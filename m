Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CB606A326
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UXnJT8b5;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=HHaRZbJd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D39C8409CC;
	Tue, 10 Nov 2026 16:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fL0tBRGUs9Cq; Tue, 10 Nov 2026 16:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D90EC409ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794326548;
	b=B87hay6mfMNLUyxajmBZaiEsZvso5OtSOTw/1puggpb2BBSjuCyEcY/VDLS1m3oVN/ci
	 EoF5UCgkCU13Y+JURk1NNiaJwfdFoxsOQ6DQQj5u+35eGIIuwZE8pVzrYdt5yKqZHMMsm
	 NGltNuPVcHxXzGZQoFYyt3Tn9YCcj1QhI6FQXCwSzL7XC47HHcjZ8SYXD4KGgWPozw4wK
	 OhX4gMnRGsc7saudtav38bC5+zRsugqUR1C2baxDr7aO1ovbFm2uB9kzL68hfRVXOQ+hb
	 b315Xs1GPAxtiBPd6QTqk2Ms1SZwSGNEWQ1NjDbEXnGEj54+csEP16urnnv+UYHKKrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794326548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ccVqh9h7GG6HGRl10ZMBdlVk2dwf2beEGQ4VtFSmT0o=;
	b=lcRDTWVsME7agXFI+MrSw63BCpQ5tYMK6lxZB3j9z08M365kQuJOimjpNSXBFyEJ9hxQ
	 Y2QjYjS31nJx2mCdvZdXIlpuy5eIIDkNpRvF7aniJaNDMILO0dxnb25jBNWEVqndxWqDv
	 RUk7k0JnuqDK5myvYl3EdAMTcF6kra6ur0c5Is1LP99lZ4mbdPy4aSEBvRbqIlIsf+AGr
	 d/wAbsHIfEly3XOCXEjE3qtmO7umg3JvZOzQZkoD1Xmq1Yoj2g+iaMKPdH3SE7/OD2Y/3
	 oLrCvFf+x/fapqkzy7OFb/Dfct9uhWkmLc8fx6iG6GPDbi5Z6beutHKz7MK6G+jWdaw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794326548;
	bh=ccVqh9h7GG6HGRl10ZMBdlVk2dwf2beEGQ4VtFSmT0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UXnJT8b51HjQ+lOBUynp8fpOlG8J5lDRw9d2ebRqH2su2uOQV5PzcZ4AD2VY3fNtt
	 vsjdQl7y73Jm7jwI5e6OOx/b8wosQfSrgVcCyWlA/ez4gxh4TDBd0MJbSl9doVhHrM
	 +xl69EP4nVlYtT5dInibyvPfdlUFHa1RBVWXzYsZ+8EL4Z1HnUSePMG8mPW45HQVts
	 x1PIEFcCQCW7UJJP3DHs8hykbyn73DXHDOPtFOklLLSEMRr8g8zGr9gOI6M2MOjWAx
	 qtOL7PPH15HgD9Z2hZ7DKQ7BSW5095bmY+0SJti+tT4t8bY1AV+/fQ7jRYZMRQrudo
	 3UCdPiwhSdPSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D90EC409ED;
	Tue, 10 Nov 2026 16:02:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF269731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4BFB81186
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d3We5Mo65iwh for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 16:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A65F81190
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.125.25.14
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.14;
 helo=smtp-190e.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=HHaRZbJd
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [185.125.25.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A65F81190
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 16:02:23 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jPBHc4n9kzW3l;
 Tue, 10 Nov 2026 17:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794326540;
 bh=ccVqh9h7GG6HGRl10ZMBdlVk2dwf2beEGQ4VtFSmT0o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HHaRZbJdkoM7OJlSoVkZbHjvSVcfKD6AHJbIqcsvAGc3bDkibA7/zvwYlu7gvLgoY
 TwcRtOpqxdPmiaemm44Yxgf9T0UBoUXLEfmAbb+OCnPbkiODrOrXY41c2QaZOZ3wNT
 miQoTWGZNyIN5R/g7UmR5pvdbAccFS/6T/a20YtM3rdDQ4hQvyKmMoa47e2fcj3NBv
 ZlE2gRIup3nrJR92muTI4vX8SnaRkbHLv3gIuNjc28Y+0GaZZ1OBJZ8akRaEHA6A7m
 vAXNSGOU5g07I7blbZ33PfVMKbvqwOFDxOUpvyXNifTKBAwB4QtAq1IzoezCGXnUM7
 Jb7xZZJHkHaFg==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jPBHb4wnQzXHy; 
 Tue, 10 Nov 2026 17:02:19 +0100 (CET)
Message-ID: <670e5c96-6330-4cbb-a8ca-8d2247169faa@0leil.net>
Date: Tue, 10 Nov 2026 17:02:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Add support for KICKPI K1
To: Yuming Chen <3305708832@qq.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 ilias.apalodimas@linaro.org, chenjh@rock-chips.com,
 u-boot@lists.u-boot-project.org
References: <tencent_3B62428BD3AA1A925C6D6F63D2E1190B9E08@qq.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <tencent_3B62428BD3AA1A925C6D6F63D2E1190B9E08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yuming Chen,

On 10/31/26 5:37 PM, Yuming Chen wrote:
> The KICKPI K1 is a RK3568B2-based single board computer with eMMC,
> microSD card slot, dual Gigabit Ethernet (Maxio MAE0621A PHYs with
> on-board crystals) and a 1500000 baud serial console on UART2.
> 
> Add a minimal device tree enabling eMMC, SD-card, UART2, USB OTG
> and both GMACs, together with a defconfig to boot from eMMC or
> SD-card.
> 
> Signed-off-by: Yuming Chen <3305708832@qq.com>
> ---
>   arch/arm/dts/rk3568-kickpi-k1-u-boot.dtsi |   3 +
>   arch/arm/dts/rk3568-kickpi-k1.dts         | 226 ++++++++++++++++++++++

We do not accept downstream Device Trees for Rockchip boards anymore. 
Please work with the Linux kernel to have this Device Tree upstreamed, 
then once it's merged and available in 
https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/, 
you can add support for it in U-Boot by cherry-picking the Device Tree with

./tools/update-subtree.sh pick dts <commit_hash>

Cheers,
Quentin
