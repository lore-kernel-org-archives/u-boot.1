Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7094510F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:09:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02B6083CE3;
	Thu,  2 Apr 2026 00:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yv9W8Lvb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00ABF8408D; Thu,  2 Apr 2026 00:09:45 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 010CB80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so36793766b.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775081382; cv=none;
 d=google.com; s=arc-20240605;
 b=jBOgDh7eUzRsJTi3l5TsMluYHPh7qmnJx5CXUxkJQHlIEEBs82utNr32YrtLw6EdsW
 iCYu+ZTVHb4jyBHtPvMC0b63YiAXujU8ZxcD64Q+bUIZS8ZMESVr8Q3s3Ia+UxdqyMob
 VNMZ4lKKO9levnpgPipQOD6M3dlisTYt/PhdmrAia80jif5A6QaWDhm2o2kZk2uBenX9
 BGEivj19P6cKHJRR4QuXuji29Q+w/wSanHuGuu9PNWOPnXNMC/Ot6DsjGanpYmK5G3nO
 GBP5pigM/0NgnjiMHke/CdHwax3cRgm1Lxvw6NjffSOBqXwhB14RLAqSRGsjrq4m+8Mm
 /Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sEnyVlisOArVcxQRDH0TncvPYP7Z+CV+XaTRHWXMvDc=;
 fh=C4vNWsekhYXEGt7XuLrL80wsS+2EksyJTFSgd/FaRmw=;
 b=MZUmo6efTBktvcySnBUwxLuUJFvu/DnHbg+8SdDxmBdToZjZ8bSvqdB5mYFT9kBbBq
 IxlPlVqjx71zOhyjShZvx2S0Gb05NuGdpsMxaPrQl1gCFa5U8q8Ga1AVabWrxmNbE05b
 kOmdfn5mOg2/5/VbwKsgxoSdfXUuKGipdtvD4CVxkob5l6t+iYUwOLzvgnsyEkWdFXE2
 MInk93lihm6YQlZdBLiczQDZgCO0SeMQZ4S6Satl7jirZVLWlJlGNR5oaiaaYRT8ggXx
 MokBNGCkJL4uvr/lVOJHDVQ/EKU6xQxXya0jBx5Ag+8jWt3KHqSbwUssb3S5KkSPKY+4
 ZBAw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775081382; x=1775686182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sEnyVlisOArVcxQRDH0TncvPYP7Z+CV+XaTRHWXMvDc=;
 b=Yv9W8LvbQgPXc6TVi3fUsUHXtvPw+5wQRkHFSF6OonGDJ+7QPgmY0CRbna10/juCto
 GlGSYfsb4quDI2Au8BOzA4ravQt1oaZ80W1QCSbv83/Gd7pN0AvMIx5pKb8kBu5sb8hq
 nfFFSP4QBfG2NM3tIcasVRfAiCAtnMs1f4jro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775081382; x=1775686182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEnyVlisOArVcxQRDH0TncvPYP7Z+CV+XaTRHWXMvDc=;
 b=GZPr5fbunqgsJV8s67HDE5DjPaPQviqs1AQmW1JOSDMW6OVG0juob+6W1tY6tqrf20
 bXli9CWRbh+e4RppeQM271SX09J0qHSxO2ASgtpqLcPmHY7+blIWhr9RcQcfT+VYzkHW
 N4C19nXPuzHh8cs2RCMnTlNa6FptmdR/bg03vddO/dxuOfgdlviWN3opKf2kVCHumMki
 Oo8cE/9ozM3USzF6a9Wg37k+FnmpMVs/TrvmmN22HUKw+1Ugli1Bls/GBmZrKiZWCAIw
 xKhomgbw5KTSbIqDxhPAx/Spk+jyfCi0DQ4WtmvXHIp7xhHhWA+q73Y0E725FmdMppIy
 7l/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4sotDcNFu8jlAIaMUFVdrDcENQLbMh2VR05zbY5NDW4N2saqAuq/uxImutyz4vsYDT6inyxg=@lists.denx.de
X-Gm-Message-State: AOJu0YyKWR2UsoaQXcC6l2VSsnGB2wbFlXhzeTNyXUpzkqSrc0HaM4go
 Nsk/9q0dRq1IaP/nOTi+0q3Sb9q4jPMc43NdRdEYkymdFSyrXioi9zeNI6AwB8NceXn8ZSQzOaY
 XRVc1kqvxFTj9Tt1mEjeEZhZLUaYv0e16xZbAwriY
X-Gm-Gg: ATEYQzwd0O9zdF4Dv2+VaDF9AQPqRYl2e5MjpBqOsrp+2bqZZT3LshTjRLtdhdA+lWh
 B0c2g3xCsXF9AqM5WK93vZYXBIIDoRXNrnlJfD6su30hG5pVqu8yAIVbdk6LV7zvazG6H/iuhd5
 Wgq8FvbzLrBvbV3BB24nFyp934hGPnBeJJi/tcV5Dom3wp9/9+qigfhbPE96cwykcbwlhQ9qQHk
 C8fh5iMo4YCGJ/7t65HV7Lx5weZiDNf6lMmPYIMezyf5r4WOifYMUl9kaUr8/JdI7L5rBnte/SD
 jPuWrg==
X-Received: by 2002:a17:907:a686:b0:b98:3b5d:e12b with SMTP id
 a640c23a62f3a-b9c13928664mr396963766b.22.1775081382352; Wed, 01 Apr 2026
 15:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-7-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-7-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:09:24 -0400
X-Gm-Features: AQROBzAOsMxSOCyMmmsqgrFABl3SZAB33br5JBKKALsaCGdzn9NRPdV-o050-CA
Message-ID: <CAFLszTizhB+XFVUogJTZygZEVFnqn8EzHiBFCtPF1DxrH04Bow@mail.gmail.com>
Subject: Re: [v3,06/15] test: dm: ecdsa.c: clean this test as software ecdsa
 is now implemented
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -9,29 +9,15 @@ static int dm_test_ecdsa_verify(struct unit_test_state *uts)
> -     ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));

With the software ECDSA driver now available, this test would no
longer return -ENODEV. Rather than just removing this assertion, could
the test call ecdsa_verify() with valid test data and check for
success? A DM test that exercises the full ecdsa_verify() path would
be useful to ensure the driver binding works correctly.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
