Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F19C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 12:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE2A82CCE;
	Thu, 19 Jun 2025 14:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z1QSY3CK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBE482CD5; Thu, 19 Jun 2025 14:01:15 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4E682CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 14:01:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso627884f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 05:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750334472; x=1750939272; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zMjOjNeoUy0D6o4cjzfHiWVhRlscHlm6T1/k7wYlQo=;
 b=Z1QSY3CK3w/uXDB9HrweYCPEeabwcOb1bQiROCW+kbCNBPJN8+K2GZTqWwV6W+/TO9
 ZNupw9CoFPEBz487OXCjhysDL4MSorwZaqgDi2WvdePs+haheLjSKFUkTBZqPQxeacOr
 n70PsfkHyLVksAf1M4Owmnets+SfkC43l5SB4wIUdpnOJrKQ4k1b+zDwl8UjbyNuAtH+
 JBfXYVptKqPKBHv2Noe0HCQsXiZdSRfxE+wxQYGBqDv/UEN8wyfJYVI3j7ABNZtzXO2s
 F5ZeDJ8fGrQHuL8k69MHk3laTr86/tNa98l8SXLSKA/Qk6Vp6j7xBFTiyJzXoJ1tyj2o
 J7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750334472; x=1750939272;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6zMjOjNeoUy0D6o4cjzfHiWVhRlscHlm6T1/k7wYlQo=;
 b=HLvuTcMBirDAgEAOlNFmp/dYg9Aweph/XWqxvZLZT00700+T0PIQpe3UJ51eQoCLKd
 jD0iRSZDuKETXcj9vgeEVwgGtMahAqBrCL4JWRRIdSPVj/M48AfKm/shnqur3i6hsdv9
 mN3rYw/ksJTCPYeV5ujLzbnR0STHl3+W7wpW9kNnFmTtOP2+5u3DjL3r/8oqKrxHFCnp
 T7Vt65hOL+ST+XBD+R3pxgz6UFQHdxca9ou9jFWgjHaCPdfmJJG7f/rNxGN+UtqMcQPn
 jM3Z7jUtIgHPME7oVo1zNYpPbW5ykmdYCaE8ymKvM9l+dimx7PyRVSR7EVsLZKeGCKew
 0hOw==
X-Gm-Message-State: AOJu0YwmeRC14xdMXGlDh77+xA8Zz9DcinHxijORDsSJp/9nko0qkoyZ
 PZ44EXam+P1/mFUro+kFVycwyyrXxtPSa4wQagkjpYqhOYoQZ7X3dmNz/Hlmyi5ae2arJAlfF0s
 js3jaOL8=
X-Gm-Gg: ASbGncsHd5EosfQhYDCclGz8dxN8Ga2T6vcWPyNT2tHCMY9PIVgyC8aiqJg78UC8a+L
 VofawEGwoMJbpWi/lQ4SbnFhoCw7GUVbd5FLAEHSvRjvchUL8w8Vh7KXhZErnVQwjhEEwUpmNtF
 NFagFg2guiWlN6Uu5HqhXBQ4FGWtW7rOywU8aN5pPwRz6xpEK8WxZXm2GI8//k6t/6MTXjVMKe3
 pe/tpsi24HjiDX+39MYTEb8jOFU7EOwI11gVALCl9sgCAWCj09KLEayMT2xfaCn7RR7fuHV3ERI
 mE/WJaS+EQZrjvETv463pQHyVV7PMYnZXTEdDgQOubfdq9lgv19LZJLdKsadzLLLMyNi+j+DZo8
 mUsasCJ56VWlgB94BbkuSlvGeGoNYwbvrTeOPnM0ckw==
X-Google-Smtp-Source: AGHT+IHeSPWHgMESPo3DsxubJMI6Z/KAPgHcIhuxSIbOS2GbuDX5NlgoqOH0Fxeu5VhdTeAREjr/VQ==
X-Received: by 2002:a05:6000:188d:b0:3a5:2875:f985 with SMTP id
 ffacd0b85a97d-3a572e5858amr18750023f8f.59.1750334472192; 
 Thu, 19 Jun 2025 05:01:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:cf2f:b483:c307:5b0f?
 ([2a0a:ef40:ee3:2301:cf2f:b483:c307:5b0f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b28876sm19296350f8f.73.2025.06.19.05.01.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 05:01:11 -0700 (PDT)
Message-ID: <56eec040-4f67-4b92-9736-eba5883d182b@linaro.org>
Date: Thu, 19 Jun 2025 13:01:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [RFC] Using Smatch to find bugs in u-boot
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

I have begun to run Smatch on the U-Boot source code. This is showing up 
a number of different classes of issue.

1) Inconsistent indentation.
While I would like to fix all of these reports, they are not actually 
causing any bugs. So I am going to assume that in the interest of 
keeping churn in the source down to a minimum that these can be ignored.

2) Warnings about large usage of the stack.
I am going to ignore these, at least for the moment. It would be good 
practice not to do this though.

3) Uninitialised variables.
These generally result from possible but unlikely code paths. These 
should be checked though.

4) Possible buffer overflows.
Most of these are probably not possible in practice but Smatch has not 
been able to absolutely confirm that. Some however are going to be real 
bugs. These need to be checked.

5) Ignoring unreachable code.
Mostly this is deliberate (if unnecessary). Sometimes it is the result 
of config choices. Also used as a way to disable some broken test code.

6) Variable dereferenced before check.
There are instances where a variable is dereferenced early in the 
function and then later there is a null check for that variable.

7) Always true or always false tests.
eg checking if an unsigned variable is negative.

8) Probable incorrect tests.
eg use of && instead of &, etc

9) Other things.

I am going to follow this email with a sample email that can be produced 
for one report that I believe shows an actual bug.

I do not wish to swamp the mailing list but I do also believe that we 
should be aware of these issues and absolutely must resolve them where 
needed.

The code coverage from a run of Smatch depends on the platform chosen as 
the target of the build and I am never going to run all of them. But 
maybe it will be possible to run at least one build in CI with Smatch 
enabled to catch newly introduced issues, at least in those areas of 
code that are used in that build. It would be good for all developers to 
run Smatch on their platform builds to broaden the code coverage as far 
as possible.

Andrew
