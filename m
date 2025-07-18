Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FC5C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFAC836D2;
	Fri, 18 Jul 2025 21:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hgUdcX0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8249D836D5; Fri, 18 Jul 2025 21:43:31 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555CB836C3
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73e82d2ec21so687889a34.2
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867808; x=1753472608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2/ABG3R/gYuz9UuA1DQNqPe5mV2S0zVcS3xqjCBK+wk=;
 b=hgUdcX0Op/IodeoxrSDQJPOSzMC2E6orexouamf2iCCko8GCo4f6MmXEeo4sOIiM8K
 JZsQBhAYewCBztfBhUvzVvmYfu8roR8PKqcUBGcoOvSEBs2RyAd1NWSpRHNZoUINPX39
 dvgjtx1XtOcDY/Z7GEurC9FPtMf8oTGyP3s/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867808; x=1753472608;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/ABG3R/gYuz9UuA1DQNqPe5mV2S0zVcS3xqjCBK+wk=;
 b=M7Lc59nT1OEbn6rbIV8wrQlwz32RNG3bEJveFKh4RwEmkbj0dRTL2MefLU2XVpNWuM
 8sE7st+DJbYJeIvMnRxnkThSsRDk7Rp4OqDxim0S1XVJ8c78BFovg5NHgeFlPY+JYZId
 uu9GwS3RwqkVC3RocL7w/i6uUpz1q0cWC4A+cGl5GaxNm96jaER36dGQji5a2mqMkCkQ
 15McrSADfZtqL7THmLusAP1wWi/0dpgBVYRFpek20DVbob6pB9LaR213uRT4QMB0PANe
 1QUAJaZKhnKLP2PhUXEaCWKu1EFzNxEzGCYyUzAZGm7KvNVJCWn0VhBHISEMMKc8yDLH
 Dyww==
X-Gm-Message-State: AOJu0YwFhXhvVMlnTJOeP4sXZSRj1A0fRPrvm+b3UelHl3U398Ye5bOJ
 kPJM1lgAuEiXBIlsymnjYpbJOeoK20eiBNhs0GDgIinm5bdnVEj9dMFhtxr/w5Hcr6MFsJWJlWF
 wLrOLv2g=
X-Gm-Gg: ASbGnctTeKzCxTF0XQ+MiG8NYBaKDAD6yDl3jnxOLdTELEF/NNpvtAW/CDQ6MygjT5/
 G4m5MF5IHpSwcpiy8380lFaapjUkh1R5I+FpY497VB0xm1EVa57Rfgb2Klkj6Z78chqK8IV+C7a
 BUCg7dZd7LfcLlRJFCy2kHULmbuRy5Nzy6k0jkCPtH5PqDJ9Fz+4uwu4hOP1ZnPuiDFlWfu2jdh
 La40jHaajhGg6gHnwNl1b3CdSMM8EdWn0i0zaQRDKfsgbA8/Zhf1htBjWHqLlQlf0VwwaizkuxB
 uhU5rswsYsYpgfHrbShtkUoXwUgUxhG+IP3IiZELZ5Hn9s5VP9pLDVtP+3LWqH3u3gF44gLcbwA
 sT6oTqQ8zQpMjxP0nA2AQmfn8+SGN+dux2WAlIWwcCkTPHuKZNN/idFM=
X-Google-Smtp-Source: AGHT+IF/H6ynnKHZQw4v/mJREM7NIYCIEmz2BzSqxOzFPot6zhbk1x584IZwB3RIzcHUNLCZhApeow==
X-Received: by 2002:a05:6830:3805:b0:73a:9158:fb7e with SMTP id
 46e09a7af769-73e753c8ffdmr7179142a34.25.1752867808054; 
 Fri, 18 Jul 2025 12:43:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711152028.2225638-1-trini@konsulko.com>
References: <20250711152028.2225638-1-trini@konsulko.com>
Subject: Re: [PATCH] misc: Remove DS4510 driver
Message-Id: <175286780717.1647311.13575907455522772905.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:27 -0600
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

On Fri, 11 Jul 2025 09:20:28 -0600, Tom Rini wrote:

> As no platforms use this driver anymore and it's not been converted from
> to DM_I2C for use, remove it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] misc: Remove DS4510 driver
      commit: bf9a78f10939f3dfa9a255386f552d3ef02c8afc
-- 
Tom


