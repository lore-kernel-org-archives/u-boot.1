Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E50D262A8
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 22:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB4E83AB8;
	Tue, 20 Jan 2026 23:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WlAFZMe2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 400B083A83; Tue, 20 Jan 2026 23:34:15 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D678F83A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 23:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x341.google.com with SMTP id
 46e09a7af769-7cfe2a6bf81so1760815a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768948451; x=1769553251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aXVryHa/eduuJWGRvf/lSVcB98uCH2ykAiS2AXVDsK0=;
 b=WlAFZMe2ECE/RYI1vZZAE4zcEjhgjleDMIAKxrrPB0xsDu6UouJJhcl5dLuuhHKo+K
 JryZzNpgUeDWcmPFcIt8C3/qqGsgHDdZTHfZbpRJZ9zJyHaw1Mct+YxLO509Kah+qEfP
 MJccRFj0XJw75pppCgGui4/XsosM2+5YufD0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768948451; x=1769553251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aXVryHa/eduuJWGRvf/lSVcB98uCH2ykAiS2AXVDsK0=;
 b=Yfx+PrmjSoo7grvQg2q4dIvr57REFRM4aWESL5I0azKyvVCqw6CvFwMnV0TY/5p3qI
 CklosPDpCVsm+Imvh0zqWcfVvwS4kITa2yOJTPRfQAjVfEa4l8CVGP/BhHP25oRj7nRk
 UYem3Dr+0M7f65rsYYSDZZiWsbrpNxYYCZTegmEFBjwPLjzFlD6LLz7lbWYAw16AZBHM
 8glepUaOlgezg2iHQY3yPhUEABq8DJn0TLzYxEMoDUPQ2h2TfcVU3xsLkqdL6vEPlghf
 /jebUJzP3fgv/7yG2k4LnWMSjED8ZpNmgI7dS1tkRdTgU0cIjEGxsSjIBDXsL2Uxy2/A
 jrPg==
X-Gm-Message-State: AOJu0YwahNkkinYOppiV+ZtvMCjBCbDCsK1EAiPwNKUOBvjAf+fwNEvP
 TBZC7vGne63lZU2iAkaJsaAddBRKpnBDI39YEIyRpAGdHWTWo/N/+9GNlP9Em9uRI1AUOJlMHMq
 2ppNuqgk=
X-Gm-Gg: AY/fxX4S1M3BkbSQyG8Ugvdcq+MD+G380AU0JBs6BsWz4Z1+HdLO5vP5i2CxuAksvCu
 bKBpEY651x0cGI+bRD+AdcTUbwD5VZoz2wD/JoULrzRMLVdUClWkz5d+mhHW5HzC/OJZ8qTlRvu
 nvw9iVTr/uuBeLia9TJKUoWmU6RXfOHzYEFZYRnzL0G0LFdmuIq7rLq143uQUyUGLQtF+DaR+QY
 0RndXgmQuOyc/8LK27b7+tLvInNcy7Z93xnyjQAYWaq5AkKTIwz+Tt7YqKATRgKmY0F0lvuHzbf
 VhlOMPI0lwIW5SxfH42vqaZGRFBRsixYGUbtD6GNxHa6Dr38Ve3t/KgvgyoADhW0yVUVxhqTZB2
 vw2+tz21owoj/zZrIBHDXPQyB6la1WRYGx7ibDcLZ91ctzd86TOLnBUhpbeQOwuxNirwnR1a5uc
 f1MD2tAmIgplUQ7bkrmnTd9x0NzfJK+6pYXfTuSXCRbVFcxfe+XSnbufsnDxB7SYBIZ/yu//DxJ
 LlbNDgcKWuo5yv+FtGDylY5euZxGN1F3hcDdT2Etw==
X-Received: by 2002:a05:6830:4c09:b0:7cf:cf19:cc62 with SMTP id
 46e09a7af769-7cfe02bde0cmr8353811a34.38.1768948451640; 
 Tue, 20 Jan 2026 14:34:11 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b59e2sm9705687a34.30.2026.01.20.14.34.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 14:34:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/5] doc: develop: sending_patches: Update link to patchwork
Date: Tue, 20 Jan 2026 16:31:45 -0600
Message-ID: <20260120223405.469050-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120223405.469050-1-trini@konsulko.com>
References: <20260120223405.469050-1-trini@konsulko.com>
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

Make use of an anonymous reference for the external link here, per rST
best practices.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/sending_patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index ee6e34089b5b..53c7655b2c34 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -325,7 +325,7 @@ Notes
 Patch Tracking
 --------------
 
-Like some other projects, U-Boot uses `Patchwork <http://patchwork.ozlabs.org/>`_
+Like some other projects, U-Boot uses `Patchwork <http://patchwork.ozlabs.org/>`__
 to track the state of patches. This is one of the reasons why it is mandatory
 to submit all patches to the U-Boot mailing list - only then they will be
 picked up by patchwork.
-- 
2.43.0

