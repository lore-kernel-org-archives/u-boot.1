Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F905D2A523
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 14:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D252188A1B;
	Wed, 16 Oct 2024 16:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ooh1qYJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8FA388B70; Wed, 16 Oct 2024 16:34:56 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14162889C5
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 16:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=97a5=RN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729089289;
 bh=gC+Rg345wA+WaKtl7KFIFGd6gEDe42F+5zks5EifZug=;
 b=ooh1qYJmxUZi4LkAzqxgVbU3448QVhbM+PxrICQcFhwIVdtZnKXiYslu+myiytTikz0Octqdv
 ArbdZv4RwbAuVv3XsUTuALvIqxuy/vkinjB/DYeDSk8VmhhZyMQRkAtO2u2kGDqu4j0O0Jfz9pW
 Qu0NK6d2zsNrAqN7fLspXeg0ntpoD6+6PWSvLFYxmXLcidXQNTSdVXiZgmwz/i0xZZNttnm8nJv
 vhNDhFr/nPQvHZ+LAeTb5cyV86/d5etMfxwBqS7x5/tqrafhNIAEAQXX24bDyttw9P30/jLiR9H
 uHPFSfInyYzHPc15Y+7Z/Fnz/Ma5wyPgr4oq2AIRlcMg==
Message-ID: <a9c88272-3b0e-4303-9a52-637084a8e6dd@kwiboo.se>
Date: Wed, 16 Oct 2024 16:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: device_bind() with ofnode_null() tripping assert()?
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <ba0dfee4-9c9f-4f7b-8139-5ce1741384da@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ba0dfee4-9c9f-4f7b-8139-5ce1741384da@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 670fcf07d2d8cc807ca1a8dd
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

On 2024-10-16 13:25, Quentin Schulz wrote:
> Hi all,
> 
> Not sure how to word this better so here goes nothing.
> 
> I recently wanted to debug some issues possibly related to DM which had 
> a bunch of debug() log messages I wanted to see. To see those, one needs 
> to define DEBUG. Once that's done, assert() calls are now built in.
> 
> It turns out that this means I cannot boot my board anymore because (at 
> least) one of the assert() fails (specifically an ofnode_valid()).
> 
> I've for now narrowed the one in SPL to dev_read_u32(protocol, 
> "arm,smc-id", &func_id) in smccc_agent.c, c.f. 
> https://elixir.bootlin.com/u-boot/v2024.10/source/drivers/firmware/scmi/smccc_agent.c#L91
> If I change ofnode_null() with ofnode_root() in the device_bind() 
> creating the scmi-base.0 device from the SCMI UCLASS, then it goes 
> further, c.f. 
> https://elixir.bootlin.com/u-boot/v2024.10/source/drivers/firmware/scmi/scmi_agent-uclass.c#L377
> 
> However, I then get another assert() being tripped later in U-Boot 
> proper (right after the Ethernet has been initialized and before I get 
> to the shell, no idea if it actually is related to Ethernet), which 
> makes it reset again.
> 
> So... I basically have no clue how to go forward with this. We've 
> started to discuss to decouple debug() log messages from assert() 
> (meaning they don't share the same knob) but that wouldn't fix the 
> issue. Should this assert() really be tripping? If not, how should we 
> handle that instead?

I have been hit with the such issue in lib/smbios.c due to assert().
Not sure if this is a correct fix or a bad workaround.

One thing that could make it easier to get a clue on what is causing the
assert() is to ensure debug/warn log happens before the assert() in e.g.
drivers/core/ofnode.c.

Have also seen similar ofnode related assert() reset issue in the past
with BOOTMETH_VBE enabled, due to a missing node or props.

diff --git a/lib/smbios.c b/lib/smbios.c
index 7c24ea129eb5..4aa8829a283d 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY	LOGC_BOARD
 
+#include <display_options.h>
 #include <dm.h>
 #include <env.h>
 #include <linux/stringify.h>
@@ -630,7 +631,7 @@ ulong write_smbios_table(ulong addr)
 		ctx.subnode_name = NULL;
 		if (method->subnode_name) {
 			ctx.subnode_name = method->subnode_name;
-			if (IS_ENABLED(CONFIG_OF_CONTROL))
+			if (IS_ENABLED(CONFIG_OF_CONTROL) && ofnode_valid(parent_node))
 				ctx.node = ofnode_find_subnode(parent_node,
 							       method->subnode_name);
 		}

Regards,
Jonas

> 
> Cheers,
> Quentin

