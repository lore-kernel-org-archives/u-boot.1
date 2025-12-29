Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA006E9271B
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 19:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E06FB83ED7;
	Mon, 29 Dec 2025 20:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="O/0kipBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3774783EE3; Mon, 29 Dec 2025 20:15:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FE9283A3D
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 20:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fb60=7E=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1767035737;
 bh=HJqWZf3/ARvKahzR1X0m76+/CItS2bTBvX7d9EGOOv4=;
 b=O/0kipByB+iNDFu3nCMpNNlIdBihdU5MK9HsuwOvbiWd/H4tULIVB8mdcYXAXlToJjZMBhao5
 TSguAI7b8A75j4RWSbSDdpdQkAI4lx3/FX3PUL6bb8Tw/I+xSTS6k0RRp5TEaJH0fARdY61DSF8
 qiIXdVaHtzQgLodWI2XSCGsyoX9G5mKvSKX9+boptvWoooS+hnv84WA9fFbcpTXynaZ+LSg7rpr
 6dEjnvvx6NYwL7Jzx778TY8XQRpDtbXKClcmLUmW7uu+9Nj4hK7jMJPyM3Tatd8svnGNwJLoNkX
 rVMBlndD4lmZtK/wb77+gmBuxN8VNlpfQLTdoksqF1XQ==
X-Forward-Email-ID: 6952d3564287cd05bf364bb4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.0.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d63bc142-91a0-459d-8ccf-ad373fb0ca41@kwiboo.se>
Date: Mon, 29 Dec 2025 20:15:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rockchip: sdram: allow reading memory info from TPL
 on non-ARM64
To: Aaron Griffith <aargri@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Chris Morgan <macromorgan@hotmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
 <dc6ddbfe-df79-4dcf-90e3-76068e5a5e40@kwiboo.se>
 <CAPcvo0S-ft94KFN6f2ZPr5KEMoEmATcFkTQk8O6PjFkJn3Ak0g@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAPcvo0S-ft94KFN6f2ZPr5KEMoEmATcFkTQk8O6PjFkJn3Ak0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Aaron,

On 12/29/2025 11:26 AM, Aaron Griffith wrote:
> Hello Jonas!
> 
> On Mon, Dec 29, 2025 at 4:49 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>> [..]
>>
>> Is there anything useful encoded in the RK ATAGS that we need on any
>> other SoC ? (with the goal of using mainline TF-A and/or OP-TEE)
> 
> Not that I know of. I must admit, I'm new to this codebase and so I'm
> mostly looking at what code already exists and what the Rockchip fork
> does to try and synthesize a solution. The Rockchip fork reads this
> info, and it was a simple change, so that felt like the right path.

The memory size info is also encoded in PMUGRF os_reg2 reg, a simple
call to rockchip_sdram_size(PMUGRF_BASE + OS_REG2_REG) should be enough
to get the memory size info typically needed by U-Boot.

The RK ATAGS do include some other information that could be useful e.g.
what uartX and baudrate is used by external TPL, but this is mostly
information that the vendor blobs for TPL, SPL, TF-A and OP-TEE read,
use and/or update.

For mainline U-Boot there should not really be a need for using the info
encoded using the vendor RK ATAGS, at least no to my knowledge.

>> Nice!, please also see my rk3506 branch [2] for a mainline u-boot branch
>> that is mostly just waiting on upstream Linux support before being sent
>> out. Should have good support for most Luckfox Lyra variants and the
>> ArmSoM Forge1.
> 
> Oh, fantastic! I started working on this as a way to learn my way
> around U-boot, but I've been learning that adding RK3506 support might
> have been ambitious. What I have boots just fine and I learned a lot,
> but... more experience here is definitely for the best.
> 
> (Your link [2] to your rk3506 branch is a 403 for me. Is that temporary,
> or..?)

Strange, probably the Anubis instance used by source.denx.de at fault.

I have now pushed an updated rk3506 branch to GitHub [1], the old branch
last rebased in September is located at [2].

Most of my RK3506 work was done back in February, not sure all features
was fully implemented, e.g. Ethernet on my Forge1 did not seem to work
now that I did a new runtime test, maybe a PHY driver is missing.

[1] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3506
[2] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3506-2025091

> 
> I'm happy to either continue with these patches if they seem useful
> for any other reason, or to drop them if not. RK3506 is the only
> reason I had for them myself.

I do not think we want to extend the use of the RK ATAGS, at least not
unless it is absolutely needed.

There is still one big question related to RK3506 that needs to be
figured out, should we use cpu enable-method psci and offload psci to
e.g. OP-TEE as done by vendor, or possible TF-A or fully handle this in
kernel?

Hopefully that and a basic device tree can be submitted and merged to
mainline Linux in a near future, after that we have a proper DT that can
be used by U-Boot. At least this is what I have been waiting on :-)

Regards,
Jonas

> Thanks,
>  -Aaron
> 

