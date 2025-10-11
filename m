Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77055CCD18A
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FECE83A2B;
	Sat, 11 Oct 2025 20:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="NoSC581v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEED83A3B; Sat, 11 Oct 2025 20:19:04 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B479983A26
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 20:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1760206741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UOyRJW0MTU1W4RaT4roU/CTk3s/c+8467X1fsPttJso=;
 b=NoSC581vk2WMZnD+tchx/5CrVPKCH/iNRhqVQTzC4FbstR5+PPRQgnhsn65oGIJ4s1mBCf
 ZtOs3wDTDxsZg1kKA1hsZzf0XYZPYtADeqIYCk7NrdQTMvVCkypuw3Pg8mxMSHHq2vGIA7
 7TKpXpfc+ILvGORN3Nh/imIoh+12NPfbFAJCgW5CnKg/x0bjU6O9ufnP6/EE8HV/oBzUHA
 mPvzQDss/9r8tc93LIXY52EhwLnJ7RbGlesernRCooT2pUdxVRrzeMIa+acikbS57vDBID
 8kbIa6h476PTeq0Krl4Fjb+1qnG+L6QvuBGpIko/dwcM2nNDlF356S4P7nAWOw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Oct 2025 18:18:57 +0000
Message-Id: <DDFP7O76VCD9.1J0ZA8GFU55G2@postmarketos.org>
Subject: Re: [PATCH] arm: meson: add support for EFI capsule updates
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Ferass El Hafidi" <funderscore@postmarketos.org>,
 <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>
Cc: "Tom Rini" <trini@konsulko.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Viacheslav Bocharov" <adeep@lexina.in>,
 "Arseniy Krasnov" <avkrasnov@salutedevices.com>, "Evgeny Bachinin"
 <EABachinin@salutedevices.com>, "Ferass El Hafidi"
 <funderscore@tauchgang.dev>, <~postmarketos/upstreaming@lists.sr.ht>
References: <20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org>
In-Reply-To: <20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org>
X-Migadu-Flow: FLOW_OUT
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

Hello,

Thank you for your feedback, I sent a v2:

https://lore.kernel.org/u-boot-amlogic/20251011-meson-capsule-v2-1-53a8be65=
95ce@postmarketos.org/T/#u


On Tue Oct 7, 2025 at 7:10 PM UTC, Ferass El Hafidi wrote:
> Previously, few Amlogic devices supported EFI capsule updates.
> Generally only the Libre Computer ones with SPI flash supported it,
> thanks to board-specific code.
>
> This commit commonises capsule update support across supported
> Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
> and firmware name is automatically generated at runtime depending on
> which device we are booted from.  Right now this supports flashing to
> the eMMC/SD and SPI flash.
>
> As usual, the capsule UUID is automatically generated.  You can get it
> by enabling CONFIG_CMD_EFIDEBUG and running:
>
> 	=3D> efidebug capsule esrt
> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	ESRT: fw_resource_count=3D1
> 	ESRT: fw_resource_count_max=3D1
> 	ESRT: fw_resource_version=3D1
> 	[entry 0]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	ESRT: fw_class=3D796180D4-AAB2-50F1-B16A-53DFF9CA89B2
> 	ESRT: fw_type=3Dunknown
> 	ESRT: fw_version=3D0
> 	ESRT: lowest_supported_fw_version=3D0
> 	ESRT: capsule_flags=3D0
> 	ESRT: last_attempt_version=3D0
> 	ESRT: last_attempt_status=3Dsuccess
> 	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
