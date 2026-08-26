Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A0DC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78ACE4069F;
	Wed, 26 Aug 2026 13:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cu9TLdaqMlwS; Wed, 26 Aug 2026 13:01:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749316;
	bh=JY0JQj0ENhE8E5Fd6o36Fsb96auBFw3hvEaEoLfx7hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=edJ3wwBXKouddz8890o2uc6PcSh5p3eRRwTVIzYDMJsI0SgjsHYQLdQZDzVRg//rQ
	 VF64gMkEoqvorUqnYbCtsROCT6MuO8vhMylGVD1H3oOQ1OUrKwR7CJKhiXYrJ2Enb/
	 2jTwO2+CJJ0dxreQwyNYJt8OW9Ig6lSbb0hUEqBXt/u3hgrn7XFsj9Eb/VwIALdQva
	 qCUVlaKsj3lqBKQOmaoEi0nxeRAnfoCSbNVx7avno4IA6FC611b5tKtCbGU4aZWI8Q
	 4tnvRAdHPlM8hvb64ehGUDQQzEpRVrjCslSylKjhIQgOJ0retVHcDkYa1nmM1QrIbe
	 S81VLA17jQnOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFC32405A3;
	Wed, 26 Aug 2026 13:01:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 837DA23E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 757684017C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uzp6OC2L9LIt for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 07:15:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=T8sNVMql
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 797FA40130
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:15:07 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so991758a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787728505; x=1788333305;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JY0JQj0ENhE8E5Fd6o36Fsb96auBFw3hvEaEoLfx7hc=;
 b=T8sNVMqlwAn07nN1NCmI0+ByfVBoWpgMKlVcfFO5scPIPrRdrR6eU9aThogy1Zdv34
 ozow+p9XbKegAe7ws9CCU9k1I24kXqYm2VhOK4b16N43Q6/wGqovt9vnDVt6cc8IeqCZ
 oBNen3MTf8lavfT4V4DarkRP5q9mBasgKzngELYFeHRKY/VAiFCoeBjRFkrRK/gNubt2
 XeE9rRQ5YWajrYbf61oQZE5BQq4rnXT83fDlLMDK4cBi/naaVQKky3K8r9bu3D75gdjL
 Ij3v/L3oqSRY0SXAd0IcE95dyaq2/VQPj3CfZzcW7YLhPNAIJe6VOSyOmEtgzngeg3NO
 HFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787728505; x=1788333305;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JY0JQj0ENhE8E5Fd6o36Fsb96auBFw3hvEaEoLfx7hc=;
 b=GllBlnK61idWSjH/S2efgEwHlVwRB5Mr+5cfyj66e2bWivpsItZe316jL9H9L/hjEp
 aKGMyIEkm5c9YNHCNiZwpazbfhDnXzliuh4XU+VCZd+196Out8TpSMLPBmExvFeJmGlt
 DKKOei6cHq3QXJ2yeqHwPCDw5FexeCyhLqNP+D8frG1K1g+4csMWcyoBGsBlnZWg2lS7
 GY4ZVvRYELhotv/u8Sipf4POhRnO2NNzVmW9tVCMUKpBTCVdC3LueRvRZ8U9tBK901TM
 6bLeT/j5XrL+SsAyKk4MTg/vt6YC/q0DCEDvKlj29+lg/JuWIsrjWLzH8NfM/XzV73EU
 WKQA==
X-Gm-Message-State: AFuF++niTf6aB79q7n1fSvOCGWC8hVg1OAv9lDp2qPkxaZaVAyR4x0yl
 P0xDyAf7n7H3ML/Nyi1M7vD9u8Zf1NAdo2SLhKuRKw3gmfdvrRIYII/q
X-Gm-Gg: AR+sD12A5qB++j3NW5JHe4Ter3bkzu9dmUDCNrP9KMg84MAARf71ThxYZBeeVbD9Z9G
 67usOVCE6b2dP+KmFLnODiCeSUV1PpdACrJ3vdd1mcUKPsjcWGx2scMsSAwA6QNGxc+13VuIFmJ
 l50/rcIX26sxpfDSSfOMaHYywQnrheJ60qwBbAULdqt7QKTO/U0Q7BNVJZSdSlcp+MCNH9G0jux
 Q75h5DIOlZ3qIpk1bZJrmnN0aJTDzY7NGDHM7HhRHu2QQysg9/wXtOPDMSxgAaEq0jqh4xX3mnW
 SSl17ybDR5jHp07neIG7y0x4ICrDOLLLrQGVj2p84vLmRe3Ys2MqaFS5qWihTPE+6YivdQNSab/
 OSeFWi+FHk4HZb2c0AJI6vaDoI5SwJ3hGWq+sI7Ew1TDqOE7LGaEKvaC2n+4GiNpTwcFqeIdmpx
 GS6A69N2n+qoBLf/ayQebpKaM17Sced0eQNozDwQ==
X-Received: by 2002:a17:907:3e26:b0:c12:83c9:d41 with SMTP id
 a640c23a62f3a-c250c595aaamr508154366b.12.1787728504796; 
 Wed, 26 Aug 2026 00:15:04 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac5csm351619966b.40.2026.08.26.00.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:15:03 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:15:01 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 sjg@chromium.org, ernest.vanhoecke@toradex.com
Subject: Re: [PATCH v1 1/6] usb: dwc3: core: only provide legacy gadget IRQ
 handler when USB_DWC3_GADGET
Message-ID: <ao6SdYSOzJGKtgIa@eichest-laptop>
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-2-eichest@gmail.com>
 <ab7c860e-2f59-4c60-96dc-0c510a63d64c@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7c860e-2f59-4c60-96dc-0c510a63d64c@mailbox.org>
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

On Tue, Aug 25, 2026 at 01:33:27AM +0200, Marek Vasut wrote:
> On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > Building a board with USB_DWC3=y (DWC3 used purely as an XHCI host
> > controller), USB_DWC3_GADGET unset, and DM_USB_GADGET disabled (e.g.
> > to use CONFIG_CI_UDC for a separate ChipIdea gadget/OTG controller)
> > fails to link:
> > 
> > drivers/usb/gadget/ci_udc.o: in function `dm_usb_gadget_handle_interrupts':
> > drivers/usb/gadget/ci_udc.c:983: multiple definition of `dm_usb_gadget_handle_interrupts';
> > drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.c:1034: first defined here
> > drivers/usb/dwc3/core.o: in function `dm_usb_gadget_handle_interrupts':
> > drivers/usb/dwc3/core.c:1044: undefined reference to `dwc3_gadget_uboot_handle_interrupt'
> > 
> > Add "&& CONFIG_IS_ENABLED(USB_DWC3_GADGET)" to the guard so this code
> > is only compiled when the DWC3 gadget driver it depends on is actually
> > present, matching the Makefile dependency. Boards that combine DWC3
> > (host) with a separate legacy gadget driver like CI_UDC, with
> > DM_USB_GADGET disabled, now link correctly. Boards that already use
> > DWC3 in gadget mode without DM_USB_GADGET are unaffected since
> > USB_DWC3_GADGET is set for them.
> > 
> > Fixes: 4d1589808970 ("usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget")
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > ---
> >   drivers/usb/dwc3/core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index be198041f08..9bff5149c5f 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1016,7 +1016,7 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> >   MODULE_LICENSE("GPL v2");
> >   MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
> > -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> > +#if !CONFIG_IS_ENABLED(DM_USB_GADGET) && CONFIG_IS_ENABLED(USB_DWC3_GADGET)
> >   __weak int dwc3_uboot_interrupt_status(struct udevice *dev)
> Simply enable DM_USB_GADGET , then the drivers/usb/gadget/udc/udc-uclass.c
> dm_usb_gadget_handle_interrupts() is used which correctly invokes the
> per-controller IRQ handler. DWC3_GADGET should likely depend on
> DM_USB_GADGET.

Unfortunately, CI_UDC is not a DM driver yet and it depends on
!DM_USB_GADGET that's why I can't enable DM_USB_GADGET in that specific
case. I think NXP is working on changing that driver to DM (at least
they did that in their BSP). So my hope was to have this as intermediate
solution. Also in our case we use the DWC3 controller in host mode only,
so we don't need DWC3_GADGET at all.

Regards,
Stefan
