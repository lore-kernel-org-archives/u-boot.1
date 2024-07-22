Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE547C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 04:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D8388001;
	Mon, 22 Jul 2024 06:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721621321;
	bh=Zd1mnrbWUw6mkmiQXDuc6n5yVOm+KjYsXzfGyQnUHgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=PMT+uLzJUmek3EHJm9xpTSPzCiloPxtWNy9HukuiYZOjJ1K3y7CeYzHYcMLQa0LC+
	 j7pZk0P3XW7zjnu8U44PQWyBOgvM8t/XM60FfZg0RbN3ZCJGih0P4sA2DnJLBs3r1N
	 LvDDQnfV7zkgxLjR8j+2e6FxDMRrTYibmPDRsjchaSpEO64QQnDWEvMRc++GWVJZ1v
	 tg63NqeTn4tTAKCoxX5zOA8DCFlx5mfweQznYBnK2I0lafJhDhtb026tzmYKFB4pYV
	 gTeAM3Vmd1RlyX5tK3VkMVpjUVqWGWPvjCqu+4lRJYjZ3qcgpmRjBrg7eG5uVlnutm
	 VrrlWCzPFmVdg==
Received: from [192.168.1.107] (87-97-112-163.pool.digikabel.hu
 [87.97.112.163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9CAB58808B;
 Mon, 22 Jul 2024 06:08:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721621319;
 bh=Zd1mnrbWUw6mkmiQXDuc6n5yVOm+KjYsXzfGyQnUHgg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=rc2j6/e/6m3tDxekD2OxhvL5gL/aVvQ/15Hw3F6c9lGx/AezlGXVwCfuqdljZMwel
 qzJUgRxAB42BFDrYqq0KRH7vIx+ruGKOEzZCwmhoed204t2/uVZ0Z2chedWlHO1Bzs
 rKvzSZNWMUc5nT1qPsovwrrCtcSpOvGY2IjtnlKVwfMNp7Ir+ucMGaOdbrzGVtFtsS
 1DvM2EG61+53nz0/ceKsepZEU4CDeOQ9dV5ih0xvEi+nZEarSSMscD2DcbqZiAX+wF
 DmsbZu9nsYtkGHDpp3yY+rGaV9gDru/TPC1CZXk+7qDdcQp1yRec1SnAPZmiL5xFf5
 ZPtZd9o5LpyIA==
Message-ID: <d7cdfb24-6718-428d-a02d-867bf921a6ca@denx.de>
Date: Mon, 22 Jul 2024 06:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] board: keymile: convert to CONFIG_DM_I2C
Content-Language: en-US
To: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
References: <20240719191656.3323947-1-agust@denx.de>
 <20240719232422.3403700-1-agust@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240719232422.3403700-1-agust@denx.de>
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

Hello Anatolij,

On 20.07.24 01:24, Anatolij Gustschin wrote:
> The conversion to DM_I2C is mandatory, rework to remove
> use of legacy I2C API.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> ---
> 
> Changes in v2:
>   - convert pg_wcom_expu1_update_defconfig and
>     pg_wcom_seli8_update_defconfig files
>   - remove obsolete CONFIG_SYS_I2C_MXC_I2C* in all defconfigs
> 
>   board/keymile/Kconfig                          |  3 ---
>   board/keymile/common/common.c                  | 12 ------------
>   board/keymile/common/common.h                  |  3 +--
>   board/keymile/common/ivm.c                     | 18 ++++++------------
>   .../keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c  |  8 +++++++-
>   configs/pg_wcom_expu1_defconfig                |  8 ++++----
>   configs/pg_wcom_expu1_update_defconfig         |  8 ++++----
>   configs/pg_wcom_seli8_defconfig                |  8 ++++----
>   configs/pg_wcom_seli8_update_defconfig         |  8 ++++----
>   include/configs/km/pg-wcom-ls102xa.h           | 13 -------------
>   10 files changed, 30 insertions(+), 59 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
