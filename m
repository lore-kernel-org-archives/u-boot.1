Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0107F606A331
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0QqPfpM2;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e3O07bYE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D33AA810D7;
	Mon,  9 Nov 2026 17:29:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vy8r0UUQ29Ub; Mon,  9 Nov 2026 17:29:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 25483810CF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245374;
	b=UWllzEv13MknBqdJHVepCI1+xKWL8NogXBFjq7mx+6usxe0VgUGgzzK/evwmHQLmgOly
	 4nlfTxQfclRTQIcs2YIMBw1UvMOa+AuAVAj+Cve6a/k2Ab6Aq39mIbHpXcCd083bO2lE7
	 mmInpj5ZT153DUSvXwpFfBMcXj34LFmymm2PUdp9nf/HkrNURAdClgEe76XPpV94Ja2vR
	 ULMZJGUybGCpynkXg0j9jVyGCEem8I2cwMnfQQRdUBRRIiaEHtzwxWFnA5EUjcCuW/qvm
	 m+OxmoxPsd9OPVfXj/oCBeUQVg7fD/HhAEJuGzx4X/JLyCuai+3MkGUqoidJKSLWdLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lHjV6vbj/98CEqlbLYofcciWNd5GSj1noxRC3bVOuQI=;
	b=hxnDCm1zL8+4oR1ShQdXNdp+sfGykamZGQ5NQ+enK3BPYIMO0Q+XqOPAKXvg9a3splBi
	 lQfagcqlQwQb5JPName428ZIMS0V9Af7ja8jTuMWO2sFf4pHWMN58cUfZj9PcdLlKUa36
	 O90IGrU+dHk8Kdg3kmB90q7OilCoz9TmrDdkelGhtQdKf/7ce4+GSmPNTKI+Y4d7qWI4Z
	 yEez0y9K8Y3LR7ul0nIGpOKrONhDWAghd14IEzkCzKUw8212U78D6HKwK0W+cfcMhIKj7
	 /VF9/UCinWavCPH9xEeuyMF2n7OJ7w8n//huebhTMRbIMPrjcGOVqBMfPc0Otvlbu1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245374;
	bh=lHjV6vbj/98CEqlbLYofcciWNd5GSj1noxRC3bVOuQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0QqPfpM23ZBl61H6d2BV0zgcq0AOhnrZRvumJk2MzsTj9Cy18vPC2cuzzNkK0FFrz
	 pBNVdRvMY5kxfZDkPpHxN3Iias3/BEZUZUV6WUzfFCIw31z0c7BIegsWvTLLCBe2xF
	 bCzSxbut73hfuVRJHOMRR6Tk0GRCbM7s5jnOsh81SCmHGDGDcloulE1niGr73yzHaa
	 7+6k8cv3CIllJ0Gxo3TgWCb5FO/5OBBU8QEkIbDVA97NNgXEO8pUyIClIV8IF6Mkl5
	 n2N/PwlCS6tTS+GNIyiIGW18z9fJ6hwkH3IQfffEBb8Xn+JL5rQk8hQ0tpCjU6MGtZ
	 z53J7x5cLUi3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25483810CF;
	Mon,  9 Nov 2026 17:29:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB060971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C12D640176
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QITrfgEDFRy9 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C500F40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=e3O07bYE
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C500F40068
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:31 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so828847f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245370; x=1794850170;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lHjV6vbj/98CEqlbLYofcciWNd5GSj1noxRC3bVOuQI=;
 b=e3O07bYE30oO1BDrJOnhsirnCysy6aD2BSctvEXJHcECKHCIxUNiBgtVppxkDU71tf
 DCzCBXjCA1QuMF6Z4faMxqiDEPEAK3Y1MHotOo4Ff8yrErTYqkMrXcjqsjR0kH3NipS6
 6YV8mTDcyO0PXMEfFowTKamP76spilB25oCT5ZGIV4InDaoQKekVSo5Uu7cvkzliNX4c
 Dgf61Liq1RF2TwRGLefdH7TOxTDqAPFMVXgj7ImP9qiIPshpKp340iBbMjnh4wsaTZEq
 r76yJefZDkdXoD5V9h81wud3ZSg8lUKbOp0MDzOsyBJtgEVDRfLOsPssAPOidGlCwY1p
 bVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245370; x=1794850170;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lHjV6vbj/98CEqlbLYofcciWNd5GSj1noxRC3bVOuQI=;
 b=zzII2qxf8HoWL0+y99m92P0ak3NExfVDkFks+U31qlQD8XBdZtmtZIU+J/WE9gHSFM
 zRqlmYBu7LSU40UNt2+wRYWhBFAvHj6PxvMbq/68edzG/0tC534OwG1HAejKzoctowuH
 ERLnlGEJo8z5jbryMqSABzjQnmKpEaWj1Ao4KfNKs7IpWMVkPNRWmnzHQg3vJvAHkQ95
 Kmz9Lx4FmIBv2LpwszGOQasLqIZZqKPKwTrgSQxg3X03ATaSwVEH1/v0YVeOfjIqcdwl
 /43NUuw/Y6Oh0ZPVoWd+woQBT3vEjctfDZYeeRHiUGd8WstqJ3gflGiezZYpIISXmOnF
 kFzw==
X-Gm-Message-State: APuU4Z/vc53M7JVR2qYh4cjhhGWBKw2MduIvFI//CqDb5IMbg2ZH6EOw
 6nYOmYdOegVI6HNuAmOUgHyAicqgj+jaAazLqXnYtm3+uFoLJDTD3fv+zln8JJqSoUE=
X-Gm-Gg: AYBFou31zfNfNUo6VhcqICy0nrg0ED78f40FjjmVT6X+RRG6dsAGSKinDqC8GW1HZNG
 KI2vNp+fkSeqJ3tNSyYJ8SzcwtpLHxrTyh3LSmUOKa9pKNv59ycQdNkojNMBqkUv8gPPp/y4Cx0
 PfNSXCZVL3ozTQ8amWC2Jripsx1KVbzdTtM4qVtUytcpeemBxoGPMFOT0kn7ADPKGUmYPjCLn0W
 lzRrcjOgfRiFY8UQLT8vNLJW9p9fAXD77EQMSCVCspvJy5Wm3a7FYbVKK5vSo16z742JNQBxB0a
 cbpaLHiAcdaCTZPqmKaCtDr4ikwrWLsPlYJ0af+Hn9LXMXT+kyO6Nm1hUS1tznnbg/3hwJ5ddTt
 5BLOkqlTxwBuOPS46EEi0Ow2vqXUzPh8KOR3SJKAf8hlbEUpksuKprzAoG1zPZ1oOMoi8iryuSh
 frCPkKWwoDU2XCuVb3euq8MLlXjYBKsk0oEgWInaRyZZ2aTi7/0A3QhCWhSZkM0ToDCkQ3DBvK2
 Mpw+qytXyj5CLY7Y4b0XMF7p0VwZne6qm8mUVVFAkMAmFnjtKGpWq+bq1fMBKTBTHpkH+ZURVSg
 VVjEeS1zXiYdjMZdVRjGIDnKLD91Rjw=
X-Received: by 2002:a5d:5e03:0:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-49830b9796emr227137f8f.31.1794245369364; 
 Mon, 09 Nov 2026 09:29:29 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm86547f8f.44.2026.11.09.09.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:29 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Subject: [PATCH 05/11] video: rockchip: vop: Tell the display the frame buffer
 size
Date: Mon, 09 Nov 2026 17:29:27 +0000
Message-ID: <fd719611-e1cd-40dc-b99a-213e066f3c7f@gmail.com>
In-Reply-To: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The VOP reserves a frame buffer for CONFIG_VIDEO_ROCKCHIP_MAX_XRES x
CONFIG_VIDEO_ROCKCHIP_MAX_YRES at 32bpp, but takes whatever mode the
eDP, HDMI or MIPI encoder reads from the display. A display announcing
a larger mode makes the frame buffer run past the reserved memory.

Work out the depth before reading the timing and pass it, with the
reserved size, to the display, so that only modes which fit are used.

Fixes: 7b7ad5c31c91 ("rockchip: video: Add a video-output driver")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/rockchip/rk_vop.c | 35 ++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index 17dfe62c9da..ff7f7a7fa79 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -245,6 +245,7 @@ static void rkvop_mode_set(struct udevice *dev,
  */
 static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 {
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	int vop_id, remote_vop_id;
 	struct display_timing timing;
@@ -326,6 +327,22 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 	}
 	debug("vop_id=%d\n", vop_id);
 
+	/* Set bitwidth for vop display according to vop mode */
+	switch (vop_id) {
+	case VOP_MODE_EDP:
+#if defined(CONFIG_ROCKCHIP_RK3288)
+	case VOP_MODE_LVDS:
+#endif
+		l2bpp = VIDEO_BPP16;
+		break;
+	case VOP_MODE_HDMI:
+	case VOP_MODE_MIPI:
+		l2bpp = VIDEO_BPP32;
+		break;
+	default:
+		l2bpp = VIDEO_BPP16;
+	}
+
 	disp_uc_plat = dev_get_uclass_plat(disp);
 	debug("Found device '%s', disp_uc_priv=%p\n", disp->name, disp_uc_plat);
 	if (display_in_use(disp)) {
@@ -335,6 +352,8 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 
 	disp_uc_plat->source_id = remote_vop_id;
 	disp_uc_plat->src_dev = dev;
+	disp_uc_plat->fb_size = plat->size;
+	disp_uc_plat->fb_bpp = 1 << l2bpp;
 
 	ret = device_probe(disp);
 	if (ret) {
@@ -357,22 +376,6 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 		return ret;
 	}
 
-	/* Set bitwidth for vop display according to vop mode */
-	switch (vop_id) {
-	case VOP_MODE_EDP:
-#if defined(CONFIG_ROCKCHIP_RK3288)
-	case VOP_MODE_LVDS:
-#endif
-		l2bpp = VIDEO_BPP16;
-		break;
-	case VOP_MODE_HDMI:
-	case VOP_MODE_MIPI:
-		l2bpp = VIDEO_BPP32;
-		break;
-	default:
-		l2bpp = VIDEO_BPP16;
-	}
-
 	rkvop_mode_set(dev, &timing, vop_id);
 
 	ret = reset_get_by_name(dev, "dclk", &dclk_rst);
