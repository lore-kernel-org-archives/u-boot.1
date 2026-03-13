Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D088F107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495AF842DF;
	Fri, 13 Mar 2026 22:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="H+1QIzbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3AE8430A; Fri, 13 Mar 2026 22:06:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5872A84286
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8936=BO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773435981;
 bh=O5i6Mv4W63gAMfHD1Np1ozHU//YFFMzCmqejf1GePM0=;
 b=H+1QIzbq+ukeTPP57hnGZ3pQ9DskEOageg3en18e89x1DTRXEu1lLLH1kmJs9m0PQNDLixxMz
 3o9/KAuwL338Rq2NzuDj5iwD4X5fgIUDs9xPEVu13iHShZdeO9O6CrhF0qd9QsCeucHv8kfhhIf
 v08jej5ydCvEm8e4YvXHroN+dgwN9Xd3FQFUbNZE6LhBO5PE9mYYchu701mhY8xFTENm1H/iFZ8
 jzFBpUq41KkdRvlAgfsP5gXJlMcu5t/4bHFNQQtlQBg18zlWJaBwX469BphaFr7oYkL+mQJjUgA
 4eVpSXuxgTdlbRtrPOGRUz9IDTlgXXAIBVliKP9aA1Xw==
X-Forward-Email-ID: 69b47c4b087b10120ea086a0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.50
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <e8148f39-39ba-410e-b353-9b75dca79266@kwiboo.se>
Date: Fri, 13 Mar 2026 22:06:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.denx.de
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On 3/13/2026 9:54 PM, Tom Rini wrote:
> On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> 
>> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from
>> same bank"). These are based on incorrect premise of the first commit, that
>> "U-Boot does not use memory above ram_top". While U-Boot itself indeed does
>> not and should not use memory above ram_top, user can perfectly well use
>> that memory from the U-Boot shell, for example to load content in there.
>>
>> [...]
> 
> Applied to u-boot/next, thanks!

This patch break RK356x devices with 8 GiB RAM until following patch
also has been applied, currently only the fix for RK3588 got applied to
next.

"rockchip: rk3568: Include all addressable DRAM in memory map"
https://patchwork.ozlabs.org/project/uboot/patch/20260309210234.521070-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> [1/1] lmb: Reinstate access to memory above ram_top
>       commit: a3075db94d49f415658bf7e961e1eae90d9abc33

