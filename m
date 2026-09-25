Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DA5C98306
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 05:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AE3860B9B;
	Fri, 25 Sep 2026 05:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JQlq8mBBesqw; Fri, 25 Sep 2026 05:27:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6DA6F6067F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790314042;
	b=kqCgOCf4C+Xbfb/iP/Sz1GMRtvCM6mjOqAjIbQyR3Okf+lq72oeF/tj9lKarnKKixMAG
	 gYQsAAeY+CC+hk0uZGtHVXJPJ/NApmHxznhaYZp9Vopewaht8ipO2opk9zXxOLqX9ghah
	 CA2BIKdN+Caom8sROvMlF9KSaHSLsbgtsh3wTtO/A5BhQeckq30PzQ2DyJJCnjKsUr/cn
	 1TRn1RwRwhdGrG+D6Mq1cKzzhQs8VDi8yZ5eOjUgUOOKkf8xJGkVf2THHzJCI6kA4TBUc
	 3U6dp3B993rDm88BlTxtOjs/BcnAbVeUdeQwm+39cDExStx6yuBn5+fUNtbkIAzoY7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790314042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=aSRS35hOhFDIxobXU0jpShDANbJZmQZUJB+6J5nvO1I=;
	b=HsEcSsljCaSKkqYwu9pU7sUnL4moweQ6uUSeaiArLVVCha/yws53KsR0Yrj+81vOU7cx
	 pBF2g9903DmvuHfa4Vp7rmed3wGSeVNjsZthMng7Q3sPK7Y0UDWdmPt5S6/NQfiIrFI9q
	 2AmMnWirBHIbZ6BhEWH72kUbmKpIPrjNNeQwoI39FnFcxc4iqnyCpSK4af9JjlUDJKfSa
	 rfzWfP93S7fAH7qIMiA+/JkZDF7/4xgATeLv5sV/i9MDHVFmRq12AAJpM9gAwtG0r7APt
	 Iu39lVMP34gy7RT2aytPdePhYRy17va44raqch4fuosNSzPpyXdpDDWI8tHEsEYSptQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790314042;
	bh=aSRS35hOhFDIxobXU0jpShDANbJZmQZUJB+6J5nvO1I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Va032oI/FhwO7i7/kHn7mSOcg6bbB1XZl9T6X77F0VJAX0TAybXkG3ZGPcXTn8cK6
	 4UacNhbvObXDNsOh+mZWzfzTheVuSlY1ZJ6M7cUKYPnvhsVHF+OKa1kgRKIDMNFkLF
	 t+6Ln3gTKMw9lt072D23kB0kdmjQzI2bm4ic4pi5JGkZPSDM2xjQhNg6eFzc/x6N4p
	 RlZg6Wd82ELWQwtXyFZ4rEIPbQF+4DuURm24nPg5jxLVhAGXL5n+5MXAS+6Fxww1cx
	 IeWdZFlqg9rzjJ/q5q/ls1aOozGCOXF1tQXSnhV8EH1cQJ8QHPJnDLzg6gJ7mDwNd5
	 78uRzSwicwXhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DA6F6067F;
	Fri, 25 Sep 2026 05:27:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E737C355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCB7F401E3
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wbaRFjzaOqQ4 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 05:27:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 23DAD40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790314037;
 b=JYFFtMnzlNhQKLuYL6zYev1XIlnhSbXQeQTIeT5gorApjSdPpoQsknFzUTdZzDma671R
 7/UEjzuvBXRXqzMfi0JHi0+DwfEkcFqZIeoxnsD7Rht9qNqxu38OUJFf7ekzseuYzz40W
 8PpKjFwVHet6JM334pYTLkF/C4hxw7Q1vP2p2xsHrRfNmGSWRjnUq+PzQeIcPO+BiJD/s
 QlQ2/qQOQK/ie4Qa4tLRjLTRMFdqtm9iaXEeWg9u+9ueJKE6Op38cXKebEyKYVm0AIZoA
 FVtx/1pct++wPHWttGpv+o3ksz/cOGNsmaAd2XW1PnGA/P37u3AesZ8MZUK5PTB7uZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790314037;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=aSRS35hOhFDIxobXU0jpShDANbJZmQZUJB+6J5nvO1I=;
 b=m1ce69hK/KGLDB/8g2ajTWXRfCImOJGEhHpNToLgIQWRWc90e8Gyym9T/Khs3Av5SrL9
 JupAh+CM9X6SIHinMqyvZ073Tw1PPVd9gJMI94vj3DO1VPQAq9z3PmkBr5mUKwFr8yF6L
 +OUdXvqRYBB3aKbsb/XuCSW/HA69VGPdgzHHICzNZctILtS8XYBJ9TCt/cYb9VR1g4i/y
 2EGDheF3h5fuy8HtwYSu5VTUYa8Sp1fKEOi8JKRj3XbOYPInf1PChxTIomYCYCM2BPsQR
 4/aVXeYPYHOPrY1498Wo3Cr7zyYLwCZbIUJfi9zgv4RoONt/T9PE7mp4f+Uu1vb+AgA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=BqUKWJIi; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=BqUKWJIi
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23DAD40079
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 05:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790313977;
 bh=aSRS35hOhFDIxobXU0jpShDANbJZmQZUJB+6J5nvO1I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BqUKWJIi5P+HbrjIv5/Uy6NMHpD6BtCPF/2rDyzv14+Jukx3JQTWDMCm6/OSF5hkQ
 MPpjd+7d1+Ek1I5QNcyJZJFbmpCFMj83aDWnKYLBeDa59tf5joKJY8vV5S6lG3fhKy
 oy/mzqzO5QgsxJNx4gjxcq4mIhRMhuNVUO+UIdQfuw/zxsbVmoCn4Y3MQoJ8AUvLmw
 Oj/AyK+6MonJhZScb6D6AtRm3z8GsQNjEbmzmCuY4jBFjuRtJKQ8j8dnb3inZdyqwZ
 lq3UjKSP7tW5eewAYb+kh06u/wraL68lOFoTXfDdtCtMyvOyI+Z/NimfCtOQ/0m+cv
 CH6ZgeGe7OF/A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 8876CB2224C9;
 Fri, 25 Sep 2026 07:26:14 +0200 (CEST)
Message-ID: <b9150c66-37f2-4348-98c4-92e5764e74bc@freeshell.de>
Date: Thu, 24 Sep 2026 22:26:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] riscv: spacemit: Add support for K3 Pico-ITX board
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu
 <junhui.liu@pigmoral.tech>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260923-00-basic-spacemit-k3-v1-0-fa1015f2cd1b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Yixun,  Add CC: Aurelien (per our chat about DMI on K3 and Debian d-i
you may find this interesting)

I have included my report of testing this series with step-by-step build
instructions, after the reply-quote. I was not successful to boot Debian
daily netinst debian-installer ramdisk. However, as an aside, I did
produce build instructions that result in the vendor u-boot v2022.10
fork with additional fixes that is successful when flashed to SPI NOR to
run netinst debian-installer and that success is measured as my baseline
for comparison. I omit my T-by tag for this series until it goes through
a few revisions and I understand better what your goals are if it should
be successful to boot and run debian-installer for example. -E

On 9/23/26 05:46, Yixun Lan wrote:
> Add initial support for SpacemiT K3 Pico-ITX board, the config file
> will enable all basic components which make it able to run into U-Boot
> serial console.
> 
> The series actually depend on previous sent patches, I'm not adding
> dependency to this series, but list it here for reference.
> 
> Pinctrl:
>  https://patch.msgid.link/20260906-pinctrl-v2-1-729da680092c@riscstar.com
>  https://patch.msgid.link/20260820-01-k3-pinctrl-support-v1-0-b54a2450c895@kernel.org
> 
> GPIO:
>  https://patch.msgid.link/20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org
> 
> clock and reset:
>  https://patch.msgid.link/20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Yixun Lan (4):
>       board: spacemit: add SpacemiT K3 Pico-ITX
>       riscv: dts: spacemit: k3: add binman node
>       configs: spacemit: Add K3 default configuration
>       doc: spacemit: k3: Add Pico-ITX board
> 
>  arch/riscv/Kconfig                       |   5 +
>  arch/riscv/cpu/k3/Kconfig                |  18 +++
>  arch/riscv/cpu/k3/Makefile               |   5 +
>  arch/riscv/cpu/k3/dram.c                 |  29 +++++
>  arch/riscv/dts/k3-u-boot.dtsi            |   6 +
>  board/spacemit/k3/Kconfig                |  30 +++++
>  board/spacemit/k3/MAINTAINERS            |   8 ++
>  board/spacemit/k3/Makefile               |   5 +
>  board/spacemit/k3/board.c                |   4 +
>  configs/spacemit_k3_defconfig            |  50 ++++++++
>  doc/board/spacemit/index.rst             |   1 +
>  doc/board/spacemit/spacemit-pico-itx.rst | 204 +++++++++++++++++++++++++++++++
>  include/configs/k3.h                     |  13 ++
>  13 files changed, 378 insertions(+)
> ---
> base-commit: 9ab84467bbbdf6a9149f6c66664c65b18c7b7f21
> change-id: 20260921-00-basic-spacemit-k3-838119645d39
> 
> Best regards,
> --  
> Yixun Lan <dlan@kernel.org>
> 

Foreword of testing notes: The build environment is a fresh Debian
"forky" (testing package archive) pbuilder chroot. References to
debian-installer files are from the unmodified daily netinst
debian-installer featuring Linux stable kernel 7.2.6 and dated
end-of-day 2022-09-18 retrieved from:
https://d-i.debian.org/daily-images/riscv64/20260918-20:52/

### Start the chroot environment for testing
sudo DIST="forky" pbuilder execute -- /bin/bash -
###

cd
dpkg --add-architecture riscv64
apt install -y bison ca-certificates flex gcc-riscv64-linux-gnu git
libgnutls28-dev libpython3-dev libssl-dev python3-setuptools swig
apt install -y bc curl lzop device-tree-compiler ssh vim less
git clone https://github.com/riscv-software-src/opensbi.git opensbi.git
git -C opensbi.git checkout 5a175017261a  # origin/master as of
end-of-day 2026-09-18
# v4 "platform: generic: spacemit: add K3 platform support"
# https://patchwork.ozlabs.org/project/opensbi/list/?series=522817
curl https://patchwork.ozlabs.org/series/522817/mbox/ | git -C
opensbi.git am
make -C opensbi.git O=../opensbi clean
make -C opensbi.git O=../opensbi CROSS_COMPILE=riscv64-linux-gnu-
PLATFORM=generic
make -C opensbi.git O=../opensbi-itb clean
make -C opensbi.git O=../opensbi-itb CROSS_COMPILE=riscv64-linux-gnu-
PLATFORM=generic FW_TEXT_START=0x10000000
git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boot.git
git -C u-boot.git checkout d677d508c9b7  # Merge tag 'v2026.10-rc5' into
next
# pinctrl: fix on Spacemit K1 SoC
# v2 https://patchwork.ozlabs.org/project/uboot/list/?series=522007
curl https://patchwork.ozlabs.org/series/522007/mbox/ | git -C u-boot.git am
# riscv: spacemit: add pinctrl support for K3 SoC
# v2 https://patchwork.ozlabs.org/project/uboot/list/?series=524932
curl https://patchwork.ozlabs.org/series/524932/mbox/ | git -C u-boot.git am
# gpio: spacemit: add support for K3 SoC
# v1 https://patchwork.ozlabs.org/project/uboot/list/?series=519731
curl https://patchwork.ozlabs.org/series/519731/mbox/ | git -C u-boot.git am
# spacemit: k3: add clock and reset support
# v2 https://patchwork.ozlabs.org/project/uboot/list/?series=524896
curl https://patchwork.ozlabs.org/series/524896/mbox/ | git -C u-boot.git am
# riscv: spacemit: Add support for K3 Pico-ITX board
# v1 https://patchwork.ozlabs.org/project/uboot/list/?series=524926
curl https://patchwork.ozlabs.org/series/524926/mbox/ | git -C u-boot.git am
# riscv: spacemit: add ethernet support for K3 SoC
# v1 https://patchwork.ozlabs.org/project/uboot/list/?series=525020
curl https://patchwork.ozlabs.org/series/525020/mbox/ | git -C u-boot.git am
# tools: mkimage: add SpacemiT K3 boot image support
# v3 https://patchwork.ozlabs.org/project/uboot/list/?series=524562
curl https://patchwork.ozlabs.org/series/524562/mbox/ | git -C u-boot.git am
# adjustment due to merge conflict of k3 platform support and mkimage
sed -i -e '/spacemit-pico-itx/i \ \ \ smtimage'
u-boot.git/doc/board/spacemit/index.rst
git -C u-boot.git add doc/board/spacemit/index.rst
git -C u-boot.git am --continue
make -C u-boot.git O=../u-boot CROSS_COMPILE=riscv64-linux-gnu-
spacemit_k3_defconfig
u-boot.git/scripts/config --file u-boot/.config --enable CMD_WGET
--enable DNS --enable NET_LWIP
make -C u-boot.git O=../u-boot CROSS_COMPILE=riscv64-linux-gnu- olddefconfig
make -C u-boot.git O=../u-boot CROSS_COMPILE=riscv64-linux-gnu-
OPENSBI=../opensbi/platform/generic/firmware/fw_dynamic.bin
git -C u-boot.git remote add -f spacemit-com
https://github.com/spacemit-com/uboot-2022.10.git
git -C u-boot.git checkout k3-br-v1.0.9
sed -i 's%compatible = "ns16550";%compatible = "spacemit,k1-uart",
"intel,xscale-uart", "ns16550";%' u-boot.git/arch/riscv/dts/k3.dtsi
git -C u-boot.git add arch/riscv/dts/k3.dtsi
git -C u-boot.git commit --no-edit -m 'dts: riscv: spacemit: k3 uart
compatible with mainline opensbi'
sed -i '/cluster[01]_frequency/{ s/<.*>/<2200000000>/ }'
u-boot.git/arch/riscv/dts/k3_spl.dts
git -C u-boot.git add arch/riscv/dts/k3_spl.dts
git -C u-boot.git commit --no-edit -m 'dts: riscv: spacemit: restore k3
cluster frequency from firmware v1.0.5'
sed -zi 's%\n#ifdef CONFIG_PHYLIB\n\tphy_init();\n#endif\n%%'
u-boot.git/net/eth_common.c
git -C u-boot.git add net/eth_common.c
git -C u-boot.git commit --no-edit -m 'prepare before cherry-pick
7e0370f37d24'
# cherry-pick 7e0370f37d24 'miiphy: define mii_devs with LIST_HEAD()'
git -C u-boot.git cherry-pick 7e0370f37d24
sed -zi
's%\(\tbootstage_mark(BOOTSTAGE_ID_NET_ETH_START);\)\n%\1\n#ifdef
CONFIG_PHYLIB\n\tphy_init();\n#endif\n%' u-boot.git/net/eth_common.c
git -C u-boot.git add net/eth_common.c
git -C u-boot.git commit --no-edit -m 'cleanup after cherry-pick
7e0370f37d24'
git -C u-boot.git rm board/spacemit/k3/k3.env
git -C u-boot.git commit --no-edit -m 'drop the creation of k3_env.txt'
make -C u-boot.git CROSS_COMPILE=riscv64-linux-gnu- k3_defconfig
make -C u-boot.git CROSS_COMPILE=riscv64-linux-gnu-
u-boot/tools/mkimage -T smtimage -n k3 -d u-boot.git/spl/u-boot-spl.bin
u-boot-spl.bin.FSBL.out
curl -LO
https://raw.githubusercontent.com/spacemit-com/opensbi/k3-br-v1.0.y/platform/generic/spacemit/fw_dynamic.its
u-boot/tools/mkimage -D "-I dts -O dtb -i
opensbi-itb/platform/generic/firmware" -f fw_dynamic.its fw_dynamic.itb
curl -LO
https://raw.githubusercontent.com/spacemit-com/buildroot-ext/k3-br-v1.0.y/board/spacemit/k3/partition_4M.json
ln u-boot/u-boot.itb mainline-u-boot.itb

ls u-boot-spl.bin.FSBL.out mainline-u-boot.itb
ls partition_4M.json fw_dynamic.itb
u-boot.git/{FSBL.bin,bootinfo_spinor.bin,u-boot-env-default.bin,u-boot.itb}

### Reset with FEL
$ fastboot stage FSBL.bin ; fastboot continue ; sleep 10
$ fastboot stage u-boot.itb ; fastboot continue ; sleep 1
$ fastboot continue
=> sf probe && sf erase 0 800000
=> fastboot usb 0
$ fastboot flash mtd partition_4M.json
$ fastboot flash bootinfo bootinfo_spinor.bin
$ fastboot flash fsbl FSBL.bin
$ fastboot flash env u-boot-env-default.bin
$ fastboot flash opensbi fw_dynamic.itb
$ fastboot flash uboot u-boot.itb
$ fastboot reboot
=> usb start
=> env set fdt_addr_r 0x138000000
=> env set kernel_addr_r 0x140000000
=> env set kernel_comp_addr_r 0x102000000
=> env set kernel_comp_size 0x20000000
=> env set ramdisk_addr_r 0x130000000
=> load usb 0:1 $fdt_addr_r device-tree/spacemit/k3-pico-itx.dtb
=> load usb 0:1 $kernel_addr_r debian-installer/riscv64/linux
=> env set filesize_kernel '0x'$filesize
=> load usb 0:1 $ramdisk_addr_r debian-installer/riscv64/initrd.gz
=> env set filesize_ramdisk '0x'$filesize
=> env set bootargs 'initrd='$ramdisk_addr_r','$filesize_ramdisk'
console=ttyS0,115200 earlycon=sbi'
=> bootefi $kernel_addr_r:$kernel_comp_size $fdt_addr_r
# specifying the actual kernel filesize doesn't work as expected, use
512MB length kernel_comp_size instead
# Baseline result outcome of above, Linux 7.2.6 boots and
debian-installer runs from initramfs successfully.

### Reset with FEL
$ fastboot stage FSBL.bin ; fastboot continue ; sleep 10
$ fastboot stage u-boot.itb ; fastboot continue ; sleep 1
$ fastboot continue
usb start
=> env set fdt_addr_r 0x138000000
=> env set kernel_addr_r 0x140000000
=> env set kernel_comp_addr_r 0x102000000
=> env set kernel_comp_size 0x20000000
=> env set ramdisk_addr_r 0x130000000
=> load usb 0:1 $fdt_addr_r device-tree/spacemit/k3-pico-itx.dtb
=> load usb 0:1 $kernel_addr_r debian-installer/riscv64/linux
=> env set filesize_kernel '0x'$filesize
=> load usb 0:1 $ramdisk_addr_r debian-installer/riscv64/initrd.gz
=> env set filesize_ramdisk '0x'$filesize
=> env set bootargs 'initrd='$ramdisk_addr_r','$filesize_ramdisk'
console=ttyS0,115200 earlycon=sbi'
=> bootefi $kernel_addr_r:$kernel_comp_size $fdt_addr_r
# specifying the actual kernel filesize doesn't work as expected, use
512MB length kernel_comp_size instead
# Negative result outcome of above:
Booting /MemoryMapped(0x0,0x140000000,0x20000000)
EFI stub: ERROR: Failed to handle fs_proto
[  96.160] Removing MTD device #0 (nor0) with use count 1

### Reset with FEL
$ fastboot stage u-boot-spl.bin.FSBL.out ; fastboot continue ; sleep 10
$ fastboot stage u-boot.itb ; fastboot continue ; sleep 1
$ fastboot continue
=> sf probe && sf erase 0 800000
=> fastboot usb 0
$ fastboot flash mtd partition_4M.json
$ fastboot flash bootinfo bootinfo_spinor.bin
$ fastboot flash fsbl u-boot-spl.bin.FSBL.out
$ fastboot flash env u-boot-env-default.bin
$ fastboot flash opensbi fw_dynamic.itb
$ fastboot flash uboot u-boot.itb
$ fastboot reboot
=> usb start
=> env set fdt_addr_r 0x138000000
=> env set kernel_addr_r 0x140000000
=> env set kernel_comp_addr_r 0x102000000
=> env set kernel_comp_size 0x20000000
=> env set ramdisk_addr_r 0x130000000
=> load usb 0:1 $fdt_addr_r device-tree/spacemit/k3-pico-itx.dtb
=> load usb 0:1 $kernel_addr_r debian-installer/riscv64/linux
=> env set filesize_kernel '0x'$filesize
=> load usb 0:1 $ramdisk_addr_r debian-installer/riscv64/initrd.gz
=> env set filesize_ramdisk '0x'$filesize
=> env set bootargs 'initrd='$ramdisk_addr_r','$filesize_ramdisk'
console=ttyS0,115200 earlycon=sbi'
=> bootefi $kernel_addr_r:$kernel_comp_size $fdt_addr_r
# specifying the actual kernel filesize doesn't work as expected, use
512MB length kernel_comp_size instead
# Positive result outcome of above, Linux 7.2.6 boots and
debian-installer runs from initramfs successfully.

### Reset with FEL
$ fastboot stage u-boot-spl.bin.FSBL.out ; fastboot continue ; sleep 10
$ fastboot stage u-boot.itb ; fastboot continue ; sleep 1
$ fastboot continue
=> usb start
=> env set fdt_addr_r 0x138000000
=> env set kernel_addr_r 0x140000000
=> env set kernel_comp_addr_r 0x102000000
=> env set kernel_comp_size 0x20000000
=> env set ramdisk_addr_r 0x130000000
=> load usb 0:1 $fdt_addr_r device-tree/spacemit/k3-pico-itx.dtb
=> load usb 0:1 $kernel_addr_r debian-installer/riscv64/linux
=> env set filesize_kernel '0x'$filesize
=> load usb 0:1 $ramdisk_addr_r debian-installer/riscv64/initrd.gz
=> env set filesize_ramdisk '0x'$filesize
=> env set bootargs 'initrd='$ramdisk_addr_r','$filesize_ramdisk'
console=ttyS0,115200 earlycon=sbi'
=> bootefi $kernel_addr_r:$kernel_comp_size $fdt_addr_r
# specifying the actual kernel filesize doesn't work as expected, use
512MB length kernel_comp_size instead
# Negative result outcome of above:
Booting /MemoryMapped(0x0,0x140000000,0x20000000)
EFI stub: ERROR: Failed to handle fs_proto
[ 128.493] Removing MTD device #0 (nor0) with use count 1

### Reset with FEL
$ fastboot stage u-boot-spl.bin.FSBL.out ; fastboot continue ; sleep 10
$ fastboot stage mainline-u-boot.itb ; fastboot continue ; sleep 1
$ python3 -m http.server 8000
=> dhcp
=> env set fdt_addr_r 0x138000000
=> env set kernel_addr_r 0x140000000
=> env set kernel_comp_addr_r 0x102000000
=> env set kernel_comp_size 0x20000000
=> env set ramdisk_addr_r 0x130000000
=> wget $fdt_addr_r http://host:8000/device-tree/spacemit/k3-pico-itx.dtb
=> wget $kernel_addr_r http://host:8000/debian-installer/riscv64/linux
=> env set filesize_kernel '0x'$filesize
=> wget $ramdisk_addr_r http://host:8000/debian-installer/riscv64/initrd.gz
=> env set filesize_ramdisk '0x'$filesize
=> env set bootargs 'initrd='$ramdisk_addr_r','$filesize_ramdisk'
console=ttyS0,115200 earlycon=sbi'
=> bootefi $kernel_addr_r:$kernel_comp_size $fdt_addr_r
# specifying the actual kernel filesize doesn't work as expected, use
512MB length kernel_comp_size instead
# Negative result outcome of above:
Cannot persist EFI variables without system partition
Booting <NULL>
EFI stub: ERROR: Failed to handle fs_proto
[    0.000000] Booting Linux on hartid 0
[    0.000000] Linux version 7.2.6+deb14-riscv64
(debian-kernel@lists.debian.org) (riscv64-linux-gnu-gcc-16 (Debian
16.2.0-2) 16.2.0, GNU ld (GNU Binutils for Debian) 2.47) #1 SMP PREEMPT
Debian 7.2.6-1 (2026-09-16)
[    0.000000] Machine model: SpacemiT K3 Pico-ITX
[    0.000000] SBI specification v3.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10009
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI DBCN extension detected
[    0.000000] SBI FWFT extension detected
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: legacy bootconsole [sbi0] enabled
[    0.000000] efi: EFI v2.11 by Das U-Boot
[    0.000000] efi: RTPROP=0x8fffd5040 SMBIOS 3.0=0x17ef51000
MEMRESERVE=0x8fffbe040
[    0.000000] secureboot: Secure boot disabled
[    0.000000] cma: Failed to reserve 128 MiB
[    0.000000] OF: reserved mem: 0x0000000100000000..0x000000010003ffff
(256 KiB) nomap non-reusable mmode_resv0@1,0
[    0.000000] OF: reserved mem: 0x0000000100040000..0x000000010007ffff
(256 KiB) nomap non-reusable mmode_resv1@1,40000
[    0.000000] NUMA: Faking a node at [mem
0x0000000100000000-0x00000008ffffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x8fff86280-0x8fff88c7f]
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfhimv
[    0.000000] riscv: ELF capabilities acdfimv
[    0.000000] Queued spinlock using Ziccrse: enabled
[    0.000000] Zone ranges:
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000010007ffff]
[    0.000000]   node   0: [mem 0x0000000100080000-0x000000017ef50fff]
[    0.000000]   node   0: [mem 0x000000017ef51000-0x000000017ef51fff]
[    0.000000]   node   0: [mem 0x000000017ef52000-0x000000017ff56fff]
[    0.000000]   node   0: [mem 0x000000017ff57000-0x000000017ff58fff]
[    0.000000]   node   0: [mem 0x000000017ff59000-0x00000008ffbfffff]
[    0.000000]   node   0: [mem 0x00000008ffc00000-0x00000008ffc00fff]
[    0.000000]   node   0: [mem 0x00000008ffc01000-0x00000008fffd4fff]
[    0.000000]   node   0: [mem 0x00000008fffd5000-0x00000008fffd5fff]
[    0.000000]   node   0: [mem 0x00000008fffd6000-0x00000008fffd6fff]
[    0.000000]   node   0: [mem 0x00000008fffd7000-0x00000008ffff7fff]
[    0.000000]   node   0: [mem 0x00000008ffff8000-0x00000008ffffafff]
[    0.000000]   node   0: [mem 0x00000008ffffb000-0x00000008ffffbfff]
[    0.000000]   node   0: [mem 0x00000008ffffc000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000100000000-0x00000008ffffffff]
[    0.000000] percpu: Embedded 33 pages/cpu s95768 r8192 d31208 u135168
[    0.000000] Kernel command line: initrd=0x130000000,0x2f7fd9b
console=ttyS0,115200 earlycon=sbi
[    0.000000] printk: log buffer data + meta data: 131072 + 557056 =
688128 bytes
[    0.000000] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 32MB
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem
0x00000008d6600000-0x00000008d8600000] (32MB)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
8388608
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 43618 entries in 172 pages
[    0.000000] ftrace: allocated 172 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=8.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] RCU Tasks Rude: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped using AIA
[    0.000000] riscv-imsic: interrupt-controller@e0400000: providing
IPIs using interrupt 1
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 64 bits at 24MHz, resolution 41ns, wraps
every 4398046511097ns
[    0.008111] riscv-timer: Timer interrupt in S-mode is available via
sstc extension
[    0.016072] Console: colour dummy device 80x25
[    0.020616] Calibrating delay loop (skipped), value calculated using
timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.030692] pid_max: default: 32768 minimum: 301
[    0.037341] landlock: Up and running.
[    0.039054] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.045942] AppArmor: AppArmor initialized
[    0.049946] TOMOYO Linux initialized
[    0.053934] LSM support for eBPF active
[    0.058226] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.065189] Mountpoint-cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.073764] VFS: Finished mounting rootfs on nullfs
[    0.080855] ASID allocator using 16 bits (65536 entries)
[    0.083577] rcu: Hierarchical SRCU implementation.
[    0.088348] rcu:     Max phase no-delay instances is 1000.
[    0.093778] Timer migration: 1 hierarchy levels; 8 children per
group; 1 crossnode level
[    0.102190] Remapping and enabling EFI services.
[    0.106797] smp: Bringing up secondary CPUs ...
[    0.114386] smp: Brought up 1 node, 8 CPUs
[    0.186102] node 0 deferred pages initialised in 68ms
[    0.188364] Memory: 32817560K/33554432K available (14124K kernel
code, 6338K rwdata, 12288K rodata, 2827K init, 682K bss, 729060K
reserved, 0K cma-reserved)
[    0.206045] devtmpfs: initialized
[    0.218929] posixtimers hash table entries: 4096 (order: 4, 65536
bytes, linear)
[    0.223500] futex hash table entries: 2048 (131072 bytes on 1 NUMA
nodes, total 128 KiB, linear).
[    0.234235] DMI: SMBIOS 3.7.0 present.
[    0.236235] DMI: spacemit SpacemiT K3 Pico-ITX/SpacemiT K3 Pico-ITX,
BIOS 2026.10-rc5-00506-g88a94d52fe5a 10/01/2026
[    0.246912] DMI: Memory slots populated: 0/0
[    0.251809] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.258379] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic
allocations
[    0.264464] audit: initializing netlink subsys (disabled)
[    0.270026] audit: type=2000 audit(0.188:1): state=initialized
audit_enabled=0 res=1
[    0.285008] thermal_sys: Registered thermal governor 'fair_share'
[    0.285018] thermal_sys: Registered thermal governor 'bang_bang'
[    0.288231] thermal_sys: Registered thermal governor 'step_wise'
[    0.294297] thermal_sys: Registered thermal governor 'user_space'
[    0.300379] thermal_sys: Registered thermal governor 'power_allocator'
[    0.306603] cpuidle: using governor ladder
[    0.317324] cpuidle: using governor menu
[    0.329552] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.333453] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.340153] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.347025] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.353373] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.360248] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.372832] ACPI: Interpreter disabled.
[    0.374099] iommu: Default domain type: Translated
[    0.378583] iommu: DMA domain TLB invalidation policy: strict mode
[    0.385586] pps_core: LinuxPPS API ver. 1 registered
[    0.389872] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.399129] PTP clock support registered
[    0.403272] efivars: Registered efivars operations
[    0.408614] NetLabel: Initializing
[    0.411371] NetLabel:  domain hash size = 128
[    0.415788] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.421549] NetLabel:  unlabeled traffic allowed by default
[    0.427390] vgaarb: loaded
[    0.429994] clocksource: Switched to clocksource riscv_clocksource
[    0.437549] VFS: Disk quotas dquot_6.6.0
[    0.440238] VFS: Dquot-cache hash table entries: 512 (4096 bytes)
[    0.446927] AppArmor: AppArmor Filesystem Enabled
[    0.451165] pnp: PnP ACPI: disabled
[    0.460312] NET: Registered PF_INET protocol family
[    0.462493] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.476469] tcp_listen_portaddr_hash hash table entries: 16384
(order: 6, 262144 bytes, linear)
[    0.482419] Table-perturb hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.490301] TCP established hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.498886] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.506310] TCP: Hash tables configured (established 262144 bind 65536)
[    0.512999] MPTCP token hash table entries: 32768 (order: 8, 786432
bytes, linear)
[    0.520522] UDP hash table entries: 16384 (order: 8, 1048576 bytes,
linear)
[    0.527796] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.533028] NET: Registered PF_XDP protocol family
[    0.553901] cpu0: scalar unaligned word access speed is 1.71x byte
access speed (fast)
[    0.553900] cpu5: scalar unaligned word access speed is 1.41x byte
access speed (fast)
[    0.553900] cpu4: scalar unaligned word access speed is 1.53x byte
access speed (fast)
[    0.553900] cpu6: scalar unaligned word access speed is 1.50x byte
access speed (fast)
[    0.553901] cpu7: scalar unaligned word access speed is 2.17x byte
access speed (fast)
[    0.553900] cpu1: scalar unaligned word access speed is 1.43x byte
access speed (fast)
[    0.553900] cpu2: scalar unaligned word access speed is 2.17x byte
access speed (fast)
[    0.553900] cpu3: scalar unaligned word access speed is 1.43x byte
access speed (fast)
[    0.631499] cpu2: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.631500] cpu0: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.631500] cpu3: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.631500] cpu1: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.631503] cpu5: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.631507] cpu6: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.631509] cpu7: vector unaligned word access speed is 4.14x byte
access speed (fast)
[    0.631509] cpu4: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.692743] PCI: CLS 0 bytes, default 64
[    0.696891] Trying to unpack rootfs image as initramfs...
[    0.698109] Initialise system trusted keyrings
[    0.706679] Key type blacklist registered
[    0.710852] workingset: timestamp_bits=44 (anon: 39) max_order=23
bucket_order=0 (anon: 0)
[    0.721558] fuse: init (API version 7.45)
[    0.723764] integrity: Platform Keyring initialized
[    0.728085] integrity: Machine keyring initialized
[    0.733000] Key type asymmetric registered
[    0.737060] Asymmetric key parser 'x509' registered
[    0.743227] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 246)
[    0.749644] io scheduler mq-deadline registered
[    0.754724] riscv-imsic: interrupt-controller@e0400000:
hart-index-bits: 4,  guest-index-bits: 6
[    0.763070] riscv-imsic: interrupt-controller@e0400000:
group-index-bits: 0, group-index-shift: 24
[    0.772144] riscv-imsic: interrupt-controller@e0400000: per-CPU IDs
511 at base address 0x00000000e0400000
[    0.781928] riscv-imsic: interrupt-controller@e0400000: total 4080
interrupts available
[    0.792895] ledtrig-cpu: registered to indicate activity on CPUs
[    0.803728] Serial: 8250/16550 driver, 6 ports, IRQ sharing disabled
[    0.811096] mousedev: PS/2 mouse device common for all mice
[    0.814525] riscv-pmu-sbi: SBI PMU extension is available
[    0.819275] riscv-pmu-sbi: 16 firmware and 18 hardware counters
[    0.826856] NET: Registered PF_INET6 protocol family
[    0.831415] Segment Routing with IPv6
[    0.833952] RPL Segment Routing with IPv6
[    0.838044] In-situ OAM (IOAM) with IPv6
[    0.842015] mip6: Mobile IPv6
[    0.844979] NET: Registered PF_PACKET protocol family
[    0.850243] mpls_gso: MPLS GSO support
[    0.859988] registered taskstats version 1
[    0.861645] Loading compiled-in X.509 certificates
[    1.078648] Freeing initrd memory: 48636K
[    1.144399] Loaded X.509 cert 'Build time autogenerated kernel key:
842aea05c03e7d1a797f7470bddc4da5e2015b8a'
[    1.158233] Demotion targets for Node 0: null
[    1.160150] Key type .fscrypt registered
[    1.163644] Key type fscrypt-provisioning registered
[    1.181142] Key type encrypted registered
[    1.182234] AppArmor: AppArmor sha256 policy hashing enabled
[    1.188002] integrity: secureboot mode disabled
[    1.192542] ima: No TPM chip found, activating TPM-bypass!
[    1.198096] ima: Allocated hash algorithm: sha256
[    1.203365] ima: No architecture policies found
[    1.207500] evm: Initialising EVM extended attributes:
[    1.212647] evm: security.selinux
[    1.216003] evm: security.SMACK64 (disabled)
[    1.220313] evm: security.SMACK64EXEC (disabled)
[    1.224980] evm: security.SMACK64TRANSMUTE (disabled)
[    1.230092] evm: security.SMACK64MMAP (disabled)
[    1.234763] evm: security.apparmor
[    1.238204] evm: security.ima
[    1.241194] evm: security.capability
[    1.244813] evm: HMAC attrs: 0x1
[    1.264829] riscv-aplic e0804000.interrupt-controller: 512 interrupts
forwarded to MSI base 0x00000000e0400000
[    1.274365] printk: legacy console [ttyS0] disabled
[    1.277165] d4017000.serial: ttyS0 at MMIO 0xd4017000 (irq = 12,
base_baud = 907421) is a XScale
[    1.285879] printk: legacy console [ttyS0] enabled
[    1.285879] printk: legacy console [ttyS0] enabled
[    1.295553] printk: legacy bootconsole [sbi0] disabled
[    1.295553] printk: legacy bootconsole [sbi0] disabled
[    1.306783] clk: Disabling unused clocks
[    1.310494] PM: genpd: Di[    1.317467] Freeing unused kernel image
(initmem) memory: 2824K
[    1.320869] Run /init as init process
[    1.648268] usbcore: registered new interface driver usbfs
[    1.651222] usbcore: registered new interface driver hub
[    1.656617] usbcore: registered new device driver usb
[    1.693421] spacemit-dwmac cac80000.ethernet: IRQ sfty not found
[    1.697139] spacemit-dwmac cac80000.ethernet: User ID: 0x10, Synopsys
ID: 0x54
[    1.704186] spacemit-dwmac cac80000.ethernet:        DWMAC4/5
[    1.709468] spacemit-dwmac cac80000.ethernet: DMA HW capability
register supported
[    1.717142] spacemit-dwmac cac80000.ethernet: Active PHY interface:
RGMII (1)
[    1.724369] spacemit-dwmac cac80000.ethernet: RX Checksum Offload
Engine supported
[    1.732038] spacemit-dwmac cac80000.ethernet: TX Checksum insertion
supported
[    1.734006] random: crng init done
[    1.739266] spacemit-dwmac cac80000.ethernet: Wake-Up On Lan supported
[    1.749438] spacemit-dwmac cac80000.ethernet: Enable RX Mitigation
via HW Watchdog Timer
[    1.757527] spacemit-dwmac cac80000.ethernet: Enabled L3L4 Flow TC
(entries=4)
[    1.764839] spacemit-dwmac cac80000.ethernet: Enabled RFS Flow TC
(entries=10)
[    1.772164] spacemit-dwmac cac80000.ethernet: Enabling HW TC
(entries=256, max_off=256)
[    1.780267] spacemit-dwmac cac80000.ethernet: TSO supported
[    1.785909] spacemit-dwmac cac80000.ethernet: TSO feature enabled
[    1.792080] spacemit-dwmac cac80000.ethernet: SPH feature enabled
[    1.798251] spacemit-dwmac cac80000.ethernet: Using 40/40 bits DMA
host/device width
[    1.892677] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.895605] xhci-hcd xhci-hcd.0.auto: new USB bus registered,
assigned bus number 1
[    1.903512] xhci-hcd xhci-hcd.0.auto: USB0 root hub has no ports
[    1.909431] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe6d hci
version 0x110 quirks 0x0000808000000010
[    1.919599] xhci-hcd xhci-hcd.0.auto: irq 16, io mem 0xc0a00000
[    1.925112] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 7.02
[    1.933474] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.933594] spacemit-dwmac cac80000.ethernet end0: renamed from eth0
[    1.940636] usb usb1: Product: xHCI Host Controller
[    1.940642] usb usb1: Manufacturer: Linux 7.2.6+deb14-riscv64 xhci-hcd
[    1.958656] usb usb1: SerialNumber: xhci-hcd.0.auto
[    1.964262] hub 1-0:1.0: USB hub found
[    1.967414] hub 1-0:1.0: 1 port detected
[    1.988689] usbcore: registered new device driver onboard-usb-dev

### Reset with FEL
$ fastboot stage u-boot-spl.bin.FSBL.out ; fastboot continue ; sleep 10
$ fastboot stage u-boot.itb ; fastboot continue ; sleep 1
$ fastboot continue
=> sf probe && sf erase 0 800000
=> fastboot usb 0
$ sleep 10
$ fastboot flash mtd partition_4M.json
$ fastboot flash bootinfo bootinfo_spinor.bin
$ fastboot flash fsbl u-boot-spl.bin.FSBL.out
$ fastboot flash env u-boot-env-default.bin
$ fastboot flash opensbi fw_dynamic.itb
$ fastboot flash uboot mainline-u-boot.itb
$ fastboot reboot
$ python3 -m http.server 8000
=> dhcp
=> env set fdt_addr_r 0x138000000
=> env set kernel_addr_r 0x140000000
=> env set kernel_comp_addr_r 0x102000000
=> env set kernel_comp_size 0x20000000
=> env set ramdisk_addr_r 0x130000000
=> wget $fdt_addr_r http://host:8000/device-tree/spacemit/k3-pico-itx.dtb
=> wget $kernel_addr_r http://host:8000/debian-installer/riscv64/linux
=> env set filesize_kernel '0x'$filesize
=> wget $ramdisk_addr_r http://host:8000/debian-installer/riscv64/initrd.gz
=> env set filesize_ramdisk '0x'$filesize
=> env set bootargs 'initrd='$ramdisk_addr_r','$filesize_ramdisk'
console=ttyS0,115200 earlycon=sbi'
=> bootefi $kernel_addr_r:$kernel_comp_size $fdt_addr_r
# specifying the actual kernel filesize doesn't work as expected, use
512MB length kernel_comp_size instead
# Negative result outcome of above:
Cannot persist EFI variables without system partition
Booting <NULL>
EFI stub: ERROR: Failed to handle fs_proto
[    0.000000] Booting Linux on hartid 0
[    0.000000] Linux version 7.2.6+deb14-riscv64
(debian-kernel@lists.debian.org) (riscv64-linux-gnu-gcc-16 (Debian
16.2.0-2) 16.2.0, GNU ld (GNU Binutils for Debian) 2.47) #1 SMP PREEMPT
Debian 7.2.6-1 (2026-09-16)
[    0.000000] Machine model: SpacemiT K3 Pico-ITX
[    0.000000] SBI specification v3.0 detected
[    0.000000] SBI implementation ID=0x1 Version=0x10009
[    0.000000] SBI TIME extension detected
[    0.000000] SBI IPI extension detected
[    0.000000] SBI RFENCE extension detected
[    0.000000] SBI SRST extension detected
[    0.000000] SBI DBCN extension detected
[    0.000000] SBI FWFT extension detected
[    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
[    0.000000] printk: legacy bootconsole [sbi0] enabled
[    0.000000] efi: EFI v2.11 by Das U-Boot
[    0.000000] efi: RTPROP=0x8fffd5040 SMBIOS 3.0=0x17ef51000
MEMRESERVE=0x8fffbe040
[    0.000000] secureboot: Secure boot disabled
[    0.000000] cma: Failed to reserve 128 MiB
[    0.000000] OF: reserved mem: 0x0000000100000000..0x000000010003ffff
(256 KiB) nomap non-reusable mmode_resv0@1,0
[    0.000000] OF: reserved mem: 0x0000000100040000..0x000000010007ffff
(256 KiB) nomap non-reusable mmode_resv1@1,40000
[    0.000000] NUMA: Faking a node at [mem
0x0000000100000000-0x00000008ffffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x8fff86280-0x8fff88c7f]
[    0.000000] SBI HSM extension detected
[    0.000000] riscv: base ISA extensions acdfhimv
[    0.000000] riscv: ELF capabilities acdfimv
[    0.000000] Queued spinlock using Ziccrse: enabled
[    0.000000] Zone ranges:
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000010007ffff]
[    0.000000]   node   0: [mem 0x0000000100080000-0x000000017ef50fff]
[    0.000000]   node   0: [mem 0x000000017ef51000-0x000000017ef51fff]
[    0.000000]   node   0: [mem 0x000000017ef52000-0x000000017ff56fff]
[    0.000000]   node   0: [mem 0x000000017ff57000-0x000000017ff58fff]
[    0.000000]   node   0: [mem 0x000000017ff59000-0x00000008ffbfffff]
[    0.000000]   node   0: [mem 0x00000008ffc00000-0x00000008ffc00fff]
[    0.000000]   node   0: [mem 0x00000008ffc01000-0x00000008fffd4fff]
[    0.000000]   node   0: [mem 0x00000008fffd5000-0x00000008fffd5fff]
[    0.000000]   node   0: [mem 0x00000008fffd6000-0x00000008fffd6fff]
[    0.000000]   node   0: [mem 0x00000008fffd7000-0x00000008ffff7fff]
[    0.000000]   node   0: [mem 0x00000008ffff8000-0x00000008ffffafff]
[    0.000000]   node   0: [mem 0x00000008ffffb000-0x00000008ffffbfff]
[    0.000000]   node   0: [mem 0x00000008ffffc000-0x00000008ffffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000100000000-0x00000008ffffffff]
[    0.000000] percpu: Embedded 33 pages/cpu s95768 r8192 d31208 u135168
[    0.000000] Kernel command line: initrd=0x130000000,0x2f7fd9b
console=ttyS0,115200 earlycon=sbi
[    0.000000] printk: log buffer data + meta data: 131072 + 557056 =
688128 bytes
[    0.000000] Dentry cache hash table entries: 4194304 (order: 13,
33554432 bytes, linear)
[    0.000000] Inode-cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.000000] software IO TLB: SWIOTLB bounce buffer size adjusted to 32MB
[    0.000000] software IO TLB: area num 8.
[    0.000000] software IO TLB: mapped [mem
0x00000008d6600000-0x00000008d8600000] (32MB)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
8388608
[    0.000000] Policy zone: Normal
[    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 43618 entries in 172 pages
[    0.000000] ftrace: allocated 172 pages with 4 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to
nr_cpu_ids=8.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000]  Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] RCU Tasks: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] RCU Tasks Rude: Setting shift to 3 and lim to 1
rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] riscv-intc: 64 local interrupts mapped using AIA
[    0.000000] riscv-imsic: interrupt-controller@e0400000: providing
IPIs using interrupt 1
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.000000] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff
max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 64 bits at 24MHz, resolution 41ns, wraps
every 4398046511097ns
[    0.008111] riscv-timer: Timer interrupt in S-mode is available via
sstc extension
[    0.016074] Console: colour dummy device 80x25
[    0.020618] Calibrating delay loop (skipped), value calculated using
timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.030693] pid_max: default: 32768 minimum: 301
[    0.037348] landlock: Up and running.
[    0.039055] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.045941] AppArmor: AppArmor initialized
[    0.049945] TOMOYO Linux initialized
[    0.053933] LSM support for eBPF active
[    0.058228] Mount-cache hash table entries: 65536 (order: 7, 524288
bytes, linear)
[    0.065190] Mountpoint-cache hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.073767] VFS: Finished mounting rootfs on nullfs
[    0.080862] ASID allocator using 16 bits (65536 entries)
[    0.083579] rcu: Hierarchical SRCU implementation.
[    0.088348] rcu:     Max phase no-delay instances is 1000.
[    0.093779] Timer migration: 1 hierarchy levels; 8 children per
group; 1 crossnode level
[    0.102189] Remapping and enabling EFI services.
[    0.106806] smp: Bringing up secondary CPUs ...
[    0.114379] smp: Brought up 1 node, 8 CPUs
[    0.190073] node 0 deferred pages initialised in 72ms
[    0.192301] Memory: 32817560K/33554432K available (14124K kernel
code, 6338K rwdata, 12288K rodata, 2827K init, 682K bss, 729060K
reserved, 0K cma-reserved)
[    0.210016] devtmpfs: initialized
[    0.222861] posixtimers hash table entries: 4096 (order: 4, 65536
bytes, linear)
[    0.227433] futex hash table entries: 2048 (131072 bytes on 1 NUMA
nodes, total 128 KiB, linear).
[    0.238154] DMI: SMBIOS 3.7.0 present.
[    0.240168] DMI: spacemit SpacemiT K3 Pico-ITX/SpacemiT K3 Pico-ITX,
BIOS 2026.10-rc5-00506-g88a94d52fe5a 10/01/2026
[    0.250846] DMI: Memory slots populated: 0/0
[    0.255738] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.261964] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic
allocations
[    0.268399] audit: initializing netlink subsys (disabled)
[    0.273960] audit: type=2000 audit(0.192:1): state=initialized
audit_enabled=0 res=1
[    0.288932] thermal_sys: Registered thermal governor 'fair_share'
[    0.288942] thermal_sys: Registered thermal governor 'bang_bang'
[    0.292155] thermal_sys: Registered thermal governor 'step_wise'
[    0.298221] thermal_sys: Registered thermal governor 'user_space'
[    0.304303] thermal_sys: Registered thermal governor 'power_allocator'
[    0.310534] cpuidle: using governor ladder
[    0.321249] cpuidle: using governor menu
[    0.333525] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.337430] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.344129] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.351002] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.357349] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.364225] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.376764] ACPI: Interpreter disabled.
[    0.378016] iommu: Default domain type: Translated
[    0.382515] iommu: DMA domain TLB invalidation policy: strict mode
[    0.389517] pps_core: LinuxPPS API ver. 1 registered
[    0.393804] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.403061] PTP clock support registered
[    0.407209] efivars: Registered efivars operations
[    0.412530] NetLabel: Initializing
[    0.415304] NetLabel:  domain hash size = 128
[    0.419720] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.425481] NetLabel:  unlabeled traffic allowed by default
[    0.431326] vgaarb: loaded
[    0.433925] clocksource: Switched to clocksource riscv_clocksource
[    0.441476] VFS: Disk quotas dquot_6.6.0
[    0.444171] VFS: Dquot-cache hash table entries: 512 (4096 bytes)
[    0.450869] AppArmor: AppArmor Filesystem Enabled
[    0.455100] pnp: PnP ACPI: disabled
[    0.464253] NET: Registered PF_INET protocol family
[    0.466437] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    0.480421] tcp_listen_portaddr_hash hash table entries: 16384
(order: 6, 262144 bytes, linear)
[    0.486366] Table-perturb hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.494251] TCP established hash table entries: 262144 (order: 9,
2097152 bytes, linear)
[    0.502836] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    0.510259] TCP: Hash tables configured (established 262144 bind 65536)
[    0.516948] MPTCP token hash table entries: 32768 (order: 8, 786432
bytes, linear)
[    0.524485] UDP hash table entries: 16384 (order: 8, 1048576 bytes,
linear)
[    0.531734] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.536976] NET: Registered PF_XDP protocol family
[    0.557851] cpu0: scalar unaligned word access speed is 1.39x byte
access speed (fast)
[    0.557850] cpu2: scalar unaligned word access speed is 1.41x byte
access speed (fast)
[    0.557850] cpu1: scalar unaligned word access speed is 1.45x byte
access speed (fast)
[    0.557851] cpu5: scalar unaligned word access speed is 1.41x byte
access speed (fast)
[    0.557851] cpu4: scalar unaligned word access speed is 1.41x byte
access speed (fast)
[    0.557850] cpu6: scalar unaligned word access speed is 1.41x byte
access speed (fast)
[    0.557851] cpu7: scalar unaligned word access speed is 1.45x byte
access speed (fast)
[    0.557851] cpu3: scalar unaligned word access speed is 1.78x byte
access speed (fast)
[    0.635473] cpu2: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.635475] cpu3: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.635476] cpu1: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.635486] cpu5: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.635486] cpu6: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.635488] cpu0: vector unaligned word access speed is 4.14x byte
access speed (fast)
[    0.635490] cpu4: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.635491] cpu7: vector unaligned word access speed is 4.15x byte
access speed (fast)
[    0.696721] PCI: CLS 0 bytes, default 64
[    0.700863] Trying to unpack rootfs image as initramfs...
[    0.702059] Initialise system trusted keyrings
[    0.710653] Key type blacklist registered
[    0.714808] workingset: timestamp_bits=44 (anon: 39) max_order=23
bucket_order=0 (anon: 0)
[    0.725534] fuse: init (API version 7.45)
[    0.727747] integrity: Platform Keyring initialized
[    0.732056] integrity: Machine keyring initialized
[    0.736976] Key type asymmetric registered
[    0.741038] Asymmetric key parser 'x509' registered
[    0.747210] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 246)
[    0.753606] io scheduler mq-deadline registered
[    0.761046] riscv-imsic: interrupt-controller@e0400000:
hart-index-bits: 4,  guest-index-bits: 6
[    0.767071] riscv-imsic: interrupt-controller@e0400000:
group-index-bits: 0, group-index-shift: 24
[    0.776147] riscv-imsic: interrupt-controller@e0400000: per-CPU IDs
511 at base address 0x00000000e0400000
[    0.785934] riscv-imsic: interrupt-controller@e0400000: total 4080
interrupts available
[    0.796839] ledtrig-cpu: registered to indicate activity on CPUs
[    0.807712] Serial: 8250/16550 driver, 6 ports, IRQ sharing disabled
[    0.815095] mousedev: PS/2 mouse device common for all mice
[    0.818517] riscv-pmu-sbi: SBI PMU extension is available
[    0.823266] riscv-pmu-sbi: 16 firmware and 18 hardware counters
[    0.830815] NET: Registered PF_INET6 protocol family
[    0.835429] Segment Routing with IPv6
[    0.837964] RPL Segment Routing with IPv6
[    0.842036] In-situ OAM (IOAM) with IPv6
[    0.846008] mip6: Mobile IPv6
[    0.848973] NET: Registered PF_PACKET protocol family
[    0.854230] mpls_gso: MPLS GSO support
[    0.864071] registered taskstats version 1
[    0.865738] Loading compiled-in X.509 certificates
[    1.082340] Freeing initrd memory: 48636K
[    1.148139] Loaded X.509 cert 'Build time autogenerated kernel key:
842aea05c03e7d1a797f7470bddc4da5e2015b8a'
[    1.161876] Demotion targets for Node 0: null
[    1.163785] Key type .fscrypt registered
[    1.167282] Key type fscrypt-provisioning registered
[    1.184620] Key type encrypted registered
[    1.185699] AppArmor: AppArmor sha256 policy hashing enabled
[    1.191488] integrity: secureboot mode disabled
[    1.196027] ima: No TPM chip found, activating TPM-bypass!
[    1.201578] ima: Allocated hash algorithm: sha256
[    1.206831] ima: No architecture policies found
[    1.210980] evm: Initialising EVM extended attributes:
[    1.216121] evm: security.selinux
[    1.219480] evm: security.SMACK64 (disabled)
[    1.223804] evm: security.SMACK64EXEC (disabled)
[    1.228464] evm: security.SMACK64TRANSMUTE (disabled)
[    1.233577] evm: security.SMACK64MMAP (disabled)
[    1.238246] evm: security.apparmor
[    1.241679] evm: security.ima
[    1.244683] evm: security.capability
[    1.248296] evm: HMAC attrs: 0x1
[    1.268852] riscv-aplic e0804000.interrupt-controller: 512 interrupts
forwarded to MSI base 0x00000000e0400000
[    1.278465] printk: legacy console [ttyS0] disabled
[    1.281174] d4017000.serial: ttyS0 at MMIO 0xd4017000 (irq = 12,
base_baud = 907421) is a XScale
[    1.289912] printk: legacy console [ttyS0] enabled
[    1.289912] printk: legacy console [ttyS0] enabled
[    1.299589] printk: legacy bootconsole [sbi0] disabled
[    1.299589] printk: legacy bootconsole [sbi0] disabled
[    1.310763] clk: Disabling unused clocks
[    1.314542] PM: genpd: Di[    1.321531] Freeing unused kernel image
(initmem) memory: 2824K
[    1.324934] Run /init as init process
[    1.653984] usbcore: registered new interface driver usbfs
[    1.656920] usbcore: registered new interface driver hub
[    1.662321] usbcore: registered new device driver usb
[    1.709947] random: crng init done
[    1.717194] spacemit-dwmac cac80000.ethernet: IRQ sfty not found
[    1.720892] spacemit-dwmac cac80000.ethernet: User ID: 0x10, Synopsys
ID: 0x54
[    1.727946] spacemit-dwmac cac80000.ethernet:        DWMAC4/5
[    1.733227] spacemit-dwmac cac80000.ethernet: DMA HW capability
register supported
[    1.740894] spacemit-dwmac cac80000.ethernet: Active PHY interface:
RGMII (1)
[    1.748127] spacemit-dwmac cac80000.ethernet: RX Checksum Offload
Engine supported
[    1.755799] spacemit-dwmac cac80000.ethernet: TX Checksum insertion
supported
[    1.763028] spacemit-dwmac cac80000.ethernet: Wake-Up On Lan supported
[    1.769697] spacemit-dwmac cac80000.ethernet: Enable RX Mitigation
via HW Watchdog Timer
[    1.777846] spacemit-dwmac cac80000.ethernet: Enabled L3L4 Flow TC
(entries=4)
[    1.785156] spacemit-dwmac cac80000.ethernet: Enabled RFS Flow TC
(entries=10)
[    1.792483] spacemit-dwmac cac80000.ethernet: Enabling HW TC
(entries=256, max_off=256)
[    1.800591] spacemit-dwmac cac80000.ethernet: TSO supported
[    1.806226] spacemit-dwmac cac80000.ethernet: TSO feature enabled
[    1.812398] spacemit-dwmac cac80000.ethernet: SPH feature enabled
[    1.818570] spacemit-dwmac cac80000.ethernet: Using 40/40 bits DMA
host/device width
[    1.910488] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    1.913409] xhci-hcd xhci-hcd.0.auto: new USB bus registered,
assigned bus number 1
[    1.921371] xhci-hcd xhci-hcd.0.auto: USB0 root hub has no ports
[    1.929963] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220fe6d hci
version 0x110 quirks 0x0000808000000010
[    1.936924] xhci-hcd xhci-hcd.0.auto: irq 16, io mem 0xc0a00000
[    1.937182] spacemit-dwmac cac80000.ethernet end0: renamed from eth0
[    1.942988] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 7.02
[    1.957903] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    1.964975] usb usb1: Product: xHCI Host Controller
[    1.969910] usb usb1: Manufacturer: Linux 7.2.6+deb14-riscv64 xhci-hcd
[    1.976544] usb usb1: SerialNumber: xhci-hcd.0.auto
[    1.981829] hub 1-0:1.0: USB hub found
[    1.985281] hub 1-0:1.0: 1 port detected
[    2.005405] usbcore: registered new device driver onboard-usb-dev

### End of testing environment
### End of mainline u-boot K3 platform testing report by E Shattow

