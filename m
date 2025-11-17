Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE4FCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 11:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51AC839A8;
	Mon, 17 Nov 2025 12:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p95+6nUh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0084583A79; Mon, 17 Nov 2025 12:06:34 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1EF839A5
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 12:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 45BC43F628
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763377591;
 bh=JIJQ+NDTO2S0enKdxtRWBcBrqvTH/ssXS6sFDd8GNg0=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=p95+6nUhngKgDKPjg/OoZ/HAem6U0cMMnYa4BPYGluZa2PkLsHsdnfuR58qorghKO
 4pmRTXdon08tAGc7G36lr4aEwldBZfsm9tGwepbyyasSV9fdJamGFSMegwQAbDTp+s
 QKVQKWZ8+R0mnlhIw711bvplDTrlZ0hD3bUY1zOI3c/fG4JsQzq3nKquPiIUBB/emf
 AiLuZUpI4l20AshEUhv7nliMSkWmJg33V+4Bvah5/H61c99dvtNIiZFrnSa+G0IKiY
 TyrrYzd0XPDjyraJe9wWRUfEACQ9mBJlgQ+jt1LHWGUqTXBgYrg0Rf3WU10xO5GqqT
 Kd5OFzx5xhdhkKu/eGozJidRcCNsa0n0BGrarxADY47F6mhq1wQJoFj/yz6ApkVH/Q
 bOCUiUpTl4pDB0eazeiKPM+XnmW79DevAQnafyQ+a+oXbLHyZx2DNA2VCl+YFHYIwc
 qw1fBu3a05t3x0uUpjLPxfpat36ey40NnRHBAxmcrUYsPOAsCqtxIb+nMKQxMGk8ZT
 Fbos6OdGH+tWjWhEiTJwGQKoHNy0Hmo2XfWQ4f/MPx2hArP/Ov740HOigcW6B957NB
 PeM507GAGsoPfrDl1FiScs4DhGnAGprk2nIf8P6hgEk4RSKz5K8YN2mVV6Cm94pIzs
 FL0BH5rZ6ULMJc9OXMs3g2g8=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2ad29140so1893474f8f.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 03:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763377591; x=1763982391;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JIJQ+NDTO2S0enKdxtRWBcBrqvTH/ssXS6sFDd8GNg0=;
 b=H3p6U244X0NJZk8T3iL0cI/y1aXHe0wpV1Q7kNkKw0Fx2Vtr1yG59/jA4Z8pe/8Bzh
 v2UZbaL6+1+hZth44F18uE+DPH8eDlwkA97JnHa32H1fWrN9K/QhLW7Tvae0hYdgslJK
 6DJrHFJSzE0B6sVuFvHryP4/A/EmUnAdqRIiLALiuKi0K1NIbkuuLB0hmi+6mcm9p6UE
 7A249gJ9h4oMk6fLKfRLZvtS8wgTX+qoJvoYcL70ubbLiVo1R8y2KCY8B/GmRRBgv/OO
 lqHwrf4NKiD5KYRaUljg6Qhtt4P6dWu5/39HljFLFJnZKGbWT9hG86p4dUgzxz5EhfKy
 XTYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe83hy523aJNEiS5LEvtgTXlvGWd6htsUvu3qjUUCKQFK5Z/JZRS8zqJcgnw98H1Yn34dNyFc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyeb7RXm6r0xRXP9VxTmCZc/+QxIJn31gx3Z9AwoTo8Nmt/IZfS
 WGEcSGhaxcFccQrCo5x2sVIoWYUYJqLztwXazWE+2DiD4sF5Gofw2CL7KuoQN1l08f76LeHtgbN
 pUMsZPW7t8/wUJ+jZ816DH+cWLvoL1rEMCIWliCWVH520dzQrs2oKEyMiYApMJ1P1+YzghQY=
X-Gm-Gg: ASbGncsPo0veMRZYI4Lz/F7SSyi46wq+7gdP62ByzQ8M6ZEIcUyMFX0FQiY3qylWpJW
 PpNikF9JkJDpQU6wKq9z2r+jOBYK53onm2gy2XsAwPIQ/ddIN5tb5K6cCYvkuqgIH0hzUIbTlPw
 qCZqTzqz67gsXQnRK12VoARNLuRM/3Xlfmy79Ou2YmTvtWYOPYvHNmEuln0wvLW6WQRlotbks1M
 EMgWaP7ZWHDS2Z7A9H0q5jniuIlQllXuNPGxn/epXDmaH+5xGMgsUuIXZKraji+A5hqYDfEykJi
 wj96U7DKm4FUEo/Q5ogCiCbyh1LDO4rXk9MHOdc4c+wniU+xUp0k6bwRfSbq2EafJrg6JsU/Xxp
 pcpD/q5BII9wT/G905MxuEf/iapupX/EgvlzYeShmHfLhxYQmuQ9r9kydBfcLu+vCyg==
X-Received: by 2002:a05:600c:1382:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-4778fea1743mr111732815e9.32.1763377590758; 
 Mon, 17 Nov 2025 03:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdSh+vt0DoKxObYBpRq3Hhe2PVMNmVZF4NMvxRJ8air1/rGD5lSW45ucyKeBKBOPnxPZOEDQ==
X-Received: by 2002:a05:600c:1382:b0:477:3e0b:c0e3 with SMTP id
 5b1f17b1804b1-4778fea1743mr111732505e9.32.1763377590340; 
 Mon, 17 Nov 2025 03:06:30 -0800 (PST)
Received: from [192.168.103.118]
 (dynamic-046-114-108-197.46.114.pool.telefonica.de. [46.114.108.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477952823d3sm159077485e9.11.2025.11.17.03.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 03:06:29 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <e2cdac2b-b4c6-4acd-ade7-d96758173588@gmx.de>
Date: Mon, 17 Nov 2025 12:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: extension: Fix possible null pointer dereference
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
References: <20251112130742.97473-1-kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251112130742.97473-1-kory.maincent@bootlin.com>
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

On 11/12/25 14:07, Kory Maincent wrote:
> From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> 
> Add a null check for extension_list before calling alist_get_ptr() to
> prevent a potential null pointer dereference. If extension_get_list()
> returns NULL, alist_get_ptr() would attempt to dereference it, leading
> to undefined behavior.
> 
> The fix ensures both extension_list and its first element are checked
> before proceeding with the list operation.
> 
> Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> Fixes: 2d12958ee71b ("boot: Remove legacy extension board support")

Please, add

     Addresses-Coverity-ID: 638557 - Null pointer dereferences 
(NULL_RETURNS)

so that we know that the Coverity issue was addressed.

> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>   cmd/extension_board.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/extension_board.c b/cmd/extension_board.c
> index 86e4795ba8a..1b92be82611 100644
> --- a/cmd/extension_board.c
> +++ b/cmd/extension_board.c
> @@ -99,7 +99,7 @@ static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
>   	int i = 0;
>   
>   	extension_list = extension_get_list();
> -	if (!alist_get_ptr(extension_list, 0)) {
> +	if (!extension_list || !alist_get_ptr(extension_list, 0)) {
>   		printf("No extension registered - Please run \"extension scan\"\n");
>   		return CMD_RET_SUCCESS;

If extension_list is NULL scanning, there is no extension device and 
nothing to scan. We should separate the two cases.

See my suggested patch

[PATCH 1/1] cmd/extension: avoid NULL pointer dereference
https://lore.kernel.org/u-boot/20251116114153.118217-1-heinrich.schuchardt@canonical.com/

Best regards

Heinrich

>   	}

