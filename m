Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D674606A537
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p3zYXm3o;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFXbrRFR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58A00606D0;
	Fri, 20 Nov 2026 06:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klbdBsJ9o6Lm; Fri, 20 Nov 2026 06:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A0EBD606D6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795155147;
	b=F83CYlwJ9nz/H0fr0zjSEnlWcZJ9LPBKc4NfW5R15739fJWPuqqJbzbr51k0zuY9GVLw
	 0BegCMaE5WCYD2Xwoy/sqjOe2vaokwGMAFQn40UHyrrble/7Kgke3Sckm0BdMDKptx+YC
	 w4ImOr4u8cRA82NR7gGrrNtHGaClgn7R3xnjKmjNhaB41NmDxWgpLvGhWxNMp56a4GLpl
	 kgPjFe8MvyRHEtcT8XMXgALEUDvJiJAQcVfFwdWP4IwkFdh5hLUX9vf9Qv5wQXMw2sUAY
	 +FystTeSR0GoPZAlwekL9gk6r7x9VuRiWZVWc+CL5CKLWd6ybFBkXEVtHz22+1ZT24g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795155147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p1KsGlCEWwY/on3uaKodFeUKJekVJ24m0aGB0zl40+c=;
	b=GQroWCjLcbpr2LC1oLC1yR7YrUS1WmceEXUTMODSdd4WiiDhVflbnom/EsFFKh69DCqJ
	 nLfhseDOnc16YUgZqkB68eEm2EvvQTrg73+BoIm+Y91jcvaZEgQIk6joc2qi6D3LSh9wu
	 CAIxbl10en/nXNQ8M3hGTq9o7cI/FHGbLO7+JJJiiEJVH/pi5i+WA6/uDOYjrARN9Wew3
	 l/U2jckdJzYe5kcPPX3htwdiM+4DJ/SlQfeJRTTRin3gvF3jlJEwZJqQx4XommTznPnXq
	 KU7GlH46DcHNrtWVauiPjdwAYJaNPUGtXgp1Hfzhyr7DnIYQi1k+8YP0oGyZugonzbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795155147;
	bh=p1KsGlCEWwY/on3uaKodFeUKJekVJ24m0aGB0zl40+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p3zYXm3o9nTbP69v4mm/uqUKRjmoOxBB8cyMpbPRDU141uYu1nwZXsshG+cX64BKK
	 aDOoIdMVlrWIVXffD+fwaSaK4ZYCnkruHHng7XRUiGA0s2pP1cmb9rH9lU7m55uiLK
	 Pk9+UD61D9RBZIKlV5SOvQ4E1hY67PB8YcBvltlJwLcW5MV1s+JHyrTxaS0DCdDGZ8
	 +liTlbPJG3FGYU9qPB3HD4A9911ET41g2vkn3RG2pS0ZsC4EvdTkZXUM4AnsS2vDL3
	 urhjCl4rYsRWA9BGU7l68y+kqif2Jd02LbfqPLoVeu/axm48Wj3UTmfYsVuFLiQTnM
	 v9uWHwSx7U3Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0EBD606D6;
	Fri, 20 Nov 2026 06:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F1129260
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D41ED40122
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9zE84Ckbde1a for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 06:12:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1D4A2400D6
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fFXbrRFR
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D4A2400D6
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 06:12:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B806640449;
 Fri, 20 Nov 2026 06:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2759C1F000C4;
 Fri, 20 Nov 2026 06:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795155143;
 bh=p1KsGlCEWwY/on3uaKodFeUKJekVJ24m0aGB0zl40+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fFXbrRFRIapZ3kz7k/dh7F4MY8ujlH8FX/6CAVtJGx+lqRFL2KU1x2MxKEMQon+Qp
 fCqBSin87NZWVUlyzl0oB3WCfBKjJyKsQbbuHN6kEFP0R7zTC0LAdw6sd9uUtUG7Sz
 ypaxvVNOHbFMbL2LN9aiZI5x4asD7dzM8AUwILHqxkDZXL6goh6stsNQqG0KxiaDqy
 SpnnNR1wDj8FofiYAoxyjps0nabGBbZ0zeX6g27af8Ij8f9N8e74V3ikVTUvkDr+pW
 S2MKPT7WYxpMUrJd3Jj/svuFzJu82jhYoxJIWoJgVX7fBVeHZROLBuZWREXQkby3Ne
 c8BGWZfZBbhsw==
Date: Fri, 20 Nov 2026 06:12:21 +0000
From: Yixun Lan <dlan@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 E Shattow <e@freeshell.de>, Huan Zhou <pericycle.cc@gmail.com>,
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: Re: [PATCH v1 5/6] pinctrl: spacemit: Add SPL support for K1 pinctrl
 driver
Message-ID: <20261120061221-GKF156369@kernel.org>
References: <20261029134705.3767-1-linux.amoon@gmail.com>
 <20261029134705.3767-6-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029134705.3767-6-linux.amoon@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anand,

For the title, how about
  pinctrl: spacemit: Add SPL support for early access

On 19:16 Thu 29 Oct     , Anand Moon wrote:
> Add `SPL_PINCTRL_SPACEMIT_K1` to enable the SpacemiT K1
> pinctrl driver during SPL initialization.
> 
..
> Depend on `SPL_PINCTRL`, `SPL_DM`, and `PINCTRL_GENERIC`,
> and select `PINCTRL_SPACEMIT_K1` to reuse the existing
> driver implementation.
> 
Redundant, drop it

> This allows SPL to configure pin multiplexing for early
> board initialization.
> 
This is ok, but better if able to add some more detail

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
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
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
  similar,     s/Spacemit K1/SpacemiT/
K3 reuse same config with K1, so other part looks good

> +	depends on SPL_PINCTRL && SPL_DM && PINCTRL_GENERIC
can you check if able to combine this two? SPL_PINCTRL && PINCTRL_GENERIC
as I see SPL_PINCTRL_GENERIC

> +	select PINCTRL_SPACEMIT_K1
> +	help
> +	  Enable the Spacemit K1 pinctrl driver in SPL.
> +	  This allows SPL to configure pinctrl during early board initialization.
> -- 
> 2.56.0
> 

-- 
Yixun Lan (dlan)
