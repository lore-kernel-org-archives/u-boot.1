Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C45BC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 21:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA2D8823C;
	Sat,  4 May 2024 23:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="wgS6+9f7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C74288274; Sat,  4 May 2024 23:15:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 642FC87FF2
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 23:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714857330;
 bh=cxzs5FD+hhs6EZMi45ewBU3t8+u0SzEn1/C+h02HhzI=;
 b=wgS6+9f7pcko+X9dFPWPj8CUCGgUorrvkj0MGGkkALmVMrXdflylhI/2fNSTbY70LzJ8EumSb
 xSBN/63oaRqulGZknY/XJUQRa9i6hB6duM8Icrzqu5oziuHbN6VmMu6LcmZQ4PEVbuGQunpFOrS
 IIXidHKnNCqWEaMpGgqxD19GgtYdmSPsCak7urdPu76MlJm97Xf1W3tRvogekYkj8gtiEj6G41d
 JyaGUmXAouJI2wp8NohgCkbt/uYL7h4ozNNe9yDa36IKVwPgnmUH1ik+3bABiGfiTxXgwys9vSD
 SKw/opg6yU3geSzY9OVs6uD+ojSsPegZtbX8rQs5ghXw==
Message-ID: <46db8ab2-0d79-4ecf-877e-16cc60943e92@kwiboo.se>
Date: Sat, 4 May 2024 23:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] rockchip: rk356x: Remove redundant device tree files
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Frank Wunderlich <frank-w@public-files.de>,
 Joseph Chen <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>, Tianling
 Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 u-boot@lists.denx.de
References: <20240504194346.2462489-1-jonas@kwiboo.se>
 <20240504194346.2462489-10-jonas@kwiboo.se>
 <DM4PR05MB9229CA4B06151DEBD33C4DABA51E2@DM4PR05MB9229.namprd05.prod.outlook.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <DM4PR05MB9229CA4B06151DEBD33C4DABA51E2@DM4PR05MB9229.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6636a57078c2a3e877051799
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

Hi Chris,

On 2024-05-04 22:51, Chris Morgan wrote:
> On Sat, May 04, 2024 at 07:43:01PM +0000, Jonas Karlman wrote:
>> Remove redundant device tree files now that RK356x boards have been
>> migrated to use OF_UPSTREAM.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  arch/arm/dts/rk3566-anbernic-rgxx3.dtsi  |  788 ------
>>  arch/arm/dts/rk3566-quartz64-a.dts       |  838 ------
>>  arch/arm/dts/rk3566-quartz64-b.dts       |  737 -----
>>  arch/arm/dts/rk3566-radxa-cm3-io.dts     |  281 --
>>  arch/arm/dts/rk3566-radxa-cm3.dtsi       |  425 ---
>>  arch/arm/dts/rk3566-soquartz-blade.dts   |  198 --
>>  arch/arm/dts/rk3566-soquartz-cm4.dts     |  196 --
>>  arch/arm/dts/rk3566-soquartz-model-a.dts |  236 --
>>  arch/arm/dts/rk3566-soquartz.dtsi        |  684 -----
>>  arch/arm/dts/rk3566.dtsi                 |   35 -
>>  arch/arm/dts/rk3568-bpi-r2-pro.dts       |  852 ------
>>  arch/arm/dts/rk3568-evb.dts              |  689 -----
>>  arch/arm/dts/rk3568-lubancat-2.dts       |  730 -----
>>  arch/arm/dts/rk3568-nanopi-r5c.dts       |  112 -
>>  arch/arm/dts/rk3568-nanopi-r5s.dts       |  136 -
>>  arch/arm/dts/rk3568-nanopi-r5s.dtsi      |  587 ----
>>  arch/arm/dts/rk3568-odroid-m1.dts        |  741 -----
>>  arch/arm/dts/rk3568-pinctrl.dtsi         | 3214 ----------------------
>>  arch/arm/dts/rk3568-radxa-cm3i.dtsi      |  412 ---
>>  arch/arm/dts/rk3568-radxa-e25.dts        |  236 --
>>  arch/arm/dts/rk3568-rock-3a.dts          |  859 ------
>>  arch/arm/dts/rk3568.dtsi                 |  267 --
>>  arch/arm/dts/rk356x.dtsi                 | 1886 -------------
>>  include/dt-bindings/clock/rk3568-cru.h   |  926 -------
>>  include/dt-bindings/power/rk3568-power.h |   32 -
>>  25 files changed, 16097 deletions(-)
>>  delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
>>  delete mode 100644 arch/arm/dts/rk3566-quartz64-a.dts
>>  delete mode 100644 arch/arm/dts/rk3566-quartz64-b.dts
>>  delete mode 100644 arch/arm/dts/rk3566-radxa-cm3-io.dts
>>  delete mode 100644 arch/arm/dts/rk3566-radxa-cm3.dtsi
>>  delete mode 100644 arch/arm/dts/rk3566-soquartz-blade.dts
>>  delete mode 100644 arch/arm/dts/rk3566-soquartz-cm4.dts
>>  delete mode 100644 arch/arm/dts/rk3566-soquartz-model-a.dts
>>  delete mode 100644 arch/arm/dts/rk3566-soquartz.dtsi
>>  delete mode 100644 arch/arm/dts/rk3566.dtsi
>>  delete mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
>>  delete mode 100644 arch/arm/dts/rk3568-evb.dts
>>  delete mode 100644 arch/arm/dts/rk3568-lubancat-2.dts
>>  delete mode 100644 arch/arm/dts/rk3568-nanopi-r5c.dts
>>  delete mode 100644 arch/arm/dts/rk3568-nanopi-r5s.dts
>>  delete mode 100644 arch/arm/dts/rk3568-nanopi-r5s.dtsi
>>  delete mode 100644 arch/arm/dts/rk3568-odroid-m1.dts
>>  delete mode 100644 arch/arm/dts/rk3568-pinctrl.dtsi
>>  delete mode 100644 arch/arm/dts/rk3568-radxa-cm3i.dtsi
>>  delete mode 100644 arch/arm/dts/rk3568-radxa-e25.dts
>>  delete mode 100644 arch/arm/dts/rk3568-rock-3a.dts
>>  delete mode 100644 arch/arm/dts/rk3568.dtsi
>>  delete mode 100644 arch/arm/dts/rk356x.dtsi
>>  delete mode 100644 include/dt-bindings/clock/rk3568-cru.h
>>  delete mode 100644 include/dt-bindings/power/rk3568-power.h
>>
>> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
>> deleted file mode 100644
> 
> Can we remove this since a non-upstream device tree depends on it?

I was a bit unsure what to do about this file, after this patch it gets
included from dts/upstream/ correctly when building the
anbernic-rgxx3-rk3566 target.

Not sure if it is better to keep a local copy in arch/arm/dts/ and
manually sync it, or let it be included from dts/upstream/.

Let me know if you want me to keep the copy in arch/arm/dts/.

Regards,
Jonas

> 
> Thank you,
> Chris
> 

[snip]
