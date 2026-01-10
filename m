Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB39CD277CB
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 07:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06698416E;
	Sat, 10 Jan 2026 08:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F188B841FA; Sat, 10 Jan 2026 08:56:53 +0100 (CET)
Received: from mail.duskware.de (mail.duskware.de
 [IPv6:2a0a:4cc0:c0:3f56::116:136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0C683C39
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 08:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=martin@NetBSD.org
Received: by mail.duskware.de (Postfix) id AAEA4E1FFC1;
 Sat, 10 Jan 2026 08:56:34 +0100 (CET)
Date: Sat, 10 Jan 2026 08:56:33 +0100
From: Martin Husemann <martin@NetBSD.org>
To: Yuri Honegger <yuri.honegger@icloud.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: Placement of FDT in memory
Message-ID: <aWIGMbsetBkL_4c-@big-apple.aprisoft.de>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
 <20260109170958.GE3416603@bill-the-cat>
 <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
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

On Fri, Jan 09, 2026 at 10:13:25PM +0100, Yuri Honegger wrote:
> As for u-boot calling the netbsd kernel a linux kernel: That is
> NetBSDs fault, for some reason it produces images with ?os linux,
> although I don?t know the backstory.

The NetBSD variant did not pass the FDT blob IIRC, so it is mostly
useless nowadays. We switched to marking the images as linux kernel
as there really is no difference for the boot loader.

Martin
