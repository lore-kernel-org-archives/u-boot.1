Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5C2C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 17:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4E4482E2D;
	Wed, 25 Jun 2025 19:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C8482D21; Wed, 25 Jun 2025 16:07:18 +0200 (CEST)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBE0803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.buira@free.fr
Received: from localhost (unknown [82.64.135.138])
 by smtp2-g21.free.fr (Postfix) with ESMTP id 32FDF2003A4;
 Wed, 25 Jun 2025 16:07:13 +0200 (CEST)
Received: by localhost (Postfix, from userid 1502)
 id 1B5B71519E; Wed, 25 Jun 2025 14:07:12 +0000 (GMT)
Date: Wed, 25 Jun 2025 14:07:12 +0000
From: Etienne Buira <etienne.buira@free.fr>
To: E Shattow <e@freeshell.de>
Cc: Etienne Buira <etienne.buira@free.fr>, u-boot@lists.denx.de
Subject: Re: Git server issue
Message-ID: <aFwCkKElKVUruDAt@Z926fQmE5jqhFMgp6>
References: <aFlkUUwIm2JYKj0Y@Z926fQmE5jqhFMgp6>
 <3b8d6574-82a4-407c-928e-60aab3c29cdd@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8d6574-82a4-407c-928e-60aab3c29cdd@freeshell.de>
X-Mailman-Approved-At: Wed, 25 Jun 2025 19:05:52 +0200
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

On Tue, Jun 24, 2025 at 07:14:24PM -0700, E Shattow wrote:
> Hello Etienne,
> 
> On 6/23/25 07:27, Etienne Buira wrote:
> > Hi all,
> > 
> > I try to fetch newer commits from denx.de server, but it keeps failing
> > the same way:
> > 
> > u-boot.git $ git fetch
> > remote: Enumerating objects: 81513, done.
> > remote: Counting objects: 100% (25013/25013), done.
> > remote: Compressing objects: 100% (3154/3154), done.
> > error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0
> > error: 51980 bytes of body are still expected
> > fetch-pack: unexpected disconnect while reading sideband packet
> > fatal: early EOF
> > fatal: fetch-pack: invalid index-pack output
> > 
> > Maybe a hint: numbers are constant.
> > 
> > Can a sysadm have a look at it and report please?
> > 
> > Regards
> > 
> 
> This is a common situation with git from many locations, it is dependent
> on routing and your specific location in the network.
> 
> Also, the common workaround is well-known to start with a shallow fetch
> strategy, and then incrementally get additional depth as needed with
> later "un-shallow" operation if all history is required.

Hi,

Thank you for the tip. Maybe thanks to the sysadmin too, as a fetch
proceeded correctly today.

Regards.

> 
> An example:
> 
> https://docs.u-boot.org/en/latest/build/source.html
> git clone --depth 1 https://source.denx.de/u-boot/u-boot.git u-boot.git
> git -C u-boot.git fetch --depth 2
> git -C u-boot.git fetch --depth 3
> git -C u-boot.git fetch --depth 4
> git -C u-boot.git fetch --depth 5
> ...
> git -C u-boot.git pull --unshallow
> 
> Best regards,
> 
> - E Shattow
