Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D952FC43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 07:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB31D84119;
	Sat,  4 Jul 2026 09:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KX+E2hPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5417841F2; Sat,  4 Jul 2026 09:50:22 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BD98341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 09:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664d35b4777so1699493d50.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 00:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783151419; cv=none;
 d=google.com; s=arc-20260327;
 b=FDOiKsd+lXg2DnYe+3olyKX/d6DJEhmtGQUCJhheRxJeMk8W3rKbg5Fv+7pYCpgf9A
 9sF2Ls1jVY/s8zBZBLLGJkBPhbLDED3RuzVOE+JEOkYcurV6kaLSToaC/ciYL2NZ9ZK7
 sG+zhjogN0I3gSwbPq/zgoTjxU22SXyYQrFp3B16BbvgsDo1b4W8NavB24oJwGV0MV4j
 vZ0n7LRpIMRt/z1GX0N1CyUP4lj/Dyh3bcrbYe50Z3xNmSrCBWoVCPTuvlnfvLlMQnx3
 8Y8o/UZlYpnxFwwhHMXAHdb1FX762sENxVLrKQw3gACOvcReX5FUpG+ac6ATafMdvnAm
 a0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AArATN0zgeAFShVBG6iCJgEEuAXYaaig79RF4Z7Pg30=;
 fh=yu+G6IsdztysNsRSTmRW48WPoAbx+i8T8yzETV29jiE=;
 b=E7Fro/aUBiUhpIGb3GmeWISvhik/HF4WM3Ev3QSeozh19wUApoyjGYM+hBKpajXOPX
 PJS41pda4jP3FLrGMgi5UVU0F/96XbCsyoVW3BEG/KoN2GNRpPmOL5WhrWMvblRWRqGY
 2iRQIN7dUGVB7K+AagVokXD4Xv173mJUoNwkgBEBSfSAv/Afb0HEjnwExdA6yxicNZFF
 YWeGMn9hZHzKvLMjtEqW/FQM+f/edb6u3knBybekTzcLgE6effhd2NMC4J6vQ0zUMDMu
 Ij/5Jv6UzTsuM04ZMFpca10AwWzP82FdwMtiQNBXk6gJxN2vIv/3mgL1rvMxuRC72OAx
 ZjWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783151419; x=1783756219; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AArATN0zgeAFShVBG6iCJgEEuAXYaaig79RF4Z7Pg30=;
 b=KX+E2hPR+wPIhe3XOer2gxcKCSJfdVg8Zt8YR7CzQitwba5lnENawSDlNPRmdPQNoP
 lErC6HtAYIxJYTdhgaznR0vQX1MB4Jnf36G2lJ19bgnOkJBImBxtgBMvra5RS+FQkM7Q
 117mGzfk7Y8jAbKG5TQ/3dPRRa+jODrntiQRDgB4mS7QBlvWGzlJsdjIYyNlOwajI4o7
 Vr87i0xVPJvbX/YqhB8iSQnRqDdJpphME4LJMgJm32cBaUefP9/I1X2vxey/0P5rG4i+
 mr3Xd8okis8x7FRMeAu2eWt5l9cqNySlMjNww55DtZ7pyhDzXbKEKsJdt9qhSmZ7CVbF
 /LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783151419; x=1783756219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AArATN0zgeAFShVBG6iCJgEEuAXYaaig79RF4Z7Pg30=;
 b=AXQxHDC462i9LuuJ9y9Aaq5iGX1JfLaFzzEtf+KtQ2nHhXGgWEx5fEF6MuvGrvLnik
 kXCYDQy4jN2zfdGPQruVC26cj2kEQh2OvtT9B1Qb/RkrNmKevFN689XOlDUukF9pdqpC
 YDiU4kEzAdN8Jo066l0UVNbmUz3gdQt5YM2qYCCb2P7Wxs/rbdxU1U2YrlaypO3Xvhgj
 0hS0PFw3MuKJ6k8mbDIVMRGZiSnScEmDIt52uV70yhJNvtg5+V3mdbFAa1bgvIIlXa6l
 j4nt1wZwsUblrHzdOpRoPHpElr94gYQgNxFhLTHhD5cTiRdXrl7eF32GhjTQJVP5zEl8
 YGnQ==
X-Gm-Message-State: AOJu0YxQ9xYlLxJyd3fxq0OSNBobbw5xrFfoYqVwvsDF1t+hK0vh5EwT
 cKVR61JXDLSEWqRBPsHUGzx/8sh4SuNcO5asN45t12NhBdQQtA+QTcJKBYMuyOG0wck5QoVsg83
 Wxor5VdC5cKSB1HUs/ot6tIHfK+hIvY8=
X-Gm-Gg: AfdE7clV4tsUjGXkmf5OC9RXjilubRdjmnYdpZnKiHozOZWA/nyEnfFxqw4WCvycWbB
 w2YYUZlv721Wf8sG72sxxK8jh+7I7hgdMzRK/LONUceCbC6kHtPSi4eiNAtlmUhByMM2AH468ux
 6DVPunjB7x2Z6qZe9uqCRYs/lslwF1dmg23VJvjcboZNbCtU9r05/CkDhY/oRAx9IT+CkGSXRgo
 MNVNdSpOT9SHJzqLEUQdxqE1vVKex7V92+MKnTLb8+mt8j6cvkqRf1VLhA8gxko3STOknzmOGoY
 bYycPcj0rAuTTNUBToe1FC+83ZRtlvE=
X-Received: by 2002:a05:690c:c0d:b0:80d:b8ea:75bf with SMTP id
 00721157ae682-817396f4498mr25404157b3.38.1783151419377; Sat, 04 Jul 2026
 00:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260702234020.3628298-1-judge.packham@gmail.com>
In-Reply-To: <20260702234020.3628298-1-judge.packham@gmail.com>
From: Chris Packham <judge.packham@gmail.com>
Date: Sat, 4 Jul 2026 19:50:06 +1200
X-Gm-Features: AVVi8CceN-VGdvD3FLAeQXjrgFFnStB9QKYot9tYZlbiNvyzmYgD4RkVStruIPo
Message-ID: <CAFOYHZB2QeckFoS2j9tGmQ-bbs5oBT_z3=9d9YxsOnuaGdOf1Q@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: Update docs for Allied Telesis x220
To: stefan.roese@mailbox.org, Tom Rini <trini@konsulko.com>
Cc: u-boot <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 3 Jul 2026, 11:40=E2=80=AFam Chris Packham, <judge.packham@gmail.co=
m> wrote:

> The current documentation doesn't work as-is for extracting the DDR
> training binary from the vendor bootloader. There are some seemingly
> undocumented alignment requirements that we need to meet by padding the
> binary file. Add some instructions on how to do this with objcopy. Also
> fix a minor spelling mistake while we're here.
>
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> ---
>  board/alliedtelesis/x220/binary.0 | Bin 423 -> 77772 bytes
>

Whoops looks like I included the result of running the command. I'll send a
much smaller v2.
