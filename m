Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAD3C531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 12:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B45F76068D;
	Thu, 23 Jul 2026 12:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fcgRqAbayO0v; Thu, 23 Jul 2026 12:29:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D022E606A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784809751;
	bh=E/xrfGSRy+KHZwVh+fl+kdVcuQSuLSxfzDxI7HD43ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SQVW3S5rsMedwt0BWqwwW4VJm/TEV29wEl31Ga8k882bf3tdmeYPdec/M1hYgLKEm
	 bkxeYTl7oKjUeH+Fn0PEjuyVnZA8NRQV/XG2Qu3dJWpSqMcFdBn3GGG8rbDqW8k8mU
	 mON+mqVonrcuhEF4t8SxzD81M6O11ij2ZlVfxYteL77aij3kn09m1Qo/cB07iD06zk
	 3zAEV4hWWmvltdsJm6i1BnVJP6iKIlNJkHsXrELLZeaCpIfm0wy0PkT/fre0b415he
	 AlTPln3gq1984AUt7rselYSPgaoAd9qy8lZOER8r7wFQehufTCFOeNRW4nVlKvMNxZ
	 77Z/4zkbzyrjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D022E606A6;
	Thu, 23 Jul 2026 12:29:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D23C3B1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 132B68102F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LyHx2fn-ruTR for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 12:29:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 445A58100D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 445A58100D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 445A58100D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 12:29:08 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F53B803F6; Thu, 23 Jul 2026 14:29:06 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90EB80117
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:29:03 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E88B600AD;
 Thu, 23 Jul 2026 12:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694391F000E9;
 Thu, 23 Jul 2026 12:29:01 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Dan Tran <Dan.Tran1@synopsys.com>, Marek
 Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
In-Reply-To: <3f9ff728be6806066dd5d5e69d4e177666b46252.1783620779.git.Thinh.Nguyen@synopsys.com>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
 <3f9ff728be6806066dd5d5e69d4e177666b46252.1783620779.git.Thinh.Nguyen@synopsys.com>
Date: Thu, 23 Jul 2026 14:28:35 +0200
Message-ID: <87h5lp99fw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784809742;
 bh=E/xrfGSRy+KHZwVh+fl+kdVcuQSuLSxfzDxI7HD43ag=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=b9VUkGQ08oWtGvzCWTcOfIvoi4PEVV+lgw73RUjLUkLaIsR8dk/mb5qYB3OPXV0Ta
 BGJZwdEtVAaEQVjv9OqLVgD7yja0rx7BhoozKTuv4oDgQ1FGBa8Jd1fjkZ+SR0w2HZ
 5KPXrbY4pYl0PpvN1Va9S/kJruHw+Edfw2gM+8vD+Sl+v4MUvbfQvbTIAZCdHLpDxW
 l7w7NVHEJdIy8E6lkjZRu3X2n2FKiHEpMMbE6mWW/TKi04E21nMjs6CjiGXogc8MqD
 htDFyu5xYaAMQ6rQwpPydtu0MOQKp2gUoukNtJu1zs9oIf6WHMiMUYGI/36PpYTG3b
 npjwB4+JTAl8Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=b9VUkGQ0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9VUkGQ0"; 
 dkim-atps=neutral
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

Hi Thinh,

Thank you for the patch.

On Thu, Jul 09, 2026 at 18:19, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> From: Dan Tran <trandan@synopsys.com>
>
> Add SS bulk endpoint descriptors (1024-byte MPS, bMaxBurst=15) to
> storage_common.c to support SuperSpeed connections. Extend fsg_ep_desc()
> to select them when operating at SuperSpeed, and wire up ss_descriptors
> in fsg_bind(). Free ss_descriptors in fsg_unbind() to match.
>
> Signed-off-by: Dan Tran <trandan@synopsys.com>
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> ---
>  Changes in v2:
>  - Removed internal Reviewed-by tags
>
>
>  drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
>  drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index 87ed25e8bb3a..a2f34c100482 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -2225,14 +2225,16 @@ reset:
>  
>  	/* Enable the endpoints */
>  	d = fsg_ep_desc(common->gadget,
> -			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc);
> +			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc,
> +			&fsg_ss_bulk_in_desc);
>  	rc = enable_endpoint(common, fsg->bulk_in, d);
>  	if (rc)
>  		goto reset;
>  	fsg->bulk_in_enabled = 1;
>  
>  	d = fsg_ep_desc(common->gadget,
> -			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc);
> +			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc,
> +			&fsg_ss_bulk_out_desc);
>  	rc = enable_endpoint(common, fsg->bulk_out, d);
>  	if (rc)
>  		goto reset;
> @@ -2653,6 +2655,7 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
>  	fsg_common_release(fsg->common);
>  	free(fsg->function.descriptors);
>  	free(fsg->function.hs_descriptors);
> +	free(fsg->function.ss_descriptors);
>  	kfree(fsg);
>  }
>  
> @@ -2701,6 +2704,24 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>  			return -ENOMEM;
>  		}
>  	}
> +
> +	if (gadget_is_superspeed(gadget)) {
> +		unsigned int max_burst = min_t(unsigned int, FSG_BUFLEN / 1024, 15);

I can see that this looks similar to what we have in Linux with
commit 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")

However, the Linux patch added a comment as well:

+               /* Calculate bMaxBurst, we know packet size is 1024 */
+               max_burst = min_t(unsigned, FSG_BUFLEN / 1024, 15);

Why can't we do the same here?

> +
> +		fsg_ss_bulk_in_desc.bEndpointAddress =
> +			fsg_fs_bulk_in_desc.bEndpointAddress;
> +		fsg_ss_bulk_in_comp_desc.bMaxBurst = max_burst;
> +		fsg_ss_bulk_out_desc.bEndpointAddress =
> +			fsg_fs_bulk_out_desc.bEndpointAddress;
> +		fsg_ss_bulk_out_comp_desc.bMaxBurst = max_burst;
> +		f->ss_descriptors = usb_copy_descriptors(fsg_ss_function);
> +		if (unlikely(!f->ss_descriptors)) {
> +			free(f->hs_descriptors);
> +			free(f->descriptors);
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	return 0;
>  
>  autoconf_fail:
> diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c
> index 7e4b542f7ce5..d745649eadb7 100644
> --- a/drivers/usb/gadget/storage_common.c
> +++ b/drivers/usb/gadget/storage_common.c
> @@ -531,11 +531,61 @@ static struct usb_descriptor_header *fsg_hs_function[] = {
>  	NULL,
>  };
>  
> +/*
> + * USB 3.0 requires SuperSpeed descriptors
> + */
> +static struct usb_endpoint_descriptor
> +fsg_ss_bulk_in_desc = {
> +	.bLength =		USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType =	USB_DT_ENDPOINT,
> +
> +	/* bEndpointAddress copied from fs_bulk_in_desc during fsg_bind() */
> +	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize =	cpu_to_le16(1024),
> +};
> +
> +static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_in_comp_desc = {
> +	.bLength =		sizeof(fsg_ss_bulk_in_comp_desc),
> +	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
> +	/* bMaxBurst set during fsg_bind() */
> +};
> +
> +static struct usb_endpoint_descriptor
> +fsg_ss_bulk_out_desc = {
> +	.bLength =		USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType =	USB_DT_ENDPOINT,
> +
> +	/* bEndpointAddress copied from fs_bulk_out_desc during fsg_bind() */
> +	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
> +	.wMaxPacketSize =	cpu_to_le16(1024),
> +};
> +
> +static struct usb_ss_ep_comp_descriptor fsg_ss_bulk_out_comp_desc = {
> +	.bLength =		sizeof(fsg_ss_bulk_out_comp_desc),
> +	.bDescriptorType =	USB_DT_SS_ENDPOINT_COMP,
> +	/* bMaxBurst set during fsg_bind() */
> +};
> +
> +static struct usb_descriptor_header *fsg_ss_function[] = {
> +#ifndef FSG_NO_OTG
> +	(struct usb_descriptor_header *)&fsg_otg_desc,
> +#endif
> +	(struct usb_descriptor_header *)&fsg_intf_desc,
> +	(struct usb_descriptor_header *)&fsg_ss_bulk_in_desc,
> +	(struct usb_descriptor_header *)&fsg_ss_bulk_in_comp_desc,
> +	(struct usb_descriptor_header *)&fsg_ss_bulk_out_desc,
> +	(struct usb_descriptor_header *)&fsg_ss_bulk_out_comp_desc,
> +	NULL,
> +};
> +
>  /* Maxpacket and other transfer characteristics vary by speed. */
>  static struct usb_endpoint_descriptor *
>  fsg_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
> -		struct usb_endpoint_descriptor *hs)
> +		struct usb_endpoint_descriptor *hs,
> +		struct usb_endpoint_descriptor *ss)
>  {
> +	if (g->speed >= USB_SPEED_SUPER)
> +		return ss;

I can see that this looks similar to what we have in Linux with
commit 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")

However, Linux uses the following diff instead:
+       if (gadget_is_superspeed(g) && g->speed == USB_SPEED_SUPER)
+               return ss;

Is there a reason for not doing the same here?

>  	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
>  		return hs;
>  	return fs;
> -- 
> 2.53.0
