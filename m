Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E51C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285F788637;
	Mon, 10 Jun 2024 18:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="si+faiSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B15188651; Mon, 10 Jun 2024 18:51:09 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 764738863E
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d1b33e9ac6so2422693b6e.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038266; x=1718643066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a2oqglSbv8aA1BmrmM+lQmTO3GPADwFmMqsZ+Etdh8c=;
 b=si+faiSLt4tivz8pv/aJL3WmwgCWOhqQ/7dFgwOMCxomBc56E1iO6zuMHuZkhL+VwM
 0PxVlJVYyfFGRk5ejBkOPjTKiIi962JUEaNSpdCRHRJVcC75fbPvi564dyYxPLrnhkU6
 Nu+n8LTaXkoVkwTdCksGPm9CgP46k2jyEi/Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038266; x=1718643066;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2oqglSbv8aA1BmrmM+lQmTO3GPADwFmMqsZ+Etdh8c=;
 b=kOgtoU16Z3qsr/TVzhod7L1UIGlZoUmm1ZZ4GAHYxADODhxXO+0F238Sl9RA3i2URk
 +IFNrYswN7kr/0hQj7hYoie3gaSmbfnqOjrlWHUkFDCo53PfiOnfhlLw1R1wqOtcAX+H
 QACLDhp6h1/fg3Vu2jXFhS9KNIfmWYKC7oHAZ2jknC9PUngDJVolZQb3b/X9uNviVKlz
 vqorr1wNZX+Byx0xiFFe6OcHP8eClvqcDR4azPTy+Jsvj+5zQrXS4bE/ssMXZzkKDs89
 pm+xrd89a5fDO5U7UR8N/FNEcQ5WTqdrq4Jf6BIfCUbBZdmzplUifLm/32ZY29vVVkcM
 1CXA==
X-Gm-Message-State: AOJu0YwURpR5aQUCIISSsgbm7IotXUtV+zh6rXVPHlnoUIEjfvhuuCR0
 UATT6kDROaNJwBZA61exc3m/VDnDhrBJobbut8zaWmQFLSFkquyYkSev/pt46oNXNUONnV4H7nQ
 F
X-Google-Smtp-Source: AGHT+IHooOAvlP+ncnFSHh7/qrZJ+QXFDO1fzfWNfeBkmw9XhkcN/dK7ldMPPincGgINihzqd3yy0Q==
X-Received: by 2002:a05:6808:1817:b0:3d2:2851:27c6 with SMTP id
 5614622812f47-3d23464e25cmr106172b6e.19.1718038266209; 
 Mon, 10 Jun 2024 09:51:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb57sm1668475b6e.10.2024.06.10.09.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>
In-Reply-To: <845fdc163529638fcd2c16ef084a075c61fadc76.1715747836.git.baruch@tkos.co.il>
References: <845fdc163529638fcd2c16ef084a075c61fadc76.1715747836.git.baruch@tkos.co.il>
Subject: Re: [PATCH] fs: relax ext4_write_file() dependency
Message-Id: <171803826554.2405130.15474207317073699702.b4-ty@konsulko.com>
Date: Mon, 10 Jun 2024 10:51:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 15 May 2024 07:37:16 +0300, Baruch Siach wrote:

> ext4_write_file() depends on CONFIG_EXT4_WRITE. Allow build without
> CONFIG_CMD_EXT4_WRITE.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


