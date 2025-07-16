Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56E8C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 22:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7DB883276;
	Thu, 17 Jul 2025 00:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RGinYpcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB35E830CA; Thu, 17 Jul 2025 00:15:12 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD19C830CA
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 00:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c27166ab3so269051a34.1
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752704109; x=1753308909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EIQYPji1I4n+wM28b38gdBRqjUKXOAjiZ36AfOLWAs=;
 b=RGinYpcOgXcseL9CJ2B66nRUPKzE48o/HFoEKmVkD7UOmnl2/q+UatK3o9FynkxOYa
 mknNkCfpkbPkcbZ1twfmpY0NFic/BlcAnbnFs0s3qyqPY77CY0BwSkLWH6pDyq8TPAUe
 SVYmVgKmhXv82am4MaE6GUI13DR11Z8am68+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752704109; x=1753308909;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EIQYPji1I4n+wM28b38gdBRqjUKXOAjiZ36AfOLWAs=;
 b=KdMx5oO77Xhd/j38Z0BIas2yNyqFyw+JKp/0B7M19mb7AV9QnaJArh24HvKaaIkrb1
 CH8S7cipTN4BReVA/2KkjeyWnk7QLny4s/XkecK1NMUYcVUDJnuVXXGOXBJgWWc5hCjk
 nveFUaGltyRDQBI9M13ZyNuAmBy63Y4GFwU/II4PnIramPEuu6ngi87NUANICgQND5LN
 W59GlEtwKD5lDnKs/GfouJu0dWofHBbCMP1S6iKa+cBRVwUMvwbohcy2M3+aDskoOQHq
 Og7geB6eWP2fagr6QgMTxSyzOHaxJojXSVcVijhcshCE0+KYGJ1aWGE4cbXv+7C7Q8pJ
 SC3g==
X-Gm-Message-State: AOJu0YyOnRTUpI4UZ+N4fZuwTfBDryi+UdEUPk7Os7o2o/iAwTiwcEkG
 xRR50AcikK2Xj2OaXuGpHZUTJB82WfHps2k5llTu7aYWNznafamDdJtXzn5dD9atPN8=
X-Gm-Gg: ASbGnctLDpJKJWNye2H1m158dtx2URbCEqQRd+vMpp1MrDw7V6IUKebsHO7O2YDf50D
 yYcgJxHvaDF7+qIehkcBs8Zo+ZAoaH/fyni1LIdjHftErAnTdrnodGEfSbJMYaCtdbZWt9VkBmE
 O1RYPZZmPh7saFdCH4jv9LqMRgX/s2J5zTLYnrZow4AAfErITJ5uVwp913aX//6LpnH5KxwEfPw
 hEXL+A2qSZoZJleJttFxVsbtmKDYSn/qSTlLwSeDvj3PGzjgSBv+stFykRdPpIkSprz8x83Ki0b
 fP21V57vOvJW06Ncx0SlzFCGy+S0cv52S22ZvflO/iDQdVIa3fZA1j91BgA2GyxHn+NcwFG9BPG
 1H0VmVRXEB5rAPtUWfLfZ0d2zNjfuEIQM2GSAnf70qJDD2h07v1lV4A+rWM9yj5ZE5A==
X-Google-Smtp-Source: AGHT+IHRDxO/fk/znBgGno8vDc1kzBWsGyneHfDDWKBToydYsGH25YJ7SBbkqZUVsyPmmm2Zi6twvw==
X-Received: by 2002:a05:6870:3048:b0:2c2:5f8c:4630 with SMTP id
 586e51a60fabf-2ffb1ea478fmr3201805fac.0.1752704109389; 
 Wed, 16 Jul 2025 15:15:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116d3541sm3949246fac.35.2025.07.16.15.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 15:15:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Andrew Davis <afd@ti.com>
In-Reply-To: <20250709110751.663614-1-ravi@prevas.dk>
References: <20250709110751.663614-1-ravi@prevas.dk>
Subject: Re: [PATCH] arm: dts: am335x-evm: remove duplicate chosen node
Message-Id: <175270410851.2648161.15830953112108701219.b4-ty@konsulko.com>
Date: Wed, 16 Jul 2025 16:15:08 -0600
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

On Wed, 09 Jul 2025 13:07:51 +0200, Rasmus Villemoes wrote:

> The stdout-path property is already set to this value in the other
> chosen node ~15 lines above.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: dts: am335x-evm: remove duplicate chosen node
      commit: 343a30aba38f753161b8c5007898211cc9d43b2a
-- 
Tom


