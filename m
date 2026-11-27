Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30597606A691
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j1eouA7c;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=Yh9mUpvV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 842CF81226;
	Fri, 27 Nov 2026 10:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GSRpLzUJHi_U; Fri, 27 Nov 2026 10:56:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CABF81206
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795776987;
	b=oEctO5ojq5JTNVBeGArMhu6BSKkeJgNxcqrH7ERvtE3OkoLv8GVDjS+FYX3nBKoZ+M6+
	 DyysHak/i00DJk70bowSFbobVY3YHSG1Ua527kih3UO1u9ezNQKzw0aFG9+zo4eMT7Ix2
	 5bps3qjg/fLmDyqSJ8cSvnF7YT9qCBJpiaMSP9hS6lb3ZTbcxyuRvotVAiRWC2QQESJXO
	 TA+EAgw2ejF7kFu7sL7w1ETm8fl+6NWoxbEqSqk19SKBMgAUfFI/q8GETKk+/UnzNVgis
	 cAkYSk8bXS00toMBdCfulzg7ZzjU7wa7ykcCHaUrnTYv6mQgNeAvtHVJuLabSLY6zxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795776987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ojS4Zw+mldXbgIQdnSObjh1YtcqF4zQ2uzqDLUfV+QY=;
	b=C7+5JKML1vQVJXxW+8j3+O1HeHo02i5IKj6B9FYusxUCCfAwQaJxbBifzezzSvBzC1zo
	 mQnTPp/a0Vm2j8Dx7EaJzKdSC0KqfzaGUYEpEjOGyK1CIYEDQAMNgTo7aMZnbj4nEiYHF
	 hlUb+6QlPFdHeztU1AAwU0DUVBI9aGFoyUIwMSJDGZIMQ9zjrLjlOyD+UNupWWHOFl4kF
	 N21IU8IyGnG7ihEzj9yFAt55xYwJIlSO+9ZTz0gtsHNNmpq8IR3ydVH963NGXCe2v6FnD
	 F6xxdk8jW87n98urvy9zDwKSvz7R7V61GFh8dioZyAML+XIoE8RILhUGM50CHMgGAnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795776987;
	bh=ojS4Zw+mldXbgIQdnSObjh1YtcqF4zQ2uzqDLUfV+QY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j1eouA7ckeJ+0aL+aTuKq3m5Z8CYSAlvg47FvkdTdxLskZ4aL648lUdbYWqmTkSdL
	 DrrXA4uPGB2NbEj4epy1nNQJk+ItiAu/2GAPNIuAal8qKNFZQjpijynR1e/jgbm50D
	 oGn3qPKgxYOE4kRiB0+tnSh8RRAPqFByWyVLjHDV1H+7yzkRPz07pCpbvCOEogjEdN
	 oMvCAoOVIGMU+BccW/yAgD6lLyHE/hmGO6M6n4RHA72yUkMkrVZcphkCD/sQCkqH7v
	 l0VWLWjtwikXeQg3YF/15ywEoU0gOzlgHGNoAvW3NkWjlPxDveq7ImAPsRMBRqxNLP
	 DWz/r9HATUFgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CABF81206;
	Fri, 27 Nov 2026 10:56:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D962266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73B834008B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:56:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OueXXQjRRuDl for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:56:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 55FA04004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=Yh9mUpvV
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55FA04004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795776927;
 bh=ojS4Zw+mldXbgIQdnSObjh1YtcqF4zQ2uzqDLUfV+QY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Yh9mUpvV/0l0DErvcFoorF3c+w0MuOTTkzI4vydkZ06urlyqGYiwPd0meGdsY7L+8
 ypU3gduFmeh7lWIQggZn+D7ZHWMG8kpuaArwajgewxnG45VRa23BFPNo4qx4VKH/ka
 UdUzuS5rRVmaolqs0qSzcUGKvvepzNWYelZeUImjDaoQvjnSBdMN1BSy5XUDS3HWvS
 /297Ko3aFLQ2MUunNuVGFDshupdmhTarBfKu9+EmHzH3zBbU2zJ8MoG0Qm4UVWJFvj
 js8/1au8V/jbjumfb4i8h3cY1q6fzcWQr/5qaOdAgEygIMAMvw4mDRRj5OREXkeA7z
 /Ae1VTXrVbYmQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9F56FB220384;
 Fri, 27 Nov 2026 11:55:24 +0100 (CET)
Message-ID: <ff1da8c1-0265-4f9c-b116-35c1d78e2ab7@freeshell.de>
Date: Fri, 27 Nov 2026 02:55:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] riscv: dts: spacemit: k1: Move common U-Boot
 nodes to shared DTSI
To: Anand Moon <linux.amoon@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-2-linux.amoon@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261127103030.4647-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 02:30, Anand Moon wrote:
> The Banana Pi BPI-F3 and MusePi Pro U-Boot device trees contain
> identical Binman descriptions and memory node overrides.
> 
> Move the Binman description into spacemit-k1-binman.dtsi and the
> memory override into spacemit-k1-u-boot.dtsi.
> 
> Include the common U-Boot device tree through DEVICE_TREE_INCLUDES
> to avoid duplicating these definitions in the board-specific files.
> 
> This is a device tree reorganization with no intended functional
> changes.
> 
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 32 -----------------------
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 29 --------------------
>  arch/riscv/dts/spacemit-k1-binman.dtsi    | 29 ++++++++++++++++++++
>  arch/riscv/dts/spacemit-k1-u-boot.dtsi    | 13 +++++++++
>  configs/spacemit_k1_defconfig             |  1 +
>  5 files changed, 43 insertions(+), 61 deletions(-)
>  create mode 100644 arch/riscv/dts/spacemit-k1-binman.dtsi
>  create mode 100644 arch/riscv/dts/spacemit-k1-u-boot.dtsi
> 
> diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
> index 36c1bfc12fb..bc117f5987a 100644
> --- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
> +++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
> @@ -3,15 +3,6 @@
>   * Copyright (C) 2026 RISCstar Ltd.
>   */
>  
> -#include "binman.dtsi"
> -
> -/ {
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
> -	};
> -};
> -
>  &uart0 {
>  	bootph-pre-ram;
>  };
> @@ -96,26 +87,3 @@
>  	bootph-pre-ram;
>  	max-frequency = <204800000>;
>  };
> -
> -&binman {
> -	u-boot-spl-ddr {
> -		type = "section";
> -		filename = "u-boot-spl-ddr.bin";
> -		pad-byte = <0xff>;
> -
> -		u-boot-spl {
> -		};
> -
> -		ddr-fw {
> -			type = "blob";
> -			filename = "ddr_fw.bin";
> -			align = <64>;
> -		};
> -
> -		u-boot-any {
> -			type = "section";
> -			size = <0>;
> -			offset = <0>;
> -		};
> -	};
> -};
> diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> index f2688a1868f..03cfed10521 100644
> --- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> +++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <dt-bindings/clock/spacemit,k1-syscon.h>
> -#include "binman.dtsi"
>  
>  / {
>  	aliases {
> @@ -15,11 +14,6 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> -
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
> -	};
>  };
>  
>  &syscon_mpmu {
> @@ -133,26 +127,3 @@
>  	bootph-pre-ram;
>  	max-frequency = <204800000>;
>  };
> -
> -&binman {
> -	u-boot-spl-ddr {
> -		type = "section";
> -		filename = "u-boot-spl-ddr.bin";
> -		pad-byte = <0xff>;
> -
> -		u-boot-spl {
> -		};
> -
> -		ddr-fw {
> -			type = "blob";
> -			filename = "ddr_fw.bin";
> -			align = <64>;
> -		};
> -
> -		u-boot-any {
> -			type = "section";
> -			size = <0>;
> -			offset = <0>;
> -		};
> -	};
> -};
> diff --git a/arch/riscv/dts/spacemit-k1-binman.dtsi b/arch/riscv/dts/spacemit-k1-binman.dtsi
> new file mode 100644
> index 00000000000..2ff6bd2cc43
> --- /dev/null
> +++ b/arch/riscv/dts/spacemit-k1-binman.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 RISCstar Ltd.
> + */
> +
> +#include "binman.dtsi"
> +
> +&binman {
> +	u-boot-spl-ddr {
> +		type = "section";
> +		filename = "u-boot-spl-ddr.bin";
> +		pad-byte = <0xff>;
> +
> +		u-boot-spl {
> +		};
> +
> +		ddr-fw {
> +			type = "blob";
> +			filename = "ddr_fw.bin";
> +			align = <64>;
> +		};
> +
> +		u-boot-any {
> +			type = "section";
> +			size = <0>;
> +			offset = <0>;
> +		};
> +	};
> +};
> diff --git a/arch/riscv/dts/spacemit-k1-u-boot.dtsi b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
> new file mode 100644
> index 00000000000..0d92edf9fc1
> --- /dev/null
> +++ b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 RISCstar Ltd.
> + */
> +
> +/ {
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
> +	};
> +};
> +
> +#include "spacemit-k1-binman.dtsi"
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index d9cb6c8cebc..0f6e9284259 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -66,6 +66,7 @@ CONFIG_CMD_EXT4=y
>  CONFIG_CMD_FAT=y
>  CONFIG_EFI_PARTITION=y
>  CONFIG_OF_UPSTREAM=y
> +CONFIG_DEVICE_TREE_INCLUDES="spacemit-k1-u-boot.dtsi"
>  CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro"
>  CONFIG_MULTI_DTB_FIT=y
>  CONFIG_ENV_OVERWRITE=y

Reviewed-by: E Shattow <e@freeshell.de>
