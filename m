Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C53C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 21:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1BC836C8;
	Wed, 13 Aug 2025 23:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Q8xzNgw4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QXI1/8P8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D5DF8373B; Wed, 13 Aug 2025 23:33:15 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9A482A53
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c2M6w5M0Fz9snw;
 Wed, 13 Aug 2025 23:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqnl/xku04vUUPTtjH0ZWGS1A22YeE8O9NGVnayJ6WE=;
 b=Q8xzNgw4aIY3A0TikqlgRugUPm9C98mn588MN/d4bLWu1HlYrZpXqiQ9k3jE8oiqacNjzC
 A3mUk1s4af0UuRfIo5fqnLPJ0XgOUSxbBZ2a0l+xQn2Js4k/ATFTSM37eq5JkzKdixM2Ae
 XE1kTcIdzws2tt0PJJJkedEzUw+uuL8bpehJGMPZz6zdh5PjQRfTOtLuRPTRqz6/Vc6GC8
 uQ75pR29+N//B0FhqZG68lChvkR+S/srg0LGtivMXT3q1e7sOw3RgFSCLEK9YuTUecUnxy
 gXhAcpEQ0WBwHAAATy7mkhBhyEQcz/CbqTkF5cA9vblon3u73yoGbvzikxhpSw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="QXI1/8P8";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <d4cae49d-e4c7-481b-9a0e-ed54c0068560@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755120790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqnl/xku04vUUPTtjH0ZWGS1A22YeE8O9NGVnayJ6WE=;
 b=QXI1/8P8YWdhmN+lQBA13NFyYGEtATnPykAGhhyMmevoa4M/aPgQgG6yay5FfKWqgqhLaI
 nH9HkXjAi8sEcXq7t3swgDKBaSUYetXt0BUsPXFQsEsSkiKbtg3gO9MFub7SbYw+UqdvwR
 paR0+X3ZKih4E1DWUfq88pKM4uT68MCEXpnJODbyid+n6qS7q8SC0HESF6ZspMnu4lbm20
 XmZ0/9aW5SUFxKH4YLUedFesD+KhLp8RyN3eVAC0vk3HTuEMkAH5LiSCl+n28QrlS7pGfi
 S/VdDlEbIfVx+Igry0b2n+wUgU1KwI9UAfKJF6b7n3GHpqmGxwvZsdTqglpfFQ==
Date: Wed, 13 Aug 2025 23:33:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] configs: Remove redundant CONFIG_TEXT_BASE assignments
 for Renesas defconfigs
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chris Paterson <chris.paterson2@renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250723081015.278248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250723081015.278248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fk6ohhunxiegjb4u3gph7h8ghdw9pnnu
X-MBO-RS-ID: 975521a9bfc592808e6
X-Rspamd-Queue-Id: 4c2M6w5M0Fz9snw
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

On 7/23/25 10:10 AM, Prabhakar wrote:
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
>    - r8a779a0_falcon_defconfig
>    - renesas_rzg2l_smarc_defconfig
>    - rz2_beacon_defconfig
>    - silinux_ek874_defconfig
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
