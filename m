Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF51E7071E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1FF86BF4;
	Thu, 21 Sep 2023 13:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZyI6zesr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B184386AA8; Thu, 21 Sep 2023 10:14:10 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 955CD86ABC
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 23D2D12000E;
 Thu, 21 Sep 2023 11:14:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 23D2D12000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695284046;
 bh=mhHx6lf4p0khf54xz+87saCVPW8k1eDqtvjoEPPahr8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ZyI6zesrFp0zPZhSFU4M3KANgBmTmAT6LqnkQTsMit69iEWSVwdto9dddpDpGMqqN
 skdwXM28JGL2p7bR9fzR33fgZghfScvdH9l1Bi4J0+uT6+QUDFEWVHQ4JEDrYZw4Vd
 f3gM3wZAQKxbI0Oy6/f0BH9/MV6TVYfTQlZxc9O0VBqI5ZKPjQR8OnJVtUvuctMaE1
 hT4u9dBa6MkFOy7KrI0oinVQre3RYmnbkBhhA1L//Er7Vy6VaTuIQIFKANTBK9jNKB
 omRL786I6g20k7HqpbgvKgSeqpQdDvUyehvPh5bGVK9uoKsx/w42OrJ+nmZlo+KYTZ
 OjCQXg2BrQleg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 21 Sep 2023 11:14:05 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 21 Sep 2023 11:14:05 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>, Simon
 Glass <sjg@chromium.org>
Subject: [PATCH v3 3/8] sandbox: dts: add meson secure monitor node
Date: Thu, 21 Sep 2023 11:13:36 +0300
Message-ID: <20230921081346.22157-4-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
References: <20230921081346.22157-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180016 [Sep 21 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534
 808c2ea49f7195c68d40844e073217da4fa0d1e3,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/21 03:17:00 #21936738
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

We need this to test UCLASS_SM.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/sandbox/dts/test.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index dffe10adbf..4475aa58a6 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -693,6 +693,10 @@
 				};
 			};
 		};
+
+		sm: secure-monitor {
+			compatible = "sandbox,sm";
+		};
 	};
 
 	fpga {
-- 
2.25.1

