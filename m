Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171A6C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1CF087960;
	Mon, 22 Jan 2024 12:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B60A879A3; Mon, 22 Jan 2024 12:45:30 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A9C0B8796E;
 Mon, 22 Jan 2024 12:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4681FB;
 Mon, 22 Jan 2024 03:46:13 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702663F5A1;
 Mon, 22 Jan 2024 03:45:23 -0800 (PST)
Date: Mon, 22 Jan 2024 11:45:15 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240122114515.760e9cd3@donnerap.manchester.arm.com>
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Wed, 10 Jan 2024 16:05:36 +0530
Sumit Garg <sumit.garg@linaro.org> wrote:

Hi,

I certainly welcome this more automatic synchronisation of the DTs,
however have one comment about the upcoming sync process:

> ...
> However, Linux kernel DT maintainers proposed [2] for U-Boot to rather
> use devicetree-rebasing repo [3] which is a forked copy from Linux
> kernel for DT source files as well as bindings. It is tagged at every
> Linux kernel major release or intermideate release candidates. So here I
> have tried to reuse that to bring DT bingings compliance as well as a
> standard way to maintain a regular sync of DT source files with Linux
> kernel.
> 
> In order to maintain devicetree files sync, U-Boot will maintains a Git
> subtree for devicetee-rebasing repo as `dts/upstream` sub-directory.
> U-Boot will regularly sync `dts/upstream/` subtree whenever the next window
> opens with the next available kernel major release.

I hope this doesn't need to stay that restricted? Can we either sync more
often, or at least on the kernel's -rc1, and not only on a "full" release?

The reason I ask is that we have a chicken-egg problem here: without a DT
merged into the kernel tree, no U-Boot board support can be merged. And
without U-Boot support, we cannot boot a kernel, at least not in the
canonical way.

Since the U-Boot and kernel merge windows are not in phase, for sunxi I try
to sync the kernel DTs either as early as possible (-rc1, sometimes even
before, when the maintainers have merged them into their tree), or
sometimes "out of season", if a board defconfig patch is coming up.

Otherwise new board support, which typically has a very low regression risk
for the rest of the code base, would need to be delayed until the next
release. In the worst case the U-Boot merge windows opens one week before
a kernel release, then new boards need to wait three months?

Cheers,
Andre

> `dts/update-dts-subtree.sh` script provides a wrapper around git subtree
> pull command, usage from the top level U-Boot source tree, run:
> 
> $ ./dts/update-dts-subtree.sh <devicetree-rebasing-release-tag>
> 
> The RFC/prototype for this series has been discussed with Linux DT
> maintainers as well as U-Boot maintainers here [4]. Now we would like to
> reach out to wider U-Boot community to seek feedback.
> 
> [1] https://lore.kernel.org/all/CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com/
> [2] https://lore.kernel.org/all/CAL_JsqKEjv2tSGmT+0ZiO7_qbBfhTycbGnhJhYpKDFzfO9jzDg@mail.gmail.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> [4] https://github.com/u-boot/u-boot/pull/451
> 
