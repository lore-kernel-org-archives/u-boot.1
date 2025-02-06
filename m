Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604E7C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 08:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAD480562;
	Thu,  6 Feb 2025 09:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oANxRwtv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D1A806FB; Thu,  6 Feb 2025 09:08:31 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B725080104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 09:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso3421075e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 00:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738829308; x=1739434108;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SnE427k+4UNbEIzxuni2vLA1joZUyP4+db2Tf+mOJw=;
 b=oANxRwtvEOstvm1fOOrgbpRc7iiDMa0pG9Y6JK1svh6jhN2fwGkhqMhqpOsDD63iXw
 VYf3ZruRFLY9DfJh7SFhjKgVZj9Pwe8wma+dirmYfVPzcKz2Uczq/pEnjs38hyoebWOO
 X1rnusiHJmIbT7iHMoDd4rKPHEsncImf/6hJcrOXd2MAv04rsZW7FyCqRnYsCCu55hJt
 VHlEN2HZ4oa0CoelIhF2fEVVk9wagS7D4W0FfeFyUqwqmEHfKFbGTA3Kin2pQAONqE8x
 yk+VyJlndS+LqYiHpFNMeGSKOefDuwIzPNO99V8sRwJZsg2o7L234XvQvl9bS13yMbVq
 68iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738829308; x=1739434108;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SnE427k+4UNbEIzxuni2vLA1joZUyP4+db2Tf+mOJw=;
 b=lYzPqEG7iw03jWu6fTailPs9oK6vmscl8UtFIS7DM6IWzlq8KH/3bHCzcGEsN3Xdn6
 rJKdLol0vSyDOQJZx5+v95XWAk9r2ORG5aQnGYctPlKDwRsMLfcLGRmXCXH2ZXeNs9BW
 bQlRZiv1kohmNhO/75NQZlaZt7dboOrdlrsvh3LZ8mYmJv8wCM7EEwhAL4uSU06O6R+i
 m+ZYG/hsJalmF9chfRrTHD3jcLoCv6e929veI6bm/9RdY8ivfW5AlAoLtfiY1Olwou0H
 BYPeHgMJ4DcL04gmLUWpibPlP7upqzqMRKMkBDq27eNBNeOJn0yaIOh6YQbhT/4GT39J
 UAnw==
X-Gm-Message-State: AOJu0YwVxX5SJkPoR7VvZlD8+mNWkqXAfEw2vx3Sqn4QbnUfcCEt9s8d
 kaaGl/wcQhKi8d4PBES4v8jm83lcAgYSdxdqg1GM3HSrapgqrW/uOFhvlKAlIyI=
X-Gm-Gg: ASbGncsxGECCTHe9OBK6vAvryGdgc16YRXKZIjd8PuGzhYzO8NuaQgo0W3S2UzIdUjt
 d4plA0qkAjrQ4qkA/lPBhU7BZg5e5ePntP4mNybf/fXaj1DBsYMsMKiV/Hk7CMr02UTyS1fuSqg
 dfqo05KyZLnpb1PVahpnq3TY4i1qhztXdEqjgtgSRc35VlmoRV1lwQsYsUbgPVqNaqTA4aw4Rn+
 RC0+1XaJx7MTJmAUbCL0E1b/9TixPEsc5XB6CWfMfsSV3ZyqNovV9Fyll+t2GRU5KSu9lnw067N
 lY+Zid31sfG9SrN2aOjP4SiNgPc=
X-Google-Smtp-Source: AGHT+IEwKAiDKSouiiP+vlsYsaW3qCCkTHJwktbtz5md+de739QIbOIgDB61p6sk96koqxfwNrAMNA==
X-Received: by 2002:a05:600c:4f03:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-4390d42d8a4mr46225805e9.2.1738829308171; 
 Thu, 06 Feb 2025 00:08:28 -0800 (PST)
Received: from [192.168.2.172] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ffd8sm10853055e9.10.2025.02.06.00.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 00:08:27 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Michael Ferolito <michaelsunn101@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>, 
 Kyungmin Park <kyungmin.park@samsung.com>
In-Reply-To: <20250128030945.1219589-1-michaelsunn101@gmail.com>
References: <20250128030945.1219589-1-michaelsunn101@gmail.com>
Subject: Re: [PATCH v4] usb: gadget: g_dnl: Fix NULLPTR dereference when
 serial# is unset
Message-Id: <173882930729.236396.17050620630502515819.b4-ty@baylibre.com>
Date: Thu, 06 Feb 2025 09:08:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

Hi,

On Mon, 27 Jan 2025 21:09:45 -0600, Michael Ferolito wrote:
> The current behaviour of this function will dereference a null pointer
> if the serial# environment variable is unset. This was discovered on a
> board where U-Boot did not have access to the first 256MB of ram,
> resulting in a board crash.
> In the event that U-Boot has full access to memory, it will still read
> from address 0, which is probably not optimal.
> This simple check is enough to fix it
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: g_dnl: Fix NULLPTR dereference when serial# is unset
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dcf1c627cf436191919c5a3b153d1033245b54b7

--
Mattijs
