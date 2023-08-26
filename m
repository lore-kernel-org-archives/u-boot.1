Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C54C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 13:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF9848611C;
	Sat, 26 Aug 2023 15:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="bSJuYxvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4B98634D; Sat, 26 Aug 2023 15:46:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D28847C3
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 15:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693057591; x=1693662391; i=xypron.glpk@gmx.de;
 bh=i0vMMy8tP3Ncw9tERF8+ND/IB2gCf/l9uUeJRWQ5jcw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bSJuYxvRQlXCVLiDRuX7vPYCGdwKwslQLppkW+aOn+B/MKHSqPJz2vJr9t+pFNqpnRteqVi
 gpK7kycYcXnmC0iNep3o58s3V14D505FNqjZG0hqbhMJK6wX3sD9HaP5t8+MJltFsxDG6Twn5
 j7cbP1Q3v1l/m+WMqCHM+dnzNparvjFoyA7h8ACqhmvJsS5Dj9Ggv7AHq/X7KZt/QT2umIqp3
 lv7OlsbGhgHUeNPv2O6EFDvu3eEmcKh6jFu/GaB2/WDtWca4OZ9VTARZuAGZzBv2SU2EOcifu
 aJc5IGAvAY/D0Ht9/E6XzlUHLNABoZhHFiHYopjn7TszBtiU0cOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1pclbz1wXQ-016NhU; Sat, 26
 Aug 2023 15:46:31 +0200
Message-ID: <aa9044e9-62a6-4bf2-a390-eb6d3d5d9bf0@gmx.de>
Date: Sat, 26 Aug 2023 15:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-imx: bootaux: fix building with disabled bootelf
Content-Language: en-US
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: Fabio Estevam <festevam@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 Stefan Agner <stefan.agner@toradex.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@lists.denx.de
References: <20230826132410.378846-1-oleksandr.suvorov@foundries.io>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230826132410.378846-1-oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JEc0F4eVVDBxVUzL5wzN7lkHu4wx3I1bWpnuVAO0cUb31KxUQWJ
 BuigB36yE6+nfAhHZg8VWM9Tv9zbRSYEvGbJjKfSJbFACnXzAdfahUburN3hMo9TEmZgJvq
 EhdB97Luufm/Mzcp76OAzTH+PSSi8OWQ2G0NAzt2CVdhIHSEDNE9+6ROXlGH7jZKJS9mUnP
 X6OTwGqLZLkYPUNRAsbNw==
UI-OutboundReport: notjunk:1;M01:P0:H53GRXWT7G0=;Fn+xBxJ4eVcxT9gLX3xg1BndoNi
 yaJwOcbunQkjEgi1G7uQNqvZ43qDE86w2HDdvgc2iQ2wOyVqhTiprc3mEbG3aVpwFrO3w1bf+
 uDpS37AwW9YHHV2+Y+KnV599oZd2TcLLgM3o1r0qbgvF+gI3ale87ZBeEW6/R23sn8ZQD6q96
 FeNdD7c+JzDtNwMq9LQIsBvpLzO/vHk4P6+q3dwSQytyCHdOdPtKpG8NLTnYwEwxfpykdxqI3
 qdeQFlIXROxPLw5BTN7LeafaQoQk4szwUclVs7ULehn4Ojj7vfQiRAGvhw2wwVjtVUmov95yt
 oBHoZwJciKY9cbGOSItny1HaHh2JmtTQew5V9VXhaM3sCD1u7oT4RrTGDdUO8Vn1eYORy1Z3B
 WEBL8mnoaTTv0ac7KIZpAYiHvTt2IvsWudskM3HPcO3tGVAXP0uk9Hb9ApwKOD+awAjJVGUbN
 4215BO4AZmnK0ibPhj7vXHNR51XXP+QHKFixVIOWKdyxLq7Rqn7JmHDmZcUfjiWuJQbf4Hwtk
 c39fLtcjhTSZwV29Ckm5q/wY3hFQoChYvdYZfUEcs63Z5HR0LTpnJ+dOHm1njuBbhJQ65uoFO
 rJgBSLX474wqEHP/5/vtbdHX7nav6aCx7n7YFX5B5gDh7zHSo+Sp16NARFQQaShrEL3DC33sz
 GTbl7Fw79TiWwi+MlAgTTULAQvZ9bs6lYLlobytl35RfOdfV+AzUGCe+ugtuSfB/0m+MpMcPx
 zUtJ5xQ1VVfmkVA+zHyO478VjLpIh/X7jiuLt7JMeCEPh3OFHW4yGwys1TrQ8rZELc6ifoqOt
 v7pkuxbfARYVjnREHye/UOEcz0rlzw0BV6+J3MVVKdWU180HnRC9CSyGSwDFNlGlDhbiMps8T
 JApgxpusF+uV9KD4LQ5x4vUdF46kcqqyAzcffr+kYk/eOG2tARmz6Q/UbukOs4E9iS4d6nMYl
 BWnEpJDGdwisIv57LaNUO4PSuLY=
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

On 8/26/23 15:24, Oleksandr Suvorov wrote:
> If CMD_ELF disabled and IMX_BOOTAUX enabled, the u-boot building ends
> up with a linking error [1]. Select LIB_ELF for all cases when
> valid_elf_image() is used in the imx_bootaux module.
>
> [1]
> ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
> arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_elf_i=
mage'
>
> Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> ---
>
>   arch/arm/mach-imx/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index d94b5828d0d..cbe62d6b8f9 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -32,6 +32,7 @@ config IMX_RDC
>   config IMX_BOOTAUX
>   	bool "Support boot auxiliary core"
>   	depends on ARCH_MX7 || ARCH_MX6 || ARCH_VF610 || ARCH_IMX8 || ARCH_IM=
X8M
> +	select LIB_ELF if !ARCH_IMX8 || IMX8QXP

For CONFIG_IMX8QXP=3Dy arch/arm/mach-imx/imx8/cpu.c uses valid_elf_image()=
.

Shouldn't the IMX8QXP case be handled in arch/arm/mach-imx/imx8/Kconfig?

config IMX8QXP
	select LIB_ELF

Best regards

Heinrich

>   	help
>   	  bootaux [addr] to boot auxiliary core.
>

