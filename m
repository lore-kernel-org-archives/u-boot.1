Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF309C3600C
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 08:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8EBF82B17;
	Sun,  6 Apr 2025 10:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Pppdrtk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFD082B1F; Sun,  6 Apr 2025 10:50:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B89982B12
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 10:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5bca=WY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743929431;
 bh=9XzowZunV9YnAlwVYf6RMEN+NHYyswz59veFSnyn1ZE=;
 b=Pppdrtk7LIKwynCkb6czFHoQcnhbkOSJSC8gQsXhS/UsRJkFCKXMN70hSsswkyFJC4m8+b+/9
 /yFACSSdBxqBeoJQc4VqNvWai6cwtsP42CtVnhqo7NdnDbUUlk3QpVyD6o/ROVZCyyN8iaMkYn7
 2G6pgQ60gFgrfsSl/yJ9ZBhZ3r8eAjofuz+INDhJXBqBySSWLRjTpDfFAwJFEegWHbzs6VRUkbf
 gkO+PNq6UEviu4j4XN+QorICoLTtT7hrm/ey9SnyLcbE/OzQ3GBlLC/nOKdgJbcEugano9rYLH0
 jCwIh+bZ++yeAAJyPgtsO/wL2zV8yHAA6UsO4GoQQmYg==
X-Forward-Email-ID: 67f24052728eb85f56834b3b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <33614601-f517-4031-b947-702d2bba7d69@kwiboo.se>
Date: Sun, 6 Apr 2025 10:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: designware: Disable DMA on removal
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, neil.armstrong@linaro.org,
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20250405221308.498047-1-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250405221308.498047-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 2025-04-06 00:12, Simon Glass wrote:
> At present, removing the device frees struct dw_eth_dev but does not
> disable DMA. When DMA is active, packets can be received even if the
> driver is not active.
> 
> While it is possible that the memory used by the struct may remain
> untouched after removal, any other allocation may reuse that memory
> and result in DMA writing to random addresses.
> 
> In most case U-Boot does this removal in announce_and_cleanup()
> immediately before jumping to the OS. No further allocations are done
> after that point.
> 
> But with EFI_LOADER this function is not called before jumping to the
> EFI app. U-Boot continues to run while GRUB starts and finishes, as well
> as while Linux is starting up. During this time, devices cannot be
> removed, as they are in use. U-Boot completes the removal when
> efi_exit_boot_services() is called. It seems that this function does
> more allocations after calling dm_remove_devices_active() although I
> can't figure out where.
> 
> Fix this by disabling DMA when the driver is removed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
> ---
> 
>  drivers/net/designware.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
> index 07b0f49ef58..eebf14bd51a 100644
> --- a/drivers/net/designware.c
> +++ b/drivers/net/designware.c
> @@ -809,6 +809,7 @@ static int designware_eth_remove(struct udevice *dev)
>  {
>  	struct dw_eth_dev *priv = dev_get_priv(dev);
>  
> +	_dw_eth_halt(priv);

This should not really be needed, eth-uclass already call the stop() ops
that in turn call _dw_eth_halt() from the eth-uclass pre_remove() ops.

So ethernet should already have halted when remove() is called, calling
it here will probably only hide any real issue.

Regards,
Jonas

>  	free(priv->phydev);
>  	mdio_unregister(priv->bus);
>  	mdio_free(priv->bus);

