Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6970C83F3C
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10E9833C0;
	Thu, 17 Jul 2025 18:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295F3833EC; Thu, 17 Jul 2025 18:57:55 +0200 (CEST)
Received: from mail.duskware.de (mail.duskware.de [91.199.88.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34A8D8334F
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@duskware.de
Received: by mail.duskware.de (Postfix, from userid 205)
 id E7D52A7E41; Thu, 17 Jul 2025 18:57:51 +0200 (CEST)
Date: Thu, 17 Jul 2025 18:57:50 +0200
From: Martin Husemann <martin@NetBSD.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] fs: fat: Prevent possible buffer overflow
Message-ID: <20250717165749.GE20410@mail.duskware.de>
References: <20250717-fsfat-v1-1-4cfb1d1a77ca@linaro.org>
 <20250717145858.GB20410@mail.duskware.de>
 <1e80ff96-48a5-4a17-85df-59c8459b3083@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e80ff96-48a5-4a17-85df-59c8459b3083@linaro.org>
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

On Thu, Jul 17, 2025 at 04:38:50PM +0100, Andrew Goodbody wrote:
> The original use of strcpy suggests that the string must be \0 terminated. I
> will admit that I do not know the code well, is dir->itr.name guaranteed to
> be a known fixed size?

You are right, the iterator's name pointer always points to a \0 terminated
string, but also always points to one shorter than FS_DIRENT_NAME_LEN.

The on-disk fields are not \0 terminated, but the code extracting them
deals with it properly. If the length would overflow, a NULL instead
of a dir_entry * is returned, so while it is not obvious, AFAICT the
original code is fine.

Martin
