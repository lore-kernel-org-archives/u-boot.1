Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F697D3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:22:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1044A88FB8;
	Sat, 19 Oct 2024 17:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nmIyc+gf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71A788EFD; Sat, 19 Oct 2024 17:22:34 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B396687D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a39620ff54so11407485ab.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351351; x=1729956151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkNmC7gLSYKXKZa4Vy5epClhB5932qUD8aHgmMbM+mY=;
 b=nmIyc+gfpefouxNUPNgCBTEOiuP1DYTl30P70fn0sQT5UGvrCNT8cAUQveJfDooBhX
 VaC6JDOBiwNBGZpsVwVIh+sI6P0P0IVMeyatlu4iTrUEFECMX0okYF/Q5nU2FJFE5qoV
 EMbcb38kyeFT6IYYb3JOo0/wx11vkLaeo7ckc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351351; x=1729956151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OkNmC7gLSYKXKZa4Vy5epClhB5932qUD8aHgmMbM+mY=;
 b=ia9O4LtJiuGxmzn+iQL/uUZRtHyzdDFz1Gwql3BrGFcgKpO2PzBtgyfRq4Yi/s/9Mt
 C4vJjEXx/Ju8d9O7th8+xFBXHOB4lPADjyxUBx1UfR12x834r1c5UO5P+fTuNEXAaMEb
 YA8hYvB1NVAwZoz3GFqCJtiywvMzoSPhCjke6ZbF0Bn/f2cnwhp6W2X4FAWsalBxDLBm
 N8Ux9YNl/5DtK74gFsyeHVN6/sV2KidE2XW+tTO5dU9oaOiat3ZVyk4iyRs+e0Xvpclh
 2Iyb/Rxc/2jk/SYUuSfHaTtvvLnv64es2+u2eC4LqvcXm6plJhjU624VKXsmbKczTwNG
 7Sgw==
X-Gm-Message-State: AOJu0YxHmjlVwNyr/qIFa+WZ2t/s8sAgzIgrD7Rh7slUknBKqzw0VC2/
 eS9dWdvFT+FgzZa/LhoaoPKwrtAENDSbZdS6CIm3g+7rPV4jBOxAvI/crKEcuzmjPwqzBOEUSZw
 =
X-Google-Smtp-Source: AGHT+IEomC08V75omQO0bqPxTW8elA7Fj78IJsMjegMdj8vA2LNSvHMCsOIcenXvMmn0njkwuAZO5A==
X-Received: by 2002:a05:6e02:20e1:b0:3a0:8edc:d133 with SMTP id
 e9e14a558f8ab-3a3f405f920mr56393955ab.9.1729351351365; 
 Sat, 19 Oct 2024 08:22:31 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 03/31] alist: Expand the comment for alist_get()
Date: Sat, 19 Oct 2024 09:21:43 -0600
Message-Id: <20241019152211.1014896-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Add a better description for this macro.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/alist.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/alist.h b/include/alist.h
index a727f1c7dfa..2c78ede201e 100644
--- a/include/alist.h
+++ b/include/alist.h
@@ -116,7 +116,12 @@ static inline const void *alist_getd(struct alist *lst, uint index)
 	return lst->data + index * lst->obj_size;
 }
 
-/** get an entry as a constant */
+/**
+ * alist_get() - get an entry as a constant
+ *
+ * Use as (to obtain element 2 of the list):
+ *	const struct my_struct *ptr = alist_get(lst, 2, struct my_struct)
+ */
 #define alist_get(_lst, _index, _struct)	\
 	((const _struct *)alist_get_ptr(_lst, _index))
 
-- 
2.34.1

