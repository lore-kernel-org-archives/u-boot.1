Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1946FC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 11:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6FF8070C;
	Thu, 27 Mar 2025 12:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JJXjXA7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B24581951; Thu, 27 Mar 2025 12:38:39 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08759806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 12:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso8354595e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743075516; x=1743680316; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GzVEzvBRagy4siXBCt8+GU9fU67E9Vy8gCUJVn9zHJI=;
 b=JJXjXA7nV7rUqfay3yX2JwOiG8xFcfzIj+KbIGXO8/fIL+6rSDw9lhLXxg+Uhi7UYR
 fP9CFjzV79DTRPbwkiD74x+nnY24kvq3Rkt5Y2LTnhIcbt0blWNbXwGJ5MfYoRDvNan+
 avUGjuBGoFx79uZxP3LofrGw3Vq4GoSq2vafHcNgP+lTLUtG7uyXytfv1n8nvMEUg5Bm
 FJFIXWPNQrtfBJc0LwEWNysCb+NL6GHT90wTKfJYup3avSfDKaFoCzn4LliiIa/CbFjZ
 CXmL82sPBtV4lUxbrmIQ9nT5a+cmq4HbOejXdkctEI9xA1bLPBuALmwRQNMrD+w7hcV2
 VxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743075516; x=1743680316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GzVEzvBRagy4siXBCt8+GU9fU67E9Vy8gCUJVn9zHJI=;
 b=voZwUf15WSeCiY0Qu+Ai0bii0UNDKD+XI9py4HIZaOkyz+8BXpgCB/GuIAIrbXgU6q
 BatTR/jhbLgpokydzRDiSS8b8CivPYKaa6UUpXXT7XKIIL7HO/+QKvBD2MoTKQjHapda
 roOGf2DZKfxm791XsddF4e4b/vDwi7bKJS4kP2C8RzJoDURSntFMa6y+brLv1PRkC9Ex
 PHsm0W5xsjtUxaUYQi7sJiQezSV+H17piyZl0CqgXUge+RMk6VDhHO7UwlfeJy7m3by+
 HaFJ4z8J5qct/ZVt7uIyN0qsMZ2hNxnT56lmDMo+OjJJ0zoMLzusr14YXvF2K2Dx74Tr
 P5nQ==
X-Gm-Message-State: AOJu0YyqfiC+fhQC3nYyfaqj8725/jJzcvBLQsDM36WWeEb+KDEmsWvs
 4gnegoscBIdKP/ra2Cd4jwXF2EKy7jo8Cgow+Xvyo7L6eejmyBae6HIiSoBBS9eJ082MtRb+dF/
 b
X-Gm-Gg: ASbGnctW+eKGfxo97guUeWmnmP3TREMk6CH2agmqM35x3xTseV84sd9HiGRt0B56gM7
 rgIZx22SGFBbgnQvrCvLwvv6r/LEl7HyvVKNbepjM05CGfmaUYU+lPFRXbCqXeo2Gt2bAjbIge2
 0fSY95c+SaYtU3rR4AKD1qO5RJCbEWi7/c2cNAXJA4epdP3Y+xBbmEHo5sDiYqZFheZmgER9AMc
 fc8/ndEaUxn0BScFn3X+mD9ruMvaIpbfmJwOXp+TWX1BF3XNOgFXXX5WoQhSmQEAjO48eegjsLf
 qS5Nmr45915DeP7h2w3l90SVwtUe6HdjVOi+CBnW8YkCVyb2Qx/4MyQdD2TZweGYaNrF6U3EXYE
 wo1/OHVE0zgaBONT6Xkhiyj/S
X-Google-Smtp-Source: AGHT+IEB++Yu11nf3NcBDebtq4beKXeNHI3V3fXnYftF0IYAHYU+et1ps1ELOn4b4PBGFD1tWq7IQg==
X-Received: by 2002:a05:600c:3107:b0:43c:fbe2:df3c with SMTP id
 5b1f17b1804b1-43d85093c19mr25086085e9.26.1743075516397; 
 Thu, 27 Mar 2025 04:38:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e72:7f01:3990:34ea:6ba2:7710?
 ([2a0a:ef40:e72:7f01:3990:34ea:6ba2:7710])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d7bff520esm32421525e9.1.2025.03.27.04.38.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 04:38:35 -0700 (PDT)
Message-ID: <bb61fbd4-1a1f-4bfe-a81b-a81658add85c@linaro.org>
Date: Thu, 27 Mar 2025 11:38:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: undefined reference to `__stack_chk_guard' when building with
 sandbox_defconfig
To: u-boot@lists.denx.de
References: <DB8P193MB0710CB597A4A1F3C5E1A0CE183A62@DB8P193MB0710.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <DB8P193MB0710CB597A4A1F3C5E1A0CE183A62@DB8P193MB0710.EURP193.PROD.OUTLOOK.COM>
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

On 26/03/2025 13:03, McLaughlin Amy wrote:
> At my workplace, I ran:
> 
> make distclean
> make sandbox_defconfig
> make all
> 
> The result:
> 
>    LTO     u-boot
> /usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `pci_io_read':
> /home/mclauam/gitclone/u-boot/arch/sandbox/lib/pci_io.c:52:(.text+0x3d1): undefined reference to `__stack_chk_guard'
> /usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `get_token':
> /home/mclauam/gitclone/u-boot/boot/pxe_utils.c:943:(.text+0x755): undefined reference to `__stack_chk_guard'
> /usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `parse_sliteral':
> /home/mclauam/gitclone/u-boot/boot/pxe_utils.c:1010:(.text+0x898): undefined reference to `__stack_chk_guard'
> /usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `parse_integer':
> /home/mclauam/gitclone/u-boot/boot/pxe_utils.c:1030:(.text+0x91a): undefined reference to `__stack_chk_guard'
> /usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o: in function `os_printf':
> /home/mclauam/gitclone/u-boot/arch/sandbox/cpu/os.c:59:(.text+0xb3c): undefined reference to `__stack_chk_guard'
> /usr/bin/ld: /tmp/ccvKFEMH.ltrans0.ltrans.o:/home/mclauam/gitclone/u-boot/arch/sandbox/cpu/start.c:203: more undefined references to `__stack_chk_guard' follow
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:1766: u-boot] Error 1

See https://source.denx.de/u-boot/u-boot/-/issues/35

Patch was merged to U-Boot on 2nd July 2024 and is included in U-Boot 
2024.10

Andrew
