Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB01C7EE43
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F29C869B7;
	Thu, 24 Aug 2023 21:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="choYXP7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26AC86A01; Thu, 24 Aug 2023 21:56:15 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A30869E0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-792409bc1cdso8465939f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906969; x=1693511769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSLQbUwePqIdIdDe4jWQ+uDVWx4p6sZF+W5wqRXr6mY=;
 b=choYXP7Gd26eFlu8hs0EM7oMaYNRB8SqYSgq3djjUreseu8Z6fG3SQB6RoxpkjRRwK
 0o/uaROhgcZnPAQUIMMnzFbZTGJNtAD96lXIwDg4KJt7E5HVjUY1Od+ZTSuiD2yLFVNB
 6liHAMCrg3pZVm3oz6/dUOPLY72p4Lq3Jgdzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906969; x=1693511769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSLQbUwePqIdIdDe4jWQ+uDVWx4p6sZF+W5wqRXr6mY=;
 b=UTfICYF+9M+P97SvlyB0YmGG2Olm3sj3OGYYu1rB5tibl11dxP8tw+hLyooPWyi/Kq
 LQy2pq1r124Qk6uFQ92x3T7EXZZnIipTKQ20jAIlAMHWNl4YtD7PvR6Lx2XJGlyHvU8H
 hzdw04pxNWZeszmVXzUbClfsKQfQms1bFb60b6wH6YIAstm/NdFxgn/agkurunuiFFua
 5fmgfC5bPvC3QkSs+buCC3FjHZ1g3wDix74ptgOmYgz3VGPB9kYfvsoV/6guOcAc7Iiw
 JGRD5cRV0X43Qh3FCKABGlbeyMoBAILSvi6yFSofY3eDGKRyI/1QE9fbZCx7Lni/e01y
 0UnQ==
X-Gm-Message-State: AOJu0YzHRSZQN0MAFuPRgl0Ni/sT7qxcwYV0Z+JitTM7DpbJn3ubvtqw
 psWoy+sg+7D91svLwNSpceC4ig/Dv4oX3QHLLy4=
X-Google-Smtp-Source: AGHT+IG9gOrY9/mrLgdUdByJ3cpaAjwhyYIJsZIQVct5XOzMcKPnfs1mRHDQlkBwksMJQIfPsGFPrg==
X-Received: by 2002:a5e:de04:0:b0:790:9341:59eb with SMTP id
 e4-20020a5ede04000000b00790934159ebmr6450104iok.3.1692906969353; 
 Thu, 24 Aug 2023 12:56:09 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 12/23] dm: core: Correct error handling when event fails
Date: Thu, 24 Aug 2023 13:55:35 -0600
Message-ID: <20230824195553.1685996-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

Follow the correct path in device_probe() when and event handler fails.
This avoids getting into a strange state where the device appears to be
activated but is not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6e26b64fb812..60f8d6700ad4 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -598,9 +598,10 @@ int device_probe(struct udevice *dev)
 
 	ret = device_notify(dev, EVT_DM_POST_PROBE);
 	if (ret)
-		return ret;
+		goto fail_event;
 
 	return 0;
+fail_event:
 fail_uclass:
 	if (device_remove(dev, DM_REMOVE_NORMAL)) {
 		dm_warn("%s: Device '%s' failed to remove on error path\n",
-- 
2.42.0.rc1.204.g551eb34607-goog

