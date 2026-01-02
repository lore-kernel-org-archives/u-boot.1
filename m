Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A71FA3753
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 19:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA05C84255;
	Fri,  2 Jan 2026 20:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sYx+9Qyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8F684262; Fri,  2 Jan 2026 20:10:16 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 766058421C
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 20:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 198B73F798
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767381014;
 bh=h8z36WpwKxaYv+8WX5tmuvBZB8wlbRgSVh5wV32pjkE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=sYx+9Qyqkaw+ooqTJhw02eTh/dX56QzYCj+wRjmN1SGQAVWaH7781N1xDs1TwFXK3
 FuQdSJepvNpdZlgcybRTzrWAa8SF4LNMsiY8kzFXxRl3YA0/Fo5zfGdSNCDTJY63tF
 cMV4L0X0cbpj8nrESFbjNRVo2HqucmzG7rELinYN5+pxhyOjQAfv70aH+YaKkFOF8O
 zU4wodGSeArsK1vKbDx259V6soo3XDpVniPWJR5UM/fdyxRgMQ3fk9kFcZuSOKCrHE
 ugf+JmhuOIzY5u8eMsUI6yYMOygzbvAs/ld4tsViotmyl9tqdazKvXtJlQ9YSdE7AJ
 89PsqZZJumfdHGIH3h1NwnXBGd2rJr24ENIMS/ZJ7r3rVybKFKL02QjYG07zB8CrGO
 Af3uWAwmfbWWR8cS/gc0fbLGlsKnUBbVXJctPdLoxaA9ntW2ENlBG8nLkMfDClgprC
 /mMLLyTVl7ZydszGSjMbZMc7ZIZLoXH25ESviD52fSc8B1mTEJdIH7yF4jiDRuYElA
 wQyokXREVCOkxgFksOfpRyPE1Lepmyg8rlYxOWxzmRFxvlejhm9MYQutPFxrj/E4E+
 7MDY0eqVY8y4tGgz8unZGGXjIgija5rJZJbq8PQHtBK4Qtk+TTt5j7OXpillc6ftOq
 HmwKgQcH/LhH3GkfampULKFs=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so3267974f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 11:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767381013; x=1767985813;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8z36WpwKxaYv+8WX5tmuvBZB8wlbRgSVh5wV32pjkE=;
 b=DH7S3D568p1EykylQYDlETL63L6O0IDUoDFS0Q5gNIH7hi+iOdU4hoV4gIt5Ask6X+
 aPkNjdKtO1dnUX2Rikz+8WpyUCOGy0NDkEQt6OJ070K+fSauwnqdnYKIqDVRFSudhzEn
 M4DidZP7SxsHPxittODPs4H42acwp+e9MHvZzflMLNNdUMs9Ko+qnd9O6q3LIYSG8zUr
 7iWUm7nMPianyRRug86sssPJgE7lyEJ74fBkU1B58YOr7LPQbdKG8CSkitdkojqArGrS
 pasQ+PvMpdAFaocGAgiXHodMu/X0JiJuWMi5zU/MQ3EZ0iRPvNmkUjsAvxOGMgSnbyVL
 XyHQ==
X-Gm-Message-State: AOJu0Yyspcy/St7H//e2SsCF7EkSb9KKgbV/q84qDCfiID9GzlfDIdEP
 QT/m8/4xn7ixBNYZh9ScEolEa9vVmwD2MR+qw/1bpCvnyxjxxieyS3BqNCMAKfo7j7LKGwpPqu+
 1RHnJjp0KBkFhuhf5rG0PcDYGC+DbEemvpOqm3z8ePO7tlPDTqKU49GJXErdWKaD0s/C1O/8=
X-Gm-Gg: AY/fxX5nCVrRTAGDb1c/opWzkHC4KZrOk88EGOPESjQxfAVjtjix1mFSGlvhUvJCUR1
 aejrv6pdQFkMNj1xKX3c/GoiVarXv4CeSl272rIFC0iXBqUPJXlNH+9PFmbPaB01WOAHvpWoi0W
 3d+C5OTsVsIHXbfH2S70x64f5ZWEOCL+iFNji/C4DZf45IoPeUWOQg/OL9/uDoXMDZsvicjAuGd
 EUjN6QDR7xCb5TW/+5hAj1fjjU7iyjiFcbOmAk/0x3QuaOPpP4PrZ2ddqrMjBoGLAY4IfN87NdD
 NctCFNBBk0AGYFdNlHKxHkrmfiYl3ZRBZQqHmE5IpkjZBH3zOPWfHM7hthBU7wgcOeP6H5okTGP
 mXMB91Zi2RnkXeDNNxliflFfMIRneF0eQGZn34pSOUZMY+tI4bHqbUaZqsrija6OtzAvl6EpfTL
 bCJmfFbck=
X-Received: by 2002:a5d:5f90:0:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-4324e4c38bcmr50821020f8f.6.1767381013646; 
 Fri, 02 Jan 2026 11:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyrHAQIJapw46JFggQyNKsApFPeT+ZdSFPvYuT9/iGsL5tYcjLrxAFj3W7eYBvbc3QIr0fgA==
X-Received: by 2002:a5d:5f90:0:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-4324e4c38bcmr50820991f8f.6.1767381013184; 
 Fri, 02 Jan 2026 11:10:13 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4325b6bfe88sm78021791f8f.19.2026.01.02.11.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 11:10:12 -0800 (PST)
Message-ID: <3f5af37c-db44-4686-9a13-1b8d52a90889@canonical.com>
Date: Fri, 2 Jan 2026 20:10:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb_kbd: remove match string
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
References: <20260102125622.144573-1-heinrich.schuchardt@canonical.com>
 <da40c4d0-8c8a-4341-b779-96f571b7db87@mailbox.org>
 <CALeDE9Oue=0L3PRVs7O8suPVDFBXL_i6o0hc50jLQ49HtaX2nQ@mail.gmail.com>
 <67fefad5-ce05-486b-81f9-f28798195bc1@mailbox.org>
 <CALeDE9NVNR8pA5G6um7p0CTmuQqmK4LWLoxj--jRKnBWJ5+dhg@mail.gmail.com>
 <18a3fe38-c6dd-48e2-9273-c6862b99b7c9@canonical.com>
 <9368ca1e-f57b-403b-9d07-fc0e69d3e989@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <9368ca1e-f57b-403b-9d07-fc0e69d3e989@mailbox.org>
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

On 1/2/26 17:21, Marek Vasut wrote:
> On 1/2/26 4:15 PM, Heinrich Schuchardt wrote:
> 
> [...]
> 
>> Looking at https://gitlab.com/CalcProgrammer1/OpenRGB/ the protocols 
>> used to control keyboard backlights vary a lot between vendors.
> 
> openrgb seems to be meant to control various fancy vendor LEDs and such, 
> I'm talking about the boring 1-color keyboard backlight on laptop 
> keyboards.
> 
>> But anyway the vendor ID and product ID is used to identify the USB 
>> keyboard and to look up which protocol it uses. There is no need for a 
>> device-tree description.
> 
> It is in fact the other way around -- if it is a HID keyboard device 
> according to USB descriptor, it doesn't matter which VID/PID it has. The 
> few keyboards described in the usb_kbd.c driver are there because they 
> need quirks.

I wrote about backlight drivers needing VID/PID in OpenRGB for discovery 
of the protocol.

> 
> So, to move the discussion along. I can see why an USB keyboard might 
> have to be described in DT. It seems the usb-keyboard DT compatible is 
> not standard. If it should be removed, the commit message needs much 
> better justification for doing so.

I can't see any use case for a USB keyboard described by a fantasy 
compatible string which no operating system supports.

Leaving this unused code is just a waste of binary size.

I have updated the commit message in v2.

Best regards

Heinrich

