Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DEFCAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 15:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 266858319C;
	Mon, 29 Sep 2025 17:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVvybTto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB3A8349B; Mon, 29 Sep 2025 16:32:47 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069DD8344E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 16:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=konstantin@linuxfoundation.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CC61562496;
 Mon, 29 Sep 2025 14:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD47C4CEF4;
 Mon, 29 Sep 2025 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1759156362;
 bh=XlyAHEz50zR/6WzYRZzAohn5XmrWORbmEBkidDIlzxI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NVvybTtobbz8Ms4rFJXaqBdUhNcgvr4WJKAkmupc46u4yeFBTT+YJXJg8Onhxj4eR
 z4gVcYuqHwpfIV91qMh1MFfGMLoruaMAu0Rs1Yz/WToGIIirA32E7xYtutRg8ReT5X
 R6aGOZQ7z0v+GHD0SOf3x2fFSe8+bdb6jNmZJhyI=
Date: Mon, 29 Sep 2025 10:32:38 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: Remove redundant test
Message-ID: <20250929-fuzzy-attentive-dogfish-60df26@lemur>
References: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
 <b6d1f1df-eed5-4cbe-8add-31c1e77e3a16@mailbox.org>
 <02ef127e-f789-4cc6-9592-eb4b75f1b0ea@linaro.org>
 <59d4ef95-e030-4508-8e1e-ae37a0df6c29@mailbox.org>
 <cb3ad7f4-6e02-4a59-b763-887ead2c338d@linaro.org>
 <20250929141507.GE6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250929141507.GE6093@bill-the-cat>
X-Mailman-Approved-At: Mon, 29 Sep 2025 17:43:40 +0200
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

On Mon, Sep 29, 2025 at 08:15:07AM -0600, Tom Rini wrote:
> > So it looks like the default command used by b4 for the Cc: section is
> > "scripts/get_maintainer.pl --nogit --nogit-fallback --nogit-chief-penguins
> > --norolestats --nom" which causes recent signers to not be included due to
> > the '--nogit' argument.
> > 
> > I have added the following to my git config file.
> > 
> > [b4]
> > 	send-auto-cc-cmd = scripts/get_maintainer.pl --nogit-fallback
> > --nogit-chief-penguins --norolestats --nom
> > 
> > This will mean that from now on recent signers will be added to the Cc:
> > list. I hope that this is what is expected.
> > 
> > I will resend this patch with the expanded Cc: list.
> 
> A while back someone submitted a .b4.conf (or .b4.config? I forget...)

.b4-config

> patch, but at the time it wasn't setting anything non-standard I
> thought. However, is the above something that can be configured there?
> If so, that would be good to put in a project-wide b4 config file, and
> if it's not it'd be a good feature request for upstream.

Yeah, we try to walk a fine balance between being newbie-friendly but also
allowing power users to tweak things. The decision to add --nogit by default
was because for most subsystems this returns a list of CC's that is way too
huge and actually trips up some MTAs to refuse delivery with "too many
recipients."

The biggest downside of providing settings in the toplevel .b4-config is that
it can't currently be done per-subsystem, so projects like the kernel cannot
carry a .b4-config without it clashing between what different subsystems want
to set as defaults. I've not yet come up with a good way to solve this.

-K
