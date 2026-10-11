Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E185BCA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 08:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F31D6064E;
	Sun, 11 Oct 2026 08:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w9TffN9uNSTA; Sun, 11 Oct 2026 08:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8ECB460631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791707486;
	b=QO25u2JBARnsAzBYAcic2+tZHdzUdFd7w0Xl3i//WroiSDK/ZSVTkEOmf/cg+mM14R1j
	 E48MSWvdf+AMWX/ZxsOWfMqVAgcLs0PVQuHzVbB8K/IyAeD4QPZM/xBeuyqjMtNZNYC12
	 KzD7tx/fz509SpGPDAH5nDw3duzbhT2m4jNoZT2PJai/180z9s1yAf/9z1mPeKlDN3Xiz
	 WNpjt1KJ0hYA1ow8f7NbEgxAh3PZh0ktys88J2ZVMMjCmWGp+TVXF07JESeA6lA9hgVv6
	 ezG0eujwVJ0YOQiOgKzODalPJDrf49XiHD4jVq2mVjzJdMeGW+Ssw6F37QcGAd2eNNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791707486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fF2zdrPm9YLisP+p2KaUo7aj1W/od0in63MI98RiyCI=;
	b=ERzPwU7a5FCGfdSyElyJtiVj7OasNIrT0MG3cpeHnu7fuZmLfyuwVCLoi0nsEoIedNtH
	 YBvJkZaK3uBFyBD83Y4CiZ/PIoGYgHfAiM6QCIqesgLkJ2CjqxkgxHhCEKbma2oLAS3zb
	 pgNwhemlL8asDNOtdXdqAdD1K5ek8cAqyh4SJ/Fi5T/QMZ57gKIY90sIskqhU5MH4rGJJ
	 EMSVGqREMBD8Le5xWdHBjW4uEnI90x4eNsWhBkQNwqe/Uj8DG0VmJilwy4lME8lcdUuqF
	 1A+Tr5S6ph0f5ntTVKH9CIZuZCjEJjT0NUxjsx2ipxkNpZVdCLVMepqTL1q2fe6kehQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LAy5xVqd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791707486;
	bh=fF2zdrPm9YLisP+p2KaUo7aj1W/od0in63MI98RiyCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rxr/i4D6Kmrzt/OB5ogGjLOxXBENbvG5U6BYSRykH2bBSc78TRe8vlwGxKPxUf7zq
	 TMsrec8D1e5o/sN1kWLbOwnOqEeWZvolHs8c/ojAdUohjPFj4ikzydGSFPfZxhV5FU
	 FJ21hARd8Aa472XxBt2SMcNkK5yydv8bTm88z8Y/bVxvSozeRC9ARinNYENgcAxob1
	 xAt9P0pFVjJV2fxLE6RF7/KrD6drRagXmRcRhj/JEexS1z6cJbUQ23D2c0YRRhY9vm
	 9wV7JbqUhcvQgHm954GfoifWdJHQTbzH1E2U42lQaQhVaqACpRLiaILV/lW1H4R9wW
	 K1YHJPdkW0JEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ECB460631;
	Sun, 11 Oct 2026 08:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22330235
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0873860623
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCu9qLpC9Gce for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 08:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C6A6860644
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791707484;
 b=TpknKlkSNULloJlpaFxFsaeKqXx4nNduWQK/PGM/Rp9FiLi48GbCeaxYPMZQGkIqPB3Y
 9vBkZcBgF66Uc55Ug9YKRW4t8EJ4e/fV+32fuq705yv+USbS5DQGPJNn7wYYNm0tF6RXu
 XrEeDjTD+G2AW4hapKBFcpEq9bVjWneyYsaoQYBPeuhgcEs1ZnD8zLIlVcQ9wTQ4EBC1N
 BLPu5eN9Sosy2YiplspbU307QdQSKk2U8PoDliXFsNd5ThEtxR1LBtdNR51yctl41NmV4
 Gmho6Db+aQKveA3ELlXkCk1Qns04CKWxdAGfNgacRSTAcCxCmLb1Ld+tqfKLP3n8e5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791707484;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=fF2zdrPm9YLisP+p2KaUo7aj1W/od0in63MI98RiyCI=;
 b=bPqz23kXBAAeA/wLwbSUXKMUo2RnB3mjDy117OmF9aitursZQQIfan/Iyv37Th1nDVa/
 +1Ixl0BV5vOE4pQ64F5bkZpMcNeNmQ66OXPb7XbyUzne9N7ZX/7OQrbQnysiHbayzem4h
 piDfL6RG7CItSCRBDbCNWCANdlx4sEP7+/Up9UGpCrxcwUg5rjMgpzWIiCZ/3hrz/Rhfb
 mxrJ6tvBxdBrS47rVpl0QT6yOhcuWIlsgLE7CsdKOzZHB4SmT85jHnval3QCXKUzWdiSk
 fyaoGmMqAjuYMV99x/X+1Vn5Epm8y5bMFc3eTUoNIcrnLMXEc/E44wIIbKV7CMvF0Nw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LAy5xVqd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LAy5xVqd
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C6A6860644
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 08:31:23 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6afafc89b48so1411729a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 01:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791707482; cv=none;
 d=google.com; s=arc-20260327;
 b=T0SbSZxnysdQzR9Vtk3S7Uhy1KqLz5jWoFRLp5IdupfVrycAUg0OnXO9ujW9/ISmWb
 sq3lZhpkHXKdYYZwqYrsliaprhETiMh3GDsUQHdDiUm5nqajooHQCyUX39fgWQ//zNKg
 WCVyZ3RqttULkTZuTode+Ighc92Tfwyq6OuuglC96T1YEV5QQdOiHQgFBRYJlsy5BMyy
 wUoH+su4YUcFddkWSa7jRav2J57fgtIhcf7LpMVr5y+Sha0zQ6P+PJvhs7SSxziQeW1Z
 5u0phfPzYx+p03A8MkOd7r0zvIGMx+JP+rWgdBottim5L+jZeC6F3gxyLrrD1rpnI1A/
 yFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fF2zdrPm9YLisP+p2KaUo7aj1W/od0in63MI98RiyCI=;
 fh=I68HNoIeDK1Us65sFKVq2jkaRSWjwRJTU/AKMHlk5FI=;
 b=FFEltWFH2iL1iyUxJIoBCP/E71lQNKFiIzdYgpisZ+1UXJdokdE11GP2J/pLSGAifi
 b4gyLoEz3FRSRaEPvsIkeKEN1NhcUdDcgXsHDi4jrKLThg6jLRLmWJ7QNfvvSa3hO1j2
 SGkHLWILowisFi5rpDieU55nemShGJ4/h6XBxcY9gzMJn5XGJeFA94yZmCV+/orO+er4
 lOkXMvu3WYdYi22Lt2WnUrMSDLRqqG1lCquXWlKtPvSgu58TbpU445KsCGkjfDWUly8e
 pAtxN+yGXMIsNzbqcxdDJjG17bNy/n4EXiekaf1FlRBnLZR5u/77zyM9dndLTFw8ZHpD
 4onQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791707482; x=1792312282;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fF2zdrPm9YLisP+p2KaUo7aj1W/od0in63MI98RiyCI=;
 b=LAy5xVqdZmuoPolmPhwUyGt3FzD/GGAX3R6TaXnPQwd8utcuTB/U9/w/oMnJQkyQD+
 X/GcqpENwtRg7FP1I97d+lef+0gjWPmljG4E4XJGhpgKKW2u04+pGxdJQ7QvxmnsbvPC
 zw/sOS9ytbBtLMSRLdZX3IaXEaXw6aA83/eJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791707482; x=1792312282;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fF2zdrPm9YLisP+p2KaUo7aj1W/od0in63MI98RiyCI=;
 b=W6DMDGIqUd8C7tVo3By5EzjLRgXppOdiVvgWLb0UOz4lE+9FLPx0c4pUrtD+L62PBq
 W7vXaaEu/YOlKVge+WvwVGYBGcGjHOc8pAGzskbVwVgONb8TV+8S9OtdtKTc6++GxkOZ
 DTAp6rW6n78ha1avg61Ypayf6HeDgGwdL7hDm80LAtIHB1DFWo3yhEudNqmqIfhBe1WD
 +c5cT7uQ+YhCVlKk5yFa2LsITyF3UwZqiT2TDnU1/ikp68gRQXpPB/dEdak+L6cURtXU
 JDlBv6LoDJideftJE73ax+45n2D+iaV/Pmz9Dq2e6t3bFoYsbOBMcrP5Otz3ZLq+u29o
 IvPg==
X-Gm-Message-State: AFq9FYI/ayaMCJ4cUJTMXodlWg7rYX6xmCzhRgLjP5hTq/IPtvQ2d9vy
 XIk1l2yKThVjU/b69q8b9WzjMffv6I3df+SSsrzRulRQW1oxZlrRDa4wswkZG0c/61hu3pZ+xEV
 OjbRRV3izNGX/mWgaFq+S8QF1xumliDBPNXtftzpJ
X-Gm-Gg: AYBFou309MTx2F6g2QHEEuLGtYeAl5F5WG2o9smQGs1o1i1tRtL0waYoRGQquCk093F
 plCGqP+Tf7e4MksvzRTd2cUuM/EstVdRUYIypd9oyTSW0FCGDLnvKKyxb101VYBlwsVhjW7+5OY
 Hnmo9HrkXFQIAzSSLSzlijSPB839wGgbLw4CANl1+seN5v1VHTlXCwxXFqyMB7frA/BLDui+VAL
 q7S01ZxN5uRabh2r75+nZ+yRi1HCzLOmi4p8NoA2n9tS3/JYTsY9466+O0QWMAIQg8NqnBPGkZv
 mly2I1VMIQYaxY7xp6KLBmxO4Y0asnU3lkAVxlFJmku7ywdl9TXWqiU=
X-Received: by 2002:a05:6402:52d4:b0:6b1:b0f5:40e6 with SMTP id
 4fb4d7f45d1cf-6b1b0f56d04mr837697a12.36.1791707481705; Sun, 11 Oct 2026
 01:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Oct 2026 09:31:09 +0100
X-Gm-Features: AclHuK9ExGdX1iNpmT7wVyZCh_dmZSD9g2suNtm21GPIZuZPl2xoQBRSVuhYbBY
Message-ID: <CAFLszTh_gxpXajGF0JawRpZduNcRX0_dunixZYF854fN7+7NAg@mail.gmail.com>
Subject: Re: [PATCH 00/11] cmd: phonemenu: phone form factor boot menu
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Brian Sune <briansune@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>, 
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
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

Hi Petr,

On Sat, 10 Oct 2026 at 23:32, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
>
> Add a boot menu for devices with a framebuffer where the only inputs are
> the volume and power buttons. The menu is SoC independent and SoC specific
> parts hook in through weak functions. Qualcomm implementation is provided
> in the patch set.
>
> 1. Add helpers for several commands. dfu_pwr is needed because
>    the stock dfu loop only exits on Ctrl-C which a phone doesn't have.
>
> 2. The core for the menu which reuses bootmenu_loop() for navigation
>    so any board that maps its buttons to keys (BUTTON_REMAP_PHONE_KEYS)
>    works unchanged.
>
> 3. Phones often have no usable display during bring-up, or are driven
>    from a host so the same menu is also drawn with ANSI escapes.
>
> 4. Not specific to the menu: Qualcomm keeps A/B state in the GPT
>    attribute flags, not in "misc", so ab_select_slot() is wrong there.
>
> 5. Generic header info for the slot lookup which is a weak hook and
>    the block device comes from the "storage" env var.
>
> 6. The Snapdragon override of that hook kept out of the generic file.
>
> 7. Shows why the device booted (e.g. recovery, fastboot). Reads the BCB
>    from the "storage" device.
>
> 8. PMIC reister layout QPNP-PON specific for PM660 to decode the boot reason.
>
> 9. The USB ACM stdio device can be listed before it has been started
>     and puts() then dereferences NULL private data.
>
> 10. The weak default picks "mmc" from Kconfig, so on UFS boards
>     "fastboot reboot bootloader" could never write the BCB.
>
> 11. Usage documentation for the commands above.
>
> Here's the URL with image of the menu on blueline, sargo and enchilada:
> https://download.ixit.cz/u-boot.png
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Petr Hodina (11):
>       cmd: phone_util: add poweroff, dfu_pwr and USB Ethernet commands
>       cmd: phonemenu: pixel drawn boot menu rendering and navigation
>       cmd: phonemenu: mirror the menu to byte-stream consoles
>       boot: android_ab: read the A/B slot from the GPT on Snapdragon
>       cmd: phonemenu: show active A/B slot in the header
>       cmd: phonemenu: read the A/B slot on Snapdragon without "misc"
>       cmd: phonemenu: show Android boot reason in the header
>       cmd: phonemenu: show PMIC PON status in the header
>       usb: gadget: f_acm: check the acm_stdio_puts() against an unstarted device
>       cmd: phone_util: fix "Cannot set reboot flag" on fastboot reboot
>       doc: usage: add phonemenu command documentation
>
>  MAINTAINERS                 |   5 +
>  boot/android_ab.c           |  42 ++++
>  cmd/Kconfig                 |  11 +
>  cmd/Makefile                |   1 +
>  cmd/phone_util.c            | 148 ++++++++++++
>  cmd/phonemenu.c             | 550 ++++++++++++++++++++++++++++++++++++++++++++
>  cmd/phonemenu_qcom.c        | 112 +++++++++
>  doc/usage/cmd/phonemenu.rst |  92 ++++++++
>  drivers/usb/gadget/f_acm.c  |   3 +
>  include/phonemenu.h         |  17 ++
>  10 files changed, 981 insertions(+)

We have expo - rather than duplicating the video output, etc. could we use that?

https://docs.u-boot-project.org/en/latest/develop/expo.html

There is also a boot menu which uses it.

> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20261010-b4-phonemenu-series-15f574867344
>
> Best regards,
> --
> Petr Hodina <petr.hodina@protonmail.com>
>
>

Regards,
Simon
