Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97919C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F528706F;
	Mon, 13 Nov 2023 04:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cqcv21DK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 633F287090; Mon, 13 Nov 2023 04:00:15 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426E186EE0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-359045af665so16741055ab.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844411; x=1700449211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJaCYkVGDjM8jWIBwFbwiu+l7T6dhL+ooFjzXN1MkiA=;
 b=cqcv21DKT+9KLBMGwPmMdhzpZ/xDnbq2XvpWcv0Lm6sNGtLcIK1AvOvgUiz1YAiPpg
 ugZHCfysQFGbN7Kv88Zbbr49E+T7WGZMbIPwj79LSaImJo1Z4jdi2/8MHu3otT6ooBmQ
 Z7ANzlZzrCUeEM/bSE1IXDZIfa3DX/CZxz1RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844411; x=1700449211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJaCYkVGDjM8jWIBwFbwiu+l7T6dhL+ooFjzXN1MkiA=;
 b=GBc1fqNdMdUnnw7z1kR0mkKF+M+W4gQlOEVhs6A2tAwHfkYJxIYv53zdeA7EsOKp58
 gdhpnUlVRAu0yOOXlLm+5JQZXnBxmDfchugc1cx8pO47qajqgOWWORizxFb2t7EJQNkf
 UUG5/f5CnBUYId+qTWHCxfVA6pAmL1IYTNNGz4d1O0Okq2XIAMHSEdMyxwn0xeCCFDZm
 LVxyXCFCdhSmYtR63PjiJ9KHmgYhYQnNgetqTZdNm/Y6s9jdeBJniXLxYbIY6+byba6p
 SEQ2RvcQ+/QcMhhUN7R1+zh/nLUjYXiYs6T3LCU1QuaoZMestHIcvTSGA/pJE4sBy+EW
 4y1g==
X-Gm-Message-State: AOJu0YyRqfFXvyfFhI4WlZzFDuUkgWyYJ767vTkJndXBSyClATUWm7cd
 chhBiaFZXImPXv2GdAsCpnS0WrufmBDJhlX04rIkYA==
X-Google-Smtp-Source: AGHT+IEY6+JejvjfWVmsk8pXHPUuXJLocgg8DcvxpYbzc65atQsDQDU+b+bhywnDepo/aSuDf1QGYw==
X-Received: by 2002:a05:6e02:2143:b0:34a:a4a5:3f93 with SMTP id
 d3-20020a056e02214300b0034aa4a53f93mr8810256ilv.5.1699844410852; 
 Sun, 12 Nov 2023 19:00:10 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Breno Lima <breno.lima@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>
Subject: [PATCH 6/9] udoo: Use checkboard() instead of show_board_info()
Date: Sun, 12 Nov 2023 19:58:26 -0700
Message-ID: <20231113030001.240020-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

Boards can use a sysinfo driver if a particular model name is needed.
Update this board to use checkboard() directly, rather than having a
weak function laid on top of a weak function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/udoo/neo/neo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index 730e266469b2..d99d93b44ae5 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -212,7 +212,7 @@ static char *board_string(int type)
 }
 
 /* Override the default implementation, DT model is not accurate */
-int show_board_info(void)
+int checkboard(void)
 {
 	int *board_type = (int *)OCRAM_START;
 
-- 
2.42.0.869.gea05f2083d-goog

