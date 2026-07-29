Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74563C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36D6A60AB3;
	Wed, 29 Jul 2026 09:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0MV8Vgkm61Q; Wed, 29 Jul 2026 09:21:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B7BF60ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785316876;
	bh=YU04F6iWEt37QDNYYFYz2f9sSQPowedpDasH328MtTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHd51905/uh/tCPcnqYLaN+9YK7bw8ZwoXiQaCVZeEL01uagCNcTKjzU7bdPfReO/
	 YHBRKO0oHuL/f2oxpdEv6clK0V9qjOKlFeQ9X0Zoq6IGR7DO+8vwQRy/JfPJUGAeJj
	 rbBNomxBV1dDUJ5magsX5j3ytORzn0yP8DHSollxHri2l2XUCkypdwszkEw5d1Wlbp
	 +e5+UvkJV4vBYaOaMLOnvpVtIKLfpo58eg4sopsKBimuPF/Ds1X1m8XF2cQVzyI+xb
	 JZunPcnkCYOjUBa1jFnRMrJxkMqu6MMgbrRpCnraCWMUyii10Ki8NsPZiXTYAHffYW
	 17sQuQXh0BHbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B7BF60ADD;
	Wed, 29 Jul 2026 09:21:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDDE1788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFBBC60AB3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsEmuC1lp9vh for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:21:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4820E60ADD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4820E60ADD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4820E60ADD
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:21:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23718494B; Wed, 29 Jul 2026 11:21:11 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3E38404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:21:09 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09833600B1;
 Wed, 29 Jul 2026 09:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392BB1F000E9;
 Wed, 29 Jul 2026 09:21:07 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v5 51/75] usb: dwc3: import from kernel v6.7
In-Reply-To: <20260716134305.614278-52-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-52-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:21:05 +0200
Message-ID: <87qzkmywvy.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785316867;
 bh=YU04F6iWEt37QDNYYFYz2f9sSQPowedpDasH328MtTI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=K1gj1xoYAf3QMxg7fyCip+NK5adMlXLhspcZpKT+su+6eyf9McQx4uWDic09vrgEO
 kBnaJ0cBPmY4OnJ8sUfkWEIKV3NVmpqZ6k4aZj0dhmlbj8b2Lm/7T8FN4AKjkI/XhK
 8QwdwIl958XEfLVY9/+lYRrGJQtHsWKaQ6DjmmvPIUT4zc/E7uglWBymbZuDytDnqz
 McXHWMQX6pyoyT1n5xlBGBLScbeVt+OQPiKIikDKVXF16d+F+sD0+AtXKdQmNKFzr0
 EbOfiPpj3YOMdGo+Trh5s90ihf6OlKEInNo//MLofFRMGf7X0jy86fzmDT8A5/bcTQ
 Vf5GU+oeHcu8g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K1gj1xoY
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="K1gj1xoY"; 
 dkim-atps=neutral
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

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v6.6 to v6.7.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v6.6..v6.7
> Commits imported:
> 9cf87666fc6e USB: dwc3: qcom: fix ACPI platform device leak
> 9feefbf57d92 USB: dwc3: qcom: fix software node leak on probe errors
> 51392a1879ff USB: dwc3: qcom: fix resource leaks on probe deferral
> aee70a1d7113 USB: dwc3: qcom: simplify wakeup interrupt setup
> 41f5a0973259 USB: dwc3: qcom: fix wakeup after probe deferral
> 8bbae288a85a usb: dwc3: set the dma max_seg_size
> 791cd7afe51b usb: dwc3: add missing of_node_put and platform_device_put
> 10d510abd096 usb: dwc3: Fix default mode initialization
> 97789b93b792 usb: dwc3: add optional PHY interface clocks
> de7ecc4e0570 usb: dwc3: xilinx: add reset-controller support
> e24bc293a6a6 usb: dwc3: document gfladj_refclk_lpm_sel field
> e72fc8d6a12a usb: dwc3: core: configure TX/RX threshold for DWC3_IP
> 34c200483569 usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver

Please drop the commits that were not imported (for example qcom,
xilinx, rtk)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

