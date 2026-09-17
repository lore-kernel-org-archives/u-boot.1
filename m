Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56372C982D1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:02:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B30B406C4;
	Thu, 17 Sep 2026 13:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRZ9-bKF9KYF; Thu, 17 Sep 2026 13:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ACDB740640
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789650152;
	b=BQYjmI6fue9NrClqfHNNo7P0AZPmWvMROjazVXeKobtZU/hkiQzYJ5kxdgDG1Ub2bcSy
	 z+hZcOk92Lx/knIIMluvqJRjG/Eld7k+8rVyQ8irztDnQjNQ0XMKhFNerQ4Tgg19/WvhL
	 rAV732H77IIzCqx4KDeIEo/sQGUkz2SXMVK/1C0p8XbzcRzp9lR+Gt1K7+DmWcUZLu9E4
	 JRoFX6CE3frTEJcPqEdsmJdb3PhzrpqlM9rjtun5bZs631Ga/r1EBimSREKJi0Qp5Na1c
	 SL3AQqaXLfuH3obLcyjh41ONNIqzrYjzIyfCXzWEkSN1t/JMnKNOu889AcENfcQSpHw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789650152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jJ4CrJ6IpxxXApqyg0zPRJt8KWRBhrdbClSc9DVjrZk=;
	b=W5xwUBgzEDn3J7vZPIawKAKDkU324EzMgyIDg0DorQXkumiq53dewAWijxRkboz9dVai
	 3PRkXENkju17b3BmLQtp8aW3+wy6a7WEqPMIoZw4f1d9BmPjaDrN9svD7NBEUkmKF7k6D
	 dkghfL+VguQkkcOlsraIxJostKP5q6WhcFDQKvFdSghJ5kdTJTg1kJMQmJEn//RHKCG6K
	 kmcqINLWG+MOMO9ae5+Vb1F/9MTo5btVrUvzZGMFU0QmvJfDMKIuSlIHoYFgucweGrugb
	 xJ+cJ86dC8Ixx1gud3Ln31kKjAyoO6Amrbvm0OKaDb/TTqzjDQWgyhnoKs1wJyeV9Eg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789650152;
	bh=jJ4CrJ6IpxxXApqyg0zPRJt8KWRBhrdbClSc9DVjrZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qgWMOIkhZNTu3fdp1SN9O+iEAYxV8RkZ/iZZN68/zz0jPOSn8/l3B7GKIt09KcNTB
	 rPUj3Wg1386P4MC6nDLWzzg2kpG5QkXc0XM95qE791LoHA6qfi0K3tMfpfNUv6ktIG
	 5eS/mvxjGcReWdkuf9jD1nSvz4mj6oB0HaBBeZS39piUHCX2X4XrYfEJLyI0m4NBc5
	 gy1J2tPh4V+ddi/XR2y8opO9klzssGuFlMCYH7k4Oe4ysPtRQ0Euj0rj6xwpKnAjW6
	 lyWvkWG36xszeqk7ddG2H4y66bBPAspIExyXcFps/7ajuhPFLIPUGXTa8cIO5sJolJ
	 xU2r10XumSpEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACDB740640;
	Thu, 17 Sep 2026 13:02:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 813623AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 736EB40355
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ImbLpt32un66 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 13:02:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2F7F940346
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789650150;
 b=jETBSCfxQl8iuMnR3oCEnmahxT+zTVsJRStzR9EF2AsLt/RggDEiX33vPdHpPlQeqj8s
 tAbfZwQh7OBeruU9fF+WVsM2tglk4OZmqq8Cwbz81ZEKxf5uRCknqQ6nGX9xOEFS3JskO
 +wpZI1zmFJF8QLIfnMWsIhNoq4br1/SFUUeXuXp3HC1pBa3gVSuDe1lcJ1P+WwmSKhxPj
 vzjBVVK7zlG49v60fxb8shdb6HlfYH5l4FdC/HLdysYVIY+9zvaQIoDLXmWi+RVW7GvfZ
 vlmpvda0QTCUkZSxp4Eh1oD01y10peyGSBKRwp+7+wDPgMgCQWWz/N1PgeSKEEoT/Zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789650150;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=jJ4CrJ6IpxxXApqyg0zPRJt8KWRBhrdbClSc9DVjrZk=;
 b=ZlIQfOuDA+kbDTB5fgXs5elt/xHyIH6IttxhrTrUg5H8sw10I6yEtD0BdVvgs1e67Q7H
 meTN67t3fTfVYRwHTTaD2VfiwhbU7wTHpJh2o1toCrHaib3VQ3+WWG8tSKNTomUNsJwL5
 rBGs0w0CNrg9XO2ZFE6SLRhnWr0v5gc+UYZBl/5qniltKbksLBnlir/N1J3r9wVBdU/NJ
 dc5vQYnk7FXOs8f86R2ozqizgJuGzGxA5e8x5nl0SfxfqiraSDmYXZ7su3OjnxBWFPpvX
 GcLPg97wPwuolH+bwmB2GLvR3y75tNT8v7f1oitHtrcHMlV5r4HBpiEwWzi30FhyvAQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=b6o3ylVQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=b6o3ylVQ
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F7F940346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:02:29 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab222dfso738569d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 06:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789650148; cv=none;
 d=google.com; s=arc-20260327;
 b=G8wd0UlDh0wSnfMxRKbwLPBCfNPHwyInpvjYQLkfCWS9nQz49HF1kYhnGmQ2MinPpx
 rYqkuMYO+xUs3mJA+s/Zaq1JWbiJH8xCMzMtxvs+Dr8ZNmXPFU2X7ih8S8VdNTaC+WzY
 sb1czxpt0WtQMm6+KidmRrmkoBpSBUjNdyYkuoQWzYiQh+pPfFbmnLkZju+zxU/9MZ6n
 fz6sb7loctMetVbjurOsy9dIVpVc5jlJ4JxZhDKEJSexSeQIHZN9IbPkBdXbY+1KBuyF
 o29rVFUQfjQ1I6Q+a3eq1Gy+MhTXF41czsaABxt9BYFZAGpycqgwLBulGDslyJdliQwE
 hrJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jJ4CrJ6IpxxXApqyg0zPRJt8KWRBhrdbClSc9DVjrZk=;
 fh=kVreg/XVzhFSRHtsGe8mfClA5FRXEs+uGvHSpRpcpMA=;
 b=Sj1ujEh1GlLksOMiJ4EADgFKMKYa/ncBByD3uXQkHFtkDpskmxQXn7xOMFrtK/fst4
 OlJItn9R/8Jp50LIfE39ts0RjvMwCWCSXjkVbrf89et8MCr2Z+iMeCpfwmtlnnJNCYsi
 kEGxYaK90Q+8SDZ/zWxvJ9aaI31Xvj+OmjpRs/SR3XiCMX4pZnOOppVOR+4XWUnl7OKn
 oBAXmtEFr4WIGCuxA+0oOx//xZcgDE/qLY7T3kdXIi3+FSfUDlwzcnebTjR4z2sjDo/p
 0D3JPzreFcB4fxDJKnPGGrsO5ZtvMmNWs6pWom8cKWklm0aCIp5VCgHRp9+a8bCNLbgE
 Hlqw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789650148; x=1790254948;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jJ4CrJ6IpxxXApqyg0zPRJt8KWRBhrdbClSc9DVjrZk=;
 b=b6o3ylVQeZ5cMwHQbjtTmGl/J+qG6M3sy6vRerSw25bBp4KoF7iLNIKHgoWVlQ6uaC
 7+ZcRo6MQMHDroTDXrvfRpEoDhTo/Q4XMJlLFecx90uyuMNja/++WZV9PUvEOwzeQIxk
 hTdcqER30Cm+is7MvK13cflB6dO120AQ3PeoXnEm+CnM810j6s9tMZXnBUhwcT7E+CGj
 ScwQcQQ+Bd4sBA7TjWNd6fyPaHsd8hJ2AtrO9NQlWmD5UbGvnHLfD6uyzMVKtD9qyGMf
 kjZb/kTsAoPmdLpiqnbBnEjrLalLp1SO5tww+sJg5Dgu4lN4wo1pFWdTK0EBDA5aUnWg
 2Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789650148; x=1790254948;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jJ4CrJ6IpxxXApqyg0zPRJt8KWRBhrdbClSc9DVjrZk=;
 b=ztJ6vSYcMVmQUlGRoL8vLKqWWBAoFRaO2j0hSSACcevOqt1D4jS4wc1s0srTEum2J1
 wDL1rvqA03vPG4kPHOos0KAw4dU/L1VM99Tepds8xBo5YEbEbrLAufcskUvBbsktpkXP
 IkR4GbXnU1CxcJ6Ht2j+4ru5Lu3jdZkMVpCF4PZRMOXeloxJii+DX/Cpa0/bpWpweDJP
 SARaVq+c8FAthseYayDe2kG9krKSpCJP9vQq3q/DQuLXrZn2Po6Zv5gCld11TrPygqHT
 8iwfRUbuub/U+cNdbumxrassT9qyxtc27lUHQa9WachkGtzu+Le5/+3xe8V+IKQqRR13
 vtWQ==
X-Gm-Message-State: AFuF++nHf6f/Kqy/BCXrtNWMQkgmezSf1S1xC/L7gxRdljQD7805j6Se
 Pd5q9Ip9anpuzzfa8IkdGvEOFitYsdRJGBTaz31WI61htMW7czBRTjTFdnPEBs957x/WLWZweAe
 gA9dKfLpvrGrkIBwcJfJNnyt/K7NEE76AWokJyo7JvA==
X-Gm-Gg: AYBFou2JGE8sFCUz/t335W3MwPsrArekunXwAdwvUEO6d3tqRO1rVh9/qcmiYg1CJNZ
 4woyjCpTxjWanK/n4tjBzDXkVCBSCZe16ipP9BiSoSyZ0vdISPdTK6C72TJhQzgZMyENtfSXaD9
 HBZUY/uPwy+c+RnAj2CmhMf/U3iDO7ePZFiBy81/fXVyREDwiMdRj3zaLV13XLvGi66WoPZG5dF
 2+KO1fGiF1nqhP5VA6tcT9ue7fcpT1qosHWM43WPgsKYnhKIztj7B5dGa95/aEpwUhTKMfohp8z
 aJXRqcAedMlf+3hJDzE8rBXAlA+y0fs48Fa67DjN1hCgjkyk6N+EW5WghgSI/2vghooMSU93iLt
 MEfa/TiSSVUs8jsJ6FkLHKD025B/tG67PkIM7ql9vsn8htMuPmO+Cd/GiwvvxeOGN3KCwuCuGEQ
 r05Hj/yAF1RdnAel4sQ48im7s05Z+LyxGp11t23sACXBx2AtvoTkApINe//5VdRZkPvHhc13Q+h
 Lqe9BK75o5aYt3ioVIMQVmUcMEkphZo2EwqNyJqnlza6iDcuwDeCbp4d47XYEzZ+vBmnJDXkXGE
 qKezgL8hcELCg7m1s++O4tpV+yw8CjwmH9lpcMETJxPyvQIGuJ2TTLbDo7wXgUADpbweTqY2GXQ
 req5bwTZHbfTTBV+yT1iYxFKTG2wy9j5NU8DHBgCLIfPCKsPPIaL9
X-Received: by 2002:a05:690e:11c3:b0:671:4aff:c1a0 with SMTP id
 956f58d0204a3-671632b05a7mr2362870d50.68.1789650148139; Thu, 17 Sep 2026
 06:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <1a6e9dffe86b43d3c62ba185859d30a376fb61cf.1789023381.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 15:01:51 +0200
X-Gm-Features: AcwNN1UEhqqvNhBiVXh5zBaJumq8yZ-XhI_NRpjvxh5x4JZO-CW26onfQhi1RsI
Message-ID: <CAC_iWjJ7b=Dh+8k49Mq7W5=-b1dZV=L7Z_E6epeOCoej65unyA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] tee: optee: Add support for enumerating services
 that only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Jan

I pinged Jens for some help with the OP-TEE path.

[...]

> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -191,3 +191,23 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>  {
>         release_mmc(dev_get_priv(dev));
>  }
> +
> +void optee_rpmb_available(void)
> +{
> +       struct udevice *dev;
> +       struct uclass *uc;
> +       u32 tee_sess;
> +
> +       uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> +               if (strcmp(dev->driver->name, "optee") != 0 ||
> +                   !device_active(dev))
> +                       continue;
> +
> +               if (optee_open_enum_session(dev, &tee_sess) != 0)
> +                       continue;
> +
> +               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);

so both optee_probe() and this function will now call
optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);.
In OP-TEE that ends up holding a mutex in tee_rpmb_reinit(), but I
don't know OP-TEE that well to figure out if this can deadlock.

Jens?

Cheers
/Ilias
> +
> +               tee_close_session(dev, tee_sess);
> +       }
> +}
> diff --git a/include/tee/optee.h b/include/tee/optee.h
> index d1194493780..755533b2c0b 100644
> --- a/include/tee/optee.h
> +++ b/include/tee/optee.h
> @@ -74,4 +74,10 @@ static inline bool is_optee_smc_api(void)
>  }
>  #endif
>
> +#if defined(CONFIG_OPTEE) && defined(CONFIG_SUPPORT_EMMC_RPMB)
> +void optee_rpmb_available(void);
> +#else
> +static inline void optee_rpmb_available(void) {}
> +#endif
> +
>  #endif /* _OPTEE_H */
> --
> 2.47.3
>
