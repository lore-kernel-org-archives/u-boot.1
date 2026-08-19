Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE96FC5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75C8180EB9;
	Wed, 19 Aug 2026 03:57:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MK_NrEIxQWNc; Wed, 19 Aug 2026 03:57:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111859;
	bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q/kovN1DMPBk4kSfMphyVl+cJQjlagN0xJ2KZFHWoamKu2C7Dm0I8Um0TAmH1/lD2
	 S64gauXqL3Eea9M7S4dchci2OBIL3yZJz9Q5MHoKTe6aU30uVZI+y/UzcuKKXqZdWw
	 ZmmAeMoYFxeLnpk35AflPnwITFdqX8Gw6pz+mHKNWwmKGg++vWLX+11vCBwI4Ius/D
	 9o8R/2kOdi2PcDUbNF930YmqI32lkK9TuqvkzfG1e1LMM5f0HqAXFJwSimgVonuNl0
	 E6d7sA5CKf+Mbh/U0yULxVCW/N6XZCrRkWGgOYb2Dir808bHA1rUxn/qK5c85JYb9B
	 q/1bBMnpwUg6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7A0E80E9E;
	Wed, 19 Aug 2026 03:57:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C0D939E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52BC84009F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9JTixFxnfAz for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=o6Yl/rcd
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FAE340077
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:36 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cab973140bso7445375ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111856; x=1787716656;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=o6Yl/rcdcdZDshB3QhCHeVMVa/8ZS9pDJlERN30OyhYIa/akWQGh1i+JAroZCkbHGB
 D1ctyrti/ebYgcV2ZdN6GtMSf4AecX4eDkA3j1wrRKkOpvwTr9F3TSbDU8/LieAwFD98
 mFCdEKa/0B8iHd4LRy44knOUT3wFU4NXFaxL2jVHOjmnCPvHo7NXAuTkEhcTxvqL2hXS
 jk9xpFNyuUvwJu2fxXH1bAREGWoLgO6gleQ5z0pk+fW25WkDDHaW7n23I5+cLq08PD6c
 Cd6yXzkyStn5uJ5cGp/htd7uVeX0JxLPaGScf0KUB/8dws/9I3aunSNnY3u6zUY7O/V0
 ajNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111856; x=1787716656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u5gQ2F41dky5wd1j++HGBuzitKIC3uObZl7iYjOMjnk=;
 b=XSX4aREzNezXRIplxEiOzr5OqaXypHLHe413Sxc7skwdGhWDbZV5ZMBuL1c+jdT157
 dcCqtGibD690e6aTOY1SeoXMOMpPW6sGnro30GZFSKVKDMCDW64mHVXQx7I4MOeV+oiL
 xYlgrnZ0koHAVA/mZd+9qU5E3aHvpB0yEE5zuiGojuvtt6luJikNYaBlYP5itKvb7Sb6
 7bzdG3BgzODww7EzwFztXKs8XWnx9fqEN+Cxf/9nM9D2yJiiccK3QzbE6MgJgAR+B8P6
 fIxluRJ2bbUkpHArYpPsTrSp2R8ZCzJ9GFJ4oPKCtQ04OykpOYgJo7D1WXQBoKA8/23Y
 eNuQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqj8paoCnq26FcbdvS24M5kEsf27ywb3xJJ9/qDDR/jMW98Q3SfkDRqO74KozoEiv7s4jIUIwE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx+bJd+byEdlOwiAQICDXxebUZuFdE/Wqqq5PuiNYkKYlAnnI0E
 GcOiynBzFHQ5kOCShS6cOPFdD4quatHplEQR/IP+AtPLBf19YI6zxsLrCi3RCEIaX0M=
X-Gm-Gg: AR+sD10LgO/Q/N0tsMLNAIJyQjwUszY059JFn/kMaIhtLwCBFw1lx5NT36djMaSeS4F
 eHkRtc+plGtAT+5oSDlSSL9iEfa7+wxO4pDNpgc9s0Hg/Cw5Le1yr+a6BOkkprBmScNRO7K2oXt
 HJz4SyFyt7o+5nXX9qpRHwBLsXFNh9f/kr0+Ejb2pBweqmQABmj2vbV2eYHxABTiUpd6YJrmvx7
 JgY6XXiTjkEYOuujzgbXm6sjnmE8NCoowYSq2Tot8VvVwehSzUFczLNST3c8S3hIckZ0/CvI//y
 NSpR7HTIazkxVUOTmp7OQ+KmSr9cRkl0cteSCz8Db8rv39ESMFvzEv0SBv5Mh2ApRhXLyTOBxxB
 b2asRxEiSbTTLnpx/Xni9GEF5xcs1hvC1ToKFBpK9xwhMqPDo7VyyoWzAZTNPa7kSQ10jxIVj0U
 AtVEnmPuzX/UJs4K4sJRvJ7WYUIn8jON2ECU3J/OJw//JYTmTI7gAz4AFZPuxZ0EPFvKbpvckno
 iqrFJvhrlyo5eYtulwGiqd5B1cQ0qVal4WWnMaYzQRAFcnwQFq7SRyekeuEKEwJlf8tPLhSCLU/
 AFY9AFRUaXFTCi3FBLJQqe+/sOY=
X-Received: by 2002:a17:90b:268b:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-395810b3250mr3272639a91.10.1787111855848; 
 Tue, 18 Aug 2026 20:57:35 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:35 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:59 +0800
Subject: [PATCH v9 17/19] MAINTAINER: update Spacemit K1 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-17-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Update the maintainer for Spacemit K1 from Guodong to Eric.

Add mmc driver to maintained files.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Add mmc driver to maintained files.
v4:
- Update the maintainer.
---
 board/spacemit/k1/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 32d47ecc8f1e..4b2bc4ecfc10 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@gmail.com>
-M:	Guodong Xu <guodong.xu@riscstar.com>
+M:	Eric Chung <eric.chung@riscstar.com>
 L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
@@ -9,6 +9,7 @@ F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
+F:	drivers/mmc/spacemit_sdhci.c
 F:	drivers/pinctrl/spacemit/
 F:	drivers/power/pmic/pmic_spacemit_p1.c
 F:	drivers/power/regulator/spacemit_p1_regulator.c

-- 
2.51.0

