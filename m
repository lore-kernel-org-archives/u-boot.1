Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5867ED17120
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 18:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09CC88D56;
	Mon, 21 Oct 2024 20:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C3nu6CWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE2C088EFB; Mon, 21 Oct 2024 20:01:28 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B274188D51
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 20:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain (1.general.zfsdt.uk.vpn [10.172.194.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C7DF93F043; 
 Mon, 21 Oct 2024 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729533686;
 bh=twda6CkNgaSDLnBRHGFZdkGVHzMGfqo3mw1DTqKPUNk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=C3nu6CWR5OKKGtG5SWra78waz3OSC4ONxh7jR/PvcO6LDdN7WvNsznvstm9Rtpcgz
 7xEMrxRu8+mAJq+iSLxu2WG9g7qAvJvcurtlRD7XcU2amyfvBKtImVjmhXmhgsH5Ys
 C8vhDFwNPcPuuz4vi6nAhkQTDxmQ5z/HGWzBFOWUGD80zyWuglk3/zIlpx06vYeV3V
 A2h7OZlTFiogB8mnWDZiDcKnxnQ2+0276AjlZnW9DwhVFzWRjn3AeCskWLshkqWENh
 AGIrVnuFr3m4gra271w6plaz2cwYLFRo8EdtmwRC1Pcn0bst92YRozJ7C+owmeeus9
 5/tsXzPrM+F3g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sean Anderson <sean.anderson@seco.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] doc: include pages only once in TOC
Date: Mon, 21 Oct 2024 20:00:59 +0200
Message-ID: <20241021180101.18452-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Sphinx can only add a page once to the table of contents.
Sphinx 8.1.3 issues a build warning when trying to add a page twice

Replace duplicate TOC entries by references.

Heinrich Schuchardt (2):
  doc: Semihosting should only be once in a TOC.
  doc: do not include K3 boards twice in TOC

 doc/board/emulation/index.rst |  5 ++++-
 doc/board/ti/k3.rst           | 11 +++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.45.2

