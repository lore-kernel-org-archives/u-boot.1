Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F0ECD37B9
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 339EF8460B;
	Mon, 11 May 2026 14:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eRCIK/Fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D44838D7; Mon, 11 May 2026 14:09:40 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE55480086
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Mx5+KWAJ5iF7k7BaYUjZKc5h24RF5+zVWeTOXitUK2M=; b=eRCIK/Fj0PU5S2op/qyFEqYrOs
 5RIQgivBIeeJP8X5z/mb5LJlwPP6pFaZUHZageRBgMOCg8peIP1RXaJDYNTXwVMMp9lMswbB8hptf
 dPJQZpyjnh8js7DD4Cy/CSgEVYYAUbQN/vEAv+5bBGOqU58dYouwpQ7imlNLGiUS2ynWXlfbPYUll
 gxqz9wwFX+tvEYGE6SM9YWSHs4/V0yqJJQ+9AukAZEhA6T232dxfIHTOJTf+xxJ3eQsQO+1vMvTb9
 pvNqEs2fNZcTyPkTgKrw4aWnRYce3DcMWF2ZHbyujeaZB2eQCjGthl6oYWUEoKGOOn4BRxq+/aM1P
 kGPIOZaQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wMPS1-000MWQ-1U; Mon, 11 May 2026 14:09:33 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wMPS1-000GAr-1r; Mon, 11 May 2026 14:09:33 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: u-boot@lists.denx.de
Cc: u-boot@ew.tq-group.com,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] drivers: Kconfig: rtc_pcf85063: note unsupported chip
 features
Date: Mon, 11 May 2026 14:09:17 +0200
Message-Id: <20260511120917.1017866-9-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
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

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 drivers/rtc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d9bf533cb..1c703c1e229 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -163,6 +163,9 @@ config RTC_PCF85063
 	help
 	  If you say yes here you get support for the NXP PCF85063 RTC
 	  and compatible chips.
+	  Support for the following chip features is currently not implemented:
+	  - NVMEM
+	  - CLKOUT generation
 
 config RTC_PCF8563
 	bool "Philips PCF8563"
-- 
2.34.1

