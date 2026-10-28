Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DB606A335
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ott+gUZa;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b+KRoIck
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC3BB81466;
	Wed, 28 Oct 2026 14:49:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWdnOZVez3Bc; Wed, 28 Oct 2026 14:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB242811CB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198857;
	b=kq2ULTIHPrgvv1y2RuqC4W8W+Z8XoR+R95GHRt9bJp0CLQ2V/iTwOjzoM5aMsl+WkOSL
	 1cj3lxHIx86eItYmevYdhvxM8QU0AyEprHWphcuut85VikvS8ZDry3s8xw2vmaNxtar1J
	 BdOB0/eoKoD01rjeWblU3OJnaLUwJugqV9zwP/oHoOMitpv5y9TCvyt6rSn2vwcMPfLju
	 ED0BdpL+lC5TMGmZPQ+9hCPMs9800LZmMrqKRRVX7V6KkDxnF+YPXV3uv/9JXy5JWcLyc
	 HA16N85SdKu41gXqQrYCrCN35X97T4X482/ngjbFEuMZFUjD6abuMjSz878a9dvnXTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
	b=SOPVN5HZlIXazXBYZgLmEja1g/EL58kKHNoRKryArXm7dLkXrcJ3r2vbuLlpJPXZzmGU
	 EXf0NOSK3nLPJLqPP26iykB3zs6kqAob6VIy7e3+3SucfDDX7gjHWs3BP/s56tYmCNrPB
	 PCIurChOJkd1VX2soDeHny3riUcRCZRMhHcJsIN/8sITCBUiOn4zz5xEavJSnNQy+VBVO
	 pkOUu2QQILSawgEHYEk8QHAmfXj2CNqZ5A0r56kPrc3CwncN1CNXcJAkUiRFxYOrrU0dn
	 Im1aLNUY+8QgoI5JDc5PJ9fr6tuRqVyYvQR5JKPtyplMVK3tnxPkBOrlgwMmQ/afFkw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198857;
	bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ott+gUZaSbPFd328D2NdDddrZmk5zETQ4i6+SCpZoYDbT1CfO0BecjL9w5/eXGUx2
	 X9CxFYx/DHJ2WRu+aN1QvDu9Z+hluhnqdN2IcBAxzN81sBCnsvXU7i79a8gdXfeTqs
	 jMmvAGl+e3uX0tSI3kVa1Bp4nkpstXVE35N1f9XUCLrScQmyJV670toKY6GHr5daoK
	 GENr8nkdlZ5oGfhyo4HJX8h6Vw43cWyyDQ9HU9PPOGDE4ZPZZhSTwsvjSrKMh5uEGn
	 xblf8MhBq4k5WeyVxG0JhrqwOs/EMGT13RlEQbHGfrOq8SrFr6Devao/E4OCeDnuQe
	 RIi4yZZCUKOsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB242811CB;
	Wed, 28 Oct 2026 14:47:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE1BB4D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFB3640518
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MS8zO6FbLvm6 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 96CAE404DE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196849;
 b=JBPs4vjFQxkev6oGOgK2UCtzI9pWXmMoqt4iXG3ewpv4i4h/NiccktqFh96pgHTk9lM9
 fplVC0SbzbeOv1Q0GwS5Rz+o9c+BaGHl90GWhoKrn7s9pPUmye7DCqdRGdvSFeAEoVJQB
 1h6hTgwZApn36JM69Pu3BAokEtTU2dhjIatV2BZMe3vmdi5K4cIiQL0XcdHAptDvLMqIz
 EfOLp3IVu+Zh5ukHPRGytFeAKtHOPltfeAQ35WpQbNVbWjtbMB2JzgAJbEvBoN8TXIAjL
 BacAnG66NXxQ35L2m5gVEztVilEu0zjHS3v+SU+PI7h+Q19HietADi+4AlgPgiCL/oQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196849;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=sF15ixtmw5bAqf8qVYfevNegUNPdDAmRRHS/+awf0aLd5GOO15Z2bmt7X0ICOxMdFHvn
 TeaPSGtj2Ip7xPnUuLgzUyt/+4WIwBFTQHoBmF2FfXE/PrzcfCmW6bK7TEfLXUxlt3wPM
 BiXh9uS1FuUee26gGmzyY1SADMzb11QzFY2G00CJYqs0oWQki+cqc749VS1vMsrE/MWvA
 qN1vKejw/4Yt1Tv3UpKhJWKfME/y5oEqsUGV/2Ukx/eE1Z8spQHGJZLGwGKtvSG5RZ7rf
 HujN7Z+S1Qeof3/e0nxkRtua27EEaPuNO2/CPhNB8Bltpz3vg+nO6k8s3jUx2D6Ilew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=b+KRoIck; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=b+KRoIck
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96CAE404DE
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:08 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c40aa03a96fso11237966b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196846; x=1793801646;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=b+KRoIckdFOTWp4EUGsJS9EenKNEUXlFqmpwWFUcttzye5mREEg1mQ6puli7DkSjWs
 eHi9yjT0JtFbSjwNNrAUuypnW+Ei7YpoLDbGCwBKeQnfZdZ9DDVzCO0n8wj6FLc8BqjV
 zwveZNwYKpQrIK+cZLZ78CY64rOJBK4AfOecVWHR07Vltdmrtf4oxk9pV86adsNQSrOz
 GjSS4I0vOMOqqp5Kdnbmwk0O1ue6ffKVyk71J8aUVj3ulrcrvnbDNcdH9/05v1WQKSkq
 za76M9rlWRfmd0sKTeRMJiAzadQg1sSGL4fdJsfmeXcHEfb5sdwcQrwyZiKjtP0geoeT
 L6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196846; x=1793801646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5g0xwoqaIl6hdgvO1YxGZQk93ObKcJjpRJ+I0ffNrDI=;
 b=Bs/DFM6WXsd/bXmWCxmtbYYvxSoMfsylL1SOhjWH6BRnmMA6UxDhOH39qSBDnlwGIR
 C/U2EVu07lnxg10HKcENgxHn+bC2tG9gO+5ahrW34M20X3apDeNVWzUf2tF4C1AtSBjw
 Ifa5//lPElraSqS5X0sgS5V/8kJP3f8jofGfg1ASPhGqu5CwC9gYlsYa11fa4mSQ2MYZ
 yArJVUPvrQZyiRMfvpz04FF3pgv6Sg26fEwKEo6IEkRi2c/eYZb7AUN53iXbxesn0cRi
 nFgqKjgn/M7ZyldoN0p44CbzOZg86WQq8za0epbhMfG0ion+HOSEuYtsLRQIIA507D1M
 9uVw==
X-Gm-Message-State: AFq9FYLfjmkWqC2cWFo55srt68LhW++XYM4wJTCRNrM1xKsL/2aidvFk
 dEYAw8k2GVRE0c2Tr3Vd9T6s8VYguNT39iKxwRDoSXhRR5Ypc5BPy+uMtce7myDssIh09j4bAqx
 HTAoV
X-Gm-Gg: AYBFou0OioJIDElaOcLZizKZPOh0gusZs6O+LOX9nBPprGQUR1URq53Q1A0RKT/WynE
 Fxn5gACWya4WbvAbpMv044cSMZOFsQSKyKdijLgaXQxNqWufvp1moBTM1eRXheGwRKkI8tVePxN
 55lHlCEIFo2aUP0VwvTjdkZiFPOQtxyuNBOrlf0v1oqXf7ZAbwiCTyfVWuyicdPAKDCINSc5QFi
 oOeLyipyqI86JvDvibnB0WXoHHf/VwqoaGfsydtlGIh1DOBxo+RygBpWjaBOtQBFQDpQK2de9Iv
 hfanCFzw4zPgQdU3rbKiiIEw3JR1mR+x4MOV3nVz7zzlCu7+kUsNFFelSEW0owkaU56rgD6nYBw
 cCephFktZbB6t69SNCPCmO9Z987yx3oMbEkEuQYYAX6BzxK2LzuSxjQd6Rc5sgMKYAb4gToIrDY
 kwS5XwTmSkz4fXYZu8/GVojjHS7/yHb/p+WxC1aMR64W6EODnsJXTbK0lxittZmLjc21oMU33Pd
 sVdB3BtkczpaanWlHB3qKVq8nhydwgtksPNykSMeQEwCNE6RuvtUe+AWr3R7+htaWVTMdwM44p7
 t7piMh00wv7lf+NadStpTcYhwfNCvpQ5MzNa1vlvYkPTSXKKw++fVa3pC0UdyWxmgEvQFPEvIRZ
 zCtlH1tSvWus=
X-Received: by 2002:a17:906:9986:b0:c46:b5a7:5b29 with SMTP id
 a640c23a62f3a-c49bde9c83amr231857566b.2.1793196846385; 
 Wed, 28 Oct 2026 07:14:06 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524271sm628414666b.35.2026.10.28.07.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:06 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 56/63] usb: dwc3: import from kernel v6.11
Date: Wed, 28 Oct 2026 15:09:22 +0100
Message-ID: <20261028140930.3025368-57-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.10 to v6.11.

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

List of commits: git log --oneline v6.10..v6.11
Commits imported:
9149c9b0c7e0 usb: dwc3: core: update LC timer as per USB Spec V3.2
00dcf2fa449f usb: dwc3: Avoid waking up gadget during startxfer
72fca8371f20 usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)
14e497183df2 usb: dwc3: core: Prevent USB core invalid event buffer address access
d504bfa6cfd1 usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
179264157bba usb: dwc3: core: Check all ports when set phy suspend

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 89 +++++++++++++++++++++++++++++++++------
 drivers/usb/dwc3/core.h   | 10 +++++
 drivers/usb/dwc3/ep0.c    |  3 +-
 drivers/usb/dwc3/gadget.c | 41 ++++++++----------
 4 files changed, 106 insertions(+), 37 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index cb82557678dd..9eb085f359ce 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -108,22 +108,27 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
 	u32 reg;
+	int i;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	if (enable && !dwc->dis_u3_susphy_quirk)
-		reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-	else
-		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+		if (enable && !dwc->dis_u3_susphy_quirk)
+			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+	}
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (enable && !dwc->dis_u2_susphy_quirk)
-		reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-	else
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+		if (enable && !dwc->dis_u2_susphy_quirk)
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+		else
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+	}
 }
 
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
@@ -559,9 +564,17 @@ int dwc3_event_buffers_setup(struct dwc3 *dwc)
 void dwc3_event_buffers_cleanup(struct dwc3 *dwc)
 {
 	struct dwc3_event_buffer	*evt;
+	u32				reg;
 
 	if (!dwc->ev_buf)
 		return;
+	/*
+	 * Exynos platforms may not be able to access event buffer if the
+	 * controller failed to halt on dwc3_core_exit().
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
+	if (!(reg & DWC3_DSTS_DEVCTRLHLT))
+		return;
 
 	evt = dwc->ev_buf;
 
@@ -599,6 +612,18 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (dwc->gsbuscfg0_reqinfo != DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED) {
+		u32 reg;
+
+		reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+		reg &= ~DWC3_GSBUSCFG0_REQINFO(~0);
+		reg |= DWC3_GSBUSCFG0_REQINFO(dwc->gsbuscfg0_reqinfo);
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1338,6 +1363,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
@@ -1359,6 +1386,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
 	 * fails to send proper CRC checksum in CRC5 feild. Because of this
@@ -1576,6 +1618,27 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 }
 
+static void dwc3_get_software_properties(struct dwc3 *dwc)
+{
+	struct device *tmpdev;
+	u16 gsbuscfg0_reqinfo;
+	int ret;
+
+	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
+
+	/*
+	 * Iterate over all parent nodes for finding swnode properties
+	 * and non-DT (non-ABI) properties.
+	 */
+	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
+		ret = device_property_read_u16(tmpdev,
+					       "snps,gsbuscfg0-reqinfo",
+					       &gsbuscfg0_reqinfo);
+		if (!ret)
+			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
+	}
+}
+
 static void dwc3_get_properties(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
@@ -2090,6 +2153,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc3_get_software_properties(dwc);
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset)) {
 		ret = PTR_ERR(dwc->reset);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3781c736c1a1..c71240e8f7c7 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -194,6 +194,10 @@
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
 
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_REQINFO(n)	(((n) & 0xffff) << 16)
+#define DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED	0xffffffff
+
 /* Global Debug LSP MUX Select */
 #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
 #define DWC3_GDBGLSPMUX_HOSTSELECT(n)	((n) & 0x3fff)
@@ -417,6 +421,7 @@
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
@@ -1153,6 +1158,9 @@ struct dwc3_scratchpad_array {
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
  * @debug_root: root debugfs directory for this device to put its files in.
+ * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
+ *		       DATWRREQINFO, and DESWRREQINFO value passed from
+ *		       glue driver.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1262,6 +1270,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
 #define DWC3_REVISION_330A	0x5533330a
 
 #define DWC31_REVISION_ANY	0x0
@@ -1380,6 +1389,7 @@ struct dwc3 {
 	int			last_fifo_depth;
 	int			num_ep_resized;
 	struct dentry		*debug_root;
+	u32			gsbuscfg0_reqinfo;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index d96ffbe52039..c9533a99e47c 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -232,7 +232,8 @@ void dwc3_ep0_stall_and_restart(struct dwc3 *dwc)
 	/* stall is always issued on EP0 */
 	dep = dwc->eps[0];
 	__dwc3_gadget_ep_set_halt(dep, 1, false);
-	dep->flags = DWC3_EP_ENABLED;
+	dep->flags &= DWC3_EP_RESOURCE_ALLOCATED;
+	dep->flags |= DWC3_EP_ENABLED;
 	dwc->delayed_status = false;
 
 	if (!list_empty(&dep->pending_list)) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89fc690fdf34..291bc549935b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -287,6 +287,23 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
  *
  * Caller should handle locking. This function will issue @cmd with given
  * @params to @dep and wait for its completion.
+ *
+ * According to the programming guide, if the link state is in L1/L2/U3,
+ * then sending the Start Transfer command may not complete. The
+ * programming guide suggested to bring the link state back to ON/U0 by
+ * performing remote wakeup prior to sending the command. However, don't
+ * initiate remote wakeup when the user/function does not send wakeup
+ * request via wakeup ops. Send the command when it's allowed.
+ *
+ * Notes:
+ * For L1 link state, issuing a command requires the clearing of
+ * GUSB2PHYCFG.SUSPENDUSB2, which turns on the signal required to complete
+ * the given command (usually within 50us). This should happen within the
+ * command timeout set by driver. No additional step is needed.
+ *
+ * For L2 or U3 link state, the gadget is in USB suspend. Care should be
+ * taken when sending Start Transfer command to ensure that it's done after
+ * USB resume.
  */
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
@@ -327,30 +344,6 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 	}
 
-	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_STARTTRANSFER) {
-		int link_state;
-
-		/*
-		 * Initiate remote wakeup if the link state is in U3 when
-		 * operating in SS/SSP or L1/L2 when operating in HS/FS. If the
-		 * link state is in U1/U2, no remote wakeup is needed. The Start
-		 * Transfer command will initiate the link recovery.
-		 */
-		link_state = dwc3_gadget_get_link_state(dwc);
-		switch (link_state) {
-		case DWC3_LINK_STATE_U2:
-			if (dwc->gadget->speed >= USB_SPEED_SUPER)
-				break;
-
-			fallthrough;
-		case DWC3_LINK_STATE_U3:
-			ret = __dwc3_gadget_wakeup(dwc, false);
-			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
-					ret);
-			break;
-		}
-	}
-
 	/*
 	 * For some commands such as Update Transfer command, DEPCMDPARn
 	 * registers are reserved. Since the driver often sends Update Transfer
-- 
2.53.0

