Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA0CC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E97F80F39;
	Fri, 31 Jul 2026 08:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1eAoNfgco3pC; Fri, 31 Jul 2026 08:41:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADD4480F09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785487317;
	bh=lj9QHEvA0DvlvgeYD4PWdpAL+FI42h+i+cPFgNhdfhM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L1JM2PLhEL7dhhVzXEPxNIln1AVYqLH1GHbML9ZGyeQSSsDjnPZTyJSqj7LBYim1E
	 I3Ay97n99zaKDoCJdWVrGlA0X0lVaa598qjz/MAkP3PBmbnvIBA6KHvJCUI2x6kmyP
	 ogQwwfDJV6w3t5/rDHXdhtoMexkRIVZqLFOs3vqps1hCGJhHc5FVbGHW9qaXLuYuQq
	 zzaUYByzprYV39ZIKdyqiy5AfuK6gH8ueiKTSYv7JaLpvoyUnVykwcg9rwHY1hh0eV
	 ZQ+hSqOuxNOfaMvpr/kHzqlP6BdAHw6MA0BEHaHCErUM/BVTZjQ1W6OpctGxK4WnoZ
	 C2t2dp0gYJmrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADD4480F09;
	Fri, 31 Jul 2026 08:41:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 545692E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3789040E22
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jmy52XkR29QR for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:41:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=f707=fz=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7DF9640C6C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7DF9640C6C
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7DF9640C6C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:41:55 +0000 (UTC)
X-Forward-Email-ID: 6a6c5fd0323e9d4ba9920aa4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9f5438ce-104c-4cf5-82d0-c5278a332dfb@kwiboo.se>
Date: Fri, 31 Jul 2026 10:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] rockchip: tools: add comment section to rksd.c
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org,
 trini@konsulko.com, u-boot@lists.u-boot-project.org,
 eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
 <b6f80fe1-f0ee-4750-a74a-97398a91dc08@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b6f80fe1-f0ee-4750-a74a-97398a91dc08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1785487314;
 bh=lj9QHEvA0DvlvgeYD4PWdpAL+FI42h+i+cPFgNhdfhM=;
 b=gltKW6yjmW0RkLaSFITplfLJkJ51pE52wQR8+FyrRUi2ruu15EZfgx5kO9G8Xf+i8/vGpguVL
 ci5XP1la2gJHd1vGYtVP24X1yp/u4qLj0xi9iHixCL+SYe12VnMq56AaLXFBniWhB5jOk2MZ7M0
 5DTqTRolgh4wgawr2moG+gVlf8AqH8DZhqxMobDaWxAT6611niqCYRpsbEfv0M5NhAaoFW8SQdY
 PPVB8pr6rcHp+xS0WsVDIloDi7IWvCjACzg2AtZ92yhTFw3+8hWv+JdqFdp7hrqh1DC7bMItfF/
 5wBc7KbgYpQzj1J54u18nj8PYXnPEKe+wdMCieWmGWZg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=gltKW6yj
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
> Move the rksd comment section to rksd.c
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  tools/rksd.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> --
> 2.39.5
> 
> diff --git a/tools/rksd.c b/tools/rksd.c
> index 7d46a1b07b3a..ea12b9cac12e 100644
> --- a/tools/rksd.c
> +++ b/tools/rksd.c
> @@ -3,7 +3,26 @@
>   * (C) Copyright 2015 Google,  Inc
>   * Written by Simon Glass <sjg@chromium.org>
>   *
> - * See README.rockchip for details of the rksd format
> + * rksd.c produces an image consisting of 32KB of empty space, a header and
> + * u-boot-spl-dtb.bin. The header is defined by 'struct header0_info' although
> + * most of the fields are unused by U-Boot. We just need to specify the
> + * signature, a flag and the block offset and size of the SPL image.
> + *
> + * The header occupies a single block but we pad it out to 4 blocks. The header
> + * is encoding using RC4 with the key 7c4e0304550509072d2c7b38170d1711. The SPL
> + * image can be encoded too but we don't do that.
> + *
> + * The maximum size of u-boot-spl-dtb.bin which the boot ROM will read is 32KB,
> + * or 0x40 blocks. This is a severe and annoying limitation. There may be a way
> + * around this limitation, since there is plenty of SRAM, but at present the
> + * board refuses to boot if this limit is exceeded.
> + *
> + * The image produced is padded up to a block boundary (512 bytes). It should be
> + * written to the start of an SD card using dd.
> + *
> + * Since this image is set to load U-Boot from the SD card at block offset,
> + * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, dd should be used to write
> + * u-boot-dtb.img to the SD card at that offset.

Not sure where you got this text from, but it seem to be very outdated and
not fully applicable.

Some examples of incorrect information:
- 32 kb size is not fixed, it is now treated as a soc specific limit
  defined in rkcommon.c
- u-boot-spl-dtb.bin is not really used or picked anymore, the binman
  mkimage node in rockchip-u-boot.dtsi determines what payload is added
  as the secondary image.
- 'struct header0_info' is only correct for v1 format, not for v2 format.
- rc4 encoding is only applicable to v1 format
- image should not be written to start of sd card
- u-boot-dtb.img should no longer be used

Most of this information is already declared inside rkcommon.c or in
rockchip.rst, maybe we can just drop this?

Regards,
Jonas

>   */
> 
>  #include "imagetool.h"

