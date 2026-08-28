Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEF9C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A34940851;
	Fri, 28 Aug 2026 13:15:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o8TazJdVGlse; Fri, 28 Aug 2026 13:15:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787922927;
	bh=MCbWDuoGRN8TtNWkdXeWfAnKcw9N0coQEJvN5agZuE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TuH8UZ9C/7vns5o2/8RtrKWBhDhA28lxV7avl62CrMplsZl/A5li87ologAw7PU/F
	 +U/4hfXXfecYIYtfHeKfvze4qJRE6L8O7c+FwwpWp44LDyeEnkXBcG52TYekwvg+FF
	 e9ooSnyACzzKfkDjZGliGcnsSIrbH1iWWT5k91FUCplRsjLZcrCB71amXbDhdtZ12e
	 xamJNcoWOEkrlF5I4eiqmycDKZbTgTjb5iFjFv0+0NeTZrYTS6MAhIdDvf8KiPTYGd
	 WAhgBaJdQXZOYBsX4y+Q0LCu5KIH9o6MH8iK/kUxNMabi8AKElvw8q5RJtcdC9SamC
	 QkT7sXYHUTvOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92D334084B;
	Fri, 28 Aug 2026 13:15:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 29908386
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 12:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10745401A3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 12:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjprFet7nSR8 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 12:26:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FQkrqRYF
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DED0D400A6
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 12:26:16 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso13197666b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919974; x=1788524774;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MCbWDuoGRN8TtNWkdXeWfAnKcw9N0coQEJvN5agZuE4=;
 b=FQkrqRYFi/bs494dVuvjMzhYbjjU2coHvPLnrcQoS0hRRNWO0aWguWHc2nRFQxT+lw
 V/HxV40HK/qVKJtwIyQUI+gqzdhzy9pDLH/KDcrpONTmy98oMwKcASR9EYvAu4PJ6fNq
 9Lkurw7To4CM8iyb57hXM44HQ+YAR/9+AEZWHBXg4USbY0pvbz3/fAqu5t+u+8BDMwKA
 R0CgtBQqFKyD3Wzk17DlF7r57rdBJZURggYaM7tgZjvC3TsTvbgdPaajs5nAcPtU1G1N
 8PYYIxl8UiKkc/WRshv4B1DW7tj+OygXtyjcqWgO+TDQnG+ERlm6RhhP0jOMFSdDxdB1
 sMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919974; x=1788524774;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MCbWDuoGRN8TtNWkdXeWfAnKcw9N0coQEJvN5agZuE4=;
 b=erjF3opOqT0cPDTH2yRI7daWGc8wwIESiwCz6j6/ehKtDmv+SAcWSa7aRFWR7zSJcf
 evtVVzwpRt2pSmpkf4tFOV2G0XGRZwavhAUlDAZltgu6gNMPW9ih6Eipd5CU7c8yxf0Z
 8JwOjo+j1Wu1jXbyg6jof/zWNtzP76C6NcN4HWEdMnKwRnFdJVsWazsjMs3zIDRHdhe2
 WkNF5uLtfOGLboNOAcQFEjrOIN4MPZzyWVBcz8kWbb0sbu1gSD2L07oBbG5CceZPXN9v
 W2Gs9ycLTy7Sj5LWiRHOPnUvukpPESDRwwQu2GdwkHLt8tfhv8Yw9kBRIr/GzmIkWJ9q
 V0ag==
X-Gm-Message-State: AFuF++lwXSS4d6Ve+9zr4HTFl/AB60bBATtd+qPwFLPB9VUlaXyTIvCM
 Jmi3fXbER/veUmObP8JNK8PsJveOtq9jSb93fKU5uIGw2NS4K8SnERa7UjVLU5xPN14=
X-Gm-Gg: AR+sD11bFJiqgUf7HOaZTTEHlNupGOcV2TrqmbvSGpTm+om9KR7MJwiScwYNN1PT1R2
 qI85uT8jAq2qXd3G5KKVW9Sg5vMMCVkXKAHAoSxYBqwwvM+k0uIt68SSogtUWrVqyqTRZ8HDOym
 FW7o16ErJfNtj3TXZU5YxYmGMpTtGUglNXKa3TsOzf0KKSwLN2UVvOwTb055sv+HPKExiAdOa8h
 RTXLt4BSo/9DeBPALryvE1mmSs4gST76813bc6FvP9hXZEeOGK3I0BasCSR5UV2qL/26igqVJVo
 Kq7YXmGaLiNnI36TE2d7qJKkzzhjG/GUUsmpXK6xySIpOqTQwqqhHIb5GHdzRexAIIDsHlEvxzz
 tZzs2iQknVTAFYMAsWSQQNPbYrqovVpcj1c5TwmPLhUeVcyh72Hy42uPuyipPWILZySBWkwWMHw
 QvSATYtM5SvPtK906nguO9772uf/65UrXdmuKwLRSYVAQ9wYBQYgAXZ3VPwcideic0ZZUPsevfm
 4fT27KOZ7B3St1/YQfRLtM=
X-Received: by 2002:a17:907:9618:b0:c25:3ccf:bd9c with SMTP id
 a640c23a62f3a-c25571c7be7mr231637166b.2.1787919974028; 
 Fri, 28 Aug 2026 05:26:14 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2564e31462sm44345366b.60.2026.08.28.05.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:26:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:26:11 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, sjg@chromium.org,
 Chintan Vankar <c-vankar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v7 00/24] usb: dwc3: part 2, make the resynced code work
Message-ID: <apF-Y29Nk1g0WkUI@monster>
References: <20260824154133.217744-1-anders.roxell@linaro.org>
 <178765097973.1498018.5668901885485543636.b4-review@b4>
 <ao6kAOgauISZ1-dx@monster> <DKZK7EJH891Z.2NDLCYZZ1OXF0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKZK7EJH891Z.2NDLCYZZ1OXF0@ti.com>
X-Mailman-Approved-At: Fri, 28 Aug 2026 13:15:26 +0000
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

On 2026-08-27 13:18, Anshul Dalal wrote:
> On Wed Aug 26, 2026 at 1:59 PM IST, Anders Roxell wrote:
> > On 2026-08-25 15:12, Anshul Dalal wrote:
> >> On Mon, 24 Aug 2026 17:41:09 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> >> > [...]
> >> > dwc2 with and without DM_USB_GADGET, at91_udc, atmel_usba_udc, ci_udc,
> >> > musb-new and mtu3. 17 boards in total.
> >> > 
> >> > DFU is tested on hardware on BeagleBoard-X15, and on BeaglePlay by
> >> > Anshul. ci_udc is tested on an i.MX93 board with ums. The rest is build
> >> > tested only.
> >> 
> >> Hi Anders,
> >> 
> >> Thanks for reworking the series, I was able to get DFU boot to work properly
> >> and the usb devices are being discovered properly too.
> >> 
> >> Though I ran into an issue while using ums with your patches as the host isn't
> >> able to detect the connected device. With default logs I only see a
> >> '\dwc3-generic-peripheral usb@31000000: unknown endpoint event 0'.
> >> 
> >> Further debug logs are below on TI's AM62p EVM:
> >> 
> >> @    => ums mmc 1
> >> @    UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3b72400
> >> @    g_dnl_register: g_dnl_driver.name = usb_dnl_ums
> >> @    g_dnl_bind: gadget: 0x00000000fde7fb68 cdev: 0x00000000fde5cdd0
> >> @    usb_add_config: adding config #1 'usb_dnload'/00000000fde83cc0
> >> @    g_dnl_do_config: configuration: 0x00000000fde83cc0 composite dev: 0x00000000fde5cdd0
> >> @    adding 'Mass Storage Function'/00000000fde5c110 to config 'usb_dnload'/00000000fde83cc0
> >> @    cfg 1/00000000fde83cc0 speeds: high full
> >> @    usb_add_config: interface 0 = Mass Storage Function/00000000fde5c110
> >> @    g_dnl_bind: calling usb_gadget_connect for controller 'dwc3-gadget'
> >> @    usb_dnl_ums: ready
> >> @    -dwc3-generic-peripheral usb@31000000: unknown endpoint event 0
> >> @    |set_config: high speed config #1: usb_dnload
> >> @    \non-core control reqa1.fe v0000 i0000 l1
> >> 
> >> I observed a similar issue on the beagleplay too. Regards!
> >
> > Hi Anshul,
> >
> > I could reproduce it on my BeagleBoard-X15. First I only saw it connect
> > and got happy, so I forgot to look for the disk. It never shows up, and
> > the host gives up after 20 seconds.
> >
> > The resync dropped the cache maintenance in dwc3 gadget.c. The
> > controller reads a stale trb and nothing moves, that is your "unknown
> > endpoint event 0". DFU still worked because it only uses ep0.
> >
> > With the diff below the disk shows up and 64 MiB reads back correctly.
> > It applies on v7.
> >
> > Can you try ums on AM62p and BeaglePlay? Please let me know how it goes
> > before I send the next version.
> 
> Thanks for the fix Anders, the block device shows up properly now.
> However the 'dwc3-generic-peripheral usb@31000000: unknown endpoint
> event 0' error log remains, is this expected?


Good, thanks for testing.

I do not see that message on my X15. In your first log it comes once,
between "ready" and set_config, so it is during enumeration and not on
the transfer path. The event loop is the same as in Linux v6.16.

Do you see it on plain mainline, without my patches? If it is there too
then the resync did not cause it, and it can be fixed on its own. If
mainline is clean then I broke it, and then it has to be fixed in this
series.

If it is new, can you print the raw word and send me what it says?
Event 0 is not a real endpoint event, the defined ones are 1 to 7, so
some word is decoded that should not be.

  --- a/drivers/usb/dwc3/gadget.c
  +++ b/drivers/usb/dwc3/gadget.c
  @@ static void dwc3_process_event_entry(struct dwc3 *dwc,
   		const union dwc3_event *event)
   {
  +	printf("evt raw %08x\n", event->raw);
  +
   	if (!event->type.is_devspec)

Cheers,
Anders
