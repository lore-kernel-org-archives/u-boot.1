Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3642C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B14588828;
	Wed, 22 May 2024 16:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="N7IgFsxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C7C887D9; Wed, 22 May 2024 08:18:45 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B5A87F4B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716358722; x=1718950722;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hg/B9MIOzPGGGYO9eGASDZvDHPUCzcPePe6MYi0u3ws=;
 b=N7IgFsxv9E8e95QQdfraf8ieDJ+ZDdHwBtE5rdOMRyJ0MU8DO8abdrybgrKt9fRj
 mXyY6WYkGSGI4hBy/Ywa8Om/THtsq542XbfEHI/hmzCfLvuPR++EEHCvA8HnwQCe
 HAaqluSDlsvUvgtu2T71Rt+NZd6yP2SI8bgv9EBfJQ0=;
X-AuditID: ac14000a-03251700000021bc-59-664d8e429fab
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3D.00.08636.24E8D466;
 Wed, 22 May 2024 08:18:42 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 08:18:41 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 0/6] PHYTEC SOM Detection API v3
Date: Tue, 21 May 2024 23:18:21 -0700
Message-ID: <20240522061827.601699-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWyRpKBR9epzzfN4PRBa4u3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoEr4+3UB8wFu/kr9l04xdTAOImni5GTQ0LAROLz
 ianMXYxcHEICS5gkGnYeZoRw7jNKXN3XwQRSxSagJXFny1xmEFtEwExi0drzbF2MHBzMAhoS
 7c/ASoQFDCRmTTkHZrMIqEo0L3nJAmLzClhK/Ou5ywqxTF5i5qXv7BBxQYmTM5+A1TADxZu3
 zmaGsCUkDr54AWYLCShIzN42mRGmd9q518wQdqjE1i/bmSYwCsxCMmoWklGzkIxawMi8ilEo
 NzM5O7UoM1uvIKOyJDVZLyV1EyMoHEUYuHYw9s3xOMTIxMF4iFGCg1lJhHfTFs80Id6UxMqq
 1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxSDYxqdo9/vjy/RPtnB+uk
 jRO5zUX0Z0603c9yjmO+1uzLjzL3tO3p9slLkQ6UchaqdOt794vhq9EGQ6cIT+4jzhm7liZv
 t2s3ab745ftfu4errdlX8kVKpFtnVklZs/FqZl7M8dqqY+M7K23x5kf1HDPEAljV09e8WT7L
 9ddRz593Xmr/1DLpuq7EUpyRaKjFXFScCADfzHMLNQIAAA==
X-Mailman-Approved-At: Wed, 22 May 2024 16:50:43 +0200
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

This patch series adds support for the EEPROM v3 API.

V3 is backwards compatible to V2 and therefore, the V2 image still
exists at the beginning. Only the API version changed from 2 to 3.

V3 is a block-based memory layout organized as singled-linked list
with different types of blocks. This is a more flexible approach and
allows us to extend it by more block types in the future.

The V3 data starts with a 8-byte large header which defines the
block count (u8), V3 subversion (u8) and data payload length (u16).
Additionally the header contains a CRC8 checksum a 3 reserved bytes.

Each block starts with a 4-byte large header which defined the
block type (u8), the absolute address of the next block (u16) and a
CRC8 checksum. The content itself is defined via the block type and
we currently have 2 different types:

1) MAC: Contains the Ethernet interface number (u8), MAC address
        (6 x u8) and a CRC8 checksum.

Daniel Schultz (6):
  board: phytec: common: Move eeprom read to new function
  board: phytec: common: Define PHYTEC_API2_DATA_LEN
  board: phytec: common: Move API v2 init to new function
  board: phytec: common: Add API v3
  board: phytec: common: k3: Set MAC
  configs: phycore_am62x_a53_defconfig: Enable CONFIG_ENV_OVERWRITE

 board/phytec/common/Kconfig                   |   9 +
 board/phytec/common/Makefile                  |   2 +-
 board/phytec/common/k3/board.c                |  23 ++
 board/phytec/common/phytec_som_detection.c    | 228 +++++++++++++++---
 board/phytec/common/phytec_som_detection.h    |   9 +
 .../common/phytec_som_detection_blocks.c      | 105 ++++++++
 .../common/phytec_som_detection_blocks.h      |  61 +++++
 configs/phycore_am62x_a53_defconfig           |   1 +
 8 files changed, 408 insertions(+), 30 deletions(-)
 create mode 100644 board/phytec/common/phytec_som_detection_blocks.c
 create mode 100644 board/phytec/common/phytec_som_detection_blocks.h

-- 
2.25.1

