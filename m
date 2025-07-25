Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D95C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76BE083979;
	Fri, 25 Jul 2025 15:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i+ywfHkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 647F78397B; Fri, 25 Jul 2025 15:11:27 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50ECA8391A
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b77683cc5bso413097f8f.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449084; x=1754053884; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J0O5gaeojQOAGWD0LE+cudoMfEb7B1qAfHT3fCDhP7M=;
 b=i+ywfHkCtrc822xxvmeaFN2v/obB5xrgLPlnRsoxluAC/6EyLvVw2p1ctOrYg8pwvy
 2MqhSUUktvlBkAiFa2lN8GSqSk26xzR93pMNOIhwaOVcLW+dG2bbjQ1j/cvmWhCN28Qa
 tT2Njs8ibewFiA4dkED4Xg75BFe19VQ4dvKsyZY1ZBA7knSzUAt7OH6MpGJmVvCyLy9I
 kr/VHTFvC9Thc9CrXQr8wK3eqqUEBm+Vn9cfQ4CgXLyAk3RPzsxov9iUgtyWB/2vEsDT
 qyUT7Da1xH2aiZWbT4qUDHC6Tqm2nUI0eIqc392IE1rLELZmkXIOFtkmFZhsOv7WF7rz
 FEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449084; x=1754053884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J0O5gaeojQOAGWD0LE+cudoMfEb7B1qAfHT3fCDhP7M=;
 b=fQGEDf01SPFcsntPDjmdWhHzU5iA4w8iowgXeTdibqHhmh/s/c51IyB4oBKifxLQOW
 K3c0Tqn/uWifza1Y4DTx3fuPg29qMguX0EHjMHvs0rAiff/jEDK3qy+iBoH3MKl5oSh9
 cLkyxdAYo8W/+vv+TAtTAmhD2oirZ4mEvhWZberoMM+B9M3FA9dAKOhW01FfQqy3wvV/
 NsJHtSNDgGxqS9abWjTxo/RHrcb+y8tNPR118S2uM+xi7RwaTteHZv5paYOa2cR9d/yz
 xndUud4VIT5XPySEVkkVewRW3IX8GBaXR0ZtaTAvaG2nqioJExyzAlTG+YUeqQMrTYVB
 eNRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1csP1BEEJ9jbw7IN05TosVQqrudwuJdvHVz3pZccN9tLJOzZgzBEzevKDkg73eQ8vtrKYHlM=@lists.denx.de
X-Gm-Message-State: AOJu0YyopV4tOcfyQzYoknNCkY4HwndvnWrFa9I6wJdpCkMTH45pvDny
 S1GnS8CgbxdK/ROj10u7EQu/vF+LNHStezEMuxP8FYNxw2b2gGP48rbBaFXE3E3cBJk=
X-Gm-Gg: ASbGncvyTUE6W2AGbVTAf9ckwpNKo9VzDWhdEYq7+xaFGcXKgkwlpPaSC5wQmammr/e
 8Z9KPiEsXbEFp98MK1ZaO8pB21WNfXjWDOE623Jv2G280iOyoFvEiospidYYG+6GPUi0qWGTTTc
 MOKE4OYPy8yZxt+r48UauJsOhTUrJx9Q9uvT/uRavT8D54NsWTUkwTO7WJdS20p31lev4zyHhaU
 VhOrgkDN7cd+6osRRUaVwhWDurWBxTagIkSRt8dj8kLEK00dMZ86KbacrjzciTMKO2WmR3v04ji
 Yhmybhcltj/hyqkF5ZDnFviX+mSAwATuK//au5jyN7hWyo4VWSZK9m/m6iRX+hvDjepQWkhHrqR
 7yvFqjNeQdo/M5yJZTM3OLOufjjamvIPqQ7K7IiVvYpelqOLcW24CLPC8QJAaE0c=
X-Google-Smtp-Source: AGHT+IFxZhgLcYNOMdXBpAVNF6F92YI60Lo2WQWfxfJ44shizsHKUPqOXji6zSibjzPC5m9v4Hr6Ng==
X-Received: by 2002:a5d:5d0e:0:b0:3a4:d4e5:498a with SMTP id
 ffacd0b85a97d-3b77666a77fmr1662761f8f.42.1753449084290; 
 Fri, 25 Jul 2025 06:11:24 -0700 (PDT)
Received: from [192.168.1.37] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc604bcsm5094539f8f.17.2025.07.25.06.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:11:23 -0700 (PDT)
Message-ID: <786a2fca-d137-45ff-91d4-6f9e8cf95f75@linaro.org>
Date: Fri, 25 Jul 2025 15:11:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] capsule_update: fix partition match to exclude
 uefisecapps
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-3-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250724090009.569341-3-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On 24/07/2025 11:00, Balaji Selvanathan wrote:
> - Update partition name match to use "uefi_" instead of "uefi".
> - Prevents incorrect matches with partitions like uefisecapps_a/b.
> - Ensures only uefi_a and uefi_b partitions are considered valid.
> - Fixes capsule update logic when identifying target partitions.
> - Avoids flashing to unintended secure apps partitions.

Please rewrite this in sentences rather than bullet points, this should
only take a sentence or two to explain.

Kind regards,

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/capsule_update.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
> index 4dced4961b6..11ef4a0f4b9 100644
> --- a/arch/arm/mach-snapdragon/capsule_update.c
> +++ b/arch/arm/mach-snapdragon/capsule_update.c
> @@ -136,7 +136,7 @@ static int find_target_partition(int *devnum, enum uclass_id *uclass,
>  			 * flags might not be set so we assume the A partition unless the B
>  			 * partition is active.
>  			 */
> -			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
> +			if (!strncmp(info.name, "uefi_", strlen("uefi_"))) {
>  				/*
>  				 * If U-Boot was chainloaded somehow we can't be flashed to
>  				 * the uefi partition
-- 
// Casey (she/her)

