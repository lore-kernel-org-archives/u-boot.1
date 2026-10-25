Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D69606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pgXElb89;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=MCIICtmD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E71A780D9D;
	Sun, 25 Oct 2026 14:15:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGQd7qkLohAP; Sun, 25 Oct 2026 14:15:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A633B80D92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792937732;
	b=gVBvrFCNp7EfWdp1Mf266ANa/W6hWF3mbOyb64b0djgS5FrFhzm3tNvWJwlcyPlqpHl8
	 IqPaLpWQ9CuUB4+ixxASZ8HH5o/hyE9ZpMktedqrGPAZgtLTA8nibfBGjdpIP87caVY0O
	 XdPqKfPAucz7WDRL3JNQ1Tu0pMlG/4gVbw4d6/u91aPc0o5RB7HsXCqTtDXlo9rQERkU5
	 MlgttyCyeBk/YP3Bk/bxVcGivCwmCnxQ8F0rwHWHaWsuNyrolIwP4SrXe8hmrweDf8zgC
	 IMYvgZT9dgG29N/gOJ4w1PA2WSFcFjGkBC5kHFg/KwEQvLGNKUdaheYMmKGF9VJz0Pg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792937732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-Virus-Scanned:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:References:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pFusJMjswqVfKwHj1/GrBOtkCieq6q2rc1uzpvgdcJI=;
	b=pn4FM0Nxwf1nN1KcXsFwpL1/q6c2tvq9deO3dxmVMoI6oCGw4BkJ1TQ2yuwnUeLklQ+/
	 YQApLCSeq+nvcm0E7LyMGkpwrW15oH9iL0uzpyNTah60qYVu3MveJ76/vNSYHRPpMAtHO
	 41Au6t6YKTt+SMMk5Kp2RcZV4Az6Orc0wg1V69XDFhNBVkzY6eBKD4zeYicig4IZP3lKz
	 SAT0DwO9T7iIYuYH37O2rCh20YtYCjMd7ahPlt5AFxkuG1whp5g231Pw3hD2/Bn1tq+Ew
	 aRjLFP08f8M1JdCFU9dFk5xu9W6cDaAs6m19M9yBRnvfpaOkxJv1ji10VOiiRQ2PBGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792937732;
	bh=pFusJMjswqVfKwHj1/GrBOtkCieq6q2rc1uzpvgdcJI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgXElb8960H/wnr36Z1DgFwTIXLNak7fhAVSKYD3hx6+NmFgbgzcDD8ObNBH/yAGe
	 4YA2A7pnF4De7PnrkW8XQb9V2nKKxJyi+yvsuDChAPcfl0VsanB6ZLKpN9KGFjFg5r
	 pA4Gv/ou3hkTJLCKhLULq5nULjMcNxadNNKKQadug4I2laGFE9jzINE29iwsPCA3Hz
	 XiOqAqLSb0mzYG0aXty6cyW38tnpIx/e3bREeQN/B2Dk5HcuQRDET3kldL/4DJN6IX
	 P4jWfcxU2HubzOUOCdDbzJ1wUqhr1Ja/K+Oe91he3N3qgdfZakRCQIrhKMr2EZ6Xjl
	 /oFGWRiwCH/rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A633B80D92;
	Sun, 25 Oct 2026 14:15:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D17BE380
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 04:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEEEC6060D
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 04:55:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e6mJO0BrzxZ7 for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 04:55:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1CA6460607
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792904124;
 b=f4OluNhDRGPx7+sXybPBePkcW/8+VbRknvpaH1/pmXr+ZXrHUEfG5suDwhBqqz95m/Yr
 22kXSvdECFu04rN/hORVVrqzAUH219/gfz0Ifv/PisLhbzr/2+rd6cD+RC8gQGsK0gAnK
 eqsAKhZPvfBVTVkmFJLeA4//6r4cqTHYWL1LHxQvz513/oxWuu83h8E/qexICXu5dwsOT
 8ybOeXJdZp3z4IcI8h9p39HosfhV6bhJeI3qIuouL2+jyN5luw0X7bsMIFGDWrBQYTRMY
 Fe8WJOg1K7KTwXfr8Ay0mcfk+buZtHFghdkwfN1LNNnazhtFK+FGG/L/xeegoDCJWxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792904124;
 h=X-Greylist:Received-SPF:Received:X-Virus-Scanned:Received:
 DKIM-Signature:Mime-Version:Content-Transfer-Encoding:Content-Type:
 Date:Message-Id:Cc:Subject:From:To:References:In-Reply-To;
 bh=pFusJMjswqVfKwHj1/GrBOtkCieq6q2rc1uzpvgdcJI=;
 b=XKeyfBA5nNFen7aWLE07khjoG3RTlfTX9X4z9kwJkuvluVbfxJoJ/1h74GzN6KYH0vxX
 E25d2dJdjsSqbugdnEj8SwTaRAQecXZbTYcdscQE6bNp2c4OMaZ9W0otIVgG7Ug2EyqkG
 w/JvqD1wJqwOpFmCmo0n+KSjDBScAOTHyLENGFrppSp1kmb0w/X0Iz6axrjZjyvIkshdk
 TWZwXiz3iTFo7FO7LFPWcWFoQpOLFHXxm9c5Pwemv8Fe3WNO5/1XtQ3QU1LswWNkeTv+J
 zfNo9TtP45NcKVU6Dx2NduVK8I/ChPvhwAhoDnrAvCJHfWYulBBf/4XXr/v6EjYZjFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=disroot.org;
 dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256
 header.s=mail header.b=MCIICtmD; 
 arc=none smtp.remote-ip=178.21.23.139
X-Greylist: delayed 509 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 25 Oct 2026 04:55:23 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256
 header.s=mail header.b=MCIICtmD
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.21.23.139;
 helo=layka.disroot.org; envelope-from=kauschluss@disroot.org;
 receiver=<UNKNOWN> 
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CA6460607
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 04:55:22 +0000 (UTC)
Received: from mail01.layka.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 81E0780B35;
 Sun, 25 Oct 2026 05:46:50 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jl2QZ9qt_pMY; Sun, 25 Oct 2026 05:46:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1792903609; bh=RqWdCkcf6PsMhDwnEKNQrGF9kdkzJH8ICGvWUgrdGCY=;
 h=Date:Cc:Subject:From:To:References:In-Reply-To;
 b=MCIICtmDnSKRaYcZNWilOsXCGn13cGL+TK/ffijRXjjK3fZI+ENN1fhk3xlA0YrJZ
 1MBptYXxfqAkDAwI2fcuWbBQtj0mUyoxCN9Gl6LLwffvvPJPuqL/aQCHPQXwAToyPy
 4MaddI9IXNIis1IvC2LJf3QPPsA/htjkjSUtugqx+Xq9x4dE8uKJCK/+6wV5h1mkVz
 CZY2Fvl/m8+hBtSsFHKM9fbVjKg8d7SBW/UNLFr9W02vhFe+WsTv3Dugs8xRIkNE/N
 N3ZEHIRp1ZB1i3sF9svi3HBu7VOH+Q9VbS2NXvSo1OTIKeIaAqUPaO9E/qJQA5WyhX
 iAwf9kP/3W7WA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Oct 2026 10:16:43 +0530
Message-Id: <DMDNA8TB98G2.1PF8QD3X90SVI@disroot.org>
Cc: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Alexey Klimov" <alexey.klimov@linaro.org>,
 "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Kaustabh Chakraborty"
 <kauschluss@disroot.org>, "Minkyu Kang" <mk7.kang@samsung.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH] lmb: Enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9
From: "Kaustabh Chakraborty" <kauschluss@disroot.org>
To: "Sam Protsenko" <semen.protsenko@linaro.org>, "Tom Rini"
 <trini@konsulko.com>
References: <20261018043128.26916-1-semen.protsenko@linaro.org>
In-Reply-To: <20261018043128.26916-1-semen.protsenko@linaro.org>
X-Mailman-Approved-At: Sun, 25 Oct 2026 14:15:31 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-17 23:31 -05:00, Sam Protsenko wrote:
> Since commit a3075db94d49 ("lmb: Reinstate access to memory above
> ram_top") secondary CPUs cannot be brought online on the E850-96 board
> in the Linux kernel:
>
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to come online
>     CPU1: failed in unknown state : 0x0
>     CPU2: failed to come online
>     CPU2: failed in unknown state : 0x0
>     ...
>
> This is happening because EL3_MON (the Secure Monitor firmware, which
> also implements PSCI) cannot handle 36-bit addresses in its CPU_ON PSCI
> function implementation. The E850-96 board has two 2 GiB RAM banks: the
> first one is mapped at 0x8000_0000, and the second one at 0x8_8000_0000.
> The commit mentioned above changed the LMB behavior (in U-Boot) in a way
> that the memory from the second RAM bank (which is mapped at 36-bit
> addresses) is not reserved anymore. The change in 'bdinfo' output:
>
>     - reserved[4]    [0x8_8000_0000 - 0x8_ffff_ffff], 0x8000_0000 bytes
>     + reserved[3]    [0x8_ffff_3000 - 0x8_ffff_ffff], 0xd000 bytes
>
> That in turn leads to the Linux kernel image being placed in the second
> RAM bank with 36-bit addresses. The corresponding change in /proc/iomem:
>
>     -   f480_0000 -   f67e_ffff : Kernel code
>     + 8_fa80_0000 - 8_fc7e_ffff : Kernel code
>     -   f6b6_0000 -   f71a_ffff : Kernel data
>     + 8_fcb6_0000 - 8_fd1a_ffff : Kernel data
>
> As evident from the Exynos850 device tree, it uses "psci" as a CPU
> enable method. That means the kernel relies on PSCI firmware (which is
> implemented as a part of EL3_MON firmware in case of Exynos850 SoC) to
> bring up secondary CPU cores. So when bringing up secondary CPUs the
> kernel makes an SMC call (for each secondary CPU) to execute CPU_ON PSCI
> function (see PSCI spec [1]). The kernel passes an "entry point address"
> to that SMC call, which is the address of the secondary_entry() function
> in the kernel, which should be executed when PSCI returns to the kernel
> from the SMC call:
>
>     static int cpu_psci_cpu_boot(unsigned int cpu)
>     {
>         phys_addr_t pa_secondary_entry =3D __pa_symbol(secondary_entry);
>         int err =3D psci_ops.cpu_on(cpu_logical_map(cpu),
>                                   pa_secondary_entry);
>         ...
>
> The pa_secondary_entry is a 64-bit variable, which is perfectly fine
> according to the PSCI spec. Unfortunately, in case when that address is
> actually bigger than 32-bit value, the EL3_MON firmware doesn't execute
> the function at that address -- that's the reason the secondary CPUs
> don't come up. And as discussed above, the kernel image is now located
> at a 36-bit address, which means the secondary_entry() function is at a
> 36-bit address too:
>
>     - secondary_entry() address:   f67d_f5a8  // 32-bit address
>     + secondary_entry() address: 8_fc7d_f5a8  // 36-bit address
>
> It seems like a bug in the EL3_MON firmware, e.g. it might truncate the
> address to 32-bit by using a u32 variable (instead of u64) to store it
> internally. So the right way to fix this issue would be to fix the
> EL3_MON, but unfortunately it's closed source. So instead just enable
> LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9 to limit the available
> memory to the 32-bit boundary.
>
> Although this platform could benefit from having all memory available in
> U-Boot (e.g. for transferring big images over TFTP), and it looks like
> there are no hardware limitations on this platform too (DMA has 36-bit
> support, etc.), limiting the available memory in U-Boot is still the
> easiest way to workaround the EL3_MON problem, and 2 GiB is enough for
> all use cases in U-Boot currently. And of course all 4 GiB of RAM is
> available to use in Linux in any case, so it's not a bad tradeoff, and
> in fact it just brings back the previous behavior (before the "Reinstate
> access ..." patch).
>
> Enabling LMB_LIMIT_DMA_BELOW_RAM_TOP for the whole ARCH_EXYNOS9 family
> also seems justified, as it's likely that all modern ARM64 Exynos chips
> may share similar EL3_MON software, and thus possibly the same PSCI bug.
> For example, a similar issue was mentioned in exynos-mobile related
> patch [2], stating that after "Reinstate access ..." patch only CPU0 is
> able to come online on some variants of the Samsung Galaxy J6 (based on
> Exynos7870 SoC).
>
> This was tested on the E850-96 board:
>
>   1. Using 'bootefi' to boot the Linux kernel image
>      - before this patch: the issue is reproducible
>      - with this patch applied: the issue is not reproducible
>   2. Using 'booti' to boot the Linux kernel image from 0x8_8000_0000
>      - before this patch: the issue is reproducible
>      - with this patch applied: the image can't be loaded there anymore
>        ("Reading file would overwrite reserved memory"), as the second
>        RAM bank is reserved in LMB again
>   3. Using 'booti' to boot the Linux kernel image from 0x8000_0000
>      - the issue is not reproducible
>
> [1] https://support.arm.com/documentation/den0022/fb/
> [2] https://lore.kernel.org/u-boot/20260614-j6lte-lmb-v2-1-6046b54db536@d=
isroot.org/
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Acked-by: Kaustabh Chakraborty <kauschluss@disroot.org>

This is also an issue in Exynos 7870 platforms, so ARCH_EXYNOS7 also
needs to be added.

I did send a patch to fix this using some hacks, but this seems to be
the correct approach as various other platforms have also opted for it.
