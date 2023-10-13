Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630D8CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 07:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22FA486E5D;
	Fri, 13 Oct 2023 09:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cJnG29va";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C601286E2C; Fri, 13 Oct 2023 09:16:49 +0200 (CEST)
Received: from mail-m15594.qiye.163.com (mail-m15594.qiye.163.com
 [101.71.155.94])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C7086E42
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cJnG29vajOm+Gp10CNC5al0fOSrtAoo1KvJ1NhAsPtfGm1E1dhHrPbYt8m8y/UajA1G9VWgi0P+f5REjOqlA9rUXHlpAExPpmy8wiZO+U5rAjXdjLyedMbR5MOsu9QLu5ZFNy8c4SWlpTyV5tdPf2pJupykXMW4xjrUaUd0oJK4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=DX7gRX44Aok/sfIzNi0HodtxJC/78ia8HvPuQcQfnVc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id B2C5B4001E6;
 Fri, 13 Oct 2023 15:15:30 +0800 (CST)
Message-ID: <656e3e70-ca8f-75dc-6346-70d3938efea5@rock-chips.com>
Date: Fri, 13 Oct 2023 15:15:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 4/7] rockchip: block: blk-uclass: disable bounce buffer
 support for rkmtd
Content-Language: en-US
To: Johan Jonker <jbx6244@gmail.com>
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <4050eaef-b4c7-3f18-6bd0-a89ac03ba4bb@gmail.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <4050eaef-b4c7-3f18-6bd0-a89ac03ba4bb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhNSlZJHh4YSB5DHUxKSh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b27e3ee622eb3kusnb2c5b4001e6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6Dzo4FjwzHAkfCS0iFzYC
 PCMaCwFVSlVKTUJMSkNKSEhKQ0JMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISk9DNwY+
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


On 2023/10/13 04:51, Johan Jonker wrote:
> Disable bounce buffer support for rkmtd.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>
> Changed V3:
>    New patch
> ---
>   drivers/block/blk-uclass.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 30ad5bbb0024..ac1b43d757d8 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -415,7 +415,7 @@ struct blk_bounce_buffer {
>
>   static int blk_buffer_aligned(struct bounce_buffer *state)
>   {
> -#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)
>   	struct blk_bounce_buffer *bbstate =
>   		container_of(state, struct blk_bounce_buffer, state);
>   	struct udevice *dev = bbstate->dev;
> @@ -441,7 +441,7 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
>   			  start, blkcnt, desc->blksz, buf))
>   		return blkcnt;
>
> -	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
>   		struct blk_bounce_buffer bbstate = { .dev = dev };
>   		int ret;
>
> @@ -478,7 +478,7 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>
>   	blkcache_invalidate(desc->uclass_id, desc->devnum);
>
> -	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
>   		struct blk_bounce_buffer bbstate = { .dev = dev };
>   		int ret;
>
> --
> 2.39.2
>
