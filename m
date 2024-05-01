Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036FFC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 08:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DAF888B17;
	Wed,  1 May 2024 10:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 924D18875F; Wed,  1 May 2024 10:23:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2956188B17
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 10:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.hoyes@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72502F4;
 Wed,  1 May 2024 01:23:26 -0700 (PDT)
Received: from [10.1.198.41] (unknown [10.1.198.41])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 016303F793;
 Wed,  1 May 2024 01:22:58 -0700 (PDT)
Message-ID: <0d172acc-9004-47b4-b33d-02ec41d2c43c@arm.com>
Date: Wed, 1 May 2024 09:22:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: Move sev() and wfe() definitions to common
 Arm header file
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, andre.przywara@arm.com, mk7.kang@samsung.com,
 ilias.apalodimas@linaro.org, wqu@suse.com, neil.armstrong@linaro.org,
 sr@denx.de, michal.simek@amd.com, patrick.delaunay@foss.st.com,
 sjg@chromium.org, patrice.chotard@foss.st.com,
 quentin.schulz@theobroma-systems.com
References: <20240501081633.120913-1-peter.hoyes@arm.com>
 <20240501081633.120913-2-peter.hoyes@arm.com>
Content-Language: en-US
From: Peter Hoyes <peter.hoyes@arm.com>
In-Reply-To: <20240501081633.120913-2-peter.hoyes@arm.com>
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

On 5/1/24 09:16, Peter Hoyes wrote:
> From: Peter Hoyes <Peter.Hoyes@arm.com>
>
> The sev() and wfe() asm macros are currently defined only for
> mach-exynos. As these are common Arm instructions, move them to the
> common asm/system.h header file, for both Armv7 and Armv8, so they
> can be used by other machines.
>
> wfe may theoretically trigger a context switch if an interrupt occurs
> so add a memory barrier to this call.
>
> Signed-off-by: Peter Hoyes <Peter.Hoyes@arm.com>

This patch version should have included:

Reviewed-by: Andre Przywara<andre.przywara@arm.com>

