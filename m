Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B9BF3C25E
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 13:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1450D83BC7;
	Mon,  9 Mar 2026 14:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gvzeVR08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FAAC83BC8; Mon,  9 Mar 2026 14:45:53 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 967EB8063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 14:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-40946982a78so2656712fac.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773063949; x=1773668749;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZjMWnKxImElQ5a3jnG2/GT4tMQ+YAcOZQkBax6okrT4=;
 b=gvzeVR08a1MJat2C3UQ5215Tfb4uK3VKGHegLZIok70wufG/RKS11bdkdQ6xjJnzMb
 Y+CPan0FqhkJ2KwJ4vIkUnbjxAo0Sdkx5uogfKDRCPH9JqAMx4Bfvfr2EJ/5gHSKaI2F
 09aau5QvtGkCfd59J7O5EynCdm2jdUmzo9E1Ew7cBiWBF3uJ6IBzvWERJ9gkC0hgEq7Z
 ElOgjN+S/TRo7IA7FPvaMsXD6BmKSSr9RRt/oQ9E3NtqX6iDnnYKalb5pAJ8Jk7OP3DC
 t1r8c22OhareTeMWSBkG8FjCeS3DQcw6keGGQkoU8BOJ4HZkGRyRLnIImgSz5Ct13+8j
 ZnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773063949; x=1773668749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZjMWnKxImElQ5a3jnG2/GT4tMQ+YAcOZQkBax6okrT4=;
 b=cTEeaDlfWO3vocKtLqGhGZ8CpikpXeduzvdizOOt9r/OZ4eQP9q4LpziPp85VI3rFG
 42jWOU/RTnBv1A8KAG/drmjMzIuThTLIaJynCRR5P7+xRWH8wfuxP8ZhUGQFQiHBR/VF
 5ATMGwqaS1vRcGe5x8Hoq4aTpt1DCOR2bZySpEpvjJuIEs2A59U0xubBb9dsLqFCmn5O
 TY1zcfyVxGMTQK4kQRjo1n5IrxdGn8OCanPjhHRR250JhdZRN69guA6KWm4bUeU/Cvm3
 U80Idak0ZxbcvUp2vWPLkJIEDw19KV/MJ29zNlTuMH9XLOLRE87p3doKzheO0NuN5VNd
 t0jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaCVZKmaiq2o3GjEtLLItzGViDxyhA/929Mr0BeN47+OouEA4BrxymHmYednvnUr2z/lOzny4=@lists.denx.de
X-Gm-Message-State: AOJu0YzMsqq1Ey1BGEtdU8qqdNzdA8AhfCLsynPvMY/I1e3HH0VF5gVY
 0s9k/HTwYf3t0Ka1JYYFvjcfiKhJsalAiXH2t9xmR3DHFYlVCCrYnSUWYSwAvGm9yh8=
X-Gm-Gg: ATEYQzxqXQQFUdhXN/bSDLt3MdeLMmHNK0f4cVqjbCZS2gCm4BOPKNiGWZNhXiy42Ku
 slrFPTEMNPuD2mJ7+yxk4mZxl58btWzKUb1KYBB839u45pfkoVhCybwoMubtmNbv72bx3DFOSaO
 eknRO7Byjyf38ZDIUUBRxFt+8NFzpIwRR0n17GjgU+MJ+zMskTaCGHmaqLoo3OKA4UXGYHXN/GT
 yp3f0miWMvjjAcwnDZ5+mht6mFqvni7ujmPxU3ilzz8d98+/849QUkDDI4d1cwG1dKp/kwbo3v3
 l0O3bnePOtWzK5e6y4y0gi6iXVKChne2ka4rvo923C4sCd85wlG82i9QRWU2X1zyAzQr3wkg2eN
 QYb9qrlL0PLnLnQ9hdVlVCfWWtfNopZXCiQCjitiXXXkGvIBBi8aykoQXsByq4QzQScv4b4HhQ+
 lJMnu47MFwzXYr41wLMAeabyAwziNHCG1o44wripacO61AHMRMHCDZOPy4V16ZjIxgYwOA
X-Received: by 2002:a05:6820:4dc4:b0:662:c7a9:bb14 with SMTP id
 006d021491bc7-67b9bd1b23cmr6851933eaf.35.1773063949094; 
 Mon, 09 Mar 2026 06:45:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:77:c35f:9c1b:c75f?
 ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bb666de5bsm1094094eaf.7.2026.03.09.06.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 06:45:48 -0700 (PDT)
Message-ID: <d3c75072-46e5-4570-96a9-6d23ef0996a7@baylibre.com>
Date: Mon, 9 Mar 2026 08:45:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/buildman: fix missing :: on examples
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260306-doc-buildman-fix-example-format-v1-1-fbf955d39a2d@baylibre.com>
 <40e1d392-3745-413d-b011-1fb58389b0c2@gmx.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <40e1d392-3745-413d-b011-1fb58389b0c2@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 3/9/26 7:50 AM, Heinrich Schuchardt wrote:
> On 3/6/26 20:52, David Lechner wrote:
>> Fix 4 instances in buildman.rst where examples were missing :: for
>> proper formatting. Three cases just had a single : and in one case,
>> : didn't make grammatical sense, so it gets a stand-alone :: along
>> with fixing the indent.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>   tools/buildman/buildman.rst | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
>> index 9e850b26ec0..a2061715788 100644
>> --- a/tools/buildman/buildman.rst
>> +++ b/tools/buildman/buildman.rst
>> @@ -146,7 +146,7 @@ the '&' operator to limit the selection:
>>   - 'freescale & arm sandbox' - all Freescale boards with ARM architecture, plus
>>     sandbox
>>   -You can also use -x to specifically exclude some boards. For example:
>> +You can also use -x to specifically exclude some boards. For example::
>>       buildman arm -x nvidia,freescale,.*ball$
>>   @@ -970,10 +970,12 @@ a set of (tag, value) pairs.
>>       settings file. They can also be useful when building U-Boot against other
>>       open source software.
>>   -    [make-flags]
>> -    at91-boards=ENABLE_AT91_TEST=1
>> -    snapper9260=${at91-boards} BUILD_TAG=442
>> -    snapper9g45=${at91-boards} BUILD_TAG=443
>> +    ::
> 
> Thank you for addressing the documentation issues.
> 
> In the documentation we tend to prefer syntax-highlighting.

I used :: to be consistent with the rest of the file. Should I change the
entire file to .. code-block:: ?

> 
> .. code-block:: ini
> 
