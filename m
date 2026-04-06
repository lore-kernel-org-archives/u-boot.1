Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED065F46C78
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916A88415C;
	Mon,  6 Apr 2026 21:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tNyGeUox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9710183C2B; Mon,  6 Apr 2026 21:21:39 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DB768352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8a23f802e0cso69843526d6.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503296; x=1776108096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+Xbjk7F5jiYZOpED3P/2VAc89G/ssZFPE2ArW137EY=;
 b=tNyGeUoxlLmIiOMOQ732T6ikmp2DEWL9fhWK6nRx0CQjcIP+3pgY4FvDJxYzUSWCDv
 G+vzm6WVg4z7CbptjyssdpD1t3r0/fh8lXwea5CIZPi6kZakKIJYLGACq5BB67vqj7cL
 Ps2LzxmkzxchqVbF/1uSv4IDWQ+Z/zq+qQ7DAkrtOZcc1xQNXLq+DEJb7CFHwvD4Xp93
 Nhsvy6+rRnGuwhrXzBIQS2f9JB51wmURGiun8S2XEyA29C23q90hkTSvchOqjf0jhrWF
 +nWb8eVkTP5p9KDmEwi6oSdSFfRKQiQ+yYWMn1qLRW/+2Hw2bw+nVvcXwH5rLHCKpqGV
 IuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503296; x=1776108096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+Xbjk7F5jiYZOpED3P/2VAc89G/ssZFPE2ArW137EY=;
 b=HakC5h252I3pQ2mRpG2QpByJZukANFZjQwNVBdSsf72XXb9Z+ecMOgaA/8SftWTqzB
 d8r4GLMW5zFQx31QaZfip0A3yxhQOx1oBuRXDnNV2SMjm99256UWg1hC/AbH3Q+AAtkK
 MM1lOooSdJ2QBlVRX6eigctg2u3WgdVop3v5OIKJd7x1HDWsUsvjdnuI/2GOPFeEeqyt
 r/ZB417VkpN3CPnIBHcuaqU/vYTPS1w4T9CKqHgOpHQdnWy7ydX8Cjp4GsJy9xJ03Onl
 r/D0I7Ad854SzWZ4UJjyITtsnM3aueqrYu9fhaMk+IP5raWNb6Bg2fdtt8l5LXynnh/h
 4iQg==
X-Gm-Message-State: AOJu0Yx2tU4t4MulFFUQsmKuMe0iv1T2HifNXKaHQrOrRA/wfNQO4tIg
 KcLwI7eEac84rf86jnXrf0AkH/uqL8qvxjc1jk618jUUfmwbsTLZ8lv4ij/BD2pZ
X-Gm-Gg: AeBDies55FtizMAdQ81MJK3QKI5Dujnx85ztzqYwIyZh3Fa5ORPk1nsTA+LpkkvBk7y
 LcKgH1NoTgtHGQfIt6uk4eEIRNhPA9FWFQ8vPVRZzo+aCB+XYnP5mk/bDBfM1hVMdS03fVRj6nw
 kxeQU4cTbHt6VTLTCWSyLZfqV+Cg6IsqxMDmQdpY/lo2Er2s1hnyc9v1186CDpOoDj8qMfmUp07
 ghm9mYiZ4zwzz8izVr+HdqIndzeFidZX9uhIHYZhTUPSSunn29JaxhlimR1K4j9vOlEzazdDA0N
 eHFXGohPDVI+ojUWFmiSGat8aCnAFuiuwTb+ADXDul0mPVOoBMdKW8l3bEyUdh7rwi2plsjLH4j
 bF+EYJWjyKYYVbjlt+PHj0K4vqU4xnMvgTUldSqKMr4lZF85Ugwiw+yRk99GybCfbUo94R53DYn
 pY0QTpeDHhbxVtyluWtTxpCXWyVzpOomJCpE96U+UxJdr1
X-Received: by 2002:a05:6214:4a89:b0:89c:ed12:41b with SMTP id
 6a1803df08f44-8a703d215bfmr242672406d6.31.1775503296205; 
 Mon, 06 Apr 2026 12:21:36 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:35 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 07/13] dts: sc594: Fix gige-reset line on EZKIT
Date: Mon,  6 Apr 2026 15:06:09 -0400
Message-Id: <c55d472eadf333dba4c8c3f3ae65803c166cbf53.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index afc16df577a..422dab9ff50 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

