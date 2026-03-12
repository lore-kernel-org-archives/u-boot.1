Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C172FED2EC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 08:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9468A83F53;
	Thu, 12 Mar 2026 09:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="DkJj1s2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80BA583F6D; Thu, 12 Mar 2026 09:19:52 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3D583F00
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1773303574;
 bh=F4s53iJQZ/m9jl72+sgGGo/t13Z1XhRex1o0Py7OgXU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DkJj1s2TPJb7ahCOLP0NPRjt6Wfx3ll7kS1DUuaKCfGjqHePCsm99ZBrOLBdPMxMz
 lpOQBl5gFv1eAZjpaCFNzwuZCaZVf89ehIIj+KQMC116wmFdYgEVM2LTmHf+k0RXvP
 N6yspZuxmnui/y077TlA8VGKRIEY/IxVWC7URGeR0wKsNcnGYh7pSTuej29ya760PE
 X0RgJEm8xgfCPDjYchtaLPB/m8gnfpJYfeXoEBhhKoMh7+fCbLhAXob7wpdr9IFb5t
 +YQQeAsi6VePRdUY3Esh/sQ4COUYGH4+V/xnWs5b+m8prautmBPPxbhVzF7d/f+sV2
 6+0xrZwXUs74A==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 905E9B220182;
 Thu, 12 Mar 2026 09:19:33 +0100 (CET)
Message-ID: <802f0860-07fc-4351-b9e7-c57d7b98f45c@freeshell.de>
Date: Thu, 12 Mar 2026 01:19:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 0/3] Add upstream board Xunlong Orange Pi RV
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
References: <20260305170043.33994-1-e@freeshell.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260305170043.33994-1-e@freeshell.de>
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

Replying a question from Heinrich review on the non-RESEND of this
series v4, "Did Shenzhen Xunlong Software Co., Ltd ever respond to the
suggested EEPROM change?"

On 3/5/26 09:00, E Shattow wrote:
> Xunlong Orange Pi RV patches are now in the Linux v6.19 release, so let's
> introduce support for this board.
> 
> Note: The content of EEPROM is known to not be unique on this board, and
> an (optional) invented "XOPIRV" identifier is implemented with this
> series. Without, there are reports that the board is detected in U-Boot as
> StarFive VisionFive 2 1.3b, and is then functional enough to load the
> devicetree prior to booting Linux.
> 
> RESEND v4: has collected tags that were missing from v4 as sent to list
> 
> Changes since v3:
> - Collect tags (no code changes) [n.b. this failed, see RESEND v4 instead]
> - Cherry-picked dts subtree patches dropped as redundant:
>   Drop patch 1/5 "dt-bindings: riscv: starfive: add xunlong,orangepi-rv"
>   Drop patch 2/5 "riscv: dts: starfive: add Orange Pi RV"
> 
> Changes since v2:
> - Collect tags (no code changes)
> - Adjust missing S-o-by tag to first of tags list order for patch 4
>   "configs: starfive: Add Orange Pi RV to visionfive2".
> 
> Changes since RFC v1:
> - Cherrypick from devicetree-rebasing instead of importing upstream dts
>   as -u-boot.dtsi overrides.
> - Add basic documentation
> - Mention invented "XOPIRV" identifier in commit messages
> - Rebase on origin/next
> 
> 
> E Shattow (3):
>   board: starfive: visionfive2: Add Orange Pi RV selection by product_id
>   configs: starfive: Add Orange Pi RV to visionfive2
>   doc: board: starfive: Add Xunlong OrangePi RV
> 
>  board/starfive/visionfive2/spl.c              |  3 ++
>  .../visionfive2/starfive_visionfive2.c        |  2 ++
>  configs/starfive_visionfive2_defconfig        |  2 +-
>  doc/board/starfive/index.rst                  |  1 +
>  doc/board/starfive/orangepi_rv.rst            | 35 +++++++++++++++++++
>  5 files changed, 42 insertions(+), 1 deletion(-)
>  create mode 100644 doc/board/starfive/orangepi_rv.rst
> 
> 
> base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67

Heinrich, no I did not get a response beyond what their sales
representative would say, that they do not give samples and there is
documentation at their website only. Likely this question I asked went
nowhere and was read by person(s) who could not engage with me on the
topic. Anyone with a contact at that company is welcome (in my opinion)
to push this issue further and get an answer from someone with agency in
the matter. -E
