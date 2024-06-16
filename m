Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6711C27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 04:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B70488246;
	Mon, 17 Jun 2024 06:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="NwdoOqGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E39E8811C; Sun, 16 Jun 2024 15:34:39 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38A587B30
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 15:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mmkurbanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 20B94120005;
 Sun, 16 Jun 2024 16:34:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 20B94120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1718544876;
 bh=ikTFzh5LoUO41F3dGTwePIf1Zua908UljOUUlKTSsts=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=NwdoOqGeESuqKQ/S99PhSpLXZDukfNvK2YO06G9AVO841EuCY38F+q7QGuXBmwXty
 XjUIFxXkBUeVFdr1STSoSugNvgR0N7b4nXYoCVY6ansUrADy+9JThLtSx25fTagfOe
 9/6fJRfIlkZyi2I9s/uzxGNubXCQc6qiZPwcviaEiwL5L/L/VL58rSujlmJWN8HWTG
 cY8kB8OGrLpaSE5DgLEY55aTrs8PuEKBxBet90iIQpYUoMm3Di6p1ZhFiI45rQCdLT
 4BgTFb80XccyNc+SYDdjGsm9Vxwbfi8hp5ayX58x02rBjk2bD7m5FEBIVpj5OiAy7d
 BIBGYHRXSvJRQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Sun, 16 Jun 2024 16:34:35 +0300 (MSK)
Received: from CAB-WSD-0004828.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 16 Jun 2024 16:34:35 +0300
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
To: Tom Rini <trini@konsulko.com>, Dmitry Dunaev <dunaev@tecon.ru>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, Martin Kurbanov
 <mmkurbanov@salutedevices.com>
Subject: [PATCH v1 0/2] cmd: ubi: check 'updating' before calling
 ubi_more_update_data()
Date: Sun, 16 Jun 2024 16:34:16 +0300
Message-ID: <20240616133426.123299-1-mmkurbanov@salutedevices.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185944 [Jun 16 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:7.1.1,5.0.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/16 07:48:00 #25636995
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 17 Jun 2024 06:48:41 +0200
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
2.43.2

