Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62495D232D3
	for <u-boot@archiver.kernel.org>; Sat, 10 Jan 2026 17:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A218183B72;
	Sat, 10 Jan 2026 18:45:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C3D983B8A; Sat, 10 Jan 2026 18:45:54 +0100 (CET)
Received: from mail.duskware.de (mail.duskware.de
 [IPv6:2a0a:4cc0:c0:3f56::116:136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D2183B1E
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 18:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=martin@NetBSD.org
Received: by mail.duskware.de (Postfix) id 3C6E9E1FFD3;
 Sat, 10 Jan 2026 18:45:31 +0100 (CET)
Date: Sat, 10 Jan 2026 18:45:29 +0100
From: Martin Husemann <martin@NetBSD.org>
To: Tom Rini <trini@konsulko.com>
Cc: Martin Husemann <martin@netbsd.org>,
 Yuri Honegger <yuri.honegger@icloud.com>, u-boot@lists.denx.de
Subject: Re: Placement of FDT in memory
Message-ID: <aWKQOW_ajq0DsbYA@big-apple.aprisoft.de>
References: <B157C9A8-9D26-4C06-B2F5-BABDFD7A8BFC@icloud.com>
 <20260109170958.GE3416603@bill-the-cat>
 <89B99CA3-BA46-4755-BAFE-95C1944AAAAF@icloud.com>
 <aWIGMbsetBkL_4c-@big-apple.aprisoft.de>
 <20260110164349.GO3416603@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110164349.GO3416603@bill-the-cat>
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

On Sat, Jan 10, 2026 at 10:43:49AM -0600, Tom Rini wrote:
> I thought it might be something like that. Are there any non-EOL NetBSD
> releases that don't use device tree? If not, we can go and mark the
> legacy option as non-default. Thanks!

I think there are still some ancient arm and mips platforms that have not
been converted to use FDT, though there was a project to fix them recently
(but it is not done).

Martin
