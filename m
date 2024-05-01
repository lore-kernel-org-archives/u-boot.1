Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F4CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 05:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B8788ACB;
	Wed,  1 May 2024 07:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714540113;
	bh=weFliPgGRa0K+uJNG/Q2O0kzR08ZTyFdw7pm5c24/1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Xn4s0HoFnjeH3Db+T2VKJsVK1cHV9JVbZBOxi/F7UXTX11xikQRmhwNg/txhqnHkF
	 8XiyUDgDD+W1CMZJDwbQKGgvvmG7nUKuLY/8DcisJeoDht5d6W/s9GwjTjzlAev2FB
	 utuMW7xnFhbFB+KqcAd54hBWvUexndA1y8mjuagWan2npapoL9GGMOMl4JgWkMb2LX
	 FHTDdRnTUDIANn4Yq2lZVjpJe2fTRz3hSMSWrakXtPW/77NzR+UrViTdRk1xVoeYjV
	 Jr1BQysAdHSUqFFtXgeJW0epLpIaMP0I/ub+IkfvQYHnx6lIAXyy1Lp7xpvds6F/Po
	 Kqg3XRVru6gcA==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2196B88AE2;
 Wed,  1 May 2024 07:08:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714540113;
 bh=weFliPgGRa0K+uJNG/Q2O0kzR08ZTyFdw7pm5c24/1s=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=d4ZFeohQjq+lfP6dM4Yl5lOjeO7tx3UZJyTg3dKKdCvWz5gXp2w2nUC0RbxHww3IU
 E11igIhiW7wOWimIyVVbe91CF2cbBpIxPCAvKAwteYh1C201MaoMoSd5XBCjJoQhtA
 TvIQO6fZ0X0/1Z1qUKvD+jUwJsoen2TBrFAM2MnSNAbADYM/WL35w+ul7p8ZXkYnB4
 ELERmkS1SrNibiA9KCwFTRaG0QfO3HNxm3r6l4H/6eqi2H4qbmnrwEbEZ5ezZQzQM6
 35gBjgqS+Hn3vxiiI8detkpBG2gnpSfocJKFDVHm9mvRxRryE0BRoz1VYlOGP6+TK/
 mbLbsPEj+u5Lw==
Message-ID: <2da10997-60e9-0dd3-c2d6-241aed4c637c@denx.de>
Date: Wed, 1 May 2024 07:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 027/149] board: bosch: Remove <common.h> and add needed
 includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-27-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240501024316.1767971-27-trini@konsulko.com>
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

On 01.05.24 04:41, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Matthias Winker <matthias.winker@de.bosch.com>
> Cc: Philip Oberfichtner <pro@denx.de>
> Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Cc: Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>
> Cc: Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>
> Cc: Heiko Schocher <hs@denx.de>
> ---
>   board/bosch/acc/acc.c        | 2 +-
>   board/bosch/guardian/board.c | 2 +-
>   board/bosch/guardian/mux.c   | 1 -
>   board/bosch/shc/board.c      | 2 +-
>   board/bosch/shc/mux.c        | 1 -
>   5 files changed, 3 insertions(+), 5 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
