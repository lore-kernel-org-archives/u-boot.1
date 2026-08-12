Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D8C5CFCF
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A51560674;
	Wed, 12 Aug 2026 14:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSIpdxoHUKrt; Wed, 12 Aug 2026 14:06:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0720C60633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786543610;
	bh=ypEmeiinNRA6N0HH0w7RX0Ys1ASq2m24Vs8Sqt1wYWI=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=vJbo4DXSgJI1f5yO7VdM6ogG/V27T5JVRi0oBjNxKqYqsJA2/oCXHhDQX7GKztUrL
	 KLszAaR8D1hcXzvG1UU+I8UZLkQESBRYezHPx2kC3AV5YPzrqmd55AX3Rhail/UFsz
	 P2ZMS8pQOVzmRcq/dbdKzJLJ6lW6xxeH/nq/9V4ICefFOozuOMR/o/9scufhBKJdAw
	 yqq3quis3hdT+7AhppWKR4Ab4s9ZIAPGivm26Pan/jny6TaWvT2cP6UdCg2XV8j+Ke
	 2gR2IN4sgos44iNg+JuDd6x+uq1uOt0FWj7VfbmWaK6rIWtN29G3LSmlt70IRD50v8
	 gJlvq13QmNLfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0720C60633;
	Wed, 12 Aug 2026 14:06:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 85BA91F41
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:06:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7638A80F97
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:06:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZF5dvtPPCin for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 14:06:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.10;
 helo=smtp-bc0a.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 85EE380F93
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85EE380F93
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [45.157.188.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85EE380F93
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:06:46 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKqzm5tTJzKD6;
 Wed, 12 Aug 2026 16:06:44 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKqzl5rFQzmkS; Wed, 12 Aug 2026 16:06:43 +0200 (CEST)
Message-ID: <6c7c302a-1b68-4443-b2fe-506cb2e1f754@0leil.net>
Date: Wed, 12 Aug 2026 16:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] rockchip: tools: add comment section to rkimage.c
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
 <53c6506a-c81e-474e-9a6f-33d86242e066@gmail.com>
Content-Language: en-US
In-Reply-To: <53c6506a-c81e-474e-9a6f-33d86242e066@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786543604;
 bh=ypEmeiinNRA6N0HH0w7RX0Ys1ASq2m24Vs8Sqt1wYWI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mACJHloiGZuIZfL4gvMMjfGk8JaLRe9Ez101CwaXQKpZpHUAtf4611JBbU9nk53fh
 gTV4dcs9p2P4nAw7gULwD5EQbZyMq102GqHQIKVSKyWEFxUjMOPCGScl3suohKsXa4
 N/C0mYdPd0hI+oLl9LQYJ7tHsT+Jl8h6LwpNupdCXGn0aqeS9FMfTzX4sjUDn6Z0Dt
 xiu867hWTZfJsMzMx3jllUBNR0ABUz/xBa1WDKHvnEVx3yj5oFUgZMdMM0jWNlu+Iu
 FxAhGla/HRj4Ih6m1/TVLmgEGozxRyj9NT98TnBXQXh7WysihhPnyK35DkAmLeOqBp
 mvzBNcc8Yn08w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=mACJHloi
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 8/6/26 1:12 PM, Johan Jonker wrote:
> README.rockchip must be removed.
> Move the rkimage comment section to rkimage.c
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   tools/rkimage.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/rkimage.c b/tools/rkimage.c
> index 1c5540b1c3d1..0cabdf2f6723 100644
> --- a/tools/rkimage.c
> +++ b/tools/rkimage.c
> @@ -3,7 +3,9 @@
>    * (C) Copyright 2015 Google, Inc
>    * Written by Simon Glass <sjg@chromium.org>
>    *
> - * See README.rockchip for details of the rkimage format
> + * rkimage.c produces a SPL image suitable for sending directly to the boot ROM
> + * over USB OTG. This is a very simple format - just the string RK32 (as 4 bytes)
> + * followed by u-boot-spl-dtb.bin.

It actually does a bit more than that. It's not RK32 for starters, it's 
whatever the SoC (passed via the -n argument to mkimage) expects (can be 
RK33, RK30, RK31, RK32, RK35, RK11 or 110B for example, see 
tools/rkcommon.c) the magic value to be. If the SoC requires rc4 
encoding, the image is also encoded.

To be honest, I'm not even sure this still works and for which SoCs this 
applies.

I'm thinking we should reword this to something like:

"""
Takes a single image, sets the magic value expected by the SoC in the 
first 4 bytes, and RC4-encodes the result if needed.

The output is typically used as payload for the Mask ROM, uploaded via 
USB OTG.
"""

Vague enough yet precise enough. What do you think?

Cheers,
Quentin
