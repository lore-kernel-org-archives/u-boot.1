Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6CCCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 14:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D00281D6A;
	Wed,  1 Oct 2025 16:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vq+iw3HL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8798C8328F; Wed,  1 Oct 2025 16:03:35 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EDC800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 16:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3ea0445fso31841395e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759327412; x=1759932212; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hac0adumesgKXwJM3mJZ8O4PYx4LIa7OwhcFBV6wXtk=;
 b=vq+iw3HL7GZwynPjc93UqkfCsswQCe7epRyg7jUjymmRxQCeLqXM5vE3yQnp5/r5b8
 qq8FsaJixNoS+0Iaq32TYULlsGNtz2TWfxYTO5wZNBK3U4YrhCz3Z2kRT94Y+rs1iB8m
 kOKwfA23Da4+Dm6DIiuH219yPamX4RiUoh0Pp9p5e0d4H/bsTaEmrXZ5c5IXgpCdvsrt
 kt6Qbd4c9Nu+xLmbKNkuxFsTfbe9fc8UP1AbTD6k2dcDr6FIhNHypG31cDs4WBbwlwUd
 /3sw4ftqE3hV2IgMMd6UbIhxPnfa7kE6LdDTmaiAzwgPHWtZqsUwVWNCZevbz2Ra+2U7
 VAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759327412; x=1759932212;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hac0adumesgKXwJM3mJZ8O4PYx4LIa7OwhcFBV6wXtk=;
 b=CyX492mktqMJu9I3wpjm45/ANw5+YvmmuGpOE+HDHVf4ajFkueotXVWCYBiKLgkHvk
 lwREQmaaKhix5lsGgBmlSlidkCoWcJVce1oovokQZ6dggumVL8IjLUEoP3nxqe3DlkU+
 we0f3TDyCv/OKCjKodhdQ7nZKdn5FvMD2EYhbwuPbCFIQa/bHVmJkT+20JC/DuNKoGzW
 ev8779gv70qwSxZxZ9tr32sBuVbRDGBJdbsdCG44wdzkkK421kLv++syvX9PIDEKvbY7
 XWjaEppMC64TSV1S+kG4uO6vKS1QlcthDoRzURFE/xt0yJqr2ekuhn2WCgZD+yAqX8vI
 acXg==
X-Gm-Message-State: AOJu0Yw5Xfv3qXdkSFZseTt/IHlpQ+yG/zkdTy0kHgZo+aWpfu0yBsnq
 D6lWe4/9ljRIGFSr0lWaxxV4DEP2LlsgzMU/Z0upIxR+GUx0ty3/+/uuvlnkZrL21vU=
X-Gm-Gg: ASbGnctESQlwGTpyY7ut4oZgU/4d4yBK8esyxSlO7khox97E0/aGCw5zZ9gjxJA2E8G
 cOl9NZVnOxeA4xaRtTBq8xAdegFpTKZlkn3BvdJl5Ydh27JIGDM1M/ictTkEbHMf6zwpv5CIBfy
 kD7Ri45UjMqiFhcJ4+GHd+qTI5513ZUbJ/P3yRYsVaTD1MgqcXFtn33dICD5+Zw48kotoskV17I
 QwUaciBFQcDnnW8twWTHUsQpwu0fxNjZWoSk6JIc/l6G8WMt1S+7fbfGVsh7I12NDwY8B0WJHjt
 KX0MZnzdF72qJz5dSMKiK7RSbzKs4r1RZaubPyh3ltogRSqr/LTKLZah0P/Rsxdy7WvqSjyU6Ci
 KWpRvmYvErdCqAdYkKZTur/wcTRv3Imnk2vUqAot8larFh8L7AaxKhqJTEQfVZG3d6i3gAxXxaY
 VWAnNQew7+H192eykr7Lz9ApKkDw==
X-Google-Smtp-Source: AGHT+IGSyaBRJwDR6YoQ7mi0PcTE1No/MwsYse0Zm4PMn8EpiODjygNiQXrdHFh6/bC6pzyklHLOhg==
X-Received: by 2002:a05:600c:8b37:b0:46e:4329:a4d1 with SMTP id
 5b1f17b1804b1-46e61202280mr34403145e9.4.1759327412522; 
 Wed, 01 Oct 2025 07:03:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c?
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5e4922sm36273895e9.1.2025.10.01.07.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 07:03:31 -0700 (PDT)
Message-ID: <21c8099e-a2ba-4361-9351-221e10deae80@linaro.org>
Date: Wed, 1 Oct 2025 15:03:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Michal Simek <michal.simek@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch reports for zynqmp video driver
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

Smatch reports the following two issues

drivers/video/zynqmp/zynqmp_dpsub.c:271 config_gfx_pipeline() error: 
uninitialized symbol 'offset_matrix'.
drivers/video/zynqmp/zynqmp_dpsub.c:277 config_gfx_pipeline() error: 
uninitialized symbol 'csc_matrix'.

Looking at the code, offset_matrix and csc_matrix are only initialised 
if video->is_rgb is true. It looks almost as if the code for 
video->is_rgb being false was never written. So I am not sure of the 
correct fix for this.

Andrew
