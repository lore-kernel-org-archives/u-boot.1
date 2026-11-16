Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D21606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pc445oQP;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=YwNLO60X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 908B240653;
	Mon, 16 Nov 2026 07:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LeHra6PaB_Mg; Mon, 16 Nov 2026 07:44:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19EBD40652
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794815046;
	b=Ogv9uulgNi2A5Xn0ExBN74osDhAt33/IG8SuNOZcIjV5uxxNRg0ZgF0/YpEBZOlvXRgq
	 3JtyAv2//46eymtfOo6Rpn1t/0nGIPdXa7ZsmLyOw18Z1xa9Zt3wpmHyz0iRMat9uPTW5
	 ONu+qBrTxokIRxm1K5GGqQSwuPcln2uQpP2g9SlWmtrmbcpG8rvDGgEDwitdT48JyPE5E
	 p1yS82HeVQ6mGEOn5HdKgHYot5XjiRfCW7jQkTx72QPsCnbA5e3uBu8rwVsHwjz4DDfK5
	 4NNiY5tIBlGHoLvy3bsFYNKBJG2LWXtj2JIfGEDlwddiJRelPeS0pTlwqktCOk0+DDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794815046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uOdyiOB8Lanso1QF9f8+CYxOoZODUt76CHIii9ERyes=;
	b=i55jRsDLwIXjJBx7ngJhOkMxBtPLZFmMzH4djMOpNwQZF7X+XJCtyuFd2aGHAetzvy6z
	 mwlfjsbymptO95X9j4gjARHcpLmhLWyOZzcvCTiXKrLr9vufZhFd5L5hNB5YiOYXg6HzB
	 DhgZxzhJDXMlNS+G6f1cJLPB59UJF823iEzUiCxJEBC/bDCTihr8/toBAnWLlnYMl351q
	 5kCom9iVA1p6VKu4VgTJ0o9qi9DOkg9lgTFpoz9KECQFpgso4WZB1SDkp2HywdtG0S+b7
	 yEla71uC/pwJ2OmLu6xHfwHlsTZIVHEc/Ozr0sNnYHk5IhhxdXAWP4W/ug89XxrI/+g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794815046;
	bh=uOdyiOB8Lanso1QF9f8+CYxOoZODUt76CHIii9ERyes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pc445oQP3lpOWEqvaOqXd8Sk4xRd03uXqEsZyd10UlXRM+HVqfEDfsCL/agOd55r7
	 mtCJe7mrnjZyneF0CsTymCq9DumaM0Z3AenpiN4H9O5sdY3bAgN+M6HQxLMVTzd1Zj
	 NFQEsrsgKA63ZQuNraqHtsiPqeE2gdry6Kc8HNxNBOTpTMUOgFmnnbjgb8EDOxtZe8
	 dZyya1tBI9DJf1C/QYu1JKyoGN7mXEnon4WucHhKyf0XisGkKi0ISwYKpOVntuGZZl
	 ANJid+ZTKo6DmY/qDZu4dlyn6jIdR7BEoluARv+EgEYn5zvlQwj20h+oBWr7dDP+W4
	 qEOnPS3aGCCRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19EBD40652;
	Mon, 16 Nov 2026 07:44:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CCD194AB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B657C400D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40pzVbbyY1_t for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 07:44:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4961340012
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=francesco@dolcini.it; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=dolcini.it
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=YwNLO60X
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4961340012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:43:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE9A483108; Mon, 16 Nov 2026 08:43:56 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E019D83108
 for <u-boot@lists.denx.de>; Mon, 16 Nov 2026 08:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id E033C1F8BF;
 Mon, 16 Nov 2026 08:43:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1794815029;
 bh=uOdyiOB8Lanso1QF9f8+CYxOoZODUt76CHIii9ERyes=; h=From:To:Subject;
 b=YwNLO60X2IrAeV7sEh/Xl1DEjBjNklOqCoTi+Zs+e8bLgo3qV3//gjpAL1ksMaRT2
 HOfHwgY95pOovIzJsewcAJAZCMmNUNUmb7cEG1GQlf5ufxn39ZepfIQwh0ZAxLcS6p
 afLCBc65DrF5SYJ1jXbuWO0bFX3JjCyhj2EGl2YDW27Tu/ScDk+/hiPPlO5v/U3RL1
 zRhB0GztEeW3Xzlxa/7JFrMTJZdzKBd4bvp/RefbujV57jEtBtrQpVpeG/woqJlSzu
 8hixFKfkoemgbmEcEdmVCeM0iXcnnu1Qd2DM8PU8hVwFl4Vkpz0n7BWKwQy6unMCAV
 /oaRgPs5C/q0w==
Date: Mon, 16 Nov 2026 08:43:47 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Stefan Agner <stefan@agner.ch>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] colibri_vf: configure the DDR controller from the DCD
Message-ID: <20261116074347.GB16341@francesco-nb>
References: <20261018195302.2900162-1-mehmet.fide@gmail.com>
 <20261114061936.846858-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114061936.846858-1-mehmet.fide@gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Mehmet,

On Sat, Nov 14, 2026 at 07:19:36AM +0100, Mehmet Fide wrote:
> On 2026-10-18, I wrote:
> > I will report the numbers in this thread
> 
> The temperature tests are done, on five modules: three Colibri VF50
> and two Colibri VF61. Each module ran your two tests, each in both
> directions, first with the current U-Boot as the baseline and then
> with this patch. No boot and no memtester run failed, with and without
> the DCD.

I cannot find the original patch, it's not in lore. Maybe you should
resent it? I assume it is gone also from patchwork. I was also not able
to have a final look at it, but I see no blocker, so

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Thanks for all the tests here.

Francesco

