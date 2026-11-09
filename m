Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE297606A330
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0qdcZv2p;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itXvCWtl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B82DE608EA;
	Mon,  9 Nov 2026 17:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 373kAZcfSk7a; Mon,  9 Nov 2026 17:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1165E60907
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245401;
	b=PCKkpjcd0eanyXNpjnnh2SfNCnzuzuef3zyW8gRhhS2TixkN9uC7+NsCWQVeT4H4Bqx8
	 Rn+/8oP7Eb42fFsfpBbXPynJrmX+LPR1ZXzDjOwzIoOgD1IhXQOR1VppQ9U0AfASgv085
	 wV9cCLeXdZSZ5aqP6lmtnOmpCT3EaGgNlIUSoVh3fHK/v+NHP7v187GjcasBHC9j3FnrU
	 tqkCWU8biKvBLQb/jBsSZ6+2lxU2ymK2X22I8xfMtyUSIduK4bBnhffUSBp19FgbkK83q
	 Pde7mVkgrOp9ulNvY8f26qsDFCXd5W0AfFnC94o+UKwyAgv0xe86sXKOyy0X22YEevg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=tgBrfP6h2pNvBnaTnU+xjZoh8lZkO+v+xBbUEmjMQfE=;
	b=dYSAMpghNBPfzXDVxBW0d0XOyfdIIJ+Wei8Cax22MmoZOsYdLldTZXmm/J3iywNq8+qO
	 rJjfBXbtVVkNAwBCF/LI+hEzQ9mw3xeCiy3DFcUy1o2pialQYS95+TGwanBvtLCh3zFHf
	 l3xOV3kY4Gj3VrCkjv66ipF1e3zJazPI9JVBWa08mPxJX1mQrbHI2mowJqKKMWQaoGtps
	 pSSqiC1mxyicsXJQqPlM426upAzNX0tD0qupHM5kTKeoSl4JKrSCjIA1PZlFOZjjB8Wjy
	 nEHn1oKqsTffEGpnA4f1FGv+tW6v9AaOlo8mvtAxVRENlxt0VY0h0EUAUfKcjVE3cdw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=itXvCWtl;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245401;
	bh=tgBrfP6h2pNvBnaTnU+xjZoh8lZkO+v+xBbUEmjMQfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0qdcZv2plxFHhVwtXlrySqZ82Z6ox9UHDy31dUnQ/xMlfL432GL29mLDvGDAjoFja
	 rXXx67Q8MYEcUoPa3kaVL1UuKM6eqQbRW18ahyVlYznEUDdk+zfr0cL7YB1y+BaYVX
	 teuzX+nBk4nBKhfosH06Dv3WUhFKlm6CDxyfzO1daksJJjvhjj4IFv+Hsu7ueAfFBM
	 e7KGKyQR0PGWt7Dc7hTf6oC4D4hyxNeYFVwg8qjdvmsdS5YsB/FjXrIUJlH3k4i5o3
	 eqyGor/yJ2HxYQyYC7bb3NKMqsbgrVUGu9FopHZXIhvvQHRQZJfcN48kUZQZppwyXS
	 DB/PZ+1T3FMPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1165E60907;
	Mon,  9 Nov 2026 17:30:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43E4B971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 405E6607FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dr07-QeKVQOg for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 61A9A606EC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=itXvCWtl
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61A9A606EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:53 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so9219485e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245392; x=1794850192;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tgBrfP6h2pNvBnaTnU+xjZoh8lZkO+v+xBbUEmjMQfE=;
 b=itXvCWtluw7QEIOvuEk+WOOI1goVaU7NYxiIsOVbdsxNM1eUTckuV86+l2ubGmIVua
 +mMPmxHpn+Gy/bRq7CGxD2OcvKGUdn77z9RSpO1uExvSf9m8TD3DcOHaH8DUBwsUtb+y
 m9NMw/qy7me1wVONFnaboZE1uvMybDvhGoo4Mq/mPsyCMlO39SuC/2GfeBOMSx14Dryc
 4ACCfRLjjx6ax9wy3MQ3AIUi74Q9kkjI5xAHFrc9JXYGEsqH31D8Rm+IpDF9aJtmvYqv
 SsQjC1rd8hiHQYetk0isbpaFKGlKDCRujCdmEMB8H7/8J1cgRDMzqV2G7uA+aWZb7rt+
 BjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245392; x=1794850192;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tgBrfP6h2pNvBnaTnU+xjZoh8lZkO+v+xBbUEmjMQfE=;
 b=GzaC4lCVE9bwFIAG2kvUvpp5hgukmMCo2CGXQ/UGo0Xs2puG1sWKtPmgszNLH8Jg+Z
 qVpcAKc3/Q7RfQUsOhSdttBDPy0kPVp4timc42aZ+Z+SLUGZlKTMcRfLupeuyd68jUSP
 0KzGDdi+hRXEU8qTPKcrDC47N6165l61MjTiHkcyzFMGdS4hzJtOK8JAm2qbYUZUTR9K
 H14Ailtf9UsIGnP0X+mWmS5zAM0rA2cOEC0jT8OAJI+/Myv9j3RoTiX/v4WGoCL+m/e0
 TL8p8mxPtY82acS61G6KthBo5TYt7BCaJALERvhm7w6UOKqFxR4IEIfcRgmPPyaqcM9o
 DRlQ==
X-Gm-Message-State: APuU4Z9DHFOMs4pcOGPdXApfL4L8WdWOEZl55fsQp2ETIkS5cySqs1Ds
 RVhRglI4JXKlGZxBGJzY4c8mxNsytO12B3M9pxW2qJbeY2CUEKKwJVOS1mSImX0pdgk=
X-Gm-Gg: AYBFou057UXDZDYwP1P25aioat+U87A9wGlhoJa7IdA4wngYWyhKyHlrKiJG0XBtRv8
 l5aZgWpVTmyeT+t+yFelrZE0oklkM6gzSfv3IKvC/1TUH2opoSD7MzPIx83jbZBfVbH9UbiItJk
 NOCC6EbTIagMvFh1aIeo52oDco/SAXz8Nw1QVBG43+0oJ3w/oI4Wr9p8laEnIrcbQxKqh51Vwx0
 d/O5HJ2n3jHwoVfAWZjs/tGsHZMSYoqnBhW+UPUzF2D1M6/T+b1MruZpwJNVLJpEVWoVmWd9+AH
 zwEwBn94f/Gd2qmCJofG/FzjHi559Z3UnT0mdYZnJCzpZJ1kB7VGOczyZ7ocN68j6rz1cynBzvq
 trva5QQDUFMMwPg2IRAOoORenBTncuGxlYOHL6xzGIY/4jhL2JOJHIWDpspM+LAWuyaY6okcQsH
 AROVnUKTQsdMie/JR8Hx2HZ2//JCZElooxKvBEGZdMGTvjxgx4A/GS086K/PdYvMGmjjNDJ/UZ9
 6p6BxKu9zaXrj0df/MydpB2xPmyFSLe8iLT6DazJOaZoLl+4fa1GltbuCHMJ+mzflTurL9CyPZt
 pWLQq3SCnJHCU1sZtuf+cUaDlNB8RgE=
X-Received: by 2002:a05:600d:82e5:b0:4ad:181a:4348 with SMTP id
 5b1f17b1804b1-4b963c6bd19mr95974705e9.18.1794245391973; 
 Mon, 09 Nov 2026 09:29:51 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm84585f8f.49.2026.11.09.09.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:51 -0800 (PST)
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
Subject: [PATCH 08/11] sunxi: display: Skip EDID modes larger than the frame
 buffer
Date: Mon, 09 Nov 2026 17:29:50 +0000
Message-ID: <a9d30df3-8e6a-4b28-a99b-4109b191cfc9@gmail.com>
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

sunxi_hdmi_edid_get_mode() takes the first detailed timing of the EDID
which video_edid_dtd_to_ctfb_res_modes() can convert, of any size, but
sunxi_de_bind() only reserves a frame buffer for LCD_MAX_WIDTH x
LCD_MAX_HEIGHT. A display announcing a larger mode makes the frame
buffer run past the reserved memory.

Skip the detailed timings which are larger than that, so that the next
one is used. If none fits, the display is handled as one whose EDID has
no usable detailed timing.

Fixes: 75481607c741 ("sunxi: video: Add DDC & EDID support")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/sunxi/sunxi_display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sunxi/sunxi_display.c b/drivers/video/sunxi/sunxi_display.c
index fa492c661db..8783c09031a 100644
--- a/drivers/video/sunxi/sunxi_display.c
+++ b/drivers/video/sunxi/sunxi_display.c
@@ -287,10 +287,11 @@ static int sunxi_hdmi_edid_get_mode(struct sunxi_display_priv *sunxi_display,
 		return -EINVAL;
 	}
 
-	/* Take the first usable detailed timing */
+	/* Take the first usable detailed timing which fits in the fb */
 	for (i = 0; i < 4; i++, t++) {
 		r = video_edid_dtd_to_ctfb_res_modes(t, mode);
-		if (r == 0)
+		if (r == 0 && mode->xres <= LCD_MAX_WIDTH &&
+		    mode->yres <= LCD_MAX_HEIGHT)
 			break;
 	}
 	if (i == 4) {
