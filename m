Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33C5CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:32:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDA346064B;
	Fri,  2 Oct 2026 21:32:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2ChyWkoNUiXq; Fri,  2 Oct 2026 21:32:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2292B60D99
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976736;
	b=lGWWOm++KkxLS+uDdgwdD/2nqh9rSwj0wYKj+oNDwXP1b/xut7XKyiSU40hV7bKMJ3/w
	 PiYbPDQA0sqkW4kmxLG54BnAUBnTxqu53ZUFPjR1QG33XVzvEqatnHWJ4E+OmhZcWEPeH
	 PX70Co1YkXVtZfmvgw93UDISWAV40XNz57/JA+o/MND0mps8lnlqX+4akxVi+3OKIOaKY
	 UDQNNAbLAAokyHg2/RNXN6U0czaHMPoeS1nFgNfeNx7EtmGaVJZ4snD94bVm7dxZiRQeA
	 +zwYN433bE08VEabv2sMKZQm6uAdkl6q1KMaIe3nXFHNeQOFnpYOCkZMqdHjah4mbBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iRNpwKlEsRnPKPdep5qbFVsFrPEuvWPSV+X/XWyBues=;
	b=Mlc4BS65E4gY8JvfHIiEgUzsIJeSXkivK1UsB6EDewCuBSfywbXVa1vd08Mqnf5InXxj
	 KrWJakG91hMWqblii6X9vNlO/q4MXtbabB1LEg7UR0dVRXXyzD+H3KI9AivFCALD7Aji6
	 zyP60U0SN0IMiPHKUMuArMOdZTX8LMIcA+cZbqz+CYkyvlLqCaTcVYuNWr4zclY5afwdJ
	 JhLSE/soPJHWenV9bc/wffihIyhTUU6kK6ss3+Ap7GObPZYa1SXu7ZeY+EMEXLW8a4A1n
	 RRkrI573+VgBFwhTiYch1E5xwSiFy/HuQ5pac2/qdn1dEdiYNUFlL/nCaTewAtBHrHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976736;
	bh=iRNpwKlEsRnPKPdep5qbFVsFrPEuvWPSV+X/XWyBues=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qww4d3LsSVEz9T5t8uIGT3CjfoXM0IfupZ9w3YDF7/slrnQMARKSH+5YNcarL1sd+
	 aAB289No576chOBHul+13AEZVtF5nBSCf7akJq4KDoenPqjmmvyLEBZF5GOvwngzPZ
	 hwoiXmwqtocF61fRg3C0ZULrlJlXjSEDIdfc3FlpFMMfTIZzIH5XEXfpzoO8ehZ5ii
	 V+Jgz6ChnJdCzlptGXdEz3JHUcnfwSeAKUaSaM0f4ksQ0tDCXMybcXjh2OqaUW7KCh
	 taI5bdNYZDWAeDFm24nwzgCqOuTj8xCoWb1XJTzGKAcmnruKtaOUgI9Vwc6ANRfHPF
	 hObPUPq3z56hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2292B60D99;
	Fri,  2 Oct 2026 21:32:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DECF179
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B25340590
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:32:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6dkMGFpcCgEL for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B266140585
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790976726;
 b=pa/eVWxgaoW87OZS62HU1tjbjZlvDZLQGPOErzk/Jku8akSeF1f9e9T3NXMu6BuTbH2R
 MHSP0spUinwlVd/hz47kqWqrQUiIsQvdSv9JjY6p7tMJbNEORHBnrCrSfOs38JH8ZdZql
 wV6tOfv4QzaKSBylvS8e7f9i1yRIzC3hI1dgQ97AXMKUB/pi5if+eooNxFQUmp/HXIz7p
 fNsATM+RbutUWVM1BfEu2wsVLXuInygSxmzHIhhBnWfjlIzSihIUuAuQdhkNakYaHmHV7
 rdHqRqOpoOA522HvCPe2KZ/ZCXOG8i6v/l2zuwJC5S+V6XT8YdMSk3G0pdVnKwaqKxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790976726;
 h=X-Greylist:Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:
 Message-ID:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=iRNpwKlEsRnPKPdep5qbFVsFrPEuvWPSV+X/XWyBues=;
 b=B3z42TnBbkYJEm1UZwVRuXfmRIRvkmkH3IyAj3kK1U5f/XfwgA4+bz9CU1qW4Fa2YUNo
 7w2qa+k2Sv3hP3bsx+Mg84/O5bc8lT9Eir88kxBssC+jzEOM5iqhGAcSdaWJm0IASQJK6
 qylOumyAs2coumjQcHtEyA5zBzR7TSXaVB3D1ytC4KsChGJ2x/Kr/EINPIYcgcoIxMamd
 dsCIlTRSkyu9JC7bGfQMpTgLVrEU0m+pSnt8Y9LRoZeBnIXx/ayVxkLxcqovtVoagaAqo
 ziAYsnHtdjTY+AWf7WHMyT8fmQXnWInWPhdX9u9cyJMP2hesfGjEUbH5O+FCSiWlLzw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=BSzGTFyj; 
 arc=none smtp.remote-ip=79.135.106.30
X-Greylist: delayed 101 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 21:32:05 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=BSzGTFyj
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.30;
 helo=mail-10630.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch
 [79.135.106.30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B266140585
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1790976723; x=1791235923;
 bh=iRNpwKlEsRnPKPdep5qbFVsFrPEuvWPSV+X/XWyBues=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BSzGTFyjlxbclMnrqupPGY5n/zvMxjqyJTzvsJ3EMud7ilwiZuTpayz/KuA6OhFCP
 1ybcGSGrO4NWoP6xXqQG4FLIdxR8bWBQaXMCXG+hP7r2+GiZ5de6Zkjb9Vb3dnkQMf
 9eyzgI5zx2vc1krI9xN8dY/ZokolnVpMJ4MwcsG57JpKXev+lKh21INiYQ6dKYRbX4
 sSXouS0ub994meqJFGPLB4PPl7rWoaBoJM7Z/h2c2ih1D5N7vJtNIP6XQ8PYCN2uBn
 nrXaMK7lT5Bu/v3cKZDrtAdwf+BdpoWehBmLblvVb8zjVbJ2TTE0c1Rk58Ah9GxJdx
 RoX7q/AlU+1ww==
Date: Fri, 02 Oct 2026 21:31:59 +0000
To: Yixun Lan <dlan@kernel.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Junhui Liu <junhui.liu@pigmoral.tech>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: clk: spacemit: ccu_mix: fix inverted condition in
 ccu_mix_trigger_fc()
Message-ID: <20261002213154.4167570-1-DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 9191d2499210945302839832304eeb1fcedb10a9
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:32:12 +0000
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

This fixes a K1 boot failure too. On an OrangePi R2S booting from eMMC,
the BootROM leaves the SDH2 io clock at 409.6 MHz (divider 0). The SDHCI
driver asks for 204.8 MHz, the divider is rewritten but never latched,
and the SPL stops with "Internal clock never stabilised" / "spl: mmc init
failed with error: -110". With this patch the board boots from eMMC.

Tested-by: Dave Klotz <DaveWK225@protonmail.com>

