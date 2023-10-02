Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D57BE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B6E8723D;
	Mon,  2 Oct 2023 03:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fipC1E3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 365F887250; Mon,  2 Oct 2023 03:18:24 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7BF8717B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fe612beabso283896739f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209389; x=1696814189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oPrOx/bgRaxZ++FLJQHTtWd2RQsoItTwrtmh9NDeto=;
 b=fipC1E3+6JHOmewLpzuxZ+5ImseHSThUG5nfAYnbHmIKBzcTRk1AZ4jqdZyaJCto+m
 Z0ZpulpwoD3XRX7DPSQXERheNDAVD8CZOLFxLzOEzeP8u7KIC93S+UE8lc59uNXu5vr6
 peccAqXkdGTt6DNKMyRZKOiz/FHTiSBa2joig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209389; x=1696814189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1oPrOx/bgRaxZ++FLJQHTtWd2RQsoItTwrtmh9NDeto=;
 b=ilA7MWZ9qvftXAxpJurs5X+pfDyHuan1LWrWS+jFABT7z/T/sOPJpEJv6O///r/eh4
 FgrK9e26U9xWKA8M7Q5zFZ+t0C94pEq0iEE9IXDc/ecFel8qzb/1QfpOa+rUMpHzUm4R
 xM4Lx4hQGWuVf+FiWtdDi8YjbM9QP2OaWGXOOSWLeSs3eSbU3uFVZa6Q6GtdgYmRGd7b
 fIEuVHY8HwHrdx8WIMIbyozNDblXsqW4ZzDFUM38y/Zugek+GsMKGLC16eMFi0OA0R5O
 7q2iznKoyXh9ifSbBwC25Vmlq1uXsTeqlyg0d0WxBHhfSPdaCZDQT0G6mpfweBt/fbuc
 HeNw==
X-Gm-Message-State: AOJu0YxV9KHF7tfEfE/YzMC+qlOP/wf556Wsv42niSPBrQrJEctbe4Qa
 2bX9dq7U7JI+YxVaEn52XyMP3VB5lEuqG9DLMjs=
X-Google-Smtp-Source: AGHT+IGuNvFBGOMCxBE3tPsTh5ZK9dvKCpyfg8U/jqc7ctKKEVMxENr3DsoDIfbHqWbpekfXu2GMCg==
X-Received: by 2002:a6b:6119:0:b0:798:2415:1189 with SMTP id
 v25-20020a6b6119000000b0079824151189mr11779880iob.12.1696209389238; 
 Sun, 01 Oct 2023 18:16:29 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 26/34] expo: Add forward declaration for udevice to cedit
Date: Sun,  1 Oct 2023 19:15:36 -0600
Message-ID: <20231002011553.463514-27-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Some files may include this header file without first including dm.h
so add a forward declaration.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/cedit.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cedit.h b/include/cedit.h
index f43cafa5aa24..f9a4a6d9e8eb 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -12,6 +12,7 @@
 struct abuf;
 struct expo;
 struct scene;
+struct udevice;
 struct video_priv;
 
 enum {
-- 
2.42.0.582.g8ccd20d70d-goog

