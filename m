Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E783606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SUax26gw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EzY45mcN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C06581215;
	Wed, 28 Oct 2026 14:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8N0cBtsR77wP; Wed, 28 Oct 2026 14:47:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AB36B810D8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198814;
	b=eDNECKe3PFV8gHSn+WaU5Pozq10KXAkflbvjRp9tlf8FxaPlgxauQxt/NK4CIAlV3kG7
	 awrhuJKmiUM1Rh8qr4B97QOX9pN3Z5brPJsT5xsd0/Ax8Jn9sr/k7GKvFeoxo+BmQ1xqq
	 LDNIZpDSMyzlnNV0lvqY1KugV5xx9LqSisM4wl8p/X4s0qxLhaJip/lGedO1Bw1ZMTUTe
	 0UkBhLs4yggAq8/GMho9+LQ46RQsMOlKrNYnhwhllQ3oPbWQDcQ+vXXoUZNwM54N1Y3+G
	 A76FGTlU9jRmLxU7d5O962fIdmueutmCYFUo+qzFduUiM/E3Mj8Y14uYuUDh+7hCBRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198814;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
	b=NkwOy9M12OB4hA3gT8OhLxj57JWeVJOJj98Ko4XnKT55J5jymbolFCcueU5O+Jjt9bIY
	 gYtAzj38Xr1MKmZcgrIt7jbxZgXTAEdBo2b7la8RSElNlILZ7EmWCaPPRGOUmob/b4YmQ
	 M7G764SLuKsJYgvwUuDVW7/eNZPugHI8qirsKNn6m9kqKKF55yIkhMAIrQmnWwu5DsNrY
	 lEjNOmvIkUShRraztg9wYjzo6OF8yU0i1+hlXKFVEXDaDQWE5T/3hAU8xNAdO1YuGHgoi
	 1p2gaKErirrL1TZUshFCbi+Aozg3HETkAKUIe+h7Zp9GluZUDk8GNxUX2aCsZrSOWXw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198814;
	bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SUax26gwKnz51YGmUUWI04wkCd+vF5Pu+bcTjxAvDTTXl5xenEfFZBIxoTaU3oMis
	 7dArS/GJLn+V6zZA0K4HYIZ2wNndJ/55tG4XgJGKq/uYviWqMBfMf0iYrTqy/4Tv1r
	 ug9La/OysTLLFwYs/Ab7IO02j89ybd+hBeUNfn/cU0/MqrmUDX1NAtxgVzpVf3MpjU
	 1C8vqE964cxP8WHVRulMLYXbtGrrGk0dSdFEJYFwqIFJj+dtSfPcTIH1zRJq8iHJHl
	 +8ea04Rg6FrVY1z0rq93/SbjbO/gKz8uldxGNeQcpc/Qtzd6Uq5mxq8LW92q/Tkgyo
	 pHeCDS1Zlr/cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB36B810D8;
	Wed, 28 Oct 2026 14:46:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ECA21235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEAD4605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hK52PR2rU0Bi for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 86220605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196748;
 b=KGbsjECA43YEnW7VSMYzBiUdJC5wg9OlJcL4uK3q/9m5nvLGmYpKakq3um/CEwqBmpNc
 jsLOARNkb0KEGOapYQJ+Y5eucU/Frqjky7MLowIIxTJrQ5YyMMts+EzkpuOCARUEJe4GW
 D24SXdUXmlmdlVUrvlFFawwm9Tw43ZT3RoQn3dAbi1b5x8XV0xMxxhZtNl95oVWbWVn6F
 mgbNn3YBAWVZhuUXsJnOLWHq0+BmUAjLCNW3djcGdv6MAKTWotu13ui6OlEC2DnzBSLuC
 VEkgFKJ1sMDF/fF/uIieqEHg71oiCr1dTaJyRWgQh2CYzhet9eFX+f0VwgIJKoWTlGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196748;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
 b=CYdlVN+C5MreTjNqjmnrQnoQajTh5wWRUPBFo5H/4SLHR93pYq32No6T8TRNrJKSigoP
 cSNf3p3i4dfjhK/3SyTKCvoXUXGuB+9C3s8oUEmO8dWUd/MO+dCaX1Yc3E9K6zmXJBmOh
 bTh/5wpyVhdBahsKczsO9DBHrOyAo/Hq26mhTQAf8PpsYf0/cXP0rNGArNUrDDyjUe2ih
 Ds1ZAdbfgIZZgqUuKfNTD62nBac5w628nGnJNz1JXvY8W1KGLjXa1ezhok2+D9Jd7X71D
 Ok9+IEUuWgf5i8j4+LQf8vr40yImz1B3DPBDwSNjvVKPceDhck+FLlmB9eeJ4raJDkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EzY45mcN; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=EzY45mcN
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86220605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:26 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c499e0e43a9so13373066b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196745; x=1793801545;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
 b=EzY45mcNgiyCsBul11JCc5CB+hM2p3pBao3J22Ne4rrvsZhd7ggBfy5Vm53B1+ycXv
 1A/zs317vE4jlwBlvUm0aORNektuQCRvL2up7Ej4U62IXgjctzyFyFAsszHxa1mCbj5h
 JZX7D/A1NK4BPRjgd4obGhUYlxaIq+nvyF4S/wz4Sqz5i3oqhjNmYlVdg2eOi0q2RyqB
 o2bydFERaZLJYYzLRyPfvEZ1nuFqs1uZWt0UvxM4LOpI33cKeaTcpqcltP1bQdsVjSLr
 eURPstjIFxCOz1spRNU5s/e/ibhDXYemFVzKyU5fXvGirCw0/kzU3WOWqYEHv9mnrhTV
 xSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196745; x=1793801545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=23pfFLqJWnB3No+/wCGklZnciLzFWFIzD7FXqwFrMDk=;
 b=FEcnr5NepqStmktWu+yaB6Noo8boSKgg4Q2PnxcrQ/bgcf51C/tQRKoGfIHJcXxlSj
 vDHy8RVcuaEtFPhxU1JJcZ5N9HzKKJc7K+1EoKkI2dcnC3+t90zW39baHbb6Xu0i9z7a
 RPje6I2GuwYw40EAe6l379oouyDlN6Icv0gs+aZHFjAjIDEYSfKQ39FvD3C2SoDkOVc4
 jveMlrT1G/mjXI4Xll3XdyCVZPc+Qa+t5QiYpwI+o7/5Z6j/D1cwB4IXMLvIxsyjS/oM
 6UhJHkq9xAt7tk6dT8nxLh+KoBegdgcZ7Lzsi1RjNMC50XFJ7z9scR7Msxmgn6K6DIkM
 9SYA==
X-Gm-Message-State: AFq9FYIDiQGTyaatw5Ejmicr2KxwfB4GghMxXAneHiczyBM3BqMdWrsO
 hN7fIEGYzDNFXX6eyumnkNMZ4NzgJwdGaZvOvlEa/K0kgS4dTPKays6fRY0orJmOJIGE5acWU6O
 YL4co
X-Gm-Gg: AYBFou2GVNQK2/kadMX1EH4PRPeimkhmJqYg4GtlJjR8+kgDHPSIBDWBCqr9s9sIMKV
 4g+yZSdjLMg66M8Qdid25u0qDGZuRf3ApQIgDXNJ03mFewIBZwaXBd8+1HPVLcexs2jFBnGOylR
 BkamnbumA1iXwzK/M2ywRJGp0JAiZBm6+V0Bxk+jhTLAjSf8WT0wtzMTmADvYXzmOLfCGLMDYl5
 chKM5Oxma7GLat5cfn9qFWa2jumu7pmC/vh+EJ60taLRsRjCOYZ4rK/LP7sDIcsVYA7wSZTT9oa
 JvpXvTPqbNoHOreiia9D+TGGkuhXGH8Y9QbX1c3UJvmmBMi4RbF8d/6ocOELbP1aCoPHRtSDVdz
 naJ5Tnb/NLussO4o0m4q7YxRzdZGr6FcUS6qZAzj5LCLBJ6oxJvfxinnmnWykQPhqbxZhLvblSx
 r7NZYNX1UdQuEn+2ZT0c0YeG5g6QtTKnkF8loJqx7bw4tWWtcrHSgOSZyZLC6tKKRYcoyP3pMiH
 hQaw7L6P1iudCvtaj/4sGF0i041gY2Mx1Ol4U0jttBnzaMP04UJzDS6Ijudz7Mq5mHuSLHxhi6k
 gqvYaYiK8IM3z2cPs4qd3CRiofbd1zkAA43/eEvi7EokCO6mdMfSHAAix/UlxSmHmlz0XiE8GXm
 YvwcD3/3N+A==
X-Received: by 2002:a17:906:5192:10b0:c40:5ee3:8694 with SMTP id
 a640c23a62f3a-c49bdee7e16mr261532466b.4.1793196744873; 
 Wed, 28 Oct 2026 07:12:24 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:24 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 32/63] usb: dwc3: import from kernel v5.7
Date: Wed, 28 Oct 2026 15:08:58 +0100
Message-ID: <20261028140930.3025368-33-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.6 to v5.7.

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

List of commits: git log --oneline v5.6..v5.7
Commits imported:
00e21763f2c8 dwc3: Remove check for HWO flag in dwc3_gadget_ep_reclaim_trb_sg()
49e0590e3a60 usb: dwc3: gadget: Fix request completion check
d0550cd20e52 usb: dwc3: gadget: Do link recovery for SS and SSP
d94ea5319813 usb: dwc3: gadget: Properly set maxpacket limit
586f4335700f usb: dwc3: Fix GTXFIFOSIZ.TXFDEP macro name
0227cc84c444 usb: dwc3: core: don't do suspend for device mode if already suspended
4a1d042af420 usb: dwc3: Rework resets initialization to be more flexible
0d3a97083e0c usb: dwc3: Rework clock initialization to be more flexible
98ed256a4dba usb: dwc3: Add support for role-switch-default-mode binding
8a0a13799744 usb: dwc3: Registering a role switch in the DRD code.
7ba6b09fda5e usb: dwc3: core: add support for disabling SS instances in park mode
2dedea035ae8 usb: dwc3: gadget: Wrap around when skip TRBs
a114c4ca64bd usb: dwc3: gadget: Don't clear flags before transfer ended

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 29 ++++++-------
 drivers/usb/dwc3/core.h   | 18 ++++++++-
 drivers/usb/dwc3/gadget.c | 85 ++++++++++++++++++++++-----------------
 3 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1d85c42b9c67..edc17155cb2b 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -289,12 +289,6 @@ done:
 	return 0;
 }
 
-static const struct clk_bulk_data dwc3_core_clks[] = {
-	{ .id = "ref" },
-	{ .id = "bus_early" },
-	{ .id = "suspend" },
-};
-
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -1029,6 +1023,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->dis_tx_ipgap_linecheck_quirk)
 			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
 
+		if (dwc->parkmode_disable_ss_quirk)
+			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -1342,6 +1339,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-del-phy-power-chg-quirk");
 	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
 				"snps,dis-tx-ipgap-linecheck-quirk");
+	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
+				"snps,parkmode-disable-ss-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -1441,11 +1440,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
-	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
-				 GFP_KERNEL);
-	if (!dwc->clks)
-		return -ENOMEM;
-
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1476,22 +1470,23 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	dwc->reset = devm_reset_control_array_get(dev, true, true);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
 
 	if (dev->of_node) {
-		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
-
-		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get_all(dev, &dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
 		 * Clocks are optional, but new DT platforms should support all
 		 * clocks as required by the DT-binding.
 		 */
-		if (ret)
+		if (ret < 0)
 			dwc->num_clks = 0;
+		else
+			dwc->num_clks = ret;
+
 	}
 
 	ret = reset_control_deassert(dwc->reset);
@@ -1637,6 +1632,8 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
+		if (pm_runtime_suspended(dwc->dev))
+			break;
 		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 77c4a9abe365..4c171a8e215f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -25,6 +25,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/usb/role.h>
 #include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
@@ -249,6 +250,7 @@
 #define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
 
 /* Global User Control 1 Register */
+#define DWC3_GUCTL1_PARKMODE_DISABLE_SS	BIT(17)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
@@ -305,10 +307,14 @@
 
 /* Global TX Fifo Size Register */
 #define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
-#define DWC31_GTXFIFOSIZ_TXFDEF(n)	((n) & 0x7fff)	/* DWC_usb31 only */
-#define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
+#define DWC31_GTXFIFOSIZ_TXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GTXFIFOSIZ_TXFDEP(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
+/* Global RX Fifo Size Register */
+#define DWC31_GRXFIFOSIZ_RXFDEP(n)	((n) & 0x7fff)	/* DWC_usb31 only */
+#define DWC3_GRXFIFOSIZ_RXFDEP(n)	((n) & 0xffff)
+
 /* Global Event Size Registers */
 #define DWC3_GEVNTSIZ_INTMASK		BIT(31)
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
@@ -953,6 +959,9 @@ struct dwc3_scratchpad_array {
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
+ * @role_sw: usb_role_switch handle
+ * @role_switch_default_mode: default operation mode of controller while
+ *			usb role is USB_ROLE_NONE.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -1024,6 +1033,8 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
+ * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
+ *			instances in park mode.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -1086,6 +1097,8 @@ struct dwc3 {
 	struct extcon_dev	*edev;
 	struct notifier_block	edev_nb;
 	enum usb_phy_interface	hsphy_mode;
+	struct usb_role_switch	*role_sw;
+	enum usb_dr_mode	role_switch_default_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
@@ -1215,6 +1228,7 @@ struct dwc3 {
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
+	unsigned		parkmode_disable_ss_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1e00bf2d65a2..585cb3deea7a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1521,7 +1521,7 @@ static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *r
 	for (i = 0; i < req->num_trbs; i++) {
 		struct dwc3_trb *trb;
 
-		trb = req->trb + i;
+		trb = &dep->trb_pool[dep->trb_dequeue];
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		dwc3_ep_inc_deq(dep);
 	}
@@ -1728,7 +1728,6 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	u32			reg;
 
 	u8			link_state;
-	u8			speed;
 
 	/*
 	 * According to the Databook Remote wakeup request should
@@ -1738,16 +1737,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 	 */
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
-	speed = reg & DWC3_DSTS_CONNECTSPD;
-	if ((speed == DWC3_DSTS_SUPERSPEED) ||
-	    (speed == DWC3_DSTS_SUPERSPEED_PLUS))
-		return 0;
-
 	link_state = DWC3_DSTS_USBLNKST(reg);
 
 	switch (link_state) {
+	case DWC3_LINK_STATE_RESET:
 	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
+	case DWC3_LINK_STATE_RESUME:
 		break;
 	default:
 		return -EINVAL;
@@ -2227,7 +2223,6 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
 	int mdwidth;
-	int kbytes;
 	int size;
 
 	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
@@ -2236,24 +2231,24 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 
 	size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1));
 	if (dwc3_is_usb31(dwc))
-		size = DWC31_GTXFIFOSIZ_TXFDEF(size);
+		size = DWC31_GTXFIFOSIZ_TXFDEP(size);
 	else
-		size = DWC3_GTXFIFOSIZ_TXFDEF(size);
+		size = DWC3_GTXFIFOSIZ_TXFDEP(size);
 
 	/* FIFO Depth is in MDWDITH bytes. Multiply */
 	size *= mdwidth;
 
-	kbytes = size / 1024;
-	if (kbytes == 0)
-		kbytes = 1;
-
 	/*
-	 * FIFO sizes account an extra MDWIDTH * (kbytes + 1) bytes for
-	 * internal overhead. We don't really know how these are used,
-	 * but documentation say it exists.
+	 * To meet performance requirement, a minimum TxFIFO size of 3x
+	 * MaxPacketSize is recommended for endpoints that support burst and a
+	 * minimum TxFIFO size of 2x MaxPacketSize for endpoints that don't
+	 * support burst. Use those numbers and we can calculate the max packet
+	 * limit as below.
 	 */
-	size -= mdwidth * (kbytes + 1);
-	size /= kbytes;
+	if (dwc->maximum_speed >= USB_SPEED_SUPER)
+		size /= 3;
+	else
+		size /= 2;
 
 	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
@@ -2271,8 +2266,39 @@ static int dwc3_gadget_init_in_endpoint(struct dwc3_ep *dep)
 static int dwc3_gadget_init_out_endpoint(struct dwc3_ep *dep)
 {
 	struct dwc3 *dwc = dep->dwc;
+	int mdwidth;
+	int size;
+
+	mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
 
-	usb_ep_set_maxpacket_limit(&dep->endpoint, 1024);
+	/* MDWIDTH is represented in bits, convert to bytes */
+	mdwidth /= 8;
+
+	/* All OUT endpoints share a single RxFIFO space */
+	size = dwc3_readl(dwc->regs, DWC3_GRXFIFOSIZ(0));
+	if (dwc3_is_usb31(dwc))
+		size = DWC31_GRXFIFOSIZ_RXFDEP(size);
+	else
+		size = DWC3_GRXFIFOSIZ_RXFDEP(size);
+
+	/* FIFO depth is in MDWDITH bytes */
+	size *= mdwidth;
+
+	/*
+	 * To meet performance requirement, a minimum recommended RxFIFO size
+	 * is defined as follow:
+	 * RxFIFO size >= (3 x MaxPacketSize) +
+	 * (3 x 8 bytes setup packets size) + (16 bytes clock crossing margin)
+	 *
+	 * Then calculate the max packet limit as below.
+	 */
+	size -= (3 * 8) + 16;
+	if (size < 0)
+		size = 0;
+	else
+		size /= 3;
+
+	usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 	dep->endpoint.max_streams = 15;
 	dep->endpoint.ops = &dwc3_gadget_ep_ops;
 	list_add_tail(&dep->endpoint.ep_list,
@@ -2457,9 +2483,6 @@ static int dwc3_gadget_ep_reclaim_trb_sg(struct dwc3_ep *dep,
 	for_each_sg(sg, s, pending, i) {
 		trb = &dep->trb_pool[dep->trb_dequeue];
 
-		if (trb->ctrl & DWC3_TRB_CTRL_HWO)
-			break;
-
 		req->sg = sg_next(s);
 		req->num_pending_sgs--;
 
@@ -2484,14 +2507,7 @@ static int dwc3_gadget_ep_reclaim_trb_linear(struct dwc3_ep *dep,
 
 static bool dwc3_gadget_ep_request_completed(struct dwc3_request *req)
 {
-	/*
-	 * For OUT direction, host may send less than the setup
-	 * length. Return true for all OUT requests.
-	 */
-	if (!req->direction)
-		return true;
-
-	return req->request.actual == req->request.length;
+	return req->num_pending_sgs == 0;
 }
 
 static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
@@ -2515,8 +2531,7 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 
 	req->request.actual = req->request.length - req->remaining;
 
-	if (!dwc3_gadget_ep_request_completed(req) ||
-			req->num_pending_sgs) {
+	if (!dwc3_gadget_ep_request_completed(req)) {
 		__dwc3_gadget_kick_transfer(dep);
 		goto out;
 	}
@@ -2570,10 +2585,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
-	if (stop) {
+	if (stop)
 		dwc3_stop_active_transfer(dep, true, true);
-		dep->flags = DWC3_EP_ENABLED;
-	}
 
 	/*
 	 * WORKAROUND: This is the 2nd half of U1/U2 -> U0 workaround.
-- 
2.53.0

