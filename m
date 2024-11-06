Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42151D59F67
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 21:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F7F88E63;
	Wed,  6 Nov 2024 22:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tVBwtbhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C93E88E2D; Wed,  6 Nov 2024 22:15:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E075789020
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 22:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5449=SC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1730927699;
 bh=JoR1iBxq81+AxclnsdjdAg2SCLZbgVEVhgqU5Enhi/w=;
 b=tVBwtbhVZXJ1q6xzg6cfbW6qH3PO/tToa/lCgNb/glzh2us8fJlDBuY4og/gVwgNjsDjZRDoO
 9JRQAFLFKGwnIAhm47ElXyY+QdEJxaYg8HGEqh0rfotWyhIHObohUzOcrRJq/RIoe9JhYyvASiy
 RSWq+P7FQXueHXcu83dR1OA+TyCxKdzApzjPC/i0ABq/glYZiK7QVnec/gtFRkAeg66WlMHXQi+
 qZq4lJ5A+zGQlSaR/e3nSzX5hdIIvNt+U26fWg5xnyz4KFUZ+VlRnOsbLPgiA2DQMI6geKZIw+Q
 GTrOA/KLrtC5PGn2mnR1yp7ek62+gcScm0D7kGePa2Vg==
Message-ID: <bb8c43c2-11c2-4124-a8b6-e98ae8cd5e4f@kwiboo.se>
Date: Wed, 6 Nov 2024 22:14:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308: Drop unused rk_board_init()
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20241102204516.3633375-1-jonas@kwiboo.se>
 <ef7ac63b-0792-402b-8dfd-d15ccf427cd7@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ef7ac63b-0792-402b-8dfd-d15ccf427cd7@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672bdc52e997659fa2f4d0b4
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

Hi Quentin,

On 2024-11-06 14:49, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 11/2/24 9:45 PM, Jonas Karlman wrote:
>> Nothing is calling the function rk_board_init() and the io-domain driver
>> can handle the functions intended purpose based on information from DT.
>>
>> Cleanup by removing the unused rk_board_init() function and re-sort
>> included headers.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> git log -p -S rk_board_init
> 
> only returns one match and it's the introducing commit in which this 
> function seemingly is never called.
> 
> I'm really wondering why this wasn't shown as a warning by GCC?

Building with W=1 at least show one warning (and a lot of others):

  warning: no previous prototype for ‘rk_board_init’ [-Wmissing-prototypes]

> 
> Since this is the IO domain for storage medium on RK3308, shouldn't we 
> make sure the IO domain is enabled in SPL for fallback mechanism (i.e. 
> proper isn't found on the same storage medium as the one used for 
> loading SPL)?

I took a new look at schematics of supported boards and all seem to
signal correct VCCIO3 voltage using GPIO0_A4 (0: 3v3, 1: 1v8).

Also re-tested emmc/sd-nand and sd-card cross-read in SPL and there was
no issues on my Rock Pi S and ROCK S0 boards, so current reset values
to use GPIO0_A4 should work until io-domain driver later decide change
to use io_vsel3.

> 
> The IODOMAIN isn't even enabled in proper for the EVB and the ROC-CC 
> board. And there isn't an IODOMAIN symbol for SPL in Kconfig AFAICT?

Originally I probably only wanted to enable the io-domain driver on
boards that I could runtime test. Also the primary use for Rock Pi S and
ROCK S0 was to configure correct io voltage for Wi-Fi.

For rk3308 U-Boot IODOMAIN=y may not be fully necessary, at least now
that Linux io-domain driver also has support for rk3308.

For now, I do not think any board need to include io-domain driver in
SPL, could be changed in a future series if/when that is needed :-)

Regards,
Jonas

> 
> Not that this commit would change anything, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

