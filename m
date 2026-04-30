Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB78FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 03:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47BE845CE;
	Thu, 30 Apr 2026 05:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="kHMtIMUf";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="iY1BCeSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449F584150; Thu, 30 Apr 2026 05:09:02 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05BD280433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 05:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BE7DA140009B;
 Wed, 29 Apr 2026 23:08:56 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 23:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777518536; x=1777604936; bh=w3XejX/7o+UEYDwlj6LzU6KZBYItEKyj
 gOe720sFw9c=; b=kHMtIMUfQzZlkF62RtIIzZ3bk9I5/hvc0K80S4cs74yVUuIk
 cpIj7meMvyHtF/ua77WggpNYPmCkE+NjFmQD7MbvLa2Vo4MwYOjuyBdHKwUEuz32
 /K8Rui54cpI04VrwVps5m8LstuPRrp5Girl3MYSn+ivQ5TZKteb1ky2G08eAL07R
 AAQsqDvdYULXU5LrwlDyHkFZlikJ3JwzZkyqV2mX9PO3M8+Yj9X644VvxfoUm+3D
 IZ7GauO+5lro6c65xdurThuWVDcBoO5XAJx1WHUiN5iTCyKpVekX0c+MUJL9E0a3
 qfycQ0EvGA5jjVNLte0AtgnH8gBB9rAWAt6fQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777518536; x=
 1777604936; bh=w3XejX/7o+UEYDwlj6LzU6KZBYItEKyjgOe720sFw9c=; b=i
 Y1BCeSVezWGq7O3APSosbXf1Lbh3uor4pDkEfOXzU1suJ+POhnSyytO9pyOG6jPq
 cNalVg4D+XmPex4UJmOTyQuMpTdPpr1DoSMp/BL76AWs8bT86LXZCRBnmhC5vke8
 iyBqqMZJ4VCVJcZhCN/tq0G7cZxTL2LsyIvNreWp3C5qFt3EaJCswjxPJNgARwAd
 sxpwRxY/itB35FPMY+MEMUMA5dIqDmuMQZ8EOla6aJqEG4eeAbQv2mwaqhiLAzNn
 XI7wxvNxS6dJT3PfF5nrtk/xR+WOXeJ2SQfc4IEQYJCujN/16/A1gFXG3RY1EDl9
 8J+GKXbZAZmuTxG1mu+Ow==
X-ME-Sender: <xms:yMfyaWaOgUtGvDByPvK8xLZyXtkfiZvf3We1xdYP4isVKlazTDP1DA>
 <xme:yMfyaUMZsCGiyTKPnmFZUW_YPgvO4Pizs9ZqbO96K6iDhXmDff6bJE_gAE37K5UCX
 FuCJPLHNYb9Img8WOFOfo_GxCNJoJLhpl8x9UbLIdg6ig_SEp_Qvco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghthhgv
 ficuofgtuehrihguvgdfuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenuc
 ggtffrrghtthgvrhhnpedviedtueefffehledtuddttdduudfgtdevffffkedvffdvhffg
 jeeutdegledutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohep
 ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhitghhrghlrdhsihhmvghkse
 grmhgurdgtohhmpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrihesrghmugdr
 tghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghrrhihrdguvg
 dprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehtrhhi
 nhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtsh
 druggvnhigrdguvgdprhgtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohig
 rdhorhhgpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhmpdhrtghpthhtoh
 eplhhukhgrshiirdgtiigvtghhohifshhkihesthhhrghumhgrthgvtgdrtghomh
X-ME-Proxy: <xmx:yMfyaRXR5RStBCsDX4Nt2jN2y1oHw-krfsyNAtw2fkMaSSOScL4Ecw>
 <xmx:yMfyaWiZm2KoZnCQd44MN510dAOh9U9q3t0GPIpH6KFgByg-Elr69Q>
 <xmx:yMfyaRrxc-VaJk6i1TTeH87XF_hwfBB7fuepwx8zpnB1PCZauGdFvw>
 <xmx:yMfyaUG6lL6fw5aitxG9GCPF8aEBa_cQG4rm_6wqE8q8iR_jTEq61A>
 <xmx:yMfyaeCtxYvGKCF35SHIaLP_n2tBpoxSugyrVKIkCwPHUoumRoo-w9eK>
Feedback-ID: i426947f3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 33BA915C008C; Wed, 29 Apr 2026 23:08:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A9FgZx7NEMOw
Date: Thu, 30 Apr 2026 13:08:35 +1000
From: "Mathew McBride" <matt@traverse.com.au>
To: "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Simon Glass" <sjg@chromium.org>
Cc: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>,
 "Lukasz Czechowski" <lukasz.czechowski@thaumatec.com>,
 "Michal Simek" <michal.simek@amd.com>,
 "Marek Vasut" <marek.vasut@mailbox.org>,
 "Padmarao Begari" <padmarao.begari@amd.com>, "Peng Fan" <peng.fan@nxp.com>
Message-Id: <0f64c232-1f6d-48ab-bb55-379f50245458@app.fastmail.com>
In-Reply-To: <35038a9a-fa5a-4f9f-b34e-17cc80a7824c@cherry.de>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
 <20260421-ten64-add-usb5744-v2-1-eaa81288e393@traverse.com.au>
 <CAFLszTh=NVKYe2NS5t_kj2t9C+3oCfUqpY919fqEr9jyHgpN5w@mail.gmail.com>
 <35038a9a-fa5a-4f9f-b34e-17cc80a7824c@cherry.de>
Subject: Re: [PATCH v2 1/8] usb: onboard-hub: fix compile issue with gpio.h
 import
Content-Type: text/plain
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

On Sat, Apr 25, 2026, at 3:55 AM, Quentin Schulz wrote:
> Hi Mathew,
> 
> On 4/22/26 3:15 AM, Simon Glass wrote:
> > On 2026-04-21T00:04:33, Mathew McBride <matt@traverse.com.au> wrote:
> >> usb: onboard-hub: fix compile issue with gpio.h import
> >>
> >> This resolves the following compile error when compiling
> >> ten64_tfa_defconfig:
> >>
> >> In file included from ./arch/arm/include/asm/gpio.h:2,
> >>                   from common/usb_onboard_hub.c:10:
> >> ./arch/arm/include/asm/arch/gpio.h:17:9: error: unknown type name 'ulong'
> >>     17 |         ulong addr;
> >> ./arch/arm/include/asm/arch/gpio.h:18:9: error: unknown type name 'ulong'
> >>     18 |         ulong size;
> >> ./arch/arm/include/asm/arch/gpio.h:19:9: error: unknown type name 'uint'
> >>     19 |         uint ngpios;
> >>
> >> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> >> Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org <mailto:%2Busb@mailbox.org>>
> >>
> >> common/usb_onboard_hub.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Only received the v1 so commenting here again:
> 
> Well, it doesn't fix the actual issue which is include/asm/arch/gpio.h 
> use types that aren't defined in its scope.
> 
> So what I think we should be doing instead is to add the proper include 
> in include/asm/arch/gpio.h such that the types are defined, I'm assuming 
> it should be as simple as adding
> 
> #include <linux/types.h>
> 
> to include/asm/arch/gpio.h (or replace the unknown types with something 
> that actually exist in that context). Otherwise, we'll end up having to 
> fix all users of asm/gpio.h which do not include linux/types.h one way 
> or the other. Can you please test that?
> 
Adding #include <linux/types.h> to the top of arch/arm/include/asm/gpio.h
does solve the issue, while leaving common/usb_onboard_hub.c untouched.
(The CI does not detect any build errors as a result of this change on other boards).

There are other versions of asm/gpio.h for other archs (arc, mips, powerpc, sandbox, x86 etc.),
but I think we should leave them alone unless a problem occurs?

> Cheers,
> Quentin
> 

- Matt
