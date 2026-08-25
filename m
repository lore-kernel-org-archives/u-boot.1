Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81FBC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E0B96076D;
	Tue, 25 Aug 2026 22:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id itrG16qvBOoP; Tue, 25 Aug 2026 22:50:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698259;
	bh=1GmxaSIsezFocFUu7SlvEJ3obRb7xjDspkH7VSgZsQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTKW3vvUTxNOipdhB1EFYIHhTS2Ezsm1vJdR+5HKIoRo/EgJ+sgpE8KOOxZE9A3Vk
	 N6tuZqchhXoMHcKxktWyzJE+uatgzihOvU5dHyWTqI8QypTAGqCPW+neInH2s0xyG1
	 UxokcXFf2DI9FYlvkeQpC8KQQ+sQFTA5+kIHc/2OVTW+EnrsxPySlaBBDdjbo9uoHm
	 Sn1PRRzabojISy85Wigea3y6z4eOQjKYUyq4njAhcMv1clxr+dzZ1HMWT3F0NsWi6q
	 4whhdR7gQfNqOf2bEUgEwNlbJZU3zuxM0+u7eoUcwaVkot4NGZRJB7+A6/zx+REKgL
	 daGAkfcW8lCcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56D1D6073C;
	Tue, 25 Aug 2026 22:50:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 37DFB334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35AB480C84
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeIcK5TnNx9P for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:50:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=V1MrIfTS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F19D80C81
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:50:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DEF140A86;
 Tue, 25 Aug 2026 22:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2871F000E9;
 Tue, 25 Aug 2026 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787698256;
 bh=1GmxaSIsezFocFUu7SlvEJ3obRb7xjDspkH7VSgZsQU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V1MrIfTSBJad4Y2dVW6t5m+GewAdlJpfqLp63gHwu1UPlFpozmJkHUHLUiUQL+3Ts
 tWVFwTTlwc6FJ1bLjr2lYXbm3OqixBotsDlztA2+so9BsCMA2eyVjqe6TH2m4tDf87
 E1mROgclg2NupD7+CZ61EGAXZM8/4JFeCQY2N1fsytpM/7X9oGUv0t2lVAgwWyFkl4
 ZE56Whg8AgKZ017yPYeIEgCp1QIibs4AODjnRJoWqceEhuNwAz0fufxpDOgMOAjGLD
 kMf7rwM+sK1z74F+75lwY6EFE9hCvlLZ/uM000SPID4fiPHBsr+awSjPOsvgwa9zqK
 sibw/4qY4/Tyw==
Date: Tue, 25 Aug 2026 22:50:54 +0000
From: Yixun Lan <dlan@kernel.org>
To: Bruno Banelli <bbanelli@gmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
Message-ID: <20260825225054-GKE631715@kernel.org>
References: <20260825065257.69536-1-bbanelli@gmail.com>
 <20260825224418-GKC631715@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825224418-GKC631715@kernel.org>
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

On 22:44 Tue 25 Aug     , Yixun Lan wrote:
> Hi Bruno,
>  Cc Guodong's new mail address
> 
> On 08:52 Tue 25 Aug     , Bruno Banelli wrote:
> > board_fit_config_name_match() derives the device tree name from the TLV
> > product name held in the board EEPROM, and only recognises boards whose
> > product name starts with "k1-x_".
> > 
> > Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> > instead.  On those, fdt_name is left empty and the function silently
> > falls back to "k1-musepi-pro", so an M1 board selects the wrong device
> > tree with no error or warning.
> > 
> > A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:
> > 
> >   00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
> >   10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.
> > 
> > i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".
> > 
> > The device trees are named for the K1 in both cases, so accept either
> > prefix and keep deriving a "k1-" name.
> > 
> > Signed-off-by: Bruno Banelli <bbanelli@gmail.com>
> 
> Looks good
> Reviewd-by: Yixun Lan <dlan@kernel.org>
sorry, have a typo here ..
Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
