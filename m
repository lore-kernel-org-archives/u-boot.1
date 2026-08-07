Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89167C5ACD1
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 21:19:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2177081149;
	Fri,  7 Aug 2026 21:19:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOK2ubgxiLc8; Fri,  7 Aug 2026 21:19:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 445008113E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786137567;
	bh=JWRdVNfwXX17Raic7H9H5XNFBfPutVvhdWdKxpIfUNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSBDJ8WunjwN96UsqfPzK9ANT+4rVap+g4S96F6BvC+8qcPy8h4eIek/Z+ase68fI
	 rOJtwjwHu+EldXOQ8/h/0jQ3UHwOD+2xKm3YzOSLItF+WGq1s3mwVl2h9DX8DOSWB6
	 rvG4lEbJ1pYngf3M9uDdHCe/a9ebQfGjK5oQvl2fhZYw1iMILNUigWwUDOWzSF+bf+
	 e4we/QXyABgV0VW7CaNoGDsODbaJCUGqHKG1w9S7oo+peJpKYRiPx+604NgQVE7Qcz
	 52drOqUi8SUQFIskBtZMl0WIx+hovO+vTB60a3s/6R55xLmtIn0/y5FCszOiKLQ16Y
	 v/1xrjdiM3Riw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 445008113E;
	Fri,  7 Aug 2026 21:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87976296
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85516607C6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T4PCJzRSIUyv for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 21:19:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 86BFA607C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86BFA607C1
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 86BFA607C1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:19:25 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so5579153a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 14:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786137563; cv=none;
 d=google.com; s=arc-20260327;
 b=r2pp+yfWWv0jD7jlKDw9gQmaZNWNeHC2+frzfS3up3aelrUwFxyGKoA0rFE6JPjXOY
 MRUSa1iqJrEMTHULEoZ2h7Ddj+IKMuE+NGHj6zOyv5ba6L8rwcZURwiQIBxoJGqcrLt5
 ZX1pN2h1vX9dA2rxe2PoJvPLjWN8rG4hW7UrBOlTg0n3E1ogiY2YNvqo0qLr6X1CiTOz
 f+YznBz2H0kJfiFRTk7eHLdoYfXbp/+YlcpjANrhuaGCJTd5hGqujUQH58aPu2pBGn/0
 eHBTwP5wDwzYCXwtv/4fXRRK20kx7jK6hkyJnXl06ekBT5SYMz3tGNzaw3nLBvVpjNja
 5pfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JWRdVNfwXX17Raic7H9H5XNFBfPutVvhdWdKxpIfUNU=;
 fh=Q4e50Ym8c5Hh4ECElhsWQfDZBeKKF2M/kgqq3yluw3s=;
 b=gqQNWNK19KqR45eG4eUTCTpUiLRrem/jjFnn3yL8YhWu8DIpY9TAQ7zQBtKK7pBCMw
 4ktXh3tBf7NQk7Dzg8l32LqCjlnbIPsZmmjorpITCjZbBimMyDwhKg5XNt3d8WrjQaIy
 sDs2pokTL4TgkGrC36NIRFUxzvVpEno9LGQWnKlWtabG6WnM2lrQFUm9h1z78XYIKmtf
 pYx+KLKVvJLvfZE0eNQiVi0S5V+tWfvId7yPQ8F6lyWu0wUmw802ti7eXW0mC5XFa6Oy
 PDXjRb5kCQVKRfS2hBQ1tw8Ju3HYFuNsc3RB7D51VQ13RRb7Ss6IEEY7YwZ8f7vts44Q
 W9Lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786137563; x=1786742363;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JWRdVNfwXX17Raic7H9H5XNFBfPutVvhdWdKxpIfUNU=;
 b=emnBbXYCgwZlnUzbizfP/yKtourLdLr2nFsoVk7TYEWPbu/eIijrmGiTZxKaU9tbBY
 FIqqQ/hyvXQLX2x5Cq3L6RPaDq2f67/E0SeZKHtXWyOWkGNOjaXxzSVeF69QMbq6kJvr
 M9/YpxP0t0zVFG/0xshzHOazEvP6gE5+5eTbuX4CuxLqXxavRgGgEE2oIW4Ttg2nWnxE
 lUZlL4F0J0ziwKHNepH1157uV8nyafYcPAOzeJgjBFs5YJYP2rydVdg/xiWF0D/v8OHm
 2mPOi21LrxYJrKAHDraQEBvkxdF3rrkVbFTn5cU4ZMpLp/aXJtW/za/Cu89guKiK+aTZ
 fP7w==
X-Gm-Message-State: AOJu0YyHboSzSyHi1wwdBH7lQrI1VwzIPGvPWDf6yRbJyXLuNNETREs1
 y/z4nj893bkvPGcz5kweCzZK6skKI9aNAaE071eDNu0YMiP/fcujdDfueIfZFNOcme84FCheXjd
 xw59o44rFN5q77h3CNakQZJ1UlTo17dRdQJ2e1trS
X-Gm-Gg: AR+sD10wgVA2BFyB3+nCcQVzau5JoLy+XGPuOH9sBuZbJ9uYz++KgzMUDc6YqzosliD
 pmq6qxjZdx2Za/RAo7Ix0iLnagbtY5jRmwrlnch+Oc/b1MaHMhGzUcAMYhdPeQYCOiBDYMjoepN
 XSIUlpKkztX4j4pa/GUs3SOumXkRioLFYVPkSeIPgtQ3M3XFxeL8Ei7FXc/4jkSjyjK3+XP2rhu
 rOOFvoG1B6K1SZ32fM1fZG688LfvdIyqt1rdBjtZIk26scVkj8PjJGtgR6TDcl1SGeh1efxIplg
 Cm2uMoINg/5A/FBRcsq6v5gOmUF+EsIVgKYbjnSXypps
X-Received: by 2002:a05:6402:324d:b0:69c:6547:518b with SMTP id
 4fb4d7f45d1cf-6a1f2461f97mr1341903a12.12.1786137563489; Fri, 07 Aug 2026
 14:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260805203113.46567-1-smoser@brickies.net>
 <20260806181818.197191-1-smoser@brickies.net>
In-Reply-To: <20260806181818.197191-1-smoser@brickies.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 15:19:12 -0600
X-Gm-Features: AUfX_mzB9aeLURFpw87PKHJ50PP_fUxFIdoTys27pJCBxu1EivECUP_Eeni3hVA
Message-ID: <CAFLszTg6V8MBHgxBwpjeYF_TKEDv3-V036G7zbfSOgVx=DCjNQ@mail.gmail.com>
Subject: Re: [PATCH v2] dm: pci: fix uninitialized fdt_pci_addr fall-through
 in pci_get_devfn
To: smoser@brickies.net
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Dustin Kirkland <dustin.kirkland@chainguard.dev>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786137563; x=1786742363;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JWRdVNfwXX17Raic7H9H5XNFBfPutVvhdWdKxpIfUNU=;
 b=PcBtRLm5EJtGngrbDiV+05UYj2+6ZUpn6c0VjUDVobInm4Jwvh2uxyfl26Nge4mMva
 wgaSBfYrF8ZiuVCbT8ZmDdpNeSLOMlKAbGqpj4EHvYUp++hVf4zs7uUAK72p3Sqb250a
 S7B+/ldQRtIf9s5JQdanfauP09tm0997xu8X8=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PcBtRLm5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-06T18:18:18, Scott Moser <smoser@brickies.net> wrote:
> dm: pci: fix uninitialized fdt_pci_addr fall-through in pci_get_devfn
>
> pci_get_devfn() reads addr.phys_hi and returns the low bits of it as the
> requested devfn even on the -ENOENT branch, where ofnode_read_pci_addr()
> has NOT written *addr. The C standard leaves that read undefined; in
> practice the returned value depends on the compilers stack layout and on
> -ftrivial-auto-var-init. That value ends up in pplat->devfn (set by
> pci_uclass_child_post_bind()) and is later compared for equality in
> pci_bus_find_devfn() during PCI enumeration, so an under-determined
> value produces an under-determined driver-binding outcome.
>
> Concretely, this fires on Raspberry Pi 5 (BCM2712) when built with GCC
> -ftrivial-auto-var-init=zero. In that build addr.phys_hi is zeroed
> rather than left as stack junk, so pci_get_devfn() returns 0 for every
> DT-declared non-PCI child of a PCI bus. The Pi 5 device tree includes
> one such child under the second root complex -- the rp1 simple-bus
> node representing the on-SoC RP1 south bridge as seen from the OS
> side. Under zero-init:
>
>   * pci_uclass_child_post_bind(rp1) sets pplat->devfn = 0
>   * pci_bind_bus_devices() of the second root complex reads vendor at
>     bdf 02:00.0, calls pci_bus_find_devfn(bus, 0x0000, &dev)
>   * pci_bus_find_devfn() finds rp1 with pplat->devfn == 0x0000 == the
>     requested devfn, returns it as the pre-bound match
>   * pci_find_and_bind_driver() is skipped; the RP1 root port is never
>     bound as pci_bridge_drv and its downstream bus is never enumerated
>   * dm_pciauto_postscan_setup_bridge() then writes PCI_SUBORDINATE_BUS
>     = 0 and PCI_MEMORY_LIMIT = 0 on the root port; Linux flags the
>     bridge as "bridge configuration invalid ([bus 01-00])", the rp1
>     driver fails to enable the endpoint with -EINVAL, and every
>     RP1-hosted peripheral (USB, onboard Ethernet, ttyAMA10) is
>     non-functional for the rest of boot.
>
> Under the default -ftrivial-auto-var-init=uninitialized, addr.phys_hi
> happens to be non-zero stack residue that does not collide with the
> requested devfn, so the same code path just returns -ENODEV from
> pci_bus_find_devfn() and pci_find_and_bind_driver() correctly runs the
> fallback. The bug has been latent since introduction; -zero exposes it
> deterministically.
>
> A "reg" property that is simply absent now consistently returns -ENODEV,
> matching the documented contract in include/dm/pci.h, instead of a value
> that depends on stack state. A malformed "reg" property still returns
> -EINVAL, as it did before this fix.
>
> Fixes: b52142004fbd ("pci: Add pci_get_devfn() to extract devfn from the fdt_pci_addr")
> Signed-off-by: Dustin Kirkland <dustin.kirkland@chainguard.dev>
> Cc: Scott Moser <smoser@brickies.net>
>
> drivers/core/util.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
