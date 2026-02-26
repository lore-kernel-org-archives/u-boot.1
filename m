Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADACFCE081
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 13:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF46F83E83;
	Thu, 26 Feb 2026 14:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e/nZ8KQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DB683D1A; Thu, 26 Feb 2026 03:26:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C6083642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 03:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A2893F0B1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 02:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772072790;
 bh=mWVVuUSEZhwInqN2I2ZQr7Mhg/R/tJqclm0sTBTGJjk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=e/nZ8KQY8iUYqFqVKlRvDl3+b9O0LD8i3ql7it0M6Ne2bW9bukcVaLABaUKH6ZpnI
 3jOLnjHGxth+w0sSc7KVl66DFhymSYaZgeY6bZsbxL1+DAhKLlIxtE9DGwMdMzqiRT
 StfiB0izTMifFL6swLl0+UMyesP3g3SBJgYW09CU5wsbS7ww5WyBWIse7Xrt8+8N7N
 wNJ2QR5AaBvlI6PJt8pOTCEBj0GKNgf16lbGR8DaFJIIJ8K7Crr67PSAfkjWfjGBg7
 9WVxbuuMJ2aq6U43lIxNd/IMRsaRC/oQswZ5IlBb006JmDnquzpqYtdirZMZvItp1M
 Sy3LeB14LmoJXjApkbySd4zVRl1Tw7oJXf0gu5J2oxhv/KIkmb2LrOQXJlqLyzKYZm
 gUGbeMH4MEkqn0GgErFSzJPzr7KMJ1ACEaZNBMxOotebHuCK8PkP8dhYA9uPqyX7yh
 iKxWH5KqaennZGDvCLuSfkARt5Qv6Wtp9tWvr9isi9Etm7FK/fXDUB2CW/p8hwsoqj
 a5PP2eTi357Mk/9CbaI9C4vX7v3RTzNfh+MbIeXUjiRj/4JiAPr4kllcEy0uGelGeS
 u2sPj5mwEQbluyLtvxCgBm6XFPwTVz+2enjdp9XGkpeiVCz+bxhdnYMurr951sORDO
 Y5bteEw9sQaZq8AcAiVFaoMY=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837c597cd5so1528185e9.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772072789; x=1772677589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mWVVuUSEZhwInqN2I2ZQr7Mhg/R/tJqclm0sTBTGJjk=;
 b=rOyDng6UWDFs2n6JZuxqcVhKjoe2Ce50hj4tXS3CEFgm3MTC6g+rgvnsokLt8owbF3
 9d3aduuyRmTKq8TxLzjYL7LD1TZYRvtb4HlKt41Hu0FoT1g8pMmGa0g2Q+RF4eCAUsQm
 B6asz+wKshti3TMFdW8IF9C/gytAd98+YkeIEHcBPYpi8v781Jra1DaIfRfXI0ZNzSHf
 h9EXeW80TzX0sRtbUxAwvJBdHl8acbOqmU0KjEzQF+vaShiBbjQFRcUlKAhrCM7ykYMO
 Noqlkq6TfjImx9m61kR/ArF3zmLVNcAfzeLN2e+XOtgFI6lG7p98K2y7w4SDtx3zRCof
 jFUg==
X-Gm-Message-State: AOJu0YxMvtYZmy6Yd6Zl5WFXfEmAmFlyZuMpguk2kVCEjSOLrfQx+zN4
 829ojsVOmqa+bm8JcDuQKzXMNAokXzfDa5H6XmHrmquO5jvvnaRMFL5diOabiriHS7DCXRAD+hK
 qMT5zfevEsnTt4xrFMD/NeAI2u3AF0eByh+VZKLg1xl7mgFgxebThEtbCfhStTtEGzK/fUjEB5p
 XwFk8=
X-Gm-Gg: ATEYQzwV3K/HAFacAK8dB70jxNzRIfXttjZnAH7MCtsiBadhmx6WlnU95IQAO5LqG33
 7FF7yfStjeOuhFr/Z8HOgX+wM/O74fV5CYJnq92t6nDSL/rJfMLhPfpP8rAO5/8uVfiG+D4/vPc
 7W2aoyz/hM+dUSjWJix/W1JVml/QtCpzO8/kFiT+34/bAUsX4wixR44CY3W791zu6xuKKFGUF2r
 BqQiYMccnNbZ4M/kABVDFrKNm2tB3UbVRjrbpKYrICDrdS+T1LE7qcGQ0abLp4g7r2TRd3UnVTS
 ewHOJPvWG4/+oZdq+df24pnStk+yq63AnV2Qw8PJnR+088+L1LdgGR4Y+Goml4CMdFO3J4iYHHO
 ssrc4CzFawf5mnNcLa/pQMK/6aXnUlZik1wOMsxaDogpeXDsEwGfYZCgUSUwiQhXOJlgvtg==
X-Received: by 2002:a05:600c:528c:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483c3db5120mr8278815e9.1.1772072789389; 
 Wed, 25 Feb 2026 18:26:29 -0800 (PST)
X-Received: by 2002:a05:600c:528c:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483c3db5120mr8278535e9.1.1772072788970; 
 Wed, 25 Feb 2026 18:26:28 -0800 (PST)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b44207sm11521905e9.7.2026.02.25.18.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 18:26:28 -0800 (PST)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/1] doc: pstore: fix typo
Date: Thu, 26 Feb 2026 02:25:16 +0000
Message-ID: <20260226022550.2155-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220031841.15708-1-aristo.chen@canonical.com>
References: <20260220031841.15708-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 14:43:22 +0100
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

Use "parameters have been set" for correct grammar in the pstore
documentation.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 doc/usage/cmd/pstore.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/cmd/pstore.rst b/doc/usage/cmd/pstore.rst
index 63a437135ec..fd3425a1dc2 100644
--- a/doc/usage/cmd/pstore.rst
+++ b/doc/usage/cmd/pstore.rst
@@ -80,7 +80,7 @@ For test purpose, you can generate a kernel crash by setting reboot timeout to
 Retrieve logs in U-Boot
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-First of all, unless PStore parameters as been set during U-Boot configuration
+First of all, unless PStore parameters have been set during U-Boot configuration
 and match kernel ramoops parameters, it needs to be set using 'pstore set', e.g.::
 
     => pstore set 0x30000000 0x100000 0x2000 0x2000
-- 
2.43.0

