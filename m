Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227ECC5DF7D
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 16:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A75C680F42;
	Fri, 21 Aug 2026 16:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRdfWNSL8gHF; Fri, 21 Aug 2026 16:13:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787328835;
	bh=AZejjeNfyKI7ugvYc1EFi7jlgg8Rh7yqDVIepJgrKlA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VdSlwM0bolEGAR7LTCSAJVUVdI/PZTSCmtejEKTElCJvsxBV/K7spcT4Mj6Pa/0Q5
	 BVMzGNSt4gTjEB62Wqg98VJ9evIJpm6Wyz0nb3y0xKw8uyKXmKD5xGIxpETerjcNgN
	 Bd/ebap0OphRJbvbKc0EW8F7erq/x/ZDi0YxVmpyIgtVdvto1UTZ2FTeklyRagK3SI
	 la5tdEK2Lo61vLK9Qreb7fH+W1XDP4ZCvzelR5SOS2cSREMBf9jwYD+fo7ZoxkwA+h
	 hQ5GZoqCFxXzke825xK9watLIebvBsBkau3DI4628Kzw+4FJyPzenWzYs22KFCMEpQ
	 wB3mlxGUjkF4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B634B80F46;
	Fri, 21 Aug 2026 16:13:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A641629B
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8959E80F46
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHFla_9o2TmP for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 16:13:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Bh7YLRdz
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B196E80F42
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 16:13:49 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c2020421077so209575266b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787328828; x=1787933628;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AZejjeNfyKI7ugvYc1EFi7jlgg8Rh7yqDVIepJgrKlA=;
 b=Bh7YLRdzRQbBdbudsUt+XxClZDRMNjd6P844VIQEsxBQ8jhiHrgbMky/CweecInKJY
 DzX1PjfrS6Jx5o4m3vsuRxvfXyPbX8RL/i1/+Fbt9A5/07fQo0r6boiy56Ko5nhJPTqi
 Iz5ULgplspxKExPJ8LhtG4018v+jdZT9O/aYMbtT9hY9YM3krYRcq4f7HUWeO3IkUJjR
 m/yEnUJ11tWjCAejLFNzUUPhl8NRIxOykPE2CW5vV1kbBuwnDygWlXWsSexE1fvKQeZZ
 lbwZXaOpitcfK2HzjoV/EMTv4eSiy4hEfVJXSKbW9XteZ886mTP4wTa3qnmMdfHHTePD
 HBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787328828; x=1787933628;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AZejjeNfyKI7ugvYc1EFi7jlgg8Rh7yqDVIepJgrKlA=;
 b=ThL8jYx3J2lRj3uu6KU1AV2sKs5NlHWbty7RQjV/MZF7L/JaRdwSi6BE2xjyQDdND9
 rsbIBtVE+Qsmnlk520KMnWfLfrleyZ7fZHE2vzb7N6cPRsdjjegxp4t/aB345NISzuFe
 25kERhH17pumzN0yi4vH2Ym/UOIaYzWstjKwBesuGYa4kKgS5PIlageD/jHFF8GWotYh
 ptVVR8xsW3i+FlhyGnvpXbXTjGlyLFQQdUvS4N+T5SZG/7b3kAvLH7O9Hz6GWSbPM3MG
 w2qCHOW/XTEGJGdeFbs0X/DzaLEl++1ZKpn0BiSPyCJ8OPkCPOxN6JSe/qIqHQNzkgEM
 gYDw==
X-Gm-Message-State: AFuF++l9Iitkoh1JAq7KgzoD0XME8CMVAlQaUj1nkmSf+wseA7TxsdAm
 GgfEzymGdEX0aLHcdwKmnAEjUSDmOB6KeXziRW0dwRQ0tb3kgg3+IIuByw8BGdCLX+I=
X-Gm-Gg: AR+sD10srXlSlEK98MVVxovHT06rBs2P/t3+3A8SK0KDUZpH4g1lTWL+4TJWkqMVIiy
 e+bdooC50gZAQS5G/kB8D4A2+KB+VQcYFLyCBN6dT1VK3hEqHrzFXJuqIu257/3nobXO8XrsC6+
 6hGzuOV/Y7Tpe9Ru21rXZM84T8Aiaug9gaDiKYBC4v7S5FkS2wDKfpa/fT2vNSY31Rpke5m4/RZ
 NgdvC2zJGRRP3NwrXLKp1yjhdSETHpw0gLOhJJWwYSpcZA5P/vThqqoP2bXnoEQ+4PkHzYjGZn8
 45u+sPnOLk7Xzry8gnFlmtLHlYscWkY8liAIfeyBlHcMLa1jVaZzP6sbsOTl+uIxRY9o6nbSsP4
 iRDGUHMKBo2LCKzqH2TH/brRj7V1GwRUt1vbHPWyPBsijVFRfTYdjn6vsmLQTz/KMdFpllqQyVS
 ul4ZIcJjqpDIT1ro8G8ALdYmmLWUVPEmI1BHXj/mDFj9wIgcg2sdmMHfq2gtlU3qh42PNTOODFB
 bvqnVPtt5GwPgguXkD1qECgPOc0Jczj/V2aiqHURkEpALEutEYgpzW/
X-Received: by 2002:a17:907:d64a:b0:c1c:4e36:eec6 with SMTP id
 a640c23a62f3a-c246a728577mr788009266b.18.1787328827766; 
 Fri, 21 Aug 2026 09:13:47 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459198d59sm486643466b.35.2026.08.21.09.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 09:13:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 18:13:46 +0200
Message-Id: <DKUR6VFB7640.GKQ4T2IA60U@baylibre.com>
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
Cc: <u-boot@lists.u-boot-project.org>, "Jonas Karlman" <jonas@kwiboo.se>, "E
 Shattow" <e@freeshell.de>
To: "Stefan Monnier" <monnier@iro.umontreal.ca>, "Carlo Caione"
 <ccaione@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d__17726.0234997206$1787249364$gmane$org@baylibre.com>
 <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <DKUFJ6TTK7AW.2VKPRV8CRQ70V@baylibre.com>
 <jwva4qf7kuq.fsf-monnier+Inbox@gnu.org>
In-Reply-To: <jwva4qf7kuq.fsf-monnier+Inbox@gnu.org>
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

On Fri Aug 21, 2026 at 2:21 PM CEST, Stefan Monnier wrote:
> Carlo Caione [2026-08-21 09:05:37] wrote:
>> It is possible to include U-Boot proper in the host-loaded bootstrap
>> and use its existing fastboot implementation. That is a valid approach
>> and is preferable where the Boot ROM download limit and memory budget
>> allow it.
>
> Right, that's the situation I'm familiar with.
>
>> But it is not always possible: some platforms (like the one we are
>> enabling) impose a strict size limit on the bootstrap, or only provide
>> enough early memory for the DDR initialization code and (small)
>> SPL-sized payload.
>
> I associate "fastboot" with the Android nebula, so I find it hard to
> imagine a machine with enough resources to run Android yet with a small
> enough boot memory for U-Boot not to fit into it.  I assume the SPL is
> pre-installed in some dedicated boot memory (SPI NOR?) whereas the main
> storage is left uninitialized during production.  And the NOR flash is
> so small that it can't even accommodate a proper U-Boot?
>
> I wonder how many cents it saves the manufacturer (e.g. compared to
> having a slightly bigger NOR, or not having the NOR at all and
> pre-installing U-Boot on the main storage) =F0=9F=99=81

Hi Stefan,

Just one clarification: SPL is not pre-installed in NOR here. The
Boot ROM downloads a transient bootstrap over USB into a fixed-size
on-chip memory window. That downloaded bootstrap then contains the DDR
initialization code and SPL, while the eMMC may be completely blank.

Also fastboot is used only as the provisioning protocol; it does not
imply Android.

For more info about the SPL on this kind of platforms you can also look
at [0], there is some documentation about this in there.

> Anyway, this is clearly getting offtopic.  Thanks for the answer.

Thanks for the discussion :)

Cheers,

[0] https://lore.kernel.org/all/20260814-ccaione-upstream-mt8390-spl-v4-0-f=
4f92978a79e@baylibre.com/

--
Carlo Caione
