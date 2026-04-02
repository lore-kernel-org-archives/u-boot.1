Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8FC111224A
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 00:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3D384056;
	Thu,  2 Apr 2026 02:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YpZEesdo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBE8840AA; Thu,  2 Apr 2026 02:17:30 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BBB183CE3
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 02:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b982d56dac4so49277966b.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 17:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775089048; cv=none;
 d=google.com; s=arc-20240605;
 b=Mx+klUZ1oxN5JxyjqFZQuB+i99M0z2S9bBJnkNO9jXdDdG9VYNPA+r0xbTBYm4Kl7w
 BHDuj35UxyTvZnvwj+TE3Bju3R327WGqDQ6VYVkLvER+LxDN8VIItNVUOhRrha02jGAE
 0z4KkeZCAagUXEE/i5aNpIh8QCK5shY3dCK0Iwe3Z8LRjPvVFEoNpPrEUR0CeWsYyJSW
 BErvThyfIec2awev9vAe5bIR/QABIzrlU/ZDJP6GlzUYcFEBd4sgAKAa+qLgxd/xiyZn
 PMW3CF1lJvdeiMMtHAez5iZQ9CVYqmeU/1527+dywlkYDNdO50UhEPAFSTpmfsX1paIf
 u+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eAgOldAzvs3CCn6kpeFP4MT52u2iMxoxmQB7Ag/Qha0=;
 fh=ceFLWtJ0NzjxqPJVkAATHzM9jeSTjfj3d4oM3gKwipo=;
 b=IINcdhvUxdl1VOM95DK2+r1jjRA5LQGWTfi47m87XLCg4sPLNkfliXyhwyKj1D0ysR
 xaU3dfKnU70sqynUHkn3WBvO7kRzEW/crDi2PG4BbeWpG+Nf1wErkPRsX/knxqz329QF
 jXKn6xq2o2ihcSr/T3qajMCGAxQrr4tzq0zxdPTnb7as7BqD2Hd6vwYzOrG3sUdMOd4e
 6poQ2OSIulF1GzixEU2sCCi0hRefB6wOZNylA7VAyTlZdX3D8puGyDY+JIpzv9wAv3b0
 9WvHLUYPlGbWWJ1wHB+Vpf7nO8iDA2ktgEOUENrzxHe7PV1GhfKAlE00IFB5/7F1TdLn
 JY5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775089048; x=1775693848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eAgOldAzvs3CCn6kpeFP4MT52u2iMxoxmQB7Ag/Qha0=;
 b=YpZEesdolEg9RY6zPbgeFQE3/Ju91QD5Ju7iYTWCCJ9wnaVgi4yQrbSYFP97D3jXRO
 h3/nk6MKR7sk7qxHe/ZNlRorRA7s46IV926zfY48vYFoOaHrZUWRY0sdr5buu4uanSSJ
 KuuDT31Xl1+M9nMQ4+AIZVjLVP68vJD2ZCztw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775089048; x=1775693848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAgOldAzvs3CCn6kpeFP4MT52u2iMxoxmQB7Ag/Qha0=;
 b=br8CLpbm+ZePa17eZWiylyz0MjLmnS8yfv+CTwewK/Wvj4fNZg2KWiFe052S3gbKrR
 fyfHbX6vpSyWgi/g6KoUshfoqScj14U6xFzedSiQgsWe4AYvuF2X2T1/c8eWdOiH34ZZ
 bE0Srh2wX3Xmb37DM63iq23OaLjxyGuWQabcX2BP1dvbAaVAy56C2vfaVN3WAY8jTWD3
 cPRGgsfya+7PRQRpTmCwnMjYrnYqjqUx2GzlTNfVca/T8qpXQHffJDmfHl5Teu29ud9n
 Oy1uAn9GxjblTBRCnJJaOfxwmzrQ3emSwAgmHITa8xSdjhus2WhWAP1wIrLVtW4OuI/G
 y1Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX05bea/D6PD/cEx76TB4/hZO57gH8lzcHSf9s5FzcAVYKZHXU3DlJJ0ePyPh/XrqOVKTAOpis=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7AlG7Ow4dpdyVao1OYux2eG6eaImDusTgR50AMn5sVKFkqBTi
 uQZx/zmpFA577Ue2jl47nRrIkWyCbRjVxGyJnpCmitTJer7idfF7gqLkVnkpyY60iCxFjWvzTIE
 OP2HhGSixelSbWk6DHD6Za98n6YarK3pSzPb/CxTmgloFHcDs47wk+w==
X-Gm-Gg: ATEYQzx/w/9QMJutzctaSH2tg8wU9wGGjLXnC2EGERGjILhBD8Wwh71q1ZnoutByT0R
 xperTrtOjutjiGrCId0qQFg9ECZuUyYPpthJOpbkroEswt+mBxl3py+PM7p/i3CMM1cUiMS3XZZ
 WK0clF7hiLKH8XSbCKWLsk5ui9QCRbPMOxKy4j2oB1rumYSNp5CJwcIdxv8lnIzBk9K5q2EynMc
 x4O2Zk7qvnNlSjEfyJ9f48Zt+8ZDoZuu0n82KSOyj05UtbnTbhS23hLotQNCMoN3jC1fcRqdFJY
 n3Gw/w==
X-Received: by 2002:a17:906:97c7:b0:b99:7697:76cb with SMTP id
 a640c23a62f3a-b9c13b5b746mr315192366b.35.1775089048006; Wed, 01 Apr 2026
 17:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260401153525.1541415-1-yan.wang@softathome.com>
In-Reply-To: <20260401153525.1541415-1-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 20:17:15 -0400
X-Gm-Features: AQROBzA3AKfT3p216tZJm1YDsI9_Q_FEz4jYwIZ9g66P4j-G8JSsxdbG7qt8B48
Message-ID: <CAFLszTir1k33UirLzo6pktmdZobbTD9UnkY_rVJVUgT_XpPh6w@mail.gmail.com>
Subject: Re: [1/3] tools: binman: Test signing an encrypted FIT with a preload
 header
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, 
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
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

Hi Paul,

On 2026-04-01T15:35:23, yan wang <yan.wang@softathome.com> wrote:
> tools: binman: Test signing an encrypted FIT with a preload header
> tools: binman: Test signing an encrypted FIT with a preload header
>
> This test is added to work on issue currently faced with binman.
> Binman calls multiple times mkimage and thus generates the FIT multiple
> times and the last call happens after the preload header has been
> generated. When encrypting the image with a random IV or if the timestamp
> in the FIT has changed between the 2 last calls of mkimage, the preload
> header would not sign the correct data leading to a corrupted image.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>

> diff --git a/tools/binman/test/336_pre_load_fit_encrypted.dts b/tools/binman/test/336_pre_load_fit_encrypted.dts
> new file mode 100644

Test file number 336 is already in use by 336_symbols_base.dts. Please
can you renumber this to use the next available number (351).

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5894,6 +5894,23 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testPreLoadEncryptedFit(self):
> +        """Test an encrypted FIT image with a pre-load header"""

The commit message says this test is added to "work on" an issue, but
it doesn't clearly explain that this test exposes a bug fixed by later
patches in the series. Please can you clarify in the commit message
that this test would fail without patches 2/3 and why? Something like
"Add a test to verify the preload header correctly signs an encrypted
FIT. This test exercises the case where encryption uses random IVs
that would change between mkimage calls."

Regards,
Simon
