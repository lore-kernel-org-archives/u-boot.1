Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E9C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 16:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A542B889B0;
	Tue, 30 Apr 2024 18:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A90889BC; Tue, 30 Apr 2024 18:02:34 +0200 (CEST)
Received: from tianjin2.rivoreo.one (unknown [60.25.139.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720B6880AD
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 18:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=rivoreo.one
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=whr@rivoreo.one
Received: from [10.1.105.1] (localhost [127.0.0.1])
 by tianjin2.rivoreo.one (Postfix) with ESMTP id 70844722A0
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 00:02:20 +0800 (CST)
Received: from 10.1.107.31 (SquirrelMail authenticated user whr)
 by _ with HTTP; Wed, 1 May 2024 00:02:20 +0800
Message-ID: <d5c953629254395ab30173cadb5991c0.squirrel@_>
In-Reply-To: <51ddf37de37df8afe45d683983b519f9.squirrel@_>
References: <51ddf37de37df8afe45d683983b519f9.squirrel@_>
Date: Wed, 1 May 2024 00:02:20 +0800
Subject: Re: [PATCH] zfs: recognize zpools formatted with features support as
 used in OpenZFS
From: "WHR" <whr@rivoreo.one>
To: u-boot@lists.denx.de
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
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

> Currently no features are implemented, only the zpool version 5000 that
> indicating the features support, is recognized. Since it is possible for
> OpenZFS to create a pool with features support enabled, but without
> enabling any actual feature, this change enables U-Boot to read such
> pools.
>
> Signed-off-by: WHR <msl0000023508@gmail.com>
>
>
>

This commit is missing changed file include/zfs/zfs.h, has been replaced
by https://lists.denx.de/pipermail/u-boot/2024-April/552434.html, please
drop.

