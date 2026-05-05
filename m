Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C227CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D43184943;
	Tue,  5 May 2026 15:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xTlw0AoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C67DD84944; Tue,  5 May 2026 15:47:35 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6858848B9
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso43234905e9.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777988852; x=1778593652; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gatpzQrYyM4GPxVUMdc9l7bPDpLn0PU+92EL5xPFZFg=;
 b=xTlw0AoJH+3qWqOZPLSeWWiAaf7aPcsv1tcD95qU526xPBdFksXX0AiS8my3BSqJTP
 72TsovOTRwxbyNOFE2fQsO3uj5HObvt7CvXvy1TMPG+oWArNemNcqh0iKXOg3LA8SaeQ
 y0ze99s5Nk9MVi6QOAa2SO/QKLjUZywwZoyC3t++ZwxiXUBPP7za+DqqhC1XNoFiE5Lu
 rb+oXvIdysPwF32uXdAP0t9800shvccCwzjH2LPmmNPhzMemRXnUdNWLIvrh1vcsYgzN
 uIyk83vO4SqVHv6FySU2+V8FoAfW5rxl2P21ttWwWTs0IkPH0qS9uhP2dvNdmjkfGNx9
 /1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988852; x=1778593652;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gatpzQrYyM4GPxVUMdc9l7bPDpLn0PU+92EL5xPFZFg=;
 b=YeGt4L4QrnO0ZgJ93dZ5B0Qb6VtEHkIvDFO+poHvDfIeVkYmVkb43E2+8bUhJcKY9A
 EcvkYYXNnb+J6tZalOllPCfJC0QMtR/l1hM2vDNOkciFuDgX5OpxavXjSohQy1YketH9
 4/6boMoYwiTRPXRoGjW1oZZ+66OVtcc4vNwHhSfqUyqmNfrDxUMO/XHz6ztgn+CTgK85
 6Vd+xFsnSLMGeqre68c4rF3JpxgQ4Wk/kCOWi5VwDoeMEF2rlogZep2POtYNjkxL5xuc
 ujKiDc6o5alORWIZqdQ7juDuk2tntMr6myDrczlpUARlo4WxMEsIcqeje6D7wzhGHVut
 7znQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ856741ezmDUzMGg8qMHYB2LEU1FOOLcEE6+kwvlTP4OXKaqwI/tu7Tn3dUO0rgYCzwT1UpONM=@lists.denx.de
X-Gm-Message-State: AOJu0YxlSMC/LOq7cOADA0RhX6OXzvdQw3//Nb09T8jrQrfluOfuX367
 uUcoJcKfi7p8Apv/taF2+aU02YdrYUWUiLiwZwVzXXSsq+/63o+18zNosIClnVXSNM8=
X-Gm-Gg: AeBDiev/V1K2nKmBb6WxFNUIaNXS5i/C5vOD+1Ppl6/0tNykC3y1DF/XsbNu7pvB9Bn
 wgGB4mYCADkOLQJfn2i+a/xiLKN4v4qw+tXCPYUcQ+q2OjMs/VOZuuyGCHMFYCJ5Q6kDpMTX8go
 iaINdsE6YvDD1dkVv3jvQdjk/jmTu4wlSNOES5cNQvZhKW5ZyoO59aOZxah+5zYTqdRhBHtNyWH
 m23ryYkZSM1ZlYlvouub9fHXjdgfi5XwcwjOKu8u00/mzbz3rhnOHrdurla3VUfi2KKRpflEk+K
 HL+ay5QoTgL3XEPT7AnV9EP2GU+KusO798vz8fV+NxMaQOd8UxEgBPu68RsHSJ3vUHN0yuIk/5S
 dNGWobXE7fBQS8JIU38g8IZQTVNKp8pNzbMPU0seyvnMgQefSAmg2f98fPHIwDgJx6IxnkRlUax
 /dtjJhuG3P9iABiwAZe37bH+qmDDrEL6vJqdkzxpeSv3zgS2U1aVsxePxiF/5Pe2Gh2Fg30Cv/s
 P9a
X-Received: by 2002:a05:600c:1551:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a98663ca6mr230548025e9.19.1777988851939; 
 Tue, 05 May 2026 06:47:31 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d17ff35f9sm19256955e9.15.2026.05.05.06.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:47:31 -0700 (PDT)
Message-ID: <40dde65f-9dc6-465f-a053-31a90d75fce1@linaro.org>
Date: Tue, 5 May 2026 15:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cmd: ufetch: print Net feature when NET_LWIP=y,
 prettyfy if NET=n
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
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



On 05/05/2026 11:14, Quentin Schulz wrote:
> Make sure the Net feature is printed when NET_LWIP is enabled, not only
> when NET_LEGACY is.
> 
> Only print comma and following whitespace as separator if there was a
> feature printed before feature to be printed.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Changes in v3:
> - migrated from bool plus ternary operator for setting the separator per
>   printf to a const char* which contains the separator to print, as
>   suggested by Simon,
> - Link to v2: https://patch.msgid.link/20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de
> 
> Changes in v2:
> - added R-b trailers,
> - fixed spurious colon character before separator in cat,
> - Link to v1: https://patch.msgid.link/20260428-ufetch-net-v1-0-5d58c7618239@cherry.de
> 
> ---
> Quentin Schulz (2):
>       cmd: ufetch: show net feature when NET_LWIP is selected
>       cmd: ufetch: only show comma separator if there was a previous feature
> 
>  cmd/ufetch.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> ---
> base-commit: 57460fde4ba84d67de4066ee1141e89e8139ed23
> change-id: 20260428-ufetch-net-1ba7553a20c7
> 
> Best regards,
> --  
> Quentin Schulz <quentin.schulz@cherry.de>
> 

-- 
// Casey (she/her)

