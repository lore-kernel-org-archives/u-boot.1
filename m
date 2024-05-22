Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B3C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0F0881A9;
	Wed, 22 May 2024 20:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vdQmi/fF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A0F4881C3; Wed, 22 May 2024 20:16:39 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F558811D
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 20:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2726=M2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1716401733;
 bh=x1y20liH+lznuJYvmzaixXjoplK+TxZ0zZnV2nKkt0I=;
 b=vdQmi/fF9xwLmf7/cV9DoQ+Y3hhtkOvC0eRbeCyqzSobPl/93YA59y/TpTaCiJtf9So9TvP05
 n3L7CGlKmVrTWre5wjVbHpXnU8KjbqVj6E1EIM1r6ha6z50Dc+yy+jjJLi1/1HbwPrBpVj1npkt
 m2vfXMg71HS9WHbbasJj34a8Y4sKNhV5cAAWbkCmpfDUlUNmenbtZFw1MXPhXJDu+r9w9bJHXUp
 OP7/5KLnNxuWzy353iWtw1R73+T19AROdyJPc/WvZMoWiQtwtqBLxrcwZ+Aq/Tl17Y13zvtRhQe
 9uM9TRJX0bxLUkb3FwAjbqdqWo6l4wv7ed+R7M91xnWQ==
Message-ID: <b0ea7bfb-4e1c-4414-8286-d4df0a86c367@kwiboo.se>
Date: Wed, 22 May 2024 20:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Quentin Schulz <quentin.schulz@cherry.de>, Jianfeng Liu
 <liujianfeng1994@gmail.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Christopher Obbard
 <chris.obbard@collabora.com>, Elon Zhang <zhangzj@rock-chips.com>, Eugen
 Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>, John
 Clark <inindev@gmail.com>, Joshua Riek <jjriek@verizon.net>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Massimo Pegorer
 <massimo.pegorer+oss@gmail.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Michal Simek <michal.simek@amd.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Sam Edwards <cfsworks@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tianling Shen <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>, Weizhao
 Ouyang <weizhao.ouyang@arm.com>, u-boot@lists.denx.de
References: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
 <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 664e3644129ffd2d9451f3a9
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

On 2024-05-22 20:03, Quentin Schulz wrote:
> Hi Jianfeng Liu,
> 
> On 5/22/24 6:58 PM, Jianfeng Liu wrote:
> [...]
>> Note that these commits:
>> - e18e5e8188f2 (arm64: dts: rockchip: add USBDP phys on rk3588)
>> - 6fca4edb93d3 (arm64: dts: rockchip: Add rk3588 GPU node)
>> are not synced to u-boot, so I remove usb3 drd nodes and gpu from kernel
>> devicetree.
> [...]> diff --git 
> a/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts 
> b/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
>> new file mode 100644
>> index 0000000000..c7b46536ec
>> --- /dev/null
>> +++ b/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
> 
> Sorry, I failed to explain properly what was expected.
> 
> dts/upstream should never be touched except with 
> dts/update-dts-subtree.sh script.
> 
> Sadly, your board is not supported in v6.9 yet, only in the upcoming 
> v6.10 :/
> 
> So we have two options, we keep the dts in arch/arm/dts/ like you used 
> to do, until we merge v6.10 dts in U-Boot (probably for v2024.10?), or 
> we cherry-pick the changes for your board with dts/update-dts-subtree.sh 
> script, see the instructions in the docs Tom has started writing: 
> https://lore.kernel.org/u-boot/20240517174930.1028063-2-trini@konsulko.com/ 
> I would very much like to see someone starting to look into the second 
> option :)
> 
> However... it seems we'll likely need to also cherry-pick patches for 
> the GPU (should probably be straightforward as nothing would be using 
> the GPU anyway in U-Boot) and the USBDP PHY... but this one we would 
> need to update all -u-boot.dtsi for rk3588(s) boards that have it 
> already to make it use the new label/DT, make sure that the driver still 
> works... etc. Maybe not a small feat, but someone will have to do it at 
> some point anyway :)

Thankfully updating the usb3 nodes and driver for RK3588 to match the
versions used in v6.10 was already done as part of the "rockchip:
Migrate RK3308, RK3328, RK356x and RK3588 to OF_UPSTREAM" series [1], in
commit a129bbc77b6c ("rockchip: rk3588: Update USB3 related nodes in
u-boot.dtsi") [2].

So the relevant nodes just needs to be removed from u-boot.dtsi files
at some point after dts/upstream has been updated to match v6.10 :-)

[1] https://patchwork.ozlabs.org/cover/1931378/
[2] https://source.denx.de/u-boot/u-boot/-/commit/a129bbc77b6cadc191d6f5d1fd8da96964baa029

Regards,
Jonas

> 
> You'd be the first one to do this cherry-picking into dts/upstream, so 
> it'd be really interesting to us if you could provide feedback on what 
> is unclear/not working, etc... so we can update the documentation or fix 
> tools if they were to be insufficient.
> 
> Looking forward to your next patch,
> Cheers,
> Quentin

