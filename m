Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF430CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 04:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A4AD846CA;
	Mon, 11 May 2026 06:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="eM7b5LEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAEB84706; Mon, 11 May 2026 06:53:14 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF46846C7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1778475186; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SfGB1/Y7UybMw+c/sSTm+FRSdYTOAl3VWBFFQQqVFpnNuP5OpDvdJme9aPN2JpaTtxg++74x5phJGduBldag1nTCcS9MtWmDcP+b3vdh4dPqn8xAFfSWaxmxWN6ynvN70zvKzr201v5lQKi87zl06coafbMGwIQ1vdREBqL011M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778475186;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hUMw3EK4uCn0OLMUE93iDZKZf6153KoojNVCmA6cM80=; 
 b=e4C0Io5D66yryoXc6Lvk0lNDlX+sYyRsteC+kMMoYo2L0061SEoOQ4XATHlpnjLyLEutaCI6s07C6VnqxOhL5QkZwsnPOJspHGHzU4ckdyHxtAXxMkA8ZEeQ2pJixO2ov7Ir6OeEBfQYoFR998abHtw2mFs+3N8/YGKnDUfvXIA=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778475186; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=hUMw3EK4uCn0OLMUE93iDZKZf6153KoojNVCmA6cM80=;
 b=eM7b5LEj7nAAJilTLpOPn0ZieLoXXLHXozjpZwDjKa6UefnEZyqM9LqIAx2vQ2FX
 korN4d2LnchlbpHC4eRNg9UU02eVU7RWb7RFGFLZYzPBnqy8/33C9///Q7qCIiV3Y+p
 vJZUB12OoC8eu6ft7f7lOumH+Ohvcr8Nh+3V/pKA=
Received: by mx.zohomail.com with SMTPS id 1778475184059216.23393348748994;
 Sun, 10 May 2026 21:53:04 -0700 (PDT)
Date: Mon, 11 May 2026 04:52:49 +0000
From: Yao Zi <me@ziyao.cc>
To: Vincent Legoll <legoll@online.fr>, Guodong Xu <guodong@riscstar.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Peter Korsgaard <peter@korsgaard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 u-boot-spacemit@groups.io, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/8] riscv: spacemit: k1: add clock reset drivers, switch
 to upstream DT
Message-ID: <agFgoT-HbPfzgVWT@pie>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
 <3fe472bc-b9aa-49f6-ab75-a45547815c28@online.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fe472bc-b9aa-49f6-ab75-a45547815c28@online.fr>
X-ZohoMailClient: External
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

On Sun, May 10, 2026 at 09:44:14PM +0200, Vincent Legoll wrote:
> Hello Guodong Xu,
> 
> On 5/10/26 14:06, Guodong Xu wrote:
> > Currently U-Boot's SpacemiT K1 ships its own arch/riscv/dts/k1.dtsi and a
> > spacemit,k1-reset binding that has no node in the upstream
> > (kernel-mainline) K1 dts. After list discussion [1], this series
> > moves U-Boot to the upstream DT before further K1 work lands.
> > 
> > In the upstream DT, each K1 syscon provides both clocks and resets.
> > The kernel's clock driver spawns the reset child via the auxiliary
> > bus. This patchset does the same in U-Boot: each clock driver
> > spawns a UCLASS_RESET sibling on the same ofnode.
> > 
> > Patch 1/8 adds the K1 clock driver.
> > Patch 2/8 adds a new syscon-bound reset driver with no DT of_match. At this
> >            point, the legacy reset driver and local dts are still there.
> > Patch 3/8 has each per-syscon clock driver spawn the reset child on the
> >            same ofnode, the way the kernel uses auxiliary devices.
> > Patch 4/8 enables the clock driver.
> > Patch 5/8 switches BPI-F3 to dts/upstream/.
> > Patch 6/8, 7/8 and 8/8 clean up the legacy reset driver and local dts files.
> > 
> > Old and new reset drivers coexist from 2/8 through 6/8 so the series
> > is bisectable.
> > 
> > The K1 SPL bring-up [2] and PIN/SPI [3] series will be rebased on
> > this and resent once it lands.
> > 
> > Link: https://lore.kernel.org/u-boot/20260507140558.GU1614990@bill-the-cat/ [1]
> > Link: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@gmail.com/ [2]
> > Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@gmail.com/ [3]
> > 
> > [...]
> > 
> > ---
> > base-commit: 24db98cdf911b6ca362209e674bf9412441c1095
> > change-id: 20260510-b4-k1-clk-reset-upstream-dts-cbf1f3a79cfb
> 
> 
> I tried to apply this locally but failed:
> 
> $ git log --oneline -1
> 24db98cdf91 (HEAD -> test) Merge tag 'u-boot-imx-next-20260318' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
> 
> $ git status
> On branch test
> nothing to commit, working tree clean
> 
> $ wget https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/t.mbox.gz
> \
> 
>  -O ~/Downloads/PATCH-0-8-riscv-spacemit-k1-add-clock-reset-drivers-switch-to-upstream-DT.mbox.gz
> 
> 
> $ gzip -dc ~/Downloads/PATCH-0-8-riscv-spacemit-k1-add-clock-reset-drivers-switch-to-upstream-DT.mbox.gz
> | git am
> Applying: riscv: spacemit: k1: add clock reset drivers, switch to upstream
> DT
> error: No valid patches in input (allow with "--allow-empty")
> Patch failed at 0001 riscv: spacemit: k1: add clock reset drivers, switch to
> upstream DT
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am
> --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> 
> I had a similar failure with the mbox downloaded with:

Because the first mail in the mbox file is the cover letter, not a real
patch, thus contains no code changes and couldn't be applied by default.

Try

	b4 shazam 20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com

instead, which applies the series cleanly at least on my side. With
git am you might skip application of the first mail manually by

	git am --skip

and continue with rest of the series.

> $ b4 mbox https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/T/#t
> 
> 
> I also tried to apply to master branch without success
> 
> Is there something I'm doing wrong ?
> 
> Regards
> 

Regards,
Yao Zi
