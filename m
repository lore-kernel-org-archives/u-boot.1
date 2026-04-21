Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652FDF94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB99983936;
	Tue, 21 Apr 2026 23:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dD/mhDTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B468D805D7; Tue, 21 Apr 2026 23:08:04 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C53B83FFA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-464bba3a9easo2468918b6e.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776805680; x=1777410480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfiT474GCtoRdL9h9OWN+e0c/mgRZ3PdHqfHNbiojsc=;
 b=dD/mhDTITnfc+d20MECNrBiFzjf/B44YvLtb9rJGuniSVZQxca9ldGRNNrzF/LW4lz
 sy6a7jfT0RVCIiTGsNdW7CP2CPDEVNR0MqH6y1wgtldgzPw8BEfDSYGk+akdHkU/wQgl
 Ji9I5ZfpcbEBeK2lao/WOmDc5xQKAi2wPbwXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776805680; x=1777410480;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfiT474GCtoRdL9h9OWN+e0c/mgRZ3PdHqfHNbiojsc=;
 b=GC/MKSToMiLvjoG/vcfgK8/dSxpD0fcj2EILDIYAvKS0OTzMne9tUwghUwxp4yS61K
 b+TT8BKDik8YZwn5NfrfXowlc8LRzhRcsypVEdfRHLBcevcA9KUuPn3Of8wky8WXTboO
 cIlQUN2Y8tgepD4PL6msAzFz0dPVOJRXrIvVJVvoMIq6H9jKwGgdzLJ5L9d/nXCxxco3
 D2fG/0YHYdnZak8hFWxf2pP/oMsAzbXkmsDJZ0On9YrFT+yVqOWjH5U+tyhHdTAo/fLF
 vh5frcQyuiDdQEDskEjy7v2JCBZ1vwnzNCo9tTbULjImok8LluEhji3r+sHqFBKmxW4S
 hF6w==
X-Gm-Message-State: AOJu0YyNhexftf0zmfydZaENlgs9+4WEY1s5C7fcUr9X+W9DaSJFLm0v
 UW00BhDDwkQ8RF5RI55UjAoOV3cUL7hJkpvuyBrMRaSTxe9Hn1NcJvoz74rnCp6Yx78Wz9CDpa8
 j7ulxXMuOfSnA
X-Gm-Gg: AeBDiesKtO2R/ElK1XDbYbOqT4K+Ghoeyon10LPkm5e/JxdKs5HFbDgYIOSyLr8OeUw
 IW7EoeOAKE17TJR+HBJzMBrAUVCm6eEQrcqCRmk4MooziKfyOQrAfdAVV/1Gehp2CIyvyQzmxEi
 YgOpDJIgf8wM4F2vTIIsFB6Arqp8tD+IKH84fe+5AXgwMj6hEcabYgrkFfqbagC25SkubHnVw/q
 AkVQnzLeyCpoFFlUuQxPBYuOqfKK1tdY2hC1soEjKDuz3gcyQ1vt/YYB7S7lgHmEZYyFuOBULzc
 YfQDluTTZZth/y1o8wdt6mj4M/Bb6cV1uaXXLCpKWykRVIhj3U3UVLas4o/87a2hje2wDQeAPR9
 ArbYvkTj3rJWeUvkVP+pEsuQZuAqh9nX9rrzgcYKqMS/053szi4Skmn+Rtmk2W+dLBnpNTWI48n
 ihVgK3h6YRYTh63Uk2h+OlxHmj+2XklJA3xlAU6gUnFBW92w2v2VxuKgMJVJXkhgs69jlP8EQj6
 p9ez1n2weT68xFmtDcNjEaCX3Jybw5K+x13b6sfz4ExJMfCUuQWVqLdmrNt65/J8/EKbPw=
X-Received: by 2002:a05:6808:f06:b0:467:1462:a9a0 with SMTP id
 5614622812f47-4799c8f26e1mr13168688b6e.15.1776805679806; 
 Tue, 21 Apr 2026 14:07:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4799fef6dd0sm9906474b6e.5.2026.04.21.14.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 14:07:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
Subject: Re: [PATCH v2 00/11] Linux compat improvements and CCF prep
Message-Id: <177680567878.1614595.5749756722621920940.b4-ty@konsulko.com>
Date: Tue, 21 Apr 2026 15:07:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 01 Apr 2026 16:15:16 +0200, Casey Connolly wrote:

> This series implements various improvements to Linux header
> compatibility, largely in preparation for a full port of Linux CCF but
> many of these changes would also be helpful when porting other drivers.
> 
> Beside the basic header/compat stuff there are a few larger patches:
> 
> Patch 1 adds the "%pOF" format specifier to vsprintf, this behaves the
> same as it does in Linux printing the name of the ofnode, but notably it
> expects an ofnode pointer rather than a device_node.
> 
> [...]

Applied to u-boot/master, thanks!

[01/11] vsprintf: add %pOF
        commit: 968164b6863e3a75fb0f5842f4f1cab9ac7c8c36
[02/11] common: add an option to skip DM pre-relocation
        commit: f5e96fdffc024552944776848bd5570e1b2caa9b
[03/11] string: add strdup_const and kstrdup_const
        commit: 139f5292e7985d0326a1d18eee88720255e423dc
[04/11] ofnode: add read_u64_array and count_elems_of_size
        commit: 45c610d718bd605a1b3bdf99ec0386620b54b559
[05/11] compat: add PTR_ERR_OR_ZERO
        commit: 3f6f674b4a5653eb7223645be00ddb82368ddb33
[06/11] compat: add kref implementation
        commit: 70b55377553403932cb37cc530433aaee6ee41e0
[07/11] compat: add dev_name()
        commit: 8e0ed228d8b062690365e439fbd40f1edd34780a
[08/11] compat: add linux/regmap.h symlink
        commit: fae701400dd040165d713993b06239f3b4dcd9b9
[09/11] regmap: add regmap_assign_bits
        commit: 6c11994b7e7b324ea41e6d62e9a73dc430ea0df8
[10/11] compat: regulator: add enable/disable macros
        commit: 076265b75e61f56490003639b3d0a6483a9f507f
[11/11] compat: math64: add abs_diff()
        commit: f1f4a1d1d8355b0fc6bfc82d9ca6741a8e92623b
-- 
Tom


