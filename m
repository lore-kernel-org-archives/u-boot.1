Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC7EC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0D8876D5;
	Wed, 20 Dec 2023 09:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="s8G13188";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B888765B; Wed, 20 Dec 2023 09:45:44 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E4C486D4C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703061940; x=1705653940;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8VUaPA1QH1AvkbCTDgP7JVisbqVuqKy9DRG8ugH+Huc=;
 b=s8G13188s8LWgUY+z0Zf4H8keW06yW7foPPOQBM53rxJeAThE/57sJ3c6DA5GHsa
 ocqLnpY+9x4DMJ5qD9sAZp1TUiy6kl/8dCpsOciI9pTzgt9o3FUZ7KXWJ8AQfhvY
 OTnyqFQ82dwp4KQfr1eJYubUHRLtYMeWG43BXh4ubeY=;
X-AuditID: ac14000a-fadff7000000290d-e4-6582a9b3312a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 15.E0.10509.3B9A2856;
 Wed, 20 Dec 2023 09:45:39 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:45:39 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/5] This series fixes various bugs in the phytec
 som_detection unit.
Date: Wed, 20 Dec 2023 09:45:31 +0100
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKupgmUC/6WOQQ6CMBBFr0K6dgydNg268h6GkEJH6ALatIgSw
 t0tsHGty/cn//1ZWKRgKbJrtrBAk43WDQnwlLGm00NLYE1ihjkKjryAl/UwQ+9cC76bR2rAEDx
 9HAPpvoqurwyldEye6mHfFKGWEjUnroSQLHl9oP2QtPcycWfj6MK8vzDxLf1nbeKQA3GtlK4LR
 K5uR/FsaBs/zJj/am5QPgSKSy0b8WUu13X9AITbvr5MAQAA
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWyRpKBR3fzyqZUgzdvbCweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlbH8w2SWgkkcFZ9OnWJsYPzG
 1sXIySEhYCJx4ftexi5GLg4hgcVMEpPvXWGFcB4ySlzYtYQVpIpNQEXi8Yt7YLawQJTEzCnP
 2UFsFgFVieabt1lAbF6BFIkH+89B2YISJ2c+AbI5OJgFNCXW79IHCTMLyEtsfzuHGWS+hMB0
 Jolrz3+ygtSICKhJnJ4HVVMjMfX+PHaI44Ql2hfdYgKxhQRkJV6c74WKy0tMO/eaGcIOlTiy
 aTXTBEbBWUg2z0LYPAvJ5gWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgsJWhIFrB2PfHI9D
 jEwcjIcYJTiYlUR493Y2pQrxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQ
 WgSTZeLglGpg9PWsV2icwrVlTuNB/r0S8QwC/1oS0jIZMvI6VqxzWmKWKqX7hOXmBpmsiTqP
 S7VtLjoxPbhVqdocYXHbaxt/rn/hgznzt3Qy/Gpi3BbGc0fVxM3h2Z65q6f5/O98eHz6mTWr
 Ws/8WvOh6dydBRkhGzcsKr3svTddP2FR/ffeXeeZtY7UZDzgU2Ipzkg01GIuKk4EAGUV/LNJ
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


---
Changes in v2:
- fixed accidental squashing of changes -> split into 2 separate patches

---
Yannic Moog (5):
      board: phytec: imx8m_som_detection: change phytec_imx8m_detect return type
      board: phytec: imx8m_som_detection: fix uninitialized pointer bug
      board: phytec: phytec_som_detection: fix eeprom_data zero check
      board: phytec: som_detection: move definitions to source file
      board: phytec: phytec_som_detection: fix uninitialized bug

 board/phytec/common/imx8m_som_detection.c  | 40 +++++++++++++++++++++++---
 board/phytec/common/imx8m_som_detection.h  | 34 +---------------------
 board/phytec/common/phytec_som_detection.c | 46 ++++++++++++++++++++++++++++--
 board/phytec/common/phytec_som_detection.h | 38 ------------------------
 4 files changed, 80 insertions(+), 78 deletions(-)
---
base-commit: 8f5043ee6d378d7c10d947cf48b047a5954ef5b3
change-id: 20231218-wip-y-moog-phytec-de-upstream_som_detection_fixes-b442a1e16334

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

