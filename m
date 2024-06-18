Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C90C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCA788354;
	Tue, 18 Jun 2024 16:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718719436;
	bh=b4/tG7Q+JVA5IDAgmGeFSYsjjtGrVE4s02G13HoQu7E=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AV32FQeDuSMl/pku7JiWTXdHQhq/SgEGvFxSBioKMi7bO8h7tejKWFIpqs4BqKi1Q
	 Ymso0vYrLj27hmmrfveH7i9zj5xDy7TyLVYXXoLAZWMCkUi8yfGENWyUOlwnoyEruy
	 DVsNTwZvg6nArXHH6d9DhpU1e60fF5KroNiPI2Lo6+B/M3Hj75fNbmC9Gbe7eysme+
	 VUW740tqunCxVkQ36DFbqVrwp1/TscOdM9W3XQqSD2T+Tn9GZAxOXRT5fb4+Qk7A6k
	 McVZJPLnu6EFWQHuoYbHUTe9eAUMczGxy/HG2JM8ht5RM/7RnQcjH1x967t2i9wJtn
	 W88b8bZ7XarKw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B254488354; Tue, 18 Jun 2024 16:03:55 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89495882D4
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4W3T4l13Tyz9sq6;
 Tue, 18 Jun 2024 16:03:51 +0200 (CEST)
Message-ID: <ea3c974b-83a9-416f-8b6f-cab6cf68fb30@denx.de>
Date: Tue, 18 Jun 2024 16:03:50 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-watchdog/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4W3T4l13Tyz9sq6
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

please pull the following cyclic related change to fix the
CI build issue here:

----------------------------------------------------------------
- cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000 (Jiaxun)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=371&view=results

Thanks,
Stefan


The following changes since commit 16324b43db3f2b4fbbc3b701893fcfc4104f33fb:

   Merge tag 'u-boot-nand-20240617' of 
https://source.denx.de/u-boot/custodians/u-boot-nand-flash (2024-06-17 
09:27:28 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-watchdog.git

for you to fetch changes up to 1fd754cebd38d7456caa82bef15225cbe77960ec:

   cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000 (2024-06-18 
12:34:37 +0200)

----------------------------------------------------------------
Jiaxun Yang (1):
       cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000

  common/Kconfig                 | 2 +-
  configs/octeon_nic23_defconfig | 1 -
  2 files changed, 1 insertion(+), 2 deletions(-)

