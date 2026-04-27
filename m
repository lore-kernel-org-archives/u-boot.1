Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CE1FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C1F83693;
	Mon, 27 Apr 2026 14:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dM5ErKUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56ACE83AA9; Mon, 27 Apr 2026 14:21:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EC64F80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA0371684;
 Mon, 27 Apr 2026 05:21:44 -0700 (PDT)
Received: from [10.41.150.145] (e142021.arm.com [10.41.150.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1FE3F62B;
 Mon, 27 Apr 2026 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777292510; bh=hojbhjHMUiBo7adw0qOzWtjGel0Jlu+iJZWjgBG0Vns=;
 h=Date:To:Cc:From:Subject:From;
 b=dM5ErKUr5JHel+79LPdq3lzjYgftY0+tbtXjc/5fdSM1J5vWmioCj2a5d29sZlA6D
 ZGpejUN/NKHVluOVqv1Eu5bR7Rxq1rFdoWwzs/Q2Lonbxpv5FYkHcXmmf8DAdlS65Z
 OdSkdF4v0j9fnmc/nArACs8V+KHPhEHKq203sAwQ=
Message-ID: <aa0403ad-5d0c-464d-b8a1-d60830e10bd1@arm.com>
Date: Mon, 27 Apr 2026 14:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
From: Andre Przywara <andre.przywara@arm.com>
Subject: sunxi pull request
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

I was about the wrap up this cycle's pull request, but realised that I 
forgot to chase up on some details. Would you be able to accept a PR 
later this week still? There are only a very few mostly cosmetic patches 
ready otherwise.

Cheers,
Andre

