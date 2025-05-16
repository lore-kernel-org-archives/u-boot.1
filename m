Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED89C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D5A80107;
	Fri, 16 May 2025 18:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747413693;
	bh=W4qnaFdS0Hd8Hyj33BJjZnOZHbWqFRGDhvY/FPAVrvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PARM0+Fyv1s749LdGgIk3pQQ5iXzTvLxsYxlcFSVo5IiNit1AsnFOh/GoFTB2YOU2
	 VvtYn58wOP3vuS3jT6cQbqBCgtGu89aozpwZkhYzkfR6IwvLE3i1Btc+f4qTURD3tW
	 Yz9Nw8t1dPStwoH1w1mPCA6/VX1hlFOjTCfBNKKAPRFXfSvL2zGwyFPOLU+xq62OvP
	 IIuTbjEv8jG7CVUyxQrEzw6QV+CaVmLsEl3ji8dQliU8lPZfwiL41BqETLeGjZNsaE
	 1G6w6gUziKar4IjjAL+6O8cGDBQ4D7jyH7VyOmeq18YX4/gmkHM8GgEq+1HgiU+W13
	 sD2/TXSTKFWnA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37C680FA8; Fri, 16 May 2025 18:41:31 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249398006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZzXsN0BYqz9shL;
 Fri, 16 May 2025 18:41:28 +0200 (CEST)
Message-ID: <cc528492-9693-4b0d-ad4f-afb0c6516ce7@denx.de>
Date: Fri, 16 May 2025 18:41:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] make cyclic_(un)register idempotent
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250507105821.484442-1-ravi@prevas.dk>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250507105821.484442-1-ravi@prevas.dk>
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

On 07.05.25 12:58, Rasmus Villemoes wrote:
> Three small patches I've been meaning to send for a while; I really
> believe (as I now learnt Thomas Gleixner also does) this is the way
> timer frameworks should behave.
> 
> Rasmus Villemoes (3):
>    cyclic: make cyclic_unregister() idempotent
>    cyclic: make cyclic_register safe to call on already-registered info
>    cyclic: document new guarantees for cyclic_(un)register
> 
>   common/cyclic.c        | 17 +++++++++++++++++
>   doc/develop/cyclic.rst | 13 +++++++++++++
>   2 files changed, 30 insertions(+)
> 

Applied to u-boot-watchdog/master

Thanks,
Stefan

