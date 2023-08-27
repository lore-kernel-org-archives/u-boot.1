Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA98AC83F11
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 05:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFF038468A;
	Sun, 27 Aug 2023 07:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="cim0M3E5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8586A846C0; Sun, 27 Aug 2023 07:55:29 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0C880726
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 07:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EDD6F3F206
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 05:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693115725;
 bh=3btRtAqFJ21NfrbIo3SrXmIvrGMQgfj5JeyXHU5fBOk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=cim0M3E5qIkHdMgKfSKy7iqJY++qqUhFX+wmrXUGR5Q9urGSZVMFhBMUAwKrRnTlL
 aTEjpnqn+iXdOT33fotaaWwFoXwJn1GJloGEgV9/LkYnQenhL+bTIEAjHFWPbI6ovY
 QGdbnD+ctkjTJCvsC/OMO1KpiiyJPR1VwvqbU/S9aj090x653utqlMheSK3pjqJQXS
 9zbbjLv213UMoDj27W+xAhQgu9lDMSzHWjNvYJ5oqwSkPFnw4rc7Fr7KG//k5fYIg5
 qKtvwkIL5wiDRS1i5gOEpmQ6tPszNcNRyaTiOGXD3fopZKRcjML70zMVWFnlP0n7Mh
 ZteKepKXiWEVA==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3113da8b778so1512070f8f.3
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 22:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693115725; x=1693720525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3btRtAqFJ21NfrbIo3SrXmIvrGMQgfj5JeyXHU5fBOk=;
 b=SafLYDcGqxMHuTdx5jrTnTipa4P5LeM9RrfXxxtt+uapYpZzOhEsL2Rg7dvlZpOghy
 8CkZQdEFXS4MPtwDy/TWvhV8rFWU3mnXWbQgTdmSSWYO3emxIT5pmIAAHRGvs39odH3c
 eTCjewdkBUmHHjqk8mXhvI7JiEyfarlW9RyRu+Pj8xV7cdFDzwvkRXX3BeYIThAzksM6
 f5TiExO8dpeQ35/7C3PAUwJFWgLbt8uG/zw7C33nJvE0LqbkeLesIraExdiyxayWFPsx
 i733QakPKlRcIdtAXyjFhCZgOMH4r+32eVJvNMh6qVNw3h3XMBp2zGLpuPgO90hkKRdo
 RBsw==
X-Gm-Message-State: AOJu0Yx/m3g9rB9+8Et5tL+GVlblDOJR3KXP9OW6/FNvL0HrVYg7W9ms
 bqopKEWBT2g/MPF4vVyYuZ2UitN8BCD49Qog5uDJ/mVlxtSWcPwe23CVLpSkgIW3hfXEQuLmjIl
 siVp9WkC9xH64lnyQhtFyUapnMmUSUXE=
X-Received: by 2002:adf:e981:0:b0:313:e735:6d23 with SMTP id
 h1-20020adfe981000000b00313e7356d23mr18233773wrm.22.1693115725615; 
 Sat, 26 Aug 2023 22:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMFpHHdl2kHCbtyz0+aHUcUQmrU9Kxa+Gc1E6amRKXV+9fnBkpBhh06cWp5tHp1YsDiXqXvg==
X-Received: by 2002:adf:e981:0:b0:313:e735:6d23 with SMTP id
 h1-20020adfe981000000b00313e7356d23mr18233758wrm.22.1693115724646; 
 Sat, 26 Aug 2023 22:55:24 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 h8-20020a056000000800b0031759e6b43fsm6603568wrx.39.2023.08.26.22.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 22:55:24 -0700 (PDT)
Message-ID: <dea05795-5dd6-fd44-ae22-5995645adb76@canonical.com>
Date: Sun, 27 Aug 2023 07:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/2] doc: sphinx: Add sphinx-prompt
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-2-nm@ti.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230824154036.3650607-2-nm@ti.com>
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
> Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> better rendered documentation, yet be able to copy paste without
> picking up the prompt from rendered documentation.
> 
> [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
