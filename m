Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE60D6DDED
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 11:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5CE88FFC;
	Fri, 15 Nov 2024 12:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DAC8933E; Fri, 15 Nov 2024 12:19:51 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E9B88C10
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 12:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id 844C568C7B; Fri, 15 Nov 2024 12:19:47 +0100 (CET)
Received: from blackhole.lan (p5b0d8c0f.dip0.t-ipconnect.de [91.13.140.15])
 by verein.lst.de (Postfix) with ESMTPSA id CFA9167373
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 12:19:44 +0100 (CET)
Date: Fri, 15 Nov 2024 12:19:36 +0100
From: Torsten Duwe <duwe@lst.de>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] tools: use cryptographically safe RNG
Message-ID: <20241115121936.48e482f8@blackhole.lan>
In-Reply-To: <CAM=mAOkaHf-TZ1Xw0W6kcYV7G+9wCJk14svaiCtdt6V1KpVQ4A@mail.gmail.com>
References: <20241102163259.305802-1-heinrich.schuchardt@canonical.com>
 <20241114172654.GA4059396@bill-the-cat>
 <CAM=mAOmFn0tytht3oK1F59=-nGxuLJmtSr2HpJDyTf=LWKYQOg@mail.gmail.com>
 <20241114173927.GJ3600562@bill-the-cat>
 <87plmx1h4r.fsf@bloch.sibelius.xs4all.nl>
 <87ttc9m0cm.fsf@prevas.dk>
 <CAM=mAOkaHf-TZ1Xw0W6kcYV7G+9wCJk14svaiCtdt6V1KpVQ4A@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 15 Nov 2024 09:34:54 +0100
Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> Rasmus Villemoes <ravi@prevas.dk> schrieb am Fr., 15. Nov. 2024,
> 08:18:
[...]
> > Or use getrandom(), which according to the man page has been

+1

> > exposed via glibc since glibc 2.25. Or just read from /dev/urandom
> > which should work everywhere.
> 
> /dev/urandom is not available in containers.
> getrandom is not available in OpenBSD.

https://man.openbsd.org/OpenBSD-6.0/getentropy

Yes, "getentropy() is not intended for regular code; [...]", but when
in doubt and there is no one size that fits all, there's nothing wrong
with a good old #ifdef or a compat wrapper IMHO.

	Torsten
