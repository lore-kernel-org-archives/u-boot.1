Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77B2C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D41584AF2;
	Thu,  9 Jul 2026 11:22:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zk6FAoQ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0476484AE7; Thu,  9 Jul 2026 11:22:20 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FAA84AE7
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6679d88abdcso2405205d50.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 02:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783588935; cv=none;
 d=google.com; s=arc-20260327;
 b=aHN83N8sH/qLJfR1dgK238dsJrcvGfpQlg59pVjw20+/NO3zCnlZ/dVkoIS6vk1IVW
 XTwIliQNvE23/RZOWlba/IojnLGnB1S+DScamyRYP+W/MPre85kSdPPbdPbUrQ9ucwGi
 bbGcaBFSIZH/NTKwsKz6uYuSn2D8dAruHlEkAnjkCAQtjFM2Fs7rvU45aUsHeW7vvQOd
 zpfIwAGXGPENH8Tz57xnteE0O7ciwlwxUsmLdrOxgAK3NOeHoG7XclY7G6r9b+Y5elDr
 s6Jt6AzpOlsK+QkUlCAIbBGMhy7Varr+EmPVmwPuMPTsGTMKFpJxtKb1cocRu7qbR4k2
 I4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fN7f9HhToW7DW+5JxYwPNwYrFEXL6X6GA6tgOJhYIHk=;
 fh=V38ZUJKxcdlJXqozTolwU01RKxD8Otqlj8bb6/l6OaE=;
 b=W7I6kMDnBjRmlfBNvDshhOSV5Kf6No2DT2rYmvVs84p3tbUDGEl9zWuz9EaG9ErAk3
 LRTw7K48+ez99DtcwVtait1aP92cGhgzIyzihEZzBjLjDAshYUzJ/5KcJS4m44I0QYoA
 RJ//78RooMo4kkcM4+CZXnaB4KQ0g0CrAGsucAKcN70eW/pIMZ6OVMqPM6oZQDk4nURM
 JAkWMyysWqS/6NM+CbDkVr/SP/DM0DcumufuEqlaEXxcW04r9bSPAXiTeaZzt60s4drc
 RbqnvPwZ+qF6SvK5TKtKkxlviHubqXO7yKxnqhqN1nZrEm+JoloQ3LfkhuMKzLs7mVZQ
 I2tA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783588935; x=1784193735; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fN7f9HhToW7DW+5JxYwPNwYrFEXL6X6GA6tgOJhYIHk=;
 b=zk6FAoQ1FaijpJjI/m3AnL5gYL2XmaHWmQD0mT6fXXv8SIKnU4j5fzRf7PqrJSMM3f
 786wGEJh7GAedkxj5kBtPWOVdB6oHB4djqk2ixL1a6ZvK7wruVgXd0cf8FN7vH4PKnmW
 q882mNv1RSveZ80V8nMRcsHdZ47xPcRLsrWNW9ge8cDvv/PjE6Zb1wjM5RVMKtZKRhDZ
 Sw+K/mHm6dnnZwekQAADUMQe0mIUdvAYEuvaTIULplVkxL62M8vEgyUhYLFUYoHQjpAj
 hWzYrL/3tBQ65N6uQjhRAsWgneiYk47Ab2UfKlCQEZnyf4bP0OMxh+e0/lxq641VLAaV
 PMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783588935; x=1784193735;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fN7f9HhToW7DW+5JxYwPNwYrFEXL6X6GA6tgOJhYIHk=;
 b=d2Kts+3vbgLTCDHeK6X5x71PKOW1cOH0qOUdU5glaONFF3rO/gz0sZuWBrLsmzgo3W
 219/TN+FyQQxQ14PFE3WiAR5Q0NChJPMAqkHwLpt5fHo3xuRV+MVJWtpuPsXDQBSKiI+
 b5AhDMF69G2p2fN8LUY9xiTRSvnbhRhJCFTHT40T6CWHPgSt1qEh+VrIZfO8Ysp2H5MF
 xU6HzrgaYW+iuM+9wylvyLB5XG9/+XC7vZU9bFfrUKPQTcNpXv1C1nVjOqEcq+1favEk
 eDyUCQbOtNlx21AVtX1DcDGTivd4tFytr8kKFpovOOKTN/gNlGT0UJi8IXDt5rc8pX8j
 74qA==
X-Gm-Message-State: AOJu0Yy3SYj6D3em+38KYZ3csQBWiDjcmaSs7UND6j3yxEhklwzwfu3g
 JuRhoUWmsRoMxjw28MO5ZopDhdAx5LT0sHZNvadWFcEU9zuIHMzgtrSU8o5ppFiDKDw8PO7Jqx3
 Gp9D5Eun1PJ8zmbBe40eGYNJId9cTDv+wWZQoq1XruA==
X-Gm-Gg: AfdE7cnNCa1x52UEDxff2mSf4lSuy0DPqizJJpEOSJAWHEw3hmIutjFpULkfofc/hCG
 oLuGWrWVxYmaSVv38Ixm7fpds9W383tpScJZvclUsaiqKV7COW6WrgdwpNpSgW4ecD7OIjXIfbr
 bQDcKPZS9iyGoar2Pv4EpuZ0v+ycyLuKjN4v3nXOyJMIgHocWgzUFmdDGYOSVPjfnNOg+OxisVr
 2IRyjGRXGaUH5q9U+8V1ejFCaFRsuz3ZeLSiLM8qB7Md2NjrWVTtyhg3KbKEEBnuKMQjHFV3doC
 U5SoTLXTovXffbHDEbGeoEBdd96qLLc+jp6HFfvBzy9IrUNQzBarUaqMNyLLXc6VnHs40KGEtBD
 DX1U9bwWNqnRSr1CKYmEzpehzf84VJyEvzW9cIWNgJd5HpfTcnHn98XgsuYBBRhzAIcAvBuhnRL
 TQm1c4upfBti7oDcHNPlciom0Om1yVmHa7RL8iJkOQouHjgrLr/vIwrNOSMSOF07ecxZjEBBXDB
 KmKO8uQAURdsclfDiLR0lfDnnKNW8cXpkg1LnynfBy3S6rZmGxdlWyIZ6lalT6rtWu22Ic9a4s7
 StKiQZjJ0X6LUlyOcn1gGhvUJi105tE5YhW52T/+1soOsyepp9t9sB+CD4Bz+FAmnUqI6UlRXU2
 drik4sA==
X-Received: by 2002:a53:b0c5:0:b0:664:ae6a:f04 with SMTP id
 956f58d0204a3-6679f26b792mr3697678d50.78.1783588935171; Thu, 09 Jul 2026
 02:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org>
 <20260703-usb-prep-dwc3-sync-v1-1-1352bc238c9b@kernel.org>
In-Reply-To: <20260703-usb-prep-dwc3-sync-v1-1-1352bc238c9b@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Jul 2026 12:21:39 +0300
X-Gm-Features: AVVi8CfPsPJ2t0Sgqg63IJsdgl3aLf6Sy0-Vl44TvOWcUIzYIELiPrqV__otjVE
Message-ID: <CAC_iWj+F2rfnis7LwaN_REs=BQ0PXjq=hYPZyYrRZPJmLFU5aA@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: dwc2: Use usb_ep_set_maxpacket_limit()
 for fifo sizes
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Not really an expert on USB but this seems reasonable

On Fri, 3 Jul 2026 at 16:29, Mattijs Korpershoek <mkorpershoek@kernel.org>
wrote:

> More recent versions of usb_ep_autoconfig() use the maxpacket_limit
> field from struct usb_ep.
>
> This field has been introduced in the linux kernel via commit
> e117e742d310 ("usb: gadget: add "maxpacket_limit" field to struct usb_ep")
> And has been ported to U-Boot via commit
> 747a0a5b387f ("usb: dwc3: gadget: make dwc3 gadget build in uboot")
>
> However, the dwc2 gadget driver was not converted to use
> usb_ep_set_maxpacket_limit().
> This is harmless for now, but the driver will break once
> usb_ep_autoconfig() is updated to a more recent version.
>
> Set maxpacket_limit via the recommended helper function to prepare for
> a core gadget update.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>

 Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/usb/gadget/dwc2_udc_otg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c
> b/drivers/usb/gadget/dwc2_udc_otg.c
> index e475b14b9ac3..9c85383fd62a 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -828,7 +828,6 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = ep0name,
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP0_FIFO_SIZE,
>                 },
>                 .dev = &memory,
>
> @@ -843,7 +842,6 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep1in-bulk",
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP_FIFO_SIZE,
>                 },
>                 .dev = &memory,
>
> @@ -858,7 +856,6 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep2out-bulk",
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP_FIFO_SIZE,
>                 },
>                 .dev = &memory,
>
> @@ -873,7 +870,6 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep3in-int",
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP_FIFO_SIZE,
>                 },
>                 .dev = &memory,
>
> @@ -893,6 +889,7 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
>  {
>         struct dwc2_udc *dev = &memory;
>         int retval = 0;
> +       int i;
>
>         debug("%s: %p\n", __func__, pdata);
>
> @@ -909,6 +906,10 @@ int dwc2_udc_probe(struct dwc2_plat_otg_data *pdata)
>
>         the_controller = dev;
>
> +       usb_ep_set_maxpacket_limit(&dev->ep[0].ep, EP0_FIFO_SIZE);
> +       for (i = 1; i < DWC2_MAX_ENDPOINTS; i++)
> +               usb_ep_set_maxpacket_limit(&dev->ep[i].ep, EP_FIFO_SIZE);
> +
>         usb_ctrl = memalign(CONFIG_SYS_CACHELINE_SIZE,
>                             ROUND(sizeof(struct usb_ctrlrequest),
>                                   CONFIG_SYS_CACHELINE_SIZE));
>
> --
> 2.54.0
>
>
