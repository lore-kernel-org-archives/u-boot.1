Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADE606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XDvXq8eF;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g++Rhake
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F2D4405D2;
	Wed, 28 Oct 2026 14:46:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5X0_Rp_2KGdN; Wed, 28 Oct 2026 14:46:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A716405E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198772;
	b=ATgi0UBpoYOPDPtZxgEoADOCfTOXQNdWH+D45WNF/kJk8coVDOKk3SIOEE+Opz+F3318
	 dCYC4am8izQNIfcyrDRTuh96pcBTqL1puEujuhcBvjA+zIsZrA9oQbPyxX3lTfaj/rTyJ
	 zEoqS8Q1FsIesEMLAn00PeFVNQq26O6xeNeljTGNZlk9236HnpPScvBQR7LYXYBaoqrYn
	 +TeSW3G+lnssL7am3mlppQ9NTWOAPTALiv1sH193YhC+UuLPlyirYLHTUPGaTdjcWKPSh
	 pamoiVdVSx9U8gdXfyYhwQFsRTbtXaQVqpC9F9FuSgzpIoHkBoE0boiLl3dSAgNbfow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
	b=M/+h2kyEAc+QfVk/HrhjdjrPGt/mYneTuYVs5tRP5telxOx0qi3+VPM8w+RMAlxOAvbc
	 aiYWC457uYh36Rb/6iTRv9ILCKbGB9qMmRp99tNB1nnwO1Pgk6A0hyLIwfNDKR4izyeFx
	 ow9tfPpTrTlKjCFkaUZrzGQ2M8jmft8yuads9FCeOVP5+1OKJArN7kDc9foIOrG+84hE6
	 bHeGSPTKIuoQcnIJAxvdmULG830zYlU1By8Ha8LCiwTZH9t2FFZsii88jJWBGTcUUx+vr
	 NXkZfm2mt1WN7tIfKXzDguo0qyfQstf8teHwm6gF+cj4QFyK2v5Od6GvYESZ5OLQ7bw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198772;
	bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XDvXq8eFSurfUTSfpe5EoDSLrszF8H8ZRQyG4vxPwRujrK6QG+8z5pK/7nXXSVN2y
	 izJX1xGziAJ/x8/gntH9kcpykJM95+SYnnzRk0kKDM+Khf4+rUMan1e65bGq2pgKNa
	 TK7hxX8XshBiPrLkjWQhKFydzLQqr3zrPmYMB0xfoUNFOVS2w7oU0MdoUAcdv4xXSB
	 CnTPDpFj9impJggfABWYq39T/JpHb81Wn1+ChlLcZ1E3Dl8fdGVmug2FiaQlJ1yf8+
	 NyEC6x9yp30vF9lXd3hBgmg8IeUUVOM8QHpjatF6ILrdyvc7+F/THSsJu08x2CyR1d
	 IPX3tJ1ZBQ6AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A716405E6;
	Wed, 28 Oct 2026 14:46:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E086D9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C63ED80BDB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fH6U5vJkrlh for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:10:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 51F7D80BA6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196654;
 b=EhFW9RDgngYEnlQ2XQbbu1cqxSfp9l5EGEKr8KaRMexKXJMRxXr1gprjprUCqeSeWiYM
 pkHMfRWKn+B2qWDSblAcdV2w1N6miZwN1OhTwPqYNRravAMI1Fbx23bZE8GZ9nMz3F05i
 Tg7obQz8T0bXTzr91MJjqpmvEgsPLvp2vLg4+eodUf8qJ+P+fNHYok6Pnt0IninL7WeDz
 U/cvgIisk0kziHVzRKxG35BSmBn0ZDQPyr/HPzGJnowYETyD+hI4Aoymbsi4VhiK+YrAW
 1JrE2ZmmF4MqSwp4FZ6SldmVKoV1DKD4ezn6wxzdAl9e35Rr6g/qLkAWhTGg4VkHT9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196654;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
 b=JnavC0lAebx+yjTSqu9fFNVPtQ6lJ+gxRDAkLQIS/JOQteVJZgAHbjog0RkQXOrgSp3p
 blOQ6A27ylB8QZVEUYu3iv1nMz1I+HElKWutDUSdm3HpmdQ0bmW/vNCsIrupKl9bMyUtN
 t635OuqmwfiyJcNdpe30AxdG9WAGmDELPxduA4Fng6Xtr6VUjI+onnCUjrELYc5eF2Frz
 edrcfarftKrNS1lfmWoMyK2GJkD41acHCL+ZVVDj93gZzB08GzxmUNR35l31V1PJsuEdj
 h5MdBk5BKXzn3AzLmE2O3O1EaoN9cDVadcBB/qk+bEVfJY5E3u5Aki9bvtTbbKGiHoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g++Rhake; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=g++Rhake
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51F7D80BA6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:10:53 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c40f5077425so11702766b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196652; x=1793801452;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
 b=g++RhakeOYD7fK/7ixdR1uUZF8QX2QCWWVNzs9XKNMCL2A40f5IbNHLGkYVkhv2Kn4
 dGKZyknYD8iAM8vcsUPlePF1UDFLlVM44+mcC9jIRj44TFv4pTjxq1KTLr5rFym3C0mD
 ErrMWiofWC6WLbaCR2BRVgHtZyVIRplYGDJW+UM5o0oX0iQBj4UZx6BDj1SI4oH2lc11
 HDo7vDdtC3LAjWNItMQSeqcvNWaImFzfO4Egtw6tf/AxFKzBLyQs3bK0h3BwhClnXyTF
 vtQGCGXuFNZ9x8r7xrY5Lw6P0IjNdB6oevth4a65KKa8wFGss5UzGQ0WrqCrGyz5Rgs+
 XXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196652; x=1793801452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T/TQHJVqyqNkgzJtT2kYZ7dmRO5Av+sI0L4cTFBOr1A=;
 b=tPih7z80ej8cIT4576MVuy/UQgcw/Pib0AZ1g3RKXDwgRMA+lMV6DmoU0LU40aFbtJ
 fW+WnVSZYS73DNOL4Nz22Qb51iZcBYTSGTezy4G7Zl1w1bR1lbFF6+ivxTDB9nXWcOW6
 4hjRitmyWrzu3jQDso2OgAPcmsnLfkNTtlHcjg+aR8l8mYf2t2AjbGhNx1a18Eee4idv
 Szhz+Xr1MbTFk/xrJ9fVkUBNvNYiQZ0KGcNh/qHaxolbAIdW9gtXUrnCiL7hfR6vmoNJ
 zMnIuNLrKpdmhHK4RVgoXJzKS0j9u5E4f+ux3XPhP/dYIfFnmdB9BolC+Xui7ArG0vVe
 Wcgw==
X-Gm-Message-State: AFq9FYJJ2l+NsgsTTYF+sz7cppisvZyPM9Nb/A4lCD/Kj23EFAMxlJvv
 k3d5ZvTuQvT+Etnyc6IyHhFZBs7SWYZx8zBtlMya4mYOlQeM3+N0sG7jPJdYInJiJZ1HKRfajdG
 fZGrb
X-Gm-Gg: AYBFou192hNWAxvNO0rWkoDIku2YvsyjGzz6wHPmL5FREcq3s1WYe2gH8WHdK9WuwoK
 bTN/DyFFaOXGORrU1LAeXUxhJ/7YJ9SWQTZYmedi0cHt1U+svuLUsEyWdDLDe6rJpkVN+kYoxPU
 kSv8rQrGmxd0LtLKXLniAQnJn1L7Naqeh9W7B9idRdoToieP6sOQzl8OUk7yQF4MeSjTS6J+2bz
 nN7ETCLYq0q6HBaWpYhLJgBGMgBP4co7A5CuM7PGcMVYn+9Xtheyyxb6oyMYz+szW9Sw3x/DpHK
 GygglfbEYqgHAnRy1qjpRPztccO9VdXglhFuxokVWL66bD4+y0P8Jh+8f3XrxvEs1xgLUtxzBTb
 yBENVdECofnJnJIHqeMunB1/GIJC14PchLFW2uA9A6fnBobFR/EM05BNuFoMa5+dkhuIHkoYXUh
 537pFeG9meQO3N0u3gAc2m4xYs6KONnKJGvYTQw5UNiTUXsOm93Rbk2NZ3wAMHEXeiXv0j6b8qb
 8hcpGBRqoVuaPxgYZDVUyq4kTvdeW2mSI1Fr1JwfCAYunCqV57MgZmqDqR0uJ76eH2RIiCGyXMP
 l8fAXLDsZO/G2OFHtakWnNnn5p2kjiy6XfAshG2aya3lmam9xWT21en9IwX21u4+rO6LAuZd7BL
 H5Rvy3x8tqQ==
X-Received: by 2002:a17:906:584:b0:c41:8e21:4d62 with SMTP id
 a640c23a62f3a-c49bdd71afdmr213155666b.1.1793196651596; 
 Wed, 28 Oct 2026 07:10:51 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64f8c4sm617944566b.47.2026.10.28.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:10:51 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 10/63] usb: dwc3: import from kernel v4.6
Date: Wed, 28 Oct 2026 15:08:36 +0100
Message-ID: <20261028140930.3025368-11-anders.roxell@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.5 to v4.6.

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

List of commits: git log --oneline v4.5..v4.6
Commits imported:
9772b47a4c29 usb: dwc3: gadget: Fix suspend/resume during device mode
5c4ad318de3b usb: dwc3: core: fix PHY handling during suspend
e901aa159dac usb: dwc3: gadget: fix endpoint renaming
ad14d4e0308a usb: dwc3: gadget: release spin lock during gadget resume
f59dcab17629 usb: dwc3: core: improve reset sequence
77966eb85e6d usb: dwc3: Validate the maximum_speed parameter
7580862b3e80 usb: dwc3: Enable SuperSpeedPlus
2c7f1bd9127a usb: dwc3: Update maximum_speed for SuperSpeedPlus
ee5cd41c9117 usb: dwc3: Update speed checks for SuperSpeedPlus
1f38f88a24c8 usb: dwc3: Update register fields for SuperSpeedPlus
c4137a9c841e usb: dwc3: DWC_usb31 controller check

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   | 102 +++++++++++++++++++++++++-------------
 drivers/usb/dwc3/core.h   |  11 +++-
 drivers/usb/dwc3/ep0.c    |   9 ++--
 drivers/usb/dwc3/gadget.c |  47 ++++++++++++++----
 4 files changed, 119 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de5e01f41bc2..34277ced26bd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -67,23 +67,9 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
+	int		retries = 1000;
 	int		ret;
 
-	/* Before Resetting PHY, put Core in Reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-	/* Assert USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-
-	/* Assert USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
@@ -95,26 +81,28 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 		phy_exit(dwc->usb2_generic_phy);
 		return ret;
 	}
-	mdelay(100);
 
-	/* Clear USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	/*
+	 * We're resetting only the device side because, if we're in host mode,
+	 * XHCI driver will reset the host block. If dwc3 was configured for
+	 * host-only mode, then we can return early.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST)
+		return 0;
 
-	/* Clear USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg |= DWC3_DCTL_CSFTRST;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
-	mdelay(100);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			return 0;
 
-	/* After PHYs are stable we can take Core out of reset state */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+		udelay(1);
+	} while (--retries);
 
-	return 0;
+	return -ETIMEDOUT;
 }
 
 /**
@@ -962,10 +950,6 @@ static int dwc3_probe(struct platform_device *pdev)
 		fladj = pdata->fladj_value;
 	}
 
-	/* default to superspeed if no maximum_speed passed */
-	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1016,6 +1000,33 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Check the maximum_speed parameter */
+	switch (dwc->maximum_speed) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
+		break;
+	default:
+		dev_err(dev, "invalid maximum_speed parameter %d\n",
+			dwc->maximum_speed);
+		/* fall through */
+	case USB_SPEED_UNKNOWN:
+		/* default to superspeed */
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+		/*
+		 * default to superspeed plus if we are capable.
+		 */
+		if (dwc3_is_usb31(dwc) &&
+		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
+		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+
+		break;
+	}
+
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc, fladj);
 
@@ -1139,6 +1150,11 @@ static int dwc3_suspend(struct device *dev)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	WARN_ON(phy_power_off(dwc->usb2_generic_phy) < 0);
+	WARN_ON(phy_power_off(dwc->usb3_generic_phy) < 0);
+
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1152,11 +1168,21 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_usb2phy_power;
+
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
 	if (ret < 0)
-		return ret;
+		goto err_usb3phy_power;
 
 	ret = phy_init(dwc->usb3_generic_phy);
 	if (ret < 0)
@@ -1189,6 +1215,12 @@ static int dwc3_resume(struct device *dev)
 err_usb2phy_init:
 	phy_exit(dwc->usb2_generic_phy);
 
+err_usb3phy_power:
+	phy_power_off(dwc->usb3_generic_phy);
+
+err_usb2phy_power:
+	phy_power_off(dwc->usb2_generic_phy);
+
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e4f8b90d9627..6254b2ff9080 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -223,7 +223,8 @@
 /* Global HWPARAMS3 Register */
 #define DWC3_GHWPARAMS3_SSPHY_IFC(n)		((n) & 3)
 #define DWC3_GHWPARAMS3_SSPHY_IFC_DIS		0
-#define DWC3_GHWPARAMS3_SSPHY_IFC_ENA		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN1		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN2		2 /* DWC_usb31 only */
 #define DWC3_GHWPARAMS3_HSPHY_IFC(n)		(((n) & (3 << 2)) >> 2)
 #define DWC3_GHWPARAMS3_HSPHY_IFC_DIS		0
 #define DWC3_GHWPARAMS3_HSPHY_IFC_UTMI		1
@@ -249,6 +250,7 @@
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
 
 #define DWC3_DCFG_SPEED_MASK	(7 << 0)
+#define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
 #define DWC3_DCFG_FULLSPEED2	(1 << 0)
@@ -339,6 +341,7 @@
 
 #define DWC3_DSTS_CONNECTSPD		(7 << 0)
 
+#define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
 #define DWC3_DSTS_FULLSPEED2		(1 << 0)
@@ -1024,6 +1027,12 @@ struct dwc3_gadget_ep_cmd_params {
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
 
+/* check whether we are on the DWC_usb31 core */
+static inline bool dwc3_is_usb31(struct dwc3 *dwc)
+{
+	return !!(dwc->revision & DWC3_REVISION_IS_DWC31);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8d6b75c2f53b..eca2e6d8e041 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -356,7 +356,8 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 */
 		usb_status |= dwc->gadget.is_selfpowered;
 
-		if (dwc->speed == DWC3_DSTS_SUPERSPEED) {
+		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
+		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 			if (reg & DWC3_DCTL_INITU1ENA)
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
@@ -426,7 +427,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 		case USB_DEVICE_U1_ENABLE:
 			if (state != USB_STATE_CONFIGURED)
 				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
+			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 				return -EINVAL;
 
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -440,7 +442,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 		case USB_DEVICE_U2_ENABLE:
 			if (state != USB_STATE_CONFIGURED)
 				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
+			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 				return -EINVAL;
 
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2363bad45af8..8e4a1b195e9b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -463,7 +463,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget.speed == USB_SPEED_SUPER) {
+	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst - 1;
 
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst);
@@ -568,7 +568,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
 		if (!usb_endpoint_xfer_isoc(desc))
-			return 0;
+			goto out;
 
 		/* Link TRB for ISOC. The HWO bit is never reset */
 		trb_st_hw = &dep->trb_pool[0];
@@ -582,9 +582,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+out:
 	switch (usb_endpoint_type(desc)) {
 	case USB_ENDPOINT_XFER_CONTROL:
-		strlcat(dep->name, "-control", sizeof(dep->name));
+		/* don't change name */
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		strlcat(dep->name, "-isoc", sizeof(dep->name));
@@ -1441,7 +1442,8 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
 	speed = reg & DWC3_DSTS_CONNECTSPD;
-	if (speed == DWC3_DSTS_SUPERSPEED) {
+	if ((speed == DWC3_DSTS_SUPERSPEED) ||
+	    (speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
 		ret = -EINVAL;
 		goto out;
@@ -1666,10 +1668,16 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		case USB_SPEED_HIGH:
 			reg |= DWC3_DSTS_HIGHSPEED;
 			break;
-		case USB_SPEED_SUPER:	/* FALLTHROUGH */
-		case USB_SPEED_UNKNOWN:	/* FALTHROUGH */
+		case USB_SPEED_SUPER_PLUS:
+			reg |= DWC3_DSTS_SUPERSPEED_PLUS;
+			break;
 		default:
-			reg |= DWC3_DSTS_SUPERSPEED;
+			dev_err(dwc->dev, "invalid dwc->maximum_speed (%d)\n",
+				dwc->maximum_speed);
+			/* fall through */
+		case USB_SPEED_SUPER:
+			reg |= DWC3_DCFG_SUPERSPEED;
+			break;
 		}
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2340,7 +2348,8 @@ static void dwc3_update_ram_clk_sel(struct dwc3 *dwc, u32 speed)
 	 * this. Maybe it becomes part of the power saving plan.
 	 */
 
-	if (speed != DWC3_DSTS_SUPERSPEED)
+	if ((speed != DWC3_DSTS_SUPERSPEED) &&
+	    (speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return;
 
 	/*
@@ -2369,6 +2378,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	dwc3_update_ram_clk_sel(dwc, speed);
 
 	switch (speed) {
+	case DWC3_DCFG_SUPERSPEED_PLUS:
+		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
+		break;
 	case DWC3_DCFG_SUPERSPEED:
 		/*
 		 * WORKAROUND: DWC3 revisions <1.90a have an issue which
@@ -2410,8 +2424,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 	/* Enable USB2 LPM Capability */
 
-	if ((dwc->revision > DWC3_REVISION_194A)
-			&& (speed != DWC3_DCFG_SUPERSPEED)) {
+	if ((dwc->revision > DWC3_REVISION_194A) &&
+	    (speed != DWC3_DCFG_SUPERSPEED) &&
+	    (speed != DWC3_DCFG_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 		reg |= DWC3_DCFG_LPM_CAP;
 		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2473,7 +2488,11 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	dwc->gadget_driver->resume(&dwc->gadget);
+	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+		spin_unlock(&dwc->lock);
+		dwc->gadget_driver->resume(&dwc->gadget);
+		spin_lock(&dwc->lock);
+	}
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -2917,6 +2936,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	if (!dwc->gadget_driver)
+		return 0;
+
 	if (dwc->pullups_connected) {
 		dwc3_gadget_disable_irq(dwc);
 		dwc3_gadget_run_stop(dwc, true, true);
@@ -2935,6 +2957,9 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
-- 
2.53.0

