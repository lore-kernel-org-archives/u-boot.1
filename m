Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F331C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0D6883CD;
	Mon, 24 Jun 2024 14:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A3C882B7; Mon, 24 Jun 2024 08:26:18 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1EA98819D
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jhumphreysti@gmail.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O6Q8ua082751;
 Mon, 24 Jun 2024 01:26:08 -0500
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O6Q7Nq118822
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 24 Jun 2024 01:26:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 01:26:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 01:26:07 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O6Q7up028363;
 Mon, 24 Jun 2024 01:26:07 -0500
From: Jon Humphreys <jhumphreysti@gmail.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia
 <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 "Jerome Forissier" <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, Peter Robinson
 <pbrobinson@gmail.com>
Subject: Re: [PATCH v4 10/14] net-lwip: add wget command
In-Reply-To: <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
 <ba84782cebf8a151ae7bd5d9abc4b313fb4334e8.1718638104.git.jerome.forissier@linaro.org>
 <86frt2vp2k.fsf@udb0321960.dhcp.ti.com>
Date: Mon, 24 Jun 2024 01:26:07 -0500
Message-ID: <86a5javou8.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

Subject: [PATCH] net-lwip: Add message if not using http:// for wget

U-Boot's wget only supports http://, so give the user a clue if they don't
use it.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 net-lwip/wget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net-lwip/wget.c b/net-lwip/wget.c
index 63b19b99112..6b9c953ef51 100644
--- a/net-lwip/wget.c
+++ b/net-lwip/wget.c
@@ -35,8 +35,10 @@ static int parse_url(char *url, char *host, u16 *port, char **path)
 	long lport;
 
 	p = strstr(url, "http://");
-	if (!p)
+	if (!p) {
+		log_err("only http:// is supported\n");
 		return -EINVAL;
+	}
 
 	p += strlen("http://");
 
-- 
2.34.1
