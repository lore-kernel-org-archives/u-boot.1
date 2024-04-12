Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE1FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 22:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8321C881C9;
	Fri, 12 Apr 2024 23:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHjWNkqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553A288229; Fri, 12 Apr 2024 23:59:39 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63BC88211
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 23:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso11335835ad.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712959175; x=1713563975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBX5Zfg7THoRqAnb/lutndw2wzNo54hBAAJqHPjo55w=;
 b=XHjWNkqULYM2/YO8aPLnJ6DO0BVeH4+uC6Ri9Tfqq4G83Pb+rVEkH48iAdC/S4eLgS
 JFuuGkDvYCczHBjpQdPAJ7A3nGGhVSN7P3vWcjI7ik3FC2EYH9kn42TpIlWxNVdrFgO8
 YqwHY3FxxAFJGo7Pi8QqudiGy0Lu0TjYUdI6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712959175; x=1713563975;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBX5Zfg7THoRqAnb/lutndw2wzNo54hBAAJqHPjo55w=;
 b=NQtMvVkPGNu7j6puih6OKxMEVu9e/YrNCB4lGJZefH0N1FeYt8qg6GUsya1vuzAT30
 nHxzakZi7dTs2MWvIhNgPNygYqKQK6o/k090xFLGh/7wxl/oLhMdBtGZK57LaV2nMdEn
 PD0O1m8Hqv0izQXJLkOtCO9wcX5fWbYvx2h44s7uhjzkA33lpEau8POwc6A35xxX4her
 g1tdiJgS+zQJducTBZyZPzVPFZXlzWKF0IZsKPRrT8z9gExkx5HEqYBCfAAHBeqDn8xb
 CJR1FMOUahV40hAFWe6xrb2KwXEHmupcFGCHr4kh2zwZx3UW5MNIgz7jM5tubFCZz1Cj
 V2FQ==
X-Gm-Message-State: AOJu0YxKXqmVZ3RiM8RtnTxwBWGDctoXYaNeNkZ3yv435MSicRMdo3YP
 gzF/JerMoM7UXHfp4meofTO3aVnF+xQyQ7U9B4UCX/AQ/FjIC8k9X8zORcNS+1H//o7+AlD5ZO/
 4SsiG+A==
X-Google-Smtp-Source: AGHT+IGTRKw5UA9LEng4eAOH2V3ll1IkH4rVnKC7VipAXpmXfcbDMQjnh037dyDLss/GruQCLqtS7A==
X-Received: by 2002:a17:902:fc44:b0:1e1:1d5:f857 with SMTP id
 me4-20020a170902fc4400b001e101d5f857mr4206664plb.34.1712959174971; 
 Fri, 12 Apr 2024 14:59:34 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 kw7-20020a170902f90700b001e45240eca4sm3472958plb.196.2024.04.12.14.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 14:59:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de, Parvathi Bhogaraju <pbhogaraju@microsoft.com>
In-Reply-To: <20240408085017.2849211-1-JJLIU0@nuvoton.com>
References: <20240408085017.2849211-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] net: designware: Pass all multicast frames in
 designware driver
Message-Id: <171295917369.1044279.15563244192142114449.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 15:59:33 -0600
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

On Mon, 08 Apr 2024 16:50:17 +0800, Jim Liu wrote:

> Allowing multicast packets is required for IPv6 neighbor discovery
> protocol.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


