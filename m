Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB3C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3D584C43;
	Wed,  1 Jul 2026 19:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="i37wJLdK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB9384C3C; Wed,  1 Jul 2026 19:25:08 +0200 (CEST)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 510C484C19
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1782926706;
 bh=QfUNRZZFgGdtuobRW4NYBfUavciGgAoWI3VwKmvcCf0=;
 h=Date:From:To:Subject:Message-ID:References:Content-Type:
 In-Reply-To:From;
 b=i37wJLdK7G2YNSMQgM/G72Q00VlGjiBRNJoIRKMQqbjv67CnetSQ/iOFXFPMytW8J
 ILNq+A3SG1fDL8mpfvOQSUyP4lIDBlxfMQ16HvkXFJBn0X4vAckfOIFRuS8vSyYDie
 KEuALHceqBN1QM+fnRzVII94b9e+rv63JykM6AQ8=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4gr6N204hwz3sHpd
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 17:25:05 +0000 (UTC)
Received: from tachyon.qsoe.net
 (ipservice-092-208-226-177.092.208.pools.vodafone-ip.de [92.208.226.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4gr6N135Y5z8snG
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 17:25:02 +0000 (UTC)
Received: by tachyon.qsoe.net (Postfix, from userid 516)
 id BE9E52E105F; Wed, 01 Jul 2026 19:25:01 +0200 (CEST)
Date: Wed, 1 Jul 2026 19:25:01 +0200
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Subject: RISC-V (Unmatched): NVidia GK-208 card successfully initialized by
 U-Boot
Message-ID: <akVNbVv1ju7wUo-9@tachyon.qsoe.net>
References: <Zzz483tW7ODsig6u@vodafonemail.de>
 <6A65FCCE-4A7C-4558-9753-66E0563C62E5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6A65FCCE-4A7C-4558-9753-66E0563C62E5@gmx.de>
X-purgate-server: smtpa06
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 935
X-purgate-ID: 155817::1782926705-A6673DC7-D09BB1BA/0/0
X-Mailman-Approved-At: Wed, 01 Jul 2026 19:35:57 +0200
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
Reply-To: yuriz@qsoe.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Heinrich, hi U-Boot RISC-V community,

On Tue, Nov 19, 2024 at 10:03:45PM +0100, Heinrich Schuchardt wrote:

> Hello Yuri,
>
> [...]
>
> Were you able to show output on HDMI?

Yes :-)

(a slightly longer answer: but I could not get the x86 bios_emulator working with my card, despite
all the efforts. So I went a completely different way)

I'm creating a blog series (8 posts) about my findings and about the end result.
Can be seen at: https://r-tty.blogspot.com . Today I will also record a demonstration video.

To all SiFive Unmatched users (and also the users of PolarFire Icicle Kit!), who use the board
with the PCIe video controller: please write me if you're interested. I'll be opening the sources
of my "VideoBIOS" program soon (GPL2-licensed), after I finish some architectural work about QSOE's
video console. The project will be available at: https://gitlab.com/bios-riscv

-- 
Regards,
Yuri
