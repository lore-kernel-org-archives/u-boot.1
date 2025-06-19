Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B71EC7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 12:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CB282CD5;
	Thu, 19 Jun 2025 14:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L9pV69O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1A282D18; Thu, 19 Jun 2025 14:02:47 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF2482CCE
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 14:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so5028235e9.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750334565; x=1750939365; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtjbSnnmmJNTy9AQcsXNJxpx4wckFGwTGdRsQG662B0=;
 b=L9pV69O7gvHDN/qqpZYnHIqRdKmNwn1WpTW3a3cDARRvb7VjUPEj0sko7OBpGUvYic
 d0zihWZk2V+WF2fVCqLR2dBGyX9QJz6aSFouN8qY67kpe7eWDV5CxumJtqAbIxRV2m2r
 zhT/frGmm3goOK+XERBv6kC3OxWqrL/gYr6WP+9XF8+KwB4nb00yUEdyVkrLt0osekhL
 1S6NWWgynDv9xFrl5dVUYzqTyuaadavGJ6ZbKSa+2SIzrO/TTYAtWoU25WvtUywBNA7c
 ijT5DxPWzl/mp31eUTPWHUOUmalO70AAGl3nziz18Tdhu1CWFHV3w3ByHelcnoKSeKjY
 k/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750334565; x=1750939365;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AtjbSnnmmJNTy9AQcsXNJxpx4wckFGwTGdRsQG662B0=;
 b=EQbROFQW9yhBQ/a7YEUDP4sWUtzAoc9Qy1YsveZ+hDJMnalMwSUIs0sIHofxItIQwB
 4viW8S8/a3mvGp42Md08dKNCM9kuO2MwqS59wn7kcLqUE8epqyP81hx3h7YdEpmKrXih
 9ypH9KtfRnUL4yQeIAO0rXcn1S991TSmv9mNMYva8Gh/ahhXjN8uEv0wv+tO+u4FBx7B
 nihBPE+1YeeCw+v/ok9J/4VbbfUHsxclgw7Ah8wFNoFePEUcQobPiwrERMyucPmY3+pm
 PBUzAf2kYwiAjMfUnq5h2c/llRjIQ7ArIRmCaw+wg1bjlCPxAYvb52YVSsZEM8tr/7LU
 +Ang==
X-Gm-Message-State: AOJu0YwIk5h2WJDz+ffMn+y/OXfAZ6L6YGnzgXvqtXbvUC0D9ewdqwrr
 GeY9D9kFEVFMz8vTv7TifJ3de1mnMlN0PKwpg17/IncIhR80tLTKDlW7O0nCEYupUut4eh+ajXY
 tMdvaSsg=
X-Gm-Gg: ASbGncvXSHrFFD18TT1xQx7Ypbh6+E4ioAPwd4IiBmvcwk8ptWhKrXye0K6abcD91e5
 z6XSfWor7JPxwa/QvfxLto93qgdkSvo7Fe+ZVujne1PHvdkMkDr8wZoVO/eiybGHzlMSX/ZC17q
 h/Y6ug860fTROcN8ATRTz6OChxGTBszMUGi+7/tDD/ktVvN78pc9dcLx3Da2v707uzySzJNZQBo
 7JVeQgyXUYe1W88IERu1sTGQ5znDXJEftrXo0LmF5K3qvzjVXGK0fHY0vDEOwrsSj01Wtj0lEE3
 cCsuNRtLMpKjLjv7BmLRQOUfIhYwuOLC5c9zGegf3578fP07Loir+pxhNOnLE34spb18XcPizDU
 ibG0GPyOCui/HXhZ4r1rWgMMOd9XMmplDxdB9MmvzuTrzOC6oIrra
X-Google-Smtp-Source: AGHT+IHHBo0h9lJCZi8oXO4p7zCUm51Gek3lmFub469juu3PMSOppbQgY9HhNmf9oDOY2TzYk7VZHA==
X-Received: by 2002:a05:6000:2908:b0:3a3:ec58:ebf2 with SMTP id
 ffacd0b85a97d-3a572398e99mr16950337f8f.7.1750334563499; 
 Thu, 19 Jun 2025 05:02:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:cf2f:b483:c307:5b0f?
 ([2a0a:ef40:ee3:2301:cf2f:b483:c307:5b0f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5896356eesm6991696f8f.49.2025.06.19.05.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 05:02:42 -0700 (PDT)
Message-ID: <caa9932c-c5dd-46d6-a5ae-120238300a73@linaro.org>
Date: Thu, 19 Jun 2025 13:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Philip Oberfichtner <pro@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [bug report] usb: Assimilate usb_get_descriptor() to linux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Philip Oberfichtner,

Commit 2fc8638403c7 ("usb: Assimilate usb_get_descriptor() to linux")
from Jun 4, 2024, leads to the following Smatch static checker
warning:

	common/usb.c:261 usb_control_msg()
	warn: should this be 'timeout == -1'

common/usb.c
     220 int usb_control_msg(struct usb_device *dev, unsigned int pipe,
     221                         unsigned char request, unsigned char 
requesttype,
     222                         unsigned short value, unsigned short index,
     223                         void *data, unsigned short size, int 
timeout)
     224 {
     225         ALLOC_CACHE_ALIGN_BUFFER(struct devrequest, 
setup_packet, 1);
     226         int err;
     227
     228         if ((timeout == 0) && (!asynch_allowed)) {
     229                 /* request for a asynch control pipe is not 
allowed */
     230                 return -EINVAL;
     231         }
     232
     233         /* set setup command */
     234         setup_packet->requesttype = requesttype;
     235         setup_packet->request = request;
     236         setup_packet->value = cpu_to_le16(value);
     237         setup_packet->index = cpu_to_le16(index);
     238         setup_packet->length = cpu_to_le16(size);
     239         debug("usb_control_msg: request: 0x%X, requesttype: 
0x%X, " \
     240               "value 0x%X index 0x%X length 0x%X\n",
     241               request, requesttype, value, index, size);
     242         dev->status = USB_ST_NOT_PROC; /*not yet processed */
     243
     244         err = submit_control_msg(dev, pipe, data, size, 
setup_packet);
     245         if (err < 0)
     246                 return err;
     247         if (timeout == 0)
     248                 return (int)size;
     249
     250         /*
     251          * Wait for status to update until timeout expires, USB 
driver
     252          * interrupt handler may set the status when the USB 
operation has
     253          * been completed.
     254          */
     255         while (timeout--) {
     256                 if (!((volatile unsigned long)dev->status & 
USB_ST_NOT_PROC))
     257                         break;
     258                 mdelay(1);
     259         }
     260
--> 261         if (timeout == 0)
     262                 return -ETIMEDOUT;
     263
     264         if (dev->status)
     265                 return -1;
     266
     267         return dev->act_len;
     268 }

Regards,
Andrew Goodbody
