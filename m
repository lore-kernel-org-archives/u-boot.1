Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D18C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 08:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19CAD8843A;
	Sun, 11 Aug 2024 10:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723364704;
	bh=EhzPmHjrhnHfDhJwsvPE88LAifIvvzxyQbMS3TS2Vp8=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=bSmN53EcoFY0shNWlpYxwgHUsHMm9Oz8pws5Hrx98+rb7Xx26a2osur+TwTj8qhMd
	 zo1CBNAKOomEqlEIU4uut/0JOk5G88rSWQ4FQpNo3YXn8XfLTT+Ip0lRsBslj4gadk
	 uVU40yzajIkPmKZiruPDjwMYdwO5BNvNPmlrXHKCaI7T8PD3zqlgwt1bKEioo7KN4B
	 9ZCjXUTaDdk6SBm/uXRUuM8AS8NJkwCI1jJrxreZqeYKFRl3GtqB9ny+SFU1MdUY0B
	 /Hro/isoYTqOvO61TzJvFNi5C0mm0H1Ru8KZmg/y/ONUmKPwCTNP0v/ukSx9eRcfyp
	 1AMjBQrMpBtGw==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B4C5688365;
 Sun, 11 Aug 2024 10:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723364702;
 bh=EhzPmHjrhnHfDhJwsvPE88LAifIvvzxyQbMS3TS2Vp8=;
 h=Date:To:Cc:Reply-To:From:Subject:From;
 b=Kq1NQA+wEF/RwCcclPbhh3irob5S/429UKqRQi7BAO8hHF4avlq0kYFT3ra8bEK8x
 F6XOyEF0KfzSa6Y/dEYf0Cmc2s2hAP/f1pF0B6GncoMW661eR28GIEKkHxC7ywucD5
 PyC9daKjPgXSungjgW45jUoEndI7O5wGh7H7Qmc8K6NMnOi2uX3+Gsp1Wrkpgtk+Bt
 Xp9G31tv5qR3dJDj8G7QNlcJ4S/pPBxDMG4vqAI/vwTAgADzZIXDHqRQLrDfPBYfBS
 cK2L5Jnic4MqhgInuwbY9uNLBxtbYSakOPeQqe8p5KdRqyIsHOtsmTRJjUEjezV+QW
 K0KQxgy8lxUeA==
Message-ID: <bfabd86c-6fb5-06e9-b0cc-c1aeaa1b1d09@denx.de>
Date: Sun, 11 Aug 2024 10:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-ubi
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-ubi the ubi fixes for 2024.10-rc3

The following changes since commit 7bd2559cb30a4e800db519e88a22a25f13c753ec:

   Merge tag 'tpm-master-09082024' of https://source.denx.de/u-boot/custodians/u-boot-tpm.git 
(2024-08-09 14:00:04 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-for-v2024-10-rc3

for you to fetch changes up to d16bda85ff0762aa96e36fa65d2e3b5342d73d7a:

   ubifs: Call ubifs_iput when ubifs_iget is used (2024-08-11 06:52:15 +0200)

----------------------------------------------------------------
ubi fixes for v2024.10-rc3

- ubi memleak fixes from Alexander

- ubifs: mount fails after power cycle
   fixed from Ravi
   commit ported from kernel commit 304790c038bc4af4f19774705409db27eafb09fc

   HS: fixed checkpatch Error

   ERROR: Remove Gerrit Change-Id's before submitting upstream
   #213:
   Change-Id: I487ae4d172e228e72ac31d158d668f209142bce0

   removed this line from commit message.

- memleak fixes from Michael in ubifs, missing ubifs_iput(inode) after
   ubifs_iget() calls.

special thanks to all of them for detecting/fixing and testing
this patches!

----------------------------------------------------------------
Alexander Dahl (4):
       fs: ubifs: Fix memleak and double free in u-boot wrapper functions
       fs: ubifs: Set pointers to NULL after free
       fs: ubifs: Make k(z)alloc/kfree symmetric
       fs: ubifs: Add volume mounted check

Michael Trimarchi (1):
       ubifs: Call ubifs_iput when ubifs_iget is used

Ravi Minnikanti (1):
       ubifs: mount fails after power cycle

  fs/ubifs/replay.c |  2 +-
  fs/ubifs/super.c  |  9 +++++++--
  fs/ubifs/ubifs.c  | 40 +++++++++++++++++++++++++---------------
  3 files changed, 33 insertions(+), 18 deletions(-)

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=121&view=results

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
