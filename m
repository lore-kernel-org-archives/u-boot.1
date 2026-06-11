Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72C9CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C71A841C2;
	Thu, 11 Jun 2026 15:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wQs3ZhhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3807A84664; Thu, 11 Jun 2026 15:58:12 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D100583FF5
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ecc3=EI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781186288;
 bh=wSwTQ42l6kd1ueznB8wFCoOd9seWQOt7lKNaPWUi4EM=;
 b=wQs3ZhhE9sidrqPjOffB5fJVUn0QwiTyQK/CYbwCIuzSBBK/rDMnJgZZPb5fWK26LfqiGTwtO
 HlfEu4lfmUjMU1UDsqNR06uHE/4cvH+4UivI57kMcjkEl1wLfc9AgftN7J8fMthD3nnjYIl0tHx
 U3alk7f21l0hM+laJaRZRW4PIPTwAEdWGbIhTuZ0nR5xLrCuUjf23YD6BoL+3Bv1yQixOxcQZQL
 6DIGR5XDAQNMNhUqcTD9CUoYkR8nB1ZgQhaIR4AJ9SEoivmv3lfarnLN+EcHx+6xyDIVeeop42L
 AGy+Zt6WQz/WQN3zkFcw9Y77gobAUykCRivpxMqdUuSQ==
X-Forward-Email-ID: 6a2abeef976a6d1c6ea195da
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f706f118-b698-4ab4-8b19-9f3de0d10c31@kwiboo.se>
Date: Thu, 11 Jun 2026 15:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
To: Tom Rini <trini@konsulko.com>, Torsten Duwe <duwe@lst.de>
Cc: u-boot@lists.denx.de, Daniele Briguglio <hello@superkali.me>,
 Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
References: <20260528132206.2fe9f474@lst.de>
 <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
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

On 6/11/2026 3:48 PM, Tom Rini wrote:
> On Thu, 28 May 2026 13:22:06 +0200, Torsten Duwe wrote:
> 
>> Devicetree commit a198185b9b5 introduced a new type of clock,
>> "gated-fixed-clock", for which Das U-Boot does not have
>> a driver yet. The required code is similar to gpio-gate-clock,
>> and can be added using little extra text space.
>>
>> Use this code e.g. to boot a Rock5 ITX from NVMe
>>
>> [...]
> 
> Applied to u-boot/next, thanks!

Any reason this was applied without my review concerns being addressed?

Please revert, or address the issues this patch have :-)

Regards,
Jonas

> 
> [1/1] clk: enhance clk-gpio to also handle gated-fixed-clock
>       commit: 4e249b94af928aca29972fc22ef2b5ed0016eab9

