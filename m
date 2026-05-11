Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC24DCD37B9
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1380383CD3;
	Mon, 11 May 2026 14:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HDVHOvnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C8983C2B; Mon, 11 May 2026 14:09:33 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13A680086
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=xxpzVAD8iN19W1GTWquRyPxr1eb2Mz9FlDxO4VHPhdQ=; b=HDVHOvnlxIagLA22HsGOLm4sgP
 PpUu+oA+Sk+zSeFVX1snl5XCu2jbVykJV4lBj7KD6EzUV3p6CAll8k2H1faoh4QWEM1EzmIEUR8Af
 ksdr90DqYlu5dnZyVFSgpl4+ijQlobZFxr543wFXUunkOPxC+K3uxbccwxvFQEi8GYSWW6Ep7txQl
 EL8pj9RUePP7h3o17hNM8dvm/a9D/7rf7GSBsKpOn8xwTTF1gKFMHvFinvm4X0AFzxLir0KZ7T8q6
 /RhuNYPL4YazvBeHxzkqvVXVbFTxZAUunfv8NCCR00bSCod5m3yt2qKr31OL/EF2GDVkAefJAsSu5
 vW6neIYw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wMPRz-000MTx-1E; Mon, 11 May 2026 14:09:31 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wMPRz-000GAr-1U; Mon, 11 May 2026 14:09:31 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/8] rtc: pcf85036: improve spec coherence and extend features
Date: Mon, 11 May 2026 14:09:09 +0200
Message-Id: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

This series fixes some spec inconsistencies and oversimplifications in the initial
PCF85063 support, and adds some missing features from mainline linux v6.19.

Changes in v2:
- reject day 0 in mk_date for tm_mday, analog to tm_mon
- improve commit message of first commit regarding mk_date changes
  - describe previous and new behaviour
  - note tm_year not being initialized in the format case MMDDhhmm

Alexander Feilke (7):
  rtc: pcf85063: adjust date format to adhere to the rtc_time spec
  rtc: pcf85063: add support for NXP PCF85063 family
  rtc: pcf85063: add missing register definitions
  rtc: pcf85063: keep the divider chain in reset during set_time
  rtc: pcf85063: support loading quartz-load capacitance from device
    tree
  rtc: pcf85063: add power loss detection during probe
  drivers: Kconfig: rtc_pcf85063: note unsupported chip features

Markus Niebel (1):
  cmd: date: validate date using rtc_month_days()

 cmd/date.c             |   7 ++-
 drivers/rtc/Kconfig    |   3 +
 drivers/rtc/pcf85063.c | 134 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 133 insertions(+), 11 deletions(-)

-- 
2.34.1

