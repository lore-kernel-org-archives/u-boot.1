Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48740F3C246
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9768B83BC7;
	Mon,  9 Mar 2026 13:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DTlB6Q+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7144083BC8; Mon,  9 Mar 2026 13:50:10 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE138063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 285D93F285
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773060607;
 bh=C392WtFEdI4X5rjnybmECXvYpsoyBLZSltkAbRP2w08=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=DTlB6Q+fRiizA0+d8X0gFoYsATyoPzqwkph98trd9GeoHRw3C3uDOIO07YFtXY0wY
 hIdpMrhylSJWlzYofeTmPhI4hB2eqlHYDUEAL8FZlZBtIcr4s++iqsq689x5xmDSng
 mNiLf34Qe1zDXz4TJnsA1/6pFmQyYf/ruqMeBtW0Sho/tXRw3FuSGSid3OOwlyncdr
 3LEoT9Mzb/dx9ogBTdO4jo6XNLVH4sxWUncJxKvdrgCb1yTQL1pxEWMsQaQ6/TYInY
 hVEW7WUdPQbl6v48sHrHVwJt8n/HsFQnmZV/KX3tQRwGNtTeMrg2y+Untr1E9MUmdo
 Udc8BtY9AqbURu/09gkCyaniPwLhAfPBbV131q8yF79k1K5ppNPkOqmJylAsaOBoTO
 vfHRkPun1LS1HDWvDGnOIEO2zEWowdozC4ZyENM2QWqAzP3TwtBRtJ+1RDhKdZP3/J
 3mT5N36opsn8Afx7Epwhoe6zVR4LPhAri0kFdwlLIidX9RTF1MAp1aLQmKkNhYsR99
 VGU/tpIxSXAQlAXuhz7Ydete51OY77Y7S2bKqSag04bxl5Ma/aCHAmGCIGPMRbLX+7
 CeJA+ALrdM+C4eGR1XNAa8FAFCi0eVpRHUDMOzp43yxYAESsqyAygPTfznrM7n8/gz
 N9s4hI/K1LScllquH39uAQKU=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439af7ba802so7784900f8f.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 05:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773060607; x=1773665407;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C392WtFEdI4X5rjnybmECXvYpsoyBLZSltkAbRP2w08=;
 b=rD6kIFTB51PEkvU2u56plXMXcrth6Zzvu+vgP0Qv4V5LowT3ngLWRC1lRhAjixbrJA
 It+GgaTomOS/nea7ROYDag/GJl6G/rss2EQOQhyGHqFPYEekhTjfNuaWaTiz4WOTyjx/
 WUyQlVEZ7+Va9d3Na4hHf0BIec7ZA/tgtRz5jesdnfSo94B2jsN6cNQttpIxe8qkrygm
 Yeu82XD/vtETnujbzXDHC3JKjxXdBwEeArt5zErAiuk1kxHGxeWhqigM67aqlsHWJiDv
 0Ha8UDd6NRJ4k4bHkWb55mUe4gyqHAq+EfNLNWC+vOfI/83+9YD7+kCWCBipWD1ywdUq
 bcTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYv+ax6HF3ERPalQ6wKH5ftwA2dxt3PYLwhGZwO5cYSHaqi3rzsJ/qxE+DvbPPm4ydFzyFyRE=@lists.denx.de
X-Gm-Message-State: AOJu0YykBtHNq0anyx3/o9DlBXjjUwRO2yv4Ap/KknllcW0WTVH2ENdB
 7vn2DLsLTM0O9ERnsbkkaz0+kbn3S9AsZ3inaKoDz9jTId8Ik/AwHDThBvTuppYcFwolT11Fe4K
 98Qh0VhmfQsNF8VmWFwIotOrtccaCbcoWsgnxq7tDjPhM6t1J0aZhDs943IGYafJhbKOFeBU=
X-Gm-Gg: ATEYQzy6tGymoSlpj0RlIvGUsPI6/nZ3IEhBnrlKXQhzNf5jRT/sMkpOOcE3NvX4nSd
 Pj7etZERVb/vr9JAxyk9nQkIDlm697yi168u87F48OnIXF9j13G3vJ7Lvfj7/+8FuVjVvSX1zQi
 ksvEUZqPu8gs41jkBYMU5GVuSjBO2Xm5uB6FW6U8OYcJCGvgYtWA1JtRgLCgb6K7q0isOmaH6ze
 +D8S+l9zWDUZPmR4bdfY1/jwABxVvTWO76nxDRYNczmMpk/PlMII3tgpgQlUl7xbRpbqv+0CGlT
 bCnq4j3gE/H2X74VB5y2g/oXfqZNrQHKyLDIYITY+DGSdtXchYqS/04OdpkzIPCIrefLhnyYK+4
 lPqUW+Z4E8aljkSonA80PH7MW6+9Tx1AI/Qbo3l1EOHRnT4DtOzNpXEqPuo5P1WVmMmWh5DkvV0
 OYTBk35Qekfg5m5nI2HLxY8PgJVa1/1SwmsA==
X-Received: by 2002:a5d:5f42:0:b0:439:cf1f:22a7 with SMTP id
 ffacd0b85a97d-439da654418mr19991749f8f.6.1773060606639; 
 Mon, 09 Mar 2026 05:50:06 -0700 (PDT)
X-Received: by 2002:a5d:5f42:0:b0:439:cf1f:22a7 with SMTP id
 ffacd0b85a97d-439da654418mr19991714f8f.6.1773060606196; 
 Mon, 09 Mar 2026 05:50:06 -0700 (PDT)
Received: from [192.168.103.129]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d968sm25400834f8f.6.2026.03.09.05.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:50:05 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <40e1d392-3745-413d-b011-1fb58389b0c2@gmx.de>
Date: Mon, 9 Mar 2026 13:50:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc/buildman: fix missing :: on examples
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260306-doc-buildman-fix-example-format-v1-1-fbf955d39a2d@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260306-doc-buildman-fix-example-format-v1-1-fbf955d39a2d@baylibre.com>
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

On 3/6/26 20:52, David Lechner wrote:
> Fix 4 instances in buildman.rst where examples were missing :: for
> proper formatting. Three cases just had a single : and in one case,
> : didn't make grammatical sense, so it gets a stand-alone :: along
> with fixing the indent.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   tools/buildman/buildman.rst | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> index 9e850b26ec0..a2061715788 100644
> --- a/tools/buildman/buildman.rst
> +++ b/tools/buildman/buildman.rst
> @@ -146,7 +146,7 @@ the '&' operator to limit the selection:
>   - 'freescale & arm sandbox' - all Freescale boards with ARM architecture, plus
>     sandbox
>   
> -You can also use -x to specifically exclude some boards. For example:
> +You can also use -x to specifically exclude some boards. For example::
>   
>     buildman arm -x nvidia,freescale,.*ball$
>   
> @@ -970,10 +970,12 @@ a set of (tag, value) pairs.
>       settings file. They can also be useful when building U-Boot against other
>       open source software.
>   
> -    [make-flags]
> -    at91-boards=ENABLE_AT91_TEST=1
> -    snapper9260=${at91-boards} BUILD_TAG=442
> -    snapper9g45=${at91-boards} BUILD_TAG=443
> +    ::

Thank you for addressing the documentation issues.

In the documentation we tend to prefer syntax-highlighting.

.. code-block:: ini

> +
> +        [make-flags]
> +        at91-boards=ENABLE_AT91_TEST=1
> +        snapper9260=${at91-boards} BUILD_TAG=442
> +        snapper9g45=${at91-boards} BUILD_TAG=443
>   
>       This will use 'make ENABLE_AT91_TEST=1 BUILD_TAG=442' for snapper9260
>       and 'make ENABLE_AT91_TEST=1 BUILD_TAG=443' for snapper9g45. A special
> @@ -986,7 +988,7 @@ a set of (tag, value) pairs.
>       config.mk file and documented in the README.
>   
>       Note that you can pass ad-hoc options to the build using environment
> -    variables, for example:
> +    variables, for example::

.. code-block:: bash

Best regards

Heinrich

>   
>          SOME_OPTION=1234 ./tools/buildman/buildman my_board
>   
> @@ -1357,7 +1359,7 @@ directory.
>   Build summary
>   -------------
>   
> -When Buildman finishes, it displays a summary, similar to the following:
> +When Buildman finishes, it displays a summary, similar to the following::
>   
>       Completed: 5 total built, duration 0:00:21, rate 0.24
>   
> 
> ---
> base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
> change-id: 20260306-doc-buildman-fix-example-format-6f6cd937ee9b
> 
> Best regards,

