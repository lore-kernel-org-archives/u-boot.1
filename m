Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD0ACA5FF1
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 06:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F042F8307F;
	Mon, 19 Jan 2026 07:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HtXIgs5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36988313B; Mon, 19 Jan 2026 07:43:11 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4F883015
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 07:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dvgrQ2fhZz9v0r;
 Mon, 19 Jan 2026 07:43:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768804982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+kyww5qIpu7ybDPtDwzXg9BA1vzRuoa4DlFDXFDQ5Q=;
 b=HtXIgs5OjyHQuBJ/Sh2+piXT31nyYxye8lh4fbI84+AQNkuDrfJ+eRD+W4qoe0pZb9WtdQ
 9q6EPZM/lkaAbYUXceu9x6uffC+MEyEO9AM3EPEE2batwx75X16mnAZ1P6lrvFH/iyv3F3
 rm+LXM3t9HVjsOzose3PkL4g2z8scKWZSZsGOrirULbsIKV3WOEdFstJ1NicjOLjeIPQTE
 F2F3Jdge+si7lL9cpnyxI0mYEU0t5w1XOo6jL1eo9CjKP77XFmriK23niTBjflP2y05bzb
 OjTYbvwQp5/hQbbWnGccIRBvOzEGSWMcEyN0lPCUpLjd1+PDjRy++eBBJoXbIw==
Message-ID: <e406ccb2-670c-481a-a128-d25a8973341b@mailbox.org>
Date: Mon, 19 Jan 2026 07:42:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] board: unmatched: Workaround failure to find .dtb file.
To: Vagrant Cascadian <vagrant@debian.org>, u-boot@lists.denx.de,
 Green Wan <green.wan@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peng Fan <peng.fan@nxp.com>
References: <877bteqx7y.fsf@wireframe>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <877bteqx7y.fsf@wireframe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cgkg11ajiueh9c6gsnduyidckskqnq1g
X-MBO-RS-ID: 07943725f549077d3d1
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

On 1/19/26 1:09 AM, Vagrant Cascadian wrote:
> The fdtdfile variable contains quotes:
> 
>    printenv fdtfile
>    fdtfile="sifive/hifive-unmatched-a00.dtb"
> 
> But this leads to issues which booting with an extlinux.conf format
> file failing to find the .dtb file:
> 
>    Retrieving file: /usr/lib/linux-image-6.12.63+deb13-riscv64/"sifive/hifive-unmatched-a00.dtb"
>    Skipping fdtdir /usr/lib/linux-image-6.12.63+deb13-riscv64/ for failure retrieving dts
> 
> Other platforms (e.g. rockpro64-rk3399) do not contain quotes in the
> fdtfile variable, and work properly out of the box.
> 
> The workaround suggested by marex is to hard-code the correct .dtb
> value, which works for me.
> 
> This has been present at least since version 2025.01, also present in
> 2026.01. I have not yet tested against git master branch.
> 
> This could probably be properly fixed by stripping the quotes in
> whatever processes the .env file. There are numerous other boards that
> have the same way of setting the fdtfile variable, which might
> similarly be effected by this issue.
> 
> Signed-off-by: Vagrant Cascadian <vagrant@debian.org>
> 
> Not sure who all to CC on this, please feel free to forward
> appropriately!

./scripts/get_maintainer.pl -f board/sifive/unmatched/

produces a few names, added

> ---
>   board/sifive/unmatched/unmatched.env | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatched/unmatched.env
> index 34425dc9efa..cdba2c8ae0e 100644
> --- a/board/sifive/unmatched/unmatched.env
> +++ b/board/sifive/unmatched/unmatched.env
> @@ -16,4 +16,4 @@ partitions=
>       name=loader1,start=17K,size=1M,type=${type_guid_gpt_loader1};
>       name=loader2,size=4MB,type=${type_guid_gpt_loader2};
>       name=system,size=-,bootable,type=${type_guid_gpt_system};
> -fdtfile=CONFIG_DEFAULT_FDT_FILE
> +fdtfile=sifive/hifive-unmatched-a00.dtb

Also +CC Peng because iMX is also affected.
