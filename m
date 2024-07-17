Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6757C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:11:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726A588602;
	Wed, 17 Jul 2024 07:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BcWyg1if";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C2D788602; Wed, 17 Jul 2024 07:11:54 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48735885B5
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193111; x=1723785111;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x6/TnwX28SL53auwDa6uB3YW8DULVnPw0QY40ePrQwo=;
 b=BcWyg1ifdBCwena/fP3mR66of4a7UYuPC1CVmEe/BQUylXYPi32SK0392D5MgfQ4
 I1HWVAf7INI4UTohZrHQPTHleY/lxVu5WYBChti/QSLorEU7TCTiLLWBIsqfjkSx
 n5B127suyeyeGHA/Wl+P8wRXIhXN84HHBohGRXPxm5o=;
X-AuditID: ac14000a-03e52700000021bc-df-669752976c66
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7B.7B.08636.79257966;
 Wed, 17 Jul 2024 07:11:51 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:11:50 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Daniel
 Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 0/9] Generalize PHYTEC Overlay Handling
Date: Tue, 16 Jul 2024 22:11:25 -0700
Message-ID: <20240717051134.1538180-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRpKBR3d60PQ0gw+/LSxa1npYTJ20md3i
 7d5Odovud+oOLB6vDqxi9zh7ZwejR393C6vH8RvbmQJYorhsUlJzMstSi/TtErgy2h+sYSy4
 zlfxbtsF9gbGb9xdjJwcEgImEmcXvmPtYuTiEBJYwiTxcGsDI4Rzn1Hi896z7CBVbAJaEne2
 zGUGsUUEfCSOtm5m6WLk4GAWSJdYtSoNJCwsYCUxfd58sHIWAVWJG683soLYvEDxpfP+skIs
 k5eYeek7O0RcUOLkzCcsIDYzULx562xmCFtC4uCLF2C2kICCxOxtkxlheqede80MYYdKbP2y
 nWkCo8AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCglaEgWsHY98cj0OM
 TByMhxglOJiVRHgnME5LE+JNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1
 CCbLxMEp1cA4+UrslIojyjJC77fUF0SsPt++y3ihQZjQpGybD9XGr8vFeOfMb6yx6Vzt49A1
 vyW1fMqXiBAJqc47EtON9tYrcT3n2x7Lrn6n4LjMjNA1+YXS/syiGSmNB6Z8OiUzn4Utc/OS
 FYkFE8Si/L9pCqWrW7/O1IiNunvvbLPFpwlaOdcv/Vy/96gSS3FGoqEWc1FxIgDXONMuSAIA
 AA==
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

The overlays are specified in the bootenv.txt file that is loaded into
the environment. Then these overlays get loaded and applied via a script.
These scripts for loading and applying devicetree overlays are identical
for many phytec boards.
Create a common overlays.env that can be included.
Add support for devicetree overlays to phycore-imx8mp and include the
overlays.env for phycore-imx93.
Rename existing environment variables according to bootstd doc.
Move MMC boot logic into a common k3_mmc.env file and include the new
overlays.env file as well.

Changes v2:
  * Rebased to master and resolved a conflict in
    configs/phycore-imx8mp_defconfig.

Benjamin Hahn (5):
  include: env: phytec: Create env file for loading and applying
    overlays
  phycore-imx8mp: Add overlay and bootenv.txt support
  phycore_imx93: include common overlays.env
  board: phytec: renaming of variables according to bootstd doc
  include: env: phytec: renaming of variables according to bootstd doc

Daniel Schultz (4):
  include: env: phytec: Add common mmc boot for K3 SoMs
  include: env: phytec: k3_mmc: Apply overlays during boot
  board: phytec: phycore_am62x: Use k3_mmc.env logic
  board: phytec: phycore_am64x: Use k3_mmc.env logic

 board/phytec/phycore_am62x/phycore_am62x.env  | 11 +----
 board/phytec/phycore_am64x/phycore_am64x.env  | 12 +----
 .../phytec/phycore_imx8mp/phycore_imx8mp.env  | 27 ++++++++---
 board/phytec/phycore_imx93/phycore_imx93.env  | 45 +++++--------------
 configs/phycore-imx8mp_defconfig              |  4 +-
 include/env/phytec/k3_mmc.env                 | 21 +++++++++
 include/env/phytec/overlays.env               | 38 ++++++++++++++++
 7 files changed, 97 insertions(+), 61 deletions(-)
 create mode 100644 include/env/phytec/k3_mmc.env
 create mode 100644 include/env/phytec/overlays.env

-- 
2.25.1

