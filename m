Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D47CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB80983955;
	Fri, 31 Oct 2025 16:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pGaDp93j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95F583952; Fri, 31 Oct 2025 16:10:41 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87726838C2
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E15FB403CD;
 Fri, 31 Oct 2025 15:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88ABC4CEE7;
 Fri, 31 Oct 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761923437;
 bh=1zm18BM06Nxp8Ypq9IgFA/tcaTzdrg5//C453fY1zRA=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=pGaDp93j420gAHMIgBOb6I8BNggvDSA83M35ZGk5aU5i77AvpXSDTfj1qRykkqL2b
 lJ0umagpkIoLu+/Brr4g0Bctcd1H/P5mjvV+G7nmRt9QnpqgnLb+2tYqI+Q6L5aOJ9
 dWOCytBH7FmMlzKZkrMmVlYAvaWJiIb5YPpEsF7H7MlOJdxJzitFUARVVFz1GxtHTB
 lmsGF2+lM5D4WGL/xQI1ksZEkwwqWX1TcqHV7WYpFJKa17YyOFM/jM9u/msew1MB3Q
 lV9ueyGhOnxQ4Rrk6Lmid7ORYVvSK/DIaT15tJSbpdvtRCTepOfV6FAhqAJCcn0bU+
 Jf7/CkTWQUX3w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, George Chan <gchan9527@gmail.com>
In-Reply-To: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
References: <20251021-abootimg-minor-v1-1-88a12f53d8de@gmail.com>
Subject: Re: [PATCH] boot: bootmeth_android: Conditionally dependent on
 abootimg
Message-Id: <176192343323.290092.16053648607478981549.b4-ty@kernel.org>
Date: Fri, 31 Oct 2025 16:10:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Tue, 21 Oct 2025 00:36:33 +0800, George Chan wrote:
> If target u-boot img do not support androidboot v3 or greater,
> abootimg might not be necessary.
> 
> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_android_normal':
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_android_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
> aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_abootimg_addr'
> Segmentation fault (core dumped)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] boot: bootmeth_android: Conditionally dependent on abootimg
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4b493b9664390e16f61a6409ec60676df7759c7b

--
Mattijs
