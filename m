Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D16C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 02:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E52782B18;
	Wed, 25 Jun 2025 04:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E388F82C84; Wed, 25 Jun 2025 04:14:29 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D0782977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 04:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.61.206])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B5B2EB220604;
 Wed, 25 Jun 2025 04:14:26 +0200 (CEST)
Message-ID: <3b8d6574-82a4-407c-928e-60aab3c29cdd@freeshell.de>
Date: Tue, 24 Jun 2025 19:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git server issue
To: Etienne Buira <etienne.buira@free.fr>, u-boot@lists.denx.de
References: <aFlkUUwIm2JYKj0Y@Z926fQmE5jqhFMgp6>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <aFlkUUwIm2JYKj0Y@Z926fQmE5jqhFMgp6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Etienne,

On 6/23/25 07:27, Etienne Buira wrote:
> Hi all,
> 
> I try to fetch newer commits from denx.de server, but it keeps failing
> the same way:
> 
> u-boot.git $ git fetch
> remote: Enumerating objects: 81513, done.
> remote: Counting objects: 100% (25013/25013), done.
> remote: Compressing objects: 100% (3154/3154), done.
> error: RPC failed; curl 56 OpenSSL SSL_read: SSL_ERROR_SYSCALL, errno 0
> error: 51980 bytes of body are still expected
> fetch-pack: unexpected disconnect while reading sideband packet
> fatal: early EOF
> fatal: fetch-pack: invalid index-pack output
> 
> Maybe a hint: numbers are constant.
> 
> Can a sysadm have a look at it and report please?
> 
> Regards
> 

This is a common situation with git from many locations, it is dependent
on routing and your specific location in the network.

Also, the common workaround is well-known to start with a shallow fetch
strategy, and then incrementally get additional depth as needed with
later "un-shallow" operation if all history is required.

An example:

https://docs.u-boot.org/en/latest/build/source.html
git clone --depth 1 https://source.denx.de/u-boot/u-boot.git u-boot.git
git -C u-boot.git fetch --depth 2
git -C u-boot.git fetch --depth 3
git -C u-boot.git fetch --depth 4
git -C u-boot.git fetch --depth 5
...
git -C u-boot.git pull --unshallow

Best regards,

- E Shattow
