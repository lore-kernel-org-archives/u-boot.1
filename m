Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9EAC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 14:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FF080548;
	Mon, 24 Mar 2025 15:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YsIO+xr7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mzvS8G7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3AB0805C3; Mon, 24 Mar 2025 15:11:15 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6D580107
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZLw2R1nk7z9t0n;
 Mon, 24 Mar 2025 15:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742825471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gvc5ZCvtlE0as0pWaKSPAh4j2SIZUB7++DB+pykn3w8=;
 b=YsIO+xr7leGywzPnJ96D3hE+dXewNh0/VMFSOrobUUs7D1+/OT6npNTpGcibMOTEl9BqnD
 Sxoh+LxIp3qJDHrLf+08LeqclTn2svT6/v9CniZ2taYMFhee/OMoPLPt5N5FbhMjmsnXEy
 g5cLBX5/kLCIvLEY/uxZ1nVl0yqRGGb5fnhqiA25T3xjB8Lm+32di1Bt+vuC5RG7HmEstJ
 KXz18HZaLIRzhXVNW9niEwh9Zbk8Sl3w2QdVA5xxAzqncS7e3Gt65LloHx6MsSu+u+TO/0
 JF43zru65n5IXiCAKgxDn4nvxhL6RDlvFhczHZrV4WaQSmbf4TuJjPZ52nD24g==
Message-ID: <b4044271-2502-4b78-a0df-3ab164e2d196@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742825469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gvc5ZCvtlE0as0pWaKSPAh4j2SIZUB7++DB+pykn3w8=;
 b=mzvS8G7sqViO0tNPI67i/E4ww76zRDCm0Msd5j5d85zDnq4oTgzgN96MDOVOw/B7KmW+kD
 Gr+wvI4asp1cTvBBMQA69xVpoVK5u2TdAZflA7rFK71GED30WXlOlPsditvadvASEcmZHO
 yIUNRMOsAU/sJlqAPHB3S3gsFWcR0VlHKEhozFHRiaNOs3qGOEcrRyJFNcpkQ9wXw2OjDB
 5m8KcUnEVz/95n/kVfNP77tE+5FTdoLmkk9jlgIybUmUTterE77IO8yX81wnyWELmHQXzq
 6jpzqPRcaCdzqpyhHs/yEUzxcJHMMwCrhsjiaB+vnW7wcyfvpR9UzAhN4O3dHg==
Date: Mon, 24 Mar 2025 15:11:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: mmc_boot: support sandisk and micron emmc
 boot/rpmb partition resizing
To: ziniu.wang_1@nxp.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com
Cc: pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 tharvey@gateworks.com, jonas@kwiboo.se, sjg@chromium.org,
 u-boot@lists.denx.de
References: <20250317084649.1059257-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250317084649.1059257-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: j5stom8kum6fte6szk1w55af1acdo98b
X-MBO-RS-ID: 3ef38a1c82e24455293
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

On 3/17/25 9:46 AM, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Current mmc 

MMC

> bootpart-resize cmd

command

> only support samsung emmc boot/rpmb

Samsung eMMC BOOT/RPMB hardware

> partition resizing. Add sandisk and micron emmc boot/rpmb

Sandisk and Micron eMMC BOOT/RPMB hardware

Please fix capital letters and upper case abbreviations globally.

> partition
> resizing support. The commands and parameters for resizing partitions
> are different for each manufacturer. Select the corresponding function
> according to cid.

[...]

> +/*
> + * This function changes the size of boot partition and the size of rpmb
> + * partition present on EMMC devices.

eMMC

> + * Input Parameters:
> + * struct *mmc: pointer for the mmc device strcuture
> + * bootsize: size of boot partition
> + * rpmbsize: size of rpmb partition
> + *
> + * Returns 0 on success.
> + */
> +
Thanks !
