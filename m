Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BC9C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 04:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93FD89119;
	Fri, 26 Apr 2024 06:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714104451;
	bh=lSv1xhuRgCHdfg+veywi/9tMUnaqZC+mQCmHyE5U7FY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFmHh3uCYXV0/dedxvYo1Yo/2MzO5yuejhK5WL20mEfh++8KbFP3dh6sPkK2/l2Ja
	 FwtVxRqiOW0WAvYkFHYQoZAxBRvbVrUk6PM7utCtGu9gsoEn6f6jKiBAtXrZTIkwy7
	 2R+DTqSIxrLphD4x/Hsj98DIGRjBPsmH0mbDBRPFAofDesPwWTL5I0enz3USV+VR3Y
	 n4QCNzyP/OMQQN2Qk6A8GyIAhHDvy6Puu1umFrGZxyV60qrSRE/5SLLgDo1vFsvUk9
	 R/CW3NVE2mskuuUAApAU/7zot98Hmi0e0zUeICJF8+KGGJpoJ8/4OGfqIpnwUa6duo
	 PHXZcPdiK6/wQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8074D87D40;
 Fri, 26 Apr 2024 06:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714104450;
 bh=lSv1xhuRgCHdfg+veywi/9tMUnaqZC+mQCmHyE5U7FY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=geMVWtNJgbmx6MSFW3Y25zLsJsf7Xl7OYBa7igIkoaKIlRjxT0EJSPs+vMRpOBc/W
 E3qPkA9NLZMwmx1Kk0cawylFApMAaebrqvuXeyjgEFq75K5zy05Gp0qH/tuiQMrUCo
 PTfOT/66aA5ueL2vKYJ4mf8ou9udPNszBLcXzr9B+wVLtqQ/fn7xvAIg2y1dTmISpL
 z6YLdvOok284t2nCMfuF4b2LFF8io71SMookSR/JTSBSmkE+zeBOonW7zOn0eJtRJW
 awXSlBBVUqDfmZ5Ve3Dly+zZpV/qKdQH1DSdCj1xcK7HYYm5cAMXDzCKf1zTAiQ3mq
 BDO2RYR9iWHaQ==
Message-ID: <254b0fd2-0085-4894-bcfa-686c456e4e2a@denx.de>
Date: Fri, 26 Apr 2024 06:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mmc: allow use of hardware parittion names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
References: <20240426001419.1210364-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426001419.1210364-1-tharvey@gateworks.com>
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

On 4/26/24 2:14 AM, Tim Harvey wrote:
> eMMC devices have hardware partitions such as user, boot0, and boot1.
> Allow these names to be displayed when reading the mmc PARTITION_CONFIG
> field via 'mmc partconf'. Additionally allow a name to be specified when
> setting the PARTITION_CONFIG.
> 
> Before:
> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x2
> PARTITION_ACCESS: 0x0
> 
> After:
> u-boot=> mmc partconf 2 1 1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x1 (boot0)
> PARTITION_ACCESS: 0x0
> u-boot=> mmc partconf 2 1 boot1 0 && mmc partconf 2
> EXT_CSD[179], PARTITION_CONFIG:
> BOOT_ACK: 0x1
> BOOT_PARTITION_ENABLE: 0x2 (boot1)
> PARTITION_ACCESS: 0x0
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   cmd/mmc.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 2d5430a53079..26692a8e349b 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -14,6 +14,18 @@
>   #include <part.h>
>   #include <sparse_format.h>
>   #include <image-sparse.h>
> +#include <linux/ctype.h>
> +
> +static const char *mmc_partnames[] = {
> +	"user",
> +	"boot0",
> +	"boot1",
> +	"",

Shouldn't these be 'gp' partitions here ?

[...]
