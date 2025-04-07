Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82250C369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1A583125;
	Mon,  7 Apr 2025 22:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Td+6iXRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F110A82EAA; Mon,  7 Apr 2025 22:02:47 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E63F82EAA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso32401595e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056165; x=1744660965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s6I56aDrJhtZws1wBDSiL2xEFDq2AIxZpJnbMwAxDUc=;
 b=Td+6iXRnOMIzzK9/LpD0pJ4Rv2SDFvLebeiGkk9fhlrfiP7iauZmpC+QbjS9Av/Qam
 F6KBNFens1wlhRbeKb2FmB2gH8TCCL+2rCntCxy6jmfSQ5F+p49nwW14yCIp19fg+otc
 71awnSJLLV7/YJg6ap7546iNhe/aEqH1kkBBX1UAONv78Ariu99PE9l4X+Ow+fX7niXz
 kscjbuBiY3s+7kdEDiwJn/+hlGSXiaKFAqxsnpR+9zcHt6DUAFQXZldVBOHdtRmGxV0b
 Ndnt6RXis74IZGqraZ9SBYe9AEqHRWo2bsm/xCKvOLu2V9Sf4KXxU1UCCPo01/tF1b13
 8DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056165; x=1744660965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6I56aDrJhtZws1wBDSiL2xEFDq2AIxZpJnbMwAxDUc=;
 b=No4dgX9Jf2oY5IKWhnptg8uuSoUpFYysKp35BD1VEj03FAxDo3QGAHbFKtJeqESnq4
 1TY50F8bYPj6qxHrNTiTlUkqW2pIQLXkq+pPDJKmTtAWLhucb9NZ/tBgyKHhnA9WtKnW
 yKQJmEAUuqFn6LfC2raSyr5MHxW2CQCLR6ZhhzWS8YdHFHHg//7RgxMsgNaPNgYb8xAh
 pmPiQsimFT1txaJzcADLgBfGX4a1BjFbpfh1R1SR0ayV4D/FjQwfhatyLtx6ddwV7b4E
 x30SIKriHd5BwsVMf3lshgV4JfS7h8NHerFwuXzMa7T34zjG5/RNoFsrscluyftOsJZv
 Xtcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqsqgTiKx5SG/jhl+oaqGztSAEnMemaR16aSDpgnrTVb09J2PQRQvQe6CWALuCIJmTF0oe7NY=@lists.denx.de
X-Gm-Message-State: AOJu0YzmIygh97MoW2aZOGXNtB0kU/3aQLjnBceDjd4ZBZyxHVAX5MiU
 04F4NUP/Ye2uo7/CfiZ5aMWv498F87slj0suXaBcWpJe1vE53ojz
X-Gm-Gg: ASbGncue7P1JUo2SL83ZqkUZe96+oUruoW0clcRJM6Hd4YPZ51i+4J5zsV0lt1JUZyJ
 /P41VuQ1jNT3dooY59cB7atILLFK72S4mg//9e3KfFhtozupjsSBxFjdQfmW5F2IVNcM1Ks/D21
 9NFnk6tC13w4SC0Andnw1MZ2Y9dqQ5LqvaaCNALHEPp9ZW59N9b1J0H92urw5lCycDDAXU0aClQ
 rIbVSxWYKeyHqKt8f7TGfsdjml4If70K4gw7FKyUOVvrOZIS/390Kz4uLmY5aTdEa1h9Bjphql6
 ZJVRNMAWcAymDjhU4P3cREQKexADtqNs4sixBI47aH3eH4iqjZ9GHOf1mt1t6dZzp0oiGNCDm/0
 PjbElHglgTvZs/w==
X-Google-Smtp-Source: AGHT+IHMAkcefVLngIQRhhCTeXUq64d/CGmaJSBF64uD5cJmFpUy/N7Di3D05GTsSf6Bz/oJiAnTrA==
X-Received: by 2002:a05:6000:2489:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-39cb35aaaeamr11201675f8f.32.1744056164746; 
 Mon, 07 Apr 2025 13:02:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c301b9d55sm12723354f8f.42.2025.04.07.13.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 13:02:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 10/14] spi: Introduce setup_for_spinand()
Date: Mon,  7 Apr 2025 22:01:54 +0200
Message-ID: <20250407200208.25594-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407200208.25594-1-ansuelsmth@gmail.com>
References: <20250407200208.25594-1-ansuelsmth@gmail.com>
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

A common device attached to SPI are SPI NAND and some device might
require to have info on the attached NAND to know the flash page size
and spare size.

To support this, introduce setup_for_spinand() that pass the attached
spinand info from manufacturer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/spi.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/spi.h b/include/spi.h
index 6944773b596..28f127feca5 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -10,6 +10,7 @@
 #define _SPI_H_
 
 #include <linux/bitops.h>
+#include <linux/mtd/spinand.h>
 
 /* SPI mode flags */
 #define SPI_CPHA	BIT(0)	/* clock phase (1 = SPI_CLOCK_PHASE_SECOND) */
@@ -537,6 +538,16 @@ struct dm_spi_ops {
 	 */
 	int (*get_mmap)(struct udevice *dev, ulong *map_basep,
 			uint *map_sizep, uint *offsetp);
+
+	/**
+	 * setup_for_spinand() - Setup the SPI for attached SPI NAND
+	 *
+	 * @dev:	The SPI flash slave device
+	 * @spinand_info: The SPI NAND info to configure for
+	 * @return 0 if OK, -ve value on error
+	 */
+	int (*setup_for_spinand)(struct spi_slave *slave,
+				 const struct spinand_info *spinand_info);
 };
 
 struct dm_spi_emul_ops {
-- 
2.48.1

