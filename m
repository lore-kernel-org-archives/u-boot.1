Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ED9CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AEB7831B4;
	Tue, 26 Aug 2025 00:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dePSM3dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3AF0831C5; Tue, 26 Aug 2025 00:46:25 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA5B828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45a1b0c52f3so30024925e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161983; x=1756766783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3f4nxo5XWpQtStMzFY6ECnd0WuPgRu1GAEjhp/I1gM=;
 b=dePSM3dOYIPgJYaP+/+t8EAbDv6VW4nHtjdPqnO+9ixvKyyIyBJXKJHuePNgnPBWy5
 yQ3TzLHKimJXMqDkF1gRvuq3ObnRySMpZaFuUARaYQRiXHpf4eZ5itdGPXl8rs7Yg9Pj
 /5knwAASMI8GsEZOGv3sYY8Art94FkIOVjSEImovvYgPr6FBHTNiNWNNFhBfoCjb3yab
 sf5uuR1bgAAj+RfKsEld3JS66ArNquqWv4OMB7T8oQQZHHQh42AVHAclqC+um0RaWNm8
 wYG15fpVE+9Yg/Wyy9fNqZc2JxOSk/6QCqKmUDAjkZqo3ffmtqm9sVjnh5BVYqNR7QVH
 1mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161983; x=1756766783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3f4nxo5XWpQtStMzFY6ECnd0WuPgRu1GAEjhp/I1gM=;
 b=JnB+ElLDmy9XcRM4gVlrSJ/H1ESWMBxPtR0RYKpOsMcyDePulrmjxUhRW3Q3IVBG+9
 qrfCj6XTo+JJR3JgHPSjFFCu0xW2kNyOcW3JEhXypYvtqQgpZkIe24XmSCjX+wKgbja3
 A5mYC/ujgrzQxtCKjLGkOoKAXLOFc9POJeDI9MRSSGMaEcDl3KruC0w/RLhgHmMPBULq
 SCLMj+2QBHiekzMcb/+yysOBlnMNPCZBQLwF6nxcOzTrv3FxSFBJWWsa+nwBGgKj2ncx
 TpdBjwsaI834Il+Lzvu26jjx+0M8V03KnEM0E//IdBe72npTXeL0+xwoH4XIPlIeB45/
 F3ug==
X-Gm-Message-State: AOJu0Yzx2qfkojw+bCxocOVCElBlSmntxt+Eiwd0HDToj4P//X7Rucof
 g+JQgEtJ/7n4VF63tMVvnfNTC5bHd6yj0/d7AkyNyqcoXTadJDs+MNQ751WaVgW86vg=
X-Gm-Gg: ASbGncu8engV6b9x0NRbNPsQeH8MBdddMdbK6qTPhyyRCmz2IyPTUK61nJM0tywEORS
 V53gIWuZwScVkX7s5E7aGjClpxktnPyOdT/xKLWaNNmOzKhynbPl4WvIsdrc9DRBnKm3QRzg/q5
 5aTzcxyS4Xp+fErUxKpxJdvJkhJgU6uBK/acjVhxTaJgl/iYw/oUcZRpQCfOsvj6WobYsVOxXC7
 MLlJonhAWC5XeOMW2rL1DpTVcn3lH/cTncs1vb0EYoznCmVRhAd9yzH0UVNta4iBsFZqe2hoWfb
 v6lBHmihaYV3Gex8CUgrqhhfVddVoSKJvAiQ1yAxyaw9bXpKvvq1O6MCO4O7XAx+vNUBnqJEm1x
 MxKH9wwjWDg9oq/O2MHC88nKV0KBi
X-Google-Smtp-Source: AGHT+IFVwAmMMkXJW5elOzbVugFNrsNjq8pPNSyBnMmr9RcdIX+842OcaAus59gz0KnkaAscCTWmow==
X-Received: by 2002:a05:600c:4695:b0:456:26a1:a0c1 with SMTP id
 5b1f17b1804b1-45b517cb8e5mr147040215e9.17.1756161982684; 
 Mon, 25 Aug 2025 15:46:22 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:22 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 7/7] doc: make pdfdocs: Remove redundant "-j" option
Date: Mon, 25 Aug 2025 23:44:50 +0100
Message-ID: <20250825224459.682403-8-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
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

The "-j" option is specified twice which seems redundant.
sphinx-build's documentation doesn't mention the use of this options twice.
The "-j auto" version has been kept and the other version removed.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/Makefile b/doc/Makefile
index d0904a9f990..b37071b2803 100644
--- a/doc/Makefile
+++ b/doc/Makefile
@@ -56,7 +56,6 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
 	$(SPHINXBUILD) \
-	-j$(shell nproc) \
 	-b $2 \
 	-j auto \
 	-c $(abspath $(srctree)/$(src)) \
-- 
2.48.1

