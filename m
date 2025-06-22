Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B7C7115D
	for <u-boot@archiver.kernel.org>; Sun, 22 Jun 2025 20:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719F281F66;
	Sun, 22 Jun 2025 22:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L48uenGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA9D782CBC; Sun, 22 Jun 2025 22:52:35 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5BF8210D
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 22:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60be827f2b7so2079620eaf.0
 for <u-boot@lists.denx.de>; Sun, 22 Jun 2025 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750625552; x=1751230352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BblGfNY+4/ceqPHZx2NmeZAbWFm0CxkTxVhQWfwzTkk=;
 b=L48uenGslSjwCWMQKbbLhoAXv1ksyuFFtWQD5P0IXW+7psGDBZd9qau5dnQESokIOi
 ya4GVy3JsoSrViMxs41mvtEmpsIucCe8E0wmF/3mE9UUEwix0R0aSjfYPaxYLT6nMbiX
 dRK7BbqiO80Ojhwc1NLtKp3acYrK8WwYi0TAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750625552; x=1751230352;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BblGfNY+4/ceqPHZx2NmeZAbWFm0CxkTxVhQWfwzTkk=;
 b=H3pxAlNdJnUmTT6V8QqGTDtV+aCdBDJKvcnX4h7S5R+n4r/UtuV4oKkhxgvpt2/JTS
 1uQWiSsHI05cNyumiqaerJj7Ngk3YaaFB7/5CJYqkItPfIxMDr1C0dW+hZVnglcZ79wx
 IveHizE1q+FXS0s49K/MU9OvFMzhZKgQxKjenrm694wvNdtLHeUbxmGb1M2jml4qc3gV
 gO4fPx4OsauJ2VGDRCZE1pf6wO4ARSfZ7aGIOby4/+CLTCy1V7zKVHDas9VNCzOJpnJ0
 3O5p+5xAyLmiSPWPt+K4HAQ6p7DJvD2YPxmfFLP3SehndzFGL5RCIkC/yN9wTZzKvMeW
 rMOg==
X-Gm-Message-State: AOJu0YyKRWSpC39ZZ5xLGxhaXpv51aGT6F+UkXxgcxvjpOvVljXQEjVz
 ja0+7raYB7C1eV7hQiYFRW/n0BQ3wepxdD4eHfaeL6KSGBlPt69UermuawfSRtQHmTRr9/KjnNA
 Bc301h6Q=
X-Gm-Gg: ASbGncv/BtmfZw5ZaYyJtR06L2LmIPNGrW49AzU1uqCDxSxhlMCy45mZYTet78212ka
 ypeYIh6hZqA16tMWpxYE5jBHUsjc/BthzJvspGnZTx8QK8PrBW3AkxeZP6MMVwmLkwVAki+sDHd
 1EFWVcLuu9QIXB1ailuM1X4wQDXw4yYLwJrCHgZqVJw173fp5cZzVIe8WNzEMDsuTZmHjjwTjvn
 tQxsv6zLzgYvB0+/t/q77DOlaHEZm7/pFgUUIweCCh43aEeb/IcplJ/BjxGQZFCmbdSVvosv5c2
 JdVanVVPFZlf53zv+2MCr0AwlSkecdiTKnwKnBG3+tzGNeymoSHxyHI88PjZufbVzrhpfOPIqsl
 cDLR+dqmg8zAOGoK8C47f4dUW9bA0DbEJ
X-Google-Smtp-Source: AGHT+IFW/eQkZveKPGogIUJDGsN3nB3fLZSlrdZfElUJtAoa40hMnRR0hTILUMsYRcNkOw+20zuz8Q==
X-Received: by 2002:a05:6871:240f:b0:2e4:c5c8:707b with SMTP id
 586e51a60fabf-2ef2a7517d4mr3998879fac.6.1750625552337; 
 Sun, 22 Jun 2025 13:52:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ee665ad4a5sm1357117fac.18.2025.06.22.13.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 13:52:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Baruch Siach <baruch@tkos.co.il>
Cc: u-boot@lists.denx.de
In-Reply-To: <e3ed716de67cf4f46b303e9e7536b4938fba5a68.1750262675.git.baruch@tkos.co.il>
References: <e3ed716de67cf4f46b303e9e7536b4938fba5a68.1750262675.git.baruch@tkos.co.il>
Subject: Re: [PATCH] net: designware: fix bus address dereference
Message-Id: <175062555120.3894397.4855403516951831200.b4-ty@konsulko.com>
Date: Sun, 22 Jun 2025 14:52:31 -0600
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

On Wed, 18 Jun 2025 19:04:35 +0300, Baruch Siach wrote:

> Device bus address might not be valid for direct access when the bus
> address and CPU address are not the same. Use dev_bus_to_phys() to
> translate bus address back to CPU address.
> 
> 

Applied to u-boot/master, thanks!

[1/1] net: designware: fix bus address dereference
      commit: 9d169ac9733b5c3f208921a1d82f4fa8ff708258
-- 
Tom


