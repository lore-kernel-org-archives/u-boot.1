Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4559C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1416940F48;
	Fri, 31 Jul 2026 08:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6postEEqLeGc; Fri, 31 Jul 2026 08:52:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77B2840EB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785487925;
	bh=uSpBdBvyFhi7MpeGq8yPoxdhTqtXgwHzCdTHjA5TFE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZVybIfvoTziKbpltUZcnE5xW76esN3H+3ejQWiw2ALujxN4Lj8o42sUSJEg4d1dzE
	 uJHwptAOz7Wu+5ltgILX4oC4n7yOD1rKMOhQbH8yMjr2QBFEHmoeGHgVOyiBe5YIt4
	 bLojlpgLUISVihN6GWw3m+qN4DFMCuOMjNb8RoCdIisPcO+a4OJWFBa4/giMC4PZVy
	 oY2cDeadxxPbDhoy8gij7vlqCYLvxyk+8yhlHCqXhu5OpvhyLv+wkfzaQXErSx4kDw
	 Wbb4cHL13B7mGjtON56eeruyNRa1Wa+T55fFGJzLI4BljuPaSf6271Zm0q7UVzSsG2
	 jzMsbvYeSv6ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77B2840EB4;
	Fri, 31 Jul 2026 08:52:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E184126C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C82F940EB4
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycTBWBqBbxVO for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:52:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C100140EAE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C100140EAE
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C100140EAE
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:52:00 +0000 (UTC)
X-Forward-Email-ID: 6a6c622d3d2a6a998ff2bd2b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <06693e97-d193-4ad2-ad1e-73505be5d238@kwiboo.se>
Date: Fri, 31 Jul 2026 10:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] rockchip: tools: add comment section to rkspi.c
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <1eac0a41-c3bc-47e3-9868-36ff49f9c84b@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <1eac0a41-c3bc-47e3-9868-36ff49f9c84b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785487920;
 bh=uSpBdBvyFhi7MpeGq8yPoxdhTqtXgwHzCdTHjA5TFE4=;
 b=RiXqERlfMHfEe5cEXuDxwPXgBI5tCt8fWi6CEFhaXaGt39nxbqX4+NMuya9hIemkQc2MCJ/r9
 jYaXxPmDnNkyo+IzV+6IMdziuxb9Z1CffNr4HSQF4fJ8EvgLHd7BWTeWJeZL0PqWnXfCzj1lOsH
 gdg2pPvXBq8vL0WnT4gX2oAy0eavj98TmzxFatcVpT9PmZH9VoVW6s2Lnki2xYYjRBNJfxka9Ak
 rR/wUP56uaqxlgPUfVjS0+MLQHTO8durpLtKHaFmUthm3rghNqUZCKL5RrilSJZ9wsraHT3a+in
 9nCVhy57lXMOFnxHaUEXjhx1OLSTnYArniChbmuDflDA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=RiXqERlf
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/30/2026 3:35 PM, Johan Jonker wrote:
> README.rockchip must be removed.
> Move the rkspi comment section to rkspi.c
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  tools/rkspi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --
> 2.39.5
> 
> diff --git a/tools/rkspi.c b/tools/rkspi.c
> index f2530f7bde34..4f98a60a0692 100644
> --- a/tools/rkspi.c
> +++ b/tools/rkspi.c
> @@ -3,7 +3,11 @@
>   * (C) Copyright 2015 Google,  Inc
>   * Written by Simon Glass <sjg@chromium.org>
>   *
> - * See README.rockchip for details of the rkspi format
> + * rkspi.c produces an image consisting of a header and u-boot-spl-dtb.bin.

As for rksd, 'u-boot-spl-dtb.bin' is not really used, binman mkimage
node select what images is used. Typically TPL + SPL, or SPL + proper.

> + * The resulting image is then spread out so that only the first 2KB of each 4KB
> + * sector is used. The header is the same as with rksd and the maximum size is
> + * also 32KB (before spreading). The image should be written to the start of

The size limit is also wrong here and is SoC specific and the offset
where the resulting mkimage should be written to is also SoC specific.

The offsets is only correct for u-boot-rockchip[-spi].bin files, not
for the images that mkimage produces.

The only information possible worth mentioning here is that the first
2KB of each 4KB page is used, but this is already documented further
down in this file.

Suggest you just drop the reference to README.rockchip here.

Regards,
Jonas

> + * SPI flash.
>   */
> 
>  #include "imagetool.h"

