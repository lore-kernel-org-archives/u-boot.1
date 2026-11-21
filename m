Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72D606A330
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 03:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AlSE00r4;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WzhW3jub
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD6A340D1C;
	Sat, 21 Nov 2026 03:05:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT7v5_3GIERL; Sat, 21 Nov 2026 03:05:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5924640AF9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795230341;
	b=SbP6jEeJ+X4QA98RezdXYnrrc8sWGs99hihX18br8Dq/JD4dpyIZyr/FUXKHbzaJ84vB
	 cBxeUbEKGFdiZOC2zspYZVQtJFlZI9GAELZMtYJLeyK4D0xyLGEP8virhRjCUOUBR8ClG
	 JJrHQv7THJusl0oMlMmUH944coxaZbarlmcXki6c2kVmM5kI2cacTw2G+COsqOg8gCH24
	 YS9zulHUQLn4XFUsfkQEVTHfmFW+fvcS9q5cgv+CiFidElLwk59Crum08OXciAsdxFHWn
	 xp0injrPeHH/b7Frhp/U+E95Q/zEmqMdJw0WVnHUTOKxFsjiyR3ybJpjOmfxkGtomvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795230341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FI5tTvtwibxyHFVNP9kmkNtWJad1X/2UdVAsh2FgZeo=;
	b=T3uxvrffKUPQfU3sktw3jcuxApODM0vhamcURi+JGavJUXasqR0hWzmQYDK/hSXSWGN/
	 Wm4QKG3S1gPkypAw6lyjv3kanu9fPuDTcejPm3yBGg8GHmvTiSD4ZxoEJTJ01LeRQZeCv
	 //cYiHuORkUepGhNPIP4d3WBekF7puV98M7jQqw/ZkciBkU9JX4duwH7Ps1gNzJW7i0lb
	 B3/vxUmw8X/kZxh+OTk/w4sqxdfmV5OwAUNNjKn42VqvO1QOjNDSrh/MzDawcjMPBzNbn
	 YG6BFzjOtgSd7U1TqqV/hdI/l5RmNgk2msVsgI7YKLlkl6J9ZrNhn25q2XO3C5xfuLA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795230341;
	bh=FI5tTvtwibxyHFVNP9kmkNtWJad1X/2UdVAsh2FgZeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AlSE00r4y+HEjjumn1tklq5JxmCCPR7N0WYezzmNEk0Ex8kVLZjWuJaKlts94MHOT
	 IX5+hTL9eYq/1XrXuknBJKbqkjpf38aCQbHOD786xIybFpFYFOMvJ8wHsLujHIyj0o
	 /C8JCHtQxSEsQzT/XYxa7NpXc1BEJE8vduq0SilAbbbG8Qp74kJFllRRZTF2eehg6y
	 yADErcxbOylOMxV6wH2a16y1qKMtSD7K5H2fAzSNFSz530KhsnYqbpUuKva1BcFmCv
	 9hf5WwBIo5xk5MktEVIVVal2+yKKofJQhwCicFtSF5PVbRNAlCtTsN/OKxmFwYarhc
	 CoQtZfBo8kPbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5924640AF9;
	Sat, 21 Nov 2026 03:05:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BC252310
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADDF46066C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QTk5nd54C3It for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 03:05:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C86AB6065D
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WzhW3jub
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C86AB6065D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 03:05:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E1CD40065;
 Sat, 21 Nov 2026 03:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9156E1F000C4;
 Sat, 21 Nov 2026 03:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795230337;
 bh=FI5tTvtwibxyHFVNP9kmkNtWJad1X/2UdVAsh2FgZeo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WzhW3jubuTmcvizoTKbV/XRWVOW7V/A1fUMeCQ+StKLVd+OEt+CPerBfMiMHfzWqc
 OHfTQdDE+Fj8XceYddsJi7TiajB/cCSKg5D6mZnvF+OwXbctlfTppBeqknPQ/EHUy2
 TbE2xTGkgFa+L8BBoUD/aqyggG8td7X5bO1zqHlDeJ3FFemO+4J+LVGoJ1SnCN+tKT
 MOlvi4aPv7enXyWfARqXD2ew0LMjH35s/fgsL5gfzNXVwkNAw3vRHIQwyXlbDc074C
 EtNN37QgyWuDkj/mVBFKju0YV4DYUv4TSR0BbDRo+Vb3JG4houdGceVW82A4BtOupV
 aTS3rtNme7TYg==
Date: Sat, 21 Nov 2026 03:05:34 +0000
From: Yixun Lan <dlan@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v2] clk: spacemit: k3: reduce clock tree for SPL build
Message-ID: <20261121030534-GKB156439@kernel.org>
References: <20261103-01-k3-clock-spl-support-v2-1-09a0b28e902f@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-01-k3-clock-spl-support-v2-1-09a0b28e902f@kernel.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi All,


On 11:07 Tue 03 Nov     , Yixun Lan wrote:
> Due to SPL image running in a memory space constraint SRAM environment,
> so reduce the whole clock tree a bit to make it fit for final runtime
> requirement, only a subset clock tree is registered, which includes UART,
> SDHCI, I2C (TWSI), and their PLL/MPMU/APMU/APBC ancestors; while the
> full clock tree is retained in non-SPL build.
> 
I'd like to drop or postpone this patch for now, the goal was trying
to reduce the code size of clock driver especially for SPL phase which
both target for persistent NOR flash storage and run-time memory consumption
 space.. but tested on actual board found, there is enough space.. so
leave it as is for now


> Where surviving SPL CCU definitions reference parent clocks outside
> that subset tree, it will use "clock-dummy" as name of clock parent to
> ensure the framework still successfully resolves the parent clock lookup.
> 
For above using "clock-dummy" clock, will send a separate patch for it,
so will fix the unresolved clock tree warning..

> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Changes in v2:
> - add gpio clock
> - fix tswi8 clock
> - enable sdh0 clock
> - Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-6-c430253e759c@kernel.org
> ---
>  drivers/clk/spacemit/clk-k3.c | 209 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 190 insertions(+), 19 deletions(-)
> 

...

-- 
Yixun Lan (dlan)
