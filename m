Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B608CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 13:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9255A828A2;
	Thu,  2 Oct 2025 15:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E4F2831D3; Thu,  2 Oct 2025 15:48:58 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F4380107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 15:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.240])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8BB50B2206D1;
 Thu,  2 Oct 2025 15:48:54 +0200 (CEST)
Message-ID: <84f45e99-9c2f-4ab0-8c3c-1fe8c9df10cb@freeshell.de>
Date: Thu, 2 Oct 2025 06:48:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] env: spi: Fix gd->env_valid for the first write
To: Marek Vasut <marek.vasut@mailbox.org>, Michal Simek
 <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>
References: <803db0f01d568fcf702368a64eed007bde1d8bf8.1759397673.git.michal.simek@amd.com>
 <930f951c-d2ae-48e8-b8c1-680e2b5b3985@mailbox.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <930f951c-d2ae-48e8-b8c1-680e2b5b3985@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Marek,

On 10/2/25 04:42, Marek Vasut wrote:
> On 10/2/25 11:34 AM, Michal Simek wrote:
>> Update the environment location selection logic to perform round-robin
> 
> We only have two copies of the environment, why round-robin ? That makes
> no sense to me. The actual technical information about the bugfix is now
> lost in this churn too.
> 
> The V3 commit message was perfectly fine.

"round-robin" is valid for two destinations.

You understand the V3 commit message? I do not. The expanded discussion
now exists on the mailing list and so I'm fine with whatever commit
message is the result. Thanks for your patience.

Acked-by: E Shattow <e@freeshell.de>
