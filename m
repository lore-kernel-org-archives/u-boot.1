Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A24C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB07B88747;
	Tue, 23 Jul 2024 01:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vMhNysGT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sgNUcEnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ACA388569; Tue, 23 Jul 2024 01:30:03 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB11588629
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 01:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WSc2D3T0vz9skn;
 Tue, 23 Jul 2024 01:29:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLYbtphIvn3rBqyjmfXOzAjdVqmqiQJXYc5ke18z7oE=;
 b=vMhNysGTjr776oJRAQakMakdCn40o1ela6I1QkBFP9xyJlaaNJAnAurtt2bJnX1d3s+FcT
 vGDn/ot6PButYxfcklGmG6jUAUbLPXuSLupsU0RaoPNi+pOjVciVqN1AYMwiJU9ZkKqCcF
 GaHfbsDgYWa3zt8q2WgjKcu2sikx1x4tNq4i/P8Y0Zacc/SMYFWKQkz8evhuvhimIpnj3U
 xOANWe3tK5kQPdVJFiV6RPqfDIyljnDPCHoLcNnObn/cE00YXuJDO+R5f6OrD/NvJAtMkI
 TtJXHOky2g1oE708LTrGqBo7vchGcnnoVpTcmtTk9T73+/DmZsgnxFgxPmn8yg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721690994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLYbtphIvn3rBqyjmfXOzAjdVqmqiQJXYc5ke18z7oE=;
 b=sgNUcEnZmHC2OawbiA5bU41i6CiWth1l4VWid0CGz4sQBTZhdb4lT7bbBIqag8izh+bb7g
 0fRCANhZEk9le7vo9F7rUk4Myt5wB0ajZwrIIHkcdGIFtoSrm6A0LfEFR4uisPaQ3p6Tt/
 CtznJSlDoegjlkylP8E9nITtFQy44qZPVFq/GPTtLDRTxqKcMiHQdmUdxsHjOPvoe4FM5i
 iH6iHNmGBhsBuXe6th2ZIEBECFv3DOnmzAJ8thoqTJfv0QXL3cCPhXqTSCBOkJXMdiNSv/
 Kd5fYSCmbrwOUJbjJnlUWrDrWuDojQjWLK2LW4n77nK7kvrfookKBRlWY8wtPQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 09/15] include: net: Remove duplicate newlines
Date: Tue, 23 Jul 2024 01:28:28 +0200
Message-ID: <20240722232910.91249-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
References: <20240722232910.91249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: de0d0d36a06863cf739
X-MBO-RS-META: uc6b6wk5rnfpiwmo48rjujx1cbxrgzdd
X-Rspamd-Queue-Id: 4WSc2D3T0vz9skn
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/net/sntp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/sntp.h b/include/net/sntp.h
index 30b44d1c066..5dd9aa36fea 100644
--- a/include/net/sntp.h
+++ b/include/net/sntp.h
@@ -9,7 +9,6 @@
 #define NTP_SERVICE_PORT	123
 #define SNTP_PACKET_LEN		48
 
-
 /* Leap Indicator */
 #define NTP_LI_NOLEAP		0x0
 #define NTP_LI_61SECS		0x1
-- 
2.43.0

