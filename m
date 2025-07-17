Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E479C83F3B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 14:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF658340A;
	Thu, 17 Jul 2025 16:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C158341C; Thu, 17 Jul 2025 16:59:04 +0200 (CEST)
Received: from mail.duskware.de (mail.duskware.de [91.199.88.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD268833F8
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 16:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@duskware.de
Received: by mail.duskware.de (Postfix, from userid 205)
 id 31BB4A7E41; Thu, 17 Jul 2025 16:58:59 +0200 (CEST)
Date: Thu, 17 Jul 2025 16:58:59 +0200
From: Martin Husemann <martin@NetBSD.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] fs: fat: Prevent possible buffer overflow
Message-ID: <20250717145858.GB20410@mail.duskware.de>
References: <20250717-fsfat-v1-1-4cfb1d1a77ca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-fsfat-v1-1-4cfb1d1a77ca@linaro.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
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

On Thu, Jul 17, 2025 at 03:54:37PM +0100, Andrew Goodbody wrote:
>  
>  	memset(dent, 0, sizeof(*dent));
> -	strcpy(dent->name, dir->itr.name);
> +	strlcpy(dent->name, dir->itr.name, FS_DIRENT_NAME_LEN);

Shouldn't that be strncpy() instead? Using strlcpy() for fixed size
records where strings may not be \0 terminated is quirky.

Martin
