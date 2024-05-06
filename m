Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606DAC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF918885AE;
	Mon,  6 May 2024 16:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715004444;
	bh=QSqpNTlZzZshI4ySD+SVAsp1AzEFxotjdyyMPeqW3Zg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gaPB2A7OKFHHr1GEi4HXFBBYPtb67S0hoqN/0dS7AzqqyogrwcUg/8P9aSA7H7y/u
	 RhqTD50uLS1jAcXVSlIWLXKoiGU2MaoXl4bAqHfK8rTS83tfLtFOiNZW/VcsHU+Q3x
	 CcP10HGImkBxEd0eIZ7iQ6axEtiTg+mmQrHLDjKJvTysMPk5X9wS2+QZJAvICOCKaq
	 uYi2gd37+3h2VWIYVSwwOx2bfvANUwzZ4vnOUSpTPBZ1bnM+jgyNF+sBLsJwz7KfBy
	 j1tnQ+Er7QYYGsptTpobUrVKF6iMlenMUgBgo5ID1f8X9uWQkKiz8Y5QprwCgV2aTR
	 U2TzTuAnDg8CQ==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8A69C885F7;
 Mon,  6 May 2024 16:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715004443;
 bh=QSqpNTlZzZshI4ySD+SVAsp1AzEFxotjdyyMPeqW3Zg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=u+L5ZdTJmQ13IGuKzsvYpnBW85X27s+Z9P3vyxa1nCI8f4+S99mS4twNKSwBruzhW
 vf4aYVXLc0EAboOr5ZOYJHUiKO+6zYF6bt2YJncKbjKcS4UpokjjlL1Be2W1GfC+6e
 UetyJs4uV6v4zMGzTPsE5MZ0iG/WCJ4DFXfWVVvfWVn+pLely8g+ShPFj1ap0DWV0g
 nxPO8u/l3j+HXsFSCiauahGh5rpABopY4V+DbhILQdqcfWR7ZBwPCnvvzTSNOfJAp4
 3izKDaiDj/uMrznZrOk/tL7vTbxFzJVVfCifmA4oiLkYyqGtM5Jyt8AMPvasKl0DaM
 ZbfKAl/tmX/oA==
Message-ID: <c02ef9dd-669a-9ea5-b764-c03ddff7ee75@denx.de>
Date: Mon, 6 May 2024 16:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: Add support for ZSTD decompression
Content-Language: en-US
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@sifive.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20240430102358.11163-1-piotr.wojtaszczyk@timesys.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240430102358.11163-1-piotr.wojtaszczyk@timesys.com>
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

Hello Piotr,

On 30.04.24 12:23, Piotr Wojtaszczyk wrote:
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
> 
>   fs/ubifs/ubifs-media.h |  2 ++
>   fs/ubifs/ubifs.c       | 55 ++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 55 insertions(+), 2 deletions(-)

Looks good to me, thanks!

Acked-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
