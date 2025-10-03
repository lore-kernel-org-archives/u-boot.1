Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9813DCCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 10:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DE383710;
	Fri,  3 Oct 2025 12:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eICsc8km";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09E683700; Fri,  3 Oct 2025 12:42:56 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98103836C8
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1377108f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759488174; x=1760092974; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NNRthYsbe8gwYFTCgKmHT0Bhq2ZVQAJLmILuHITI3OA=;
 b=eICsc8kmImDSnUI9mnni3Wj8iMzo6BGdJoe7WAbDUhx1hmnnFVXq2+Nkeof6ql4kNM
 Xj+0WxupfEe6HhyEa7yQvrpZM3lip8FvgsQVYS4ZPxvXBpuH1CH6WDu6NWVGav2fw3RY
 SCFkooPyM64ghMEuEX4ogOFR0lx6/+0/Vdk74WIoyYBB4UvmDgjCi7LNhr0jF9k2blt6
 6WY6xHf1vuCdh08qrMDROPYhQFBrs2T7z7rGsnYqfIk+U5DxOPZchhjD5vd7YpVJPZhB
 Q3MCUQt7Etg6xlhhfTynjHjBZFS1cAEGT93vELwVFoWywZE8KJfsWOFv1tn/uuw3RjKZ
 80wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759488174; x=1760092974;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNRthYsbe8gwYFTCgKmHT0Bhq2ZVQAJLmILuHITI3OA=;
 b=B7KgKetb4J60cH5Oiz657zaunHmcJLRS2CgVGjkOMoZ9ynIgSHrAuMAjSMDu0zVc8v
 PRcCDpz/FTP5fimvnfX+RkSyToiBLKhNqDKxZ3/TiFxUC4WW0kHM7utLWhSALOLwEF32
 g2JjFJWnq8VU8E6GbuPFghSobNFY2JCKIRYEdidB8ydjJ94Gd4s3WbOKmtF9WOlk+v+p
 OFteog1iq3CSrwSwKRP4WK0YbgcXcNfdw1y3olDG3CsVOK4yuTplyQ4TLPR0VS4NDvt4
 xTZQ6oDh9+HHe+9qziqoMhiY5lkwnRLWRReqbWZML8vQqC/M/xXKyAUuTKGdTOqnYrwL
 CYsQ==
X-Gm-Message-State: AOJu0YyZ30Zh3yJ0x8tTI+hY/+6S7Adv9/qyc2cr0WANdENALtxuXbNL
 TJnQMhlsCMpclU32tzr0gnioz+nCgONfx3LQu4s85KsJ0GnLJBWVBrgaE6Ogta2t8q5LXaolQ9B
 +OIiz
X-Gm-Gg: ASbGncsIyLuZlANF/ZIMuYXGFn6CarFP6QYfFV7oE05D21aAhK/bXVE3UZ0Ll31etSv
 xi9exexI1rv+16O20Stkhwg/3jmw1kMUiwooGrohSxPiK1kF7ETDkuQD6Q49qL1lSBBn06q2Bsp
 gbT4QQ+cHvbfmCPrfa0SBvLzLdZkgmzn42UAfiz9FZqJWuBRmYtV3/zQB9VYa9TUX3OyiM5QkWD
 P1AlgL6hOoWfk8B1GnINxrs9lCQ+TjBDBuTD00DYIRJRkleIVNeS02c33Q30D4ZdtLW/CiRw0O/
 exTLHO/0XMLRwom7bcyX1zfwXVB0C4OkgrjlZ8Xy599+UwTrncW9fxTdZ2XvKQYswAJBmETQq9P
 sBipCrcZGqvjr1NT/7XhfPgSIAbdIErhvPY4n47UEZsFE6h+2BiIsV3otz/GwgM/6/7yl/59sCV
 uwTVY=
X-Google-Smtp-Source: AGHT+IGLOiBKYdgFSK1CxHFDFcF9mDSiZezugM+muaZHUVj/866B1zMTRVR9x8BboAjiwQbNa8ha8A==
X-Received: by 2002:a05:6000:2003:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-4256712a61bmr1683840f8f.12.1759488173960; 
 Fri, 03 Oct 2025 03:42:53 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:a6dd:d590:166e:6c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm7470005f8f.45.2025.10.03.03.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 03:42:53 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 03 Oct 2025 11:42:51 +0100
Subject: [PATCH 2/3] fs: ubifs: Need to check return for being an error pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-fs_ubifs-v1-2-a48d4861670a@linaro.org>
References: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
In-Reply-To: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Alexander Dahl <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The return value from alloc_super can be an error pointer so the error
check needs to detect this as well as checking the pointer for being
NULL.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/ubifs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 7718081f0937ce038f5237256caadc40630ae050..b6004b88f4ea215fbdd41ec97da5f28d1eb5e96c 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2425,7 +2425,7 @@ retry:
 	if (!s) {
 		spin_unlock(&sb_lock);
 		s = alloc_super(type, flags);
-		if (!s)
+		if (IS_ERR_OR_NULL(s))
 			return ERR_PTR(-ENOMEM);
 #ifndef __UBOOT__
 		goto retry;

-- 
2.47.3

