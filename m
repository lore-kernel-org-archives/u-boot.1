Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F44606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KyO9FqFY;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=iN2t4aTb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0419281461;
	Fri, 30 Oct 2026 17:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7fDl72RpwH-t; Fri, 30 Oct 2026 17:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A05698165F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793380697;
	b=iaPLNl0NdVI8bubHcBZh2J5ztSb8zW13l56H9QvmOdIFm1UNLVkeiomqRGqtctSgqnmf
	 nOghEnZ9bPYvgSg21f4Y2Bly562nn3tn9MLrs0PL8HFwwNpQ+ToxCjpR/EpT5CqAaDh/H
	 4HRrYNM2zos2KpHX9uDcOoWbvcTg45MouClt5KG/gMoRPLwLHUQXBxMkOM+AIFQV5d/At
	 BJ/93HoxifrZmX5hXK8wfTsOReI4yJbZdfUKvcyrF2PbFGCKy8XPK9IrzASmWZRdVB81m
	 c96tBjSFGlvQfAozj9DniB6j8SSqYroNMJRGDDRi9qbpToBt3Eax+/FalE+R8TVJykA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793380697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nGExND7FszrGnP1bcU53gdNJTDb5GOa1C4fbC5DoCOc=;
	b=eXQlqOqR9p30cFgCnPhOQduBJKu0cWlq+f+AngxR0/CLknALTlWndcQT3EV7QR8TLINn
	 7o6H8P603z7zDJd86dAQVtLevWVDb1GRVmuTTW65XSBqxC3bpTDxXcTQpyc2H36NlzFL1
	 OAzfMvLP7kZCcavfWw1Er3WJPzrKQQlK+ZmIeJmIESCtlKhC7u6i1UV27Ow4dS2uUWKEW
	 2CqE5DbE1fBYEtHeItTSX70EulakcuIlwXeSqz4bhRuG7c06XhRwx/6ShzSA52/BJOkkr
	 eODWoXH9BpgZrY1Zvzk69i/Jn4LhDwFHMsN9qU7qURPpP7Kr2a25CkBiWEgmXpKjupA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793380697;
	bh=nGExND7FszrGnP1bcU53gdNJTDb5GOa1C4fbC5DoCOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KyO9FqFYVoqrkLTFw95hpvcfSBSrExi40TjNeDhu5jlguFCesnLlr1YrFXUfoEKyk
	 r8mJKfSa82nYk/y4an+04/XnmwH9ouzXO3RITl6dakCj1u+B36CLMu/1doQBnYpDt+
	 xxjlFvBT1PxkWCuJPFTRdIlgO02nIirCxzzO0yx7veQJ/YpgsWtzybIoaG24SeKT5a
	 qBGrT/OAJy8ZkMjX5fxYVT4SJ3c03gK0tS6PydOtgcZiHPeClECbjysAbNUt78AWiU
	 jLYPDjmox1VcM8U71S222RAPV5ax10Vp8vTCVSITaZkD9SZHz6DKBim53cUYgKB5r0
	 T9mhODbb6Ykbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A05698165F;
	Fri, 30 Oct 2026 17:18:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D4930235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB00960AA4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9BxtRkQ-7mxf for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 17:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5FE2F607B4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::8fa9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793380685;
 b=OL6KSB+oZ3StnHUyqpQsRYaJB/mM8ypJb503yABNFnren9z1GbCh4vASy/G411k3LTNn
 E+5RsUdV6Ky/Mm7qe3ZiIHl70Uiz3eOkYatD47cJ6XvsbnH6x59QVKcU9DPThYMUhmvBa
 YOE6SqaeInw2DTiSOlCfC95gRRBjP6BxokzDT046IcNMyp2Kxj+laWHO32ZEJz0pk+rvg
 rdsx23qwmtDhNIsyfhGm2eEWwKdcViYWsreFFf/4uilvTe4narzEzisWDqhaT98hlrrm4
 hEtM9tXmWe0EWtPMnQDwskdOmZsQ6BGctblrtKppyDRhh/hqCeiG/b+mwO84GL1Sthg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793380685;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=nGExND7FszrGnP1bcU53gdNJTDb5GOa1C4fbC5DoCOc=;
 b=LH6inFYEs1ktYOgJC9Jl128xFog3cwtABMBZsWn9zmvGhV0YUKTshJ6VLyrt+gZuDfJv
 TAR9ToOP0GdWuZ6SRFR8ITGyDuHviQA4dWSpp8exvyAcxE2ln+yikG4enmfWNiSQVOFq3
 DWlSny2y39nm1Vu0AZZpAPqQ1cO4EGlfiD8B3mME+d82hc/XHmZib3yrfGiwF8eWGcsl+
 +q2u5KaPq18U0EnYSmyEUvyFgF+L+6YRVsN2MveNVX44o5hb8FtRZFCctWNvD+i0SvPiK
 aV6Fnwp8G9vBp3v16sNYAC4iyMCSleOFJd44evdhAi35BbkN6poft9rLl16WgV55O8g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=iN2t4aTb; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::8fa9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::8fa9; helo=smtp-8fa9.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=iN2t4aTb
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::8fa9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5FE2F607B4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 17:18:04 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jGSTz2K9czBcl;
 Fri, 30 Oct 2026 18:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793380679;
 bh=nGExND7FszrGnP1bcU53gdNJTDb5GOa1C4fbC5DoCOc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=iN2t4aTbsbv2jG4mQbPtRdjJxNILfEUm9C0iAp/y8iIsDBWjWOPZXobCPBIxtGoWZ
 ksl5ePa+7Xwf8OXOAcsAYAwwWU+4ml4162+dSWVZQk5t7HtHgcNdeY+S8DhIl198sb
 of/MFrN18NEPnhm8qqv2+bSGFmmVvI1wvq8wrjFSzJ3bgndjFU/m8QyG3QK82vIRS7
 1VGSPtCwNwD09JiSVhe/L0Hju5DJLCJCAsIFQjUvpzriXotCpBCmBmaHYvPmwd8KNu
 BSivPRP9vFit/RLPeW4zmwqz0wD7kCVOiF+EIA1cVxQn7wy/pxXWZeSx5ZFBgku/+l
 deZByPoTZh/Xw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jGSTy2TdRzZN4; Fri, 30 Oct 2026 18:17:58 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20261015224222.1582607-1-jonas@kwiboo.se>
References: <20261015224222.1582607-1-jonas@kwiboo.se>
Subject: Re: [PATCH v3 0/5] rockchip: Always init clocks in SPL build for
 RK35xx
Message-Id: <179338067828.786412.2512378148634524331.b4-ty@b4>
Date: Fri, 30 Oct 2026 18:17:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 22:42:14 +0000, Jonas Karlman wrote:
> The RK35xx clock drivers typically initialize a few clocks when probed,
> with some clocks only in SPL. However, the clock driver is only probed
> on demand, so this initialization is fully skipped when there is no SPL
> consumer requests a clock, e.g. when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the SPL
> boot_from_devices() call.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/5] clk: rockchip: rk3568: Ungate PCIE30PHY_REF clocks when PCI is enabled
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/1d28b4d1e2c164d03953a5ce5efe1732046401de
[2/5] clk: rockchip: rk3568: Always initialize clocks in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/fffeb5318d01427fcca8218ea853b6f43f8f9d34
[3/5] clk: rockchip: rk3588: Always initialize clocks in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/514663543ecf9aa24320efb68994b7ec87b1cdf5
[4/5] clk: rockchip: rk3576: Always initialize clocks in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/62cbf47dc054e4d3b1e7768bf6e854e4d8cd0f53
[5/5] clk: rockchip: rk3528: Always initialize clocks in SPL
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/41da99375dde5645941df10a0bf407bf623132a1

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

