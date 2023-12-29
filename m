Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46540C47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104E387B6B;
	Fri, 29 Dec 2023 18:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aL2u5FlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECEC287A03; Fri, 29 Dec 2023 18:43:49 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EA5987BA1
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bbc5636b8eso1387341b6e.2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703871826; x=1704476626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8mnvgMIPbBqtPqsaKBYOas7zhMJRw1OhTKM8fnQMPY=;
 b=aL2u5FlT7K1ia+0IPprA66sqev7GiPWSxN8Wbmfq4ACXvG3x+t2egkFgeMGu8bLolw
 w2nAtdSrs7U8E7vxn4D5MURmu3rjWSLZjwvPvih0qt22foQ7eJtiPfvNmN+vAztLT2es
 k6RA/bQ+qjyQzZZ52wXIqykmT1GGWjp6Vqq72xlMkZDlIHMQj9BGA5RXHPCPwzoN7YGr
 n1mHAHvq0QPsgtytSMcIRf4SeAZPrO3lUHzyfWLpfDSRzn4Gn6rJZAErvhJ0T0+l14um
 Dj+NbRaqNLAYp9W1kMAHOh87HECF9rhyLGt9XB9S8+tBcB/LVeGfquiKKcUzfj4yDlLA
 H5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703871826; x=1704476626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8mnvgMIPbBqtPqsaKBYOas7zhMJRw1OhTKM8fnQMPY=;
 b=IrxB/rgIHDmZvldIt1ZnnzCdLRfuaMSqRdBewgYUckm1+OcEy2cJe/sHA6xjOBG53y
 7Dd+yk+NaitwiO51cRAv4G60wZb8l1aZauaLxB5M/xSTUNNGt//c8FVouXDNCuTHenFn
 IOpJTSOXtaW6Jb/S2lFj4OPOxMoMN8MhlSzpIOABcT/FADOr/hvGXP2/q0zPJAzwM+9h
 oR0qfSUcj2upmtW3SrKZxnvaOw/eZg66bxlXxtOyCf2h7A795RJCRrEETmhIOHyfHde7
 bmqiJlqOh+piWjppdVpE9wLvphu3rETtGgyZX0u1Ivq6KCjps2QiELieHqDMXIrvyCZK
 w5tw==
X-Gm-Message-State: AOJu0YzC/fGtIt78ab0257oADbbKohyi4W3DnBpzNkZ0r5pLR0IX5lXJ
 sIifUE/2+iIqbx/y9FeluVtz8KCtORdV9HVszxEQX+bGCmQ=
X-Google-Smtp-Source: AGHT+IFOwxoOtVx5tB9TizVsL7bvNaIeAJ041Pof2OXzTHSlaKh1vbqXFbxGxpozMpDakw+xpwPeGA==
X-Received: by 2002:a05:6808:22a0:b0:3bb:d34c:7833 with SMTP id
 bo32-20020a05680822a000b003bbd34c7833mr2876385oib.45.1703871826013; 
 Fri, 29 Dec 2023 09:43:46 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a05620a122b00b007817084e7basm1545849qkj.99.2023.12.29.09.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 09:43:45 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH v5 11/11] bloblist: Update documentation and header comment
Date: Fri, 29 Dec 2023 09:42:43 -0800
Message-Id: <20231229174244.892818-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231229174244.892818-1-raymond.mao@linaro.org>
References: <20231229174244.892818-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

Align the documentation with the v0.9 spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/bloblist.rst | 4 +++-
 include/bloblist.h       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
index 81643c7674..28431039ad 100644
--- a/doc/develop/bloblist.rst
+++ b/doc/develop/bloblist.rst
@@ -14,6 +14,8 @@ structure defined by the code that owns it.
 For the design goals of bloblist, please see the comments at the top of the
 `bloblist.h` header file.
 
+Bloblist is an implementation with the `Firmware Handoff`_ protocol.
+
 Passing state through the boot process
 --------------------------------------
 
@@ -99,7 +101,7 @@ API documentation
 -----------------
 
 .. kernel-doc:: include/bloblist.h
-
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff
 
 Simon Glass
 sjg@chromium.org
diff --git a/include/bloblist.h b/include/bloblist.h
index 145e5c0242..84fc943819 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -66,6 +66,7 @@
  *
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
+ * Adjusted July 2023 to match Firmware handoff specification, Release 0.9
  */
 
 #ifndef __BLOBLIST_H
-- 
2.25.1

