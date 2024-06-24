Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9B7C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 21:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6523D885CC;
	Mon, 24 Jun 2024 23:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=odyssee-systemes.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 155A6883E7; Mon, 24 Jun 2024 21:49:41 +0200 (CEST)
Received: from 3.mo575.mail-out.ovh.net (3.mo575.mail-out.ovh.net
 [46.105.58.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5F2882CE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=odyssee-systemes.fr
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marjolaine.amate@odyssee-systemes.fr
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.176.32])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4W7JSy4FJnz1PH0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 19:49:38 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rgzl9 (unknown [10.110.96.170])
 by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2F37D1FE61;
 Mon, 24 Jun 2024 19:49:38 +0000 (UTC)
Received: from odyssee-systemes.fr ([37.59.142.95])
 by ghost-submission-6684bf9d7b-rgzl9 with ESMTPSA
 id eh6vBdLNeWZZcAEAepRnDQ
 (envelope-from <marjolaine.amate@odyssee-systemes.fr>);
 Mon, 24 Jun 2024 19:49:38 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0016437eb0c-4c4e-4773-b8fa-4e379684c7cc,
 F6C0AEFBAD486127301FF0EA271F04B174220FCD)
 smtp.auth=marjolaine.amate@odyssee-systemes.fr
X-OVh-ClientIp: 194.146.15.227
From: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
To: u-boot@lists.denx.de
Cc: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
Subject: [PATCH] pci_ids: fix i225 unprogrammed value
Date: Mon, 24 Jun 2024 19:49:07 +0000
Message-ID: <20240624194907.81341-1-marjolaine.amate@odyssee-systemes.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14830916525938962929
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeguddgudeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhhjohhlrghinhgvucetmhgrthgvuceomhgrrhhjohhlrghinhgvrdgrmhgrthgvsehougihshhsvggvqdhshihsthgvmhgvshdrfhhrqeenucggtffrrghtthgvrhhnpeekjeeuteevhfdukeduvdeiffelfeffvdefffeggeffvdelgeejfedtjeeltdekffenucfkphepuddvjedrtddrtddruddpudelgedrudegiedrudehrddvvdejpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhhjohhlrghinhgvrdgrmhgrthgvsehougihshhsvggvqdhshihsthgvmhgvshdrfhhrpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Mailman-Approved-At: Mon, 24 Jun 2024 23:05:18 +0200
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

This patch fixes the I225 hardware default value
at 0x15FD meaning empty flash image
or the NVM configuration loading failed

Signed-off-by: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
---
 include/pci_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/pci_ids.h b/include/pci_ids.h
index f1886c3a75..b2136d3e9d 100644
--- a/include/pci_ids.h
+++ b/include/pci_ids.h
@@ -2710,7 +2710,7 @@
 #define PCI_DEVICE_ID_INTEL_I211_COPPER			0x1539
 #define PCI_DEVICE_ID_INTEL_I210_COPPER_FLASHLESS	0x157b
 #define PCI_DEVICE_ID_INTEL_I210_SERDES_FLASHLESS	0x157c
-#define PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED		0x15dF
+#define PCI_DEVICE_ID_INTEL_I225_UNPROGRAMMED		0x15fd
 #define PCI_DEVICE_ID_INTEL_I225_IT			0x0d9f
 #define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
-- 
2.43.0

