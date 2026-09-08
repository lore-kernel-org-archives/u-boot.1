Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD9C79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B32F605DA;
	Tue,  8 Sep 2026 07:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jxxfl1rRnhNx; Tue,  8 Sep 2026 07:25:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AD1B7605E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788852327;
	b=iuInFe2jbdxO5SuN/M/y569pEq9dc7th9++3zD68SwHMnd2eoRifqBuPg1cQ16HRYXoa
	 OTOnRtHU9nxFL3mPrSmVT/CKq43dE05YGi8n+wozl0kMmuHmM+oQE4gesFWELz2nkAWXi
	 VvkW9H9RHkYHKGZUwSGDAJs0mzIOwGlhMGgmM5F+opBQqgBU8QmM8J8U8FnGLvpHmuu2y
	 iU4hk2rVPTUp7Klx4h85TXAH41MMjzsY8ZAuXuX2DsiixmWunmqYX7n0TmVliLNRDV2qB
	 NWHDoy35i2Th8jtIofZpVlffCLp0atO9CjrQ/mxDZuPWS+N9OLS3zj8CPpNmq617Zkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788852327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ydqZlGtqvFyhFuVfekZ4vRPymnwMV+NRQHq9BOy5vnA=;
	b=R8BuTWNrQSojnPlYBXeOGqyMknqpUARbk9o6YsjcJarCThfzSvmclQ6lMkYUHY+3pc+Y
	 Ropmnqv+WF06f6/daVMTJpvpkvTj6EUCNPF8OBiWnPA4BJjlI+7xaUVK92Qbprfg0db74
	 r/iJSepmuE2kH0w9piPk0ea7Ss0ifmai2ANMNcvy8ysG92HIaDFXR17Icy8GzFbk3OruU
	 l1UHr7px2wyTrGxDsc/UVMrHGLS2AtaA2xryYSYc2AJkMTmaBThoWFsP5Z5MQHH93Skxq
	 bM2UTUUdKYVw0yRVFfzSTbn93FlG4BXXgnr6azXXsyUNqSGn7W1KlwEdvuyLRhU2ZQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788852327;
	bh=ydqZlGtqvFyhFuVfekZ4vRPymnwMV+NRQHq9BOy5vnA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kC8yaA8oA6cU6KcB493BuivLNUJsIenCYhTMqB8WGton5uPmMV3EGzuNQTmOVd920
	 SbxmcVqkg3lNp0/xOjS6/dB8mMmQzsrpyoTbtRz0Lhfbf/NMkeVTSSXtXv5rxfEO/6
	 PreDaqV3t2y4r4TIhZVYA9XVXBflRFs9M1KIUoNyJ3j/8u1BeIv1f0sypeqWxGgl96
	 w0Lf93wdvb2v/60D/Pniry12kONiuS2uIRKRDS/NMx9UvKQaFMBxTeOXqM09webt9K
	 DTQGBYUOvgaIDf8WdqOLTU/D5xM2yhq8HE3xy6aWP0HynN7nP4Yasy90Whyry+jqyD
	 5g7sLTW6DHDOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD1B7605E9;
	Tue,  8 Sep 2026 07:25:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 297BE230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B55540150
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dcR0GnVEhv2 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:25:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04D414013D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788852325;
 b=HQ2hdFPv4BcVzuZQWZES5SRL91Z9xEMenrMuMaoT6g5qTWmc3SFC6Z+LvzIUR2I8WGm1
 sFpdavjG3j6dE/mIkV8zO0ZZAHaK9ExWWNGpvxsntF6zcPK8F2BpbG+mmWL4sGHnK9JCr
 pMQYFi97r1ZMi88IsaV/5cTHug/STzOLnoYvbey/O5pb7m7htLjNSxNN4IFZhcrMIuHDl
 UGL+UDICj+CFflwLBZYAvQH9Od75rE//tVER4xvSj5MBoQPIxvs98XeyqltVh/rvTnAvP
 h1eeDiFvCYRkqJThNQxhlL9XyFXoXWTfegULYFiQbVuhchCnTiuQh69Ti4qNvhs5D/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788852325;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
 bh=ydqZlGtqvFyhFuVfekZ4vRPymnwMV+NRQHq9BOy5vnA=;
 b=HBOMRldVKKPRARIK9JniwB4qgIjdQ8wRUahsWIffKD4igWJ9zSC8A+5Zp/pUzQl22Usd
 COtcgez/WPK0VWk+yAUh7eDsN3eKd3A/2Nj3qDRJTh3VS+AlRRooVKThpHPOoAtRKo6Rl
 Lzi/GdnFfzgdIOjtcbBmF4Dsl6FM8TTY8yY/Ao1ysTL9Flb+WMSnB9jWkyqpLCdh72VQ8
 YPkvOPtvoMgVv9ZkRC/6zkh3W1x8JvlEha8dhxJe33I/UyE4DZjpYy7fbW2WNA8bpZpyy
 M/XyfuNESE9nFBayXPG2keX+jdtt81drmE9WCqVjS+gFy5mg8t4LYbpk1HPsKiPhqjg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UEP55MVC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UEP55MVC
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04D414013D
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:25:24 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso3075742f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788852322; x=1789457122;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ydqZlGtqvFyhFuVfekZ4vRPymnwMV+NRQHq9BOy5vnA=;
 b=UEP55MVCed4MxvV0j8niByF2b4z2fyKNdEtxJP+8V0/ZQi1RIPMUUkS0hQL28hUVux
 7lGp8UF3PhrKE++iuPq3AkRythMxHOr5vPn/lrwsEHn4x9OkfgqbvJi+uxQPFSHpHuu5
 LRjUCOcC/7dqUTNxwCI7WVGV0F7Zy+8C06Z0TZhIrcwtXN9TOg9aSi+0gQZdd+HUgUjp
 vzq0s2OzzEd6TMJIk8ud9Njw1caWze7ZVNFkPGcGv53vwOEc8CCGsn1W7ZS2/6R4bgmV
 /btK8avjSaiH91fwGIDcbQK6EhlV2wzYCV/U8mbPgH7OLxZN2nDmFhkNBHOBKiEuLsQ4
 q3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852322; x=1789457122;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ydqZlGtqvFyhFuVfekZ4vRPymnwMV+NRQHq9BOy5vnA=;
 b=YPWKZZdpqB6+bhh2RvH16GhnQt/XVkzgvG3sclRylhOwPuazUf22epsGpstzFT4LM2
 H/Y0S7faMdYch1Uc6FDzM/lD2tCiTsTWWH8Zl11duKts4R4ZGsImImhhBCVW7V/uQYrd
 jPCBqcanhI0BTI+WLLnBzWb5ngETkKtttgbjJouFmOssNtRwHJTtrPQRHjUkh+l4EF+K
 Z3S2/iwqkV/+e0qGJHbgspePBmVmXH/MXR5pSjJnV1uEMBy96xESe/lsSvJx+qoGkEX3
 xDr3QYJCcK7DrYcIPyhRMS23CD6sKAUP7VBz1YYpFrrhVyO0h1WyVPT22obsUcMRRcyf
 f1Bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUg/aIOE/ytYEF34YB7fkpYrInScLZCLmwPoKyHki4XNR7AaOlVeO9ITJ15uRBg2u369oFPl0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k7MHo1LOcGuBILB+nH4Q596pjEri/fVfB34W4tzKA1inHo6snM
 kOs9/e9uPTrVArr7jlY7eF4YUlmemuGtEUtcy4u4zDmu6UV0N3v8EeJvFGdqKIDFW28oyC/SLHJ
 V5rFW4UI=
X-Gm-Gg: AYBFou2pPrpT2fsXnwqPms50foVRgrffM67xxD1lYLHvvwaj1sfZBIAjPRVWoplTzyg
 VBXd9IlNOy3Z4Ffnu53LAhXPXftHXGZxIVOWPpqbUBTQ0ublQjC/91EvtMmDbKfLuA63MzhluiO
 xZdi8TqoN9S7VybbCvCcIL6bfYUo/SdL9lWFhHJ18t78E0548wjFEIdqCJUxcr/32OHidzFP2Jh
 NnnzZKIPShun7aZEnBDIST7Onn/15HNwPYwqQPU/gppOsztTNvBXVSnkX38K4FTrVIELuHGCDwM
 GEfDLaEPmz+Nh/MGx5SW3H3ByY9iDLn7EgiGYxTjXRVRbAOjZCPIDfQk+v8iR4bGqVw5wMg4XHx
 +lpzVo6ahYmUbASZjhqx96xn+QYQ8Ndmyxm21Dc7jHTEJ7CdaTL+yCPxdKb9LgYOh/NgcjGuO9O
 w82le88lY7TJd3Fl0v9Rt3840IB05cK05CkYoC9l7asybUrlxhsY3A8mVG6u8EOaDQ/gKGb56o8
 F/XDBo1nHqkAnfnFC59fcOPUtvZXEl9ugDtuFD3a69tNqkdJJT3RNh4gXDszHcmGjAW1uL/0nQR
 7HrMv9kn87oIdm7aob3Z9rWuVEdHsrCCFjODkkVTHMm/ohTVuUcELgTT5xpSTDrWoZwBLboLp17
 YrTE6p6UGAT7V/txP6tCo4Bg4nqp1t2x9JhH1AnQzPfw9GBswaTPn0Ugj/6S6S5eP2+SH2D6D1M
 SufvZszOLccPdswWAuL3D0MrTRDpWA8OoGjeZ+fJCLi1LaaZEAwS509lRkUDBYgXV7ELJHrEMLd
 xtZ63Ik4cHsgO9x3VYNB3OBw3FvMNaUOthtL1AmzXK6Ws0VING0f4sTRqQNFRHTzL90
X-Received: by 2002:a05:6000:2602:b0:485:8c16:a34a with SMTP id
 ffacd0b85a97d-4858c16a7ffmr25082258f8f.34.1788852322615; 
 Tue, 08 Sep 2026 00:25:22 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c5bc5sm36598397f8f.24.2026.09.08.00.25.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:25:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 10:25:20 +0300
Message-Id: <DL9R83CX8TMM.196CDRKC99BU2@linaro.org>
Cc: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, "Sai Sree Kartheek
 Adivi" <s-adivi@ti.com>, "Alexander Heinisch"
 <alexander.heinisch@siemens.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v2 2/5] tee: optee: Add support for enumerating services
 that only need RPMB
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "U-Boot Mailing List"
 <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.17.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <1794934500e5580309f4a8cb064bd035cb9b23d4.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <1794934500e5580309f4a8cb064bd035cb9b23d4.1787514446.git.jan.kiszka@siemens.com>
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

[...]

On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> +
>  /**
>   * struct optee_private - OP-TEE driver private data
>   * @rpmb_mmc:		mmc device for the RPMB partition
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index bacced6af6c..f7312d7171c 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -191,3 +191,22 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>  {
>  	release_mmc(dev_get_priv(dev));
>  }
> +
> +void optee_rpmb_available(void)
> +{
> +	struct udevice *dev;
> +	struct uclass *uc;
> +	u32 tee_sess;
> +
> +	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> +		if (strcmp(dev->driver->name, "optee") !=3D 0)
> +			continue;
> +
> +		if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
> +			continue;
> +
> +		optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);

Will this work if devices are bound but not probed? IOW do we need a device=
_active() check?

> +
> +		tee_close_session(dev, tee_sess);
> +	}
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

Thanks
/Ilias
