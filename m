Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E27C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D02082937;
	Fri,  2 May 2025 16:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FaG2z2EI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9309C82845; Fri,  2 May 2025 16:47:40 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62FDB828C2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-86142446f3fso59057939f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197256; x=1746802056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9aZ20JCg8XZRZtCzo2y/J02t9J3UecyfGNU6wktKts=;
 b=FaG2z2EIgQt2TAgNRzhNXEi6j324TOra58AHkilef30nUE5FqTo+B8aEAW6xHliE4E
 jhbTVLAyFUyWfJln4mhHoItc+qzQEJ8grNcAJq7C6NC1lVmmsFkiNqno9NzDGXS9TxrM
 nxukmp9u7N+qh1vtQK2Rn7RErc0/jcLsgwZkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197256; x=1746802056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9aZ20JCg8XZRZtCzo2y/J02t9J3UecyfGNU6wktKts=;
 b=wMf5bD7znpPm6Mt9mb3RT0s3+U4BaqOg1pQFnwbq4rlhfYkLyQWXGDjPi2+6hagIrN
 M24zlSz894sinZ8dEQIXT9UHvlUXJEAANz5QQQbDwK/rkEpN5MkpSvOtSQl+OMoiIAlf
 yOsKhs3Z7WJxHxqiEpbCHRXVg7Q4jJeRZkatOr/hED+o/8kR38gLFgMJOva8r5PwDHb8
 8bu9oxoeS1IKrbwGSs3uMcHW/fodyFYzzCwwtxoKW9hV4mGEKpEmuHjRFdPguXmnK+2s
 1Hqw10vChFeW2TqeJ0wChEw3tA5W+eoLseOuE+5hIWAryxxdUXpX1dyczLgAQBw+KspI
 Gpug==
X-Gm-Message-State: AOJu0YzB76BfPcyPaTqHSkcrKNfMmY9LxwCHzuPh4BEbP59/kZVUwU6E
 7OloTl3Fh8T4FmazP24dIsK/+BH11Fv7P1vtKDA1crKgPU+T0MXY131VEggWhftjN53oWN44qqs
 =
X-Gm-Gg: ASbGncs+HI1zOzZYiIdSeC7fd9U23ajug2lGsttC4tIGgcpobCCC15kuKYrjyraLL6N
 s1Ul9biRZ6NfuyEm3AAPEaTNzgXy4xaqfwzjaxhpwR+Tc6jxJa9mN7SloD7WWtWx1A1cymRYaAm
 dcLE/iKggHnOI8N2oWRwgykkDwWlMPeKzAhlipOEfu9+2+58osMAZCNu3u/eH3Di2I6Jf1j0nPC
 OD+mlWsbdt6lZknrkaM765dVbUuJ8c4tr6++AV8jB+V7vWv/0wlN1UgXi99n9Xav9rwrFlZsqTR
 G5XaOmXes3s9ZqM45gg7w/tX+s4cfP5XiqF38oLcJq8mMaDs5+nb7hJ5xUD/L9Xx9BzW+WAymIA
 mfA==
X-Google-Smtp-Source: AGHT+IHhtJ8Qptih7ayOriY4kUqlK4PuECyLPbfMXdZUJHDLNdXRtsfdA/5+paeAFrwdgFT/5S3qXA==
X-Received: by 2002:a05:6602:3a15:b0:85e:1879:c708 with SMTP id
 ca18e2360f4ac-8669fb07f5emr390987239f.1.1746197256555; 
 Fri, 02 May 2025 07:47:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/60] video: Add a test for font measurement
Date: Fri,  2 May 2025 08:46:05 -0600
Message-ID: <20250502144718.313633-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add a simple test which measures a line of text using a Truetype font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/dm/video.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/test/dm/video.c b/test/dm/video.c
index 929fc16d0ef..6ce1a756e25 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -777,3 +777,32 @@ static int dm_test_video_damage(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_video_damage, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Test font measurement */
+static int dm_test_font_measure(struct unit_test_state *uts)
+{
+	const char *test_string = "There is always much to be said for not "
+		"attempting more than you can do and for making a certainty of "
+		"what you try. But this principle, like others in life and "
+		"war, has its exceptions.";
+	struct vidconsole_bbox bbox;
+	struct video_priv *priv;
+	struct udevice *dev, *con;
+
+	ut_assertok(uclass_get_device(UCLASS_VIDEO, 0, &dev));
+	priv = dev_get_uclass_priv(dev);
+	ut_asserteq(1366, priv->xsize);
+	ut_asserteq(768, priv->ysize);
+
+	/* this is using the Nimbus font with size of 18 pixels */
+	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
+	vidconsole_position_cursor(con, 0, 0);
+	ut_assertok(vidconsole_measure(con, NULL, 0, test_string, &bbox));
+	ut_asserteq(0, bbox.x0);
+	ut_asserteq(0, bbox.y0);
+	ut_asserteq(0x47a, bbox.x1);
+	ut_asserteq(0x12, bbox.y1);
+
+	return 0;
+}
+DM_TEST(dm_test_font_measure, UTF_SCAN_FDT);
-- 
2.43.0

