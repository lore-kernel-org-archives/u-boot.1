Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8784ACDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC5C84A1D;
	Thu, 25 Jun 2026 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="h6v4fQoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC6B8460E; Thu, 25 Jun 2026 14:20:04 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5492C8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=629d8e15b=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782389998; x=1813925998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OwdubEtS3LbW5epHAZ/pyWrVwtKzP8I7cbOxT84gMP8=;
 b=h6v4fQoBDGA0RxvP/2urgr7DNhAr9FzgjFVkAK+/qVOpy8qTOaM1oA3j
 jtFv6V73Fety7CjJy4jZR0/UtXsy7UsehEiRziBREjEsyIEDDbgis9aHu
 i1XR+CCn3tVutksJfWws+r1PrgmudqdsPWIi1ZmN+IJ7xbq/w6MT1uoG6
 2ivClYgvqbTQHHr1dAPKpft1WK9solE0d06mzU01IoYPV0WX1NyVZ31Wi
 Eaf2mvKyg5E6OC2N+HzND7/hsQLBwtp/Kx+6gDcBc8CMhGvm0ReOm9ldd
 4GybTO1zpoa8b62FiLz6gWQU968XLcWfbUMjAthKYFMQr1jtpZMd96REE Q==;
X-CSE-ConnectionGUID: NnZEgitoQ6mjUTDJ3r4f8A==
X-CSE-MsgGUID: bMYloFbkTluMKmm7VkgeSw==
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="60031775"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 05:19:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 25 Jun 2026 05:19:56 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 25 Jun 2026 05:19:53 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Sughosh Ganu <sughosh.ganu@arm.com>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Martin Herren <sputnik@on-the-web.ch>,
 Michal Simek <michal.simek@amd.com>, Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, <jamie.gibbons@microchip.com>
Subject: [PATCH 1/8] cmd: rng: fix error handling for dm_rng_read()
Date: Thu, 25 Jun 2026 13:23:18 +0100
Message-ID: <20260625122325.834568-2-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625122325.834568-1-jamie.gibbons@microchip.com>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:58:57 +0200
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

The rng command treated any non-zero return value from dm_rng_read() as
an error, even though the API returns the number of bytes read on
success.

Update the error handling to only report a failure when dm_rng_read()
returns a negative error code, or when a short read occurs.

This fixes false "Reading RNG failed" messages when RNG drivers
successfully return data.

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 cmd/rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/rng.c b/cmd/rng.c
index 4d91094a8ec..18c0b6c9ca1 100644
--- a/cmd/rng.c
+++ b/cmd/rng.c
@@ -62,7 +62,7 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	n = min(n, sizeof(buf));
 
 	err = dm_rng_read(dev, buf, n);
-	if (err) {
+	if (err < 0 || err != n) {
 		puts(err == -EINTR ? "Abort\n" : "Reading RNG failed\n");
 		ret = CMD_RET_FAILURE;
 	} else {
-- 
2.43.0

