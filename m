Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBC8C369AB
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 00:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C0F809D4;
	Fri, 25 Apr 2025 02:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA57810EB; Fri, 25 Apr 2025 02:23:03 +0200 (CEST)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4175D8082A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 02:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.18.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id CBB5A342FA4;
 Fri, 25 Apr 2025 00:22:53 +0000 (UTC)
Date: Fri, 25 Apr 2025 00:22:49 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Daniel Maslowski <cyrevolt@googlemail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, spacemit@lists.linux.dev
Subject: Re: SpacemiT K1x / Ky X1 DRAM init
Message-ID: <20250425002249-GYA49938@gentoo>
References: <CAJCpOFyMyXZK7Hz7mTOwHRREQEWf-=ghgLXU5RgzTMxQj7MnZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCpOFyMyXZK7Hz7mTOwHRREQEWf-=ghgLXU5RgzTMxQj7MnZQ@mail.gmail.com>
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

Hi Daniel,

On 20:26 Thu 24 Apr     , Daniel Maslowski wrote:
> Hey everyone,
> 
> As discussed in the last community call, I have written a fully open source
Where did the discussion happen?

> implementation of the full DRAM init for the K1x/X1 in Rust, based on the
> vendor U-Boot code. This would be trivial to translate to C. I would be
> happy if someone could pick this up for upstream SPL. Feel free to poke me
> should you have any questions. Thanks! :)
> 
I won't start this if speak for myself, but would glad to see anyone
else push it forward

> https://github.com/orangecms/oreboot/blob/all-the-things-wip/src/mainboard/spacemit/k1x/bt0/src/dram.rs
> 
> I could not find a RISC-V specific mailing list. Please forgive me for
> being email illiterate.
It's more likely vendor (SpacemiT) specific rather than RISC-V generic,
so Ccing spacemit mailing list to see if people interested..

-- 
Yixun Lan (dlan)
