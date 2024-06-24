Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F09C2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 19:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574FD87D07;
	Mon, 24 Jun 2024 21:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Nj4rGITE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4BB87572; Mon, 24 Jun 2024 21:39:25 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A80E883DE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6fdd947967so245715766b.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719257959; x=1719862759; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8hofnCnFArBzqpry09H8Mrk+Du/oOXCOo9C1KCQhJhk=;
 b=Nj4rGITEgkrTfIJwbDNO39uWyXW6GbnRAbJ769bAyTmQqnF1gn5gcCYdzfewDlbKy3
 OdRSzsSkKZ+KfE2JsHr3sZwiWtsTEMCP0wu7pd/uQKYVdzId3Bht78xmTKAtTbhVWc5N
 0CefOS4z4J01iNT/fZrszU/N+SqCpBKBNkroep8UnRS16RPk+xXlq+y97UOlkpVH9yGR
 PrZblnJBH4DRGXAVRi0U//RnPxBUXXoBhzJYYJB4JhtAV+jHFUPIuiOzJzMQR7z5dv/5
 XqoBqCAgkmXVz6SVRMnwHv87VKXyoToqyzwiiB/+pt6xXZaGE0FzK6ZuFdWHKS/OeBAY
 NThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719257959; x=1719862759;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8hofnCnFArBzqpry09H8Mrk+Du/oOXCOo9C1KCQhJhk=;
 b=vgXyBO7fPrmuWUOu2BwmAvJtruppvRj0HvPCb++B97KjHdvVTW3YmPwC9c2RKdmjZs
 uPsKkarIQeOwcQa6qG6rxLPuSxMID8SznKH1zNjPYgZrEOJvJoExBsd3Dj/KZJN8ZsaR
 OTOEuUZsXvAF3iUeFMDV31MTDHGzbyj1bxGMDe2q1+Q9fjoft+Ywmy6XsSq3Dp2lx0nN
 51qXg8MzgEfIFg44bgUfcrYIYtm//oypZ/6ySHnnU1S2C+gGXKSph21GYlS8O5CvdFK7
 bydy2xKMEpDp5+AIi1XnXhgFOBx+eE3Xply1rWdPxu1ZrANkq4F8ML+cm0nGe/8wnYqC
 tRYg==
X-Gm-Message-State: AOJu0YwrBxMar/c4UTjMRgQdppRODQJgQXIHmJUQAPhsBv5FfvKgAMDc
 9ApmDITGkx73eKrKzHQIv9vA9I3wQ6DgPRju260ooeirme66exuOYtx8Ve/LC2ifb3VQ1z/ycoa
 jxvZ+BVCEUAFw/FVJl9TRQ0F/oK37AF8Nz7amQ/Y2ymRQVBOO4Fk=
X-Google-Smtp-Source: AGHT+IEKwqH1p1tICJhovLeEsc1TEpi9oUmvlJtgBMqNPMgV7/rPujmLk/RzxALSwUcGBFdwnlZA5v7lYXp84RJrYNA=
X-Received: by 2002:a17:907:c787:b0:a6f:b6c3:fb30 with SMTP id
 a640c23a62f3a-a7245b84f56mr534271566b.7.1719257959232; Mon, 24 Jun 2024
 12:39:19 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 24 Jun 2024 12:39:06 -0700
Message-ID: <CAJ+vNU34T3gpSn0upzfK8ra5pUyVDE-CQZGaNo73btHA4pdE-A@mail.gmail.com>
Subject: USB OTG mode for DWC3 (ie imx8mp) host controller with usb_ether USB
 Ethernet gadget?
To: u-boot <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Teresa Remmet <t.remmet@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

Greetings,

What is missing in U-Boot for the DWC3 host controller to support OTG
mode for usb_ether (USB Ethernet gadget)? I'm unable to get the usb
ethernet gadget to work for the imx8mp as it errors out with 'No UDC
available in the system'.

The ums/acm/sdp gadget's all call udc_device_get_by_index to get the
UDC controller which for DWC3 is provided by
drivers/usb/dwc3/dwc3-generic.c and these gadgets work, however
usb_ether is different in that it calls usb_gadget_register_driver to
bind the gadget driver to the UDC and for DWC3 this calls
usb_gadget_probe_driver which iterates over udc_list which does not
contain DWC3 hosts that are in peripheral/otg mode.

Before I spend a lot more time on this I wanted to see if anyone else
understands why boards with DWC3 host controllers like imx8mp don't
seem to register controllers in udc_list that are not in host mode.

I'm also unclear how to get a DWC3 controller to switch roles
dynamically at runtime based on a gpio state for example. That support
appears to be missing and I'm not sure what the right way would be to
go about adding it. I notice that some imx8mp boards like the
imx8mp-evk have a u-boot.dtsi that just forces its OTG controller to
peripheral mode and I force the imx8mp-venice OTG controllers into
host mode.

Best Regards,

Tim
