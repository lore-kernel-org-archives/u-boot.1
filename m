Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFCFD5E12D
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 05:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9AE89082;
	Fri,  8 Nov 2024 06:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731043322;
	bh=MeVWMA4dY5W1hxkDFyaUtLTezPvNUcfVYVZJN4bHXzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yC1kHZQlgPuFN0VubhBGlKUUTEFiKiuN8HiVZ5ckgV1KJS8tFdN4uUxNcv5BkKW1V
	 wprpKgeyd1SV+ikGzT2hUpJQocWlAkJzgcWU7BIARXocJ8XIqCqDpCPG16Z6APo/tl
	 AI74JhUX2EBjSfRDfHJ9Q6eO6BLMpPAcXu+BpHkHySimPbhKbXivHiNbItTIL+LBV6
	 MezsBSr0nZs3cMxIAvjsrnmNJ1viRmEbe+nRqmyqGtYr/iv5lu1p+G5kgElMrUB8ZZ
	 BF+lnmf1uHqkYUI+sAowz7/6BTuJlDyThpVuj+XO/8Qzp/ts+aKE7y8v2L3y9H6BgR
	 ze8sKRlqH60Cg==
Received: from localhost.localdomain (87-97-112-21.pool.digikabel.hu
 [87.97.112.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 003C988E3C;
 Fri,  8 Nov 2024 06:21:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731043320;
 bh=MeVWMA4dY5W1hxkDFyaUtLTezPvNUcfVYVZJN4bHXzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A0pBX9RWg+HNWjwtxM8UCd5TqkADg/8rtylZzZtZBk8RHn2C+t8bI6Gx478q9IPHh
 4q4u5tytpIh0lF4tYhCf1K/Eks9+/3DgUzgOIze3MMK4GCvUwBcKWDnb81kjAQACC8
 RDZQea14ceqUKFoRLEEguHDW8+3hLnqTpNOW17Pl5LXATJzn9Kh3yXb6dd5mZp952q
 ZGztC95GsdwQKOLUDx8Y43tRwDIQjx8+ozqtcs1vRotC2d5DfJpjCosnqTxmKB9f+Z
 LBktUtE670RsYc3Gm/NhhkQ5WPqJJnImU2a5HcqPt4VOHb/pint5rW3WL9L9Y+Xdwj
 3slrufPjzyYrw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Enrico Leto <enrico.leto@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 10/22] siemens: imximage.cfg: sync image names
Date: Fri,  8 Nov 2024 06:21:31 +0100
Message-Id: <20241108052143.26874-11-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241108052143.26874-1-hs@denx.de>
References: <20241108052143.26874-1-hs@denx.de>
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

sync the image names in imximage.cfg with
the ones used in arch/arm/dts/imx8qxp-u-boot.dtsi

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 board/siemens/capricorn/imximage.cfg | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index f73c5a7a9b0..7fd3fb8b72e 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -15,12 +15,18 @@ DCD_SKIP true
 
 /* SoC type IMX8QX */
 SOC_TYPE IMX8QX
-/* Append seco container image */
-APPEND ahab-container.img
+/*
+ * Append seco container image,
+ * use same name as in arch/arm/dts/imx8qxp-u-boot.dtsi
+ */
+APPEND mx8qxc0-ahab-container.img
 /* Create the 2nd container */
 CONTAINER
-/* Add scfw image with exec attribute */
-IMAGE SCU capricorn-scfw-tcm.bin
+/*
+ * Add scfw image with exec attribute
+ * use same name as in arch/arm/dts/imx8qxp-u-boot.dtsi
+ */
+IMAGE SCU mx8qx-mek-scfw-tcm.bin
 
 /* Add SPL image with exec attribute */
 IMAGE A35 spl/u-boot-spl.bin 0x00100000
-- 
2.20.1

