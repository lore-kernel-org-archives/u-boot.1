Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4522C35FE7
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54FE988F38;
	Wed, 18 Sep 2024 08:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="eXAA4mg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5E888DAE; Tue, 17 Sep 2024 19:54:04 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F2D885F4
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mmkurbanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 18574120007;
 Tue, 17 Sep 2024 20:54:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 18574120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726595640;
 bh=gITkYENBLvI1QXqMSnKpe5Z35u99Kk0jYRNbzSa8h6M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=eXAA4mg9ZQUBGHI7JXHDuUNQGTZmeoRpy8F10g2jlR7vfvgeHUsYDez6eX+enadwY
 m6nQEXsk5MNNBN3tGFPiZHxWJlWc1zPJlk4P/2OqOObRltUvr20FolL2HUy+inxjMw
 PfA/tMQY7pXKFBmAn6Zhm3LgsbM86zUkRJtpOVZuQ3e/2JDzQl/G5JEUQUl0/WwbTI
 M0GclaaaAha1qryhTfZM49edDGsFgAZVCkYq6u3Xa3K49ha0ZJ18RUWhA9tRjOM34L
 Wea5o2Gbw2AyFWtBJPKxpxs6lV+6FxEvx43hEVbdBVRHLqMKyQLAB3LyErGGGKJx32
 TkM8WbLVI1qGg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Sep 2024 20:53:57 +0300 (MSK)
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>,
 "Heiko Schocher" <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Martin Kurbanov
 <mmkurbanov@salutedevices.com>
Subject: [RESEND PATCH v1 2/2] cmd: ubi: check 'updating' before calling
 ubi_more_update_data()
Date: Tue, 17 Sep 2024 20:53:23 +0300
Message-ID: <20240917175327.13311-3-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917175327.13311-1-mmkurbanov@salutedevices.com>
References: <20240917175327.13311-1-mmkurbanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.162.132]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187805 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/17 16:39:00 #26606450
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 18 Sep 2024 08:14:47 +0200
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

If 0 is passed to the 'bytes' parameter in the ubi_start_update(),
there is no need to call the ubi_more_update_data(). Otherwise,
there will be a double-free of 'vol->upd_buf'.

Also check that the ubi_start_update() was called before calling
the ubi_more_update_data().

Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
---
 cmd/ubi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 23b6211f6c..b68b51c6a9 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -363,6 +363,11 @@ static int ubi_volume_continue_write(char *volume, void *buf, size_t size)
 	if (vol == NULL)
 		return ENODEV;
 
+	if (!vol->updating) {
+		printf("UBI volume update was not initiated\n");
+		return EINVAL;
+	}
+
 	err = ubi_more_update_data(ubi, vol, buf, size);
 	if (err < 0) {
 		printf("Couldnt or partially wrote data\n");
@@ -412,6 +417,10 @@ int ubi_volume_begin_write(char *volume, void *buf, size_t size,
 		return -err;
 	}
 
+	/* The volume is just wiped out */
+	if (!full_size)
+		return 0;
+
 	return ubi_volume_continue_write(volume, buf, size);
 }
 
-- 
2.43.0

