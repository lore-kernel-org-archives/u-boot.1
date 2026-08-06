Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03229C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 14:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5612607C5;
	Thu,  6 Aug 2026 14:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZuu0xidt3Fx; Thu,  6 Aug 2026 14:20:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B620606FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786026035;
	bh=4utYb6BAKx6h0AkheC58WSBJpnmCyyhacZrCWlbqrtA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VO3/ykEI0PNql9ebV0B60exsgH2BLLi7zCcmMQCOdJkUDk5BHTcb6K7XuwpDIWDRI
	 4XaeGXRXiREr/h9mX0odR+QBto2kGbkNnsovmDPhmfF2WnAwi8FBtZQsh1Yt9OQOZF
	 VmztbGnoFr2UiulS3wv/NOh6V0ebUX4bRqxmHoQYskcENzXS+02XZ8FeRrH+U7gS+C
	 OlcQ82ZX+ZKBqMltoqC0mhrLMi2MwiAk1GxOnZvQzzTBOd672DM3FXeAjSu1bmWRu4
	 T/NVB8s/hmdRCP2YUd5yrT+I2EnmMs5wIaS9qNOgvUjrBFqkSRkmwre7B64lsn9o2x
	 tL701GyrcE1ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B620606FF;
	Thu,  6 Aug 2026 14:20:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45563194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B109405A9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUE3J8F9Cr6i for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 14:20:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D45A14054D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D45A14054D
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D45A14054D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786025991; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=I8SewKkwczP4HSbtzzMF7H3v+2K65tv5Wfy0Vqc7dgkQ85Yu9MtC6dphmCI6pcM/XBT/ulyXNWyuVPIYasQ1Fa9qBn1YDUzE0kIqjoO6ncHTg4HV9Uzuaax8IgidwGkeUQWG4N1SbeSNEtWn7IqrWEcd49FNdjEbGOvGBxbE4zA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786025991;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4utYb6BAKx6h0AkheC58WSBJpnmCyyhacZrCWlbqrtA=; 
 b=iMx1Qx6DMcqXxeDb7pQelFQMMTeFVcDtQv2ezsFF+8M6olLUFMwn3BY5ny65FVCEBeb6sP2KDnvljD+pLlTYPwZvYymE6zaMrhCnn0eqtV2f/P7iqtaqbR7ZYlNucqtl6VLT2gE/QsbKDausnQp/ffzHCFAziy3LUjKba2EO/ww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
Received: by mx.zohomail.com with SMTPS id 1786025988841522.8370012505809;
 Thu, 6 Aug 2026 07:19:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 22:19:39 +0800
Message-Id: <DKHXDBYX3IR2.M4Z0EXRW0620@pigmoral.tech>
Cc: "Lukasz Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>, "Hiago De Franco"
 <hfranco@baylibre.com>, "Thomas Bonnefille"
 <thomas.bonnefille@bootlin.com>, "Kongyang Liu"
 <seashell11234455@gmail.com>, "Tim Ouyang" <tim609@andestech.com>, "Leo
 Liang" <leo.liang@sifive.com>, "Guodong Xu" <guodong@riscstar.com>,
 "Andreas Schwab" <schwab@suse.de>, "Junhui Liu" <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v3 3/7] riscv: licheerv_nano: Enable hardware system reset
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Zhuxu Ran" <zhuxu_ran@zohomail.com>, <u-boot@lists.u-boot-project.org>,
 "Yao Zi" <me@ziyao.cc>
X-Mailer: aerc 0.21.0
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
 <20260806-milkv-duo-upstream-dts-v3-3-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-3-917cf70a2337@zohomail.com>
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786025991; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=4utYb6BAKx6h0AkheC58WSBJpnmCyyhacZrCWlbqrtA=;
 b=ennfb0Ky3aIskk4ouPF+raFfBGT7+mwpJC41M/rfCoy852svObeWGZhUw9hi/PfB
 Nmh8K4Y9yT08KTdcIGE22com5a0fgzywAiN+Q7zDukwv9adsG8ilDTd53FclsLOd1Oe
 +zRzsqQ7csGg5gUjupMzu1eznuRPIa6nT7d1Fijw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=ennfb0Ky
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Zhuxu,

On Thu Aug 6, 2026 at 8:13 PM CST, Zhuxu Ran wrote:
> The LicheeRV Nano configuration disables board_init(), so the existing
> CV1800B sysreset driver is never bound. This is an existing board issue
> exposed while validating the upstream SG2002 devicetree conversion.
>
> SG2002 uses the same RTC system reset registers as CV1800B. Enable
> board-specific initialization and bind the driver in board_init(),
> following the approach used by Milk-V Duo.
>
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  board/sophgo/licheerv_nano/board.c     | 9 +++++++++
>  configs/sipeed_licheerv_nano_defconfig | 1 -
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/board/sophgo/licheerv_nano/board.c b/board/sophgo/licheerv_n=
ano/board.c
> index e6099d35dbf..c0685c44662 100644
> --- a/board/sophgo/licheerv_nano/board.c
> +++ b/board/sophgo/licheerv_nano/board.c
> @@ -3,3 +3,12 @@
>   * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
>   */
> =20
> +#include <dm/lists.h>
> +
> +int board_init(void)
> +{
> +	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
> +		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
> +
> +	return 0;
> +}

This looks the same as what Milk-V Duo already does. Since this is an
SoC-level driver that doesn=E2=80=99t change across different boards, could=
 you
please look into extracting it into common code instead?

Also see:

https://lists.u-boot-project.org/pipermail/u-boot/2026-July/625352.html

> diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_lich=
eerv_nano_defconfig
> index 9aa3ede10c5..ab29f327d7a 100644
> --- a/configs/sipeed_licheerv_nano_defconfig
> +++ b/configs/sipeed_licheerv_nano_defconfig
> @@ -17,7 +17,6 @@ CONFIG_SD_BOOT=3Dy
>  CONFIG_BOOTCOMMAND=3D"run distro_bootcmd"
>  CONFIG_SYS_CBSIZE=3D512
>  CONFIG_SYS_PBSIZE=3D544
> -# CONFIG_BOARD_INIT is not set
>  CONFIG_SYS_PROMPT=3D"licheerv_nano# "
>  # CONFIG_CMD_BOOTDEV is not set
>  CONFIG_CMD_MBR=3Dy

--=20
Best regards,
Junhui Liu

