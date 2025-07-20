Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87637C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 20:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7C18303B;
	Sun, 20 Jul 2025 22:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="l9NtqUHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D7283087; Sun, 20 Jul 2025 22:50:05 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1191D8303B
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 22:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4blbJB0hNTz9sss;
 Sun, 20 Jul 2025 22:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753044602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MtTUwCicYyadFFuRAlSuz5i8attUI65cMiD7OfD8wwU=;
 b=l9NtqUHxmmaxI7DRaO6Of6iVYyS6Ih/+0H5L6Y30ZfkVvv3TOlaM2i0qi0oM3SMVLVxmiR
 iPpYw6DB4zi+ieqwrLhW9+GqBy4D4dtUZYRyQNWhd64HBKr8wfSvl/zYd64Wxo02lOl0iu
 /PHYrkHhq76MkzVdDjKTK+sUpcp7ok0OjsFzWc8Ox2EpaYh9btG66vZfPyvIbVzdwU7EAD
 7o1zMZYvR3Z0iNh85gah1FPmRMkCYlqJK7bs2JVEDX8/Pe0PPd77CUOGXXBw/zsoRBzSO5
 WiZsKYy8eQGMX/8iUbswEQ3/f0Ndj5NRqAVizV3oM+9+KScgb/tBQKo00KJ/9Q==
Message-ID: <644a3540-9606-4b99-be80-5249cdb5d53a@mailbox.org>
Date: Sun, 20 Jul 2025 22:49:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] configs: Remove redundant CONFIG_TEXT_BASE assignments
 for Renesas defconfigs
To: Prabhakar <prabhakar.csengg@gmail.com>, Tom Rini <trini@konsulko.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Adam Ford <aford173@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chris Paterson <chris.paterson2@renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250717105259.96548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250717105259.96548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9d0e1886d61481455cb
X-MBO-RS-META: 9dccrewq7ctnhrzx75tcqdryt558uxpg
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

On 7/17/25 12:52 PM, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The Renesas board defconfigs explicitly set CONFIG_TEXT_BASE=0x50000000,
> however U-Boot's POSITION_INDEPENDENT=y build default already places text
> at 0x0. These hardcoded overrides are therefore unnecessary and will be
> pruned automatically in upcoming resyncs.
> 
> Remove the CONFIG_TEXT_BASE lines from the following defconfigs:
>    - hihope_rzg2_defconfig
>    - r8a77970_eagle_defconfig
>    - r8a77970_v3msk_defconfig
>    - r8a77990_ebisu_defconfig
>    - r8a77995_draak_defconfig
>    - renesas_rzg2l_smarc_defconfig
>    - rz2_beacon_defconfig
>    - silinux_ek874_defconfig
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Instead of setting CONFIG_TEXT_BASE=0x0, removed the line entirely
>    as it is redundant and will be pruned in future resyncs.
> - Updated commit message to clarify the reason for removal.
> - Included renesas_rzg2l_smarc_defconfig
> ---
>   configs/hihope_rzg2_defconfig         | 1 -
>   configs/r8a77970_eagle_defconfig      | 1 -
>   configs/r8a77970_v3msk_defconfig      | 1 -
>   configs/r8a77990_ebisu_defconfig      | 1 -
>   configs/r8a77995_draak_defconfig      | 1 -
>   configs/renesas_rzg2l_smarc_defconfig | 1 -
>   configs/rzg2_beacon_defconfig         | 1 -
>   configs/silinux_ek874_defconfig       | 1 -
>   8 files changed, 8 deletions(-)
What about r8a779a0_falcon_defconfig , does that need update too ?
