Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D313C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 11:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20F2B80DD3;
	Mon, 27 Jul 2026 11:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxsAswvA8l7z; Mon, 27 Jul 2026 11:57:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFA6E80DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785153474;
	bh=cvN/LxgQp36KOu9bv0AWCdTj6wqefVKLwW/6CsQ50g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlVQqCVbcG5dnt/tt7D6xPYilSEpjQ0r4LZsw9HU+2Zk+lk63vYhnn9+bkQEMmPem
	 oynE3VBw8n/ocdggGLHcwbze4u3HMKlKx5Fb6eTz2zLYURam2Ry+xOtNNsvIjpBvyy
	 MQSTLzyUDnUx5UCokgFOGvggEhIAdZx3yBZfJQ4IUPrhlyG+31cwjPVKzGx6rGdRGl
	 usjbRbWdHEo5VlEOy1OxZKAW5tyL1oItkiCufaGvenib1/PdMDlyt8cZe5iPY6cxEI
	 SAC5hAdYehqbKTq/Grehke0T6C/ofeLZK0o8XZhu6MkTLLfkEpDDMPh7C7FtZGlvU9
	 Vvu3miPogwAhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFA6E80DB2;
	Mon, 27 Jul 2026 11:57:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 720C4977
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5632B4006A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFw13ZMFu_eZ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 11:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1682F40065
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1682F40065
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1682F40065
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 11:57:48 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxp-000EpG-3A; Mon, 27 Jul 2026 13:57:45 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1woJxp-000Fh8-2F; Mon, 27 Jul 2026 13:57:45 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Mon, 27 Jul 2026 13:57:37 +0200
Subject: [PATCH RESEND 1/4] sysinfo: tq_eeprom: select NVMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-tqma6ul-eeprom-v1-1-ad1d4e2fa1ae@ew.tq-group.com>
References: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
In-Reply-To: <20260727-tqma6ul-eeprom-v1-0-ad1d4e2fa1ae@ew.tq-group.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.13.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/28074/Mon Jul 27 08:25:14 2026)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cvN/LxgQp36KOu9bv0AWCdTj6wqefVKLwW/6CsQ50g4=; b=TEF3hp7nXWcixPpWV/22L2rUBD
 oUSNNS44uwmd3bjZxC7HnXMcaNR8IVvwAk0IyujhPAxv0CH6QGCvRFKJ46zt5eXciz3rltQLNp6mV
 scMwu1BnPl+dKOWL3M1kJXnPYxJkRehSeC+/ycrEnr8VrNDTcmV46PiPgGHLBy4/dtXChmqAyatvT
 RPmU3SVEvjE+85d2yhRvPDVhCsJ2Jyo0lTbY9/4NAcgTvE9spxHkMsy0ziWCiMHdpq0sd6tIaXCHM
 BZ24FMtPngKEmcIpcGtgQqGBKIPEsz3hDs+ox62+ph5brY3KxPXI7PfgeevDjI99rM9BJpR0OiOPc
 Q3ksIdqQ==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TEF3hp7n
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The SYSINFO_TQ_EEPROM driver requires NVMEM to access the SoM EEPROM.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 drivers/sysinfo/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sysinfo/Kconfig b/drivers/sysinfo/Kconfig
index 6922dac9170..adcf1aed8a8 100644
--- a/drivers/sysinfo/Kconfig
+++ b/drivers/sysinfo/Kconfig
@@ -63,6 +63,7 @@ config SYSINFO_TQ_EEPROM
 	bool "Enable TQ-Systems EEPROM sysinfo driver"
 	depends on I2C_EEPROM
 	depends on SPL_I2C_EEPROM || !SPL_SYSINFO
+	select NVMEM
 	help
 	  Support querying EEPROM of TQ-Systems SOMs to determine board
 	  information.

-- 
2.43.0

