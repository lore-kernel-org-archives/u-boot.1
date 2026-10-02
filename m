Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05844CA5FE6
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 22:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30C0160E0F;
	Fri,  2 Oct 2026 22:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MS4Z6g7nx6Ed; Fri,  2 Oct 2026 22:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD2AD60E05
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790979015;
	b=ibNqc71uoZRHYsAZEOp3h3GbNy2VGiMJS3Wl0/YUdgX3No2zzIBS5sgboaQEyUpyuplk
	 q+Lt5J6XTxP5/HhAXJnYJ4t6GBc69Onh4qzZqXPVi3Vjn0ILtBCTNSXHV5e1880taqvCh
	 A+K+9Ba2c6KCTY+bqNXT5H49KD4aeFdzCmzy7D2eMTVVGC/neYUwKaJFVtLiMlADaWfnd
	 nvJ6m8WdNZYEiqw90xrdOjO70GO9ALCrm5DblzheMBjWXfbY/0PjfEIfi95HcqGOdhqD6
	 e6AfNKa9nd74kyNQ8uylaO2Gojk58Q9H1n76N64koEU+JqSKLoXMr/+FPurd/3JmJpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790979015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sB5TDdOUCxj8NJeLUwlg9UsMM4PTl89RNOMSLoga83M=;
	b=rPTJGNrPS3eyqIxjJUWydxbXiKrWqlDY4CAWWan9ovebk8jHMvmM6ntSEZ5d4xrmijhT
	 kJJtCL9Z1DznJ4KoxEiHH+ZNQ7Zi9xif4owHhulULkaYvLwgES/PbVOtpbeU0vinAMFKP
	 pxSSnlClZv+v6Bbt5zSQtkKth+r1JmggrzCHVXapTaop/0Wfk6kKphDiuIry6/fB1d+tq
	 tV1kbRcY0WwDEKwU3kuccXZs59HomjgisA85J3I5KVb9T/5po9Mb0Ms+4eS+XX4HQakKv
	 7evBoPD2wfuNXY+YpqXpFC4O62G/AobZ63MpSLTUPtAK3jERBFUMWbFFAPG+y3SrcCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790979015;
	bh=sB5TDdOUCxj8NJeLUwlg9UsMM4PTl89RNOMSLoga83M=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNxlPI484c35ElDimqGJ+a1ESzrHv2PFwchScT4VXiUVp5DUY5ikHCabFAjcyArYl
	 +4eco3U963DIdoQIO4oi2H/iJRiWp+gILORA2ut+GH8xHGZeZEMr1/dYYzZuc5cdIs
	 NAGxbsDGCD1q06nNzSflR2l4x4NVWygdYLW4heUvKKdZMJzwJrNBjHbe0xGLEMT4mr
	 zMeSqrlK4Dqvgh76AaYAU8c69bKNQxsyiDTh5as0qJniqidbR+U/E7O4H5y/6XI+ND
	 UvhBhYy5u5A90TNciRH3/YKRPnO8UJSWypWchmo2qXRIn5qrYdA6u+08qVvruwtbce
	 ORYbraNDAYqSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD2AD60E05;
	Fri,  2 Oct 2026 22:10:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 25C6B179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 172EA40585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:06:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lz0pcNPVApul for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 22:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D681C40061
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790978779;
 b=qXErSVOSB+scEh/cUNvX98hGleArTDHtEJRm94yRweuPIUcyfywOCOWV6/PAG4Ym6jcD
 rkj8V60Q5lxo47m1xWw0SRu8F7F5Lnnf6ODlA9rxFyGOL0X1a2yIefdK0OkkHWhrB8tfG
 tIqQux/noBvpLENacERJHSY9/PfQ2ssoGuHLddbGxhb9r9Kh7nL7PdDXzsmfOEjfW9OYE
 zFKVYWydFhQ5y/+FMMRFfuQFEux7m9LN03GKhHba89rCLrDWBHycXCuPpruiD2YG/Y/4o
 dWFcest4+TgoXfLWb4DJXPsx6X1VQXqk2oGPFgeSVewXtNHyyDwYO1SWvcumtCb62RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790978779;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=sB5TDdOUCxj8NJeLUwlg9UsMM4PTl89RNOMSLoga83M=;
 b=H4EfoXxVci4qz5WMsqxjt3h6hvxZRb1IRTiOkg/+umRDgf0ASdBM+QOlLcDkvguO+y6m
 oNW9zdEatmH24tCJy7er8zgL9ryk1kcSQhOPs3tuEQoWuY1SqkIPlaIbUDijie4Fp2ACV
 35mLdg/Q9y3VtKxvFpjDHVwXNnuyhsHCFlOGMmJSULV9YepPJyXx3IVm/A2r2dvd6H6CD
 S/9UgjdDxpvqTVpXgXwyVndV2GzGlYIs/00QGyJBNZK7GjlST8I4ZZCfGhC7uLdJ7voc1
 luI8l7jwEILr3HcrJrJUHB67F5Tag/ZRD9fazgq5c5hoQIPA4ebmmYsg9meExCibvxg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=AgE8Umlk; 
 arc=none smtp.remote-ip=185.70.43.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.16;
 helo=mail-4316.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=AgE8Umlk
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D681C40061
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790978776; x=1791237976;
 bh=sB5TDdOUCxj8NJeLUwlg9UsMM4PTl89RNOMSLoga83M=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AgE8UmlkwTmTgkCIH/LSs5uhN+VCVy1Ifl6fAG7dTzz+EvQxzfWg/c3VBeM2B15N2
 gWC4Wt9oe3fgIkLsFqYdsTgj/AGp5b+nFLDyX82W3tS9H0lbsoEi6MKD6WTCCw1Zqs
 6gI0SkxxAiS1vW2xy9ssNGXlxYeOdQxFE6R46b5x4LzPOE8/WgDzBBwMnyLJ/F5Dgs
 SvIhBVTKx9T7oDBDNYHcVT4Fi85OEj+GYsFeaoV0NkLnI5BWUeprXj/SgtgAbEfXVO
 Aaz7W3mQXmqGk7R39Fy5FhD4zfbQdyw6rEUmlOUNsC6MHAcAeaMgbPo8L7bPe6D2dx
 PYhRaYo8AaBkQ==
Date: Fri, 02 Oct 2026 22:06:10 +0000
To: u-boot@lists.u-boot-project.org
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/3] mmc: k1: fixes for the SpacemiT K1 SDHCI driver
Message-ID: <20261002220607.314126-1-DaveWK225@protonmail.com>
In-Reply-To: <cover.1790975596.git.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 56133328e59af82b592dc018a1747e4faa59af07
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 22:10:03 +0000
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

Also tested on an OrangePi R2S (K1, 2 GiB, boots from eMMC), with the
same tree as the RV2 runs (upstream next plus these series and board
support that is not posted yet):

- the SPL starts the eMMC (SDH2, io clock moved from the BootROM's
  409.6 MHz to 204.8 MHz through max-frequency) and loads U-Boot;
- U-Boot proper runs the eMMC in HS200 with tuning ("Mode: HS200
  (200MHz)"), finds the EFI system partition and boots FreeBSD;
- FreeBSD then runs the eMMC at 200 MHz, 8-bit, without errors.

Patch 2 (SD only) and the failure path of patch 3 are not exercised on
this board.

