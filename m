Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64581606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IlR3Y0c+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwuWv0nC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F46D80FB5;
	Mon,  9 Nov 2026 17:29:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jExtiYO6N63N; Mon,  9 Nov 2026 17:29:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 60CC880FF8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245358;
	b=mjJcjQCyqfhjIswqxzirGQvZlSlAIO3joSED1EzARWUG/1hm4g1lB12OKUO77EAQaxqv
	 YTESRkEkq9+hhqgO9pxv7lDiHjVTtqqdfbf7t5xRrjg7yvW/KIdtYFLWRDSM+Ctp60T/g
	 b+xo+9oLLkcksWGgD130m3ITBY4EQSlizqsdEFpMTixBj+DnQ23eF5Xk6ZS12ida2wa/t
	 4Ts4HfzmC3pAskeB5EQkmrpMmqPN/isRibMYcEbkzPy74s8bHWytndFRoFbSWuJUTGhBC
	 QnuyQRgAjk07ANMI0MrAiPaxbr0Ck6cDHJstKpI/K2SO6rcR7CeCdIlioxARletuVNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245358;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O0pkVSR2BXuPuTVlZZ7lLJOgosLCzGn2zX+V+QK2F7A=;
	b=e3M244JBPD2qWqJ46PlSZq1gW2GVL6P0TEIpdt15GpUWOXT1nx8k0PTroAezQgrdzFQH
	 r8L/xidiHMAhqbo2PPQWXd0qe1jbKTd91KhLSIOTJPdYp5SAZHfN/KlUF/1ksStwtoSj2
	 0bFaOZsTQnaClAWjM+bW73MJJXXt67LoJ1tJDM5FRcrjwOGa3WCbbeLdLAeEGLtosg7xk
	 PX49oNi/cfIJn4mtLPfp73gq/FfjqtLhpyxwzSlmpQ/dsdD/664fGri4iNAr/yfeQi6um
	 W11ZjlVEPvx92mZWOzL4dpYVBrYYRbw0iCSVxEPgtuCxb/C9onJh7WbVhQNVi2LgepA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245358;
	bh=O0pkVSR2BXuPuTVlZZ7lLJOgosLCzGn2zX+V+QK2F7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IlR3Y0c+5NHx3TvwgsMiAFKYvhvl4Nb8W+0R6elSAABgRQrm5QBfbVzAgYiZJtrR6
	 f7VPQPLXhvpQ8rYY33D7swoo1AQ+wccLqLwcC3LAUHdqzQGGen2hYdte2AM0YmAkXY
	 uKcLloCX++p1/zAv53gI34vAFtw/+m9WG7kVvjNPAFo5WuAmu6DlK8eHryFhxbnE+z
	 AogHpFh68gutbQIWpigw3qqn5Hqw357tqkBXMhlLZsVVKM/QVN0uBV76ZFXwr4pccf
	 CedxFb0M7cbkvTMZ771/CmUIwiv0P8IVEZP/5tkNYj9R06oNzj2m1Zbj6Lvu/mucsc
	 4op9+r//5382w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60CC880FF8;
	Mon,  9 Nov 2026 17:29:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1680628C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F080940769
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SktLxgtzUMTE for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE57140756
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=VwuWv0nC
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE57140756
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:15 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso813746f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245353; x=1794850153;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O0pkVSR2BXuPuTVlZZ7lLJOgosLCzGn2zX+V+QK2F7A=;
 b=VwuWv0nCJ37i2IJcsW8dJO4Dfm3mohfM67FULF8BqfiSLB51A5bc7RbiFFF3BOHTmc
 FKZz3wsu7j74kcQbYsZDidSKWsHtvMEOItJQN2VRSYkNpOFaeM9M6ZvHKsXUgRY0Fu26
 pZtuPlZ3BB+g3pkyk4SOm/5xrh3IxO4E3o6akKqborAp5YjJZCNNjt/VtE/pJNh8A8v7
 8wBQ4ZJeY5+OQBk13FWvf7A4HA1pj/YvDbOzQVdK8GkVZxDlPSyAaNncXdpagy6hgawz
 OgeF7k04a78GXQlbStk2cfECoT6eRsZ2sW5dIw/Ypy8S1RrrTPyPGhHGfxhekUPe3vc6
 8xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245353; x=1794850153;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O0pkVSR2BXuPuTVlZZ7lLJOgosLCzGn2zX+V+QK2F7A=;
 b=dZasdRHcq4kA58AoaX6qS46VndmjPsk4aBPKB8lx6/4giWpwSlAV5b6SiQCb9BDXgJ
 qrKdkYKfdfRP/GmMxNAMvO1TTarMOb4wyXjbp+Z/jKIRSouU1NuVPAA8/12HSIeU1/Sa
 UqupNX/HKO8KpTKIqv3yxQ9pDi6sBypk+Fh1eFkIGiNCueTkFMcsO/Zp6RWxoKhijsgV
 NktMFpeJFIA1ewEQWbzUI7j+IjL3tyJ973kbYT/IbImm+AxK8wVbeV4FsdRM8zPtvDYO
 GeaeQGcC8eisEx7AT3SIrP4W0sHKqhqEf6DBbLSL8Kfg9U1LZwrYjy9CoUnhOKzro+1k
 ZvjQ==
X-Gm-Message-State: APuU4Z/CVGEmW686Yfucsae8Ewk/ZtDbWPdKJ/sX1mkghFcIzT1L1xbz
 StZ7A0qsWo2Cw0brgTki59PiKdwISh8ubHQWCcMdSkFOSFCvUjE/VhBzy8LV8GUmtws=
X-Gm-Gg: AYBFou19VHns8nAMCtKdA5mBGCxgTirnfEPpYi2wGGGHau6wIXbL1AP/UfBo7gAjDYE
 0FKq2uDBULLvP9YNm52wgM3qrBRVGyhr1B96HZRTfJ0MoVfWp2DDqY2vqF7vB2m0WvyQm6jfZA7
 RMFeLPJKqAoto39VQ/6F8FrY0u03atsu96TLPUwkTRlvYf4l1MhiOeWmIgBsZ5OpzllVtD0+LUo
 VUfwjySbsWCvixLcjLHDR6+5+JcmJvtcS0U6hbh9EzfGbDKIx4Vq69DQUkTOYjKPGXrAhZVtyNn
 fK4OGeYY2I0u/tai9qUuW9fTJwvEPVdTHI4zEdoGg9AZhqJRmpPbOiEaGHkCS9cbChD9veovaLF
 n352r2c8IHjqyGbQNehHbUNAW4SzdoU7HOJO3dowynm/5sIClFTS3izoLtEvwQSe9xhNjA9mqpS
 IEGbKrhyxSARRmhf0ZLqwbmD+TXSSbZh4rI2Z0VjvsNoFkqpZafDfmd5lIXGCb60s8EsspF2hoC
 lVvipID1oQrqM+dcA6dadm+kujF0AURjINdpHS9aMY+EEnbO094EKm/Fh21FxShFMzAkkI6baWO
 rvvOCIO8PE0ME5TGl1fnM/uhuHbVqT7BjvlxnK5tMhogZ02kLICS
X-Received: by 2002:a05:6000:2306:b0:48f:cb37:3ec3 with SMTP id
 ffacd0b85a97d-4982ff2890bmr287496f8f.41.1794245353175; 
 Mon, 09 Nov 2026 09:29:13 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983284c92asm191560f8f.4.2026.11.09.09.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:29:12 -0800 (PST)
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
Subject: [PATCH 03/11] edid: Leave the timing alone when no mode is valid
Date: Mon, 09 Nov 2026 17:29:11 +0000
Message-ID: <76cc4bd0-52e7-4362-8aff-489f17df1466@gmail.com>
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

edid_find_valid_detailed_timing() decodes each detailed timing into the
caller's struct before asking mode_valid() about it. When it rejects
them all, edid_get_timing_validate() fails but leaves the last rejected
timing behind. The Tegra124 display driver ignores that failure and
uses the timing it passed in, which it set from the device tree, so it
ends up with the mode that was just rejected.

Decode into a local struct and copy it out only once it is accepted, so
the timing is left as it was on any error, and say so in the header.

Add a test for edid_get_timing_validate() with a mode_valid() callback.
It goes in test/common, as the code is in common/.

Fixes: 1c1ed441b0d1 ("edid: add edid_get_timing_validate() variant to filter out edid modes")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 common/edid.c        | 10 +++--
 include/edid.h       |  3 +-
 test/common/Makefile |  1 +
 test/common/edid.c   | 87 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 4 deletions(-)
 create mode 100644 test/common/edid.c

diff --git a/common/edid.c b/common/edid.c
index e5aa4ca494f..1d934edf843 100644
--- a/common/edid.c
+++ b/common/edid.c
@@ -373,12 +373,16 @@ static bool edid_find_valid_detailed_timing(void *buf, int count,
 
 	for (i = 0; i < count && !found; i++, t++)
 		if (EDID_DETAILED_TIMING_PIXEL_CLOCK(*t) != 0) {
-			decode_timing((u8 *)t, timing);
+			struct display_timing dtd;
+
+			/* Leave the caller's timing alone if no mode is valid */
+			decode_timing((u8 *)t, &dtd);
 			if (mode_valid)
-				found = mode_valid(mode_valid_priv,
-						   timing);
+				found = mode_valid(mode_valid_priv, &dtd);
 			else
 				found = true;
+			if (found)
+				*timing = dtd;
 		}
 
 	return found;
diff --git a/include/edid.h b/include/edid.h
index 77a5d258311..fe0d88a859c 100644
--- a/include/edid.h
+++ b/include/edid.h
@@ -315,7 +315,8 @@ struct display_timing;
  *
  * @param buf		Buffer containing EDID data
  * @param buf_size	Size of buffer in bytes
- * @param timing	Place to put preferring timing information
+ * @param timing	Place to put preferring timing information, left
+ *			unchanged on error
  * @param panel_bits_per_colourp	Place to put the number of bits per
  *			colour supported by the panel. This will be set to
  *			-1 if not available
diff --git a/test/common/Makefile b/test/common/Makefile
index baefc7b3622..658f30b3652 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -8,6 +8,7 @@ endif
 endif
 
 obj-$(CONFIG_CYCLIC) += cyclic.o
+obj-$(CONFIG_I2C_EDID) += edid.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
 obj-$(CONFIG_$(PHASE_)CMDLINE) += print.o
diff --git a/test/common/edid.c b/test/common/edid.c
new file mode 100644
index 00000000000..15f5eb81501
--- /dev/null
+++ b/test/common/edid.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the EDID timing selection
+ *
+ * Copyright 2026 Ana Bobillo <anabobillo3@gmail.com>
+ */
+
+#include <edid.h>
+#include <fdtdec.h>
+#include <linux/string.h>
+#include <test/common.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Detailed timings for 3840x2160 and 1920x1080 at 60Hz */
+static const u8 dtd_3840x2160[18] = {
+	0x08, 0xe8, 0x00, 0x30, 0xf2, 0x70, 0x5a, 0x80,
+	0xb0, 0x58, 0x8a, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x1e,
+};
+
+static const u8 dtd_1920x1080[18] = {
+	0x02, 0x3a, 0x80, 0x18, 0x71, 0x38, 0x2d, 0x40,
+	0x58, 0x2c, 0x45, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x1e,
+};
+
+static void edid_test_fill(u8 *buf)
+{
+	struct edid1_info *edid = (struct edid1_info *)buf;
+
+	memset(buf, '\0', EDID_SIZE);
+	memcpy(edid->header, "\x0\xff\xff\xff\xff\xff\xff\x0", 8);
+	edid->version = 1;
+	edid->revision = 4;
+	edid->video_input_definition = 0xa5;	/* digital, 8 bits/colour */
+	edid->feature_support = 0x02;		/* preferred timing mode */
+	memset(edid->standard_timings, 0x01, sizeof(edid->standard_timings));
+	memcpy(&edid->monitor_details.timing[0], dtd_3840x2160,
+	       sizeof(dtd_3840x2160));
+	memcpy(&edid->monitor_details.timing[sizeof(dtd_3840x2160)],
+	       dtd_1920x1080, sizeof(dtd_1920x1080));
+}
+
+static bool edid_test_max_1920(void *priv, const struct display_timing *timing)
+{
+	return timing->hactive.typ <= 1920;
+}
+
+static bool edid_test_none(void *priv, const struct display_timing *timing)
+{
+	return false;
+}
+
+/* Test that a timing rejected by mode_valid is skipped, and never returned */
+static int edid_test_timing_validate(struct unit_test_state *uts)
+{
+	struct display_timing timing;
+	u8 buf[EDID_SIZE];
+	int bpc;
+
+	edid_test_fill(buf);
+
+	ut_assertok(edid_get_timing_validate(buf, sizeof(buf), &timing, &bpc,
+					     NULL, NULL));
+	ut_asserteq(3840, timing.hactive.typ);
+	ut_asserteq(2160, timing.vactive.typ);
+	ut_asserteq(8, bpc);
+
+	ut_assertok(edid_get_timing_validate(buf, sizeof(buf), &timing, &bpc,
+					     edid_test_max_1920, NULL));
+	ut_asserteq(1920, timing.hactive.typ);
+	ut_asserteq(1080, timing.vactive.typ);
+
+	/* With no valid mode, the timing passed in is left as it was */
+	memset(&timing, '\0', sizeof(timing));
+	timing.hactive.typ = 640;
+	timing.vactive.typ = 480;
+	ut_asserteq(-EINVAL, edid_get_timing_validate(buf, sizeof(buf), &timing,
+						      &bpc, edid_test_none,
+						      NULL));
+	ut_asserteq(640, timing.hactive.typ);
+	ut_asserteq(480, timing.vactive.typ);
+
+	return 0;
+}
+COMMON_TEST(edid_test_timing_validate, 0);
