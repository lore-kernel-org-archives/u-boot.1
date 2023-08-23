Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F3AEE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 05:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D288640A;
	Wed, 23 Aug 2023 07:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fq63kSdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C0E8640B; Wed, 23 Aug 2023 07:20:40 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F7CC80B98
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D51DA3F214
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692768036;
 bh=afs1cffOqvv+a7UyDxg9WWRjp2XqCcI8sYj1MySHn4g=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=fq63kSdvlD+etNeN2m2AIymKMau3FMxX+GwfunqPXesa0K9gK7feb6W4ZNn+5r+4R
 N5grfCE1NYVytrhnRpLkFG5p6G35QOuUfRCOr4Tc2Bh3We5ugg9ztzBZYk2mIB21/E
 1NtRO5XuzVPZnsupq6XQjodriY8oJGWnBDn12+r0oHIkCN0U8nyVFlincTb38+WEjl
 /EPLIkKje8L4mpm89GBZzEvNfxE7zsXHdwiE/T/c95wjXhdyuNW1whiSc5ohHsP/xK
 6rxxOV6d2xGsNuR/xvRoBp9aIMOgbpUoDMeg7tW141Sye3KCvgIiQ6ADZlkdPPOMr4
 74TVzF61/l0ag==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bb8ab25c51so55274011fa.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 22:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692768036; x=1693372836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=afs1cffOqvv+a7UyDxg9WWRjp2XqCcI8sYj1MySHn4g=;
 b=IqBYAh9y4Ru0T/Pd70kw1YOIunX2tH+BARF7cVYHILWoU3fdmluPxFGeCbytGojmYA
 yd6cJLt8f9DoMz2F1hISLZWyNU6BJAsCu1U1zFe3KhobmKhzJJL/nWdkK5qW3uZmUY9s
 3dVCj8M6YUDbtEUHYtM9njo9E8D01fa0nVN6E7cU7CS82xmdtu/oZvx4mCFe3xL2H91M
 vHc+wmN+AlYYSlNDw0j0fbpipfQO6QTmID7cDRuT9cCOO3KKxH+UVG1YzKA7G4ZK4zy5
 t6mS/gFYdLa1/Lx/C8n34KLOfNkl5mwrHoTHA2rl628ZubCbITQMFRWRPFbMbTLMtwdG
 CRSw==
X-Gm-Message-State: AOJu0YwgyGxOqEiyNrWcF8oYK/f9FSQ1EWAHbnPBlM+9Wm6sqPslDdGN
 x0/t5+KWc0axML4XT1VbqGAfplY/NiiOPeyA8eVen+xEjek3cf735Gk9HiMLxEvIhLxP1P0z2Gg
 uoZMNCR7d1M/SkjX176MT+8aV975NFOc=
X-Received: by 2002:a2e:86ca:0:b0:2bb:8d70:c9e with SMTP id
 n10-20020a2e86ca000000b002bb8d700c9emr9328136ljj.47.1692768036087; 
 Tue, 22 Aug 2023 22:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaAvHTw3anW52kF9QgXzYECdMskNl2/nno6ZOEFCCPolAitR9yx9ukWVQsYnoJB3PchW4c8w==
X-Received: by 2002:a2e:86ca:0:b0:2bb:8d70:c9e with SMTP id
 n10-20020a2e86ca000000b002bb8d700c9emr9328121ljj.47.1692768035534; 
 Tue, 22 Aug 2023 22:20:35 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 z22-20020a05600c221600b003fee9cdf55esm11049110wml.14.2023.08.22.22.20.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 22:20:35 -0700 (PDT)
Message-ID: <d4c88dd8-9897-1869-05f6-ecb384d72eb4@canonical.com>
Date: Wed, 23 Aug 2023 07:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 04/13] doc: board: ti: am64x: provide image alt text
Content-Language: en-US, de-DE
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neha Malcom Francis <n-francis@ti.com>, vigneshr@ti.com
References: <20230822164107.2272231-1-nm@ti.com>
 <20230822164107.2272231-5-nm@ti.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230822164107.2272231-5-nm@ti.com>
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

On 8/22/23 18:40, Nishanth Menon wrote:
> Provide alternative text for image.
> 
> Fixes: 4bf49bade124 ("doc: board: ti: am64: Add boot flow diagram")
> Reported-by: Heinrich Schuchardt<heinrich.schuchardt@canonical.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>

This patch is only applicable to the next branch (2024.01).

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
