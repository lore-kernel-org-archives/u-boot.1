Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340C606A332
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UwvUG6Bf;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=f5R4pueP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9322440748;
	Wed,  4 Nov 2026 08:51:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M_-CwC25bA6f; Wed,  4 Nov 2026 08:51:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 12C23406F6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782272;
	b=r86mgj32oRAHinXm5ziiwzCho/aSr0gtHlMWwaLbNzufxF0uJWDdSp6EEo2rg5oG1ma4
	 xSZp/wktNUNkE+NyWk7taaXJyFOY3bzHeNSq/I+XE0ctdp6Nu9HoBHk81tXM7u25DN2Ev
	 OaivzbU3MA74pGb/5xuFmJ95Ilm0o8SK6FVlxUq7aBOFy91LX5N13Y6BYBqN6GelJbXhj
	 qKKQUUddT+819brMEg0OL7K/uHpAV3O2oSLKt8WZP13MYMzq63H7HuwfPJGNVgxEw33se
	 SCiOT2hPAQcZc55HbEqJ8FAsMuzd225hfjSH74wmLi+dCoMWH9Ib5ynGtqWOr90b7DQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4KN4rMkZPijK0aNUNzccH2Bjg7K/OhTRKfWo3KcyqMM=;
	b=ArAOAY0jHEEYvyL6wf7GQdFAFqqQgIYthWPgoulnU6EYbIDcIaYPLg5AX/AwufYBujYB
	 16COIGe1b+AyXgSvwkKBE7QlEP0Rf2SzXZqbqhzJ8q3bxOu8qqjkPKaVNNjUAyBoGIY8Z
	 8LxFL5vPp9vRCvlX1NQyZ+P2eX171bJu2slwE3sEhkexT9otAmed+eiX5QXC9MDMWpESP
	 YcWfiS+QFCETRlPyyNXFAaPE/oTgUzZZL0yjBtgtStPeW8BgS7WCGMBaL3lhwfuahFeKF
	 +KT+6k9aNoc82MQ/k7mCJgIwW9ZEIuG9rc8lqBb9igeedvDasIWZ5Lyi5NEfsqvbCmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782272;
	bh=4KN4rMkZPijK0aNUNzccH2Bjg7K/OhTRKfWo3KcyqMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwvUG6BfO+rENFPMY3M3LRfGQ4NeZDRpBmgB/xb2qKIJjYst/+X/b9uB9TlMwm1/s
	 fBiKN6NUKJ+4BnPUrx7fyVf4KXyzoT021Ylm876LaPD5N4WKinw2qlQ7igEkt/HJDB
	 chFxGLBLOpINfXCeNkaj6dTfu+eBA+quJD6ie3M6SZfFGfjkxv1sScLWCDQmWUPLW+
	 m6YxJzRrJQdZZV9Ka/iItNzAG5meDJYueP2DMXMH/mRCYxVO+8p7ichj532GdfN+D9
	 asePwcQFP1RKGybmDbxLPhDBQ44Pm4XaAkuo2qJ4e4mEXgByANShk9Awl2qmsAVYZw
	 2e6sv71dpNiiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12C23406F6;
	Wed,  4 Nov 2026 08:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F95A2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 461DA80E7F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHmoOS0lw6j1 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 75FA780E95
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782267;
 b=OvKBKV8ORnit0XVWcatqUpqXSZ5DLJ7JgS3Y1q3dH9y5imxpF5bpuO/2mQGb9f6DqgGR
 KQaLOXPmohxLV2vd9rLHYl+zSdOI5qDfOOzy//Yl9GmJaVVv0GnCUarpkFK8OI0Xrqhuh
 lxzkMCXA+CoIEGi6dCfOfXdvDXjQlkM6xyNU9KSfRJZhkYT99T/H7S3P+wur5aQ56AUeJ
 +ykyzPG+FMxODhOU0VeEVSkTxjdtK56GRSQrWgIgJMaoFZ2TJD0fAUq0+Xa4K+OUZUs0a
 oPuvd2dqJCZrN+aQUonCUVapl2a2WxL4LOXw+l3kJMFDq4gkAFHQnGON7j7679W7jDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782267;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=4KN4rMkZPijK0aNUNzccH2Bjg7K/OhTRKfWo3KcyqMM=;
 b=aG/DnVyJ02GWfwhr3Rk9V5jyXxnEOP/OWLvRne3fHBy7/CHpvK8IJhtkGxuwQqh2kyKH
 4xoZ+C55LcCUal0ywJqfLgR3k8kShAA8hx1NyYfAbglA/KwQUmGnu+iFlB2188d8X8stK
 qlXhtdrcSDCJEAZCYF2Ier+Zj39we3MI8Zz1EZr+wkFtCT5S5dXojKD6xtRyAHdNUZEpv
 7wtQ/zZqee7gEK6FjwB+GPrj/nc2amKXw0itM6viE7qoUe28Hj5P46Gai6hnXGeOIwmku
 AbhsVkDxSZ4eoyLmozUK/eyEJou1gGixeb+9afn58Gs1boGP1dulUVmDgm/gRUzjS6w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=dolcini.it;
 dkim=pass header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=f5R4pueP; 
 arc=none smtp.remote-ip="2001:4b7e:0:8::81"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b7e:0:8::81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=f5R4pueP
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 75FA780E95
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:04 +0000 (UTC)
Received: from francesco-nb (93-44-34-201.ip95.fastwebnet.it [93.44.34.201])
 by mail11.truemail.it (Postfix) with ESMTPA id C5D641F935;
 Wed,  4 Nov 2026 09:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1793782260;
 bh=4KN4rMkZPijK0aNUNzccH2Bjg7K/OhTRKfWo3KcyqMM=; h=From:To:Subject;
 b=f5R4puePk6C/sHdPzjybxwApH8U7I6TErR1l27NWvKwO4jGnSIBSnd6gB/ROHVBBH
 WVvN5+9P+n+dj9UBEubT2s1B3MAuzGDh/eNvHE6wmPBGurXe51r2zod9irDWcIXPdh
 huIeYB+vcQyx5ZQ/Jac52Pg/hyHB+ChzstEdcgMJfGkvW0Bq4Ko69mTdBg0k8OvFec
 F4g2MvSkCRYShmUeR6FBSvJFmpCxZO/Nm5EsFYa1CkzYpKMuA1vw+9xhT25PRoI/dN
 YoHcyymWmPbv92zILIe/gSM37Bmv8mOtHa32RcDyDVxKaXbCep1+UdR5bJnWav9H3r
 fR+Y4yu0nr2bw==
Date: Wed, 4 Nov 2026 09:50:49 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Daniel Drake <ddrake@baylibre.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Simona Toaca <simona.toaca@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Torsten Rupp <torsten.rupp@8tronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marek Vasut <marex@nabladev.com>, u-boot@dh-electronics.com
Subject: Re: [PATCH 1/4] imx: enter fastboot on USB serial download boot
Message-ID: <20261104085049.GA810881@francesco-nb>
References: <20261103-imx-usb-boot-fastboot-v1-0-f3a918d55a20@baylibre.com>
 <20261103-imx-usb-boot-fastboot-v1-1-f3a918d55a20@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-imx-usb-boot-fastboot-v1-1-f3a918d55a20@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Daniel,

On Tue, Nov 03, 2026 at 12:39:22PM +0000, Daniel Drake wrote:
> Various i.MX-based boards can be booted in a USB-serial download mode,
> where the bootrom pauses and waits for an upload from the host.
> 
> The documented and expected behaviour is that a separate host computer
> then uploads a U-Boot binary which then boots into fastboot mode,
> allowing for storage devices to be flashed, usually by the 'uuu' tool.

Why is this i.MX specific? We (Toradex) have exactly the same on other
boards that does not use any NXP SoC.

> 
> This is implemented inconsistently over different boards, for example
> within the i.MX9 family:
> 
> - i.MX93 FRDM: fastboot mode only activates if "bootflow scan" fails to
>   boot an OS from an available storage device.
> - phyCORE i.MX91/93: fastboot is prepended to the default bootcmd, and
>   the board boots normally once the host ends the session.
> - Kontron OSM-S i.MX93: bootcmd is replaced with "fastboot 0" and
>   bootdelay set to 0, so U-Boot stops at the prompt afterwards.
> - Variscite i.MX93 VAR-SOM, Toradex Aquila, SMARC and Verdin i.MX95:
>   USB fastboot is enabled, but nothing starts it, so the normal boot
>   command runs.
> 
> Implement a common i.MX handler for this, offering consistent behaviour:
> on a USB boot, prepend "fastboot usb <FASTBOOT_USB_DEV>" to bootcmd from
> the last-stage init event.
> 
> This handler takes effect on i.MX8, i.MX8M, i.MX8ULP and i.MX9 families
> when USB fastboot is enabled, and only when the bootcmd has not been
> customised by the user or by the board code.

How can I opt out from it?

Did you consider having a new boot command variable.

if (bootcmd_usb_recovery && booting_from_usb_recover())
	env_set(bootcmd, bootcmd_usb_recovery)


The issue I see with this simple proposal is the USB instance number,
but maybe this can be solved?


Francesco

