Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2523C10DC1
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B49B87630;
	Mon,  4 Dec 2023 11:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701685104;
	bh=jbmx6HfgMttNl9/ifQN6CMQNaYh053ebud96m+cNusU=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WSyrefVnGEHQJ9nGMnp+ePE/Rirks7xG9pgBXkkTym1eegP+ROW8vcjJ5xNFx5z2e
	 irdrcDLZYA5ugRUP8Ix9C0TX5bIOzppQ5t2Ums4GyNKVyVUsxIBUXDu1FCRsB1YTdI
	 R7+d3w4YbvEfMWZbKAZ5Aboi8MbwwP0Ff4d8WvawBSW70RpuTs939sW4+0WgdoR05k
	 wSukfMi2QKyI18j88ZDkyWnELp8A9SCTyIAyn4vTilet7iF6JcRlA0azvOFbC2rp2X
	 xzMB8gUcjO6jjsQHRpMo7I4MYJ48GQTFpUEeu+5rxAgO4aOT/AXBVb3uiD0zxPxjYM
	 /XD3bft5ULIsA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF41687655; Mon,  4 Dec 2023 11:18:22 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8E1A87626
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SkKPQ1mZ3z9sVl;
 Mon,  4 Dec 2023 11:18:18 +0100 (CET)
Message-ID: <b5692c19-9431-47ee-9053-52deef9ac539@denx.de>
Date: Mon, 4 Dec 2023 11:18:17 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SkKPQ1mZ3z9sVl
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

Hi Tom,

please pull the following watchdog related fix:

----------------------------------------------------------------
- Correct watchdog timeout print message (Chanho Park)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=327&view=results

Thanks,
Stefan


The following changes since commit 5c4e9d0c74a8c2f8d0f4e0ab9cf44959298c2bad:

   Merge branch 'master-rpc-off' of 
https://source.denx.de/u-boot/custodians/u-boot-sh (2023-12-03 16:30:32 
-0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to a341a0e01f8087904eccbf3fe7baba63a62f9674:

   watchdog: Correct watchdog timeout print message (2023-12-04 08:09:09 
+0100)

----------------------------------------------------------------
Chanho Park (1):
       watchdog: Correct watchdog timeout print message

  drivers/watchdog/wdt-uclass.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
