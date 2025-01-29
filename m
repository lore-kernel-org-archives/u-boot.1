Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492DCC02192
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:34:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 150B080B9B;
	Wed, 29 Jan 2025 17:34:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Md5tMrD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C800680821; Wed, 29 Jan 2025 17:34:09 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9FA80821
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so59637096d6.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738168446; x=1738773246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0mUqKo5/LeAOyyW3nEZdCbfaXLIxo/DF8/QJqP3n7E=;
 b=Md5tMrD+P6TIp4Um5U9ZcNjM6cVQIA+DO8ReQNGzlpybHbOMiBQhY5ccN/EQH21ylj
 5fHy6Dz/KEDGaRY8Y1rfc69UVJ0lShhv3vl1yW7f/+5lmadOkzcGfP0MkM++KXUsuDVa
 MeoKMz6rhOJcePGlbhRWldmsRET2yUOh+OjGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738168446; x=1738773246;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0mUqKo5/LeAOyyW3nEZdCbfaXLIxo/DF8/QJqP3n7E=;
 b=Pd8VAnAgB+En+/veCzyA6BY40gtwv5sStycdfJq/Aw2L+NRApwWviTk3SNpwiqFtda
 wdSfJZNcUTkAilTaLsm6DMNON6fHsfypd06ACkuagYtZEJk//cDEQNAumKUA/JSKc0Ac
 2E3JJ3/rDR6nEKHn/eZZZNG4nXZiBE6k0mzLcE1l5nw9z+i2ylb2OUceQ7fNSr19I59W
 4o3boTEj8+8+LkgJRCk/u4zJoGjhkgtHsFepPydsY+sIEHeVjnU8pLlpb1tql3wsc6+Z
 2fnOrX13B3n1XGaA1u7o1atG0CgzNR6903YgbsoWi8jkKyRbtbdq3XxyLyeTN/CYTqZb
 6dgg==
X-Gm-Message-State: AOJu0Yw/OC8wH5DAYMA6M8I3PA6ueJ/pIwOAeKlESj6aCOJWquUW+l1x
 LORQLQKDJ7JjRIjIApaDdNnsi2EocANfFA0ZEao1ANIAbhm0DAriJ98iZF1p/JM=
X-Gm-Gg: ASbGncuRKYS5PMADWGnmhzQpu5ykiQXVHxJDOxVE8269c0dQq0tcB9X9+br1cbJkiUV
 WvyYhYGUHuHbrcOx8KXZC7hyqxP9YgqxOsIs1cq/dpwOW0rSmOpG7fxGeTxNx2OfDpqY9t//T2r
 QSSfiFtVdNxjcgzHRnx4auzdckd+4oUj3OawK+r8iYJ/hlPliQ0iK1xkfxBHLLb3qgPIkToYRhQ
 JymRHB/sCavdb+Y/7Tk9/NOdwCJwIHzTggjORnBhGpU3P8ForzWJ4B4LSTCTvygX/V6O5GcTtCg
 Dr4bDZitkPyKKA==
X-Google-Smtp-Source: AGHT+IHU7nhiu/3snUVF67xZTFrp+x0ShL1jfaxpOUyqIg1/bbYLtfCrEjTYaZ/2zRARAyHdA6uowg==
X-Received: by 2002:a05:6214:1c86:b0:6d8:9124:8799 with SMTP id
 6a1803df08f44-6e243b8f605mr56287876d6.5.1738168446181; 
 Wed, 29 Jan 2025 08:34:06 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2b76sm56636996d6.107.2025.01.29.08.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 08:34:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: raymond.mao@linaro.org
In-Reply-To: <20250129102102.1844476-1-ilias.apalodimas@linaro.org>
References: <20250129102102.1844476-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-master-28012025
Message-Id: <173816844516.2140900.3625948826462989126.b4-ty@konsulko.com>
Date: Wed, 29 Jan 2025 10:34:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 29 Jan 2025 12:21:02 +0200, Ilias Apalodimas wrote:

> The following changes since commit a517796cfa5d8f4ca2f0c11c78c24a08a102c047:
> 
>   Prepare v2025.04-rc1 (2025-01-27 16:38:46 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-28012025
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


