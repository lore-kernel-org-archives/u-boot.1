Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66B1C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB15288934;
	Wed, 31 Jul 2024 09:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FRWSi4xv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7430C8896C; Wed, 31 Jul 2024 09:23:17 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC2A88886
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1722410595; x=1725002595;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Wrrbuk/fo2+nOWnwBmQTm7lbAm8hz9xAMoB4N1FBkXA=;
 b=FRWSi4xvUK48vsiIsiv1oTCCpWWdL3IX4HWhYNEdd6AGMQxXT3LVftBSzXumlPpq
 vFhmb1b+f2MQxRYnLtMmnNR8DABHsAKAVXJw0ooxO0Wm2wNxi4uxImqKYC4grZkR
 xpJZVC2av2+7Vxv2F/YwylfgJ9hOBquAZcXNyFG7D7w=;
X-AuditID: ac14000a-03251700000021bc-a9-66a9e663f9cd
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D7.14.08636.366E9A66;
 Wed, 31 Jul 2024 09:23:15 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 31 Jul
 2024 09:23:14 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/3] Enable CMD_ERASEENV for Phytec imx8m boards
Date: Wed, 31 Jul 2024 09:22:58 +0200
Message-ID: <20240731-wip-y-moog-phytec-de-imx8_eraseenv-v1-0-b8f0c4366399@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLmqWYC/x2NQQqDMBQFryJ/3Q+aahSvUkrR+NS/MAmJWEW8u
 8HlwDBzUkQQRGqzkwI2ieJsguKVkZk7O4FlSEwqV2Vevwv+i+eDF+cm9vOxwvCQnGVvfghdBOz
 GRjdQY2X6SmtKIR8wyv5MPt/rugFfJ5U9dAAAAA==
To: Teresa Remmet <t.remmet@phytec.de>, Fabio Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.0
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRpKBRzf52co0g7dvuCweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAldHx9jVjwTrWiob90g2MO1i6
 GDk5JARMJBr+z2btYuTiEBJYwiTx5PMfRgjnIaPEowV/warYBFQkHr+4xwpiCws4SJybt58J
 xGYRUJV49XMKWJxXIFTi4NxH7BC2oMTJmU+Aejk4mAU0Jdbv0gcJMwvIS2x/O4cZZL6EwBFG
 iW8NF9lBakQEvCQu/ueBqImQuHZzCVhYQkBYouGfIkhYSEBW4sX5XnaIm+Ulpp17zQxhh0oc
 2bSaaQKj4Cwki2chLJ6FZPECRuZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEEhK8LAtYOxb47H
 IUYmDsZDjBIczEoivEInV6YJ8aYkVlalFuXHF5XmpBYfYpTmYFES513dEZwqJJCeWJKanZpa
 kFoEk2Xi4JRqYDR2t+FL7budsGMmb1n/kt/3fqs2lIsGv2fNYb1bq3f89UVBwRLdRr/Cvbdc
 t740+LTp+qFtvfd6mb787RO2tRNcu4PlyM1mE8VPEdIvnnhNeO6f4BRj/J6174zY/HjFZ7rX
 b+qrrt6d/mhTvsMWA8XFuc4Cgb7zekzLubM0OR/WSAV8fLRTV4mlOCPRUIu5qDgRAPlhkrZH
 AgAA
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

Enable CMD_ERASEENV config option for
imx8mm-phygate-tauri-l,
phycore-imx8mm,
phycore-imx8mp.

---
Yannic Moog (3):
      configs: imx8mm-phygate-tauri-l_defconfig: enable CMD_ERASEENV
      configs: phycore-imx8mm_defconfig: enable CMD_ERASEENV
      configs: phycore-imx8mp_defconfig: enable CMD_ERASEENV

 configs/imx8mm-phygate-tauri-l_defconfig | 1 +
 configs/phycore-imx8mm_defconfig         | 1 +
 configs/phycore-imx8mp_defconfig         | 1 +
 3 files changed, 3 insertions(+)
---
base-commit: a9c962941e119017eb9d5985c5c214d9711c9433
change-id: 20240731-wip-y-moog-phytec-de-imx8_eraseenv-c68e2f5cb566

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

