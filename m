Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4FFCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED2884C45;
	Fri,  8 May 2026 10:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="id9dJdzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A074D84C40; Fri,  8 May 2026 10:21:43 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E3784AF6
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=F0SMAGWY5vEJ30AkaxE65nzuAZickfF0F1O4NYxZacE=; b=id9dJdzFn28ZzfK9+h7mFyhDv6
 0e10n8WCldVl4AyqPqNUwswEDULDe5Aez/OLkqrnwgHQU+ChafogB0WwQkURTJgZLDnhQknP55pUo
 61g7X2y2J/APW1dJT8vdTGROYQb971Www8YFevAnZvdR/1V7KUWdB4WR5A/ouakGiRZdAj7hno9xs
 HTwyH8Qe0chu9CzZXDZ8rvbLbLNCy9cbyAjb3rSrUJGI77bPwwqFMS3CQBsl66JlIdbwEqqnl8BuA
 BPiZAgMmXbTHz707hqUY0Yl2BPNWV0gPrERTs8nNeJtkJMn0lf1g9Esl42xUOTZ26z3acY/9KOu0s
 VGKPYNew==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSr-0005nD-0F; Fri, 08 May 2026 10:21:41 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGSr-000P5H-0V; Fri, 08 May 2026 10:21:40 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/8] rtc: pcf85036: improve spec coherence and extend features
Date: Fri,  8 May 2026 10:21:24 +0200
Message-Id: <20260508082132.25476-1-Alexander.Feilke@ew.tq-group.com>
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
  cmd: date: improve day of month verification

 cmd/date.c             |   4 +-
 drivers/rtc/Kconfig    |   3 +
 drivers/rtc/pcf85063.c | 134 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 131 insertions(+), 10 deletions(-)

-- 
2.34.1

