Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AB606A31B
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KBxrAfQ1;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=K67nhkyl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAFC0605FD;
	Mon, 19 Oct 2026 17:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgHHeQuN5S0y; Mon, 19 Oct 2026 17:36:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 83D9E60693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792431416;
	b=qC8BXR//42RzTvzuJ4kTglhJxnSBNhDlRUU/EgB3x0PaAMwB5FTUaS+u30Zzqcq8IwxM
	 UltCbalqN/Uqi42sBQLmSSuDFdIQPV1+yZcu59L7nCAXpl98Gdh27PZZrSQ3NgfzIyorY
	 FXT2BgMP8iAcQPLj+27VU3oT3jUzV4k6dH6PEju1VFQsnHYCKFxM3kBAKDSqx+NQjzy8b
	 PS82jNs3x7gMH1tdZqPhiF/bqiXMllbsJjfznCxUiaUs8YtadrlST/nhHXA8tqGWeU3ij
	 0/mIG6UfH9Noy8QEzHSkj6NxjhGcOfHOFp1TmD80X1VasuXEXFkw9WjWsMu32dv9sew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792431416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bg7tg6QakI10IQ1bSCZ84d/Qf5xEiPeNyj4CHXvrqlU=;
	b=Jr4PKnnmqcjmHa+90A1D+25a4uqB49jWGjdjhdSWwwizs6qPqiLdrLLIReZaIYqphzB2
	 0Bi8EDji80xX1IawIMxHH51g6uoedikX75JoFFYQQA5WpDATexQZTfj+wuJoqAWcf3RbB
	 9V8gPpA8ISsI0t3I0OSwo+M7+ygqwKD5PrSvT9R3rGNlePZUGklZPpYdiEqqnAeLJMFe2
	 whjWcNAZU285UlrwthQk4CAc8qRKrt4lSvnZgEDu4GSMnwhA9zmdeFHW2BMyX/4W5fyX3
	 ghsU1FFQorNtiy2LSVx+2pevZkecNDSsAuqsqHSX8Vy0jq5nUBV+MjZFuYZoQdZyXEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792431416;
	bh=bg7tg6QakI10IQ1bSCZ84d/Qf5xEiPeNyj4CHXvrqlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KBxrAfQ1V+3oXdzXpa1fVNaKb6DfEOIy/1wEsB7/WrZ/lBuyECCcPa53OmEE99g+z
	 Z2sMuAklQ0pmr7tlpUsdZhhC144Ukp0apswM4aCUL2SfMFLmwDsG7/6/xmSiyC2Rye
	 QgbjwVHWkIoFXJamAKNO8lk9jRILbG3Gv4VRi1Qw3c7b0OLNXBGV+uPaNrdgstVsQp
	 R2dKoPf1K4FhTnhqd4iZ35YJMbAa+i2rzqR4TRZblZFakDLK85wlsos1dWWUYdPQGr
	 6sCEiHl6wpDb5X1Nvj11DGqR2NtDBw8os3YEMmIUx/jQnRQo0RfGtOcb8Q1kgHSbM5
	 K3T7dOomSSUEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83D9E60693;
	Mon, 19 Oct 2026 17:36:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BFE2B1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B17E440699
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:36:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqzhKN4o1i5H for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:36:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8AA584062E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792431413;
 b=CZ/T6cCPE0AgC/yrQxPBmwxcFp0fMQmVOwbHuKynViZu+lr50PtuY3UsiDNTQBUUzWg9
 LjQvuLtCVNb9K0ERP6YQ7QkWVbzXjvXs0FIXHCWDYTepwJDWcpypVzv1RnQSOtXbEq2E9
 CGCNJgGZmdyoEfW9chpvS65WIthHQTYpECQhRd8UcprI66AWqk3HNOjhxNdH6T5r7CFfz
 FiXxucg8vnF7Ojq7bAx8NE8qM3M29vJHuk0xo5ojb9fUL/MYerbqcsUqK0C4EaAT3p5Nk
 8klTYZWWzrrKc4pXwacDXHu1PhPvSj2CB3LFz/Qid54y1y42Zd74iDiW3yQcu7rsNnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792431413;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=bg7tg6QakI10IQ1bSCZ84d/Qf5xEiPeNyj4CHXvrqlU=;
 b=aiU9R7UMl+4WVH7DLh6rfI7SOLyj4GsJ/2+607Jc3Wzq8nukfb71vujlq8Z8qwgP7odK
 Mq9MRaqr4AJ48eHn/OVtPiTZDvcuwuqm4vQWQpqH16kDkBR4r0UkAJHVwQg1x2/SmL/RL
 aW6QcJDpyNu/Y7flbFbOVcxthurfIXU/4IVHbaj7x88Ps27oxvdRvQkL0u6ZNEN7xtbQ0
 vvxtwsnY26DNNdOQMI0aS4bueqreEW53IX3C79xsTwWdu0/eM0EFAJR0u28aKZwYooFLi
 o8VN8PPNY9aPNErXKaSjmyMs8lnk0MFUNOduWVAOZmYMn8GJDu/6LDxreJBjuxrMYaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K67nhkyl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K67nhkyl
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8AA584062E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:36:52 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-70073621339so1470452eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792431412; x=1793036212;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bg7tg6QakI10IQ1bSCZ84d/Qf5xEiPeNyj4CHXvrqlU=;
 b=K67nhkylRK7iVwoYqIIA24BhOsdbcRBvEKpcv7/FSmi8ofUo+jzHi1UrHgg6f+BjOM
 MA6G5s9vTa+kzNWNPsHZMlfwXVxlVA8zRk4knyG6EDY9Sk547GmpkHPuuT2bRSBTakQ5
 1V9i6VGuUxQf/msPFV4dZoFW6o2w8mFftSteM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792431412; x=1793036212;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bg7tg6QakI10IQ1bSCZ84d/Qf5xEiPeNyj4CHXvrqlU=;
 b=yPUxlIUWMMcQghyuVhnj1ggq5uEhNjVo3MC4o9RRYUldSDCKq6/rWq+7V3b2j7dNu+
 9KmJeOLi6BR3oiO5NxUzqQRt5nGUI380SLegMcD10fw3bL0UsYeEsbSGROEKvulf86O2
 bb5A87QNLAjRFRSWjP4NCeThoyNLJyTEYQSzZKjc4LwjMnfqgr+ZzJxGVzffVSlQvaQ/
 OKdKh+6O5TDBIajXVMuR0BIZfMuS/zu0WYlAuxuhZoLW9tS1X6Y9f7lhDGMYRtZqAb5g
 d4omEPR15uydicE1nuuGvGAG22yNa9krpev0HNI+vI/NCDCp3b6KPQqDeW/W9ocy0vIZ
 aiRw==
X-Forwarded-Encrypted: i=1;
 AKwUvByw4F5Sy/psXdvfC7HhJV56kIH6Jql1yYd8On6m+gQJwQX1O596DQl2ITGlEBwK8gnVrtxAdng=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhfbFdhexfpIcqqgVe/EAF7ZFBZ006ifIVCY7ZseU58n6JfUTd
 pKwEp+2UnMDuoE4lcO1nM6K9dY8180hS2L6uT5Sn+rfw999iJ1MUrwYPNLJxka70gjwZPAXmfAu
 m7cdpbw6VwABV7lg=
X-Gm-Gg: AYBFou0cLlfeDX7e/okh7qgNE6aTdTCkLZftYaQiw3BYoq0FN7tRuGMQhjSV9TZFNLR
 1Rn5N8jDnhTk3zL3QaB438JInXbtER/F1YHeQ1z5lL1rshNRLCd+w1YYFJHIUgM70OAnesKxhPY
 pMZ1XEKQEJMlP7rnJJUOefmvG3+Ab8DQitrK27y5MHqfNTz6MhA/F8LAa1IEehFFhkKf2AwiAFH
 LAJwdY23D5uhG/7WWw5vSswyhz9FAW+cSUyXbZd46j2147iIfZWTPk4WVOoUtw52JfTPRJbaTwe
 kDhFMbIDFhn2Ge1+ZvWXoaW4kcgJf1MB2BWKHcSVt1M04sOlPk2cqQZBqkvA+MyqBoG+1pej/3a
 Uv3Aq6EWp7gDSYsdnO+CyUJLgsWIelfA7Okfz0wpD09TJc0Tu87aaT52c932ZKEm7FEA0YS63Qe
 gzxWzokK/PZGeu7nmf4ZTxI7uKoYJYkTtUnylkV7rJZm8230Jl0B90gVuQLIvV5xebURjuGPpxJ
 6qVvTQaWols7gG6aFu8X1lQymiGjQEYOACnCRXc2sbIp9FzMMs/hTucD/PofIG/m21gzLg1kdtN
 qHHuCMZYdk6jdm+e0SCLT0hdJMu4qA==
X-Received: by 2002:a05:6820:3086:b0:6f6:d7e:9ed9 with SMTP id
 006d021491bc7-7035258a488mr6382515eaf.13.1792431411743; 
 Mon, 19 Oct 2026 10:36:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7018f2e0d89sm8138477eaf.6.2026.10.19.10.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:36:51 -0700 (PDT)
Date: Mon, 19 Oct 2026 11:36:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] lmb: Enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9
Message-ID: <20261019173648.GA720525@bill-the-cat>
References: <20261018043128.26916-1-semen.protsenko@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aldf48hffcsSr7Nm"
Content-Disposition: inline
In-Reply-To: <20261018043128.26916-1-semen.protsenko@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--aldf48hffcsSr7Nm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 11:31:28PM -0500, Sam Protsenko wrote:

> Since commit a3075db94d49 ("lmb: Reinstate access to memory above
> ram_top") secondary CPUs cannot be brought online on the E850-96 board
> in the Linux kernel:
>=20
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to come online
>     CPU1: failed in unknown state : 0x0
>     CPU2: failed to come online
>     CPU2: failed in unknown state : 0x0
>     ...
>=20
> This is happening because EL3_MON (the Secure Monitor firmware, which
> also implements PSCI) cannot handle 36-bit addresses in its CPU_ON PSCI
> function implementation. The E850-96 board has two 2 GiB RAM banks: the
> first one is mapped at 0x8000_0000, and the second one at 0x8_8000_0000.
> The commit mentioned above changed the LMB behavior (in U-Boot) in a way
> that the memory from the second RAM bank (which is mapped at 36-bit
> addresses) is not reserved anymore. The change in 'bdinfo' output:
>=20
>     - reserved[4]    [0x8_8000_0000 - 0x8_ffff_ffff], 0x8000_0000 bytes
>     + reserved[3]    [0x8_ffff_3000 - 0x8_ffff_ffff], 0xd000 bytes
>=20
> That in turn leads to the Linux kernel image being placed in the second
> RAM bank with 36-bit addresses. The corresponding change in /proc/iomem:
>=20
>     -   f480_0000 -   f67e_ffff : Kernel code
>     + 8_fa80_0000 - 8_fc7e_ffff : Kernel code
>     -   f6b6_0000 -   f71a_ffff : Kernel data
>     + 8_fcb6_0000 - 8_fd1a_ffff : Kernel data
>=20
> As evident from the Exynos850 device tree, it uses "psci" as a CPU
> enable method. That means the kernel relies on PSCI firmware (which is
> implemented as a part of EL3_MON firmware in case of Exynos850 SoC) to
> bring up secondary CPU cores. So when bringing up secondary CPUs the
> kernel makes an SMC call (for each secondary CPU) to execute CPU_ON PSCI
> function (see PSCI spec [1]). The kernel passes an "entry point address"
> to that SMC call, which is the address of the secondary_entry() function
> in the kernel, which should be executed when PSCI returns to the kernel
> from the SMC call:
>=20
>     static int cpu_psci_cpu_boot(unsigned int cpu)
>     {
>         phys_addr_t pa_secondary_entry =3D __pa_symbol(secondary_entry);
>         int err =3D psci_ops.cpu_on(cpu_logical_map(cpu),
>                                   pa_secondary_entry);
>         ...
>=20
> The pa_secondary_entry is a 64-bit variable, which is perfectly fine
> according to the PSCI spec. Unfortunately, in case when that address is
> actually bigger than 32-bit value, the EL3_MON firmware doesn't execute
> the function at that address -- that's the reason the secondary CPUs
> don't come up. And as discussed above, the kernel image is now located
> at a 36-bit address, which means the secondary_entry() function is at a
> 36-bit address too:
>=20
>     - secondary_entry() address:   f67d_f5a8  // 32-bit address
>     + secondary_entry() address: 8_fc7d_f5a8  // 36-bit address
>=20
> It seems like a bug in the EL3_MON firmware, e.g. it might truncate the
> address to 32-bit by using a u32 variable (instead of u64) to store it
> internally. So the right way to fix this issue would be to fix the
> EL3_MON, but unfortunately it's closed source. So instead just enable
> LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_EXYNOS9 to limit the available
> memory to the 32-bit boundary.
>=20
> Although this platform could benefit from having all memory available in
> U-Boot (e.g. for transferring big images over TFTP), and it looks like
> there are no hardware limitations on this platform too (DMA has 36-bit
> support, etc.), limiting the available memory in U-Boot is still the
> easiest way to workaround the EL3_MON problem, and 2 GiB is enough for
> all use cases in U-Boot currently. And of course all 4 GiB of RAM is
> available to use in Linux in any case, so it's not a bad tradeoff, and
> in fact it just brings back the previous behavior (before the "Reinstate
> access ..." patch).
>=20
> Enabling LMB_LIMIT_DMA_BELOW_RAM_TOP for the whole ARCH_EXYNOS9 family
> also seems justified, as it's likely that all modern ARM64 Exynos chips
> may share similar EL3_MON software, and thus possibly the same PSCI bug.
> For example, a similar issue was mentioned in exynos-mobile related
> patch [2], stating that after "Reinstate access ..." patch only CPU0 is
> able to come online on some variants of the Samsung Galaxy J6 (based on
> Exynos7870 SoC).
>=20
> This was tested on the E850-96 board:
>=20
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
>=20
> [1] https://support.arm.com/documentation/den0022/fb/
> [2] https://lore.kernel.org/u-boot/20260614-j6lte-lmb-v2-1-6046b54db536@d=
isroot.org/
>=20
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  lib/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 021a82d47092..e0bfd10f2b7f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1371,7 +1371,8 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>  	bool
>  	depends on LMB
> -	default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH=
7110
> +	default y if ARCH_BCM283X || ARCH_EXYNOS9 || ARCH_MVEBU || \
> +		     ARCH_ROCKCHIP || STARFIVE_JH7110
>  	help
>  	  Some architectures can not DMA above ram_top boundary,
>  	  which is after 4 GiB or 32-bit boundary too. Limit the

This reminds me of my worry at the time, that we would keep hitting
platforms where this is a functional problem (and there's also the imx8
patch to set this option). I know there's some valid use cases for this
on Renesas hardware for example. Marek, how do you feel at this point
about inverting the logic and making this be an opt-in rather than
opt-out flag?

--=20
Tom

--aldf48hffcsSr7Nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatZVLQAKCRAr4qD1Cr/k
Ck9VAP9rJZVqs1KACtrIXA6Fw4icq4JMWYBF9Zo0geNWQZZMgwD/SmIM9/0Q8J5c
9ZmpQBKrfCwrUCB8MZmNn4Nd0w/p4QA=
=wM1U
-----END PGP SIGNATURE-----

--aldf48hffcsSr7Nm--
