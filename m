Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C111E77198
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 22:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51FC380619;
	Sun,  5 Jan 2025 23:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736115149;
	bh=AyWGAmkSlBKjvLqWhbBFzCTCFUjs3EhIwR4yPclJFYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a4GJDvfykxyIts0HkPtBfspmlmZwdp3177elte95LoHK2zo4wxOo47baTV6BNTJ43
	 dlASq3HfViE/BVGXW9w3VzEHBJpQmFrm+23Y4F7LhF9XiZlEdCzFTwyc4LTIU2H0EH
	 5ylhpsUetWJrLIij/xZVP71PVlHLCD5E0Y6+Vd+4EP8eHr5xeVQLLZT4U7Jtybh+4x
	 v9R+UgaweMCFliL7cB3C2SyS2SjUU0MWzgfsF1Vp8pCuoT1vPuDOAebayPpu2MRrSM
	 yvEhfrPDVE9VZJSC5Ec/DtiSNOeCXjAOpAG7J2tk/dhTMaXRSrdgA0PIHk4XTjXmwr
	 WpEx8Mq+GO8ww==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29AF80619; Sun,  5 Jan 2025 23:12:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31182805FA
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 23:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hGjS2Y06"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB92C104839FE; Sun,  5 Jan 2025 23:12:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736115144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AyWGAmkSlBKjvLqWhbBFzCTCFUjs3EhIwR4yPclJFYA=;
 b=hGjS2Y06rPuS22NI44VzS3hPAWWRBACpKAEQjm0AgaJbSowUaOqyjaKKM0JrNAqQdj9GTK
 JTJx6qWOb8M/Umtp9e3a4JX/h/iOCG2HXvcNTRL+9BRmNoxGLhHRmZJvqLDfhq2yIqpoUC
 +asGBGGIMWl+M2/OZKfE8YL0jR7oi9F+3+KU8k9i2w6pDCOkABUev5bBnQF+Cq5d+UCQmF
 8uLC42qBJnOHRaO3pifIe8UfylHarUxGtiwKQiBAmlSjWlWTix2fJwe/0cC/bpnlnoaHeY
 yNie/5Qisky8b00I+YgP3NaXklxZgz0MI0Or2uTlHHSGm2ela/sDGuKtAoo2HQ==
Message-ID: <53808532-f3b8-4362-906e-d2473801b2bd@denx.de>
Date: Sun, 5 Jan 2025 22:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/17] binman: add a new entry type for packing DDR PHY
 firmware images
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-14-6744df5dc020@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250103-imx95-v1-14-6744df5dc020@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/3/25 7:45 AM, Alice Guo wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> i.MX95 needs to combine DDR PHY firmware images and their byte counts
> together, so add a new entry type nxp-header-ddrfw for this requirement.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   tools/binman/entries.rst                  | 10 ++++++++++
>   tools/binman/etype/nxp_header_ddrfw.py    | 32 +++++++++++++++++++++++++++++++
>   tools/binman/ftest.py                     | 11 +++++++++++
>   tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 +++++++++++++++++++++++
>   4 files changed, 77 insertions(+)
> 
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 780e9817fb6496b5f2a4aef6ed1c0b4c8d9a4ba2..6da3f0b904643360ca11da32e31129f5f54d279c 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -1663,6 +1663,16 @@ Properties / Entry arguments:
>   
>   
>   
> +.. _etype_nxp_header_ddrfw:
> +
> +Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
> +---------------------------------------------------
> +
> +This entry is used to combine DDR PHY firmware images and their byte counts
> +together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
> +
> +
> +
>   .. _etype_opensbi:
>   
>   Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
> diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..541f045aa2e0bff5fea7c91c6939e35ef0b7200a
> --- /dev/null
> +++ b/tools/binman/etype/nxp_header_ddrfw.py
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2024 NXP

2025 now.

[...]
