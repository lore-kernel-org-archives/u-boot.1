Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6817109E528
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58F184027;
	Thu, 26 Mar 2026 00:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jZpdctqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4EE83DA7; Thu, 26 Mar 2026 00:06:00 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5DC83FD9
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4670464029eso192114b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479956; x=1775084756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHXbm/FzFnCIYCIOblg6x/2lGtIp8Wz8CiR4gfGc8jk=;
 b=jZpdctqsBjKXHigqfLXhK91EXHTpBYLGc3npsnMdagLWdY26z99vylit1VgMgwHsVW
 9qOWg9kSanhGddPaIVC3QiHYXL/KapwOMt17K0QR2cyl92WWZiMsp+Upg9r2q9FcUOLt
 rhAG0iqYN1/5Xtr4BQCUNy1FVD9ZD/MMGVsbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479956; x=1775084756;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZHXbm/FzFnCIYCIOblg6x/2lGtIp8Wz8CiR4gfGc8jk=;
 b=SD+3Wi+uUgOaKonuaK0cjs7wYgxwFs5mtCVQmJ1J62zmWAnLZCzzYg0XHIAQd1Z68t
 NXBP8ZVZ7RAI9Tj1SEuG/aND0EOOZ8b7LQ2gWzplS1734D3LfBUAXiSe14sD+0SwdZWx
 sAagEW4R74zuBAgX4Ngv+BkxtyJsM+f3htwy30fH1+6cXicbFXU5zE7WXbeoViry9UOy
 9KtoYxo14c817JRXh/KhOtRlSUagYwrjvW2cOTM2KVK7q5gr5JqdxBRZVBJ2qpCikt+L
 5qkSCPDIXRGEa+AoXkstzn0RlmRn4ZxorUm3odArZ1XbxloTYih4VW8L3OwtCVIw6171
 PP1Q==
X-Gm-Message-State: AOJu0YwyU7RZ9nbdzXm0vxmSAur+cbFllGXufA1QK5gMzmnCytarrojL
 KWhsCWYhVVgrexJaegoAZXSTUUSB5e3hfsFnJovCeoXmI3wBuTy0luzYBaj2gs9uYTo=
X-Gm-Gg: ATEYQzytEMH3oMxBmNuGUPGFStGRLHN/P+CQjga4ULXoJTtg7B9MuS03qJQSOt6O2fY
 iPE79npdK008pq6b176c4R+DgvuMYdJJqYVpZHGGr0cDbkR3fKbY8Wejg1+okJi+7fPiiuSbjFN
 O9N3jQMnBE07BI4tFiyteWl2gkkn3qP56phJ8mEqf/hwfJER6gFVI6BbHsSuThI0eoixSU6LvsT
 q8g0PTyKjrRg0M6wzR/qbnxOLTn1K20/pd+s/Zfybg6hASuF25SbeFFWeChvDsMaF0WAXsfa7v2
 L6/FhkAo3KsyGmlzdBpG+/81bcjp62ZTe41KprUACOdKztfemZdpkznFU9LoVIOBbWjHQw9UjKK
 uvr5Kh8NQrjsX6b/IpZGx5eeFpemD/nBE6+cGb8yRZ+cAsBch8fDRaOLpEBO1Pk+sazUP/U2AAs
 1/4SwcKpDU0RzUL1NuLzU1CSCd3ba2Ob5HBUORSVn+HvlQc7vnmD/iqn7swy8H2qACKo49d7Bj5
 HyuRM/cQTKMdbP2XScMZwAMwJZwfbAHj9vVoxjVuwlwGFY=
X-Received: by 2002:a05:6808:c1b0:b0:467:272e:892 with SMTP id
 5614622812f47-46a5c7f5165mr2598899b6e.57.1774479955957; 
 Wed, 25 Mar 2026 16:05:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260310162610.1163833-1-trini@konsulko.com>
References: <20260310162610.1163833-1-trini@konsulko.com>
Subject: Re: [PATCH] fw_loader: Introduce SUPPORTS_FW_LOADER symbol
Message-Id: <177447995495.3508238.10100414077744113326.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 10 Mar 2026 10:26:10 -0600, Tom Rini wrote:

> The implementation of FW_LOADER requires CMDLINE to be enabled, and
> expressses this. In order to not have to have every users also depends
> on CMDLINE introduce SUPPORTS_FW_LOADER. This depends on CMDLINE and
> ENV_SUPPORT and then we have all users depends on SUPPORTS_FW_LOADER.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fw_loader: Introduce SUPPORTS_FW_LOADER symbol
      commit: 4ed440e6be80cbbb45e11b01d7cfa5ce3064a2f0
-- 
Tom


