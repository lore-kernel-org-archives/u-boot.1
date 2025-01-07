Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B46E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 12:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E3C805E2;
	Tue,  7 Jan 2025 13:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736253955;
	bh=KM9VClwumAgcUPA3hV7efKRM+wE/PA4TSOSy46yjJ14=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=N4zlndc2leMHf0ktzz9FQ2VdoZ0obkpEwop2zXdcykJgY/fADilbh73c6cG0xQZfq
	 zkm6XlLtDiJBmSwD6BAZh344TNSYpXff/Po7OFeK5IwJgVDCFNG92ABhr6LJvpMG5H
	 nfBaWCe4OcIxfX8DXt7pL1AjkmPfwQVALuMTIeDYshmEusli4z3ghaBZgJfltCtSQ9
	 nce1Q0ngoUPRo/nTjGZ1LZRxCwTZBdizzmjvX+3C+Nk4VzSQgnKhwEgwHDsyUJAWlp
	 UnaNaYmzbXdrFGwy7W30+8O2Te3zV/vNwfpiCfz+WOAWjJdmORX2W4Zu/50G2L4YqY
	 7oRahZ3oKAEiw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E58805D5; Tue,  7 Jan 2025 13:45:54 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 704DE80079
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 13:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4YS9l00wQRz9sSb;
 Tue,  7 Jan 2025 13:45:48 +0100 (CET)
Message-ID: <2d78e7a4-1722-41b7-8b29-a722d27075cf@denx.de>
Date: Tue, 7 Jan 2025 13:45:47 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4YS9l00wQRz9sSb
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

please pull the following watchdog patches:

----------------------------------------------------------------
- rti: support SPL (or re-start) (Alexander)
- rti: drop hack manipulating WDT clock rate (Alexander)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=380&view=results

Thanks,
Stefan


The following changes since commit 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72:

   Prepare v2025.01 (2025-01-06 18:54:44 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to 5964f24f15473709fb9d897230c3f20e998c88ca:

   watchdog: rti: drop hack manipulating WDT clock rate (2025-01-07 
10:29:58 +0100)

----------------------------------------------------------------
Alexander Sverdlin (2):
       watchdog: rti: support SPL (or re-start)
       watchdog: rti: drop hack manipulating WDT clock rate

  drivers/watchdog/rti_wdt.c | 21 +++++++--------------
  1 file changed, 7 insertions(+), 14 deletions(-)

