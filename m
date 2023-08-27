Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD62C83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 06:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92DF8468A;
	Sun, 27 Aug 2023 08:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uaH7YJIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B6284702; Sun, 27 Aug 2023 08:01:46 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A238180726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 08:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1FF2D3F65D
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693116103;
 bh=/ecJ4aelSZy4MwjFCj06X9qGWYJsoKjrKUiLc71E+BQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=uaH7YJIvKKhklIUnefnvTvcJMChbyZrlW84RQiSNj1FZ54MoF8f6CbrohI+OIJkFN
 q5G32VF0DEWmD+tANgGJc2KIekCDbaazyGc2hE6Nq1XUHEMDvGFBJLtLDcdePBuNYw
 RHx+Lp18RsLjDLlWpyQwndmFtNyX2QVcAj2GJkvcm/ouYI3D7MCxAc80fMqo0xNGrY
 utdSL3Jb9mMEogQZtfjTgmoJ25xu78dEUDs3CTD/3DOrtnEmw7rob3GcaDetYO9bcE
 KxsLQRWcPynyU86EVKh69CVbPFQ4gJBuQCqoN0e+kcb806cVAwiX75VxlXyD1zny4S
 KeaAk9gIFrkqw==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aca0c0d63so1448143f8f.0
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 23:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693116102; x=1693720902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ecJ4aelSZy4MwjFCj06X9qGWYJsoKjrKUiLc71E+BQ=;
 b=AaKefb6ueub3dND5VuX5LqgK0Baq4VXLKfAlzt61yAENyIH3xUSSpnf3GuQZYVwOz7
 Kuf1DqxMU6L51RYpFS+IFrEnaVNtKMyR6Lj+QHcmhPq8bhbHnU/mxq+9xV9cEUnwnExb
 Bdw1jyDOXZ3rOmFoDtOTDk/B/JPMuk3KjXxmJwITr051Jp/ngeytkyuRmM17c0Qc/2kn
 t+QHYIwpXykGXg+1D8C/MoO4mO+Sqm1LAWPx0MFlcF0b3KgPVPtEMS9Vzn51VptN3bA9
 gmndwhooxkjippRaI4dWvvQVioDx3oUY57V6bXPSXD4OBCxBzPhn19S95/oIHjLD+9B9
 69wg==
X-Gm-Message-State: AOJu0YyDyUd0xrDPblZQSVEMvOYzQzg7eqIMv7wQumxG4ZKdIgmkngr1
 e/sEx/dA+f48GuJWoicFnWilYpX9g1pczW68QeTxGFF8bZ5SEvGRbNLOkYUyrrVVyOs665dlluX
 SjsbB63bQj/2R+ZssAKU8IXOJDDXVU2b0RGOKaHE=
X-Received: by 2002:adf:db4c:0:b0:317:6314:96e2 with SMTP id
 f12-20020adfdb4c000000b00317631496e2mr18124306wrj.14.1693116102445; 
 Sat, 26 Aug 2023 23:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9t/2lHCu4OqAg1s2cLK7mHfZb/PhxLR6IxGLVJTkLR02oDIo3hYaFX0RWEaAPgxyq82a/pA==
X-Received: by 2002:adf:db4c:0:b0:317:6314:96e2 with SMTP id
 f12-20020adfdb4c000000b00317631496e2mr18124298wrj.14.1693116102147; 
 Sat, 26 Aug 2023 23:01:42 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 g5-20020a5d5405000000b0031435731dfasm6659735wrv.35.2023.08.26.23.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 23:01:41 -0700 (PDT)
Message-ID: <b1bc3b26-6911-641a-e5d4-74a3446a0fd9@canonical.com>
Date: Sun, 27 Aug 2023 08:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 2/2] doc: board: ti: k3: Convert to sphinx-prompt
Content-Language: en-US, de-DE
To: Nishanth Menon <nm@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-3-nm@ti.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230824154036.3650607-3-nm@ti.com>
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

On 8/24/23 17:40, Nishanth Menon wrote:
> Sphinx-prompt provides a handy scheme to provide documentation that
> renders nicely and yet provides a scheme to copy paste for users without
> having to hand-edit the copied text as is the result of code-block
> 
> [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Reported-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
