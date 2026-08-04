Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D92C55ABF
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCF23607C6;
	Tue,  4 Aug 2026 13:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QapbENIACgcH; Tue,  4 Aug 2026 13:11:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8881D607CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849083;
	bh=tDAGKPn1X39GwgvkOQct2nAxyY4q9My1QLgGG/CkmHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tEIzXDe1OJ3nWYEtcTLsjHd4bWVSHiudcx60chvlCOBWj0B+W1xfTGMKX4XNrEchr
	 q0kX5krEl8ReLKE/TRfzjgejt0AYoCu6fLxn/wEZ1Be7DpsyBybgT1JRT9Avc5c+yO
	 AZbn7BI3eN1KIbiOX0C2J8W9jFG66dFDVTZ6dAnzUasdYJqMdWIll07iOwiSrsIwp3
	 VMRoM2uolCsS1C56K6J44IcES/L9RvWbfvBnBs+n0XRy7G6KSEYUJE9jrsXKyKIsuF
	 fEtxDjM1hr6xQygVt8uYiWp7auHBer8a8LLU3lxvjf45zHyS47rYgGk/TmHnisw8cf
	 DD/NNpWJ2joQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8881D607CA;
	Tue,  4 Aug 2026 13:11:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 38AF126C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B93D80ADC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kz0xJpKZooqP for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:04:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 291DF80ADE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 291DF80ADE
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 291DF80ADE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:04:02 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a0cb6e96dcso4469713a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848640; cv=none;
 d=google.com; s=arc-20260327;
 b=Tlwl2DWlMpCAUXnkOzSiLGj2peN4qg3cPrURgmFybrnbLOm29vG4Jt/BHJ182AFhya
 eIayqpkJ8r37ukKxVskr6DFxX1EwCK0m5Op2B1+bpnC8nlc4PI3wcI5psg/7URS/A4SA
 wLYo0Tv2XaU6fKe40WereGZoPWxXIT5fai4h5WDkAh/RdiAJvgY2unRDihzsZf3xNB3z
 3pJ4PxCLycrn9NiSuFHCp6PG3KdUfpicyxzbrpSDlScf7AvLD5Uab/KEr83IU3ZhaNVw
 CQX2teEgrxa0ul0ajUiUEzRLWIKx/5bCEOfjI/wFy5Z6ilGqebQBOrNIRoP7EEp5Tz/O
 6B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tDAGKPn1X39GwgvkOQct2nAxyY4q9My1QLgGG/CkmHA=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=UQebPs8ixbxD5eTbzejtTe4tA/p1HFb40ngrVBWcFVWt38ygfxr1LAA74uN0X7PA4a
 Cgrw7s4V+v+gbaqK4eKmVVpOsHBZ0lsAZhXRTRS65dGShRBLZAGiVepeytcjUeR2m4dz
 vJXqKd5wwAfghSHW+jri66aw6kQPfOUl0sMtBjeb5/BUB+t6Ltb7xXKU97VtYUhCxn+P
 U/kkacodITNTWF70JI2F/XmaN825jWYxx8F4KPwqscZ8vy0LdxzZR2m7hd8AXDEX+cRK
 uulz4XdQ13oDwNJC8oSe1f0VuYGMZmnEsUWNciW0WAm8r1NHeUh6HPjbYwNha0bnrYiL
 snOA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848640; x=1786453440;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tDAGKPn1X39GwgvkOQct2nAxyY4q9My1QLgGG/CkmHA=;
 b=cYjZ6MAmI3X1F7be7tJNTCcFBhLuXhXIRmxenRNzJYwmd/Mbp/dcT7w7JHv7xNB2SR
 KLq0UuvZ5qFlRpkdEk3+NdB6vc+Nkuvg8G2JAjfYWFS1XBjzOGxN/ilEbko7zxvTkBrO
 3P2EgQuEqGTZEFyW5maJ85vYIDKiiOzx/vaHCDQHhT8ktij+ujKl1gkG5VEFs7F+MppV
 kVugUeN5RnNznlmpZOIE757Rga09Lh9M5hIfArflHeKAiZHDJTaGibaIIu+HRF2fOTJz
 f6x6cGGkrtqa5iyJivdNpCbJkUHKtli9x9PDLVu4y1t//BZXojQV5+KP+PJdfGj7Mmot
 Z8sA==
X-Gm-Message-State: AOJu0YwrYoHLHGVAZUN/g7kiKdCHEj3yvjauNMUNNIbZtzluHGjs9DLu
 2CSzxx5RCaezewbVg6gUwpY5UAoGjMda1Ltiz/Uu8XBRvtHhXgXhHU5XSVPXup+MZE6QHgpscse
 D4OyVXxa4zSIeEX8oRVpj8DGLTC5IRTPkjzz8EmJ0
X-Gm-Gg: AR+sD134Q9P8ZWxxkLsZcwRI6dC1Ox1pAj0Ao7T+PcuvIiN7+Degf9aAH+ILo1OzANw
 NHwYZ+ZJJm+j+ckHndeZPopwz1T9W56wHVj/Z5VSu25SAMaP9QMDa07gbfFiis4ATkPrfPMjUnN
 MPGOJEs+BsEvn0NA+ojfD18v/Chq5SCVNtBhalJEVAF8XP4riNHSoI2h5od/8ysU+wNrZNam1AG
 akvNLTUy0iiLxu2Y+nZTW2AFo2sM0LdWnrK4M6PFbMXF4DTvbxnFzwo0Ex6XJDjCTW2pUaSlvle
 roEYW4Yy9Q3Q8xS6daZ8Zer0AZEGHrP3gggA9lQD9B8=
X-Received: by 2002:a05:6402:44dc:b0:69f:4c65:86c2 with SMTP id
 4fb4d7f45d1cf-6a0a7c61187mr10433385a12.2.1785848640167; Tue, 04 Aug 2026
 06:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-10-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-10-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:03:48 -0600
X-Gm-Features: AUfX_myGEBkfYJ6VBKDeNdKLBqjRBePpMx1OhAwT2avVkd0qtdWjx-qNynGjqak
Message-ID: <CAFLszTieNn+JSgDf=DFh-m8c+gxJ6eWJvo-2F7G7VwZ7O9tWXg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] doc: falcon: Describe booting the OS through TF-A
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848640; x=1786453440;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tDAGKPn1X39GwgvkOQct2nAxyY4q9My1QLgGG/CkmHA=;
 b=KqQiz2lpLXSP2F+L+/MN8CE0QDWltJUmq+unALUjAyyx0laCmqsaXJdwTAUxmBBo7h
 18wwNOx/zPloCKYOEQzTznBoutKlmLZgy9nfUg6hDrHlMjRtjBlbr6NYnI81FcZvg9ht
 rX6oQLu7CKj08vilsg0j+iHz3mZRXnYijjx+w=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KqQiz2lp
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> doc: falcon: Describe booting the OS through TF-A
>
> Falcon Mode documentation only covers SPL entering the kernel itself, which
> is not what happens on ARM64 SoCs needing ARM Trusted Firmware resident to
> provide firmware services: SPL loads a FIT holding BL31 as its firmware
> image and the kernel as a loadable, and BL31 enters the kernel as BL33.
>
> Describe that flow, what the kernel image may be given that neither
> booti_setup() nor bootz_setup() runs, how it differs from the classic flow,
> and how to configure and build it on Rockchip.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> doc/board/rockchip/rockchip.rst |   9 +++
>  doc/develop/falcon.rst          | 131 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 138 insertions(+), 2 deletions(-)

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> @@ -321,6 +321,15 @@ To build rk3588 boards:
> +Falcon mode
> +"""""""""""
> +
> +ARM64 Rockchip SoCs can also boot Linux straight from SPL through TF-A,
> +without U-Boot proper running at all. Enabling CONFIG_ROCKCHIP_FALCON_IMAGE
> +makes binman build a ``u-boot-rockchip-falcon.itb`` holding TF-A, the kernel
> +and an optional initramfs, which are passed in with LINUX_KERNEL and
> +LINUX_INITRD. See :doc:`../../develop/falcon` for the details.

Please point at the rockchip-falcon.config fragment here as the easy
on-ramp - patch 9 adds it precisely so users do not have to hand-edit
their defconfig, but nothing in either doc actually tells them to use
it. A one-liner like 'make <board>_defconfig rockchip-falcon.config'
would make the story complete.

> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> @@ -95,11 +95,138 @@ Function that a board must implement
> +SPL picks BL33 in spl_invoke_atf(), which looks for an image with
> +``os = "linux"`` in the ``/fit-images`` node it appended to the device tree
> +and falls back to ``os = "u-boot"``. The kernel is entered at EL2 with the
> +device tree address in x0, as the arm64 boot protocol requires.

Just to clarify - the fallback to os = "u-boot" only happens outside
secure Falcon mode, which is stated a paragraph later but reads as
contradictory on first pass. Consider folding the exception into this
sentence.

> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> @@ -95,11 +95,138 @@ Function that a board must implement
> +CONFIG_SPL_UFS_RAW_OS_DEVNUM and CONFIG_SPL_UFS_RAW_OS_SECTOR against
> +CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM and CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR, so

'against' reads oddly here - I'd suggest 'versus' or just 'and', with
a comma before 'so'.

> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> @@ -95,11 +95,138 @@ Function that a board must implement
> +DRAM which clear BL31 and OP-TEE, and can be adjusted with
> +CONFIG_ROCKCHIP_FALCON_KERNEL_LOAD and friends.

Please spell out the 'friends' - CONFIG_ROCKCHIP_FALCON_FDT_LOAD and
CONFIG_ROCKCHIP_FALCON_INITRD_LOAD

> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> @@ -95,11 +95,138 @@ Function that a board must implement
> +Enabling CONFIG_SPL_LZMA or CONFIG_SPL_GZIP additionally compresses the
> +kernel in the image, trading some decompression time for a smaller one - for
> +a 30 MiB arm64 Image, roughly 35% of the original with LZMA and 39% with
> +gzip. Note that this compresses U-Boot itself as well, since both use the
> +same setting.

Just to check - is 'compresses U-Boot itself as well' actually true
for the Falcon-only image (u-boot-rockchip-falcon.itb), which by name
does not contain U-Boot proper? I think you mean the same
SPL_LZMA/SPL_GZIP knob also compresses U-Boot in the regular
u-boot.itb built alongside. Worth rewording to make that unambiguous.

Regards,
Simon
