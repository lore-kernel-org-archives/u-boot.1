Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176C3CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD8184970;
	Tue, 16 Jun 2026 20:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="jNh02d00";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="CCHb95n0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C73848BA; Tue, 16 Jun 2026 20:48:09 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
 [IPv6:2a0a:51c0:0:237:300::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DB184895
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 20:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian@breakpoint.cc
Date: Tue, 16 Jun 2026 20:48:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
 s=2025; t=1781635687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lo/9xPpxyAAVIWkYtBKt80yx3GPQGeS/yBjMaruWDII=;
 b=jNh02d00aEZ/5UgVIic9fH6deoVRXs7TSOc4MlZgSKUkwaIiFcMI4HhaJ3AYosYBNXX3S+
 S2tuRK14o9aPi0unqL48fxiMSzRNAvkHiItVMVE5QLfwUiEBJTw8EUFHc54Tng05THbOTZ
 EgixIkyYkbD6IR9qXYxuVFIZl/5pPO5xCdbBhlWNGRj+vyuLYUJ37yl+wbf9XmYEUdWNxR
 B8b+GO5AuoegTiRlReK8TbxOvLrqOf3hP0wfJCVWL7FeIsWNQ5tmniDdgUKg8AQHOV8GHR
 ul471q8vFmjy7UsCe8nn28CePaf038BZ6urd8Jg8zGpc9Vg96I51vB93VLz/Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
 s=2025e; t=1781635687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lo/9xPpxyAAVIWkYtBKt80yx3GPQGeS/yBjMaruWDII=;
 b=CCHb95n0EZ4nPP2AucBQv1MOwAoNjKIzh6+6ugPXqWoPP6MrU4zUiAHpHiWVrUXsjAv2ZR
 ZnNVLvXX9TxweGDA==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: fix building with OpenSSL 4.0
Message-ID: <20260616184805.OM9ccIkV@breakpoint.cc>
References: <20260615160718.94366-1-heinrich.schuchardt@canonical.com>
 <20260615194632.ACNju1Qi@breakpoint.cc>
 <b25761d2-594a-429e-a3cf-3f0cca996f1d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b25761d2-594a-429e-a3cf-3f0cca996f1d@cherry.de>
X-Mailman-Approved-At: Tue, 16 Jun 2026 20:53:56 +0200
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

On 2026-06-16 10:35:19 [+0200], Quentin Schulz wrote:
> Hi Sebastian,
Hi Quentin,

> > removing it since the "provider interface" is available since the 3.0
> 
> We could migrate for OpenSSL 3+ to the provider interface while maintaining
> support for OpenSSL engines (via the org.openssl.engine: prefix). OpenSSL
> engines are supported in OpenSSL 3.x. As a matter of fact, **I** am using an
> OpenSSL engine on OpenSSL 3.

Sure. And this is gone with OpenSSL 4.0. Debian Forky wise I am aiming
at OpenSSL 4.0 so the engine variant becomes less of an option. Should
you aim at keeping the functionality provided by the engine you should
poke its upstream to migrate/ provide an provider alternative.

> OpenSSL 1.x can still receive updates provided you pay support for it.
> Bullseye still ships OpenSSL 1 (and is in its LTS phase for a few more
> months). According to pkgs.org, RockyLinux/AlmaLinux 8 and Slackware 15 are
> also on that ancient OpenSSL. The former are supported for three more years
> according to endoflife.date. So I think it may be a bit premature to remove
> support for OpenSSL engines via the engine API.

Sure. If there are people using stone age OpenSSL and brand new u-boot,
sure why not.

> > series. And since 1.1 receives no FOSS support it might not hurt anyone
> > to drop it and keep only the provider interface around.
> > If the engine support was introduced due to $HW then there should be
> > matching provider support.
> > 
> 
> Not necessarily. You can have custom engines and not have migrated to custom
> providers. The interface is entirely different and the migration is not
> straightforward as far as I've been told (a colleague of mine did the
> migration for our custom engine).

Sure, you have the option to not migrate. But if you end up with OpenSSL
4.0 you have no engine support.

> Cheers,
> Quentin

Sebastian
