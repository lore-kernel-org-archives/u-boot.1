Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773F8C47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 15:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624D9878E5;
	Mon, 22 Jan 2024 16:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="gvB/5d6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95EAF879E0; Mon, 22 Jan 2024 16:46:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFB1877EC
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 16:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TJZMs1wCBz9sSH;
 Mon, 22 Jan 2024 16:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1705938409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zngyr5RlwV95wGXnjKpP/P3wPeCTT9xPL6qcXhVyz68=;
 b=gvB/5d6zmgxCRUoXFjx/1HChVhsN7s6U//kJajdTWF7t6aiwyfXqp4LcPkKHy/CYvH+6x3
 tpunr3KEqxu0IzXrTXbZkOCgxVICrKsl4xRoQ0CTdzIdAprZgVGdE361m4dQG/IEqIAUrf
 Yy1Mqo93dZHS/XhSwnoK6WDev8C9YxSYP3/3PgQV5M2dSfw+Bz9Yuf/HpjdcIpoPIj2jNv
 IdEo7ADtDnGoVZpEP9zm+9Ara9KVYI9J+7Ju+QgxSjxU/cmgislDd59BJJAJMB9B0pKz46
 9+0H852zSjmtnBvCc2/Alkec5s2DAhJ4uV0VTgP545JNDhKxDkdJ6yZ78Xm3RQ==
Message-ID: <b3123d65-01a6-42c5-8a21-c5a039b281d5@mailbox.org>
Date: Mon, 22 Jan 2024 16:46:48 +0100
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8taikzciaa7qbkdm9asuh3gdtrfgkkwf
X-MBO-RS-ID: db724180cc3b06c50ae
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

please pull this next batch of Marvell related patches:

----------------------------------------------------------------
- solidrun: clearfog gtr: add serdes configuration (Josua)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=334&view=results

Thanks,
Stefan


The following changes since commit 3c04fcf3137d5f694d52b8f355373e4baabe5f78:

   Merge patch series "k3-j721e: beagleboneai: Fix USB" (2024-01-20 
11:39:13 -0500)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-marvell.git

for you to fetch changes up to bb6e89048ceaf26a4d775750715e3279dbd73d07:

   board: solidrun: clearfog: fix serdes 1 / eth2 speed for clearfog gtr 
(2024-01-22 12:47:45 +0100)

----------------------------------------------------------------
Josua Mayer (2):
       arm: mvebu: clearfog gtr: add config option to select serdes0 
interface
       board: solidrun: clearfog: fix serdes 1 / eth2 speed for clearfog gtr

  board/solidrun/clearfog/Kconfig    | 19 +++++++++++++++++++
  board/solidrun/clearfog/clearfog.c | 19 ++++++++++++++++---
  2 files changed, 35 insertions(+), 3 deletions(-)

