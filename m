Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED110C28B30
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 05:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA1681CA8;
	Wed, 26 Mar 2025 06:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="gwyu1mGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B918186D; Tue, 25 Mar 2025 20:14:45 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A1481026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 20:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 74188120008;
 Tue, 25 Mar 2025 22:14:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 74188120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1742930081;
 bh=/1BW82OOZYVNsx+y2MaAhTrT7ChRszvu4Sz4FYRTgo0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=gwyu1mGW+nEULuga4Ho17/8otJpLuPJjiZ1GwBTx1coNvh7RqbO8/6HobMjZw4A3w
 GLCve0iEBPqx9FqLKXuWtZ86so4jBfSncVQzwxmI+3O2sybF5Dj7r7yBNgqsOufyMd
 gDHDJp8a1AVDmjpSHLp8zXP5cCJnx8NFZ/Ch6P1ArAKQJfYxSqJNT3ySCvvud3nvX8
 L9bberEL/q0AJqyNKXsDZMnQyhYdPo/+ozl0LTV0UWGDLb8PEGj4drDWRAoZceak5J
 B99qgVYlca9rVElGTiNMc724ZdpzeLsdfC2tUDAtvTLnGdrChFlGFzxozdrZSo5idH
 JuOhSvWui8f0A==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru
 [172.24.201.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 25 Mar 2025 22:14:41 +0300 (MSK)
From: Alexey Romanov <avromanov@salutedevices.com>
To: <onilsson@rums.se>
CC: <avromanov@salutedevices.com>, <hs@denx.de>, <kmpark@infradead.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH] ubi: fix bug creating partitions for non-existent volumes
Date: Tue, 25 Mar 2025 22:14:10 +0300
Message-ID: <20250325174708.426459-1-onilsson@rums.se> (raw)
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325174708.426459-1-onilsson@rums.se>
References: <20250325174708.426459-1-onilsson@rums.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.28.160.9]
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 192098 [Mar 25 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51
 68896fb0083a027476849bf400a331a2d5d94398,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:7.1.1,5.0.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2025/03/25 17:48:00 #27843404
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 26 Mar 2025 06:01:30 +0100
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
Message-ID: <20250325191410.iELNoINY0MhJCy-z3HaaIIdl36zZn73AKsplgcT5Wec@z>

> The part_get_info_ubi() function was incorrectly returning 0 (success)
> when a UBI volume was not found for a given partition index. This caused
> the part_create_block_devices() function in blk-uclass.c to continue
> creating devices for non-existent partitions up to MAX_SEARCH_PARTITIONS

> Fix the issue by returning -1 when a volume is not found, signaling to
> the part_create_block_devices() function that no more valid volumes
> exist.

Hello, Oskar!
Thanks for your fix. It is correct.

Reviewed-by: Alexey Romanov <avromanov@salutedevices.com>
