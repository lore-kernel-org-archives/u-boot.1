Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F508D1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 13:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D97788EAE;
	Mon, 28 Oct 2024 14:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EYCzsM/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAEDE89066; Mon, 28 Oct 2024 09:58:31 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26259885F4
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4314b316495so37851845e9.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730105896; x=1730710696; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WkUBJFRCBuUho7jm0Ymj5Pzfc1LGJD4YCGB3NLIh+YU=;
 b=EYCzsM/yaA112Ee/KRL5VjFTUrk1SM2sWZUpDj5h75SHnJqTguwzrZh36VOOstD/XX
 9Hx2WUTdDnaAGNHHCRZ2Gg1QhXLyOpv1+qvrGbVS3Vtos2+Yjj00QTjgnOBhD+3GSIK3
 owEY8dZiMkc9jIThCb9W2RU9GFDZ7aw/qRHj0/AphpIYcsjia4ml+45hles2WEFon1lL
 P1uhEjXz5jIJ4mNfGiukvPF4AghIYD9bmFUBoLHeIixcui9/vChhhnGvZ8fznIEaIa3s
 fsfuUxu+W3ksKmNDiUI912gh+BOU2erW/TdYTjRVxOCb4mkiHzumqwmUZw+iYOMgni2o
 mMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730105896; x=1730710696;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WkUBJFRCBuUho7jm0Ymj5Pzfc1LGJD4YCGB3NLIh+YU=;
 b=WRXhfnnESipWkVBkNAHIZqQ4AG1jZJmVw0n7tyGvdcptKZpqosiGHuCreNsnCUl53v
 +iLPUUz/gbvQMbcqOMA91DroscIyYVhRU4u6jVTFBL3cfr/SM1jcnY4rywQcB4RSp7q3
 aRx+ZQRXbCmixSJ4f3RxV93o3fOEtpvJOJoCeG66hcktAFrEFCxYLSyRjaeLjCn524hl
 1QeeZ9crn46zlrmpZxKIPjG51g34RQ0z8N3W8LmKSf1128st+0w9YzYBSXH7XCB6MDUm
 +1u/PUnx3K6LqNedZBaf4TtqkgO7BgSjUCGvfq4lkv4txRcNicnH7nL4qWoXQpfjxPCC
 Z5Ng==
X-Gm-Message-State: AOJu0YxOHFau2rqQhY3vYVV4tzCcPV0lkAkXJ188uVkV7t/WMU9GI5ug
 HUVe6+SvumaUqTgcCkUbfjZL+edDvKt88rMILBGpAOsNO0YiTMVX
X-Google-Smtp-Source: AGHT+IGBMXM1fsM9jil8FXNcCAjydx92RZNYYm7ipQeernobDua4lBxptP9kbnDNn1b5JPg7OHV3mQ==
X-Received: by 2002:a05:600c:b94:b0:431:5a27:839c with SMTP id
 5b1f17b1804b1-4319ac74328mr63129915e9.5.1730105896354; 
 Mon, 28 Oct 2024 01:58:16 -0700 (PDT)
Received: from [10.136.20.160] ([213.164.76.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm102119065e9.44.2024.10.28.01.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 01:58:15 -0700 (PDT)
From: Martin Stolpe <martinstolpe@gmail.com>
X-Google-Original-From: Martin Stolpe <martin.stolpe@gmail.com>
Message-ID: <170fc7eb-4106-4115-8a2c-ed59b01dc08d@gmail.com>
Date: Mon, 28 Oct 2024 09:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rpi: Only add frame buffer node if
 CONFIG_FDT_SIMPLEFB is set
To: Peter Robinson <pbrobinson@gmail.com>,
 Martin Stolpe <martinstolpe@gmail.com>
Cc: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <20241023131012.2445564-1-martin.stolpe@gmail.com>
 <20241023131012.2445564-2-martin.stolpe@gmail.com>
 <CALeDE9N0_ntH1cU5SKQmN9SQEW6uPRQnKHRd90tp7N+H0HO9Ww@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALeDE9N0_ntH1cU5SKQmN9SQEW6uPRQnKHRd90tp7N+H0HO9Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Oct 2024 14:32:38 +0100
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


On 24/10/2024 13:29, Peter Robinson wrote:
> Hi Martin,
>
> Is this a follow up on the patch [1] you sent a month ago? If so it's
> not really a v1, and you should add a chnagelog as to what's changed
> as well as cc: the people that provided feedback.
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-September/565514.html

It's related but I would say it's separate. The problem before was, that when CONFIG_VIDEO was disabled and CONFIG_FDT_SIMPLEFB was enabled the compilation would fail with the following error message: undefined reference to `fdt_simplefb_enable_and_mem_rsv'

This was fixed by making CONFIG_VIDEO a dependency of CONFIG_FDT_SIMPLEFB in 392ff1449f7d30cc48fd4d17320d05882cd68f2e.

What this patch does is fix the following compilation error in case CONFIG_OF_BOARD_SETUP is enabled and both CONFIG_FDT_SIMPLEFB and CONFIG_VIDEO are disabled: undefined reference to `fdt_simplefb_add_node'

BR

Martin

