Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F1C001DF
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 12:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F413986FD5;
	Fri, 20 Oct 2023 14:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697806274;
	bh=ZpgNhmmhB+VdP/jJ3muCcEBnx/yzb6pjLMEOOHMxelM=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WfUBoPVeVGDRfLljX/WvP4CRh4wIK6aGNEq+IUc2HphJNKE6m5uPpS0h0VXsQas9w
	 zPZ7p9+YZNruSVzuvnclLDHKYab9gp2LwLWIwtmCogO7kYKdWRu1gIRY204Pgz+SVA
	 T3O6YzThlY5QtH2qnR+zYv7QkHKsJry4kCd4i47haThDZbEMR81t6WYH9gVl66HnB0
	 EK2STodQF5QaBUWR2mw0KqPE3tqeCVF+dCN9LB6eB/pyoIuBh75QkOdxiwt6o2yAE5
	 3+SbfWztgfpMjg1Uugz4ez4cKGiscg/5ju+wzcphQm8f01XkPmsqw4y3qTgqnjNxDb
	 ORVz9D2xzmQ1A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B03874AF; Fri, 20 Oct 2023 14:51:12 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D7786F83
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 14:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SBkwX3K1rz9t3p;
 Fri, 20 Oct 2023 14:51:08 +0200 (CEST)
Message-ID: <f84925f4-9c3f-4901-902c-49bb10a10765@denx.de>
Date: Fri, 20 Oct 2023 14:51:08 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SBkwX3K1rz9t3p
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

please pull this next small batch of Marvell related patches:

----------------------------------------------------------------
- kirkwood: Pogo v4: Enable LTO (Tony)
- mvebu: AC5/AC5X: use fixed page table size (Chris)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=322&view=results

Thanks,
Stefan

The following changes since commit e463222cce0df86f05a117f06e1737f539841fe6:

   Merge branch 'master' of 
https://source.denx.de/u-boot/custodians/u-boot-riscv (2023-10-19 
09:40:04 -0400)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to 37047b4c378d7707ffb86295c6d24ca5240a07dc:

   arm: mvebu: AC5/AC5X: use fixed page table size (2023-10-20 11:57:26 
+0200)

----------------------------------------------------------------
Chris Packham (1):
       arm: mvebu: AC5/AC5X: use fixed page table size

Tony Dinh (1):
       arm: kirkwood: Pogo v4: Enable LTO

  arch/arm/mach-mvebu/alleycat5/cpu.c | 5 +++++
  configs/pogo_v4_defconfig           | 1 +
  2 files changed, 6 insertions(+)
