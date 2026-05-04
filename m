Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B9BFF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEEC983EF9;
	Mon,  4 May 2026 14:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y1glPL73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76EF48460C; Mon,  4 May 2026 14:14:40 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0938394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so59775865e9.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777896877; x=1778501677; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0Qy0bwrMnkpqZIJl5DkVHyMkiY1T/Er7nTpjepyB2Q=;
 b=y1glPL73p0xk5p9G1wIyECnkD/DSGcxgBwltyA8eP5V2k8gzwNqmQs4QSkJYD7WPLl
 YIHIrnWKY7CBEaLSXfDa8HcBWQ+Fi9RtVsTjvNB9q32YIKIZhAHsqSlC+uAbsNkE1wqE
 6WTKbIDabtw6fmPbLGqDt+37jrjRhIuIrUnVop4P2AQ1fF0WKva2zjV/lLvPwd1AqZ/0
 78S4Lp4h3grZRChZdbdWwKutk7HIhK8Uh0C0rXZyeTNl0BETKy+1fxPxsd0VjBNd79a0
 yiosOmgZxwTqOIdRYxigmvAFMKEfvmo/DKKusvlE6UGGzAcq6yvVagX7SkJ44ii8sUQE
 hnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896877; x=1778501677;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B0Qy0bwrMnkpqZIJl5DkVHyMkiY1T/Er7nTpjepyB2Q=;
 b=GNDSIWqU1MnmDRHSE1azSlz0Kcv/P9aTCuy9Q5pTVNDcBgmeT6zNMfKvMQhCLcojCe
 o8uypWpzpYvRo3xpBNqODiecqRgekH9dwpTJOyQb92XvKYXu4OQ8qEufpIU7NMKpwzl7
 2MitRTWI3bwpx62kma/pMWXZR1IICkeEEDIpAyhtj9PPA62t8YafJ5boUMK2AFWr2FkV
 /sYcw4qTpGHOY6fH5f/ddsZG2cTIZNJB6BNRZQDRIYlEtobb8rHOSVTn+6BEOUijMCY5
 HN4QTaNL32c6nt8pAMuUwvDYdAcZ6/i+jbW9wyJKF53GuCJa0ckdYuHiXy4Ba+0K3ybF
 iB+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uWKbV9hK9prU41yOMzc3zY4v7ERQ91NQDwiD4iHr6pICqPC3rFjSjS7mdUWX68Dh1NG54svA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1aWQQIWySHNg8lt02VbKTPhGd+n+eKKBxX91Z60xc2cGKNYVT
 4ZsZ/C7cJ9kx24pflo0VUWQAnO9top6t/BFKjG1/DLRAypNEO1JsfiRwv6ZTGLDdmAY=
X-Gm-Gg: AeBDietynMnopA6H13xUQQ/3lk6nIZIdWtr776A8KFMNPu1jUO4fCNxYPr6VsOaRTP0
 WN2S+53lv0n41Vj/d0rHFh9L647Q7sBVjxlhmgesV3qCLkHPmKH4uH4p8XHbdEsqBa3UoliPkzv
 wo2YoTSQLAkIVhV+BPefhIiyfm1fiV/cSzEm5qQ0UMqcD+9CdXo2DR7gaIgoeMY4RQqk/cjd5Ux
 VlsXn5R4zWFI/UDqfgvx4BVfrnDdpIzyr/xfm0mv4g39LsmJyOVggIJQF6qIZKVRbNthaBXLi5M
 DmVDqlxU5IuofQ/7VEjzObccYhfuhGP5RC70IcJvLXPM8fLFGht4Cp7b4X+I6CAWTQH2GetmLfB
 S5iYIMBjFV6mp0u83wQEbR5lqi8uwwGUnoQ8KakYnXgSvTJqBzSCUhXGwcRXRb4JozlJE/LkBlG
 jPrAZqpJIGTkIErkOwCqWjgRZP4ZjXvtxmz1L0E/OoaAaYEDAOiEGdZmKScU2sURCzE3C+a9fnC
 E0m
X-Received: by 2002:a05:600c:8906:b0:48a:52f2:a0f1 with SMTP id
 5b1f17b1804b1-48a9865e4d4mr107532235e9.18.1777896877443; 
 Mon, 04 May 2026 05:14:37 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fed8b8dsm108192285e9.4.2026.05.04.05.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 05:14:36 -0700 (PDT)
Message-ID: <3e0b30b9-e1a1-47a4-8e71-5a6e680da547@linaro.org>
Date: Mon, 4 May 2026 14:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cmd: ufetch: print Net feature when NET_LWIP=y,
 prettyfy if NET=n
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
References: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260428-ufetch-net-v1-0-5d58c7618239@cherry.de>
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



On 28/04/2026 12:56, Quentin Schulz wrote:
> Make sure the Net feature is printed when NET_LWIP is enabled, not only
> when NET_LEGACY is.
> 
> Only print comma and following whitespace as separator if there was a
> feature printed before feature to be printed.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

As simon pointed out the erroneous ':', with that fixed

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Quentin Schulz (2):
>       cmd: ufetch: show net feature when NET_LWIP is selected
>       cmd: ufetch: only show comma separator if there was a previous feature
> 
>  cmd/ufetch.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-ufetch-net-1ba7553a20c7
> 
> Best regards,
> --  
> Quentin Schulz <quentin.schulz@cherry.de>
> 

-- 
// Casey (she/her)

