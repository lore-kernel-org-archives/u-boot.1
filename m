Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE675C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A1D83164;
	Fri, 23 May 2025 00:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C2jzn1Zr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984BA83189; Fri, 23 May 2025 00:07:11 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E468310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a361b8a66cso4329487f8f.2
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747951628; x=1748556428; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6U4rat/ve7QpA1X5OTk0ogx8n7MFINceNkbyQHb3Itk=;
 b=C2jzn1Zr3a8aOTi2vZ5i4l+uKh7yKEGFkcCx1QVr5LQzaezKkjxK3nWkIL6wNhNouk
 Zbdhbkphhw/pCZeV69tmfdu8q3hSV6uLR736JO1T1ysbj8z+mVju370F5mvozsPdCc/t
 I3tGus7egFpIwEZFkcoOJ1FuFWR3D1NEWi9rUMx5SpB+NiDeQ4iW6Kkck23hQ6fks3Pn
 4v/eHteKIwWl3u+7b1KVDAPFEJjfL2M3j3DKneYm+4Qtl4nPSXMZSsZU4SFZ307WschL
 7FTMCMqyUvBQKk3F5jzUQvwcdV0c/h9OFFgImlbUVGrJTGm2DHhriktlh4pKM9a/S3LW
 MW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747951628; x=1748556428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6U4rat/ve7QpA1X5OTk0ogx8n7MFINceNkbyQHb3Itk=;
 b=u8felg8Py8zlcgKvMvBbRFEIi/UqrfHSi/GOUS0l/RbdKidLZ/DLgWAEgtWuVM96K9
 4x3M5+BucSMc3OhV2bJv2SJW8S8p5AHi3Kne6RWAoINHTSetiRQ3F1JCTaJE3QgEGTV9
 a3xFCp2IUk6qLSldVE9mSV8pOYfkFRHlzUNq9cfccW+imJX3BpOvJmxgAsg/Sda7qNw5
 XNU4lp2+P6OMY7jisiPnJvUB06Emd2JNZN/cTfyujXkY4J1Ku7gQFpC9hT274Gu28s3S
 SpTeOukXpjtoOBBUGWrxLZXfwwJXlI3IvMl8qwtMc7u3Zj+dK7ashEm6UkR/YuyfjEtr
 VhKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOnRWy8D0I1xnqDPj3W1qw+HhzaIKBQfTNij711CtkODFn30+ViA2+Jcia6Jx+EI0aBtq8EtM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9O/GMNxj57aZ8T/qm0o+AcO+LVA4ZQbxn/8KsCJBtZeccR11E
 MoQYseDaffrMOQDveH0ehLuUubm4onPylgKPnuIKv64zWyFW6wEJwEbqPQvqRDgGwZDOOn7M/2H
 Ma48v
X-Gm-Gg: ASbGncspd6X+lTSZQvxoU2ddhpTMwvhCQdji//FYcxz7wUTg3gLdl6Hjd9nKHyL0562
 VRoTS7bpYGahsFm1VAW3pku3kIfM4govVBnQgmyk97NdYxFQWs1nhacinxcmS/GVqSD4mW9Zgok
 gvDTxbt2qFs3sysHLJczBMXoQwArikXYTjjzyFIq/tXvZNYpS5E6Ni1QoDxwz2w8HK4ojMekUDP
 kCfjIw/rJPNKpf2TCia9K8UD15PrXCcfPkmAwHw/J8loM/vdXn7pj1M0UXEKIOfmBoT9Lh3GUvY
 Jp9LyMJZw1Yey6U0tEI/f/u1UwaAz/azAaQvsWJ5yrAwkzOxUH8puQS0NuFUL+bpBkxgF76YccR
 a07E9
X-Google-Smtp-Source: AGHT+IEG1A7+pSU09UD7DTuju+5132pGLd5rcCx9iyJwoAU3UtnQlQWd24/V9afeiS4fWEZM4ZMrHA==
X-Received: by 2002:a05:6000:2012:b0:3a1:1227:149f with SMTP id
 ffacd0b85a97d-3a4c1faad5amr749053f8f.2.1747951628573; 
 Thu, 22 May 2025 15:07:08 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a362997dc8sm22629550f8f.46.2025.05.22.15.07.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 15:07:07 -0700 (PDT)
Message-ID: <00bc73ad-e17b-429b-9531-115f90508425@linaro.org>
Date: Fri, 23 May 2025 00:07:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Qualcomm: teach the build system to emit signed ELF
 images
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
 <20250522205100.GN100073@bill-the-cat>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250522205100.GN100073@bill-the-cat>
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



On 5/22/25 21:51, Tom Rini wrote:
> On Thu, May 22, 2025 at 10:39:38PM +0200, Casey Connolly wrote:
> 
>> With several new Qualcomm platforms appearing on the mailing list, all
>> of which build U-Boot as an ELF, sign it, and then flash it to some
>> partition on the board, we're getting a lot of defconfigs which just
>> contain a debug UART and a TEXT_BASE address. This leads to needless
>> rebuilds in CI of effectively the same image, and needless duplication
>> of build instructions.
>>
>> To address this, let's introduce a new tool "mkmbn.py", this is based
>> on the existing qtestsign[1] tool but is (currently) hardcoded to
>> only handle the Dragonwing and IPQ boards which use MBN header v6.
>> Additionally, the tool contains a lookup table that maps from a boards
>> DT compatible property to the load address it needs. Since it's highly
>> unusual for different boards using the same SoC to have different load
>> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
>>
>> With this tool in place, we introduce a "u-boot.mbn" target in the
>> Makefile, this can be invoked to build a Qualcomm signed ELF image for
>> supported targets.
>>
>> Finally, the defconfigs are cleaned up by moving the debug UART
>> definitions to config fragments (since it doesn't make sense to have
>> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
>> the qcs9100_defconfig is removed entirely since the same binary can
>> be created with just make arguments. This platform entirely lacked
>> documentation to begin with, which should be addressed by future
>> patches.
>>
>> The Qualcomm documentation is also cleaned up, a new "signing" page
>> is added to briefly cover the what and why of MBN signing, and board
>> specific pages are updated to explain the new build process.
>>
>> These patches have been tested on the RB3 Gen 2, but additionally
>> testing for other platforms would be super useful.
>>
>> [1]: https://github.com/msm8916-mainline/qtestsign
> 
> How much did you look in to having binman be what invokes a tool to
> do the signing? Thanks.

To be honest, I know very little about binman. I've done some reading 
now and on the surface it seems like it wants to solve the problem we 
have here, but I'm not sure it would make things here much cleaner.

As I understand it, I would remove the additions to 
mach-snapdragon/Makefile and instead have binman wrap mkmbn?

I can do this if it's preferred, but the abstraction feels a bit 
redundant in this case imo. Especially if it requires adding some 
"binman DTB" to tell binman which tool to use, we already know which 
tool to use because it's encoded in the make target ("u-boot.mbn").

>
-- 
Casey (she/they)

