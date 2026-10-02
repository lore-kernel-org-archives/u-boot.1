Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181A3CA5FCE
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 03:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4880F40C9A;
	Fri,  2 Oct 2026 03:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 76YB3c6fUwPL; Fri,  2 Oct 2026 03:21:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5E47540BF1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790911289;
	b=STtq4kwHULMKn1gxd2IEp7G9rc/zg7CsgqaTopueiuN19Rq9sLtal9UDd9Eoco/wPkYR
	 R4q2Lt67kDB4lxPcPx2qO4rTl8e3g+XGIjqISjxSL7trj9bsoV7MnjH9lI5YwF1TBUUXF
	 JQPBMywu2ji1G0JFZqj7ZT3PHuqUVJVxVygJLhjcJWLQ/p+bnedapg7cYtEbaqtQ+JZXN
	 0imc/oKdBMb5RGB0MiIg/O7hkjqQR6qfYXmgK5QIuCvk0hXIZLMdYZuAV8CXoTW83x4vG
	 QFGvLICp+zn2+JoCY1bEifA20iLzJCDQc5Ln8dfxw6Qc3R3ghiJJFhrjGrpKwmNzD0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790911289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VCIEh6hQVgjPk29/taK3OU5X9eSh+SU0+tjfEXjDe+s=;
	b=UWdtzuJ6e2so4Bq7xP/UD8k3+mm6z/RFpYfcVnX2EwjdGNDumr5kHagZ1DeLrR75+GM1
	 FN/rfnmpo5bfbQHsuiL8Leg70Z9eNG5Zw3KBFf8lCOLFRJoHc/3IIn/5JAKswqE55haj9
	 6eG1c4VH+WNIGFSqh3vo6Aqf5L0rZYaoPRqEPGb1ym99qauzEDwISE5d+ublTTXg6INgH
	 HpQtD+jll+ydRLvyJAGLvY/lAicl5W0X363BEJz4ljz9dv0TWu/DJDae/0bEztG1Um6BM
	 kZLPJBovUzImKwua28U4J8I5mFPkAcI9flBex8+gu5KID6rEDqqNXb9mTQTSQtUjWEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=YKXZx5Ac;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790911289;
	bh=VCIEh6hQVgjPk29/taK3OU5X9eSh+SU0+tjfEXjDe+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvzOIpocyqndjMPdS0hyOgjCQ+ntSvmGmSpM6BdgIi7bZqmRCtn7Dp/WYZlmcIISR
	 Asdvr10V2iAdhZuvVjLb9z3m7xRmHFvrC7o2Uxfay/d/Cv9v64X9/O0fW2ph9Xlbge
	 JIxorXvZqu7KNIKIKivoCX4NjfazG2kVFH/pEo/HqbCOKvsgBiAN0MjtkVNf6kab6d
	 U672MWwcKmbGGyARz0gi2XW9QG7qcnc2lm1ir3QacUfQ4sUdhYpfP9BpRJfJ1zw021
	 qh6OYx83+DXskHDYuKA7oFv1TiA0UlM84Ahh8DWI+iqAzNg/uKa7g6/JFu2wTR1dgP
	 E2jqpRl4m0NKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E47540BF1;
	Fri,  2 Oct 2026 03:21:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58611282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49F2940BF1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aqABiFzC96wz for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:21:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 38F8C40BE1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790911286;
 b=IIXfiaSDnSEBbgazndjcVnm4XB/JMGUdtGAfj9/Jv12ueISflQR5/3KyCnJhj2zv2RXz
 EhZdw97JkqwGZl0cEmm/UWMztdjVs4+xuWcXrF/N+ILwLsZ+WAN4pOaAEvhIC5oJdP/cT
 L/1u0Z8xB6qKvbVQaVtZFXZM8FracxYv9V0dyQ24KSBn5HM6NemTEPmkTlCvsGQp4gYvr
 ytmZvEcszMqZSki5K4HCV8PGc4cvx5INWMQypjvwFgMUiKwOMOg1u6RecWsKqbx50RsLO
 mCcYltqjufiVnbesvcTkgs/TKNlN8wW36/LVxGoTyJAM+PNAWTPY16qLpYgHOT+LfNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790911286;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=VCIEh6hQVgjPk29/taK3OU5X9eSh+SU0+tjfEXjDe+s=;
 b=pwlzZCS+1OrWrrGdvPncYau1JM3874Iyugvl/ounjNklNsGIQI0FHDWOWXzYeRMC2bCe
 UnbA64ZHrCHGKqEnqgtQGlIPEuosoOdn21QJKQag+fIzbBEr+4vUSF7XP18smJEdHr+pI
 rrRL6duvwg9LNexiliVWioaw3gxkrozNvnN1NJaGIeVBdJ9R0Z4GS9DnURNetEGZcXVrJ
 acs4BZ5TPMTjtsXJBLU7ffZAO5+Wsq3gOuKvsD9aEIR76aT0Md/c1qqMpzfg/syCRFomo
 td6toEd7UUsMxUP24NQSU+z+0hzCpfiuI72OPznl3tI+rxZycwTAeHmA7WsXN5EyEmw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=YKXZx5Ac; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=YKXZx5Ac
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38F8C40BE1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790911240;
 bh=VCIEh6hQVgjPk29/taK3OU5X9eSh+SU0+tjfEXjDe+s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YKXZx5Ack8tcA2EHR7TGGiXEgAD302QoGHAusx4krAn9R1eeELkE7QXExlJc8INK2
 juQ1IjVZxwt50UJRDasi+E8pY3wirV8YelMMpY5ztBZK34Gv+qsJGJvPoIQwoqyWEn
 nIv8C/QAL95aFz8soGg+C+OwF1L/B2Q09nnCT2kUO31s0kf1q+MC6InR/r+KgR5K+T
 GCoAX2OfGZtH7qrlyOfmO4RyLRsEKOZdZWihV/864mEbvTRuon2SKFX+LjrBSw7YHF
 XxsNkDrGzpPhGtDoEEEUrc/K2uumqLzp3USvDzRtzsTkTVvid7W/lqtd9l8RskowM8
 XTYNN1lBE/4oQ==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id ED7A3B220840;
 Fri,  2 Oct 2026 05:20:38 +0200 (CEST)
Message-ID: <63b49361-13f7-400b-802a-80b27feb48c2@freeshell.de>
Date: Thu, 1 Oct 2026 20:20:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] riscv: dts: spacemit: k3: add binman node
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261002-00-basic-spacemit-k3-v2-0-fd6779a0317c@kernel.org>
 <20261002-00-basic-spacemit-k3-v2-2-fd6779a0317c@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261002-00-basic-spacemit-k3-v2-2-fd6779a0317c@kernel.org>
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

Hi Yixun,

On 10/1/26 18:03, Yixun Lan wrote:
> SpacemiT K3 follow the standard riscv binman layout, which has opensbi
> and U-Boot proper, so include the common binman dtsi file.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  arch/riscv/dts/k3-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/dts/k3-u-boot.dtsi b/arch/riscv/dts/k3-u-boot.dtsi
> new file mode 100644
> index 00000000000..f1c1c3ee6fd
> --- /dev/null
> +++ b/arch/riscv/dts/k3-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#include "binman.dtsi"
> 

Please rename k3-u-boot.dtsi as similar to the target defconfig (e.g.
spacemit-k3-u-boot.dtsi) while avoiding any matches for the automatic
SOC/CPU/VENDOR inclusion routine of scripts/Makefile.lib:222. Add the
CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi" board defconfig
option to ensure its inclusion.

The automatic inclusion of per-CPU -u-boot.dtsi does short-circuit any
automatic inclusion of per-target-board -u-boot.dtsi, and so becomes a
blocker in the situation where we would need to override something
per-board on a multi-board capable u-boot target (Pico-ITX, CoM260,
FML13v05, so I think this is likely).

Essentially repeating here my previous advice to Hal about adding a new
multi-board target from
https://lore.kernel.org/u-boot/ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de/

Thanks,

-E
