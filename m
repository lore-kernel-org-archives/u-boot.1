Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF84CCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDB9E86C29;
	Tue, 19 Sep 2023 20:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="elRoA6wr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B98C86C1C; Tue, 19 Sep 2023 20:09:48 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAFC86C1D
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so227081239f.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146985; x=1695751785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTMQw4RBzTRb2QRV8ZmfaOCi8CGT7PSN5lB748VKBrc=;
 b=elRoA6wr6bKOwxujST8AfZdTVxvK5FlbFV4dq3MdF0cy8p9dak6gsVwf1OE6ss7ZvZ
 5eoPxqkK9gTaVSpHvlLdNCoRsex3ybydgK5GH+p14Oz14PlfbD5XMIwBfwwtWfur/j6R
 +sm/dOHiBqlpIkI3W6niMu4/+an4i9QDOmXgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146985; x=1695751785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTMQw4RBzTRb2QRV8ZmfaOCi8CGT7PSN5lB748VKBrc=;
 b=S5597wxFL/97h6ONl1lkJjsmzRZo+sKdCbDuJ2evT3Ts8VmlWtj7LJEVQArBgaTzmn
 0iehcjAwVufiXpmmbqkgktORDfGbrMnokZokzOBCBCOTI/UNZCIo/u9dFsAnCoG1N56h
 o784Ms80PnEcTk9vMOhTcFY2vdoenLAxVvfwPUa7A5Xara4vbLtDkw1wxzZkNJorKFj8
 bNLD+NN3t51ATleaTMJJluHHHFR8gycbDreMDEQRNK6OIKlTItETWmkQEEeE+i95uNHt
 ZQsk/DnWoDHt3uOsSottcN6ohTMGIMJYy3D5lfU0Gj13FpWxdoE7kpS7dw+2NpW8eJZ1
 ajYQ==
X-Gm-Message-State: AOJu0Yy+wh82qqoUt98CYDTLRD+7X5SWVHdhIq6k9o55JOAyIEGypua8
 uEf4XoIpxhg0Ps7l9lVc5p03DAy/HhvX/xvw5B4=
X-Google-Smtp-Source: AGHT+IEuhOm+RPOKbl7VX3cemQQweyTGxJKZdDaC/K8KibZFVJYkpEB4Xr+7zj6GxBFixhlOduBo3A==
X-Received: by 2002:a05:6e02:20ef:b0:34d:f026:7aa1 with SMTP id
 q15-20020a056e0220ef00b0034df0267aa1mr720130ilv.26.1695146985061; 
 Tue, 19 Sep 2023 11:09:45 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 22/36] expo: Correct the logic for duplicate-ID detection
Date: Tue, 19 Sep 2023 12:08:52 -0600
Message-ID: <20230919180918.2904313-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

Update scene_txt_str() to account for the possibility that the passed-in
str_id may be 0

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/scene.c b/boot/scene.c
index 9c4466c1a47..8e5d3aa7dc0 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -176,8 +176,9 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 	ret = expo_str(scn->expo, name, str_id, str);
 	if (ret < 0)
 		return log_msg_ret("str", ret);
-	else if (ret != str_id)
+	if (str_id && ret != str_id)
 		return log_msg_ret("id", -EEXIST);
+	str_id = ret;
 
 	ret = scene_obj_add(scn, name, id, SCENEOBJT_TEXT,
 			    sizeof(struct scene_obj_txt),
-- 
2.42.0.459.ge4e396fd5e-goog

