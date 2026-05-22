Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13099CD5BB3
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 15:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217FE84852;
	Fri, 22 May 2026 17:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="G0LSatLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 050B984873; Fri, 22 May 2026 17:39:47 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5FD9846DF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 17:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=6a0ymo+L7zecm+g81RFxO19qeVTYLNoodDE2MM59X0Q=; b=G0LSatLEe26TMhqCPErDZCLY/n
 hWqemnlu8CriZk1++uLusflvmWZ610iymK9k6BMELiejzNcyr4prC8c5iPu4xUGFW6Sbsp1trEXVU
 N3ArxK54Ff5viY3o5k83UYEyqb0r2cu9JroDTpFC/ZXLb9zRFxappndQK9g88dM5KkNuZuwqkweZZ
 CQl5vTy3CmPG3FCEF5yul7V+cfDJubsTTV/mFHYDslDUE2WA8sdiD/J0i8m/U9tNyVpUgRLhcMaGd
 c3v6ompAXJxg5OlffhwJhWpoY9dUb/WRMOlUP89rOpD/wKm6oVCNnhejLFYvtPbn1nzkPmnh8I5a4
 muMe1drg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyS-000OLd-1C; Fri, 22 May 2026 17:39:44 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wQRyR-0002ma-0t; Fri, 22 May 2026 17:39:44 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/8] rtc: pcf85036: improve spec coherence and extend
 features
Date: Fri, 22 May 2026 17:39:20 +0200
Message-Id: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
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

Changes in v3:
- make mk_date static
- clarify missing NVMEM feature in Kconfig
- fix some checkpatch formatting warnings of changed lines
- improve commit message of first commit regarding mk_date tm_year initialization

Alexander Feilke (8):
  cmd_date: make mk_date() static
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

 cmd/date.c             |  11 ++--
 drivers/rtc/Kconfig    |   3 +
 drivers/rtc/pcf85063.c | 134 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 135 insertions(+), 13 deletions(-)

-- 
2.34.1

