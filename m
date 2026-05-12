Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49630CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 13:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3D58341A;
	Tue, 12 May 2026 15:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jQJUftVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F40836AC; Tue, 12 May 2026 15:12:37 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 620ED803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 15:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gFH7h6nmnz9v8F;
 Tue, 12 May 2026 15:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778591553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GPeqnOOcn5l0G2nfnJztLwgq07UtVpDqn3FkjVUae0=;
 b=jQJUftVbaAzPvqBZN4QOuiP/ChDEGHv8TH5Jj0sksB/WwcGyRw8QCUnTvpKjMvAUnntPoN
 IZ+mxpgKbmdFis+LhVHFdobADRDhO7jYrav1bBE6WhKxE2fqB4RQPoLGjeJzb/ugAnDz6P
 2+zjB2wqg4Q+dOTCGyjMGXq9+iGrdpQssZ0CtxIogryYyytnpaeoyAkXF7c5ES0LynJjWZ
 EO47H/7VW2VyEWXqNObJGDI8TV3r2awi/4/XQKLba8mGNDF7Fiu10ZH1EydkaQpvBJ/J5o
 360CMnS8woUfxhUYhhqs8GE1YeJl40y5XwR0tyl5V7qEwDYlaZtTKKdEQc+9sA==
Message-ID: <8b38020c-4d92-4d46-9c47-eb70dda757a7@mailbox.org>
Date: Tue, 12 May 2026 15:12:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: onboard-hub: Add support for CoreChips SL6341
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de,
 Patrick Delaunay <patrick.delaunay@st.com>,
 Patrice CHOTARD <patrice.chotard@st.com>
Cc: Tom Rini <trini@konsulko.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>
References: <20260512-sl6341-v1-1-2819ac19e050@flipper.net>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260512-sl6341-v1-1-2819ac19e050@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: tqgp74t7wiew91n1frei156k595mnusx
X-MBO-RS-ID: 66a12290c4d73223103
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

On 5/12/26 11:41 AM, Alexey Charkov wrote:
> CoreChips SL6341 is a 4-port USB 2.0 and 3.0 hub controller. It always
> requires external 1v1

1V1 (V in caps), fix globally.

> power and can optionally use external 3v3 power
> (or alternatively it has a 5v->3v3 LDO built in to derive 3v3 power from
> VBUS). It also exposes a reset pin.
> 
> Device tree bindings are queued up for upstream release with Linux 7.1
> 
> Link: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/usb/corechips%2Csl6341.yaml
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   common/usb_onboard_hub.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6fc34489a98f..d15d7bbff87d 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -262,6 +262,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   	return ret;
>   }
>   
> +static const struct onboard_hub_data corechips_sl6341_data = {
> +	.reset_us = 10000,
> +	.num_supplies = 2,
> +	.supply_names = { "vdd1v1-supply", "vdd3v3-supply" },

Is there a YAML binding document patch which describes these supplies 
already , maybe a patch posted to devicetree@ ?

> +};
> +
>   static const struct onboard_hub_data usb2514_data = {
>   	.power_on_delay_us = 500,
>   	.reset_us = 1,
> @@ -299,6 +305,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb4b4,6506",	/* Cypress HX3 USB 2.0 */
>   		.data = (ulong)&usbhx3_data,
> +	}, {
> +		.compatible = "usb3431,6241",	/* Corechips SL6341 USB 2.0 */
Keep the list sorted, 3 goes before 4 .

Thanks !
