Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2C7E7E0C2
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 10:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A008397D;
	Mon,  9 Feb 2026 11:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vODJPpOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 025F3839A5; Mon,  9 Feb 2026 11:45:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D63A805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 11:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f4ed=AN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1770633942;
 bh=v/PgVpmwYP//B2/0ist/wld8uAeIUcZck8aLIRQe5kA=;
 b=vODJPpOWsAicNOzUIAmDX7/yAGWBZcwo6sZq4mXuIWFuAa0DWW6xXUxKxHhhbiL51WYc4wggM
 nBS+Vx119pPVndSupCXXeFII5jVtzEc6ydA0lO+GdOQp6Kl1XFN4z5luIZzuuuGS9UboWCxNIWW
 nCh5UuZzCsHCDTSnwbGJygLaNbMV8vyJ1d4Si6tlKOid+Bb4jlcU2krq3AFowDdl/sVRIatlbo4
 rRXB8O0nXCgEBjSNRu00zEQIwVMvAy4OsHrJ55BF8hQawl87VTfFvh0qGrFlemXb0rvQUIoiRe5
 +Yad5x50EIHyaKTdpCx8Kg2eWcUN8cFzHL2dBoub9d4A==
X-Forward-Email-ID: 6989bad4de8d5e1b8dcf768a
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <aa3d9695-3b54-48ab-ae29-ac31484efadd@kwiboo.se>
Date: Mon, 9 Feb 2026 11:45:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ARM: dts: Add RV1103B Omega4 support
To: Fabio Estevam <festevam@gmail.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
 <20260208212624.3413494-2-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260208212624.3413494-2-festevam@gmail.com>
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

Hi Fabio,

On 2/8/2026 10:26 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Add the necessary devicetrees to support the RV1103B Omega4 board.
> 
> The RV1103B is a Rockchip SoC that is still not supported in Linux
> mainline.
> 
> The initial RV1103B support has already been submitted to Linux kernel
> and it is under review.
> 
> Once the Linux RV1103 devicetrees are upstreamed, the OF_UPSTREAM mechanism
> can be enabled.

Please address my upstream DT review and give it some more time before
adding DTs that cannot be picked to dts/upstream in U-Boot.

For the past two years the Rockchip platform has only allowed adding
arch and boards using DTs that come from dts/upstream. So please give a
good explanation why your arch/board cannot wait until that is the case
and need exception from this.

> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - Used the devicetrees submitted to upstream Linux.
> 
>  arch/arm/dts/rv1103b-omega4-u-boot.dtsi       |  10 +
>  arch/arm/dts/rv1103b-omega4.dts               | 105 +++
>  arch/arm/dts/rv1103b-pinctrl.dtsi             | 831 ++++++++++++++++++
>  arch/arm/dts/rv1103b-u-boot.dtsi              |   4 +
>  arch/arm/dts/rv1103b.dtsi                     | 266 ++++++
>  .../dt-bindings/clock/rockchip,rv1103b-cru.h  | 220 +++++
>  6 files changed, 1436 insertions(+)
>  create mode 100644 arch/arm/dts/rv1103b-omega4-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rv1103b-omega4.dts

Please split patch 7/7 in two, one that add rv1103b arch support and a
second that add the omega4 board. Then please move the board DTs to the
patch that adds support for the omega4 board.

>  create mode 100644 arch/arm/dts/rv1103b-pinctrl.dtsi
>  create mode 100644 arch/arm/dts/rv1103b-u-boot.dtsi

The soc u-boot.dtsi is better to add in the patch that add rv1103b arch
support, i.e. this patch should only include DTs and headers that is a
drop in replacement for future files that are expected to land in
dts/upstream.

Regards,
Jonas

>  create mode 100644 arch/arm/dts/rv1103b.dtsi
>  create mode 100644 include/dt-bindings/clock/rockchip,rv1103b-cru.h

[snip]
