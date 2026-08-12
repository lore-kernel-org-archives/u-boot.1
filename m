Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAF4C5B572
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 14:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E64960A78;
	Wed, 12 Aug 2026 14:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fAX9fwTxQIXr; Wed, 12 Aug 2026 14:45:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8442560A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786545918;
	bh=3XVvpfAAb02pUvs44mcomh3LkzVkffqHQdgi/jI3HzU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=MZ4l1nnMYl/4f3ssZxsiNUWtZBLfoXsMBOTktGqfAdUDFyaZVJBJT1xDTafZmz/Nd
	 2Uy0Z34FUPTpxoLecQ/bohZLz0+plixZj+A37t+peqBVbN2aAaJFqNM81BWyj4U69E
	 9/6vS2aSEWrsbBun3UVIY0szBunzJcue+/BOml7fvM9bNgbmH1HXDTa8j/Jmw3mJ8S
	 LhgYfKF76qZdJr0lvJpEvQ6eE/32gNhLNzS45dWlkJMBhq+Hl+l5z+40fYc1IZQbD2
	 Cblo0eBYuPkqMOAsFSVkRfwpnG6zU/nns6du3kIClLN5li/ZfTzSMbkWAV/SjOgeMy
	 R8BVxeJ1KsbEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8442560A63;
	Wed, 12 Aug 2026 14:45:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 85272282
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AE8981297
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:45:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZYzrvdSDXVqy for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 14:45:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::8fa8; helo=smtp-8fa8.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8C65F81294
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C65F81294
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::8fa8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C65F81294
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 14:45:14 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hKrr82jl4zln1;
 Wed, 12 Aug 2026 16:45:12 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hKrr64xmdzB37; Wed, 12 Aug 2026 16:45:10 +0200 (CEST)
Message-ID: <c5fef18d-7686-4573-8fdf-2b81ea35b345@0leil.net>
Date: Wed, 12 Aug 2026 16:45:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] rockchip: doc: remove README.rockchip
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <0ce61246-3191-4ce2-a7ea-8ab3c02cfe80@gmail.com>
 <d77e3e79-2c79-4fa8-b6fd-d37fe04f8d6b@gmail.com>
Content-Language: en-US
In-Reply-To: <d77e3e79-2c79-4fa8-b6fd-d37fe04f8d6b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786545912;
 bh=3XVvpfAAb02pUvs44mcomh3LkzVkffqHQdgi/jI3HzU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lEW5CELER4Tb3PCzQTNGveec2WqbsbydDR3rvMUlm5lgUqBwmzJh+lTk/38/P5mCI
 czhQULQQpGrNJB+Dm1fY5CpHL9Ses0guB4WTelZ1QxbBFn/F5pMsgxx/dQTkzEZq6E
 VVS8ZyitD2VdaPkgFM9UOimIahxubydnDx+r2TH9rc0yCUJW3buf9Y4AHEBCMmLLb1
 ZF0jwWOOpCrOFtOB0pjYs9jc971x1os8Hp6FOfFoKFRTfAdK3JcUak5GwaZNxxiKuk
 DzI0NW856ridFvpdah+REK2l1oqkje4ESWdDelHPjabr0KgKy6jyAsPaiO6SXq7fIf
 oB/hhpmfiW1gA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=lEW5CELE
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

Please squash patches 5, 6, 7 and 8 with this one.

On 8/6/26 1:12 PM, Johan Jonker wrote:
> Remove README.rockchip for info that's already in
> rockchip.rst or no longer applicable.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

[...]

> -
> -The rockchip bootrom can load and boot an initial spl, then continue to
> -load a second-stage bootloader (ie. U-Boot) as soon as the control is returned
> -to the bootrom. Both the RK3288 and the RK3036 use this special boot sequence.
> -The configuration option enabling this is:
> -
> -	CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
> -

I think this paragraph is still somewhat useful info, can you please 
move it somewhere in doc/board/rockchip/rockchip.rst?

[...]

> -Note: rk3036 SDMMC and debug uart use the same iomux, so if you boot from SD, the
> -      debug uart must be disabled
> -

This note is useful information, can you please move it to 
doc/board/rockchip/rockchip.rst next to RK3036-specific sections?

[...]

> -The bootrom of rk3188 expects to find a small 1kb loader which returns
> -control to the bootrom, after which it will load the real loader, which
> -can then be up to 29kb in size and does the regular ddr init.  This is
> -handled by a single image (built as the SPL stage) that tests whether
> -it is handled for the first or second time via code executed from the
> -boot0-hook.
> -

This info is in helptext of xPL_ROCKCHIP_EARLYRETURN_TO_BROM so I guess 
it's fine to remove it (also, it applies to rk3066 as well). Just wanted 
to mention it since it is a very important piece of information I read 
for the first time when reading doc/README.rockchip when reviewing one 
of the earlier versions of this series.

Looks good to me otherwise, thanks for cleaning this up after so many 
years being left untouched!

Cheers,
Quentin
