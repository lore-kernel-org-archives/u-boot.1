Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F5BC77B7F
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 02:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC8382B18;
	Wed, 25 Jun 2025 04:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A96382C84; Wed, 25 Jun 2025 04:00:16 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC5B782977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.61.206])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C756AB4D0211;
 Wed, 25 Jun 2025 04:00:11 +0200 (CEST)
Message-ID: <7025bab8-117b-414d-9bb9-78288681fec2@freeshell.de>
Date: Tue, 24 Jun 2025 19:00:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] spl: fix error handling in spl_fit_get_image_name()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Sam Edwards <cfsworks@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de
References: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20250624153431.46986-1-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

On 6/24/25 08:34, Heinrich Schuchardt wrote:
> spl_fit_get_image_name() used to lack a detection of malformed image name
> properties in FIT images. The change in commit 3704b888a4ca ("common/spl:
> fix potential out of buffer access in spl_fit_get_image_name function")
> tried to fix this  but led to function spl_fit_get_image_name() no longer
> detecting if a property at index > 1 does not exist.
> 
> This patch is reverted.
> 
> An explicit check for malformed image name properties is introduced.
> 
> Cf.
> [BUG] [PATCH v5 1/3] common/spl: fix potential out of buffer access in
> spl_fit_get_image_name function
> https://lore.kernel.org/u-boot/38f5d078-3328-4bdb-9c95-4fb5fe89ddc2@gmx.de/T/#u
> 
> Heinrich Schuchardt (2):
>   common/spl: Revert fix potential out of buffer access in
>     spl_fit_get_image_name function
>   common/spl: guard against buffer overflow in spl_fit_get_image_name()
> 
>  common/spl/spl_fit.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Before:
U-Boot SPL 2025.07-rc4-00030-g0daf2d0cabef (Jun 22 2025 - 23:27:44 -0700)
DDR version: dc2e84f0.
Trying to boot from SPI
cannot find image node '': -1

OpenSBI v1.6

After:
U-Boot SPL 2025.07-rc4-00032-g562b7d099d46 (Jun 24 2025 - 18:53:15 -0700)
DDR version: dc2e84f0.
Trying to boot from SPI

OpenSBI v1.6

For the series,

Tested-By: E Shattow <e@freeshell.de>
