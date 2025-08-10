Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2F9C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5018354B;
	Mon, 11 Aug 2025 07:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dOjXnhWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1EE832BC; Mon, 11 Aug 2025 01:38:31 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB6783278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b79bd3b1f7so1741884f8f.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869109; x=1755473909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB42cfm/hGLuPBeGUgFDPPoHQgmqoJDkq3gQzL5Yw/Y=;
 b=dOjXnhWtCmL0V/XU6Wq94iiWN9H+JtY7Ml2CZkFpAiRjfFUhegj2U+u4WTJxWwhaJN
 eiPPceqIzdvf6XRe97X+g3lYS4uoQZ/SSdo6lPxnnE405zWFHKgR2FjMrbUkPI+dz9up
 3T6Ofwr0/4fyreKXMapNkdUmdOGRDuj8pwpKJlxFaV1kgBkpbt4JiWV1kvbl+VRGOOvp
 QqPsqs8Bxk4MIkPZRCdXtx0cXYoQthT6Q20K3SfzMcN+x4faawVgWZMfm2teoM6uATS6
 BzedHuld8+OnWpJRaoQd9hxQQ6uCNTvvLUvrY6Ch+ENdyU3ABo44q+mImQA0v3pOkaG8
 M/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869109; x=1755473909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FB42cfm/hGLuPBeGUgFDPPoHQgmqoJDkq3gQzL5Yw/Y=;
 b=O9TA1fHNgktQk+71Ax2eHLFNA3xAPrCmr3pUfmHaXE6ihUg3M0LQxDPrt1+1ZnpOlC
 llJ2ra9wjhycDlLNIrFBLrQxPDOX6Pp6MeAuZKUFw0g+f++S8POtP2I3jBSyeE1r4ord
 IC8tq30SOKKGaDqW3Wy2JkNDkFtJw+w3C+4X23yvvz9UJGgtY39hXnql98lh+W3s3qZU
 7EvvzTq3BMbZOMNJ/sJrF69LnbQUgEs3fdM+Ktd5PYoxVKicAeMJZpvrAnyQ9lalWDgQ
 TAI/qZbILoWCbTT+BXMxqftBjHMluqut3LKZcV57ZXOCZClx9yTvMeQZOdox+G6JciVF
 +cVg==
X-Gm-Message-State: AOJu0YxFKsO+9RsIn+7gwKJAQ/HX+X/vBoQVVkLmvmf1PcxRfAUO50x8
 wi1s2lQdS3TfgmT6tyA46qRaJVb5vJGzpxtThl9mNEG315Y41TSRUkmseAxUYA==
X-Gm-Gg: ASbGncv553XnUHIYAPUVgZeETLLUQMFx2YcPB+g0RlWtrM3QJlaDXNIyOi/rQNlxf0Q
 /2wUpunMFbcyVBWOMhmwvCR8/TOhgtx2dOn5gjTLEdAFg8Bli+8wZUYyS56twJwoIJzsiNFwVr+
 LUYTsRo7IIQrxjywd15b4nBFP25zbi9cr6sS2MtPvyzwIRVulNPHgUyVI2u8HlwoXPq56gNIyn6
 zUXSTynWMGvLN2LlYLSwyqCnLAFSa8NIO+yt8jislCz6GEQVYeswJU4Gf8/IPQ952KUCMbTp351
 kBnCFeyw4Mn+5awmeNK88ihi4GOEqFWqi4KiGJbQej6bjgFbCZltqzZ8FTmxfupI3I67COsAZ5A
 rzmMovzhW4bsw31de1gfOp6jUNU4CHw==
X-Google-Smtp-Source: AGHT+IHIkcQLISbXZIEuGQ9jXPsDTqZhDV8MKvzGLng+8Kqzrap8C+gn9FlC9k+ZPu8VbjPBLmUTTg==
X-Received: by 2002:a05:6000:402b:b0:3b7:8481:e365 with SMTP id
 ffacd0b85a97d-3b90093f7bemr8690487f8f.10.1754869108560; 
 Sun, 10 Aug 2025 16:38:28 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:28 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 07/10] doc: Fix typo in doc/build/documentation.rst
Date: Mon, 11 Aug 2025 00:37:38 +0100
Message-ID: <20250810233742.51902-8-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index 098c96a4c4f..f102fbdd86d 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -64,7 +64,7 @@ PDF documentation
 -----------------
 
 The *pdfdocs* target is meant to be used to build PDF documenation.
-As v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
+As of v2023.01 it fails with 'LaTeX Error: Too deeply nested'.
 
 We can use texi2pdf instead:
 
-- 
2.48.1

