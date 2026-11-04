Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFA5606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g4KzJPsp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=i6XBUKmQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69F5280D6F;
	Wed,  4 Nov 2026 04:32:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BL5AztTIyrJx; Wed,  4 Nov 2026 04:32:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E17380D4A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793766751;
	bh=RXE3taeUMxI6NMhgGys8cfcr+vSbY+W/nErl+i5IsWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g4KzJPspJ6v8j3Uo13tgIrgsPcC7PAk6+c3QcItJmVzGPEOUDDlJk/DVndbQpfOaT
	 HlpMn/Rix7WoDQlRQsRGkBVUFnaaU8gyiSsJ6yt6rp764t9uZNwhYYKk/Pz1RlVkJT
	 XH6DcqkjL6XDh2ygsexLQFyRmcvU95Fv43cbW3pfBIHB8amCxjeJEWFK/AdGbTEHSi
	 UTWjlCnXW4FPL2spEyp74xzNqj4Vv6Q8wt3aQnO3/kb8xkcSaJg2YjoYMQJAzy0wyB
	 dT6W7JTlAgcFXi1MvsBGjKId/CvnlBIJYrwiqsCc6M38oWakge+9GT5N+AQqbNXjqf
	 T5UTJJZ0dzw/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E17380D4A;
	Wed,  4 Nov 2026 04:32:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49E0D2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2FCD980D4A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u678aMfW6Cv1 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2337D80D32
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793766749;
 b=G2rhAqWCHiJQ2Yh7W1krZuHUWHbHFJpvLfwCFPW9OIt9rItq/9c3CODn1xgRfJtrliwv
 Jk79Lq+AD3pcYOVEgp4QLI5fG7WCg92UvjZEeILNCt2ed2MJWx6z+XWL+F+mUcwf0WAtk
 BD80Z+fyaBL+Vb4XbM3ET3ESf0qniHz2Adb80ILcQf4tH6zlL/P2RQ3T3V4ytC1tEZ9ib
 m+hF13eYN6zLIdrlQUCIn0lOyZzrKWdUh8l5i6qGkxaVNDamAv7l1pEJrl1ZRjVW8pZbB
 u51JuvhTBVfS/8H74hizHjBclb0wV++jR+ImEqYYSJYHi6h9v/nFfNLprlAAflrS2+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793766749;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=RXE3taeUMxI6NMhgGys8cfcr+vSbY+W/nErl+i5IsWw=;
 b=EpjvHoJY0mlPP6ZlwyGM4oNRSrhFa1clM3MqhLuC8syS4AYus2zO1gd4HOzfllSm6qEG
 OOlcFd+mIlsD4dGwgItFT3VPhrfmA4ieM2u5IKAlpz9CL7wQjSmkBIvY3qA2KWKIr0DrV
 EMnErc3OaG/WTdxTs0DTRixTSXFXH2kc84UfSn0w91cQCjLYYEFUQwwrG4CeHnAP4qAXZ
 sgG/fAEK/LUN0nDPEfvjP0V6EV2ZoGpH4gTDbIb5h0b3CiGxjZTcRAzc/glHmUErptspA
 omKqnM1C9xuYrHAe//QGV0BXmc+afYuwuk4DF0A2heWf5EZDRUyRonk8h+72p/03NoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=i6XBUKmQ; 
 arc=fail smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=i6XBUKmQ
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2337D80D32
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:32:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793766728; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RlgfdlRIZOm8iQNPvTf+Naf5vZpZjRGSWV2iW9SLuE3CcWpFShR+q061DKZDouMdCZh6AbGeYW0XLjNFbY9btoyGQn8NNvGSPrCsxyzEWVtd2oPVuA/hUf31Y1kJJzoRFIID7xwnC4fd+n1YJhA/MAuNbXE32Urw0IVh47P1q40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793766728;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GPTwzHEgqSTNAGyyKUIpWAkOMTMzA3qaQuassC/Fr+o=; 
 b=e51NK+1IM1GioHbYM46xJn2WG4FuocXOaxEzaoRrbVujsYrCyKtEzGnuXipNBcZcRkaUCkREmtCJCupsYnoFGF+hhVG7sSPt3OILLIvAqoAGiun1EbRLUAFRssLasjS9/ImBuwyeo/eIUwTi2KoAEv6VPlwRQ7Fie8iulRxTc7s=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=i6XBUKmQS7ssVDQtTTjPd02Rv5mFSFFESmCktZ3lgF5BGcKX6nEqAG0iOwOtF01SQFDZBryBR8QEHM5m3GxPCynf10+rtq3GE6a+VKEvwHxKOexjjFBJupoOW2oonjC3ZVFJWJGMGJkgj0yGLkdyv1SzH0+pbeBD/24YZZsd1Cc=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=RXE3taeUMxI6NMhgGys8cfcr+vSbY+W/nErl+i5IsWw=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793766725929879.2318426118335;
 Tue, 3 Nov 2026 20:32:05 -0800 (PST)
Date: Wed, 4 Nov 2026 04:31:57 +0000
From: Yao Zi <me@ziyao.cc>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>,
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@kernel.org>,
 Andrei Lalaev <andrey.lalaev@gmail.com>, E Shattow <e@freeshell.de>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH v2 2/2] board: sophgo: Add support for Milk-V Duo S
Message-ID: <auq1Pf0xDMoxRpXR@pie>
References: <20261025-upstream-v1-milk-duo-s-v2-0-192b68915c92@gmail.com>
 <20261025-upstream-v1-milk-duo-s-v2-2-192b68915c92@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261025-upstream-v1-milk-duo-s-v2-2-192b68915c92@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.744.82
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 11:30:24AM -0300, João Paulo Gonçalves wrote:
> Add support for the Milk-V Duo S, a development board based on the
> Sophgo SG2000 SoC with 512 MiB of RAM.
> 
> The SG2000 differs from the CV1800B used on the Milk-V Duo 64M and the
> SG2002 used on the Milk-V Duo 256M, but these SoCs share most of their
> IP blocks, including the CPU core, so the existing CV1800B support can
> be reused.
> 
> Add a separate board directory, target and defconfig for the Duo S,
> based on the Milk-V Duo 256M ones. Like the Duo 256M, it reuses the
> common Milk-V Duo board code. The defconfig uses the upstream devicetree
> via OF_UPSTREAM.
> 
> Link: https://milkv.io/docs/duo/getting-started/duos
> Acked-by: Andrei Lalaev <andrey.lalaev@gmail.com>
> Acked-by: Hiago De Franco <hfranco@baylibre.com>
> Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> ---
>  arch/riscv/Kconfig                       |   4 +
>  board/sophgo/milkv_duo_s/Kconfig         |  30 +++++++
>  board/sophgo/milkv_duo_s/MAINTAINERS     |   8 ++
>  board/sophgo/milkv_duo_s/Makefile        |   6 ++
>  board/sophgo/milkv_duo_s/milkv_duo_s.env |   8 ++
>  configs/milkv_duo_s_defconfig            |  43 ++++++++++
>  doc/board/sophgo/index.rst               |   1 +
>  doc/board/sophgo/milkv_duo_s.rst         | 131 +++++++++++++++++++++++++++++++

Please separate documentation changes into another commit.

>  include/configs/milkv_duo_s.h            |  12 +++
>  9 files changed, 243 insertions(+)

...

> diff --git a/configs/milkv_duo_s_defconfig b/configs/milkv_duo_s_defconfig
> new file mode 100644
> index 000000000000..41a31c4ad46c
> --- /dev/null
> +++ b/configs/milkv_duo_s_defconfig
> @@ -0,0 +1,43 @@
> +CONFIG_RISCV=y
> +CONFIG_SYS_MALLOC_LEN=0x820000
> +CONFIG_SYS_MALLOC_F_LEN=0x8000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
> +CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2000-milkv-duo-s"
> +CONFIG_SYS_LOAD_ADDR=0x80080000
> +CONFIG_IDENT_STRING=" milkv_duo_s"
> +CONFIG_TARGET_MILKV_DUO_S=y
> +CONFIG_ARCH_RV64I=y
> +CONFIG_RISCV_SMODE=y
> +CONFIG_FIT=y
> +CONFIG_BOOTSTD_FULL=y
> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
> +CONFIG_SD_BOOT=y
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_PBSIZE=544
> +CONFIG_SYS_PROMPT="milkv_duo_s# "
> +# CONFIG_CMD_BOOTDEV is not set
> +CONFIG_CMD_MBR=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_POWEROFF=y
> +# CONFIG_CMD_MII is not set
> +CONFIG_CMD_EXT4_WRITE=y
> +# CONFIG_ISO_PARTITION is not set
> +# CONFIG_EFI_PARTITION is not set

Personally speaking, I prefer to turn on EFI related stuff
(BOOTMETH_EFI_BOOTMGR and EFI_PARTITION). Here EFI is more practical
since Duo-S carries 512MiB RAM, and I do have a device booted through
EFI.

But anyway, it's a embedded device and takes forever to boot a generic
distribution, so what you've done here is fine, too.

...

> diff --git a/doc/board/sophgo/index.rst b/doc/board/sophgo/index.rst
> index 19c9a19b1d4b..61aceafceea3 100644
> --- a/doc/board/sophgo/index.rst
> +++ b/doc/board/sophgo/index.rst
> @@ -7,4 +7,5 @@ Sophgo
>  
>     milkv_duo
>     milkv_duo_256m
> +   milkv_duo_s
>     licheerv_nano
> diff --git a/doc/board/sophgo/milkv_duo_s.rst b/doc/board/sophgo/milkv_duo_s.rst
> new file mode 100644
> index 000000000000..9f6bf04d1842
> --- /dev/null
> +++ b/doc/board/sophgo/milkv_duo_s.rst

...

> +Boot flow
> +~~~~~~~~~
> +The board boots from a FIP image, fip.bin, which contains the following
> +binaries:
> +
> +- FSBL (First Stage Boot Loader): the vendor bootloader [1]. It serves the
> +  same purpose as U-Boot SPL, but U-Boot does not support SPL for this SoC
> +  yet, so the vendor FSBL is required.
> +- Coprocessor firmware: the vendor firmware (cvirtos.bin) or custom firmware
> +  for the C906L coprocessor. It is not needed to boot U-Boot, but it is
> +  required by fiptool.

Please confirm whether this is correct. I remembered the coprocessor
firmware is optional, too.

> +- OpenSBI (fw_dynamic.bin), built with the board devicetree.
> +- U-Boot (u-boot.bin).

...

> +5. Set the board's boot core selection switch to RISC-V.

It'll be nice to describe the exact position of the switch.

...

Regards,
Yao Zi
