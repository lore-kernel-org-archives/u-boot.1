Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7D606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jgrrN/sp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuSZcPkN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DA3040959;
	Fri, 23 Oct 2026 01:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7NaG6tni8vI; Fri, 23 Oct 2026 01:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9765D4095F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792718212;
	b=JkvEz6F2/VEQg0yD5J6Yxrm4LcVM6zCB7C+TGpSSRSIyRQFs5JkRHGCtjNRu3rd5UsfO
	 2SFTuEz1DkK82KDY8rVUh6on/93digpbDNkP2XDOxmNQqXLm53TfR/PNfZ9PItYLC5Tnx
	 9ZRAJk0YzhTWc7HrOl9ztIEWUkPMQ/cX6j5tojSS5CJfmxjI2izsjv6Fm7g/uOi580Xi7
	 pmWgQajXhkaiL/X6th99s9Vw+dEdEmftYOMOcaoiHZ2B8tDSkHfUSG7xvB9sUbt/0ZgFX
	 ALeUsvPJoYwBOCW7eLlEEPkqefi/sgFKCo6mWIIbURVfsGwx5X4MYwnC+9eYLEodFWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792718212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iefIHN9tLuTBR05r1wgKjImNW7mhzVgF2TvQ+0PaOzw=;
	b=J7F5WS88+QvwrP08gWP3MFf2u3WpFwf36WDnOdlWCgAq5oePajzlw6TEF+EuOg7gODLR
	 c0zbElBs9MCHbUO33C9XDjh1Tgvy0as34guf76TkNXmcobXsJsOr6wFOusn0IK/vQCoU7
	 U8GbI0RBwlhwxTIrhViNkmN3pFQoIT00FwHOWVR4AqT5hEvL5boyLNV7MfBVa2yY19Pzl
	 U6VBOgR/bCE9CeM3LWi//0+wfs8t5R3yQhCbIxZnCp+BJV0Nh3+J9sPUuU9NKD8AyAt7D
	 NzcL8kOV4TGl8vk4WkWWER393mWmkGcXVJgkScj9Me2gpoq0jVnvaqEjcpnQUjfADpw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuSZcPkN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792718212;
	bh=iefIHN9tLuTBR05r1wgKjImNW7mhzVgF2TvQ+0PaOzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgrrN/spmD6YwVfwoHtCruhXMWiGDq5dKRa6jrObLnD2l4zKLaF13BoWJKm+kdr4Z
	 23SQeFeoATdMrYeUGZTXM1bwCg95uoKep8PpjQFIkqD1uz3sTejSxBI+gBqm+pSrXz
	 wYjjRAWB0Tn9AKYMm5I7Ra1hMlJ6sFVQb2+ttTxyaQArzaAHiYAZmZppYX0Xhck5VA
	 8WdVTN1d5E2yHEtdPCOXIpXCfh9v8p75JIJ47dt5LbYg7QLWJnzuuGRb9VxXnI20KO
	 st9wMmjY1qtVicPMh2LVfS24zhomDzvIRmjm5+F8Zx/wMIHOzG+fIlY+FbntxFgZkV
	 pAbO3XGo3TvvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9765D4095F;
	Fri, 23 Oct 2026 01:16:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CED8A49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C03854095F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYdoyJPoaLRq for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 01:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 028D840959
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792718210;
 b=W28LurLEioO2p73S6KUbfH9zxcsE7EIUhBvvBCmYDp4yDVSUN3Fw1sbOOl8sNe7tptyf
 ihm6FaQyX1TX1mo+fGOSTB6Dc8hyezo8JJ6n2q1SOTSWPceSGKhQr8bbv6I7zPkBuOltW
 yEiZRltC6iJPjdlq83+L4VXWVSw2xR+44MIPU6z7ktTzlIJOZUoApVAVPxrDlORtf0SLl
 DQ4fMGAv/ktgykTWn3Qcixibst5lBjUCE1RA2l+wJUISU3ttzR7nwbkGx6795MmOpYV2G
 luD/kBFwtAx7Xu3cnJQoMVDtXV7gnEuaToHm3/BJGOduJtFkLqpZrkl/GdkaMJykJMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792718210;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=iefIHN9tLuTBR05r1wgKjImNW7mhzVgF2TvQ+0PaOzw=;
 b=Z34udnzIGH56bjYUovsaOgInCqhcTH1SyUMy4aPoMsBPg0TAopndm/hmA2wz0ZpSSDMx
 5MA4nBWZDnUqGHPPds5VEr4ybpdW6xDb+tMId3hLev/5slsdyZJ6wFvZtVbdN11NF2PF/
 cmXX+E58rxMN/PYKOJ+P1dEJf2u6rmcG3an1VrG1D1gan60RdMp86jMrVzSPdVtq/+R9Y
 /K34NIL6u6TWdqvCVN6AubmIi/8cW9vLD/9pXgPBevNzV9lr8TtSiT920SLuQXIxVWGGZ
 5KL/7mgtzTw+DV3hDjzXvewjOm4aXUgeGoCvmPt8Nh4sY5rBZi1ZSKhmdsXcj+eezIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BuSZcPkN; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BuSZcPkN
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 028D840959
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:16:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABF4060252;
 Fri, 23 Oct 2026 01:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662AF1F01825;
 Fri, 23 Oct 2026 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792718207;
 bh=iefIHN9tLuTBR05r1wgKjImNW7mhzVgF2TvQ+0PaOzw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BuSZcPkNts6QZ307Cizr390yQ8UMOds604HBFHjJA8C7YTI1QWlgawC0P5jXg5P4K
 2CZXC/1i8N018R8tfvEgLwTJZqw04u7FEGxk3619VGPK1EonYsr3oMhSFxU+nnJ9Um
 JV8sNc9NHcAFIfognY5yAg8JbM9ae7ahC/CUqN5iAWTRGVElyOJDzsJxFHai+9PTRY
 1up6fddZk4cmQejAKvBqDSA05mxdCHgvkwzRu/utzMegVPnehtcmbDiubIyCBLvFtQ
 Ejaft3YxpHXkoHAx7NV0c2LrzPeJrCN8tf7/H7aYXRPRewHNmg5G6P8+5ApXBhiDYP
 EZ6Wkn5t7wuiw==
From: Yixun Lan <dlan@kernel.org>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Dave Klotz <DaveWK225@protonmail.com>
Cc: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io, Eric Chung <eric.chung@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>
Subject: Re: [PATCH v3 0/3] usb: add K1 USB2 PHY and generic DWC3 support
Date: Fri, 23 Oct 2026 01:16:43 +0000
Message-ID: <179271815510.299005.3575646055531013746.b4-ty@b4>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792007916.git.DaveWK225@protonmail.com>
References: <cover.1792007916.git.DaveWK225@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 14 Oct 2026 19:59:55 +0000, Dave Klotz wrote:
> This series adds USB host support for the SpacemiT K1: a driver for
> the K1's USB 2.0 (UTMI) PHY, which the K3 shares, a flat-node entry
> for the K1's DWC3 controller in dwc3-generic, which already handles
> clocks, resets, PHYs, VBUS and the host child for other flat-node SoCs,
> and the defconfig options to use them.
> 
> The v2 USB 3 tests also used my combo PHY series [1]. This series
> doesn't depend on it, and USB 3 on main without it is untested.
> 
> [...]

Applied, thanks!

[1/3] phy: spacemit: add K1 USB 2.0 PHY driver
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/7bc8535d9c2e991ee107b0312928f2b6178ff6e0
[2/3] usb: dwc3: generic: add SpacemiT K1 and K3 support
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/f0e8c5519b2629fb540a8119b00f2852a2b94f88
[3/3] configs: spacemit_k1: enable USB host
      https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/commit/e45cd28e7355d39a216766e424f73eaa4d709984

Best regards,
-- 
Yixun Lan <dlan@kernel.org>
