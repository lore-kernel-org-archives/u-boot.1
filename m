Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CDBCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D6086E22;
	Sun, 15 Oct 2023 08:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DjC29NjL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sr+x1msT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26CB786867; Sun, 15 Oct 2023 08:43:36 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E37E86F5E
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S7Dp93Pv8z9slg;
 Sat, 14 Oct 2023 22:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqq4hq73wx8x0J+mIf83HFsS7UWl8B5DtrpKJgA3an0=;
 b=DjC29NjLa1VgYfXSBYs0xYCPfq+kGk9o6lx90yamP+h1dRiC0UXzYMLpfi12ZW5vKqYt+a
 UIl0OKjbm4VkBFSWydfA0XJ6O7pa85rzXv/ZmCbBrrqd99zNDI5cv10+BcWbhyrWp69Sb+
 B30heSPqPDwhin5Qp6kEPeYcpXCqiqwRhm7w0jzJMIEsYJyKeyxnhJJUYoIAVn8zqb7oo4
 pThaQmgEmlYoW9RgaLqxNj9dg7gJMYzYsCChNVvNdnffSFjOp+EysdU29+g9z7tfCp3qIc
 pe6dzf6fK6Ee0AXUkzwAG8Mv11zT/yvuRzfPDmT99jU6Rz0NktAhVskBhrbjXQ==
Message-ID: <80ad144b-d90f-4029-9a05-b52991965a0c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqq4hq73wx8x0J+mIf83HFsS7UWl8B5DtrpKJgA3an0=;
 b=sr+x1msTW173lmNc8XYJJGMHVmuyGyTxaeyLB7VIgz37ECWs47zBXzdspXz4IiPdXhgMFR
 RUeSWD7ioee/08z0ibb5p/rTsm9Jx/KxDd4kHLXgz17GKDvYWiPEkicCp8SdSAIKjjXHKd
 aJIs4j+eMRmze7UbkH9otl/U9Y8qvFiN7lAOm1OlftS/GUf5/2p+aFaxvvVHN/jh/gq/Qx
 F/+60Od4rQWcPI9XWnY9o9OAc8TBFGxIgseQSnUBi+qK8GvXgMGcBrayfUDVAzqWbBB/XG
 SUrp0QwMDBXBRHeArY8J97zTAFcOY7f2ZmH4N5YbHpX3AdMZ3QeZEGpkAL0wuw==
Date: Sat, 14 Oct 2023 22:03:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 10/19] pinctrl: renesas: Add RZ/G2L PFC driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-11-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-11-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c17788d9db79143a9d9
X-MBO-RS-META: g3z49psrw9sm8xeirw4in5h855pohbnz
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

On 10/9/23 18:46, Paul Barker wrote:
> This driver provides pinctrl and gpio control for the Renesas RZ/G2L
> (R9A07G044) SoC.
> 
> This patch is based on the corresponding Linux v6.5 driver.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>    * Split GPIO into separate file.
>    * Drop unnecessary parenthesis in defines.
>    * Keep Kconfig list sorted.
>    * Drop pfc_enabled flag.
>    * Use const where possible.
>    * Use clrbits/setbits/clrsetbits functions.
>    * Return -ENOENT to skip invalid GPIO offsets.
>    * Include ofnode_parse_phandle_with_args() return code in err print.
>    * Use macro instal of port + 0x10.
>    * Add TODO comment re Ethernet PIN_CFG.
> 
>   arch/arm/mach-rmobile/Kconfig       |   2 +
>   drivers/gpio/Kconfig                |   7 +
>   drivers/gpio/Makefile               |   1 +
>   drivers/gpio/rzg2l-gpio.c           | 170 ++++++++

This GPIO and pinctrl driver addition should be two patches, really.

>   drivers/pinctrl/renesas/Kconfig     |  10 +
>   drivers/pinctrl/renesas/Makefile    |   1 +
>   drivers/pinctrl/renesas/rzg2l-pfc.c | 625 ++++++++++++++++++++++++++++
>   include/renesas/rzg2l-pfc.h         | 110 +++++
>   8 files changed, 926 insertions(+)
>   create mode 100644 drivers/gpio/rzg2l-gpio.c
>   create mode 100644 drivers/pinctrl/renesas/rzg2l-pfc.c
>   create mode 100644 include/renesas/rzg2l-pfc.h

Otherwise

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
