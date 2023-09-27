Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FE6E7F153
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 03:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0746786BF5;
	Wed, 27 Sep 2023 05:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sx/in7Rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151BE86CAB; Wed, 27 Sep 2023 05:10:44 +0200 (CEST)
Received: from mail-m12773.qiye.163.com (mail-m12773.qiye.163.com
 [115.236.127.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DF286BD7
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 05:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Sx/in7RsXV0oJGlZVBfTdxo0DlArpPkzCiRSecWDP54eiK9+0WmxIyosjmWo8d4XYcVf3ajJTFOTwZMXUD/OqqwBumJ99cSmKWbz8cr2PpkVk8YJyggMeSrf9d2WfP046EUocWOg4BzRu8X/caUG02B+VA5rq0Ci0G1o4kBJFKU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=6Cc4ePXkD60Uu5vYJUn37p57wfck7c+f4TyVLfApnYg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 492A6400301;
 Wed, 27 Sep 2023 11:10:34 +0800 (CST)
Message-ID: <bf49eebf-6a7e-555b-cf84-d96d9df8a32e@rock-chips.com>
Date: Wed, 27 Sep 2023 11:10:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] configs: rockchip: add DOS_PARTITION to RK3308 boards
 defconfig
Content-Language: en-US
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de,
 Akash Gajjar <gajjar04akash@gmail.com>, Andy Yan <andy.yan@rock-chips.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
References: <20230902171507.351774-1-massimo.pegorer+oss@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230902171507.351774-1-massimo.pegorer+oss@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0xMH1ZPGElCQkofGEsdGklVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8ad49dede82eb3kusn492a6400301
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6IQw5Czw*OjYOFCNMAh4h
 FhVPCz5VSlVKTUJOTENPSUhOSkhJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITk9LNwY+
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

Hi Massimo,

     This patch is fine to me, but you can merge these two patch into 
one, because they

are all rk3308 boards.

     And if you have more than one patch, it'd better to use 
--in-reply-to for follow up patches

so that the mail system know this is a patch set and grab them together.


Thanks,

- Kever

On 2023/9/3 01:15, Massimo Pegorer wrote:
> Without DOS_PARTITION support U-Boot is not able to boot an OS stored
> into an SD card with MBR partitions table. This is still a quite common
> case, so add DOS_PARTITION (only for U-Boot proper build) to Rockchip
> RK3308 EVB and Firefly roc-rk3308-cc board: they are the only RK boards
> missing of DOS_PARTITION.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   configs/evb-rk3308_defconfig    | 2 +-
>   configs/roc-cc-rk3308_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
> index a13a809c1e..c6472a2c9c 100644
> --- a/configs/evb-rk3308_defconfig
> +++ b/configs/evb-rk3308_defconfig
> @@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_ITEST is not set
>   # CONFIG_CMD_SETEXPR is not set
>   # CONFIG_CMD_SLEEP is not set
> -# CONFIG_DOS_PARTITION is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_ISO_PARTITION is not set
>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>   CONFIG_SPL_OF_CONTROL=y
> diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
> index 9a789b212f..ca92b8f744 100644
> --- a/configs/roc-cc-rk3308_defconfig
> +++ b/configs/roc-cc-rk3308_defconfig
> @@ -47,7 +47,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   # CONFIG_CMD_ITEST is not set
>   # CONFIG_CMD_SETEXPR is not set
>   # CONFIG_CMD_SLEEP is not set
> -# CONFIG_DOS_PARTITION is not set
> +# CONFIG_SPL_DOS_PARTITION is not set
>   # CONFIG_ISO_PARTITION is not set
>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>   CONFIG_SPL_OF_CONTROL=y
