Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42281E88D7A
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 03:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABA38407E;
	Sat,  4 Apr 2026 05:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="ThYLjRa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C7A840AA; Sat,  4 Apr 2026 05:56:29 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACD8883B8F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 05:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 97AC3113080; Sat,  4 Apr 2026 05:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775274986;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Pj5MdMAj5Fn8VgA43k39q50cavxcH96WqRQ0J8y3tt0=;
 b=ThYLjRa+lw1uGJBTEbfRMd2bEjtEllZwSgthVc6/527pCF3oREPZsCVCLxSjN45Ed7UoBS
 c/mAbd3uELF8vNrl9zVbMySpFCyLjH5ZVBe0ghq/BYrjPLenokZg0Lh0Dg/NaUBP/okBmz
 ygiIHrOTxBVPpWRInPhuxljQYZFu+vaQgzSzDJyiPf2Xzik6Cd6ivpJcII8b2TATc8kdXQ
 IWzchjOuWZvZhkss381OpjPaXikbJysOyfIjwndy68Ngf0BDvkbtBJFYkvOStVSYW/TLF5
 2lZS/n7k1VOOTvLbaQeAAS1KrJnbiZnErCS90JH0xR3aQ8yQ2xq3fEPeyRDQTA==
Message-ID: <b884d242-6be2-4783-81d3-0bd55c81a216@nabladev.com>
Date: Sat, 4 Apr 2026 05:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] imx8mm_evk: FSPI build broken by 37e50627e
To: Alexander Koch <akoch@initse.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
 "ye.li@nxp.com" <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
References: <fcc606350e96e03911f6c67537853de1ad51dc10.camel@initse.com>
 <861d61d6-3d35-47bf-9cea-21f7cfd13c1a@nabladev.com>
 <24e183b2fc5419b9ed1685f49a67fb9822b1ad73.camel@initse.com>
 <a5f735cc-e699-422a-b88d-e5fe33fc8b7b@nabladev.com>
 <ea2937eabb137e2c5845bc451f7c28a827496eb3.camel@initse.com>
 <CAOMZO5CsuTw92safK80f0v+0hPkOQvHVEfKZyqWvfdw7ghnxmg@mail.gmail.com>
 <CAOMZO5AqeMmeWLXX3mPKceshw8T=fcFax7Ja=tfm0Qf6Mh_cOg@mail.gmail.com>
 <032b2f81f63f0fa9f3f5910edd4222932b4a4741.camel@initse.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <032b2f81f63f0fa9f3f5910edd4222932b4a4741.camel@initse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/3/26 9:23 PM, Alexander Koch wrote:
> I think I have narrowed down the cause for the broken SPL blob but I don't fully
> understand it.
> 
> Comparing hexdumps of the last working SPL+DDR blob and the first broken one we
> can see three chunks of difference:
> 
> 1) two bytes near the IVT
> 2) U-Boot version string and compile timestamp
> 3) four bytes around offset 0x18b50 (striped at 16 bytes)
> 
> Let's ignore number 2) as that is expected and focus on 1) and 3).
> 
> For the first difference we have at offset 0x20 in spl.bin (0x1020 in
> flash.bin):
> 
>    good: 0000 0020:  C0 0F 7E 00 00 DC 02 00
>     bad: 0000 0020:  C0 1B 7E 00 00 D0 02 00
> 
> I first thought it could be the boot data pointer not reflecting the FSPI config
> blob offset but if I read `struct ivt` correctly this is actually _after_ the
> IVT itself.
> 
> So I patched these two bytes in the broken 'flash.bin' and that made the SPL run
> (while console output still stopped before ATF).

board/nxp/imx8mm_evk/imximage-8mm-lpddr4.cfg:LOADER 
u-boot-spl-ddr.bin      0x7E1000

configs/imx8mm_evk_defconfig:CONFIG_SPL_TEXT_BASE=0x7E1000

It seems the SPL entry point address somehow changed ... from 0x7e0fc0 
to 0x7e1bc0 .. the delta is 0xc00 , does that fit into some offset in 
the imx8mm-u-boot.dtsi binman node ?

> The second chunk of interest is at offset 0x18b50 in spl.bin (0x19b50 in
> flash.bin):
> 
> good:
>    0001 8B50:  B8 C4 80 00 00 00 00 00
>    0001 8B60:  F8 69 80 00 00 00 00 00
>    0001 8B70:  74 63 80 00 00 00 00 00
>    0001 8B80:  80 E5 7F 00 00 00 00 00
> 
> bad:
>    0001 8B50:  B8 D4 80 00 00 00 00 00
>    0001 8B60:  F8 79 80 00 00 00 00 00
>    0001 8B70:  74 73 80 00 00 00 00 00
>    0001 8B80:  80 F5 7F 00 00 00 00 00
> 
> After patching those 4 bytes I got ATF and U-Boot proper running so I'd consider
> that flash.bin fixed.
> 
> Can anybody tell me what we have in those two locations?
These locations are offsets of the lpddr4_pmu_train_* DRAM init blobs , 
see arch/arm/dts/imx8mm-u-boot.dtsi . When binman bundles those blobs 
together with SPL, it patches the locations of those blobs into the SPL 
binary. It seems it patches in the wrong offsets ... offset by 0x1000 
Bytes , isn't that the size of the FSPI page ?

Thank you for investigating this problem, it is much appreciated !

+CC Simon, maybe he can help with binman ?
