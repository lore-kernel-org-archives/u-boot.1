Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AB6C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 12:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF571607AB;
	Thu, 27 Aug 2026 12:54:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33F3cFotAg87; Thu, 27 Aug 2026 12:54:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787835285;
	bh=6NJYn+tQRytQirPFSAG1sPfOEYpZFFfOwf/NCR8MIOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NadKAdH/HXqOk+k9QfxQP30UnTKoYk0m/3LcdAW25K82MQH+MbHIpeoIVDoadenI5
	 EoqymZm69lHIAMjWNi29T0TGkgRjtZCxcHVLEBPdtx6CZEnScOiKAHR5Oi8qR3vLzS
	 kjxDc+tIbCRPcmgXhpYieJhhE369hGuiEHlAg/Wx5VLD65RUEqiQC3+OjMRbH2C/nd
	 B29kX8LCSf7W9PKQtdV76k4SkslD1YJQqLVGjKQHxYgRj9F+hZlZzIDWBt0J7NZgpE
	 dVaFV9pKQaqkYY7smxpbIQm+agMzw8q/aExi2EqFgEiYjVC7nUSpzQGH9xFSCGM5dT
	 vVDxZwYOw9+Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CE766078B;
	Thu, 27 Aug 2026 12:54:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 941AC355
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 832E8406BF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:41:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89RxBWC-lO-U for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 08:41:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::836; helo=mail-qt1-x836.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FygkbwWf
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A31EC406BE
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:41:18 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-51c2cce930cso20713471cf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787820078; x=1788424878;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6NJYn+tQRytQirPFSAG1sPfOEYpZFFfOwf/NCR8MIOM=;
 b=FygkbwWfEYqipsnSGT+jgcEgPHqFbdtMxotSed1nNXdAPq8C1QNRblsV1JOFyqPEWl
 DlL3TdkSLHCnFx2bhcHOOIAdeDP1FfX6Mgatx2ucfDt5ICxxJx7EEoBXhEqTWu/LNDnf
 O1zYeOBPnuUJZIxziJnOAbv41SboXHMz0oy0HxlZOM/qE3/jUTVVF95AiQ1si5RBcn0U
 UVmFCOCZbf95ecWsWYYCjOsl9XBeJ3SAeIfJgDyT3J3f0cNx7ovK9v/EM2gzjJT3bB0w
 ta8iwSU1Bw4iaXkFxOXxBrBBigr0bcVSJKwXAOxjbZysEnju6jbxkMvuBNjAmP66LoY4
 jmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820078; x=1788424878;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6NJYn+tQRytQirPFSAG1sPfOEYpZFFfOwf/NCR8MIOM=;
 b=j7FnHedeomwPL77SK4GH1i/g1PJXrfPPDgYKk8k/daxmeyiCYLH9Cs5AGxcoHWL8hc
 dIKyRba6QRuAPdNDW/jdo3JpuJcTJYGxwPZD0JCKQToHZLtS/+fExL2ymz2gOSJW09x8
 ghO0vpovoxfe7OW+fD17JeGP2N+1ktfW5DLpGlOCzMLN7qz20/2q/rHUVsCxTwCF/lov
 cr1JnAIV+TXkidxMq1jUK0SyzOGf5lc2E/62ze0nCeHNU3ilMlevh7Zk8lVHzmdlS8cU
 03r2KzulD7uJpU5NV0kbcnAkWeh9jOc/rn0nOkMBS7C4UvVMqk2kAqVN41VdLOHXyKZf
 Hddw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqitHawF/eY0R/qHPdUYNnDfIHnB586csMG2uACn+A2KrPpVFa308CoqlX+4SztIgXX8bCOgEQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nh3Sums7m+29tuwfo1g5WXUUoSFDNimqlT+cWhtmjzm+UVuAIj
 8xitzDASBKyFCLP39xwtsXjbRCQdDFATyl35rom/UzmyZP0tp9bBfSYO
X-Gm-Gg: AR+sD110V2pdSMz4B7ZFZfJ4xQBaEdwFFr/zh4spdPHpxLa+d8gxrp88c3VVmaZZlbk
 rYvEsXhm1Eyb0QqyVWxjT40maEm1r8iAEB60XnNonyeosxHeBm2OiPSSfZEURnJh0HyPXxglJHQ
 eDfoU53k5n88sIL60PQgfC2mz2npv1x9fHzQ++UbMXvlK5CYyiyaeTHZ6sFPkcXo4a5LXHf2NVx
 M1OsWYRH9IklHcJj56OUUQmjkF8Y0N2eMCl5p+VOt6/FSrLBX9hNSskg71vt5H7JLsM7FW4yLiR
 j4t/56QSHaJ6B9s2aqUTffJcPCsh4dt1Gut22gcL6/cmhKIoKnnfpKfOz/W6ZrkvxiHK0TkyC5G
 5hQ+pGt1VWicVnlRzGLvTMic6nPlkjROlaFnmZJBSKC6c5W8TcOYYSpOwCf18a10LBsK6P0jyM5
 sxcFGe+tGDzqLsMq1Hl6GgQFyTCB7eiwrwVqpIifHZGSwEPKaW
X-Received: by 2002:a05:622a:164c:b0:516:ed02:c85d with SMTP id
 d75a77b69052e-52e4228dbc1mr130833221cf.3.1787820077608; 
 Thu, 27 Aug 2026 01:41:17 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499fa55f4f3sm43068395e9.0.2026.08.27.01.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 01:41:16 -0700 (PDT)
Date: Thu, 27 Aug 2026 10:41:14 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, ilias.apalodimas@linaro.org,
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
Message-ID: <ao_4Ks4CZBoUTsBf@eichest-laptop>
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-2-eichest@gmail.com>
 <ab7c860e-2f59-4c60-96dc-0c510a63d64c@mailbox.org>
 <ao6SdYSOzJGKtgIa@eichest-laptop>
 <20260826161102.GO523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826161102.GO523975@bill-the-cat>
X-Mailman-Approved-At: Thu, 27 Aug 2026 12:54:43 +0000
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

On Wed, Aug 26, 2026 at 10:11:02AM -0600, Tom Rini wrote:
> On Wed, Aug 26, 2026 at 09:15:01AM +0200, Stefan Eichenberger wrote:
> > On Tue, Aug 25, 2026 at 01:33:27AM +0200, Marek Vasut wrote:
> > > On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > 
> > > > Building a board with USB_DWC3=y (DWC3 used purely as an XHCI host
> > > > controller), USB_DWC3_GADGET unset, and DM_USB_GADGET disabled (e.g.
> > > > to use CONFIG_CI_UDC for a separate ChipIdea gadget/OTG controller)
> > > > fails to link:
> > > > 
> > > > drivers/usb/gadget/ci_udc.o: in function `dm_usb_gadget_handle_interrupts':
> > > > drivers/usb/gadget/ci_udc.c:983: multiple definition of `dm_usb_gadget_handle_interrupts';
> > > > drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.c:1034: first defined here
> > > > drivers/usb/dwc3/core.o: in function `dm_usb_gadget_handle_interrupts':
> > > > drivers/usb/dwc3/core.c:1044: undefined reference to `dwc3_gadget_uboot_handle_interrupt'
> > > > 
> > > > Add "&& CONFIG_IS_ENABLED(USB_DWC3_GADGET)" to the guard so this code
> > > > is only compiled when the DWC3 gadget driver it depends on is actually
> > > > present, matching the Makefile dependency. Boards that combine DWC3
> > > > (host) with a separate legacy gadget driver like CI_UDC, with
> > > > DM_USB_GADGET disabled, now link correctly. Boards that already use
> > > > DWC3 in gadget mode without DM_USB_GADGET are unaffected since
> > > > USB_DWC3_GADGET is set for them.
> > > > 
> > > > Fixes: 4d1589808970 ("usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget")
> > > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > ---
> > > >   drivers/usb/dwc3/core.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index be198041f08..9bff5149c5f 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -1016,7 +1016,7 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
> > > >   MODULE_LICENSE("GPL v2");
> > > >   MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
> > > > -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
> > > > +#if !CONFIG_IS_ENABLED(DM_USB_GADGET) && CONFIG_IS_ENABLED(USB_DWC3_GADGET)
> > > >   __weak int dwc3_uboot_interrupt_status(struct udevice *dev)
> > > Simply enable DM_USB_GADGET , then the drivers/usb/gadget/udc/udc-uclass.c
> > > dm_usb_gadget_handle_interrupts() is used which correctly invokes the
> > > per-controller IRQ handler. DWC3_GADGET should likely depend on
> > > DM_USB_GADGET.
> > 
> > Unfortunately, CI_UDC is not a DM driver yet and it depends on
> > !DM_USB_GADGET that's why I can't enable DM_USB_GADGET in that specific
> > case. I think NXP is working on changing that driver to DM (at least
> > they did that in their BSP). So my hope was to have this as intermediate
> > solution. Also in our case we use the DWC3 controller in host mode only,
> > so we don't need DWC3_GADGET at all.
> 
> So the NXP downstream tree has a DM_USB_GADGET driver that needs to be
> upstreamed, to solve this? We're quite a ways past where enhancing the
> non-DM side things is the normal workflow.

Okay, so we can only make this work if we first convert the UI_UDC
driver to a DM driver. Thanks for the input, I will see what we can do
about that.

Regards,
Stefan
