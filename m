Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA06C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5CFD40B0B;
	Fri, 24 Jul 2026 12:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtmOmAqfwuUQ; Fri, 24 Jul 2026 12:25:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0147B40AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784895925;
	bh=XvAVIcMOOELdxxKWBbQSf+quBl0+tvjpS4grBtDyW48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P/MAmt/SQ8LYVimqm4L3hMCvfcnBHzg7PnKcm8SEebH/dKxrWnFxwTTsd6EwaImHh
	 be4iRrSreHpV1udzwRPPCSgl1U9Vj/OQnvLf4usm0Agg7t/QjtEHZ+Ce/lycRDIoDt
	 YhQUWy155WqP1az7Jk1nSPj+3GSMF3nHNdAuElyeneB5xU/OeH95e9xnjGm43blYF0
	 PYEx2YXLQoTeLuViXQniPYpP8xwNaCms/EymcDXwB3DK8aDS0oKQuCpuRjJHfc+HLc
	 MWMy9WHR45eYggHst+yelPajy/l4vMjlLwhnhT6HFWwkLKAw2HrVpCV7B+aNTsTbKR
	 UIEnekceB4CeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0147B40AC1;
	Fri, 24 Jul 2026 12:25:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DF90350
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 039618117E
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gsiyy4hIGMW for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:25:23 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B0C1A8117C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0C1A8117C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0C1A8117C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:25:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4597A83E76; Fri, 24 Jul 2026 14:25:20 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E10C800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:25:17 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 19EE643BB1;
 Fri, 24 Jul 2026 12:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E20A1F000E9;
 Fri, 24 Jul 2026 12:25:14 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>, Lukasz
 Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tejas Narendra Joglekar
 <Tejas.Joglekar@synopsys.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/2] usb: gadget: mass_storage: add SuperSpeed
 descriptor support
In-Reply-To: <amJwynjvYTMyL5dA@vbox>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
 <3f9ff728be6806066dd5d5e69d4e177666b46252.1783620779.git.Thinh.Nguyen@synopsys.com>
 <87h5lp99fw.fsf@kernel.org> <amJwynjvYTMyL5dA@vbox>
Date: Fri, 24 Jul 2026 14:25:11 +0200
Message-ID: <87zezg7exk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784895915;
 bh=XvAVIcMOOELdxxKWBbQSf+quBl0+tvjpS4grBtDyW48=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=aIn29NyTIS9s0z1IOLUFq/p+1Ni1Jfr9T97KKiwvdcnJZG1eUZhyKw2KpcSPtyrvo
 Hf6x5mbeZORYfD4QMcUI4SHvbKB8c5pPmcAc4Rx9bmjxdEJ6ga2Pq3TgGK8Id9SFP7
 O2+0EVhMCIJNufCxNeFFa2hS8C4iFT8N+MTERa3bZsxrvAjAJ3kmTyL/s98f4nKaB0
 flsXQqa7vBTA2ZODT8c18BCuZolz4FE0zG3RdfeCRgMlTpdJhpRlcetG5bviSL/kFg
 gNYhtkuE26FdGJ3FbXkcM9qF8jgz8Rt5w8HonqZNGDfBiKUV6vKx+5EXfljZoytj2T
 ZHl5qN6WCc2hA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aIn29NyT
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="aIn29NyT"; 
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

On Thu, Jul 23, 2026 at 20:40, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> Hi Mattijs,
>
> On Thu, Jul 23, 2026, Mattijs Korpershoek wrote:
>> Hi Thinh,
>> 
>> Thank you for the patch.
>> 
>> On Thu, Jul 09, 2026 at 18:19, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>> 
>> > From: Dan Tran <trandan@synopsys.com>
>> >
>> > Add SS bulk endpoint descriptors (1024-byte MPS, bMaxBurst=15) to
>> > storage_common.c to support SuperSpeed connections. Extend fsg_ep_desc()
>> > to select them when operating at SuperSpeed, and wire up ss_descriptors
>> > in fsg_bind(). Free ss_descriptors in fsg_unbind() to match.
>> >
>> > Signed-off-by: Dan Tran <trandan@synopsys.com>
>> > Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> > ---
>> >  Changes in v2:
>> >  - Removed internal Reviewed-by tags
>> >
>> >
>> >  drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
>> >  drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
>> >  2 files changed, 74 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>> > index 87ed25e8bb3a..a2f34c100482 100644
>> > --- a/drivers/usb/gadget/f_mass_storage.c
>> > +++ b/drivers/usb/gadget/f_mass_storage.c
>> > @@ -2225,14 +2225,16 @@ reset:
>> >  
>> >  	/* Enable the endpoints */
>> >  	d = fsg_ep_desc(common->gadget,
>> > -			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc);
>> > +			&fsg_fs_bulk_in_desc, &fsg_hs_bulk_in_desc,
>> > +			&fsg_ss_bulk_in_desc);
>> >  	rc = enable_endpoint(common, fsg->bulk_in, d);
>> >  	if (rc)
>> >  		goto reset;
>> >  	fsg->bulk_in_enabled = 1;
>> >  
>> >  	d = fsg_ep_desc(common->gadget,
>> > -			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc);
>> > +			&fsg_fs_bulk_out_desc, &fsg_hs_bulk_out_desc,
>> > +			&fsg_ss_bulk_out_desc);
>> >  	rc = enable_endpoint(common, fsg->bulk_out, d);
>> >  	if (rc)
>> >  		goto reset;
>> > @@ -2653,6 +2655,7 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
>> >  	fsg_common_release(fsg->common);
>> >  	free(fsg->function.descriptors);
>> >  	free(fsg->function.hs_descriptors);
>> > +	free(fsg->function.ss_descriptors);
>> >  	kfree(fsg);
>> >  }
>> >  
>> > @@ -2701,6 +2704,24 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>> >  			return -ENOMEM;
>> >  		}
>> >  	}
>> > +
>> > +	if (gadget_is_superspeed(gadget)) {
>> > +		unsigned int max_burst = min_t(unsigned int, FSG_BUFLEN / 1024, 15);
>> 
>> I can see that this looks similar to what we have in Linux with
>> commit 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")
>> 
>> However, the Linux patch added a comment as well:
>> 
>> +               /* Calculate bMaxBurst, we know packet size is 1024 */
>> +               max_burst = min_t(unsigned, FSG_BUFLEN / 1024, 15);
>> 
>> Why can't we do the same here?
>
> The comment doesn't add much beyond what the code already expresses. The
> variable name max_burst and the division by 1024 make the intent clear.
>
> That said, the Linux comment also has a minor inaccuracy: it says
> "packet size" when it should say "max packet size". If a comment is
> warranted, I'd prefer to add a corrected one. We can add it if you
> really think it helps with readability.

Overall, my rule of thumb is "keep the code as close as possible to the
Linux driver to ease maintenance in U-Boot".

Please consider adding the corrected comment for v3.

>
>> 
>> > +
>> > +		fsg_ss_bulk_in_desc.bEndpointAddress =
>> > +			fsg_fs_bulk_in_desc.bEndpointAddress;
>> > +		fsg_ss_bulk_in_comp_desc.bMaxBurst = max_burst;
>> > +		fsg_ss_bulk_out_desc.bEndpointAddress =
>> > +			fsg_fs_bulk_out_desc.bEndpointAddress;
>> > +		fsg_ss_bulk_out_comp_desc.bMaxBurst = max_burst;
>> > +		f->ss_descriptors = usb_copy_descriptors(fsg_ss_function);
>> > +		if (unlikely(!f->ss_descriptors)) {
>> > +			free(f->hs_descriptors);
>> > +			free(f->descriptors);
>> > +			return -ENOMEM;
>> > +		}
>> > +	}
>> > +
>> >  	return 0;
>> >  
>> >  autoconf_fail:
>> > diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c

[...]

>> > +	(struct usb_descriptor_header *)&fsg_ss_bulk_out_comp_desc,
>> > +	NULL,
>> > +};
>> > +
>> >  /* Maxpacket and other transfer characteristics vary by speed. */
>> >  static struct usb_endpoint_descriptor *
>> >  fsg_ep_desc(struct usb_gadget *g, struct usb_endpoint_descriptor *fs,
>> > -		struct usb_endpoint_descriptor *hs)
>> > +		struct usb_endpoint_descriptor *hs,
>> > +		struct usb_endpoint_descriptor *ss)
>> >  {
>> > +	if (g->speed >= USB_SPEED_SUPER)
>> > +		return ss;
>> 
>> I can see that this looks similar to what we have in Linux with
>> commit 4bb99b7c82ba ("usb: gadget: storage: add superspeed support")
>> 
>> However, Linux uses the following diff instead:
>> +       if (gadget_is_superspeed(g) && g->speed == USB_SPEED_SUPER)
>> +               return ss;
>> 
>> Is there a reason for not doing the same here?
>
> The gadget_is_superspeed() is a hardware capability check. It's
> redundant when we're already checking g->speed for connected speed.

So does that mean that the dualspeed conditional just below is doing a
redundant check as well?

As for the previous comment, I'd prefer if we can stay closer to the
Linux code.

If we can't, I'd like to see a strong justification for not doing so.

>
> BR,
> Thinh
>
>> 
>> >  	if (gadget_is_dualspeed(g) && g->speed == USB_SPEED_HIGH)
>> >  		return hs;
>> >  	return fs;
>> > -- 
>> > 2.53.0
