Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E62C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 10:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 646398304D;
	Mon,  7 Jul 2025 12:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751883013;
	bh=61FKobgfPkrbe4dFO41a3o1Ld6VVPCI1PbBD2ELL/5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qiEaICEIc0bjSPDyx9L8AhSSSnvO/zAUXg/0+kcfLBve4KFRJkhWuS26RjE8yVaT/
	 NteDPwLlXoopKdomHjrBVFh6vtppWW9h1oaMyqeTrVZletzVEc/bG9n3YrzrMwDG/j
	 +4QiIKoGmmc4FPZyN40QBO3zcJaTwVe0PIDC9w7nGfo5hIaQpWF0v8o83XSMVqvFEO
	 hF/9QohOXItSUi7arjbDIyjoyZ5gRg0gzeigjA/zD2lPod96flmzEQbM6tfFQyXdaR
	 eWUMvkTBekUSguBI3M4C7zGupi4xOLMeDELK1YeBoKNv0/2XzbKZOXN8ponivltYFI
	 1sPlGcdZM011A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 475FA830C8; Mon,  7 Jul 2025 12:10:12 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E5D83018
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 12:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JbcmyNw3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6729510380104; 
 Mon,  7 Jul 2025 12:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751883009; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=61FKobgfPkrbe4dFO41a3o1Ld6VVPCI1PbBD2ELL/5c=;
 b=JbcmyNw3qUwHrI9lvnMQJqFLAz00yPQlfSkJmRPPWY8ZwFPBCUFPUjOKiyeZsMYX1qmzX1
 EMl1oC7MTARsyi4kq1HArUJkc86VqnzoGjJ0ZjazwlomDSEevoqarjHv+Ik8sc3GAqZwpw
 KmSBYIejUeMVWzlA7hD0TbKYFWaJH7yPKTrObsZWtuJ8oC2Hi2IjygEPKGLdI8CeeqCGl8
 eeJUxkHMwIRDAyr8NlIHB0HCbFpZDK5Z7yenc2esSi32q0VS30CNPJ+mAH68dzy3XRrtev
 TyirIeJvvL1YWeYxVUN9YYNojbaenXeCTbd4gH8ZiTYLxSF1i3qj4AjnXdA67w==
Date: Mon, 7 Jul 2025 12:10:07 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [bug report] usb: Assimilate usb_get_descriptor() to linux
Message-ID: <aGuc_2U-P6onIMwY@antares>
References: <caa9932c-c5dd-46d6-a5ae-120238300a73@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa9932c-c5dd-46d6-a5ae-120238300a73@linaro.org>
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Andrew,

On Thu, Jun 19, 2025 at 01:02:39PM +0100, Andrew Goodbody wrote:
> Hello Philip Oberfichtner,
> 
> Commit 2fc8638403c7 ("usb: Assimilate usb_get_descriptor() to linux")
> from Jun 4, 2024, leads to the following Smatch static checker
> warning:
> 
> 	common/usb.c:261 usb_control_msg()
> 	warn: should this be 'timeout == -1'

Thanks for pointing this out. Fixup is on the way.

Best regards,
Philip


> 
> common/usb.c
>     220 int usb_control_msg(struct usb_device *dev, unsigned int pipe,
>     221                         unsigned char request, unsigned char
> requesttype,
>     222                         unsigned short value, unsigned short index,
>     223                         void *data, unsigned short size, int
> timeout)
>     224 {
>     225         ALLOC_CACHE_ALIGN_BUFFER(struct devrequest, setup_packet,
> 1);
>     226         int err;
>     227
>     228         if ((timeout == 0) && (!asynch_allowed)) {
>     229                 /* request for a asynch control pipe is not allowed
> */
>     230                 return -EINVAL;
>     231         }
>     232
>     233         /* set setup command */
>     234         setup_packet->requesttype = requesttype;
>     235         setup_packet->request = request;
>     236         setup_packet->value = cpu_to_le16(value);
>     237         setup_packet->index = cpu_to_le16(index);
>     238         setup_packet->length = cpu_to_le16(size);
>     239         debug("usb_control_msg: request: 0x%X, requesttype: 0x%X, "
> \
>     240               "value 0x%X index 0x%X length 0x%X\n",
>     241               request, requesttype, value, index, size);
>     242         dev->status = USB_ST_NOT_PROC; /*not yet processed */
>     243
>     244         err = submit_control_msg(dev, pipe, data, size,
> setup_packet);
>     245         if (err < 0)
>     246                 return err;
>     247         if (timeout == 0)
>     248                 return (int)size;
>     249
>     250         /*
>     251          * Wait for status to update until timeout expires, USB
> driver
>     252          * interrupt handler may set the status when the USB
> operation has
>     253          * been completed.
>     254          */
>     255         while (timeout--) {
>     256                 if (!((volatile unsigned long)dev->status &
> USB_ST_NOT_PROC))
>     257                         break;
>     258                 mdelay(1);
>     259         }
>     260
> --> 261         if (timeout == 0)
>     262                 return -ETIMEDOUT;
>     263
>     264         if (dev->status)
>     265                 return -1;
>     266
>     267         return dev->act_len;
>     268 }
> 
> Regards,
> Andrew Goodbody

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-22  Fax: +49-8142-66989-80   Email: pro@denx.de
=====================================================================
