Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8087C83F11
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 18:41:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 550F68056B;
	Sun, 27 Aug 2023 20:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+vK7GKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA09680568; Sun, 27 Aug 2023 20:41:29 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2617D8056B
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 20:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fef34c33d6so24251665e9.3
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693161686; x=1693766486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZ+oxXh9m/GzM+ZlsfQykNYyIsQnmImNs7VBfR0ZNoM=;
 b=E+vK7GKWpwGV7O60j5BGc8/5x1S12ecE0cKLZqZ7El8Ob/6XfAjbImD1vb1mRFK934
 3YwBXIeKOT9pTJEz2jSDcxVpitYtFYoanm/xnb5EN/yXjTjtbR3SMtbMtKW4MbjpTa1K
 qQEdv+ifrcUDxTO9pwGZTUIQhvoQHrgkYeirnf/Q70+W0fXfqi2PqYZygQS+HP/sVKFz
 8dS/PHtybbDF+abryVZcio9pQvEOplHU4iu3pjlFBwe0slGBAQ6Eg6o+NR4+hyWD2B7y
 hhXgtZCT3p9LncC90hObjnjbZ+8v8Oaqjk+AEcx4qS8+vDwfN8opmPimT2W0AQtkt2xM
 Df2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693161686; x=1693766486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZ+oxXh9m/GzM+ZlsfQykNYyIsQnmImNs7VBfR0ZNoM=;
 b=At54xjiBbIdlyH0uyQemsSE4FA9LxBgo/aOBsFsfzkdCMXey6iK114mxxTJL2nGyyX
 mOagoWdaxuMBfGmmTRfXnfD6oyL3nophB2W28YlYP852nhCjTAer0YZFGSfbtQBsGhQ2
 L5LQAT09h/HYNZ3CN6DwA0lvAfOUn4SbSJ5X+A7UIqerWNeOxJcI0tEUbG8lG2MF8BhV
 PIizuE7q8A7nGMOZ0V7S455Wt99UCF41R85GXDgJfVNi9OJDcjGDVoQDmrfMX4fTACRt
 qQtuFb0JqFjNblTLenZTlEIQHnI4fNQfheRkN+Vepr9hdG1fX9uobyvJ16g5ND7RLv+5
 K2Wg==
X-Gm-Message-State: AOJu0YwcWYlPJNG+1AJwZc1/7bjR+7K9JCHKbdae0P5wMmoZHpNcdc60
 mXAqwCzGDeWZ8eUlErr2w1o=
X-Google-Smtp-Source: AGHT+IH1s6WgeF31ELAbVKsxds+i5Ufkp1d2raFpXlJtC7Te6TX3ddfHLWB3m4KTdH3MhfwL/J9zYQ==
X-Received: by 2002:a05:600c:2217:b0:401:b53e:6c40 with SMTP id
 z23-20020a05600c221700b00401b53e6c40mr5809021wml.10.1693161686362; 
 Sun, 27 Aug 2023 11:41:26 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 w21-20020a05600c015500b003fee7b67f67sm8418672wmm.31.2023.08.27.11.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 11:41:25 -0700 (PDT)
Message-ID: <86ca51bd-8277-45e3-a458-6e4dde3a4d90@gmail.com>
Date: Sun, 27 Aug 2023 21:41:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Correct handling of frame buffer
Content-Language: en-US, tr, en-GB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20230825192842.1957055-1-sjg@chromium.org>
 <af866d03-d097-48b9-994a-450ac4702d34@gmail.com>
 <274DFE38-4A70-4181-9725-EE7BC5A0483B@gmx.de>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <274DFE38-4A70-4181-9725-EE7BC5A0483B@gmx.de>
Content-Type: text/plain; charset=UTF-8
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

On 2023-08-27 19:32 +03:00, Heinrich Schuchardt wrote:
> Am 27. August 2023 16:56:51 MESZ schrieb Alper Nebi Yasak <alpernebiyasak@gmail.com>:
>> On 2023-08-25 22:28 +03:00, Simon Glass wrote:
>>> so we must allow EFI to write directly to the hardware framebuffer.
>>
>> If you want a fix independent of that series, I think the proper
>> approach here is having EFI draw to fb as it already does, then copying
>> from that to copy_fb at the end of gop_blt_int().
> 
> An EFI app can write directly to the framebuffer and mix that with API calls.

Ack. Can EFI apps write to framebuffer without informing U-Boot at all?
What I meant is, copying whenever EFI asks us to modify something or
tells us it modified something.

If it can write without telling us, how are cache flushes and hardware
syncs handled? Asking these because I'm doing some weird experiments
with video damage and cyclic video_sync() calls and VIDEO_COPY...

> blt functions causing a full copy would be much slower than what you get when eliminating the copy fb.

When we expose copy_fb to EFI, don't we need to keep fb up to date,
incurring the same cost? The VIDEO_COPY description mentions "reading
from the frame buffer is slow", so whatever code is "reading" would use
fb and would get bad data otherwise. But I can't exactly point to any
examples other than the video damage series copying fb onto copy_fb.
