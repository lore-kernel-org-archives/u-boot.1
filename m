Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0541C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 13:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215F780F9C;
	Sun, 27 Apr 2025 15:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i5YIUuqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EDF880FDA; Sun, 27 Apr 2025 15:52:29 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013618056A
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 15:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7304efb4b3bso2166737a34.0
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745761945; x=1746366745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGh4UDKoCP6O7/aFF6OzDBO1SZEiK5QPxnW1bvlOYRE=;
 b=i5YIUuqS2vWphnBHIy9tFcZBrTbNB3qIlb8vd+r+96yXja3wtDpwfIRhHKXQAVQCIh
 BOfBn+3CqtJVv1UYLCm/IIwjW5CC8D0Si74OI9yIO4EZItvS15q+AmjlciKt0A0JWWgU
 Lv8wrK6+7jGETAaexjx+7TotYxOgZZcH6uO2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745761945; x=1746366745;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGh4UDKoCP6O7/aFF6OzDBO1SZEiK5QPxnW1bvlOYRE=;
 b=w13k32xsc5en3IW5vJmmB5c2NPUNbbNy06lm6+l4ZFvUInNFft2Lqo5RqieMEoHBQv
 UfLbrUgwav1RhFriBhmHiAX+VodiDAe8L3PsJY/blzd6O4W8ULcr6PmJydaDV+qtIOOt
 ycb0iv3Vtqk9yI9huWsUTA8/t59SSPhVDJrfjg1q8HXJ9SZnyyhtbgRBRzDsq4cUYsPA
 IIQrqTPehtNtT/xtf0e7b0OXftQFAm/32elzUOZB/rmDExm6w3h9ajDOD90JnBLmYuGh
 uxGNt96evC/NiIVFpXQMwC+3UWey4aCA4YbWyUMCQBz9W5i2mLvsvx6vec5P3SdOWNyh
 3adA==
X-Gm-Message-State: AOJu0YzNSNlEWxai5LhQGX/YEF83dqAWTGlTL72Dmcr8q6Zz9g8BJM5r
 jknT0uKUDkgN5h7r2PxkKAw+NBamFKaqJFD5RyzvyJWHg63lv91cHjnZlD8SjogV2a6dy9v6wQt
 m
X-Gm-Gg: ASbGncvfdvSbauPjR3wpugTR92Se3PiAISj7PiWpZXlGEft+Okcu7OQCPyE6gnVmwnG
 3sQQqBTpLJW0Pr+g1dxpCaMpJAHYlaXRgIw3W3Hp0Tq4CxoNburU4Xr/AHdco93a1z4U3wH5JWa
 H6G0LK66CEBnyXw8w1YN2Gc+FQq/ZqOZjx8lZsv1RF0CgwAVvAqPk3PtjpHkv/UvOKRGQDxC8VN
 d6ZyHY+o4/oYriHx/hkByhDNoV+xmOzpo5Ov8usbBGSrbA4hH+NHdlN9HJwHqTubwcIbgbz7gj2
 AEl9FKnOGlpyXSfmJVYFxpBezF2wwkvkyg34C3mRH02fVcrHNZqD7eGxOnd9U9gRObyXUMgkO/m
 P
X-Google-Smtp-Source: AGHT+IFE1v2A9YimSp3J3KsMlHl+UP07/sTjOEUPJh925FiixSGDPXl5jWobLpRFdW7tA3RZID4ddw==
X-Received: by 2002:a05:6830:2a8a:b0:72b:9bff:abb with SMTP id
 46e09a7af769-7305c9fbb94mr5131826a34.19.1745761945600; 
 Sun, 27 Apr 2025 06:52:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2b208csm1423164a34.40.2025.04.27.06.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 06:52:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250427060301.709506-1-e@freeshell.de>
References: <20250427060301.709506-1-e@freeshell.de>
Subject: Re: [PATCH v2] board: starfive: visionfive2: Order board detection
 logic to match config
Message-Id: <174576194430.947627.15678153805167295714.b4-ty@konsulko.com>
Date: Sun, 27 Apr 2025 07:52:24 -0600
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

On Sat, 26 Apr 2025 23:02:52 -0700, E Shattow wrote:

> Fixup previous merge resolution of this series. Intent is to ease code
> readability and logic to match ordering in CONFIG_OF_LIST
> 
> - Remove "starfive/" string math
> - Remove redundant local cache of calls to get_*_from_eeprom()
> - Match name before EEPROM product_id in board_fit_config_name_match()
> - Remove single-consumer FDTFILE_* defines
> - Do not set fdtfile for visionfive-2-* when unknown model revision
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: starfive: visionfive2: Order board detection logic to match config
      commit: 62ea9c329a0d013993bae538c55dfea06e4551bd
-- 
Tom


