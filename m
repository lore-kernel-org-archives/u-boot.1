Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8E3C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD62B87C05;
	Tue, 30 Jan 2024 13:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dViDE2Vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A77D87C2F; Tue, 30 Jan 2024 13:29:31 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEB986FCE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UCTRQ4069603;
 Tue, 30 Jan 2024 06:29:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706617767;
 bh=uL0plh0BLI1cn396oRLU2xy+KhvOjyn211tkYV4E3oA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dViDE2VlKKLun3pu2CRwE4hDMVGfZsiup4fs2x+tOYyDp0lNI6duyKikVx21gEIHY
 RhVgnUxM4TLqbstKY/3PZqjf5FXsiJxvI9SbHqpfBZeIpIDwrVRs9wON3rh7dfMARU
 AtFr4K9a/gKKPmgsBCxp+FbsnH0x1CJhCZjS3T3E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UCTRY1093364
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 06:29:27 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 06:29:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 06:29:26 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UCTQc9073619;
 Tue, 30 Jan 2024 06:29:26 -0600
Date: Tue, 30 Jan 2024 06:29:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH V4 1/2] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240130122926.mwtho3l36xphqrql@unmindful>
References: <20240130115847.860345-1-d-gole@ti.com>
 <20240130115847.860345-2-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130115847.860345-2-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 17:28-20240130, Dhruva Gole wrote:
> The ti_sci driver in U-Boot has support for secure_msg as part of it's
> do_xfer function. This let's U-boot send secure messages during boot up.
> 
> The protocol to send such secure messages is described as part of the
> struct ti_sci_secure_msg_hdr. As part of this, there are 2 fields for
> checksum and reserved that occupy the first 4 bytes of any secure
> message. This is called as the secure_hdr.
> 
> As of now, the secure_hdr needs to be 0 init-ed before sending secure
> messages. However the existing code was never putting the zero-inited vars
> into the secure_buf, leading to possibility of the first 4 bytes of
> secure_buf being possibly garbage.
> 
> Fix this by initialising the secure_hdr itself to the secure_buf
> location, thus when we make secure_hdr members 0, it automatically ensures
> the first 4 bytes of secure_buf are 0.
> 
> Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Andrew Davis <afd@ti.com>
> Cc: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 6e9f93e9a302..49d2696a6d09 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -236,21 +236,21 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
>  {
>  	struct k3_sec_proxy_msg *msg = &xfer->tx_message;
>  	u8 secure_buf[info->desc->max_msg_size];
> -	struct ti_sci_secure_msg_hdr secure_hdr;
> +	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
>  	int ret;
>  
>  	if (info->is_secure) {
>  		/* ToDo: get checksum of the entire message */
> -		secure_hdr.checksum = 0;
> -		secure_hdr.reserved = 0;

I was thinking originally just adding memcpy(secure_buf, secure_hdr,
sizeof(secure_hdr)) would save all the churn.. but anyways.. we save
allocating secure_hdr struct.. not a big saving, but better code
anyways..

> -		memcpy(&secure_buf[sizeof(secure_hdr)], xfer->tx_message.buf,
> +		secure_hdr->checksum = 0;
> +		secure_hdr->reserved = 0;
> +		memcpy(&secure_buf[sizeof(struct ti_sci_secure_msg_hdr)], xfer->tx_message.buf,
>  		       xfer->tx_message.len);

here and below:

s/sizeof(var)/sizeof(*var) instead of sizeof(struct ... ) is probably
all the change we need? rather than converting it to sizeof(struct ..)?
same below. this would allow (theoretically), that the structure
name to change for secure_hdr and there would be less churn? not that it
matters here.. just a style thing..

Either way:

Reviewed-by: Nishanth Menon <nm@ti.com>

>  
>  		xfer->tx_message.buf = (u32 *)secure_buf;
> -		xfer->tx_message.len += sizeof(secure_hdr);
> +		xfer->tx_message.len += sizeof(struct ti_sci_secure_msg_hdr);
>  
>  		if (xfer->rx_len)
> -			xfer->rx_len += sizeof(secure_hdr);
> +			xfer->rx_len += sizeof(struct ti_sci_secure_msg_hdr);
>  	}
>  
>  	/* Send the message */
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
