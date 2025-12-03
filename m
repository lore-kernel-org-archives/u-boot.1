Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF41CD1BDD8
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 19:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E73283B99;
	Wed,  3 Dec 2025 20:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C1A5HoRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FA883BB1; Wed,  3 Dec 2025 20:53:31 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 271DC83B24
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 20:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8b30d1b467eso2021685a.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764791608; x=1765396408; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c+E5Ehrt1TgHY8tpQcFmMGo3Gu/0MasK5ynsPrr5BFo=;
 b=C1A5HoRicB+zBwKqPh8g0wyGwryUpGxSe7BUZ3o4Jw/laFyvSw0eIg/kImEMtxItOj
 kUF43CPMOqQxZujdO8nFDpPqY/1FWd6mrv2NBYQDiXrvT43YCLwFzUykFqV62EBGIE58
 6ajsxLpbU/eZYZzCmXafoKP3aghGbVH3n0315snixiScEOc/wUgw1/CPFCZ7BKRyKWG2
 0xB6mGB6t2hTdAkyH4ovhKLZIc2/JQPx8q1tgNkSxjsfUIoO4OHocWj0loyVYxot7JVy
 bIrmH4K2iqnpOhAprJznf0DfRrP7lR8MGOFa8TMsONbz5hvrYuPldIf7F/MxZsPRGYiA
 Y9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764791608; x=1765396408;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c+E5Ehrt1TgHY8tpQcFmMGo3Gu/0MasK5ynsPrr5BFo=;
 b=B4M9GNlNNVnZ2dRoEgdQG/NEsKj/XxkW6Htgdk7bR2mqy80MJBtnJV9m7/ZgvQCCoD
 /WYgThj2d3lc3PQ6k+glgmTcgcm7lNP/lHaPHFe3gIKlBiEwyPa4UbVrI6HbY+o6V1Yg
 k6vDsOrciT+YZUVtQHmMyOjandWC+8ApKKMZhgt5Ya+7P3hGKWgfzxPv33ln9r9mRUVp
 zyg8exvming2qS+uirOASm+deCGrmxLoI/qX7pQXaqPP+EjvjC4r05KG2O/8NbDGD2q1
 96iVTKQ4dWgzBgk1B9lwYo/r2hh+louW8+7IaB8ElIFQAjfmvn4A2gd3DkyoVb6XfRGp
 gc3Q==
X-Gm-Message-State: AOJu0Yz9oiBtFhL90viefzF8h7UPraXRUySKenGFjQlvoOqPPyKBnYmb
 HoQrYP2VrJC1aQy+/621kjiTfoXpxaGWbIYmL3ynLSoQDeRcgkPMiphJ
X-Gm-Gg: ASbGncuoaGGw7gC/fdN7OWrl0NuJ6ANR39Tkxxx+Bens8G4boybpdCnLBmIQuBaMIfZ
 u35dK/d25cZotszboDDT6/LIaRSQ0j4IcG9OK9+Du1EPXVXflxL4nBO0am54OL8AWblJ2xyMzp4
 mNARCuxJ5qgfMfLaoOlDq4Sgp1ZmElvoX7bLLG511WbReUQHc2P4/rk/nlz0oZcYyPwMTjF7KKA
 EQlj446UkoXoOMMQcm4+7adW+16JX4MsXQVWKrA8LRe2FY9wToGDuYlfujYVwOQhLPYNn2jIxXb
 N93F7hq0O3BFUO9TD5oBKLIiLyzFtqCI9aoAx0kObzQpWNC6Frm73HtLRoYhhQCOO5qT3gJ46ek
 w+MbHaeiaKDkK8fQEZhUCNoUnEp5UQfu6eERNTEiO+f/RpvOu1En9mblf5T0J3dPqpHzpgs83VS
 4fKY9cRshlmAmKajS/GdRBCQPEiSoW2kIoFvjUl6wBJnKqYvn4K3Qku97DQcg8fw==
X-Google-Smtp-Source: AGHT+IEPINxeR/S/bTUpJtMZHLeIHvI8m0dh7fAFYjG1sJZbCGCN4nOVYHP190YJ0lWZgDjWczniXw==
X-Received: by 2002:a05:6214:e85:b0:880:4585:da69 with SMTP id
 6a1803df08f44-8881d7bdceemr29469806d6.4.1764791607880; 
 Wed, 03 Dec 2025 11:53:27 -0800 (PST)
Received: from [192.168.1.201] (pool-108-45-131-215.washdc.fios.verizon.net.
 [108.45.131.215]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b4afe8sm132570166d6.29.2025.12.03.11.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 11:53:27 -0800 (PST)
Message-ID: <712a7f7c-1785-1ba8-dc57-dab516200bd0@gmail.com>
Date: Wed, 3 Dec 2025 14:53:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] test: correct strlcat license information
Content-Language: en-US
To: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Leah Rowe <leah@libreboot.org>
References: <20251124194556.GM2125796@bill-the-cat>
 <20251202152055.12467-1-GNUtoo@cyberdimension.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20251202152055.12467-1-GNUtoo@cyberdimension.org>
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

On 12/2/25 10:20, Denis 'GNUtoo' Carikli wrote:
> The GPL-2.1 isn't a valid license.
> 
> The copyright header says that "These tests adapted from glibc's
> string/test-strncat.c" and test-strncat.c is under the
> LGPL-2.1-or-later.
> 
> This was reported to us by Leah Rowe.
> 
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
> ---
> ChangeLog v1->v2:
> * Fixed the SPDX license identifier (LGPL-2.1+ like names are used
>    Guix and I'm used to that, sorry for not spoting the issue).
>    I've updated the commit message accordingly.
> * Rebased on the 'next' branch.
> ---
>   test/lib/strlcat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/test/lib/strlcat.c b/test/lib/strlcat.c
> index d1a0293271b..dead1dfc70e 100644
> --- a/test/lib/strlcat.c
> +++ b/test/lib/strlcat.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.1+
> +// SPDX-License-Identifier: LGPL-2.1-or-later
>   /*
>    * Copyright (C) 2021 Sean Anderson <seanga2@gmail.com>
>    * Copyright (C) 2011-2021 Free Software Foundation, Inc.
> 
> base-commit: 42a4ff5f63baacc414b564c02541cd1f5c0862ee

My intent was to relicense this under the GPL per the terms of the LGPL.

--Sean
