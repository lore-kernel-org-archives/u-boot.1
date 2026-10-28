Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J/W+Bbzo;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zylw0G7N
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D08E3406A3;
	Wed, 28 Oct 2026 14:46:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GaTLjK0cfLVz; Wed, 28 Oct 2026 14:46:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E98F40692
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198767;
	b=a9qMQ7WC1nY7SEWmfaKIMy9B53AFyLfNl8NP8/ngyDJBxY6MWVsRY4+s3CvMsJA0qfem
	 +7DD7Sx4VkPAFBr31+/dLzfsbFQ5AdHA1iMl1638WKTI355bR1cjaoCMn9uZ5QES04bdk
	 /R/i7yP1YCU3/afwQYbh5WyFA72cUOfDrynqoZRYR97NEgOro1BfO3hH08liebeS8u/ub
	 xdTvXcxiaCVmxcWw3BSW63p/wwPSCNKUhuctpg/ztd8lfN2z0D4FlwbeBhEBRNUt/KBAG
	 631JsldL7X0hLZFHVLFSYCVKrQIGnwOO446YmiBkasml/zYH7tHujJjpuqpSOqbCX/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
	b=bzmj5R+1BtUyAOeg02OkIGoOP9MS9DesdaaDT2QM7z8e4rmrcmdajQvxJRx0XpfIqe9L
	 mNYmpqmSx1XBreLWmI6SfqyknIg1ajnrl3fg9L2S/vRVvsbrPXSadoJ0afywE/0DAgHm4
	 EP/TSGDlwUuMAqEbtavpxdLr1zISVG/3wXSPzngTMKNkiJxBXTVnyjjmoJfeZZXoJ+v7D
	 OrqhRegRof5jVpsaC3X58louy/54j3stzfRU4uhNpXOR+AeE337S1D0irCzrPKUKfsGlr
	 zYBphdWSLmpqPBq3nYJ4j1+vSFz/lbAWOZmdx/cf/tXCmd5HkSahAOI8q7Dcz9Tca9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Zylw0G7N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198767;
	bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J/W+BbzodU4M5jo4uN1cL9DZXfUuvuAeiVCFIYbeK5nYyrDQUiL/lS48R+/4BRV7b
	 lo4XnBNnWezj2GgI/UgKmYbuRc4NKub9xx4RicsXZ1ZRdBBcXFyO8emAJrYgIh4hyF
	 b2s6yS2DUgUkvPpTQor0zkgTIBXK/OtLULu4IshFZ+hLxf+gEY+ySLYWeXeGbzQPdh
	 gDMtzi8oFiXhJzqLfyM+vu1gJ3lJs1CiX+gOVgTdKCXuLnuMv1E1H7fqgg3H22twKf
	 Qwgr2c1IUK/gM4YjYG3kX4tnGeHe8Qcrwr6P1iH43lhrelqmmBqOlcWtqGNZSGDD79
	 U0Re1PbHC8zpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E98F40692;
	Wed, 28 Oct 2026 14:46:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15961356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0780940562
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7a8xXcZsfin9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:09:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8A6BD404DE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196597;
 b=phEu/OhD62Npj9FeRkdHLBIONTMCfxJahCWFVWxRiesHIr1mBqoSSKQMsOwyeS5fhVfJ
 If3psXGjuocsmFU4LQU+87A5DuW+RJ33AOFrd7OD8ihSMSECEbv7klMCPDaQsp4DPTO9b
 nEgP77NWvCcB46tE8joUtO3UatHshffitAmku3AwTHDdNzW0Bqe0pLdAmGmRpGt8WTUny
 cdvsDuFFBF6RRzdKbwe3N7g4IzNhpMkEMC/ZmfvOrqgAe2EGNvYAy++FK3w5FMQKWueua
 3dXSFfShWtPvVesTvP+oQ8Ngsfld4S2LWdbGefCqTMzgeXfK9fdZJWTy/zeW92Ila4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196597;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
 b=GON9hbI8JfgEx1+oN8dNIsHNLWrWu0C7dQhZ28OVPJxhu0DkVEGXmBiYL9qVs65zWv4F
 9NOffr0AoYRlq/Vivutt6zVHEy50+2xk9iS0jD/oE0Ffb6PMStKBneylJRCE0wKaJInGM
 MANLoKOfu+XItaNjhtRx6qmEl26+bUAGItwWFMiz3Gw7ld3CEkCtw+lXlwPwECqXL3ENU
 gCM+KpovJvWOx+mcZLdYgvO64NpAAXzDHPCGyCE7anX1JC0pHdmVtLG/2k0GxXqtpTjvz
 MInd83C/yjajkrPJXLxTiKrUz2JRHingmCH+FOaVr9tOWdBEL8X83yaEstzOjX6QZjQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Zylw0G7N; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Zylw0G7N
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A6BD404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:09:55 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c38ac078440so11746166b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196594; x=1793801394;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
 b=Zylw0G7NucncXvvqwPutqSAD7hq/mL33faW1eaMx9BsT0vlXTZycEup1jITTQZRvVk
 4tQ8tpVxNLHqgJ6ja/kUS99nur/+qhpZFQShN7WW20pSFF3txmvphAUaHqrhrbGbwRLV
 FwjDADZ3VS1updem2KLB2zyxgn/CxMRE4zCleV4RFZv1LglTqENTy+RoR6dd0N0C5x1e
 N99UgmhP8vLqdE/csPETdtJaTm0/QPA++uBBYOZNJJyeReAp8yUIfQcFOQmgnXYf+fpR
 WbKz2/c8QxKhhOuX7QjQHt+AtDnOPKzq9juiOOZHuDgEL3exht28Cbd+chFsCZiWCNAq
 +wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196594; x=1793801394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTm56oQp0wNSHR1dxjaWdyMZQ00IWHSwXauafIMjGMY=;
 b=2nbloHRV6PPhir5YEZkcKTghnmRbc4PBGDk6/WwfatrtO85b6nNSVjvF7MEp/x/Six
 ItKlnJ2SYCVZFryJLxRur5C93n7SO0YrNpIQJh5pebKosIv8o2ScEihslLJG0BmGmsRf
 /+gCyId5lv83vvRLuS7v1ID4tVJNYO0Jt8EfjNZzp5yGBNRJP8XU4jmMlXR+RAr+dH9a
 sY6uwYWkTK4HtvBUoNxu+m579tgSOqTkfYwtHo/8A9u/eUd4jKgxLWQ/jmdViB1F0w15
 DpiyGZ0lNK6LMnwRbaZM23xZZxuanK0IStF69FoY/+ac+HlhJx3xfd+d7roKxvZkLyE9
 2Otw==
X-Gm-Message-State: AFq9FYIlxikadh5f7QANFGWdUVS8AI5y/XqwCWck5MBkUJt8maNq4wYM
 mxdDX7mVoqgZkUFi32rNYqiQIgNL0kFj2cFuVGfUtrdeT+OEga+a3ukHdDFtg1wJjhxxHw6cQCG
 hYGtV
X-Gm-Gg: AYBFou33nTJ5YsMSW4ae67aPeQAI+t/xMfG8lYS0RnYlETQ6rchGvn1QMLVpItbn3/w
 +CB5Kaq+gJRMJQW8K9Rwz3vhDrguA6zNHnGTRGtXLvbyajx67u1ZjkDDi2CehSw28Yo9TKvgPXl
 todTCEiFRqrTQeLDe82tmTOxlDLBdU7YbM/bRoIlDM6Jd718dd8WscWjkeLbNeN4E3Hv0jNvWNv
 SDL7bljqdnRibiwqTnHDzYou6yRqEa8HszX1u77sjt/bst8c6z6h5FBJFi2KsDJ5r3/2SjV02Pk
 WUi2oGfJsMhF83V9MQ0yaeZoQ1AEPfrb2e/9qDYQ+FOEjXS43eeFokqTwpGdiSYeSGxZ1crfNWG
 gS9a8weY35iiIYLcU5dclBtw5RT0bK4Rg6Xavs+t47US/xGPcUUAU54p/k8lK8LxhHcBVE9MpVm
 4W+Ke4ZFlVIGX2EuJHRkBBU/3mQ6FT8/OSuSIlA+znLeiDC3cCgK22dhWs0Oa3iuS34hVILfGlC
 W1Dvt71Wza8NSGkOz8ILHigi5slV4JwjNupKdFUtPnPr+g+N4Vm4G0vYvowqZ6AX2L/jSyszqm3
 GQ3psD2w2a0NMDjWRL8pe56knjiiK8Yme8k3V/Pu5Aosc4/HPdcpHIlD8zZR2UKuiON1s5X6rU+
 exu/8AAZo6A==
X-Received: by 2002:a17:906:5154:20b0:c49:ce7c:8a60 with SMTP id
 a640c23a62f3a-c49ce7c8bb6mr44134966b.2.1793196593910; 
 Wed, 28 Oct 2026 07:09:53 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd790afasm607807266b.68.2026.10.28.07.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:09:53 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 07/63] usb: dwc3: import from kernel v4.3
Date: Wed, 28 Oct 2026 15:08:33 +0100
Message-ID: <20261028140930.3025368-8-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.2 to v4.3.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v4.2..v4.3
Commits imported:
a66c275b3d5d usb: dwc3: gadget: Fix BUG in RT config
a474d3b73ba7 usb: dwc3: gadget: add ep capabilities support
c0bd5456a470 usb: dwc3: ep0: handle non maxpacket aligned transfers > 512
2abd9d5fa60f usb: dwc3: ep0: Add chained TRB support
368ca113ca0a usb: dwc3; ep0: Modify _dwc3_ep0_start_trans_ API to take 'chain' parameter
8a3442205630 usb: dwc3: ep0: preparation for handling non maxpacket aligned transfers > 512
2e5464da4e7d usb: dwc3: ep0: use _roundup_ to calculate the transfer size
b2fb5b1a0f50 usb: dwc3: ep0: Fix mem corruption on OUT transfers of more than 512 bytes
aa7399744dd0 usb: dwc3: gadget: defer endpoint name change
7eaeac5c0e44 usb: dwc3: gadget: add a trace when disabling EPs
d9972f470bcb usb: dwc3: core: remove unnecessary dev_warn()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |  2 -
 drivers/usb/dwc3/ep0.c    | 92 ++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/gadget.c | 61 +++++++++++++++-----------
 3 files changed, 101 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ff5773c66b84..064123e44566 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -455,8 +455,6 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 		} else {
-			dev_warn(dwc->dev, "HSPHY Interface not defined\n");
-
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
 				break;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 69e769c35cf5..5320e939e090 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -56,7 +56,7 @@ static const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
 }
 
 static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
-		u32 len, u32 type)
+		u32 len, u32 type, bool chain)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	struct dwc3_trb			*trb;
@@ -70,7 +70,10 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 		return 0;
 	}
 
-	trb = dwc->ep0_trb;
+	trb = &dwc->ep0_trb[dep->free_slot];
+
+	if (chain)
+		dep->free_slot++;
 
 	trb->bpl = lower_32_bits(buf_dma);
 	trb->bph = upper_32_bits(buf_dma);
@@ -78,10 +81,17 @@ static int dwc3_ep0_start_trans(struct dwc3 *dwc, u8 epnum, dma_addr_t buf_dma,
 	trb->ctrl = type;
 
 	trb->ctrl |= (DWC3_TRB_CTRL_HWO
-			| DWC3_TRB_CTRL_LST
-			| DWC3_TRB_CTRL_IOC
 			| DWC3_TRB_CTRL_ISP_IMI);
 
+	if (chain)
+		trb->ctrl |= DWC3_TRB_CTRL_CHN;
+	else
+		trb->ctrl |= (DWC3_TRB_CTRL_IOC
+				| DWC3_TRB_CTRL_LST);
+
+	if (chain)
+		return 0;
+
 	memset(&params, 0, sizeof(params));
 	params.param0 = upper_32_bits(dwc->ep0_trb_addr);
 	params.param1 = lower_32_bits(dwc->ep0_trb_addr);
@@ -302,7 +312,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	int				ret;
 
 	ret = dwc3_ep0_start_trans(dwc, 0, dwc->ctrl_req_addr, 8,
-			DWC3_TRBCTL_CONTROL_SETUP);
+			DWC3_TRBCTL_CONTROL_SETUP, false);
 	WARN_ON(ret < 0);
 }
 
@@ -783,7 +793,11 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	struct usb_request	*ur;
 	struct dwc3_trb		*trb;
 	struct dwc3_ep		*ep0;
-	u32			transferred;
+	unsigned		transfer_size = 0;
+	unsigned		maxp;
+	unsigned		remaining_ur_length;
+	void			*buf;
+	u32			transferred = 0;
 	u32			status;
 	u32			length;
 	u8			epnum;
@@ -812,17 +826,37 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	}
 
 	ur = &r->request;
+	buf = ur->buf;
+	remaining_ur_length = ur->length;
 
 	length = trb->size & DWC3_TRB_SIZE_MASK;
 
+	maxp = ep0->endpoint.maxpacket;
+
 	if (dwc->ep0_bounced) {
-		unsigned transfer_size = ur->length;
-		unsigned maxp = ep0->endpoint.maxpacket;
+		/*
+		 * Handle the first TRB before handling the bounce buffer if
+		 * the request length is greater than the bounce buffer size
+		 */
+		if (ur->length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(ur->length - maxp, maxp);
+			transferred = transfer_size - length;
+			buf = (u8 *)buf + transferred;
+			ur->actual += transferred;
+			remaining_ur_length -= transferred;
+
+			trb++;
+			length = trb->size & DWC3_TRB_SIZE_MASK;
 
-		transfer_size += (maxp - (transfer_size % maxp));
-		transferred = min_t(u32, ur->length,
-				transfer_size - length);
-		memcpy(ur->buf, dwc->ep0_bounce, transferred);
+			ep0->free_slot = 0;
+		}
+
+		transfer_size = roundup((ur->length - transfer_size),
+					maxp);
+
+		transferred = min_t(u32, remaining_ur_length,
+				    transfer_size - length);
+		memcpy(buf, dwc->ep0_bounce, transferred);
 	} else {
 		transferred = ur->length - length;
 	}
@@ -844,7 +878,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 			ret = dwc3_ep0_start_trans(dwc, epnum,
 					dwc->ctrl_req_addr, 0,
-					DWC3_TRBCTL_CONTROL_DATA);
+					DWC3_TRBCTL_CONTROL_DATA, false);
 			WARN_ON(ret < 0);
 		}
 	}
@@ -928,10 +962,10 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 	if (req->request.length == 0) {
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ctrl_req_addr, 0,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else if (!IS_ALIGNED(req->request.length, dep->endpoint.maxpacket)
 			&& (dep->number == 0)) {
-		u32	transfer_size;
+		u32	transfer_size = 0;
 		u32	maxpacket;
 
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
@@ -941,21 +975,26 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 			return;
 		}
 
-		WARN_ON(req->request.length > DWC3_EP0_BOUNCE_SIZE);
-
 		maxpacket = dep->endpoint.maxpacket;
-		transfer_size = roundup(req->request.length, maxpacket);
+
+		if (req->request.length > DWC3_EP0_BOUNCE_SIZE) {
+			transfer_size = ALIGN(req->request.length - maxpacket,
+					      maxpacket);
+			ret = dwc3_ep0_start_trans(dwc, dep->number,
+						   req->request.dma,
+						   transfer_size,
+						   DWC3_TRBCTL_CONTROL_DATA,
+						   true);
+		}
+
+		transfer_size = roundup((req->request.length - transfer_size),
+					maxpacket);
 
 		dwc->ep0_bounced = true;
 
-		/*
-		 * REVISIT in case request length is bigger than
-		 * DWC3_EP0_BOUNCE_SIZE we will need two chained
-		 * TRBs to handle the transfer.
-		 */
 		ret = dwc3_ep0_start_trans(dwc, dep->number,
 				dwc->ep0_bounce_addr, transfer_size,
-				DWC3_TRBCTL_CONTROL_DATA);
+				DWC3_TRBCTL_CONTROL_DATA, false);
 	} else {
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
@@ -965,7 +1004,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		}
 
 		ret = dwc3_ep0_start_trans(dwc, dep->number, req->request.dma,
-				req->request.length, DWC3_TRBCTL_CONTROL_DATA);
+				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
+				false);
 	}
 
 	WARN_ON(ret < 0);
@@ -980,7 +1020,7 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 		: DWC3_TRBCTL_CONTROL_STATUS2;
 
 	return dwc3_ep0_start_trans(dwc, dep->number,
-			dwc->ctrl_req_addr, 0, type);
+			dwc->ctrl_req_addr, 0, type, false);
 }
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 333a7c0078fc..1e8bdf817811 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -547,6 +547,23 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		strlcat(dep->name, "-control", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		strlcat(dep->name, "-isoc", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		strlcat(dep->name, "-bulk", sizeof(dep->name));
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		strlcat(dep->name, "-int", sizeof(dep->name));
+		break;
+	default:
+		dev_err(dwc->dev, "invalid endpoint transfer type\n");
+	}
+
 	return 0;
 }
 
@@ -586,6 +603,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	struct dwc3		*dwc = dep->dwc;
 	u32			reg;
 
+	dwc3_trace(trace_dwc3_gadget, "Disabling %s", dep->name);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -602,6 +621,10 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	dep->type = 0;
 	dep->flags = 0;
 
+	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
+			dep->number >> 1,
+			(dep->number & 1) ? "in" : "out");
+
 	return 0;
 }
 
@@ -647,23 +670,6 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 		return 0;
 	}
 
-	switch (usb_endpoint_type(desc)) {
-	case USB_ENDPOINT_XFER_CONTROL:
-		strlcat(dep->name, "-control", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_ISOC:
-		strlcat(dep->name, "-isoc", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_BULK:
-		strlcat(dep->name, "-bulk", sizeof(dep->name));
-		break;
-	case USB_ENDPOINT_XFER_INT:
-		strlcat(dep->name, "-int", sizeof(dep->name));
-		break;
-	default:
-		dev_err(dwc->dev, "invalid endpoint transfer type\n");
-	}
-
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -692,10 +698,6 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 		return 0;
 	}
 
-	snprintf(dep->name, sizeof(dep->name), "ep%d%s",
-			dep->number >> 1,
-			(dep->number & 1) ? "in" : "out");
-
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
 	spin_unlock_irqrestore(&dwc->lock, flags);
@@ -1713,6 +1715,17 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 				return ret;
 		}
 
+		if (epnum == 0 || epnum == 1) {
+			dep->endpoint.caps.type_control = true;
+		} else {
+			dep->endpoint.caps.type_iso = true;
+			dep->endpoint.caps.type_bulk = true;
+			dep->endpoint.caps.type_int = true;
+		}
+
+		dep->endpoint.caps.dir_in = !!direction;
+		dep->endpoint.caps.dir_out = !direction;
+
 		INIT_LIST_HEAD(&dep->request_list);
 		INIT_LIST_HEAD(&dep->req_queued);
 	}
@@ -2652,8 +2665,6 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 	int				i;
 	irqreturn_t			ret = IRQ_NONE;
 
-	spin_lock(&dwc->lock);
-
 	for (i = 0; i < dwc->num_event_buffers; i++) {
 		irqreturn_t status;
 
@@ -2662,8 +2673,6 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc)
 			ret = status;
 	}
 
-	spin_unlock(&dwc->lock);
-
 	return ret;
 }
 
@@ -2685,7 +2694,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err0;
 	}
 
-	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dwc->ep0_trb = dma_alloc_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			&dwc->ep0_trb_addr, GFP_KERNEL);
 	if (!dwc->ep0_trb) {
 		dev_err(dwc->dev, "failed to allocate ep0 trb\n");
-- 
2.53.0

