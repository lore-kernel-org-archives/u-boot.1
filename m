Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01224C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5636086F95;
	Fri,  1 Dec 2023 19:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hBw5wdFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF59186FC9; Fri,  1 Dec 2023 19:50:45 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B86EC86501
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephen.graf@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cdd28aa7f8so2344974b3a.3
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701456642; x=1702061442; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R3KirjFnVpXFWMsJNro6OZTInSngEe0mSu2U6KTe9ZI=;
 b=hBw5wdFPhjMggRx17CjXi8JCz3SPFjvhLLc3V2ZZ3mV6MEshLA5JnJXHXnJgc3IiN1
 lpbyrQvRk8U7ypmgibSj0gnPmKoBtMG52UOduNTJmfiD88sFaSZ6pJOcHKhEYTfap3wE
 W14ZkrzXuJwNQYfTI8m7NqvyOBEfia6q1EmvqCi4oHPwSU+xEn0OUYha1P6f2/M1ZX/B
 mQ1uVSwRYlC4rabBtMPgKuNrkADSvM2jOD59lK8au/KjywrAgTsalO7zvFkAq1lNPdjX
 qWx+HW9CzFUtztqVRQWVu/RKsJakFw0PmAyv0jaCDLtf7MF377gOTUgFCLiXJIAXRY+d
 CN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701456642; x=1702061442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R3KirjFnVpXFWMsJNro6OZTInSngEe0mSu2U6KTe9ZI=;
 b=ieKQdsbgJenxlOulXWK4jaJrQv5+a7qbUtq81sXO7+VJPGmaUpbWqZ0u6jGonrUjOS
 IEVE4QbuSH4fEUsv7JqJdkZsoirlqCgnqLIGSP+4+Okzw7Sdwfk8WMNXkWswTqMzttIw
 fWGshRYjE1KNlIdOEqz3hvR/s22wxMlmccQuinDcw7oc3pjexF2vX8fGMgw0dIY/ySeH
 aevC24mEOs8FUwH1O61jKD3W///LIgCdHwwszhn8itEcc/+q2wjZyuydh+XIk1+YtOd9
 NwD3FrxZJ/pP0b1MdP2LQ9d+NU1dA9Oad3jz2/OpSKS8UW1rbivrZW4uPLza5E9f2hBv
 /1jg==
X-Gm-Message-State: AOJu0YyQhUFjY4h89MYvwj//5TwKNGag7nGfHvJYZKhPcyuC2sMzWnia
 AkF33w30nqb4ahK3UbpNs80=
X-Google-Smtp-Source: AGHT+IEAn2zdk83VqulfQX/swK0vD8DxzA/QAlOKRxu4kRJVLG3t2FG903PujmBfvI4zh2ln5/JqRw==
X-Received: by 2002:a05:6a20:5502:b0:18b:2710:d729 with SMTP id
 ko2-20020a056a20550200b0018b2710d729mr21144775pzb.31.1701456641305; 
 Fri, 01 Dec 2023 10:50:41 -0800 (PST)
Received: from [192.168.1.3] (d23-16-72-139.bchsia.telus.net. [23.16.72.139])
 by smtp.gmail.com with ESMTPSA id
 g24-20020a056a00079800b006cde7dd80cbsm3310183pfu.191.2023.12.01.10.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 10:50:40 -0800 (PST)
Message-ID: <ef003512-e433-4d83-87a4-5ae3341f6399@gmail.com>
Date: Fri, 1 Dec 2023 10:50:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/1] correct documentation for SPI flashing
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
References: <20231114013106.31336-1-andre.przywara@arm.com>
 <20231114013106.31336-4-andre.przywara@arm.com>
 <0eab5c21-4fdc-478e-9071-f43c12e01fb3@gmail.com>
 <20231126002349.55404e43@slackpad.lan>
 <465a5608-89f7-4691-a2e0-ebec9b85d994@gmail.com>
 <20231126122342.3944cad5@slackpad.lan>
 <d8862c87-072d-4f74-bb37-08f34c610cc8@gmail.com>
 <dae3bee5-e1c7-4154-959c-e41dabb5d844@gmail.com>
 <20231128013746.23648d39@slackpad.lan>
 <5d7ea381-2a57-46f7-85c6-2bcad339d1db@gmail.com>
 <0d46cc83-8820-4bf2-95bd-a0c12b6f7aff@arm.com>
 <d410fbe1-bf0f-4cb5-99cf-3353b952985b@gmail.com>
 <345d9916-6ae6-4dbe-99a2-33aafeebcb60@arm.com>
Content-Language: en-CA
From: Stephen Graf <stephen.graf@gmail.com>
In-Reply-To: <345d9916-6ae6-4dbe-99a2-33aafeebcb60@arm.com>
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

The mtd_debug write does not work in this context. The flashcp command does work, provides
both the erase and write functions and with the verbose option gives good feedback.

Signed-off-by: Stephen Graf <stephen.graf@gmail.com>
---
  doc/board/allwinner/sunxi.rst | 3 +--
  1 file changed, 1 insertions(+), 2 deletions(-)

diff --git a/doc/board/allwinner/sunxi.rst b/doc/board/allwinner/sunxi.rst
index 797222d8d3..d0c89b956b 100644
--- a/doc/board/allwinner/sunxi.rst
+++ b/doc/board/allwinner/sunxi.rst
@@ -251,8 +251,7 @@ the SPI flash content from Linux, using the `MTD utils`_::

      # apt-get install mtd-utils
      # mtdinfo
-    # mtd_debug erase /dev/mtdX 0 0xf0000
-    # mtd_debug write /dev/mtdX 0 0xf0000 u-boot-sunxi-with-spl.bin
+    # flashcp -v u-boot-sunxi-with-spl.bin /dev/mtdX

  ``/dev/mtdX`` needs to be replaced with the respective device name, as listed
  in the output of ``mtdinfo``.
---

On 2023-11-30 4:27 p.m., Andre Przywara wrote:
> Hi Stephen,
> 
> On 30/11/2023 01:13, Stephen Graf wrote:
>> Is the attached patch file going in the right direction?
> 
> yes, thanks, the change itself looks alright, but it needs to be:
> - in a separate email, with a descriptive subject, prefixed by [PATCH]
> - have the diff inline, not as an attachment (to allow easy commenting in an email thread)
> - have a Signed-off-by: tag with your name and email address. This is to signify that the change is an original one made by you and you are happy to submit this under the (GPL) license conditions.
> - an explanation *why* this change is required (mtd_debug write being not reliable, etc)
> - sent to the U-Boot list and the maintainer (me)
> 
> Look at the U-Boot mailing list (archive) for examples.
> "git format-patch" creates everything in the right format (mbox), and "git send-email" will send this via an SMTP server you point it to. Or you import this into your client.
> 
> If you could try this (with the Signed-off-by being the most important change), I am happy to submit this with the next push.
> 
> Thanks,
> Andre
> 
>>
>> On 2023-11-29 3:57 p.m., Andre Przywara wrote:
>>> Hi Stephen,
>>>
>>> On 28/11/2023 20:07, Stephen Graf wrote:
>>>> Below is the console log from trying to use mtd_debug write. It returned immediately with a strange success message.
>>>>
>>>> root@orangepizero3:~# mtd_debug write /dev/mtd0 0 0xf0000 /home/sysadmin/u-boot-sunxi-with-spl.bin
>>>> file_to_flash: fread, size 0xf0000, n 0xf0000
>>>> fread(): Success
>>>
>>> interesting, I was under the impression that "mtd_debug write" would be the way to write to flash. In hindsight, the "debug" in that name should have probably put me off. Anyway, "cat" is probably not a good choice, "dd" is better, but it looks like "flashcp" (also part of mtdutils) is the go-to tool, since it does the required erasing automatically and also reportedly does some error detection. Can you please test this?
>>> # flashcp u-boot-sunxi-with-spl.bin /dev/mtd0
>>> I would test this on my end ASAP as well.
>>>
>>> Do you feel like sending a patch to the U-Boot documentation to get this changed then?
>>>
>>> Thanks,
>>> Andre
>>>
