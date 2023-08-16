Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F509C001DE
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 01:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810E486954;
	Wed, 16 Aug 2023 03:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="GOaiLvuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEE68697B; Wed, 16 Aug 2023 03:41:03 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD6DF867C7
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 03:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nable.maininbox@googlemail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9d3dacb33so93557311fa.1
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20221208; t=1692150060; x=1692754860;
 h=content-language:content-transfer-encoding:in-reply-to:mime-version
 :user-agent:date:message-id:references:cc:to:subject:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pi+CTNm5GI/a1DXlKUrbl9uMPbxmt4Zfhuc0YbPY9gk=;
 b=GOaiLvuS4qE4uMVHzb9/e5Lst6Kzs7QLyHGGJcTNGQ9h2Q2XyBsz2INoUWkEeGwGuy
 YhcvuI6i5z6PgX9WjfnOK6gKRS0qT1+r4u7sC3mp5LVdYGM8q1xwCh5rhynXHcOtJliv
 eorHmODZw7xjqNVpAy/5H262XL0bSUH1eFnZly08zTXQ2KO70urRZXRjnax69vV+tUdt
 96yuJXAfVLsswdYd8RgoxKvJ4PPEtbRtXD10tQiURfE4elHm8rVPKGIDm5NQjqgnwB2o
 5AC3Syw/VyqMcZUYz0wrvqXcJcUWCnD/83FmGM//dCmmhYtnykEy4ZVcVKIMFgg3l6Zy
 vHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150060; x=1692754860;
 h=content-language:content-transfer-encoding:in-reply-to:mime-version
 :user-agent:date:message-id:references:cc:to:subject:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pi+CTNm5GI/a1DXlKUrbl9uMPbxmt4Zfhuc0YbPY9gk=;
 b=Paq+vsi2IyojF0EWwiWUIke8uvk8NzZEuWPDbA01oxtyBdNCZdf6g8gxT7OQBVa8Of
 kStSszPc1ktPxuFNyeBqhwfGXXynhap9a62GTQ8gMTGJw3Qo2GvZgd0saTS57CW2Vlzx
 Nk/CSN9LzXuBoUBdFcunL5v3bf+lCGCHuuoE0MYzvYfkEFsNzRFZ9xh3CX115SAAVZHZ
 em4e3/ZDUsEvq0+5UxBw9yxGutbSNh1CelbS2QSGpKa4VjlMXWd7VZmMae9COkM8Ey6T
 XO+2YllmmcXcukM2Yn9nmNCxdLZpJEPCVGrrIxFfkkaQsw0EUWdbXPU0JJjqxSDD6ES3
 eoAw==
X-Gm-Message-State: AOJu0Yy/1sMy/37ajxz4yZOAoVLrI338gsKpWEFHQjyGM/BU9CdWDxyF
 u8sFTrnHhzNorA==
X-Google-Smtp-Source: AGHT+IFGv/bYMa9fllxXIIB5cTnRgpbamEGi1BM9elR8aS3Mqgmc8/JD7ju28HlSf+EnLKCECrR/Ow==
X-Received: by 2002:a2e:86c2:0:b0:2b6:c528:4940 with SMTP id
 n2-20020a2e86c2000000b002b6c5284940mr334769ljj.3.1692150059758; 
 Tue, 15 Aug 2023 18:40:59 -0700 (PDT)
Received: from localhost ([93.175.20.27])
 by smtp.googlemail.com with ESMTPSA id
 x16-20020a2e9dd0000000b002b6f8d07d30sm3233635ljj.134.2023.08.15.18.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 18:40:59 -0700 (PDT)
From: Nable <nable.maininbox@googlemail.com>
X-Google-Original-From: Nable <Nable.MainInbox@googlemail.com>
Subject: Re: [PATCH] x86: Update cbmem driver
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng
 <bmeng.cn@gmail.com>, Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20230813201038.413362-1-sjg@chromium.org>
 <3a9a731f-15f8-02dd-b0d1-9626031e0c77@googlemail.com>
 <CAPnjgZ05xtrLQZiKC7t4NQvMJCAx2E7bu+LyPTqKjAmAPq-kwA@mail.gmail.com>
Message-ID: <12a87716-829a-a24f-8221-c5e1ed1cb316@googlemail.com>
Date: Wed, 16 Aug 2023 04:40:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ05xtrLQZiKC7t4NQvMJCAx2E7bu+LyPTqKjAmAPq-kwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

On 15.08.2023 01:42, Simon Glass:
> I believe the original intent was to indicate that the buffer had
> overflowed. But prompted by your review I took a look at the coreboot
> implementation and it now has an overflow flag.
>
> So I will send a v2 incorporating this.
Thank you for this investigation, v2 approach definitely makes sense.
Btw, is there any reason to mark 'struct cbmem_console' as packed?
