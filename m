Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6842FC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5FA8317B;
	Fri, 25 Jul 2025 15:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GsD5zANJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5888397B; Fri, 25 Jul 2025 15:17:58 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A5AA82F49
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7788749b0so167200f8f.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449476; x=1754054276; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwDbATTvX5LG409aMJGlfVkOu6BvEtfOxMCivyLQCh4=;
 b=GsD5zANJduzmgL78jdT1INmkZA5aPEQf39YW5Ijd/cMvdxD2KvOrCM03sRDDed+YDn
 ugsT4NwA6sxhP9kSWRdkb5xmap4fPTpKd5m0bf0KHaxAfy0+mPpNrOYvVkiVsoI8yCl3
 qPYRZoh+u7nTtW4h65riuZU5q0bZ5tQZ9d3SWiTII0u82MDGt469wjAmtthgNhrQnZS8
 B8ir2C0PqoUsIzaOUSBHmMrlvH1UwX6a30jZnhdibl/zkSUY3iTfilmWJf1WoTbzCckt
 xps9YP34Q8L/xgPHZwmz2RzVYPQR+jm3mWw+ONFmnjIlATs1d2mP+TNerTgy+nbj4PaN
 Ffkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449476; x=1754054276;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IwDbATTvX5LG409aMJGlfVkOu6BvEtfOxMCivyLQCh4=;
 b=YEJqJq0fzcdjapX4ImF1aIpZjAsGYhigRY0XvnBNEyJQ4vc+91mSpugE7hrT1cUPmZ
 muMAydzAm6XTXT5C2tgsniGGC58hR4WOasbYzEXOx5rtpFCtNXEHuSBwzEuxdV3c2Vnj
 KBGAW+tdallGAYPS2zmxNHx/e99t6aWb5Jnyt/87XwktFua40MgclMPb2B0D8xMZWxvv
 CxoxANNGb/WhvQfwi14WkHOLp7pVWlMhaRsJeS3GHXRnIFu61H5VFJcw5tj1Y3ccGory
 ORY/MepnlopWWlHjZOTlV9Mo3U7tooWo8fPVfmtKJL/QX2wNLpu6Kforz2ZFCOklpU0f
 zLHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/U1QiI0liVSx2aNWMzmPRxGTwPD6n+XUYuzgohRwHcFgEA7U49Sv/Mrg+YolDSBzqy1L3tls=@lists.denx.de
X-Gm-Message-State: AOJu0YyXqx5IHqnfwx3m8oUEwuySWEk7jWfFZiwAsDdonadNmSozlEqd
 CnBn5z2u+PzAUJgWQsnqrZrwitakmSKVqZi/LoZK54URj5mJn5QzWEKz5hAiS6qprYE=
X-Gm-Gg: ASbGncvffkkhJoVfYAqdMumL+H4ua/nAV/Z8w6D0yDVcXZC3zPJk6f3Mgi7e+ZJJA45
 xgooxkBKStaXotpvflb0znallewZTztEOf88OpkcWjVfGfkPPVGpqZGzwib9K3h6unktL3iN4FS
 i9iIRo5HrhX8bkyLG57K34HITLV4YfWSA+L7G8XQvW/CXlPSztlmhiiFCaDAQlEb++rauMixBaC
 pt5uaIOSwYdNS3GTh0r8ipgbr/by08FVlf1X54zirc0+/N6EkiUIFrDzYOmRbRYxxx3irH1N6+f
 dsqxPYxwMRjzG61R7FhWyw/fwDV7T9n2BcZe6DGxuY4GkgbQH2eJ6wzwhOXsXG+hcxGuCZ9yUtJ
 EkD1yK7Cs9nLlkdHXoKBomytF2oyg4gsvFLyTDA/5BdL5weH1sZ4J2tFQe+XS/Hk=
X-Google-Smtp-Source: AGHT+IFQnWsg/M3BFUrQa1WKFxCcurrZ5Ei/OB23mYWK9RW8lA7JdD7/UO3MV+dF+j0hfpKZC0iuMA==
X-Received: by 2002:a05:6000:40cb:b0:3a4:ee40:715c with SMTP id
 ffacd0b85a97d-3b776729220mr1919572f8f.14.1753449475656; 
 Fri, 25 Jul 2025 06:17:55 -0700 (PDT)
Received: from [192.168.1.37] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcb83dcsm5092179f8f.58.2025.07.25.06.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:17:54 -0700 (PDT)
Message-ID: <3fedb4bc-33c4-4e93-8c5d-c30ba77868fe@linaro.org>
Date: Fri, 25 Jul 2025 15:17:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Improve EFI partition matching for capsule update
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On 24/07/2025 11:00, Balaji Selvanathan wrote:
> This patch series improves the reliability of EFI capsule updates by
> fixing issues in device path matching and partition name filtering.
> 
> The first patch updates the logic in find_handle() to correctly match
> device paths when the EFI System Partition (ESP) is a sub-partition
> within a larger boot device. Previously, the function only compared
> paths when the candidate path was shorter or equal in length to the
> input path.
> This caused failures when the ESP path was longer, as is
> common when the ESP resides inside a UFS LUN. The new logic allows
> matching when the input path is a prefix of the candidate path,
> ensuring the correct EFI handle is returned for accessing the ESP
> during capsule updates.
> 
> The second patch fixes a bug in 'capsule_update.c' where the logic
> was incorrectly matching partitions like 'uefisecapps_a' when it
> intended to match only 'uefi_a' or 'uefi_b'. This prevents flashing
> to unintended partitions.
> 
> Together, these changes improve the correctness and safety of the
> capsule update process on Snapdragon platforms.

Same deal as in patch 2, this isn't an essay. Please refer to
https://www.kernel.org/doc/html/v5.10/process/submitting-patches.html#describe-your-changes

Specifically "Describe your changes in imperative mood", you shouldn't
need to use the words "patch" or "patch series". Compare to [1] for
example. Save the technical details for the commit messages and use the
cover letter to provide a brief overview of what the series does to the
codebase.

[1]:
https://lore.kernel.org/u-boot/20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com

Kind regards,

> 
> Balaji Selvanathan (2):
>   efi_loader: improve device path matching for partition lookup
>   capsule_update: fix partition match to exclude uefisecapps
> 
>  arch/arm/mach-snapdragon/capsule_update.c |  2 +-
>  lib/efi_loader/efi_device_path.c          | 62 ++++++++++++++++-------
>  lib/efi_loader/efi_disk.c                 |  2 +-
>  3 files changed, 46 insertions(+), 20 deletions(-)
> 

-- 
// Casey (she/her)

