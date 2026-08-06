Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A322C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 14:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C07BF80E1F;
	Thu,  6 Aug 2026 14:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aomC2FUSKYEq; Thu,  6 Aug 2026 14:23:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA76580C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786026231;
	bh=gg7tUD7Pvfz5KaiBFSbrzzPpEq1pvJ9vF9CEEOlBf6Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkOB7TW1taYyOMpZctJNQgxrrTEnWlAy/AHmw2PoCdYR+PZCiW4vZqFh4LrdWJk56
	 2fReKSQgxIQyPEP+rMQ5UOoee+J6GTSLhwm8Lt4EAKXcskYlknqDN1e/vXPcx7b3EQ
	 cvekoApBYdPxCD8HCLRe9zqlBj7Q2yypyy1bsus4Ie/9o/5KW5tpJVyCxG6pqDsN4T
	 UkufAP608P3BKmPSXkwSjKkWHDFd91/QPLYeHxAwU4UuheYW5vr3RnOD1Tuk6/YXT7
	 vZ15Sgjlsjf59DOiqJVBawq2jbZT/mAlSpkLQctFbtoaRri3glCoDU46tWcGPGj6ZC
	 T+t1BNu56jxOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA76580C74;
	Thu,  6 Aug 2026 14:23:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B4A392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B74A24017B
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XQ3Y80xR6Qqv for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 14:23:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.12;
 helo=sender4-op-o12.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7EB8940112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EB8940112
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EB8940112
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786026203; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IuaO2DF0P5swtCuEZu7TIP7+44nToBgT4g7n7zTlTItDQeKm6BqFFxIZv5wsFLMY9MkkCpJEWsxbtIZyvNaXBb68i/i6rjJpPWzyofTTdB8ds+dTa0WFDYAhI09dk5Mg99hn0WdhgBAEAi4K09xZ+OqiZwDjQOVSorBaEnKcrnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786026203;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gg7tUD7Pvfz5KaiBFSbrzzPpEq1pvJ9vF9CEEOlBf6Q=; 
 b=du+8KNIEcDeAPvUBkonjvHQ9oCYzqPzEBP8zwA5ttXE3ek6oYTj0bs2TwXaIm12HaAWIlMgArzktXvh163DWj3Rhvc2UpSNI8NPXaBWD4qv2KVfD05vsZmEh9HnvDqqtJL/G9zfNEqbxAPJfKNg3HNR8gX59bLGdxnXHnrmjw+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
Received: by mx.zohomail.com with SMTPS id 1786026192715353.4361692909622;
 Thu, 6 Aug 2026 07:23:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 22:22:58 +0800
Message-Id: <DKHXFVMFCMQU.310RT6O8UWOVW@pigmoral.tech>
Cc: "Lukasz Majewski" <lukma@denx.de>, "Tom Rini" <trini@konsulko.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Stefan Roese" <stefan.roese@mailbox.org>, "Hiago De Franco"
 <hfranco@baylibre.com>, "Thomas Bonnefille"
 <thomas.bonnefille@bootlin.com>, "Kongyang Liu"
 <seashell11234455@gmail.com>, "Tim Ouyang" <tim609@andestech.com>, "Leo
 Liang" <leo.liang@sifive.com>, "Guodong Xu" <guodong@riscstar.com>,
 "Andreas Schwab" <schwab@suse.de>, "Junhui Liu" <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v3 4/7] riscv: milkv_duo: Use upstream devicetree
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Zhuxu Ran" <zhuxu_ran@zohomail.com>, <u-boot@lists.u-boot-project.org>,
 "Yao Zi" <me@ziyao.cc>
X-Mailer: aerc 0.21.0
References: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
 <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
X-ZohoMailClient: External
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786026203; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=gg7tUD7Pvfz5KaiBFSbrzzPpEq1pvJ9vF9CEEOlBf6Q=;
 b=YDbWtSi47nfhivBDEEfzp6q9hBwluAWFjUhJrTH7OXDjqA8GRBqgL9SpyEJgVDMU
 6IK8SzCZHoKV3sRxxmXnVhBvBpF9B4Mb8sW55u6+42t+E4lPKbTJbh3+785tnMIBUds
 7BATsD6s2J57J4+M7UPz3+dshEl77oBwTqUHbcG4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=pigmoral.tech
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=YDbWtSi4
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

Hi Zhuxu,

On Thu Aug 6, 2026 at 8:13 PM CST, Zhuxu Ran wrote:
> Switch Milk-V Duo to the upstream CV1800B devicetree by enabling
> CONFIG_OF_UPSTREAM and selecting sophgo/cv1800b-milkv-duo.
>
> The upstream devicetree keeps the Ethernet MAC disabled and does not
> describe the CV1800B SPIF controller. Add U-Boot overrides to preserve
> the existing networking and SPI NOR support.
>
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi | 36 ++++++++++++++++++++++=
++++++
>  board/sophgo/milkv_duo/MAINTAINERS           |  1 +
>  configs/milkv_duo_defconfig                  |  3 ++-
>  3 files changed, 39 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo/=
MAINTAINERS
> index 651a0592f7a..a6ff5585240 100644
> --- a/board/sophgo/milkv_duo/MAINTAINERS
> +++ b/board/sophgo/milkv_duo/MAINTAINERS
> @@ -4,3 +4,4 @@ S:	Maintained
>  F:	board/sophgo/milkv_duo/
>  F:	configs/milkv_duo_defconfig
>  F:	doc/board/sophgo/milkv_duo.rst
> +F:	arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi

How about sorting these alphabetically?

> diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
> index f1f3930564b..9d6b80362d5 100644
> --- a/configs/milkv_duo_defconfig
> +++ b/configs/milkv_duo_defconfig
> @@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x8000
>  CONFIG_NR_DRAM_BANKS=3D1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x82300000
> -CONFIG_DEFAULT_DEVICE_TREE=3D"cv1800b-milkv-duo"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"sophgo/cv1800b-milkv-duo"
> +CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x80080000
>  CONFIG_IDENT_STRING=3D"milkv_duo"
>  CONFIG_TARGET_MILKV_DUO=3Dy

--=20
Best regards,
Junhui Liu

