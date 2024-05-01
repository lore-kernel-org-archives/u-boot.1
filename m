Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58110C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834B388A7C;
	Wed,  1 May 2024 05:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="RtYYm5N+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D809D88A96; Wed,  1 May 2024 05:43:33 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B39988A66
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 05:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2b2769f017aso1237762a91.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 20:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1714535009; x=1715139809; darn=lists.denx.de;
 h=in-reply-to:mime-version:user-agent:date:message-id:from:references
 :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
 bh=WWiOgswNMlx+6L21BzeY0Wl1nbNa/KSPnmH0+b48z6E=;
 b=RtYYm5N+Q+PxGK43ohxS4Y5qQ4NkH0e9D/hyMEJZZO9U0a/wCH7VMOcY27wOUOR1eW
 UIhrcRTqwE0IYG/Q2qppz2EMGLsVPC1HJMwGkHytrLyC0TfgmznM6MnjHyv53jX/fB36
 t/VaLT3E9hbiiroM+bMKKyzCTjJz9n7YAv5PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714535009; x=1715139809;
 h=in-reply-to:mime-version:user-agent:date:message-id:from:references
 :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WWiOgswNMlx+6L21BzeY0Wl1nbNa/KSPnmH0+b48z6E=;
 b=UnRg36ZzzVMM+x4dQX/vvO+ELkNyGnfXsHzyAllzL2Wr+mdyvXpYyYt7ieYr2GdOfu
 ZcSZdW3dS1LgVcSY4jmRCcCOxOccBnhWEZk/av5kfias9SneuH1TAqt1OpQ09HOUqgbi
 W4EKihNRSsl8lhsjwfwysYcYqMEpFSfl5Wat2vxk9DPoicOvPtofeL7GygSSxycr0BmN
 pdWgKIH6Q0m1+P7R+ofVwxRsZgMfwPAR5rzEEY2o94kFhI9pu7K5v8a6YtodOux08aje
 IC3Zu4al0C1DwURzQZ9TuZ2NZHculciYezyJkS8iBkScNSVcvcojThSJkBdTnFPjnP4c
 8BeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHRMXwStWMMjIG1OKHnowT+XFXC2nu6/STOqI8pgzbr6NsPmKR7J80fmWeMlKLpjw3sDF14NDWxk2sQQDsBN20AIiPCg==
X-Gm-Message-State: AOJu0YwSMmbCJAYx3b0+DAiTODpFiAvVN7KLr07zucmiFIJYI1osVTpN
 duZSdkK1G0SjQZr3btMwfRujI27ka+NjEnYEV/Ow2jRMYCXepxtyMcEXFXkSxA==
X-Google-Smtp-Source: AGHT+IHy7DUOpLqgvSIGf6RXf1mhQN6yz9v55cvoXbxEKp71ZnhePtFNRqO3629Fz8IBVgTeswzn9Q==
X-Received: by 2002:a17:90b:1916:b0:2a5:d313:4d3f with SMTP id
 mp22-20020a17090b191600b002a5d3134d3fmr1427990pjb.34.1714535009366; 
 Tue, 30 Apr 2024 20:43:29 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a17090a608f00b002ab664e5e17sm450594pji.1.2024.04.30.20.43.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Apr 2024 20:43:28 -0700 (PDT)
Subject: Re: [PATCH 029/149] board: broadcom: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Anand Gore <anand.gore@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-29-trini@konsulko.com>
From: William Zhang <william.zhang@broadcom.com>
Message-ID: <5bef8758-936a-39e1-0e26-856cb352dbac@broadcom.com>
Date: Tue, 30 Apr 2024 20:42:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20240501024316.1767971-29-trini@konsulko.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000369ed506175c4ad6"
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

--000000000000369ed506175c4ad6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Tom,

On 04/30/2024 07:41 PM, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Anand Gore <anand.gore@broadcom.com>
> Cc: William Zhang <william.zhang@broadcom.com>
> Cc: Kursad Oney <kursad.oney@broadcom.com>
> Cc: Joel Peshkin <joel.peshkin@broadcom.com>
> Cc: Philippe Reynes <philippe.reynes@softathome.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>
> ---
>   board/broadcom/bcmbca/board.c  | 1 -
>   board/broadcom/bcmns/ns.c      | 1 -
>   board/broadcom/bcmns3/ns3.c    | 2 +-
>   board/broadcom/bcmstb/bcmstb.c | 1 -
>   4 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/board/broadcom/bcmbca/board.c b/board/broadcom/bcmbca/board.c
> index bcecb4d78392..a6ced92565f9 100644
> --- a/board/broadcom/bcmbca/board.c
> +++ b/board/broadcom/bcmbca/board.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2022 Broadcom Ltd.
>    */
>   
> -#include <common.h>
>   #include <fdtdec.h>
>   
>   int board_init(void)
> diff --git a/board/broadcom/bcmns/ns.c b/board/broadcom/bcmns/ns.c
> index 1249e45af036..45cc62936cec 100644
> --- a/board/broadcom/bcmns/ns.c
> +++ b/board/broadcom/bcmns/ns.c
> @@ -4,7 +4,6 @@
>    * Copyright (C) 2023 Linus Walleij <linus.walleij@linaro.org>
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <init.h>
>   #include <log.h>
> diff --git a/board/broadcom/bcmns3/ns3.c b/board/broadcom/bcmns3/ns3.c
> index 7ae6742c4be8..bb2f1e4f62ad 100644
> --- a/board/broadcom/bcmns3/ns3.c
> +++ b/board/broadcom/bcmns3/ns3.c
> @@ -4,8 +4,8 @@
>    *
>    */
>   
> -#include <common.h>
>   #include <fdt_support.h>
> +#include <linux/errno.h>
>   #include <asm/io.h>
>   #include <asm/gic-v3.h>
>   #include <asm/global_data.h>
> diff --git a/board/broadcom/bcmstb/bcmstb.c b/board/broadcom/bcmstb/bcmstb.c
> index aead6f099e81..bc05aecc446d 100644
> --- a/board/broadcom/bcmstb/bcmstb.c
> +++ b/board/broadcom/bcmstb/bcmstb.c
> @@ -12,7 +12,6 @@
>   #include <time.h>
>   #include <asm/global_data.h>
>   #include <linux/types.h>
> -#include <common.h>
>   #include <env.h>
>   #include <asm/io.h>
>   #include <asm/bootm.h>
> 

For board/broadcom/bcmbca/board.c

Reviewed-by: William Zhang <william.zhang@broadcom.com>



--000000000000369ed506175c4ad6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKAOr8t7mePjQvjXqQAdts13BUkn
4Bz+A/SilEq5YSbdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDUwMTAzNDMyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC61BbQ8QjohGThHQTqimqhLYH50u+8sS4P0owonAn2nXHF
ayVszsJreTFZRzgJB0pv0Ot57e+rjUCdrjDC1xFwdRDonoMngZFjeg/V/vJrAXLuDtz2Mna6M8qB
bY0TJXQC09sLMrOKaXbJhEnvDzvRR28yo/9ZhN6kXW8vbcEAvn+PWy/ubetL5D8c4WawYAjDKksu
GqyCBghVMCphwKWgEc9W5E1C4qzFQie8GPM6sPuaWK/TjCraoTdbcJLlwXWQC4kACGpEcmot5kMo
6S2jgA0BnWZcd6sVqInhvk1tMklrsoRgiRQSV5zXQtIVh8QvZuy1koQQ9Zb5n93wZiys
--000000000000369ed506175c4ad6--
