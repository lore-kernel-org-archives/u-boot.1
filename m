Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C785C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 19:43:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDAD3605E9;
	Fri, 14 Aug 2026 19:43:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qEg_UvXTRXcw; Fri, 14 Aug 2026 19:43:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13166606E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786736607;
	bh=evPOrgWf9BHFTcv0OW6ogmlW6BKWB6SQzuhSZHosoQc=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TkHBoZWs+1hPPrv/e8YqiHyPwAha7Hi0Idauc3DguVM79hlOpc+qFnG6p1tWw5VhV
	 25RZowCSKKgiIy/dGiRiNN64CbQ8Vz0E7zcj22rEbB1uSwNF2lJNKLsBQXGBb8oGPs
	 x9J2dtsZSNupumlRLMQ3qqqSyxi8AiBD6YybC8z0HFnqTd+LRSzcNhh102o0/lby/7
	 rOA9WX9F+pTbW0JBHuhEhUj8qfsacwbOuH3DqMTKQt/VFTZjAQBoFZjWMr+aMVT5bh
	 vK3R1CjdwpRoUs1gr2AIXwOltKIX+xuez2AWGVgEyYMd1zxn/rd5ViiTtRxMsk3pMY
	 UMxKS1P/7jW/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13166606E2;
	Fri, 14 Aug 2026 19:43:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 022D723F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC3964080E
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRI-2YE3oOID for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 19:43:24 +0000 (UTC)
X-Greylist: delayed 4117 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 14 Aug 2026 19:43:23 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5D35640797
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5D35640797
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=bS8F2qJL
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.31;
 helo=mail-10631.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch
 [79.135.106.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D35640797
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1786736601; x=1786995801;
 bh=evPOrgWf9BHFTcv0OW6ogmlW6BKWB6SQzuhSZHosoQc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bS8F2qJLJK3hUhTAp83eIexK5pQixGSfbIbiVQJga5WBHI9tmM5aVCKXMmcphQ3wU
 ovDPONcBOexEARvbqJCFn8K5uAEM99Uas4ZYklspOhvILxpUHIouJy7HjJxQkuUxkN
 hj+F1k0a/UEDBQgZjxGSgAIZymmTpdQX5YjSjjRm5CnByS4qL+Zep/fSr+SHsZYDKA
 WVkj6j7DTZUesmXj2y2EEeIeGMuEknwrBVmQ6MS62GbsadgF+Gj4+D80v9YgMryLj6
 fPkRaprmWs0YWOy54NipVRWSgnH7I2Z6/vajOZfzymt1Jwhb2pCFGfrfAmR78xIqwt
 TpRs9kIFg7dbA==
Date: Fri, 14 Aug 2026 19:43:18 +0000
To: Tom Rini <trini@konsulko.com>
From: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <259e9abc-603d-4a07-bd6f-41b357abef49@proton.me>
In-Reply-To: <20260814185328.GK3297518@bill-the-cat>
References: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
 <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
 <20260814185328.GK3297518@bill-the-cat>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 3b7847b4530d2bb343ed30a42dda41ba7179ad20
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Thanks for the qconfig pointer. It caught a mistake in what I sent.

The count is 47, not 41. My scan followed #include of .config fragments but
not defconfigs that include another defconfig. That missed am6254atl_evm_a5=
3,
am62px_evm_a53_ethboot, am62x_evm_a53_ethboot, am62x_lpsk_a53 and
sandbox64_lwip.

qconfig -f ZSTD reports 43 here. The other four are sandbox_nocmdline,
th1520_lpi4a, turris_1x_nor and turris_1x_sdcard. They are missing from my
qconfig.db because 234 boards failed to configure without RISC-V and PowerP=
C
toolchains. Treat 47 as a floor until that database is built with a full
toolchain set.

Size numbers are unaffected. Those five are AM62x and sandbox variants. Bot=
h
families are already in the table.

I will try buildman with the kernel.org toolchains next.

