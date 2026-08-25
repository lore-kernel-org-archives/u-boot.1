Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87DDC61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D06F6073E;
	Tue, 25 Aug 2026 22:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwvu-hW8LnSY; Tue, 25 Aug 2026 22:44:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787697865;
	bh=i6r73XDsKJAWJhoPd+zBVK1LNcoM/kJwTDr3I7kjl0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4qaeH6FAUwNpvLGW9a1KiF5sbIEY9yVkSJDjlQfsVxdyACFuOwqbvZQCGGCz95g3
	 bg845V7M88tlYL21Odshfz1HAmcAl0GpeEDp260NzZqx3iYmm54pRNGO0leKpTp9Ji
	 qdPwZhXT8kIPAIJQaFt4i0i/GVFMe/J27rW3ipsF9qTokbjZkP1K+JCPuyVYTISVkO
	 X01KFCtDko+8jOJJGOGEPtadKlyS/6e3DeY7VRkgq+3jWHxW3PG9S2QXrFEd3kMFjd
	 fCapD4tSN/8K6qEpMDtQuSAf9oeV8xYC3DR4NTk6XDaA4ZrfrOnLXNUcNuBXZqRC1u
	 2lIu7VErmearg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BB47606F6;
	Tue, 25 Aug 2026 22:44:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6ABF63C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CB6B80B48
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoOU0VlDAYPp for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XGeXJM6y
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8F3380AC5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06A4D60053;
 Tue, 25 Aug 2026 22:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE791F000E9;
 Tue, 25 Aug 2026 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787697860;
 bh=i6r73XDsKJAWJhoPd+zBVK1LNcoM/kJwTDr3I7kjl0E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XGeXJM6yosz7J5cHB0ccnXKlNb/1vupmnqBWcIFzMT1l8wvk94uvwDCcFGz9YTGWz
 B/GC3H5BuDNHzFFKNUSW+IY0CqhydTAtvGlcevrjgx0xO7WcDxobJkQiaIAAbqR2jo
 yXhus/qLMlYEtVliDL7vniUYCo1oPVtLv+DAXMMnH/clYHZoNQflGFngOxxOawv1qq
 D+SsyhPSXYpXsJmvfZdslBCfN5cSFDuooUwjz6cN6dureHpCQVCy1n5Q6ajeowCPh3
 ashGXVjJhRVhjjR8Y39S4vgIDHfrDgEgIdt/U9eWp9iXay1s12sXwK7J3E9iCWDekK
 xpHPomyt3pyfQ==
Date: Tue, 25 Aug 2026 22:44:18 +0000
From: Yixun Lan <dlan@kernel.org>
To: Bruno Banelli <bbanelli@gmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong.xu@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] board: spacemit: k1: accept the "m1-x_" TLV product name
 prefix
Message-ID: <20260825224418-GKC631715@kernel.org>
References: <20260825065257.69536-1-bbanelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825065257.69536-1-bbanelli@gmail.com>
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

Hi Bruno,
 Cc Guodong's new mail address

On 08:52 Tue 25 Aug     , Bruno Banelli wrote:
> board_fit_config_name_match() derives the device tree name from the TLV
> product name held in the board EEPROM, and only recognises boards whose
> product name starts with "k1-x_".
> 
> Boards fitted with the higher-binned M1 part report an "m1-x_" prefix
> instead.  On those, fdt_name is left empty and the function silently
> falls back to "k1-musepi-pro", so an M1 board selects the wrong device
> tree with no error or warning.
> 
> A Milk-V Jupiter fitted with an M1 reads, from the 24c04 at i2c2 0x50:
> 
>   00: 54 6c 76 49 6e 66 6f 00 01 00 1a 21 12 6d 31 2d  TlvInfo....!.m1-
>   10: 78 5f 6d 69 6c 6b 76 2d 6a 75 70 69 74 65 72 fe  x_milkv-jupiter.
> 
> i.e. TLV code 0x21 (product name), length 0x12, "m1-x_milkv-jupiter".
> 
> The device trees are named for the K1 in both cases, so accept either
> prefix and keep deriving a "k1-" name.
> 
> Signed-off-by: Bruno Banelli <bbanelli@gmail.com>

Looks good
Reviewd-by: Yixun Lan <dlan@kernel.org>


-- 
Yixun Lan (dlan)
