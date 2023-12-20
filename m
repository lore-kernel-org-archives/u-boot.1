Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE9C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C89387661;
	Wed, 20 Dec 2023 09:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="kqO42K9g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A0E875B6; Wed, 20 Dec 2023 09:20:06 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE60B875FD
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703060402; x=1705652402;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+p9cSagMgdIthOEDQCevQKCsaJYplLP/nKN79+vfSgw=;
 b=kqO42K9gpHqVwVyVBfke+IBJEgZUN7AxhDk1kNZJxy/xawqOpQ6hFWDUfnh78Tk4
 GI7vMu7W0GwmzYFrGVLbY9IvGCGNbSEHXaWxNCxdOpDoHfug2kLnt8yUQ3hVZk/I
 pXSH98Wkpyw/96SUaKz0B6p1psV3aYnBUilRM/mHjBY=;
X-AuditID: ac14000a-fbefe7000000290d-4d-6582a3b274b4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 51.B0.10509.2B3A2856;
 Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:20:02 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:19:36 +0100
Subject: [PATCH 4/4] board: phytec: phytec_som_detection: fix uninitialized bug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-4-c24f3239b4c3@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWyRpKBR3fT4qZUg+UHDSweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlXHi3wu2gr3sFQuvajcwzmHr
 YuTkkBAwkZj8t4+xi5GLQ0hgMZPEuk/XWSCch4wSH899B6tiE1CRePziHmsXIwcHi4CqxNU5
 WSCmsECgxLfGDJAKXgFBiZMzn7CAhJkFNCXW79IHCTMLyEtsfzuHGaIkReLjhn2MILYQkP3v
 2CSwOKdAqsS51avYQVpFBNQkTs+Daq2RmHp/HjvElcIS7YtuMUG0ykq8ON8LFZeXmHbuNTOE
 HSqx9ct2pgmMQrOQHDQL4aBZSA5awMi8ilEoNzM5O7UoM1uvIKOyJDVZLyV1EyMojEUYuHYw
 9s3xOMTIxMF4iFGCg1lJhHdvZ1OqEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp
 2ampBalFMFkmDk6pBkZ5nlVq04/NUs+X6qu/Ghkgs6u5Nc92Y9DO1W9cFgWz73p/L7ErjnuL
 3BWuqkRHh5mn4q4srqk+seyAFX+Gx3auCvbPf9f83er483TlQUWu1Jkxezvao7/nW66b5BFQ
 PuOkV87+UpVd3DrzjU/9m3t/39slVuGHub5pFF1YVHXF4Ziy7HzWxA1KLMUZiYZazEXFiQAi
 7SltUQIAAA==
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

When som_type does not match any case, it is uninitialized and the
function still tries to print the SoM info. Rather, this is an error
condition and the function should abort prematurely. Highlight this by
printing an error message and returning early.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index f879702df45..1b10923b62f 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -161,7 +161,8 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 			sub_som_type2 = 2;
 			break;
 		default:
-			break;
+			pr_err("%s: Invalid SoM type: %i", __func__, api2->som_type);
+			return;
 		};
 
 		printf("SoM: %s-%03u-%s-%03u ",

-- 
2.34.1

