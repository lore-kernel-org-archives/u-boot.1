Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E4DC61DE2
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 07:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 312E160613;
	Sun, 30 Aug 2026 07:56:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KfW2F1rDrqnu; Sun, 30 Aug 2026 07:56:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788076580;
	bh=vFTrVwKfGsGrqDohtDPVZWbPtqska3zB3cJ/PL/kyJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rlno9QdZFCJGNuXv21Hh1pWxU8b6m9xtiDFRURH6M1kKHk0e0iiOtYPzKLo+hVThw
	 l/ublwN/s7Oq0OZDpw4aQTd1hqNUxVqE+EeWqc87M26xTQD0C6GUcEGtn9esrH2eRx
	 XiQcZTmVQqr9jMqdsxpWYVIrSwmSt+PRQLTLd4mjYcXqgIlRblC9qEDiRGWKXVXj9J
	 iz7IdvnPeWef3tAajVxwTucdQCi2LUNBLJxdz4koQO2rJ3dVGE2/fOH3ikVPizU7vi
	 lRFl4sHcvwK3I7RlAD4YvDVtvzwyatZtKx77feqAS/WNlCrw/UCvY2lIm0ogaOGtn8
	 FFpd00lPTufhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 185E660611;
	Sun, 30 Aug 2026 07:56:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3F37230
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1CF2400BB
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:56:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a4izZRLu3tLB for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 07:56:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=PnN7DrsN
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EB5C40050
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:56:15 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 759F23F0B5
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 07:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788076572;
 bh=vFTrVwKfGsGrqDohtDPVZWbPtqska3zB3cJ/PL/kyJA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=PnN7DrsNKbTSYQN9Gok0t/2r2FxFVF69ZmEQFT2gAGc401kPqhlzbkNrM1wtClaHz
 mKMaTISwi4ax3a8qViYvxQiJi27r07lBMGgOQqt7lh2rfV4PHw7/BBo9MQZ2kaQ3h3
 RcLk1aWZYRUqhmpRFpEAJPKHuD/W3+FNW2joKe+azSdx82AiPu7kFuhJES5aaWPbH4
 1v9Prw8mXRe5PodBk1QrSMQnjmEXhApa7/RMYOoF8JSfbhNM50+rfYYM66nizTiRMj
 k7OZNE/zDsAekwdvuCf0G9hOQkrLq4XQE7QUxpG3GqrGtD7OnWqhZobH6krt+NgaCE
 jM3xnab1n793LDhR5OVqB60vbRV3PO+pquhPqonQlqXqfv2GzqBGS0tLBoHXatm+Tu
 M6S/X4FDY3TCCpxvZYmGfhGEFbA3/esoj6bGkSNtcbOMjXvl/RwhVvcsnvCbWbz6lP
 dTp7p4XQUh25OB+42FGXn3xC99AtLr/3Bx09cWcpG/SfbrFZEOkukxGLcolnGQrMgD
 K5tchE3YkaNFyBcZuaeZBvQKerQ5LZBlwuxU+5fm/gKkcEULHsPDVEnYDZ56+kNyLH
 D/7YH6C7/Rc950lA22ETMh/pIboDbolhX/lOTjbxvjQ5sja8TkONrLRndCuKsemz/l
 c1+JruY8hnV2xXvdtKbom25E=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49b64e98e94so18520685e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 00:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788076572; x=1788681372;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vFTrVwKfGsGrqDohtDPVZWbPtqska3zB3cJ/PL/kyJA=;
 b=mmgbkVN7LT+y6P2cCB2ro3ytIi3C2BokxPgp9W+6aN1y9A92AflYr58wXT+Wr0omod
 kp5WNajyRcCE8ZGaUtodG7A/PRUFwJzV487g8G3L1zRRdlCD3xpQ1D2JlB3ywf9WSpU4
 mlcJOSLDvB2Ps5XrpkuNnVfnPcnqeBACOQOIsGYGRLbEV040Vl37Y6FYydQJMc/zCOaC
 ED5bcZ28SZGhh42EBuJUdssYROMPR+MscQI9pFuRfGSSHJtv0p4/MJVIK1wZmVlZhuAe
 Wb4U91Wjnk2tjK1iHzB3C/umvBJtmYDAMbyx69E9fgOuzKR8NjjACu04MM1h9An2s3dP
 8rag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNDCkRplywfpwyiR04jXnLV77pfUO0l3pg548R9TCybsuvmo25x7uPWZQ4a3L1PKcyrqu1Pmc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nCZzY22Lo4wiNLIvhA5Q3hVTqv8GxT88BDPl9d/3/SaKq8vblj
 f2MwgGufP5wStSqBjhtmzF22mT75PznhzLK9l2RjNdR7esD0T3yYazFcGD+vh0UQBrn37ehpOAa
 B3jO/z99rGI4IQne6GKbI/SOv9XaXJyCArK7vmBgr/28j0GsLDfLhwOIKq9wdyYuWrdpGbFjc4C
 fbfmIJ4GSo1g==
X-Gm-Gg: AYBFou2EZlusrzSiYwrMZiuUNhnMgXvichaqzkvYBlCPmGYa2YYZ0fwPweEcPjFg+YN
 uMuAcGwk9MU8EHcWrhny/3Mo7O0Y739mYoH0C0Gl2Hvg/vovTHvKA4xKuBQZ64zrn6Ui1fkMcFq
 IpSvNMLzUMAVm+5bjcGAHIPxULtVOnSj7gEp95OcyHBn345fg5QJKV0YAcyDu3iiMZgq6StIIwM
 YAhO4wZnx3G75hDPFbx9ue9YH922+cF/XkJC1LH8hQSqVkyRvbFguwFZF0RROPCSxgCSnEbiClN
 phxS1z/kKSQ4hC0l2n7af5xTc9X351oZBBVFIGp8ehtWKCoGTwX1HuBoU/HCBPmjBiEK2/e04RW
 zL3PU/5Ic2SiPSvFcJv+TrTLQuesc6QgKF95bqLzWPsJ3bB3oUQZI6k9Q+VtzIId+TmC7bRpVjl
 GdBFTNMXuGGHaZ5hilVI965qeC
X-Received: by 2002:a05:6000:985:b0:482:f270:6a59 with SMTP id
 ffacd0b85a97d-4843978e7b1mr1901506f8f.1.1788076572061; 
 Sun, 30 Aug 2026 00:56:12 -0700 (PDT)
X-Received: by 2002:a05:6000:985:b0:482:f270:6a59 with SMTP id
 ffacd0b85a97d-4843978e7b1mr1901460f8f.1.1788076571623; 
 Sun, 30 Aug 2026 00:56:11 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:fa53:7c33:b56a:c4b7?
 ([2a02:908:1242:30e0:fa53:7c33:b56a:c4b7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4843310ab29sm7270220f8f.0.2026.08.30.00.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2026 00:56:10 -0700 (PDT)
Message-ID: <5f10d84e-d62b-475d-80d6-1d08bbedd296@canonical.com>
Date: Sun, 30 Aug 2026 09:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_loader: in platform_get_rng_device() use
 EFI_PRINT()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
 <20260820130746.164424-2-heinrich.schuchardt@canonical.com>
 <CAC_iWj+HxQ4HK5_X1qKJT3NNqJbcPq6sQD=PLM8hkT-5k6vdbg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+HxQ4HK5_X1qKJT3NNqJbcPq6sQD=PLM8hkT-5k6vdbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/26/26 13:16, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> 
> On Thu, 20 Aug 2026 at 16:08, Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     Use EFI_PRINT() instead of debug() to correctly indent the message.
> 
>     Signed-off-by: Heinrich Schuchardt
>     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>       lib/efi_loader/efi_rng.c | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
>     index 7810b4e47ea..9c5a60ea963 100644
>     --- a/lib/efi_loader/efi_rng.c
>     +++ b/lib/efi_loader/efi_rng.c
>     @@ -31,7 +31,7 @@ __weak efi_status_t platform_get_rng_device(struct
>     udevice **dev)
> 
>              ret = uclass_get_device(UCLASS_RNG, 0, &devp);
>              if (ret) {
>     -               debug("Unable to get rng device\n");
>     +               EFI_PRINT("Unable to get rng device\n");
> 
> 
> All the users of that function print a similar message on failure. IMHO 
> just remove the print completely

In response to patch 2/2 you suggested to eliminate all caller messages 
instead. But I missed efi_rng_register().

I will respin the series accordingly.

Best regards

Heinrich

> 
> Cheers
> /Ilias
> 
>                      return EFI_DEVICE_ERROR;
>              }
> 
>     -- 
>     2.53.0
> 

