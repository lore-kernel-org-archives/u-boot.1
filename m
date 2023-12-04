Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609F1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B172A87499;
	Mon,  4 Dec 2023 11:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B38DA87547; Mon,  4 Dec 2023 11:59:36 +0100 (CET)
Received: from mail.duskware.de (mail.duskware.de [91.199.88.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756FF870B7
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=NetBSD.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin@duskware.de
Received: by mail.duskware.de (Postfix, from userid 205)
 id 80CC7A801B; Mon,  4 Dec 2023 11:59:33 +0100 (CET)
Date: Mon, 4 Dec 2023 11:59:33 +0100
From: Martin Husemann <martin@NetBSD.org>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 trini@konsulko.com, marek.vasut+renesas@mailbox.org, sean.anderson@seco.com
Subject: Re: [PATCH 01/18] bootm: netbds: Drop passing of arguments
Message-ID: <20231204105933.GC22450@mail.duskware.de>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231204002642.895926-2-sjg@chromium.org>
 <87edg2b5vy.fsf@bloch.sibelius.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edg2b5vy.fsf@bloch.sibelius.xs4all.nl>
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

On Mon, Dec 04, 2023 at 11:48:17AM +0100, Mark Kettenis wrote:
> That said, I'm not sure to what extent the bootm command is used to
> boot NetBSD these days.  So this may not really matter.

It is used on most 32bit ARM platforms.

Martin
