Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0E606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eH4LkUxL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWlVRcaE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70720606EC;
	Mon,  9 Nov 2026 17:29:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8e22d43aDnOD; Mon,  9 Nov 2026 17:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A77BC607F0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245350;
	b=Fl3VnK0KZ+WBpEaFnhRL5a3ucsOt6Ap3UoqAydLe9Uw8LNWgNKzRLwydR62VV9NTRptC
	 SMKE1dYCYsKCaa9TQ0YTtGydIiW/eLXp+9+wijI0aMkZyFYl6s2Ug9/yMyTqBd+QL2E06
	 NgOK+U7ZfRl4Z+16AHzwZCwKF45BdU6RV26q77Lf2eMBcy8NvYQYsKFEv8qhqk9NrvVuf
	 +hFoEmKr2KDO5GfHPBU6RbJsm1dU84ONwVUI2QYEsk85GGRPnZP32eb7/4i7TJnYeYPfy
	 QGPQmb5zWQZtwk9DuZuQaFPoy+F6y8ChTVZMpmKAMRBwvwrylM4lscJXV3T88NEtiPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245350;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Fk/cu6gjT14K+HQv0RpJvrVtblN0KumrkC5Gdk8brOg=;
	b=OXhd9AwADjRUx9KDAEADarLnVl1lUrN9jWEoosk7VPBGlp4Qs1yFj+iZkJ3g91xJIurL
	 twkenXF4NKCedFlInFD3borysHAQe8adlLGN+dN+DxlGb98EBoDcuwCzCKH6eNoDdsM4n
	 tboFVDlrXiuWTndsBVXOGpvfGKAYwkmg5tBOfV0Ggu+LCyixticvA9evZSb9vhzoL5xBt
	 qTyCE9uUOevFJwj2BlDZzlQL6gN91uWbM5wpC45A8guw0by7O6NXr2Mf+rZSM8/kBDO/4
	 oGlSH7Igc1PoDgFanyLJAuYodcaMH6bedNNL0UNqr6ZlpxllC/QUxrNBi55wUAxxfSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DWlVRcaE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245350;
	bh=Fk/cu6gjT14K+HQv0RpJvrVtblN0KumrkC5Gdk8brOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eH4LkUxLVcQilxlHFS4A9Lnhbzb+qht3zdsb85bqqqMiaMQpVeiLqvapxHhBwrff/
	 +3EmUpxObVgnmEiAskArvwquEFm9G+mpKNz5bLLWf0SbTqghxcqSWxTkExFifUcgTC
	 A0KzFpdct/VIbzRbTHbjwTCZ9fLKts5kyWu56rlPgsfpK5H4NbUHoR5NdnwJvEoyQz
	 8qJIJUOYQboE88ltjy9fPZri1SiH7mbuO6njparR20s47bbPnW+OdM8zy1EeqqHFbe
	 anTw2dftcLQLnSh/h1Ys4/tLVDom9sBkRgAWC043Wz9ljvhW340yflCGJkpt1xikRZ
	 SurJZb6XS5zgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A77BC607F0;
	Mon,  9 Nov 2026 17:29:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9B0A20B0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFA16607F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdbA5B43F_tt for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B0F64606EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=DWlVRcaE
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0F64606EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:08 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so769916f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245346; x=1794850146;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Fk/cu6gjT14K+HQv0RpJvrVtblN0KumrkC5Gdk8brOg=;
 b=DWlVRcaEUFuGlWpLJdV02/2LWGtkoXcF0BpSsxhOIK1VyBt8r3WRmPMXoMEYVJVSu4
 6Qx9mK7N6aekuoqeYY09ClMkodlxT7w6YqdELeAqGpniocfthMGqsgaoZfC6nOX7RQQp
 hsQr5TSmJ/HEgbwq+iQSUeBE6NMDx8On1Psio9UNtxu08gQKBTREcicIDnMLtM98Bt5x
 m+FdFnnprMnt8EDjmdA57GDeWzkZ/R4MQGSxA4qlLWM2w6ogxz06xg65gNeBI969m/5z
 JZKkU0HSZJc/s9Tf/xeaH02X4lUjRJPaNYfGhxw/2FLeW1NqAEOWwXApcoo4mrEc9rlD
 g1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245346; x=1794850146;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fk/cu6gjT14K+HQv0RpJvrVtblN0KumrkC5Gdk8brOg=;
 b=R+wpFw2z4KQyS32BEmYzXfRvlKH6h1TqexHww3BfsRX/Jw2aRcFl2CZXahfkNKGxo8
 Vh/FVhusRw6p4wFNyUIoSpGShnTg0bZ9CXluOBIxbwBwjIu17RcKOTYTuWpLSmms5ETP
 NpX9yx4zMNgzaiC78lOJja+yQ+9OUQKQLE4a5NcefzQI7+OVB6PHo4Mgt4nOmbE9EfEZ
 gmq8iUmVt/YU+TcNxmpbscNbaL/ZEiKiC0sa/7BGlyCbH98ZLw6RsxJdu1muY0FZ1beN
 Kdy4fdBVCnOUgDumJgBSyc1vtPN0bxNp9QtprS0eXbW81H+MAsYoXrxV2seAlrpuJc0q
 u1+Q==
X-Gm-Message-State: APuU4Z8X7MP75Qy65/0/PHlbtMP0dsQW0BjlwVENxifYdkwIck9CU+Mu
 iu1xUC3d6zpgJvNQqe4eerHf4zgvcBqfGGv4cI1+1tpU7/pPzcDWa0lqf5q3+NBje4o=
X-Gm-Gg: AYBFou3Mgjqms76+RKXSiJ8qiv31nUp6av/NLxBA9LYnaHczoDydyOx7hk4/vcGkYEs
 +Ybkn0LTlYR/cfR+X07qIMVdvaT6kK9z04DSQwivuhTNsfIA5VpoJbYJrGO9MYXW1K3oy7B8B+n
 0ON52qvcpX34TihRmvXSyvq7vtT5oG8hSpBsw7+xOoWgDePHEgYmQ13vlKtiZcCrc+gLKupF/Gc
 +GNAtxCdSymrnj2e/vLb1s/7iWC9EWsYjgWuJg3skwpA3z/t1uoFBaMQxRUsM9fdhHziPMqN3SH
 1Ss4IWHXcPFgq5YXFoe6kY806VbE5z3DIk0TUMkazynSzeM7mnaz7l0BM3Z6Livkdogv15yJ4hD
 Y9D0qC4qFZI0LA66bVKYU0Q9P+iulNn/iUaIpWEutGo4cAO9I2sDNo3tCIRa7Atb0okJLLmH3HJ
 IeT+oOft2GgtdQFKamG5FPVcMhoRDq1YpxtvYKVJnqnLBP59uWWh9F7mxuFVYfL9dM4TjAyzLbN
 frXaa2piJj8aAwddZKCTj46abkFzypXuiZBKdtnXBZTloVyqzfnVy3d8vz6YOiwg4FBKM7EVZgQ
 4pVwfU5Gg5GWzhgqf6CuwOVQJA45JDo=
X-Received: by 2002:a5d:64e4:0:b0:48c:6fa4:fc89 with SMTP id
 ffacd0b85a97d-4982f77ec94mr278251f8f.12.1794245346132; 
 Mon, 09 Nov 2026 09:29:06 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983284c99bsm176251f8f.7.2026.11.09.09.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:05 -0800 (PST)
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
Subject: [PATCH 02/11] video: Check that the mode fits in the reserved frame
 buffer
Date: Mon, 09 Nov 2026 17:29:04 +0000
Message-ID: <9f6b44af-cfdc-49ae-8d90-11b7dcdd1a48@gmail.com>
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

The video uclass reserves plat->size bytes for the frame buffer of each
video device when it is bound, but many drivers only learn the mode
when the device is probed, some of them from the display's EDID
(rk_vop, sunxi DE2 and the Tegra drivers). video_post_probe() works out
the frame buffer size from that mode and clears the frame buffer, and
the console then draws on it, without checking it against the
reservation. A display announcing a larger mode than the driver allows
for makes U-Boot write past the reserved memory, into the memory
reserved above it, which on ARM holds the MMU page tables.

Refuse to probe a video device whose frame buffer is larger than the
memory reserved for it. The following patches have the drivers skip
such modes, so that a smaller one is used instead.

Add a test which grows the sandbox display after its frame buffer has
been reserved.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/video-uclass.c | 12 ++++++++++++
 test/dm/video.c              | 29 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 22183d00d97..68712f6f039 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -640,6 +640,18 @@ static int video_post_probe(struct udevice *dev)
 
 	priv->fb_size = priv->line_length * priv->ysize;
 
+	/*
+	 * The mode can come from the display itself (e.g. its EDID), so check
+	 * that the frame buffer fits in the memory reserved for it before
+	 * anything is drawn
+	 */
+	if (plat->size && priv->fb_size > plat->size) {
+		log_err("Video device '%s': %dx%d needs %#x bytes but only %#x are reserved\n",
+			dev->name, priv->xsize, priv->ysize, priv->fb_size,
+			plat->size);
+		return -ENOSPC;
+	}
+
 	/*
 	 * Set up video handoff fields for passing video blob to next stage
 	 * NOTE:
diff --git a/test/dm/video.c b/test/dm/video.c
index cc854d0e042..8b62ac77657 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -15,6 +15,7 @@
 #include <video_console.h>
 #include <asm/test.h>
 #include <asm/sdl.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
 #include <test/lib.h>
@@ -46,6 +47,34 @@ static int dm_test_video_base(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_video_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test that a mode larger than the reserved frame buffer is refused */
+static int dm_test_video_fb_size(struct unit_test_state *uts)
+{
+	struct video_uc_plat *uc_plat;
+	struct sandbox_sdl_plat *plat;
+	struct udevice *dev;
+	int line_length;
+
+	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
+	ut_assertnonnull(dev);
+	ut_assert(!device_active(dev));
+	uc_plat = dev_get_uclass_plat(dev);
+
+	/*
+	 * Change the mode after the frame buffer has been reserved, as drivers
+	 * do with a mode read from the display, so that it needs one line more
+	 * than the reserved memory holds
+	 */
+	plat = dev_get_plat(dev);
+	line_length = plat->xres * VNBYTES(plat->bpix);
+	plat->yres = uc_plat->size / line_length + 1;
+	ut_asserteq(-ENOSPC, device_probe(dev));
+	ut_assert(!device_active(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_video_fb_size, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 int video_compress_fb(struct unit_test_state *uts, struct udevice *dev,
 		      bool use_copy)
 {
