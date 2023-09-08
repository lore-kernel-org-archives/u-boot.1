Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BFBEE8004
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7330B8620C;
	Fri,  8 Sep 2023 15:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="HA7qBAK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AA286A17; Fri,  8 Sep 2023 15:55:06 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB8685894
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ben.dooks@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Gn2snurd5a2YuLZFAj2qi3g4zEK/GUxdFSfbyfUbQE=; b=HA7qBAK7QBHxEhwhnfYQ8QzTmo
 PXeCdLI7EeM+xisBYiPC4Xd3W3QtCJMqlC2hyhj19PylNFF95pdRIN1f3zpgL34biNQKX1Q/rwGh0
 u21Lif2+bKP7BR/kUlNYrJ8sCXlUUzRdq19Svwy5wIkEloNOIXMiD7EvUIaMac7uy91ZnlMHAarza
 4okSzrBfkCD1x7LFSogKOTpchGveorgVwu9Bys7iovQiGDy5AeECq4hIITPct0SzBjNDjNCgIGCJu
 nxFNemDJvTEmfn/lYvcPOjsCH9sNUXBe1TyGAXLnIJqEXI0u88R+R8M4B7XYhdyz9mHtG57zwF4Fi
 Hf/DHviw==;
Received: from [134.238.52.102] (helo=[10.8.4.124])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1qebws-0052AL-3L; Fri, 08 Sep 2023 14:55:02 +0100
Message-ID: <6c15e2be-0173-4bfe-a133-24ae462a1471@codethink.co.uk>
Date: Fri, 8 Sep 2023 14:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cache: sifive: clear out the error irqs on init
To: u-boot@lists.denx.de
Cc: palmer@dabbelt.com
References: <20230908133707.104592-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230908133707.104592-1-ben.dooks@codethink.co.uk>
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

On 08/09/2023 14:37, Ben Dooks wrote:
> We are getting a number of cache errors on starting an OS,
> so to try and avoid this, clear the errors when we first
> probe the cache.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> [ben.dooks@codethink.co.uk: changed from sifive.com address]

As a follow-up, this hasn't been checked to see if it fixes the
unmatched or other fuXXX cores. If someone could test it on
others and see if it removes the issues, then it would be more
than worth getting this merged.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

