Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F54CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753F7836A3;
	Thu, 16 Oct 2025 00:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aCHULgQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC30583655; Thu, 16 Oct 2025 00:57:35 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8F4835FE
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-79f79e37c04so74205a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760569051; x=1761173851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gWMyq+X90YEMEcMp2sS4Mx4lvQlS+PRbsMWryS0gPG8=;
 b=aCHULgQrAx9Zs1urUIy2Dqn/X+o2KmYcjWj6RBRKKKiXSSUXXT33x0mKiX4mqsZyzB
 MggS8qNPQn7R+VkcGXGHDY7ZBRvZJBObnRMJQGm87c18Fy1qOQm5M2cVlNdm8CABPEVk
 PGBedUsk3NyA7GAnUwVaaajcVvW04MoqYb2i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569051; x=1761173851;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWMyq+X90YEMEcMp2sS4Mx4lvQlS+PRbsMWryS0gPG8=;
 b=lAsFuFeUnMMhAhubrz7ENSsk/iKQQitRiVs+N/L8kSQxNjoA8kC8iVVk54zF5RJmiJ
 08P7wmf9aM+kMR4p0qaIVDi1eNEMeazHPQoWRbo54mJxOI9HGVLcX7Hr+ssVZx/XmBO1
 2T8Z5s5xohArPtvdyrhIduHZPTnD/aN8/wJ4TF5BHd63UlFjmX1fk0z8MMEmyk30MeKl
 LqNXhEmALlFXPI4/9JTdoQLvhMhWB1Je0iCls68o1Uux53WMC89Ni5UKfw+DL9QNn8Ao
 ZTM5iz61J0QIbQWLqMg9OPw25WMaY4RULLJNiy1r+CaVNcF6TPloWDKiBcwnpLgKmZMy
 vpUA==
X-Gm-Message-State: AOJu0YwnrtPDncw0ZVNQA0XT/jG9h5LbyULo9FCLNpCPofq2TwWSd1jd
 wHm9kxgExZMBLPbaXt8IWTfKk/J13YSgxe53Vk8E6DLbTDra+vgn4br+FhA/KrdBz3w=
X-Gm-Gg: ASbGncuoMBHqXx8kvqpOASXmU0xJiRoQkZib6x7DjqzIxPiufhqllLyqYhNMe9zNsgd
 fBabti/AeNcCkpvuMBSsob3sqyDTneoebNXPxdWsgaXTNk8M9vVDSADtfIXAQ5F/aA95NXzuU8I
 y1DZAbeYjSQ8WpBxZhzUQ+Syjwvbcv+mICpMfnPkzR7Rfec0unUC980a0oNGNJzECO8I0teMSgo
 CRzQh2mdQLjro2AQg08erfYLApUjjz7MUq5/YE6IBNfgtxBM0PcQXGG1wJ7fGCt97RNeDXKqBZg
 wKbA4bVcvf5vRJdqgFTEmET/TDu7Yq7A2ezEK0hbRdCq0xX0bQ7Fm+lJZdjtcqZT3kvrFejMMZK
 S5coOEwLb0kzhLPGI+3XDctbdg8K6FHEm1GmHb1EAR7DrQNmAqBDYrvmJPrXLMGkZhLePFuTpbp
 hJJ87mzXl2zGApEOibn486Z9foplhwF5sDv8ruud/j4kirfaWY
X-Google-Smtp-Source: AGHT+IGLMVkDCCkjyBmvjfmrXt5qBoxbbqkNJwrIQubOLk4uMIR/BsfOcMKGUYyrRjZ1gqPsxbmCsw==
X-Received: by 2002:a05:6830:6507:b0:7ba:8107:d559 with SMTP id
 46e09a7af769-7c0df7be2a6mr14738107a34.26.1760569051559; 
 Wed, 15 Oct 2025 15:57:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5774854a34.29.2025.10.15.15.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:57:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
In-Reply-To: <20251009060546.1596688-1-venkyada@qti.qualcomm.com>
References: <20251009060546.1596688-1-venkyada@qti.qualcomm.com>
Subject: Re: [PATCH] .mailmap: update e-mail address for Abbarapu Venkatesh
 Yadav
Message-Id: <176056905084.760819.15259915558771668063.b4-ty@konsulko.com>
Date: Wed, 15 Oct 2025 16:57:30 -0600
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

On Thu, 09 Oct 2025 11:35:46 +0530, Abbarapu Venkatesh Yadav wrote:

> Update e-mail address.
> 
> 

Applied to u-boot/master, thanks!

[1/1] .mailmap: update e-mail address for Abbarapu Venkatesh Yadav
      commit: f21920f7e7952b3f9657bd1674085211925e52f9
-- 
Tom


