Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62992CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E551D841C2;
	Mon,  8 Jun 2026 15:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AhSiQJzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5076E8487C; Mon,  8 Jun 2026 15:27:38 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6833C841C2
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bf55c39e16so20839185ad.0
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925254; cv=none;
 d=google.com; s=arc-20240605;
 b=Gk1GM1sdSs5adX7np+wA4Wy31raKe7ibzFJ4CMYc2167iNXckCl6jkOokmSvHMTVPH
 3fEd9LS8e1svNUAKtgl7a2hQQOcKtJDD5mIvfIUpy2PJZm80Gv2+yMzV7gtHbw2IkBsa
 fEslg9uTYdHMJqol8wrz/lED8YIBnlz2J4QGZBJBYCXZ8Ek+uokXDtsNVsl6Eqo/dnYA
 P0uzdiyU0IdRcNcWNpKt6GRbeucnKwOIA/raSdaFGn/WcVhiO/fviaYd3aDsmFAe7VpD
 /G378hxw159YfSfJHs5H0T1AieF3ukpfFrRYfU077sPcuP1cmC5SCydYzTXYI9rD/vzs
 3XFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p0JGOk5zT1MLSLpBCqM8GXN3Oh6ITVc8C9yoC40D/OU=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=FW7XkgCOejJAhKCQm2R71ESc8HNAWQWtz06AHIaECZ0V4XppEuZK6bW6elyZ3l9vun
 MmNmNFCTt/iEO8KbppB6Tz3nA9018SIQ3DIrPBAGNVskyFUKZlszB0wiOh6JEnjJyDtb
 UBTZd/mFK7+sMo0565CcP4YAdv90lwpaXJJvSmTxp5wJilndJI3nHEU/KUmEslH74DcH
 bDIKWjs/JN23qMZGA14dcot0lO2SLkARISgjNheibyoT4BfD6G/QGNpbvHihG3wxDRrx
 5wHSqmL2CXOm3anEq5Qs3OkRBVRQ0zuyANHzgPoFwxJYoBAoZHR15DcNmjYBL0GdTn5r
 Aq4A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925254; x=1781530054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p0JGOk5zT1MLSLpBCqM8GXN3Oh6ITVc8C9yoC40D/OU=;
 b=AhSiQJzrB0W6USUFT8BSDrhmhPNUdfS+CPCvaBHgyce+iuwOIu1BcP+voiUPuAGdvL
 ht2qAXmNZnmEvjsgpSjFw6lWODnG/5UF0cKJpWM7yYbatzpdqm3WSNJdXLkfl4wGRL3l
 cUG8fBD2I/yOgFZwfeRbXoApa/TNlI8bE4bVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925254; x=1781530054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0JGOk5zT1MLSLpBCqM8GXN3Oh6ITVc8C9yoC40D/OU=;
 b=mXkRsmNjyGufAGqq7U4N1CVikA1/wUJuY0eGIJw1VeHY+8FjXY8cPYlH4/950hIJX0
 y1kVeCHhKP8LPAJWKxznQs/MHY+0lsfaILHS243F5Sii+0DHje3a6PZ3olhEfk0SklQX
 gcbaDuY3YdY6TUOdGjIUYGuA3uRe65Z0u/yu0+PAi92qZ7r0CwaUTJ5c+OOOFK6A4zej
 66xN+QmHx4sfFgrBNtey/nbpzPnXmyMidISATE+LNuqn4TyVXW1HzHW1Tmj7CwLgMi5x
 d2qoT/s4QQpZ1O/qKYf1Zr2MHlaOd1n6zq1FSxWjGvLZ47m3tuGoE008DQJy6Fo0HIco
 IKDA==
X-Gm-Message-State: AOJu0Ywit4G/5SbDog2rfciWrkWEDm9VleDMgL1iqOgFmlBUxAYNEre9
 dQIfSUIqDsWnXWU/sjRXZhnUhq6YsFGv/0+bquMwSah8LSH1UvVSPQhBRPyM4QaQmDlW4zVPwuw
 QY2WR7Wa8OtLiDJjOkXGk1ypcUmDkofcj605IRr0d
X-Gm-Gg: Acq92OFytNYBHuffDCcVmiTQKk9S95ZNX2eM5bUXE5Kqmum/vkzDvJAOXO6b7COb50w
 LVPTfppBecrqfVv61q7SnLJeGbOcJqq18hlF7iUnNpj4Hs9pbPnJINlOWbuLqEFH6UyD5eNN7kr
 ijFJWkhJsQuU1T5CMWXkL1HtdiFdLJohxxKYw6pCHb15qs05DISRcLqllsyy/05qUewuL8JHXZa
 oduWKST3sWorK8+WPTTltcygKnHLMfuMrOzJVNhaQx7hwpG/367q/BZmCjQ8EOkPaiGyj2MtiNl
 CT9cAgcRCZ4DKqgQ
X-Received: by 2002:a17:902:e5ca:b0:2c0:fa52:1c47 with SMTP id
 d9443c01a7336-2c1ec906ca3mr133261755ad.25.1780925253835; Mon, 08 Jun 2026
 06:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-5-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-5-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:27:06 -0600
X-Gm-Features: AVVi8CdZEZIoJ_M9LxiWx6PWqDlKcQQqkgFDVCSRYhQ7czTVA4w2D9wJEwxHurU
Message-ID: <CAFLszTgj+h==F9rjS38JzY=E9xVV-qzUEXXQmbEt9qi094reMQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] binman: android_boot: SEANDROIDENFORCE support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
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

Hi Sam,

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: android_boot: SEANDROIDENFORCE support
>
> Some older MSM8916-era bootloaders want to see this string appended to
> the abootimg, or they log an ugly warning to the screen.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py                 | 11 +++++++++++
>  tools/binman/ftest.py                              |  6 ++++++
>  .../test/vendor/android_boot_seandroidenforce.dts  | 22 ++++++++++++++++++++++
>  3 files changed, 39 insertions(+)

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -55,6 +57,7 @@ class Entry_android_boot(Entry_section):
>          - os-version: Encoded Android OS version and patch level, defaults to 0
>          - boot-name: Android boot image board name
>          - cmdline: Android boot command line
> +        - append-seandroid-enforce: Append Samsung SEANDROIDENFORCE trailer,

Calling this 'Samsung' is misleading given the commit message
attributes it to MSM8916-era bootloaders - perhaps 'Append the
SEANDROIDENFORCE trailer expected by some MSM8916/Samsung
bootloaders'.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -174,6 +180,9 @@ class Entry_android_boot(Entry_section):
>                  self.Raise('page-size must fit the Android boot image header')
>              if 'dtb' not in self._entries:
>                  self.Raise("Missing required subnode 'dtb'")
> +            if self.append_seandroid:
> +                self.Raise("Property 'append-seandroid-enforce' requires "
> +                           "header-version 0")

Just to check, is this a hard restriction of the format, or only a
reflection of which bootloaders are known to want this trailer? If v2
images can legitimately carry it too, it would be more flexible to
allow it. If it really is invalid, please add a short note in the
commit message saying why.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5673,6 +5673,12 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +    def testAndroidBootSeAndroidEnforce(self):
> +        """Test that binman appends SEANDROIDENFORCE"""
> +        data = self._DoReadFile('vendor/android_boot_seandroidenforce.dts')
> +
> +        self.assertEqual(b'SEANDROIDENFORCE', data[-16:])

Please add a negative test for the v2 + append-seandroid-enforce
combination, to lock in the Raise(). It would also be worth asserting
the rest of the image (header, kernel page, ramdisk page) is intact,
so a regression that truncates the body but leaves the trailer in
place would still be caught.

Regards,
Simon
