Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B36E8782C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C361A8419E;
	Tue,  3 Feb 2026 14:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9U5zSbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF2883F93; Tue,  3 Feb 2026 02:29:26 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD2383F54
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 02:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-4094fbd1808so2082473fac.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 17:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770082163; x=1770686963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MU9WtLF/ByLYtXf/cYEty1QiYJUO6ah1iez++VXQykc=;
 b=A9U5zSbdP4DTTmkFKtZaZ2ulql/oMfmf2SqT8VIxSaikS4HaIosST6JmMZ7/gEbTC8
 YkcSN4TXiHa+bJ0mpPQBq8+uFrPj2jfVrQb/JoaW9k4SkAvYEnDmxgy82YpbPYZWc5c7
 TbJg7VZb5QQXwjl2NLkknPRd4JcNSfoz583RJVx29SMOf8/rPyxhR/ZSWziufX+UfiZ4
 2iuCg0UK5gGHISvEhFMrWvmqPWKPeF7ywB2Rx9vUnzn8x+Id1MtbvVZIlO4TvWdz7pVl
 3/1KBuiGSbQ1LdLzwLcqVc5xYbxQw8opHNgWtGh2RvYLmKErfpjg9KWlHDtaHUuku1H4
 Ebmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770082163; x=1770686963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MU9WtLF/ByLYtXf/cYEty1QiYJUO6ah1iez++VXQykc=;
 b=GT2yWq0eiRoI/9dR8Z3zTcNjr+sm/2fCXEzA7y82og93X94C5c6f42f+EYQ4pJnNjs
 a2zmb8GT+CGTPm8ml//vPv3RcFANNRQDHMNXLaBbNHO52rYHBXEFzNMfyvY6e8mf7HiY
 fFHaNALvfeqnlnldRiDLyPaPvBTe+yoVJ6WEGnmxFFOcQh73GNDR9C0j144jMiaCDR7W
 y/4edOoETotdAkt4rhCr3fGR+GXeUZTA3+YHvzTALi9sBsSxxu6EyKcwCBUW39aLb1uX
 DsC9GhYeTg38dVCBKV4wgnYC/3dbU6OdMmlISpidECy9W/oUN9U+4/TWkS2eOWRq3mSz
 o3/w==
X-Gm-Message-State: AOJu0YxYGNbBuSBGCPjY+Faa9QtSLXdQtrSjikzMapAy83388FEQU4ai
 hsgYW5s3lOi0tvHeHp4KIhXZYhB9xRbFh+IqrA51LUpWygxqV+u1jLPbG3AR0A==
X-Gm-Gg: AZuq6aKvNiQtDmn/redOMRfkAwPEhl8GXLXNJPwUwKnFaykurVgOl0bA9R5Ex6IKgWQ
 cDredCrLCegOOTGkNiizLyUpmwkt4dFIhnW/E/0uhPMYameCYHqM2w6sPnABssm6l5nYVpJJcSC
 ulfsj7HKDQjFUExaQ99xjvMsTZGBmZoBnE29DjBF0+b4iI9TZD/fuzz1YSqGaO1PXwSOb1arMpM
 FH8V+9CaiRZBXD/2kHX6iIbbVdDGdAoZgxp7pE1lh3T62R84AXXQhkjgtPSdsxKr/D2Ha70YsiW
 lGNHyylxp9ysvHQWtX74DZOKdzLsf9uUF/e1LwIGnwTlNjF9nLmQG8hpdWrqz8uau7h+iDcTdqP
 jqRHir2sbrxd922fuqcrpp//BQ27GPsVg8rYTi9OCZ1xRAQkE4IdxCSYrhTMITpfGGIZb6LGh91
 dpiVCO/aUPv//7GRDs3yo5VAW1jAcIi7ugLaWx4H+9SAqWFgsqj6eADeBTkjl/wIjYJTZIc8q47
 Nr+VBjkt5awVypflb3F+F56VW+JWOiJHFGgEUwHKg7QH2cIlIGJmw==
X-Received: by 2002:a05:6871:ac0f:b0:3fa:47e:4de4 with SMTP id
 586e51a60fabf-409a6baeaf3mr6074422fac.24.1770082163197; 
 Mon, 02 Feb 2026 17:29:23 -0800 (PST)
Received: from james-x399.localdomain (97-118-146-242.hlrn.qwest.net.
 [97.118.146.242]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-409571ae8f5sm12188539fac.9.2026.02.02.17.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 17:29:22 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/1] tools: imagetool: Disable TOC0 anti-rollback protection
Date: Mon,  2 Feb 2026 18:28:18 -0700
Message-ID: <20260203012819.3406450-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

Allwinner devices which support TOC0 have anti-rollback protection
efuses that are sometimes blown to prevent downgrading firmware.

Since we don't currently support configuring an anti-rollback version
lets just set the max version in the TOC0 certificate so that the
sbrom will never reject our image due to the anti-rollback protections
having been used by BSP based firmware.

Note that while there are 32 efuse bits the SBROM will reject any
antirollback version above 31, as such setting 31 should ensure
maxiumum hardware compatibility.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 tools/sunxi_toc0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/sunxi_toc0.c b/tools/sunxi_toc0.c
index 76693647a09..35bd43680d4 100644
--- a/tools/sunxi_toc0.c
+++ b/tools/sunxi_toc0.c
@@ -127,6 +127,11 @@ struct __packed toc0_cert_item {
 				struct __packed toc0_extension {
 					toc0_small_int tag_digest;
 					uint8_t digest[32];
+					toc0_small_seq tag_nvc_seq;
+					struct __packed toc0_nvc_seq {
+						int oid;
+						int nvc;
+					} nvc_seq;
 				} extension;
 			} explicit3;
 		} mainSequence;
@@ -174,6 +179,11 @@ static const struct toc0_cert_item cert_item_template = {
 				{
 					TOC0_SMALL_INT(sizeof_field(struct toc0_extension, digest)),
 					{},
+					TOC0_SMALL_SEQ(sizeof(struct toc0_nvc_seq)),
+					{
+						1,
+						31,
+					},
 				},
 			},
 		},
-- 
2.43.0

