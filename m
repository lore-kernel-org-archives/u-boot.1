Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5A4C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 16:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563E660747;
	Mon, 10 Aug 2026 16:05:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VL1hSLzx4THN; Mon, 10 Aug 2026 16:05:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 516A860730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786377948;
	bh=+vHONdGqC0wQLL1UzicOAR6/yp69ckE7xpVAEf2JDjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMu9wiL2ZMWgwO7uw9bstxiijPcqk1ldWoc3HZ+SbLJFgenif6o5iO/u0++/DmjKx
	 9uqlej6Q7O4GZ6H60fV1Df/lXSRLtJ8GGJLhjDYN+Q5QIeo4rUQohjC6TopYR0RS8f
	 Y00smsIlykuwxBam0OR7XoH0HwdsXsff01dzclqC9TItim7dzUIZZFJfxdd3hcwDLU
	 EQWF2bqjzdrk0plU0tW9xW6fubkkr3yMiVTeV2qj8DwRaaPnXHs5P5VipzJQlf/Mo3
	 KadqkxqQP47IghztyhSrDkBSLTSVzGxXSip5YNXoI+3k4NKFkxF7YXybKdU3tCSlm9
	 FfM+H3IbG+g/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 516A860730;
	Mon, 10 Aug 2026 16:05:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0C99218
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C70D740159
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rXks4xuqmCxy for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 16:05:45 +0000 (UTC)
X-Greylist: delayed 512 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 10 Aug 2026 16:05:42 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3E2F040153
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E2F040153
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E2F040153
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 16:05:42 +0000 (UTC)
Received: from francesco-nb (93-35-5-212.ip52.fastwebnet.it [93.35.5.212])
 by mail11.truemail.it (Postfix) with ESMTPA id A72081FD14;
 Mon, 10 Aug 2026 17:57:05 +0200 (CEST)
Date: Mon, 10 Aug 2026 17:57:01 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 0/3] board: toradex: *-imx95: add support for
 Quickboot autosave in SPL
Message-ID: <20260810155701.GA96805@francesco-nb>
References: <20260807114200.271420-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807114200.271420-1-eichest@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dolcini.it; s=default; t=1786377426;
 bh=+vHONdGqC0wQLL1UzicOAR6/yp69ckE7xpVAEf2JDjI=; h=From:To:Subject;
 b=o6iguFeXxcXTHZH4RIkGoIi4+qPvlMeUvi2wV+gIo0eljwY85a10XH7ydCKWUdI+h
 eNSfJH0Vdu6Z4vEgPMyfacHiKMFrlwz0k/43b8zxMDPjvL19kIfwd6FFVQbglC5WAI
 H8El1SzoaD99Fs9f12Gf7JzqGSQCS/IVvZ3LkyD6TGnf6BQIn26VYQ8Ys6nBP6JE6z
 EJzNFMpMjwP13bsQIku044p5RvffaU7oQfUM+zotf9vEPX7BL1AcuqRqXIdq/vzysL
 OMp13QBtT3iUliz/LVBuuHDnDxDAXFgMXk8ZP0p7wpoIlBwmj3Bz8OtKiEZLxZHWc0
 Gxe5mr4/eWq3Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=dolcini.it
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=o6iguFeX
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

On Fri, Aug 07, 2026 at 01:41:51PM +0200, Stefan Eichenberger wrote:
> Add support for Quickboot autosave in the SPL for the Aquila, Verdin, and
> Smarc boards from Toradex. Quickboot itself is enabled by default.
> 
> Stefan Eichenberger (3):
>   board: toradex: verdin-imx95: add SPL quick boot autosave support
>   board: toradex: smarc-imx95: add SPL quick boot autosave support
>   board: toradex: aquila-imx95: add SPL quick boot autosave support

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

