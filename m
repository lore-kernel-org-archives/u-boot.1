Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA29606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ad87TNZ7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=lTyjXBZr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9672406A7;
	Mon, 23 Nov 2026 15:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 28H8D3yCFK-C; Mon, 23 Nov 2026 15:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 549F5406EF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795446418;
	b=CsFsy+nDIlNzd75QPX3Q2IYhinc9ITU5Spw1slArY5JzlY3nZqwEIdRXJuR87sqZkobv
	 Oq5tMayZvFHiB75ZeQQjajGz9ThcnnAip1jLt6zgnr9ET8EjnCkBV9rLa0ZIGMi9ZBzP9
	 BJ5kP9Dodb5g70IeDS6hdV7jRb6b2pf75rU8nu6XRaTYWMsGqvQ6+b3UiUzJNZYWiRITL
	 2NeU0p1b2zbUtZNcxvJN6K/2P8XQvoTciGVWY+BuhV+xgUWtPHFgqzn8GotwOWaxgv+Sd
	 U5D0vJfOp4oJfYm1Omg6+u4GfVTbJZJ6ViXltmtbdynt9YccyQzwaZp/bA8NSjDgVvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795446418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YDTGJNgj1RqiXWdnvV4kBH/mDR5xCNY7lgCE1E70o/k=;
	b=pHl7dTx6rqSUbINkEvF55+EbqwhrbJFBq3SxJS6jVAJT9UuMLQzsmPtTFxSQHlSd/+rS
	 RXsJp55KXRUZg9GZJzaxlwklEHnyAxxg1wgwWf7IYz3hHUkYHBsV/fRicOnLySZ6EOAnT
	 UVBwGgXv5/O4kMdvnuYZkwQYI+eqLOutd1Y4m13CWlHaVc3HIdwMEl9X8wpPxfAtED4Mj
	 GPTdlY2dzcWq18ocRyVXh4ZhrSSBRCiHTddF1RX4Q+HAxk3wdX5iZwo2Kacht96UMahXp
	 57DpTwALZneN6gs0CpyNR9Na/VB3n8/jHgwqaPEse4znEtllInvn+91sGnglxE8VRAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795446418;
	bh=YDTGJNgj1RqiXWdnvV4kBH/mDR5xCNY7lgCE1E70o/k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ad87TNZ72Ad5j7+s/c+wjNn3T2yeSLWW52vzPhJEo/Ny0yj6/f9sx2OXdcyejmTNd
	 GfmzxYHMEcYicJZ55XoK8FmhpGt8QQqvFGvZ7xLOXUZh1sPu8egOdf7khsCyVIf9yg
	 vcuKajzgbN8nLt0KmhFbRMNXETC8RrxroJCVTUo1oaTdjzVIVgUf4U7MXPx7XuGqEA
	 pWRBZfcqD4teplCF96f5zHxHWVyhRgLgtUiD2w17lydP7qW/KWwBgbfW/5mbKaxQPs
	 Q5ygKIAd45l+5vIGDsfbL/Vkw2TbZIRAHM/yb8dMK+bIZ46XzMHnPsINHa+io8dAoJ
	 6r36bQ7t/9rkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 549F5406EF;
	Mon, 23 Nov 2026 15:06:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3A84759
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:06:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D53FD6071F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GBJX5i9jmmdK for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 15:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37B9660712
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=lTyjXBZr
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37B9660712
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:06:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=lTyjXBZrrxutKf+WIOuDO/LaFmaPToqxDg77rx/krffHRS+Hnn3bYrrgk+W1G+Edzb6ivIh4aGElzWRTjcujDM+dFeAFCxMLuetuYCClxZTpvyHX1kmerMQTMc0ZwzK+2UxtFdRHTiKSjR3quYPrrHei1UTl49hWMNqrdDVGdbo=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=YDTGJNgj1RqiXWdnvV4kBH/mDR5xCNY7lgCE1E70o/k=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795446299249875.2611112627795;
 Mon, 23 Nov 2026 07:04:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 23:04:45 +0800
Message-Id: <DN2OL8QDSA3H.369TW8VSAPCVG@pigmoral.tech>
Subject: Re: [PATCH v1 5/6] pinctrl: spacemit: Add SPL support for K1
 pinctrl driver
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Anand Moon" <linux.amoon@gmail.com>, <u-boot@lists.u-boot-project.org>
Cc: "Dave Klotz" <DaveWK225@protonmail.com>, "Eric Chung"
 <eric.chung@riscstar.com>, "Hung-Chun Tseng" <alan.tseng.cs@gmail.com>, "E
 Shattow" <e@freeshell.de>, "Yixun Lan" <dlan@kernel.org>, "Huan Zhou"
 <pericycle.cc@gmail.com>, "Tom Rini" <trini@konsulko.com>, "Guodong Xu"
 <guodong@riscstar.com>, "Raymond Mao" <raymond.mao@riscstar.com>,
 <u-boot-spacemit@groups.io>
X-Mailer: aerc 0.22.0
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-6-linux.amoon@gmail.com>
In-Reply-To: <20261029134705.3767-6-linux.amoon@gmail.com>
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

Hi Anand,

On Thu Oct 29, 2026 at 9:46 PM CST, Anand Moon wrote:
> Add `SPL_PINCTRL_SPACEMIT_K1` to enable the SpacemiT K1
> pinctrl driver during SPL initialization.
>
> Depend on `SPL_PINCTRL`, `SPL_DM`, and `PINCTRL_GENERIC`,
> and select `PINCTRL_SPACEMIT_K1` to reuse the existing
> driver implementation.
>
> This allows SPL to configure pin multiplexing for early
> board initialization.
>
> Cc: Dave Klotz <DaveWK225@protonmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: E Shattow <e@freeshell.de>
> Cc: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pinctrl/spacemit/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/=
Kconfig
> index 87cba336923..5770e4865d9 100644
> --- a/drivers/pinctrl/spacemit/Kconfig
> +++ b/drivers/pinctrl/spacemit/Kconfig
> @@ -7,3 +7,11 @@ config PINCTRL_SPACEMIT_K1
>  	  The driver is controlled by a device tree node which contains both
>  	  the GPIO definitions and pin control functions for each available
>  	  multiplex function.
> +
> +config SPL_PINCTRL_SPACEMIT_K1
> +	bool "Spacemit K1 pinctrl driver in SPL"
> +	depends on SPL_PINCTRL && SPL_DM && PINCTRL_GENERIC
> +	select PINCTRL_SPACEMIT_K1
> +	help
> +	  Enable the Spacemit K1 pinctrl driver in SPL.
> +	  This allows SPL to configure pinctrl during early board initializatio=
n.

I tried replacing the hardcoded pin configuration in i2c_early_init()
in board/spacemit/k1/spl.c with the SPL pinctrl driver based on your
series. SPL hangs during boot after this change.

While debugging, I found that CLK_AIB and CLK_AIB_BUS, which pinctrl
requires, are not defined in SPL. It works fine after adding them.

Could you please also add the required clocks to the SPL clock driver?

--=20
Best regards,
Junhui Liu

