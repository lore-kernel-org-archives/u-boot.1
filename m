Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9159C35FE7
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E1E88E9F;
	Wed, 18 Sep 2024 08:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Q5nIH2oT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1212788DCB; Tue, 17 Sep 2024 19:54:04 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7DD88D68
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mmkurbanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9F38610000B;
 Tue, 17 Sep 2024 20:53:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9F38610000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726595637;
 bh=Qhaw5isVDMXHzOJVooXg57AJ8UqN1oa3A/H/QwfRSG0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Q5nIH2oTY9ce952ot0AIO0hiTNmQGzjZaHQwMakZKnZDDnx626P3BRv5nZgebk8Qq
 oX/fNyFSws6WEMCn/RxAXkt3fzOD6PddeTtCqzOZeWt1DB95tHeUQ5LqlIgMRWKIQe
 CML6edwBxYU49NGufn1QCMquFAZMFgHNAlE87gVsrCZLZlYMK7S2/R3A1F6p/kLTv7
 5Egnekx882FoF5NYaxlQZsjodNp2MKkcnHOrF9LEWh6W+4bxPb5RlBzPBtkBZI6XNM
 B8YiCy6Q9tB6MbNimAcOIDmnI6VEi7lyL6waJooHkint+TXxnfIzLHKNc3iyeP2PHD
 btPc+Iy/NxVIQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Sep 2024 20:53:57 +0300 (MSK)
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>,
 "Heiko Schocher" <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Martin Kurbanov
 <mmkurbanov@salutedevices.com>
Subject: [RESEND PATCH v1 0/2] cmd: ubi: check 'updating' before calling
 ubi_more_update_data()
Date: Tue, 17 Sep 2024 20:53:21 +0300
Message-ID: <20240917175327.13311-1-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
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
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/17 15:06:00 #26605542
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

Martin Kurbanov (2):
  cmd: ubi: remove redundant initializations
  cmd: ubi: check 'updating' before calling ubi_more_update_data()

 cmd/ubi.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.43.0

