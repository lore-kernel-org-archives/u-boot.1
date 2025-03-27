Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FECC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 10:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC62A81273;
	Thu, 27 Mar 2025 11:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pbVJ1CA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C721481951; Thu, 27 Mar 2025 11:31:37 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818DF8070C
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 11:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AD864427A;
 Thu, 27 Mar 2025 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743071494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TdGEwI5Ou9MifyXP0xiC5A3ACYwaRDf3zMujSsi/M8Q=;
 b=pbVJ1CA15hRgibWxkcsLQshGGSAq4SpakW+Ye1LIUY+k5lPGaxZ2PejuXb4/GblSQEmAXh
 WyDv9yeHxCzIBuJSBJvzSIcZr7X3alX82BG38Kgwu7fA6qm6TMeexYrA0mydkfYVz7FBWB
 moLJNZZp74Qq/1+Ik8uFniaWdxftXNgkFJMYEfKYbda3iKBBJ4LknSLB7ISNw3aSMVrYsO
 QxDVQ1IhxYhPbqrmSR0SVQonTnFVcaOgbna1sfQkOcF9ZIKhN+Bm816orsu0Hn/KvFAVBz
 SPbP808TnRwPJKiO6dRj8I6ZTP+KEFUA738y1mBnu+aXZCI1su3e+wu91ElxNg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Robert Nelson <robertcnelson@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] board: ti: am335x: Fix selection of BeagleBone Green
Date: Thu, 27 Mar 2025 11:31:12 +0100
Message-Id: <20250327103113.417015-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgedugedvkeelhfehfeeuieeigeetgeetuedugeetuddvveffieekgfejkefgudeknecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtrddrpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehrohgsvghrthgtnhgvlhhsohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehtrhhin
 hhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehjvghrohhmvgdrfhhorhhishhsihgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrhgvkhdrvhgrshhuthdorhgvnhgvshgrshesmhgrihhlsghogidrohhrghdprhgtphhtthhopehilhhirghsrdgrphgrlhhoughimhgrsheslhhinhgrrhhordhorhhg
X-GND-Sasl: kory.maincent@bootlin.com
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

The BeagleBone Green board is a revision of the BoneBlack board.
Having BeagleBone Black devicetree listed before BeagleBone Green will
select always the BeagleBone Black devicetree following the functioning of
board_fit_config_name_match().

Fix it by changing the test condition and selecting BoneBlack board only
if it is not a revision of this board.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 board/ti/am335x/board.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 774ef7ac5e3..f738cba7bd1 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -955,7 +955,8 @@ int board_fit_config_name_match(const char *name)
 		return 0;
 	else if (board_is_bone() && !strcmp(name, "am335x-bone"))
 		return 0;
-	else if (board_is_bone_lt() && !strcmp(name, "am335x-boneblack"))
+	else if (board_is_bone_lt() && !board_is_bbg1() &&
+		 !strcmp(name, "am335x-boneblack"))
 		return 0;
 	else if (board_is_pb() && !strcmp(name, "am335x-pocketbeagle"))
 		return 0;
-- 
2.34.1

