Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2041BD31A29
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7174A80C93;
	Wed, 14 Jan 2026 10:44:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oFpeiajM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E617483015; Wed, 14 Jan 2026 10:44:36 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6383F808AF
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 10:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso67173875e9.3
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768383874; x=1768988674; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vZ2257E3743K0iNjIaVEgMNYCMLPBcwsKylHjrqVuDs=;
 b=oFpeiajMG2tBQh/zbcoIvUbbUgkAu5OGl6mI00fduewFQmZQLU7dqWquNw8B7AV4dO
 EYl3X7vx36v3iVgjpO/bxGy5QEmVvKZoxF1VDGRH0o7b8KWp747OK4VUu2HfLIUTnhyc
 tre/Lr2QFKpTT3T2reQ6m8ut/0tdca/242HWI9O5PwKb1sWeHPj1rsrEH02YOobSJ2cD
 rGizeihcigyKA8rzQk+GE5DrvnZrXiAB5MHEzPg72zhJi2K71p6TNR/4ltjDLnM2IlXm
 KqkNdS5a6LxhCpQhGU7GdWVZDM2fSu/PLvu5okylXUmVV9I3CtXfc2nHvmrWO12OyYhg
 mPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768383874; x=1768988674;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vZ2257E3743K0iNjIaVEgMNYCMLPBcwsKylHjrqVuDs=;
 b=Wq2NHy6uzSB8XuX7UXdrdIzgfOAT0J266DFZYuMJRipoYGypw2tN5bAiTGWPHOi85d
 ZHmTQwPkdm4v0BvPOvUVEuySlwSXcprlb5tpCNu6OLwNR6z+keJnyiYI+FpOlT5A1yhi
 2fzDUk/WE9sFLMe6vtQCFFz1YK0kmGrFl7hDct403x607DsGRhgBmXgXiDmwLKFb4fOi
 z699v0mp37xW5lfgDpVu0DGT8JrrBvSqpbVKG2MaERtGQB9M+aYCWxyFaKJMdAoEsQ6p
 A+nmbp28QMk84wJ+6ke9Wojwvp7YzmBRcqzokHxzZ6w3SYTtciUJ6ZPIqhmW4epM87so
 kInA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXlPUEc3DohPPOOcr1G/Kf7GhyLE6Gnp8UwU2ZBLRp+9ABN2Uv9mC7WFIQ5BdwvWcH02em280=@lists.denx.de
X-Gm-Message-State: AOJu0YzUcF3nahAjF28fK+qS0iM3Qu6yJ2jso+eIQpH7QglFmQwt390A
 TpyIMoqVveHxlDPIVc7lwb46bpqSKmD3fsLAem5GMsDTrljINrs5oMn+w2oTZ4eNxVU=
X-Gm-Gg: AY/fxX6zyQ9Vmg5kTayIvQZAh+9BRd5sJ37wQFjCvnYOZE1SGqjkeqsI/+hsbCXPSc5
 PtDmPJIaiYrqBj31f6xde0hZOkJDPbQks4MqhDjb9Oi8m2rCHcM+jm+0iWH4FKqb0AfkHalf9El
 epkjnHuDl/cDSX3vTXYvr7jNk8YK71oHft2+fmoX5GDAj1M8yXbal0FcAtwkiF8jLN54I3gU9Rq
 jPHkNeyarb/hY7YhNDVyk/TO318877VJrcmy/rck+M1bilInebZZ+aMDE3lec7YJWgNLC9Ttbek
 cn9mpVy1B0CFVIcCMiw4NWKzRLrhKD+iv4QCGNs9u33TF/nzforEi3OSP4wFlq4OXsJNeq1aqeF
 FF9k9aAAST8TVmZj7bNotQA0ywGyb8+1cWmbr630tTFAjEc74iVjCI81ymyEMaIUJ/avDPp5y0J
 TGZqMhfUPc6ThMEtnF63B5lkT6kRV47FmOTcUYkEGXI28S6I4F4YU=
X-Received: by 2002:a05:600c:4f0b:b0:477:c71:1fc1 with SMTP id
 5b1f17b1804b1-47ee4819f30mr14526185e9.19.1768383873667; 
 Wed, 14 Jan 2026 01:44:33 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee55d4279sm19664155e9.8.2026.01.14.01.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 01:44:32 -0800 (PST)
Message-ID: <a2ffcb48-3993-42ec-be1a-3f0b3c0df942@linaro.org>
Date: Wed, 14 Jan 2026 10:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mach-snapdragon: Add OF_LIVE device tree fixup
 infrastructure
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org, rui.silva@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
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

Hi Aswin,

On 13/01/2026 12:54, Aswin Murugan wrote:
> This patch series introduces a comprehensive OF_LIVE device tree fixup
> infrastructure for Qualcomm Snapdragon platforms. The implementation
> provides runtime device tree modifications to pass platform-specific
> information from SMEM to the operating system through device tree.
> 
> Qualcomm Snapdragon SoCs require runtime device tree modifications to
> provide accurate platform information that cannot be statically defined
> in device tree source files. This includes:
> 
> - Board-specific identification and variant information
> - DDR memory configuration
> - Hardware subset parts
> - SoC-specific device node adjustments

I have to be honest, this is a lot of words to not really explain
anything. What motivated this series? What does it actually do? Why is
it needed?

This applies for the individual patches too, the commit message needs to
contain the context that isn't in the patch itself.

OF_LIVE refers to U-Boot building an internal representation of the
devicetree (take a look at the git history for
mach-snapdragon/of_fixup.c). I don't think this is a relevant to your
series which is modifying the FDT before the OS boots...

What are the DT nodes/properties being set, how does it look in the end?
Are the bindings for these properties upstream?

I think a need a better understanding of this before looking at the
contents of these patches.

> 
> This patch series depends on the following patch [1], which adds the
> socinfo header file.
> 
> [1] https://lore.kernel.org/all/20260106122134.2047864-3-aswin.murugan@oss.qualcomm.com/
> 
> Aswin Murugan (2):
>   mach-snapdragon: Add OF_LIVE device tree fixup handlers
>   arm: snapdragon: Integrate OF_LIVE fixup handlers in ft_board_setup()
> 
>  arch/arm/mach-snapdragon/Makefile             |   3 +
>  arch/arm/mach-snapdragon/chipinfo_def.h       |  90 ++++++
>  arch/arm/mach-snapdragon/of_fixup.c           | 114 +++++++
>  .../mach-snapdragon/qcom_fixup_boardinfo.c    | 228 ++++++++++++++
>  arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c | 214 +++++++++++++
>  .../arm/mach-snapdragon/qcom_fixup_handlers.h |  70 +++++
>  .../mach-snapdragon/qcom_fixup_subsetparts.c  | 291 ++++++++++++++++++
>  arch/arm/mach-snapdragon/rampart.h            | 236 ++++++++++++++
>  8 files changed, 1246 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/chipinfo_def.h
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_boardinfo.c
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_ddrinfo.c
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_handlers.h
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fixup_subsetparts.c
>  create mode 100644 arch/arm/mach-snapdragon/rampart.h
> 

-- 
// Casey (she/her)

