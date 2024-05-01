Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB982C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 05:10:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1817887FFB;
	Wed,  1 May 2024 07:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714540214;
	bh=Sqzx1dz9Lc9Rs6Wd6TJv+fjZQw9cSpBcOGG3Gz9+M1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=plIYbGjMFspcGhbz+nqrjuicgQqVSiFg5THD3CUgdyVCxgt4Xv8WNxQdvZAKoVJhz
	 7cJei3pEHR83qwvyxjj96RNtY/2UkeOUSDrNi7qXFL6VnnG+SlK1p8wai7txFJn/LJ
	 aJVeyJsy6LTSMQPLN55AfG7iIE6vbYEy8vhQM6MOoJ0lXSQor+LM49rgidk6qNxgfl
	 8Dlmj52CzS0gzyPD4SY3Ekmwszunkj5iAQ5b9J2f5ivx5nlEAvKMeSz3OS/INTtj/7
	 dOFNFhxvpFbUcszlMXLhdD1JVhsnAl6Y5jOOAMzau3oxtiAmZe2BnnpJSyVeXrEp4W
	 UuivQIxDI7eZA==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6839E87EB2;
 Wed,  1 May 2024 07:10:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714540213;
 bh=Sqzx1dz9Lc9Rs6Wd6TJv+fjZQw9cSpBcOGG3Gz9+M1k=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=Ji6Ryglm7FBruY1/RCKtw0F4NUX0QQy4V3BCCHY2UPrggoteFiE7cvcmpV6m04atk
 8O+sD7AVGQU3m79Hl0F0zB2UXH+HY57sBflWdw4s2T+LOPNgIFopg2H/7M0sIN7E4o
 TcJKJAuQK0OuoWgcOIbFal0EZGFg4tYQx3k882aFGA7Et/qfdijukNJUnI+hsFtTVZ
 SuJbUlMF3gsf5mVO8zKBG0yGiPRPOptGKP8N936mfnojnpzlSJk1PtRpmivzQkoeSF
 yhHvhvN14935x98KcK7c0oQf9GkNGj2ZHvJSHauxEnDesOOCrS3j+TgLh7sKmuQqnW
 vIiQEP2aFcpnA==
Message-ID: <d89e032c-b205-bbc0-ec7c-a22b14691c51@denx.de>
Date: Wed, 1 May 2024 07:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 116/149] board: siemens: Remove <common.h> and add needed
 includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <agust@denx.de>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-116-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240501024316.1767971-116-trini@konsulko.com>
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

On 01.05.24 04:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Le Jin <le.jin@siemens.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   board/siemens/capricorn/board.c   | 1 -
>   board/siemens/capricorn/spl.c     | 1 -
>   board/siemens/corvus/board.c      | 2 +-
>   board/siemens/iot2050/board.c     | 2 +-
>   board/siemens/smartweb/smartweb.c | 2 +-
>   board/siemens/taurus/taurus.c     | 2 +-
>   6 files changed, 4 insertions(+), 6 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
