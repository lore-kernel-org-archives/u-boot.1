Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963C606A331
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mT+JunHG;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=mbib9LJ1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA31D60650;
	Sat, 28 Nov 2026 14:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gh_8I1Ae1_lb; Sat, 28 Nov 2026 14:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 633B56062B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795874809;
	b=iHvD5QOkrlo4nFCdLuTc+iqInKp1A67dbmpCDJYbRzNeeTXjvhHjF+T/U6V/43c/kBXk
	 TSTj8f0ywhQ+9mCCeuqELGP5nSMEj9swRKJ82TpieMNgbGi7LG21mzdHklkLIch+9ArT6
	 SKoJNXR9gLyATbkiqz3lV2ltx+Lv8dUHcWc0t6iIFJobMVuzTp+wXrTozmaKQFgwZjNIA
	 pQy3xiYulFV02EplgAbJz8CFvyTZGst1937K1pJaRoRT0OunzdDB/sgx0LXfT1fsIhrk+
	 hOzznSmrcnsKxiPbYDvHlmRIpFT6lHgSHI3OKq8cagKEjwMzHk8PcAvHf7TvMfSLl6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795874809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dss6u7SiutkZB0KPNA2LxD06Du6L9aqiIyXJZq51qqc=;
	b=oCMksSMsSLEQzA72DDUGW3f9lZ3nFrmpdX298858/FoRqS9NuudWrzdoripZk90GWQOE
	 eA4PAQmAPWJrOplEiLB2mRm+PRZZb1FZtUfWiKDkx9+Opp4oDUURHwK3JpAJNHLLGeyuG
	 ybgzgc7tqqOjxL2f4hGIitOL+2wPHDcfKfTcX7xAFVaTh+oZfaa82mvMDhGGUhRqpm0m3
	 KlrdargDqN+0XAmKzRCV3tXRDIA+YCuxNWV3sRMmyXcPUa9/Y/nPKF67s6+42AgW2Xpfe
	 v4oEsxYzFjFv+SCxvHR+a7g5YLu+xtZ6uclGtks5DMRqwk38AEEbvMK+B73Ueo3cX/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795874809;
	bh=dss6u7SiutkZB0KPNA2LxD06Du6L9aqiIyXJZq51qqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mT+JunHGZmE0Tq5XQZNZ23uII7rzrUs/1XQK+i2OugvMwiiW525gCVO1oAQmf2diN
	 upDca6jKL6XPt7CiHc9IxQ6eKdc68DMgSLkDyz12VbdN5UpxYC6fPr7DfTgwcuBKQM
	 WCekbEHvetnVjrLGs5Kbfl6Sblb6WjvsVZKrR+bf2Pd9/cMgwA+Cl8UBo4Kw93jahI
	 ofTU33vgpiCcIbimy43q01w4TdZ0GdMNeUzW3aOcYX63RQtDLJw4EDfSU9XkZselz3
	 S2nXA0T++0zBQ4ThUh82zc5tfGvdj7FLpw/xjRchDLQR+8Hpmvzeo2lNKK1mOenqYx
	 PegkRupVRa4hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 633B56062B;
	Sat, 28 Nov 2026 14:06:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC792266
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 14:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA2C4400CD
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 14:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xq03hMr16_QW for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 14:06:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 020B64005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=mbib9LJ1
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 020B64005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 14:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1795874781;
 bh=dss6u7SiutkZB0KPNA2LxD06Du6L9aqiIyXJZq51qqc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mbib9LJ1BAKmMgzFxWSpK466MVCH8+9aVpQ/fJ8XJyTKlTV8E0jc0mUeFPHDY8i+v
 f5gUZEsWp6z0s9Bnyqs1nV9i08C8Wufn3ayE5Y7WkCearFaf0RpEfLjSflxlsYjnHT
 GlLnh1aEG2uK1Y21GtMqnskz8x0a0SXfWoNgcWsep7qvMLZJD4yOpOHdHzLJEHEgUt
 Mo6UoiH7kBK5OT3IMcTc6j2DQRuQxNH2ZgAEAzTDNB21VsToAvSh2yMS92DqjKkUFr
 4/nh7ljTLQXBM1S7ZUFF+ma72P4uh/3ZuPIYws4vBoIaoVAc6sTYT7XBwZ4najBxG6
 NObGYd2BHGfXw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 179D7B221823;
 Sat, 28 Nov 2026 15:06:19 +0100 (CET)
Message-ID: <8c576549-beb3-4d12-b241-4923c7d67e90@freeshell.de>
Date: Sat, 28 Nov 2026 06:06:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SpacemiT K1 SoC watchdog support
To: Dmitrii Vaniushin <dmitrii.vaniushin@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: u-boot-spacemit@groups.io, eric.chung@riscstar.com,
 alan.tseng.cs@gmail.com, dlan@kernel.org
References: <CAHyrWCPZoVKBKJHR4uHkbGzo9f02UADdbXACemFGroSeZRxBZQ@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAHyrWCPZoVKBKJHR4uHkbGzo9f02UADdbXACemFGroSeZRxBZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dmitrii,

On 11/28/26 00:09, Dmitrii Vaniushin wrote:
> Hello!
> 
> I would like to contribute to u-boot. As I have a Banana Pi BPI-F3
> available, I was thinking about adding support for the SpacemiT K1 SoC
> watchdog to mainline U-Boot, using the existing vendor implementation
> as a reference.
> https://github.com/spacemit-com/uboot-2022.10/blob/k1-bl-v2.2.y/drivers/watchdog/spacemit_wdt.c
> 
> Is anyone already working on upstream watchdog support for the K1 or
> K3? Would such a contribution be welcome?
> 
> Would appreciate any feedback!
> 
> Thanks,
> Dmitrii

Yes, to get started look at "Guide to build reduced SpacemiT K3 vendor BSP":
https://lore.kernel.org/u-boot/20261029001555.1890775-1-e@freeshell.de/

There is concurrently development of DDR init and SPL for K1/K3 in
mainline U-Boot, however not yet ready for general use. Until then I
suggest the baseline at the moment is this guide (above) to reduce
vendor DDR init and SPL to the very minimum without clocks support and
boot mainline U-Boot main app u-boot.itb via UART YMODEM.

If the BootROM loader is in "UART" mode to boot SPL, and SPL does not
set any clocks, then any feature you author for mainline U-Boot main app
will ideally need to properly set clocks and peripheral configuration
instead of assumptions about BootROM and SPL.

You can write support for U-Boot main app and port drivers from mainline
Linux. It is preferred to borrow from Linux upstream first. If support
does not yet exist in mainline Linux please start there for SpacemiT K1/K3.

If I may suggest something the FSL QSPI driver needs a refresh in
U-Boot, and there are small changes to it in U-Boot that could be
upstreamed to Linux. It should be helpful to do this and become familiar
with U-Boot in this year (not 2022) :-)

https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/drivers/spi/fsl_qspi.c

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-fsl-qspi.c

-E
