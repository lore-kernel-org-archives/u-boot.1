Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56547606EE83
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=muOlb1IK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3xI7uwk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31A06607F0;
	Mon,  9 Nov 2026 17:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oeiMez_k9MjK; Mon,  9 Nov 2026 17:29:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 77F766084C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245367;
	b=U30x/7htFjzlrdNwjT7VIDHD050V1S86qX5qeaq/A8NbujdzfHjrp5lYUMxiud4UaTTL
	 z2Z/oZcI3adFnTjuHEdUjOCaiCLGUJPUXe5kf3LjxX97TXz/0ggSJYYWC1BAvApc32/LM
	 T0BCgwOx5zdzEqygcR94lz6UBeTsNU9HiOTeKSBpCjPxYgNueD5U/9Q5IZtwIaSrm54Kt
	 Q7Sn6uwFJJQtoxTUEqTiqJUfiR9sSAAB6rBUIfFitEKgR66AbqDGG8rJvV2qqIaHIkgKG
	 cYCzzvtDrU7noHbNwPYm14g0LafvcIJWbG/eAm4hy7Q9PdDNddSm5faRmaE4qzaHpAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245367;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JcVbg6f6ZQ74s63NM5C6N2iaxcBsF4Xncoj2qkr+6WY=;
	b=Khc5G2SInEzMSvwaBD8e84fkTtUCovCZVovZ/T1Pe4CZGuDJ5Sug9niuSA9SfAKzbsNE
	 zLmancqx7h5Ps0Tqk4EuFjsSfB/L0pTPjrPqVpcVQYM+axmTtZYIisHzRDhJvx6CTlSfE
	 +bnSc52XLWkRbVuQoUL/ZiDVRFejr8+Jt9mAsm1dfYMytAr1K4jUWWt6AedEjKsb6Rrh3
	 wAJHElNI48tncg/ZrieB7ljxF6kmSB4jPJgaSSi9Ev/NkbiO9rF+sxMwgvDwvK7Y7oxp0
	 HQ18uIfi9uLduBcDU4PulqWyIKyqJTGBa43kmp/zxWm9ZF84l6JNKJDe5l0QPidICPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3xI7uwk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245367;
	bh=JcVbg6f6ZQ74s63NM5C6N2iaxcBsF4Xncoj2qkr+6WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=muOlb1IKrD4GFkExHtcyIspw65FXvTPev0wvyHj936e6T5ywFyTlZ3j66/4Fodh5g
	 pO+0KHeBJHnbweLmqSge1t2xKOpr21twQS9fshMHxcpkz6m9D+vgfBtUFR6tlcsoEI
	 PoXMQZY2KBx8JZJOu9N7hzpkUdSAAy/Ha+OTpO3Bbm7PKqCzGnZDIqVrEsNyo23j7T
	 +cupX6d7e2CaidfdNUmYIY4fAudGhY85Ikbho8CE8TLH1FFF+oWPZs8N1VJnuAd7m+
	 x0utFVFdqH/B0+ZEPvTG1V8DebCfLNQj7qwbGc751a/gPX5lVOINLYGhqty5LcVMzt
	 oq652qV6a30Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77F766084C;
	Mon,  9 Nov 2026 17:29:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 352A1971
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AC466084C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2aO5-5ay7XDv for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 237FF607C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=s3xI7uwk
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 237FF607C2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:22 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1016574f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245361; x=1794850161;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JcVbg6f6ZQ74s63NM5C6N2iaxcBsF4Xncoj2qkr+6WY=;
 b=s3xI7uwkZgsg3HtgKnvJ2c+7S95Tw9yUhn68wTDv+9UXrKymxBwDsBnGaotpLRwwnY
 I1kHXtMpvrafLWHjchDgs3DUwRy5F0jCJV0XyRNBoKgSV7EFQ00vlsMr5p7m7a2X8a5L
 cRGXmvWA20b3/eqF3xVwWYLso9jfJeriY1gtQVeZizNvimVLVkzPLtuXcFER68MqZFxs
 EZpSBwJBWICk68KOz6jtb9qAZ+mwIDT5kG6LWknOyCX9nP7IsIdjv1wWDHkJoQu1AXyl
 +z1a7y7aA6hUHDRNMXMNwN0z9ESnoXij9wlrQJpip1EcvOr7wOzWt6vkgQOyPluWopxi
 xePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245361; x=1794850161;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JcVbg6f6ZQ74s63NM5C6N2iaxcBsF4Xncoj2qkr+6WY=;
 b=lcGumxU4LXOBThwn/6r9RF5eliV0kVOYhOe39LaoPQd5XjQJPLVzmWqc5CeMwO5FpJ
 fLUBM8wqutWhmjiX8+Tb1uaQ9bX+MuIjliSbaH6m0Z8uXk3xmR2FlqcFaz9m+asXVqTI
 lmHLuZraRYHFBv69p+kleho6j3cP7f5pnCmzrWWQxgMphsh9mi4QXS/Beop4lGYBrrvL
 tdFp0HrsbeZTpHO28baam+QnJXM3zykQzx2E64rD8/siK4sfyHbys0Cc4RzAp+Dv4p2m
 LsE+UoRw7PEoRH3GqOtKW5tRCU8rh+9tkITlzHKr4bTDgclNpvRQ6CMid2lwOkMJl54P
 EL7w==
X-Gm-Message-State: APuU4Z/x/lQYiJLXoL/VyrbcGnkSxp2LQEtd5stSWlpre5qufADuH1v4
 fBfBc1c/FiTSUNODuusb9w8d3Lmza+FSCTUqDVwcvYjiHcvvRrMc9yMtLWplvbSHE2Q=
X-Gm-Gg: AYBFou18fscPQGuJcXH/qETMQZO0WkBRKA5GKNy1u82VqpkyJdEBQSzNUl4UU0SI1VS
 d7pJoZZWUNU9ldA0Si0A5/vxoOjrwgeVQ+WtYj4EXA+bIbQYR1V3cMZs1pPkR2VC5XUqS/bzfzX
 1l7sUtn7e9wnSNbwVHn8KoYoGynJnSLBggIxhPLl+2vWTJxYcEkdN4tvWuU4NIvvOg+znW+7tK7
 1X5ycFQDy6d0OoGET486ZL4ScZJE2qznkJjvnLMu8hRzolnrUMDPdTmcdU9LiiSDzuiBLWNc8k/
 6mL7ceKWRDHHLbCwF4espt5qHC8HvJdekpkJQY+gu2k68g3rl8zpEIywjr+NH1q73FigexC18Cv
 i++nNT/Te7H5nwyEgNmBKJsOmUFEtEW6ofKcygoFPrUuRO9RYWOy5WRXIuyrA41JmaRphbyEoK7
 prhu8uo3kEJDKUmgBFZjwqscwJrRc65ATgD41Tx/rsar2Xs1zMxJV3qJBDMQ0YGpMWLdNu1uidL
 p17RYL4tjOL61eoemsqy3FE9rYMEXIuuB85cHMpvCo+7E+AS5iSk7F49PrgPG96HITSsNYlgUBX
 pUC9jbSfdo1nXmvc1U46FrEAHXx7FAA=
X-Received: by 2002:a05:6000:15cb:b0:48f:bcdf:6f83 with SMTP id
 ffacd0b85a97d-4982f3aa263mr199951f8f.22.1794245360644; 
 Mon, 09 Nov 2026 09:29:20 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4982eedfb36sm230671f8f.0.2026.11.09.09.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:20 -0800 (PST)
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
Subject: [PATCH 04/11] video: display: Skip modes which do not fit in the
 source frame buffer
Date: Mon, 09 Nov 2026 17:29:19 +0000
Message-ID: <54ffbe6d-668c-494f-874c-b5f34b84c593@gmail.com>
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

display_read_timing() picks the first EDID timing which the display
driver accepts, but the display driver does not know how much memory
the video device feeding it has reserved for its frame buffer, so it
can pick a mode which does not fit.

Add the size and depth of the source's frame buffer to struct
display_plat, which the video device sets, as it does src_dev, before
it reads the timing. display_mode_valid() then skips the modes which do
not fit, so that a smaller one is picked. A video device which does not
set them is not affected.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/video/display-uclass.c | 10 ++++++++++
 include/display.h              |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclass.c
index 85dac12a197..06888df4112 100644
--- a/drivers/video/display-uclass.c
+++ b/drivers/video/display-uclass.c
@@ -42,6 +42,16 @@ static bool display_mode_valid(void *priv, const struct display_timing *timing)
 {
 	struct udevice *dev = priv;
 	struct dm_display_ops *ops = display_get_ops(dev);
+	struct display_plat *disp_uc_plat = dev_get_uclass_plat(dev);
+	u64 bits;
+
+	/* Skip modes which do not fit in the source's frame buffer */
+	if (disp_uc_plat->fb_size) {
+		bits = (u64)timing->hactive.typ * timing->vactive.typ *
+		       disp_uc_plat->fb_bpp;
+		if (bits > (u64)disp_uc_plat->fb_size * 8)
+			return false;
+	}
 
 	if (ops && ops->mode_valid)
 		return ops->mode_valid(dev, timing);
diff --git a/include/display.h b/include/display.h
index 26b965daba9..f2ff9ffced8 100644
--- a/include/display.h
+++ b/include/display.h
@@ -18,11 +18,17 @@ struct display_timing;
  * controller
  * @src_dev:	Source device providing the video
  * @in_use:	Display is being used
+ * @fb_size:	Size of the source's frame buffer in bytes, or 0 if unknown. Set
+ *		by the source before reading the timing, so that modes which
+ *		do not fit in the frame buffer are skipped
+ * @fb_bpp:	Bits per pixel of the source's frame buffer
  */
 struct display_plat {
 	int source_id;
 	struct udevice *src_dev;
 	bool in_use;
+	uint fb_size;
+	int fb_bpp;
 };
 
 /**
