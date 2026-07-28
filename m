Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826A8C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F72F40A50;
	Tue, 28 Jul 2026 18:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2Ohgj_W8_9K; Tue, 28 Jul 2026 18:51:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7021F409EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264693;
	bh=de1EItWEGqpc5T7q7tWPwyo3BWlSml17Pt7hOZQKZnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vunOlE29MiNMI3l2/bIM1bB1f1Fll/np/XTNKVjlQTNkFjrcmnIK/QzOgg6TkgWmk
	 x4ycQxveh7s8VREBT7K/NyKCMuwFLgJhuz5kqs+YTCP/faWGjMTyZZfcOnmx1WxsTi
	 5Fj/jX7aoup2lJvEEkq+qYdxQh59gkkorXar8tw1ZZbzyzOi7SYyxoZO/Q2eGcGbdV
	 rRibIgwdck8hS03YBANn1ptM4OdkxuyuVQBBeyC1i29ALs31ILJlv6aygbWr8JoNHa
	 M2iHQ9ybPvy8ulRnnhTpl1/3PDx763BmzMp5DqJrx4RDZrvTjrOe95yFTiAPipsv0z
	 IY2KJEE0z3qtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7021F409EF;
	Tue, 28 Jul 2026 18:51:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6F8D45B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD88A608F9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HfYrvRQQnjY9 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:51:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ECE5A608FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECE5A608FB
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECE5A608FB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:51:31 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69eae037da1so131975a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264690; cv=none;
 d=google.com; s=arc-20260327;
 b=LSPJ6bP4kLvZwERXoMezl8jWa2+sCjACr3GBm4aLWFCjAG0rdOMo5A9HZl6z6ufWK0
 47lJcdRxU2zp5o+4Wo+8yiW+jhbckdrRVpmkkCjtTYT/8HqjQC9XaXxd9tNNFAGULp6f
 sVJYZBv/UO99JM5VZd6P92WzsNtgqMesy2hB3KOV9fI0vVz6yFRtZZwOkaxpBaQDBCKT
 DFBmplPpMks3+5fIbk5pvIAbtenj5NOxix+bzMDn02F/z0b96vubmvnRJ7GdKtCuNpLa
 mDTN4hhT+YLhQRYqzjoQT6k6vsO+s1EOWZnEONcluMVukPEK5ok7zLLGWIuEhbDEA7GN
 9F1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=de1EItWEGqpc5T7q7tWPwyo3BWlSml17Pt7hOZQKZnE=;
 fh=0Z/JGJ+bgnnFrsTjL+skBu3oHw408OgIofcfZwsueLw=;
 b=I/e/e9ekWrPIJTgtx2CMlFK3pUtc9zZhuzPz1GvFxrjRO7VCaEGbTia5gdImOQhJ3I
 JcGck/K5Rx110W+ucIuelA8s/QZByAX4AU0v5ZEbHhNZ+Ez5dBuG+Q0lG8iRXi/q0742
 h87fKy5gEP05mop5IKieXNp56w2HY3Ca4qwkqRgO5881uHVL7hnWBQ3y4Ni/gE9Mai7v
 qY6gII5xnWdt1ScG3inod89uvwUCZiUN/0brl3YOS/OI0i0rg1OB2nuWbUUQ0/jcOsWj
 ZzoummgL4wKHUaX/xnclEbKtDqVbYsoIg7V0+yWLdGzYwmotxGq46OOHahNOojMG7XbM
 BJ4A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264690; x=1785869490;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=de1EItWEGqpc5T7q7tWPwyo3BWlSml17Pt7hOZQKZnE=;
 b=X9KQwpzF0xKdv7+LLta/VsxBMWg5cknbz87RQKYSIf/Cfm4EjuwClujtkUiHUBSc1W
 KggiLsDbaBaS6kjZIV8CTBuftVmZKrB/eW36WbAn9UMd04yUC8VEgmzsEes+dPws3DVF
 D0kVvF4Pc8l9enrEE2xeGzCkZhtm8iJJHtxgHwG+oWyzwbvV8kaBgM6fEgNZ2FmIRL4F
 v0+Hbc9sABOYP2QImF5R4lDMUyRmgcWk3F8bqqSHen8vaf0EuwOrGOyuzDQXBB6nbvBB
 MegJPUiXwA1jjySuq2qMIH0oic5ilR6T3hWNMz3I+wqhacC6seuQvHbk10G2++nUHlDv
 ePnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0QU0xcuuPEmW+AXevQL9kHzzo5fANaqM9iRnAaep3yMgbCoQv4d3Vj/hbTvFYW95SdCwRP/I=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yzw2OzYvcMH26NpewbslI9XFqDnXEHBmya5muv1k9JLjFjOcBZ5
 xXXqBAwni2nqByGmHO+O12f0/7XPTDtWnTAQrmgzRSjNZZ/ZEawnX4ma5Qlk53HIBnhKf6YUnZB
 NdXfTBW1KBNRkRdAAtSHVRanErwdalyIxO6bkz90n
X-Gm-Gg: AR+sD12R+4+LjOUh9I3bXChsQccbovYys8+J1FxRBUzukO77f9pDk6uIeamT7XhOtwx
 LYvLQUsb4VYkIO4TLox/CFo1eh/M0oXgyRcLYQy17i8ubv3CJ9JvF+KxRDp8MPGO5rKl8Pp06ns
 VnJwe86PoytuNlj/CvPJBRByxzZ883TUPGjYjmWaLScH5q+nDRJ1nS38L8MkEbyFp2yn+lTPLkR
 lXZ9VgRzmrepGLrwrl3NXnHMl1WXTKDQlriLLM7gZUMEbW7FzXNDwPnBYui
X-Received: by 2002:a05:6402:1913:b0:69f:e13d:b9da with SMTP id
 4fb4d7f45d1cf-6a034a8142dmr2017475a12.37.1785264689968; Tue, 28 Jul 2026
 11:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <20260726115702.15397-3-bhargavdas100@gmail.com>
In-Reply-To: <20260726115702.15397-3-bhargavdas100@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:51:17 -0600
X-Gm-Features: AUfX_mxL1VLywXWd4TvsC1yIsRhgxC0x2zOWFohPRAZIb4OX3a4aQyYEKuWKtCo
Message-ID: <CAFLszTisb-KaWUZAfQrOCf_0xA85auyY2UU5oBvuFAfFnqM86g@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] arm: dts: Add RP2350 device tree
To: bhargavdas100@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264690; x=1785869490;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=de1EItWEGqpc5T7q7tWPwyo3BWlSml17Pt7hOZQKZnE=;
 b=PSg9oWlf6PVyNHCCv3y1XpnbvPQfK7xdYv7gYO4Sn1oyO7znRAl2rH4Q9TMeig4Mdv
 /GvlhG4wx3qyw0t+K6D7BF32Qy79kbRXBP8MoGeXv7Z2yBxQKEiJsH0bQW3D3mgvzGiO
 6uRjToMsyzQIu5S4yhZPb3FkKoz6FuMCsV0e0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PSg9oWlf
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

Hi Bhargav,

On 2026-07-26T11:56:45, Bhargav Das <bhargavdas100@gmail.com> wrote:
> arm: dts: Add RP2350 device tree
>
> Add device tree for the RP2350 SoC (rp2350.dtsi) and the Raspberry Pi
> Pico 2 board (rp2350-pico2.dts).
>
> rpi_pico2_defconfig selects CONFIG_OF_EMBED, building the dtb from
> u-boot's source rather than CONFIG_OF_UPSTREAM.
>
> Signed-off-by: Bhargav Das <bhargavdas100@gmail.com>
>
> arch/arm/dts/Makefile         |  1 +
>  arch/arm/dts/rp2350-pico2.dts | 30 ++++++++++++++++++++++++++++++
>  arch/arm/dts/rp2350.dtsi      | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)

> diff --git a/arch/arm/dts/rp2350-pico2.dts b/arch/arm/dts/rp2350-pico2.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0+

Since the aim is to align with a mainline Linux device tree (assuming
they would accept a file for something that cannot boot Linux!),
please use the dual 'GPL-2.0-only OR MIT' licence that new Linux DT
files use. It saves a relicensing step later, and most new DTs in
arch/arm/dts already do this. Same applies to rp2350.dtsi

> diff --git a/arch/arm/dts/rp2350-pico2.dts b/arch/arm/dts/rp2350-pico2.dts
> @@ -0,0 +1,30 @@
> +     memory@20000000 {
> +             device_type = "memory";
> +             reg = <0x20000000 0x00082000>;  /* 520 KB SRAM */
> +     };

The 520KB SRAM is a fixed feature of the RP2350 itself and identical
on every board using this SoC, so this memory node belongs in
rp2350.dtsi rather than the board .dts. Only genuinely board-specific
things (aliases, chosen, which UART is enabled) belong here.

> diff --git a/arch/arm/dts/rp2350.dtsi b/arch/arm/dts/rp2350.dtsi
> @@ -0,0 +1,32 @@
> +             uart0: serial@40070000 {
> +                     compatible = "arm,pl011", "arm,primecell";
> +                     reg = <0x40070000 0x1000>;
> +                     clock = <150000000>;    /* CLK_PERI = clk_sys 150MHz */
> +                     status = "disabled";
> +             };

The 'clock' property is a U-Boot-specific fallback that the pl011
driver reads via dev_read_u32_default() - the standard pl011 binding
uses a 'clocks' phandle plus 'clock-names'. It works for now since
there is no clock driver, but it will diverge from whatever eventually
goes upstream to Linux. Just flagging it so it is not forgotten once a
clock uclass driver appears - a comment in the commit message noting
this is a temporary shortcut would help.

Regards,
Simon
