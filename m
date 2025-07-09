Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68701C83F17
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 23:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B82483622;
	Thu, 10 Jul 2025 01:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cwTjA35m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE1F835FD; Thu, 10 Jul 2025 01:19:02 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 464C0835B6
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 01:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73cdce0d62fso206330a34.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752103139; x=1752707939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OKa0LNUnHS27hBjuU8FLgsP0GBTBp0kHgVwWW7QubQk=;
 b=cwTjA35mbFTNXnQ5bBnLBxvUVB7VClCw8UrTnepEHI6hK8IEWuWEJPbakQW1x3DmyV
 mX1NYIMHiYUDPTwW9EJZIYIOkoWAJeU/1AgH09xHA+FFx5N8O3c12pKSxr6kHupB2KMa
 fAMIyjR3q4of1htgvmr1pOI70SL0vILxcyCjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752103139; x=1752707939;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKa0LNUnHS27hBjuU8FLgsP0GBTBp0kHgVwWW7QubQk=;
 b=MFxJIajcZ7jqQZJnvOhcDY8PKQTN+Sl/v+6L0YRg9YIzsUAgsK/ZKODgRAWWMUisNu
 F2R/xNtNCxfHC8fUNf15qV7jm6ZLCaAwREGh/3wj8/9Js7HTZblwq6uTHdvP6VidmfEf
 v/upiPosrYJPDn3aCOdC777OS6ycQvB1HbRLDOEnWD0YQjWxfLCDryGhd7y7DxoKQHhC
 C00vAd/+uTpDv+OXg56JaLQVNIFMMH3EoS43R83XYfCbwJLQ/rWDOYv9hWSQHAkTJNDQ
 s877lRLCs5HEP67ZQDTj9y4CGOWAYibrF1utgdmVIOKkBqrieo8G9lKzWETKC7Y2TAK7
 jqOQ==
X-Gm-Message-State: AOJu0YzNnhFNTAy/IWb+65YpzP5+h33p2NZLQDBAqVxlzcxvmLUvHhuj
 aelHkqzMgqr2gehwIF00ImqLsepNDvhXRvJwFGFJ/Xj4Jfh7FlEaA7DITKXyIYntWAw=
X-Gm-Gg: ASbGncv4pFfu8t6YuozskpJMK7APGlvce0ushV7TFZKvKBj93jsDteWZ0AElUSHnRg+
 soyFBPbnmoPQo5k2ligmDX/bljI/PirZLrz2OcgPgoNg0TBIkQrIADo4gaPFGpq38EpEuiHJArD
 pD8TK43fA7Ou7GXg9HlcfPRGIYkwKjrYlmCM2a7TmEdy8m+dEnGyBdIlsBZoBrCcHTAcZcPpvOk
 NbDh7xTWkd8fZ8qIIHvm0xXOkfjE6MUmrNmE0GWbsxVRWPI+9sQuoBRd35jYkuEpoi5ExPYnVk/
 y5liHexog1Xgm1zuI5/2AOoces+zpv77LK9s+0fZ2n8dNz05PNq5YJtZdBRJSEFB3IRobS1wdEm
 D8c2X/PYpNYc9WhRlHfs=
X-Google-Smtp-Source: AGHT+IFn/6SzanBb6jgnGF+wQKZglc/GYktMfZjYEmRHzIrzI0rMDTne/+Z4mwvbqcUTceUVRYUizw==
X-Received: by 2002:a05:6830:8104:b0:739:fe86:9dfc with SMTP id
 46e09a7af769-73cf06cc25bmr278751a34.23.1752103138972; 
 Wed, 09 Jul 2025 16:18:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf127258dsm33211a34.34.2025.07.09.16.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 16:18:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250701184234.3191423-1-trini@konsulko.com>
References: <20250701184234.3191423-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Remove "tsi148" command
Message-Id: <175210313790.1870480.8458085833871249609.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 17:18:57 -0600
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

On Tue, 01 Jul 2025 12:42:34 -0600, Tom Rini wrote:

> We have had no platforms that make use of this since 2021, so drop it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: Remove "tsi148" command
      commit: b7c87e28289140d2b1087f0dc54669a91a39d09d
-- 
Tom


