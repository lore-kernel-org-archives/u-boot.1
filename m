Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718E9CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AEB18344E;
	Mon, 29 Sep 2025 18:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ukc5SWLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E005F834E1; Mon, 29 Sep 2025 18:07:30 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2868341C
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7b3e2a51678so1592469a34.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759162047; x=1759766847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgiL8BOEARhDjXQ5BQNhMMUH4hG0HZBxF78zElnTbfA=;
 b=Ukc5SWLi1m5BkGK/Er+KBw005QgzFAVs+n62qR5vsf9p4YExALaQ25hs2F+BWZs7Pf
 Cn6NiK2zbiCa5X+s+79QYzGAyuCxsgDzuu6b00zODNcUCHLnK4OvkzMuPjR5IqpOc1OY
 6zxpdoqosjsFQuICb6vwEY8cv786OVT68q5i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162047; x=1759766847;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgiL8BOEARhDjXQ5BQNhMMUH4hG0HZBxF78zElnTbfA=;
 b=n0A04xw6J5WtwPWbyoFjb5JAVjvilfp3H1u4BeIq9VWs98fKxoE3bHzzDd8J/YD84W
 9ob/s9kLcvmL53/wSINOQqv5eHvD5KN1nVDyNY6UmhZT2s/5SV/biLPrcMHPPyruDp/s
 DVtatePdwpF7ZVrFcLSyzFxDLhlq36n2GD9nCr+AiL9PLE0XjZEq2qwKw646aVva00bw
 VbW/M1NFgzHcKAsyXZJsO4aOOLkvraif099ELeSXBTbWrHgjB8KENEiqiC5YFzuQDgWq
 XbpCk1Dv2xQKJUadcxFWbL2PRBH49sFKevOenG3XJiagSy5axtICKliNiH/SZJS3Vi5z
 hsCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw0iITtr3/xS3XDLMPUFiZ2F//zfNxL62PJ0RFWoPRQFVPKt6WtZsUPQKb5rRGSrteRy5p564=@lists.denx.de
X-Gm-Message-State: AOJu0YwqqFFauRX3LV+xE8gw7ZEVcaoz068L6SP4Vla/fkn6/wRrH3cM
 ryYtwA1xymLu4KBa9wsQll1+wi3xG62uGDVjbgks8EN8setTj+Pr9pJs7YgiNbA2JEg=
X-Gm-Gg: ASbGncvsacqbT35o7cZgsBGBQ40RqM+eoiVFWr1zpnYIqjio/zN1OQQve8kul1pHdRd
 gJ5OB1x/BOUjd2HZ8Xyzg/4AW1i7ZTOjNeqIe3cOb8e08P1e9D1p3XQrt2NpIQDMDryo4XqKCts
 egi2OhlTdzIXuiaiHhZis6WZo0ILJSKrbUvnOBrVgZtCSmyae8+Lm+4ngwtNkFZmuvypKWi9F9f
 W99/cSr4N9ve7rhKNNtgD44SANwrbsRSQFmHr3uL1mK0BxDzWKid3G8lynVhLIoap4KGk0ovit4
 M6X9Yjt8/RgUeFtzkKdtaLzIEN72ZD2FA7HFG/r7THF/TOk+dHPLKJzKlnm80f1wlzhFNy5fgax
 fMfyCJbMiNw7icpH3IU8pBDUlpR0mNa7dHqV1Bu6wqNmSXcAhfnl0MAFYN3nYsLeKUg==
X-Google-Smtp-Source: AGHT+IFaiA+7X9E4TI/5x2CzmXHeCzQr7Gey3ajvhCV3/6yuwAK9Tsl795TL1NwmV6XcY3W80vt6fg==
X-Received: by 2002:a05:6830:258a:b0:79a:2e2e:4f9d with SMTP id
 46e09a7af769-7bc55a924a7mr496136a34.12.1759162047510; 
 Mon, 29 Sep 2025 09:07:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23e1682f4sm2689213a34.22.2025.09.29.09.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:07:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: bigunclemax@gmail.com
Cc: Heiko Schocher <hs@nabladev.com>, 
 Wojciech Szamocki <wojciech.szamocki@nokia.com>, 
 Dinh Nguyen <dinguyen@kernel.org>, u-boot@lists.denx.de
In-Reply-To: <20250926100530.732938-1-bigunclemax@gmail.com>
References: <20250926100530.732938-1-bigunclemax@gmail.com>
Subject: Re: [PATCH v1] i2c: designware_i2c: Don't warn if reset DT
 property is not present
Message-Id: <175916204661.360535.7538811434667491772.b4-ty@konsulko.com>
Date: Mon, 29 Sep 2025 10:07:26 -0600
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

On Fri, 26 Sep 2025 13:05:26 +0300, bigunclemax@gmail.com wrote:

> If reset property is missing in DT, then we get this warning:
> 	designware_i2c@0: Can't get reset: -2
> 
> Avoid this by checking if reset DT property is present, first.
> 
> 

Applied to u-boot/master, thanks!

[1/1] i2c: designware_i2c: Don't warn if reset DT property is not present
      commit: 522a58af836598918758b41b110a73f35b9335ba
-- 
Tom


