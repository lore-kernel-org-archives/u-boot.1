Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A4DE7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F6828745B;
	Tue,  3 Oct 2023 15:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sxQoaFMB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hbU1SSzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BB48725E; Tue,  3 Oct 2023 15:40:51 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B408745A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S0Jqh6m4Jz9sqL;
 Tue,  3 Oct 2023 15:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEPhfbOnXxPJqzEw2l94Xcu12q5Fhts7ykY8mYzofqM=;
 b=sxQoaFMBsHQUXKflGNxA7GVzdetAQPL5Bk70Uued7khSk4Q6BlicFc7Bibl1t+RyDmflFq
 R8qq3rur0w8XtjClhUcQJAM2xwGkAH126kf/BQdkDLZWhEMwCre8RB2HqwFBMDbgQTftTp
 p9A8ctLnSJGakeGEW2MHyUej+r5ljDafGlUf770vqnS5i26FyzVF+Bq0YqrIN/Ec7yT2Ml
 bcCCl/7xcO/tXJzgtzdnVyGvcSlo/DoBjjd03rxBii/84WBu85agEpAkKBg2RkDXIH6qHu
 aVWHOqeKSRw73Liwu32gDuV2FSmqNEf89aAsiSetth5IZKqyIJ+h1wA6l8vAKQ==
Message-ID: <40598007-6c1d-440b-70f8-469ad12693b8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEPhfbOnXxPJqzEw2l94Xcu12q5Fhts7ykY8mYzofqM=;
 b=hbU1SSzGM/gx+MUOj0NQfD3eEtepvbkKQFeHgyro8v9+EVCTXvvInbl8w/nUxGjkanSVoh
 c6DlkK4n1dd7SsY/Id061Wken4grywZpFshfQmHTBqCZ9ovWNm9NqlICOxWePgQEdtTShv
 QiRQUH4fg7LOck7DYWiT9SJtzxS7ErBOKsGJ8pmiS6MA+mUf8QHsOQJb8PlW8hW8g5Lsf7
 XX91NvcpUtwfcXWrYrChOogBVUnib/e07JSYcpR6a2P2R2ZsFgpDVD/1JXmYQsxfiBDexD
 qiNZ/V4sXYcr10OZhe81Gy4FZIIg8hZQbfJgNW5qibkIJR+UHXtke78IJpcEfQ==
Date: Tue, 3 Oct 2023 14:45:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 05/16] arm: rmobile: Add basic RZ/G2L family support
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-6-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-6-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0527887db39403f2cf7
X-MBO-RS-META: 8wfdr1ewamc59rahz3xk5rhh31to3sa5
X-Rspamd-Queue-Id: 4S0Jqh6m4Jz9sqL
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

On 9/20/23 14:42, Paul Barker wrote:
> The Renesas RZ/G2L family includes the following ARM SoCs:
> 
> * RZ/G2L  (r9a07g044l)
> * RZ/G2LC (r9a07g044c)
> * RZ/G2UL (r9a07g043u)
> * RZ/V2L  (r9a07g054l)
> 
> Support for individual SoCs and evaluation boards will be added in
> separate patches.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>   arch/arm/mach-rmobile/Kconfig                | 13 +++++++++++++
>   arch/arm/mach-rmobile/Kconfig.rzg2l          | 12 ++++++++++++
>   arch/arm/mach-rmobile/include/mach/rmobile.h |  2 ++
>   arch/arm/mach-rmobile/include/mach/rzg2l.h   | 13 +++++++++++++
>   4 files changed, 40 insertions(+)
>   create mode 100644 arch/arm/mach-rmobile/Kconfig.rzg2l
>   create mode 100644 arch/arm/mach-rmobile/include/mach/rzg2l.h
> 
> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
> index 3061ccd34c8b..fd240832d83d 100644
> --- a/arch/arm/mach-rmobile/Kconfig
> +++ b/arch/arm/mach-rmobile/Kconfig
> @@ -66,6 +66,18 @@ config RZN1
>   	select SYSRESET_SYSCON
>   	imply CMD_DM
>   
> +config RZG2L
> +	prompt "Renesas RZ/G2L Family ARM SoCs"
> +	select RCAR_64
> +	select GICV3
> +	imply MULTI_DTB_FIT
> +	imply MULTI_DTB_FIT_USER_DEFINED_AREA
> +	imply SYS_MALLOC_F
> +	imply RENESAS_SDHI

Keep the list sorted

> +	help
> +	  Enable support for the Renesas RZ/G2L family of SoCs, including the
> +	  the RZ/G2L itself (based on the R9A07G044 SoC).

Including the RZ/G2L itself ... and what else (you likely want to add 
answer to that into this paragraph) ?

>   endchoice
>   
>   config SYS_SOC
> @@ -75,5 +87,6 @@ source "arch/arm/mach-rmobile/Kconfig.32"
>   source "arch/arm/mach-rmobile/Kconfig.64"
>   source "arch/arm/mach-rmobile/Kconfig.rza1"
>   source "arch/arm/mach-rmobile/Kconfig.rzn1"
> +source "arch/arm/mach-rmobile/Kconfig.rzg2l"
>   
>   endif
With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
