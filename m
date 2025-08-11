Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8439ECA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 17:09:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D47DC831B4;
	Mon, 11 Aug 2025 19:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="b8zrvHmn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFAD83214; Mon, 11 Aug 2025 19:09:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E6A83189
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 19:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cf87=2Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754932184;
 bh=X3cKFjlPm8DgkdYkN0tknzR6T3ImHl7YsNfM3bCoVOk=;
 b=b8zrvHmnHwWikxaFeBb7e/hIwocwvI+py9YYwkI9eOR6BFCYMnPSmNuX7NPrzdr4VbIspY5Rn
 p1X/atbehjWx7hyqAyDMVE65veVf5xGlg3v717xMzKqfe0nNcDagunc1OGj/xccVqET9SH9dXh1
 R5n1lEaGEtZFa8D0/xWaNL4P+CwGVTI6zPY8vFdgl6MPRUBE3GEu2fy4J8XuVq6gStZ1F+GLbPi
 X5tDteYxfTgKi1jZT2SZT+wfkLpKuIA9TO7nwNCrWYAAqpEZh4E2Y14sJmwpumwy1vxAcQietJk
 HJJBta+Io80cSaP0w06rIbW7uFluMvvToPL9G/urnf8g==
X-Forward-Email-ID: 689a23c170d2d7c14f67369a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f4babfd9-53a5-4af8-8b0d-813c61697400@kwiboo.se>
Date: Mon, 11 Aug 2025 19:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: Add initial RK3582 support
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250810222644.4095072-1-jonas@kwiboo.se>
 <20250810222644.4095072-2-jonas@kwiboo.se>
 <1b1ad33a-3004-480d-9d32-3ea05e7eaf63@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1b1ad33a-3004-480d-9d32-3ea05e7eaf63@cherry.de>
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

Hi Quentin,

On 8/11/2025 5:44 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/11/25 12:26 AM, Jonas Karlman wrote:
>> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
>> What blocks are disabled/non-working is indicated by ip-state in OTP.
>>
>> This add initial support for RK3582 by using ft_system_setup() to mark
>> any cpu and/or vdec/venc node with status=fail as indicated by ip-state.
>>
>> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
>> cores and one vdec/venc core is always failed/disabled.
>>
>> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
>> the required DT fixups for RK3582 board variants.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v3:
>> - Apply same policy for RK3582/RK3583 to match vendor U-Boot
>>    linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.
> 
> Isn't the GPU supposed to be possibly non-fonctional on RK3582/RK3583? 
> If we don't disable it in the DT, how will the system actually behave?

Not sure about this, I was also wondering what happened to the GPU, but
this matches the updated policy [1] in vendor U-Boot and I do not want to
deviate from the vendor policy:

[1] https://github.com/Kwiboo/u-boot-rockchip/commit/5566d7d920d20932d2188c0cec57cb9036a9eefd

> 
> @Kever may have more official info on that?
> 
> See remarks on v2 otherwise, most of them still apply.
> 
>> - Update rkvdec node name to match latest mainling Linux DT patches.
> 
> Should we rather wait for the patches to be actually merged before 
> trying to patch the device tree nodes that do not exist yet?

This is what I did for v1, however Kever mentioned:

"it would better to follow the vendor U-Boot as-is to handle the dts, eg. 
seems you have skip the dts handle for rkvenc/rkvdec".

So for v2+ I tried to anticipate those node names, and have also sent
multiple reviews [2] to Linux ML for the rkvdec nodes to ensure the
names matches. However, the latest DT patch [3] changed the reg order
and thus the node name changed once again.

We could drop the rkvdec/rkvenc handling and add it later once nodes
have finally landed, or keep the handling and just patch U-Boot in
case the node names ends up being changed before merge.

[2] https://lore.kernel.org/linux-rockchip/c73a32b0-cc58-4d07-a0e5-719e5434adc3@kwiboo.se/
[3] https://lore.kernel.org/linux-rockchip/20250808193602.142527-2-detlev.casanova@collabora.com/

Regards,
Jonas

> 
> Cheers,
> Quentin

