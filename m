Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFB1CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D17B8722C;
	Thu, 19 Oct 2023 12:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697711760;
	bh=b9XTeqp99ReHYTkDkL4BWbXhsPJ0yyJTYfkBvuabUsQ=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=h8By9b07p8ielUGvg3tD+awwglFpybTwC7iB8pHyuvtCU12ge5nywN6YXmpGB+Prj
	 b/9FNJW5fx8INSwwXTqmFpW+4VmujEmA0HJyMS5DHxp+qwwB27rebaf8ue9WoPRTgr
	 Ql2U/v5k5CgFULJvGkW7jPdUuszK51mnkhC9TgcAbVZsoAgjKpNU740T9Y/6xMKM9M
	 7CKow1VLVGyKUGgAEvRXe2uYR5URR7Y7xY32U5il63Try7SAfSyuv315fdXb7sFz4T
	 mnrhWCM8II6pYiIpm2TReJVE+G2qLeOdJtuNkDkNl+fRtJpwQljEO6dbH12tzyIKxd
	 wsP738+be2fXw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8B88722C; Thu, 19 Oct 2023 12:35:58 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC647871BD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SB3yy2mnPz9sZs;
 Thu, 19 Oct 2023 12:35:54 +0200 (CEST)
Message-ID: <12efec73-ed5b-44f7-8398-a85c3b80ad17@denx.de>
Date: Thu, 19 Oct 2023 12:35:54 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

please pull the following watchdog related commits:

----------------------------------------------------------------
- sandbox: watchdog: Avoid an error on startup (Simon)
- nuvoton: Fix reset/expire function error (Jim)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=320&view=results

Thanks,
Stefan


The following changes since commit 9a0cf3993f71043ba08c315572c54622de42d447:

   Merge branch '2023-10-17-spl-test-some-load-methods' (2023-10-18 
08:28:00 -0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to 127d03893bd51f855e1a277e31a8258105ace42a:

   wdt: nuvoton: Fix reset/expire function error (2023-10-19 07:51:12 +0200)

----------------------------------------------------------------
Jim Liu (1):
       wdt: nuvoton: Fix reset/expire function error

Simon Glass (1):
       sandbox: watchdog: Avoid an error on startup

  arch/sandbox/dts/test.dts   |  2 +-
  drivers/watchdog/npcm_wdt.c | 10 ++++++++--
  test/dm/wdt.c               |  4 ++--
  3 files changed, 11 insertions(+), 5 deletions(-)
