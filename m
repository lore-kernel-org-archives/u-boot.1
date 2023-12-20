Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E4AC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17AC8701C;
	Wed, 20 Dec 2023 09:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nmRHMV5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBE687603; Wed, 20 Dec 2023 09:20:04 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 615EF86FFE
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703060402; x=1705652402;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xwDea84Ua/cazl9XZUunRT/Gcsw1uW8JzY46iqi+cLU=;
 b=nmRHMV5bAuxrrjvC6zBcakINgh/eIlEjuCUSzL9UAbXpPCGEPEVoX69ebAfMsw1O
 saxh6ztEg+e/blMXNtuiioTszG2v3va8h7UQ3EanC11UGdAWeWc8pANxXTpdCTlP
 3pYcej4GVwPPG9qjc64IjukkA+Tei3cZKqxami7gF/s=;
X-AuditID: ac14000a-fbefe7000000290d-45-6582a3b202c0
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 3E.A0.10509.2B3A2856;
 Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:20:01 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/4] This series fixes various bugs in the phytec
 som_detection unit.
Date: Wed, 20 Dec 2023 09:19:32 +0100
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSjgmUC/6WOQQ6CMBBFr2Jm7RimkIa48h6GkEJH6ALatBUlh
 Ls74hFcvj/5788GiaPjBNfTBpEXl5yfBeh8gn4088DorDCoQpWkqMaXC7ji5P2AYVwz92gZnyH
 lyGZqk59ay5Jm8bQP9+aEXVUpQ0y6LCsQb4h8HER7b4RHl7KP6/HCQt/0n7WFsEAmo7XpaqVI3
 37Fi2Vo9n3/AEYNnVDyAAAA
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRpKBR3fT4qZUg4X7uC0eXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlXG55yFzwRu2imNfDzI3MH5h
 7WLk5JAQMJFo2HyLsYuRi0NIYDGTxIZlk5khnIeMEpdbFoJVsQmoSDx+cQ/MFhYIl1j6cw8T
 iM0ioCrxe1YnkM3BwSuQItHZZQMS5hUQlDg58wkLSJhZQFNi/S59kDCzgLzE9rdzwMZLCPxn
 lLg+/SI7SI2IgJrE6XlQNTUSU+/PY4e4TViifdEtsE1CArISL873QsXlJaade80MYYdKbP2y
 nWkCo+AsJJtnIWyehWTzAkbmVYxCuZnJ2alFmdl6BRmVJanJeimpmxhBQSvCwLWDsW+OxyFG
 Jg7GQ4wSHMxKIrx7O5tShXhTEiurUovy44tKc1KLDzFKc7AoifOu7ghOFRJITyxJzU5NLUgt
 gskycXBKNTD6TP9Q7xly/JumWogkU/a03QI7kg9dcFnw1WLys7nV0/e/+fD+d23/gk7JwsIC
 JqOuzbvXM1hlmoVZ3l5a2iiz6eSuODYVxQAHm4i3BxyZpGMk61Mep4RP65l+5PkbuStvdVy+
 NIReXX9I/Ncxpn4BDqkYT7PdE3rP1ktnXH50eKnc3uqju3OUWIozEg21mIuKEwGF02FISAIA
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


---
Yannic Moog (4):
      board: phytec: imx8m_som_detection: change phytec_imx8m_detect return type
      board: phytec: imx8m_som_detection: fix uninitialized pointer bug
      board: phytec: phytec_som_detection: fix eeprom_data zero check
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

