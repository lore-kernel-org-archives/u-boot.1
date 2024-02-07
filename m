Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ADEC48297
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 00:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DA387C93;
	Wed,  7 Feb 2024 01:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="gIsMEW+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D5487C92; Wed,  7 Feb 2024 01:15:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78A587C8D
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 01:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4f0f=JQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1707264885; bh=KnnUBwv0V92l2JIm7Sw70rCcBTHx4SfRz/1kWHK0iT8=;
 b=gIsMEW+7cLmOALj1+2KlyQo8q50L4/VDyC8qGQNzCMgDvDcUFW8cwycaE7EzCamn2g87ev5pW
 eDBiDOtBfBuMB742AvklP1Z7yIgG3ESRTNsHH02zP1N6B6sJ/hvnmiFUXV7gwISlce4q0bqMPqv
 yeq+u53vSQXagvsO7WWpYawD3528v8rilWejltXXIFOAVZ0c4GMHTfKuR3GgXqWyN1Hm3JI6hAJ
 9WvztlFIXmT903/X9Ii+39CdpSIdGN+RhpdmDjP0FNBfFdnSCv32qs9WCA1Vf6sYXOofOn34rxD
 IpQbbNSGGDNeNi7FcRMIpa1oVat5sOQxCujfUMle5Lfw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 12/15] Revert "rockchip: Allow booting from SPI"
Date: Wed,  7 Feb 2024 00:02:41 +0000
Message-ID: <20240207000301.3270722-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207000301.3270722-1-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c2c8e5d5b31093c56fbfe7
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

This reverts commit 3523c07867b403d5b3b68812aebac8a5afa5be4c.

Booting from SPI was already allowed before this commit was first
introduced. A few lines further down the exact same code already existed
and still does.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 2c39a215c107..79c856d2a0ac 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -65,9 +65,6 @@ static int spl_node_to_boot_device(int node)
 		default:
 			return -ENOSYS;
 		}
-	} else if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node,
-		&parent)) {
-		return BOOT_DEVICE_SPI;
 	}
 
 	/*
-- 
2.43.0

