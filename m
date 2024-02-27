Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474F8C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 15:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBC887FE3;
	Tue, 27 Feb 2024 16:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tqANEbU+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QuohI9Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E5087FF5; Tue, 27 Feb 2024 16:57:09 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A970887FDD
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 16:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Tkhv73yR6z9spN;
 Tue, 27 Feb 2024 16:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5RUWuj9hw5fMPtLJ1jqnrIMk9aB/sLvrfsii+G5Ock=;
 b=tqANEbU+6l62PxPzxxhwJKkqUBMN26alaivHqOivplH4jw0yRdhzuj16VT1mYSH/mheWo4
 ZeAn8s/UocdkkImsvLDG9xxOTAIi6dyb5OLSWl+z3990SPx0YQfeMXSxFcN4JSi+idclXx
 EB21c197EMaaK+tNVUAS3HWJLFSWCraXyrKr5JJl0ko92JSlRzmZCUcVy4y2FFpJYNhCB+
 uMRNOiX8p80uHoFPGmGOJ3p2KYFBX36pZJbncGebP7QosZlQBflM3Y7Xh7F3D1g6jetDeN
 9yPg0zVECf7zsUzzPK34bZ43sSPrECc+GmISj7vydpVu2wHnAZo5SXbrJGXfOw==
Message-ID: <782925c7-5d52-485c-811d-b316ce7881a0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709049425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5RUWuj9hw5fMPtLJ1jqnrIMk9aB/sLvrfsii+G5Ock=;
 b=QuohI9MjMtPeq3ScEi1K9MLZpLl6KefHtiWMTRIZS69DszX064agiiTI46fVCry8A97QDs
 zy650gIcIt19JU64s6oPM1/iMt5h9LZ7jFjuc3CYmekg7LPlg8/XLlPhWx1xHAViXkpT09
 R30Re/IAgLmNC+aLle8IKlcq1DCPmYTaZ3+MVuMxmN2UE1tWH1yt90JntlydgpRT8WHTN5
 idrY12Rn3DJcFFHvetZ/Ll1s0ojCcjk6koqljlGs4yQZBZ5QpBkUJJ6UfVc5r9GNQDN35E
 9qC0BzbEPbuTRmQ6f+O/NdgbsuGjj8ohFLH+ymXnO4hH00u63LeoHiAbPxHMiw==
Date: Tue, 27 Feb 2024 16:57:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/7] pmic: Add Renesas RAA215300 PMIC driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
 <20240226150536.1690-5-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240226150536.1690-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nxn1keeeb4yk7tyuiz85macaq3ryfoc4
X-MBO-RS-ID: a1e478d5459a4760675
X-Rspamd-Queue-Id: 4Tkhv73yR6z9spN
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

On 2/26/24 4:05 PM, Paul Barker wrote:
> The RZ/G2L SMARC module is powered via a Renesas RAA215300 PMIC which
> provides several voltage converters, a real time clock (RTC) and reset
> control. A basic driver is implemented for this device so that we can
> read, write and dump the PMIC registers.
> 
> The raa215300_bind() function is added as a stub, binding of the
> sysreset driver will be added in a later patch.
> 
> Additional features of this PMIC (such as reset control) may be
> supported by future patches.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   configs/renesas_rzg2l_smarc_defconfig |  3 ++
>   drivers/power/pmic/Kconfig            |  9 ++++++
>   drivers/power/pmic/Makefile           |  1 +
>   drivers/power/pmic/raa215300.c        | 41 +++++++++++++++++++++++++++
>   4 files changed, 54 insertions(+)
>   create mode 100644 drivers/power/pmic/raa215300.c
> 
> diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
> index ad46297c6619..2cab79329db4 100644
> --- a/configs/renesas_rzg2l_smarc_defconfig
> +++ b/configs/renesas_rzg2l_smarc_defconfig
> @@ -27,6 +27,7 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PART=y
> +CONFIG_CMD_PMIC=y
>   CONFIG_CMD_EXT2=y
>   CONFIG_CMD_EXT4=y
>   CONFIG_CMD_EXT4_WRITE=y
> @@ -49,6 +50,8 @@ CONFIG_DM_I2C=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_MMC_UHS_SUPPORT=y
>   CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RAA215300=y
>   CONFIG_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_DM_REGULATOR_GPIO=y

Would it be possible to split the enablement (config change) from the 
driver in two separate patches ?
