Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B7DE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 16:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215AD8036F;
	Fri, 20 Dec 2024 17:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vUDy8KDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8688C80381; Fri, 20 Dec 2024 17:50:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182718034E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 17:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=69d4=TO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1734713434;
 bh=NvxEmr5YYLOs5VyG1+cA8Cr+uzwwCxqoFnqdBt+pFIc=;
 b=vUDy8KDCVzND7dgHNfjIZ9NZ1mYWlfq8e7JOINFUN2RhNGEzsFonv04m5zNd8YCbCpGAAwC1m
 ps48y0QGB4i4W9yjpsDXAdkP2PyB3JkfieaOoUmYV71glZzfguuyQ20N4u8YgHQzLqpQQ/MV2ol
 zyMxEFEGEP9HZDRZGR6D5KXYowFlIq8WeZxzs70h3+tTOVrve/3cXU4dD4kPxOCp5fEFA9aFtJ1
 v0RyggQE9FRKUlct9LprIkcqDWLzvQeuyCE7WAF/JSh8mB4tiW/n0JAACE4m8SqkRrB1Qj76QO8
 1MHZK9hvU7Voi/nni5G3PlRLf73oNKG6eNoZogK7WHrQ==
Message-ID: <c3cd2190-096b-4f5d-a5cc-481cc44fa11c@kwiboo.se>
Date: Fri, 20 Dec 2024 17:50:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT
 in u-boot.rom image
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-7-jonas@kwiboo.se>
 <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <8a6bb542-aeda-4d74-bdcc-8eace71eaf62@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6765a055b8c9120276e3d6f7
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

Hi Quentin and Simon,

On 2024-12-13 15:30, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 12/13/24 12:57 AM, Jonas Karlman wrote:
>> The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
>> by binman for the u-boot-rockchip.bin image.
>>
>> Change to include the binman generated FIT for the u-boot.rom image.
>>
>> This change result in TF-A being included and the use sha256 instead of
>> crc32 checksum in the u-boot.rom FIT.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> IIRC Simon was fine with removing u-boot.rom support for RK3399 when I 
> asked months (probably years?) ago, if that hasn't changed, maybe we 
> should now.

Good to know and fully agree, we should try to remove it now.

I did a compare between u-boot-rockchip-spi.bin and u-boot.rom and after
this series they are now identical for the full size of
u-boot-rockchip-spi.bin.

However, the u-boot.rom also has a copy of ~u-boot.bin and a fdtmap
starting at 0x300000. I have no idea if they are used for anything,
if they are it is probably not for bare metal booting (TPL+SPL).

Regards,
Jonas

> 
> Especially since the only RK3399 with CONGIG_HAS_ROM set are Bob and Kevin.
> 
> @Simon, you said you tested the patch series on them, with which image 
> did you do that? Are you still fine with removing the u-boot.rom for RK3399?
> 
> Cheers,
> Quentin

