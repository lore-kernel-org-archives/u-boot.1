Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF9EC61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D68D6067F;
	Wed, 26 Aug 2026 13:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y3huxY0BGeqJ; Wed, 26 Aug 2026 13:01:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749319;
	bh=74k3oV2qTeE+3n1dxeAwpW8bcu0W1SDl8x5Kk/fn+qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJy8n8N9jwQTknGbndsGp3FCGo1ktNmGeBqHHxD+dpWohnBvSoVcpFGaqeuqjEtw6
	 V5AvVWkKdHe5OHD3QsQ3hb2KhMjru4grxXLYAmxptR7fy+awwKjrG39RmMaIXsuP2r
	 Jic45uPpIl15cFQbqnq7FEiFzEdsYOBM7JRZcjZDrbm+lpgCALds+CLQj7UFCOuMM+
	 nE4osUtV3AMsIjG8lyw8WliQJIOTEc4APlNR5B3JJFRI8GJvLSbKVCIwmcPATIZh3E
	 kvoLVPKwJyHFxUhlErAijYveDcbHdiFiLdaN3Ct/EpNxbBC+B5ib9dacINuduxA72z
	 b1JThk5b7kPaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86CCA605EE;
	Wed, 26 Aug 2026 13:01:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EC4C3C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 514FD4017C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CKbVTIb8Yt8x for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 07:18:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=edPGdhng
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 533FF40130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:18:10 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6a5e971c970so372832a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787728689; x=1788333489;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=74k3oV2qTeE+3n1dxeAwpW8bcu0W1SDl8x5Kk/fn+qU=;
 b=edPGdhng2fojbZH2ykgIhDpGn6qDu3zYpXLPsrXkf+3PKu2fuojGCTVap3y8mXvy+Y
 fIelmpRf7b832NlB4CPCHi+Pr/3M/UMABXX17ZOy7B96GXLGmJW6lbVMTRVHDoLWvrL+
 H+UeZ4S9zgisBNgKh2UYp3hb/EjF3tNnedjkh9wTSZAZXagt1ll9tPfUK/6kCxtm0gXk
 4NyhJZrftpnvetn65m5bv/BNcleovBaWhQIX5Ne03NmBwh1/NwKiA6rNIf8JML/eghiA
 4xOqDseyT3XZJj6TzLT443fi+2GNEo9+5a11j/AvoiL/Xjs6AF2NpR/94HoW8EMUagw2
 PWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787728689; x=1788333489;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=74k3oV2qTeE+3n1dxeAwpW8bcu0W1SDl8x5Kk/fn+qU=;
 b=BUKrrDknJPn8PCZCXg8Kv1S+8JkqHO+kxbyX46+53SI0PxvG+9/lOpnfTaoT1dNZu7
 nh42BmEbY64ip+D7ttIzMWALQplLMEVi+XE7YCV6lgP8AGmejSvF0/R7iWDVOkstQCMx
 n7k+XZElIiwWyqCe8yN6oqfVfYbRW0IHoxRC78EMDtNchL7Ae39uoNiSAE79lvP1vIR9
 o4iqFjeRlm5bpxPMcTOqGrU82dEHoy+ytwk6v5h7APcICaBW6Dn3xBwNF0x1+AMAjwQ2
 eWpFeZ5K/oteZyvalU4tEFAyraOfDb7DOppsGyPB9hP+GTGf23LmjyaszXgKcRWGfip3
 3tSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrivkqJDB8eMcZigQE5DA76ouGg6BnvETjLchX+2pHP2jmz9VNEflINKmcYF8xuyrEMdhM0mts=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++khauV9vQGf8Qe3B3LDb/NZsCUCtZjUFqczjGpfnWQ2YTKMY9Pr
 wNqedUJY+Yx1Dq+Tdl8CQVV3olXwRv7XWpFTzQSzlckAyQYEFnrd8b7t
X-Gm-Gg: AR+sD113Av9+9W/dGHxH5/6VY4AI9zFvB6/0STdFxGoALyRkfYz60t1Qi37uz2GraG0
 yoOpLR+WpRpgpnruTd1hT42kdMbQh3Prcqdf87T/3OCRuRsNPANReD6qPp5/ZPiPqH+1MqGcYEz
 178Iqib2KJb8QQeleCUo4PtrzHsvCHiAnGr7nwND9mOKlvcYUpPsYYqNIKIAuWTGFJRT2qLsN6K
 z4CMR4bTKIIBuZzVdNbBwEcZjJ2be4oExNpxgBwsTC3tkqeJRIPFZQiTaRf3NiAdaofKvUFujk7
 qWXPMKvJmBHdEYhLP3mHlFBRhHsNnn1K21JfehheJnid/3fZ2TqvyUDbuoH4dxFIYbkaWfVyxVU
 /1GPn2IV0Z6KiYx8gxV//LGc4wLU8I6owekGWA1zPQ3RO4zp28ajqJkXFw7+CihnZ9FTLHfKRoJ
 6+YmUYzLsOU1dGak8XzG1AbZtRVoeljRYfVBfJ+OUthH4hyc4/
X-Received: by 2002:a17:907:60d0:b0:c21:4698:ee9e with SMTP id
 a640c23a62f3a-c250acaa61bmr581509266b.7.1787728688621; 
 Wed, 26 Aug 2026 00:18:08 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a7303casm454741166b.25.2026.08.26.00.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:18:07 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:06 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 alice.guo@nxp.com, antoine.gouby@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 sjg@chromium.org, ernest.vanhoecke@toradex.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 2/6] usb: dwc3-generic: fix ref clock lookup indexing
 wrong clk_bulk array
Message-ID: <ao6TLnwbzqc-TcFp@eichest-laptop>
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-3-eichest@gmail.com>
 <e8ad2e6c-1852-4ae3-bb4d-6b76b9a0aee2@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ad2e6c-1852-4ae3-bb4d-6b76b9a0aee2@mailbox.org>
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:01:55 +0000
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

On Tue, Aug 25, 2026 at 01:40:44AM +0200, Marek Vasut wrote:
> On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
> > port the hub itself enumerates fine but a USB stick plugged into it
> > fails intermittently:
> > 
> >    Verdin iMX95 # usb start
> >    starting USB...
> >    USB XHCI 1.10
> >    Device not responding to set address.
> > 
> >          USB device not accepting new address (error=80000000)
> >    Bus usb@4c100000: 2 USB Device(s) found
> >           scanning usb for storage devices... 0 Storage Device(s) found
> >    Verdin iMX95 # usb reset
> >    resetting USB...
> >    USB XHCI 1.10
> >    WARN endpoint is halted
> >    WARN endpoint is halted
> >    unable to get device descriptor (error=-22)
> > 
> > Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
> > both controller DT nodes") added a fallback that searches the DWC3
> > child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
> > the parent glue node, but always resolves the found index against
> > glue->clks, a clk_bulk populated only from the parent glue node's own
> > clock-names list. This is wrong since the child node's clock-names list
> > is not guaranteed to be in the same order as the parent's, and indeed on
> > Verdin iMX95 the child node has a different order than the parent node.
> > 
> > Fix it by resolving the index against the child node's clk and ensure to
> > enable the clock before using it.
> > 
> > Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >   drivers/usb/dwc3/dwc3-generic.c | 24 ++++++++++++++++++++++--
> >   1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> > index 2356b3bc0aa..e16d236bd9d 100644
> > --- a/drivers/usb/dwc3/dwc3-generic.c
> > +++ b/drivers/usb/dwc3/dwc3-generic.c
> > @@ -31,6 +31,7 @@ struct dwc3_generic_priv {
> >   	struct dwc3 dwc3;
> >   	struct phy_bulk phys;
> >   	struct gpio_desc *ulpi_reset;
> > +	struct clk ref_clk;
> >   };
> >   struct dwc3_generic_host_priv {
> > @@ -76,9 +77,28 @@ static int dwc3_generic_probe(struct udevice *dev,
> >   		index = ofnode_stringlist_search(node, "clock-names", "ref");
> >   		if (index < 0)
> >   			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
> > -	}
> > -	if (index >= 0)
> > +		/*
> > +		 * glue->clks was populated from the parent glue node's own
> > +		 * clock-names list, which can differ in length/order from
> > +		 * this child node's list (e.g. i.MX95: glue has "hsio",
> > +		 * "suspend", the dwc3 child has "bus_early", "ref",
> > +		 * "suspend"). Reusing this index against glue->clks would
> > +		 * silently resolve to the wrong clock, so fetch it directly
> > +		 * from this node instead.
> > +		 */
> > +		if (index >= 0) {
> > +			if (!clk_get_by_index(dev, index, &priv->ref_clk)) {
> 
> Would it be possible to call clk_get_by_name(dev, ...) and
> clk_get_by_name(dev->parent, ...) instead, until one of them succeeds ? That
> could make the code simpler.
> 

You are right, I try to rework that in the next version. Thanks for the
suggestion. I will also remove/replace the debug() calls.

Regards,
Stefan

