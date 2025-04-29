Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32487C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 10:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 163C4809A5;
	Tue, 29 Apr 2025 12:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WU4Onh0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B02180F03; Tue, 29 Apr 2025 12:46:00 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529068059D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so835663766b.0
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 03:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1745923558; x=1746528358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7hJpMsx/pz/3JXBQ96I6wuEB8vtoLJPB13rxvlOcu4c=;
 b=WU4Onh0+ZpZPErdz+qyFw3Ive+hM+z9OsYH4HQh+APTBBF0WMOObRfd92fpfmKAyYf
 RJ6WYX5ZCWrHQ9kNlz0fbjc5Ar/oVYB8qmrYEjethy2wJJvhXOzbs6RZEL3yisA3C6+m
 r8tBsGizSHt73RMEsFpyUpLV3luKwQUuO6bw2AtAh3qkSsw7gY/0vdk7V/S1wAqigs5I
 +0pqMbRkvGiBRbNvKrhB0SGDPpWHDTrxsv74FPzehIEWsQz7h3pW6RjoFZNkvUlgP2pR
 lc9i8rtTXNKjkXr9WbfgNLXzNQ52tuMHcLt3GV7ZqOiI4pYdDq43wNkhqg39piuA5DKe
 KcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745923558; x=1746528358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7hJpMsx/pz/3JXBQ96I6wuEB8vtoLJPB13rxvlOcu4c=;
 b=NLZoHJDZdgtzTnqO/Yr8He6kpAf4pRKQT7TKAbVqXbWwhl2sGhsGPUT8vl/WTFWYNC
 8XYV1z2j1uElb9lwviuxG/oF8Qves/xOA+gWdW3lkjNrIRqlgs/nBTubhxo2Cce/XS0D
 Q+tq0vXy3lEGo7zfzhorS91oepMuvGhjyLrvOblXHBBM36xGpdlo4vRohb46hQaXh1lB
 JbeUpNI/JZquK6VBfN8Rd/U8lK4xItK4FyzLeaCUng2Qwiyrq6+zRLpUSwS06b0rrBmZ
 thQWKoFQOosyaSx3Se2RzQvZTkWFAJnHUdR+I3aQA/eaYCyNKYk34ApTW0+WokAJFRJ+
 ZrNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUDh/wVWljNw+zAOsG8rWq9lGjRJC44fT4zgJ1CT0ilAlT6hh2a7i2Vk402RK9DhSilPi1MWw=@lists.denx.de
X-Gm-Message-State: AOJu0YxuM6mqTZIQ7r7TWMESABpfELiG4Ik9KeqkQ70LHCiwfVdwjZ2K
 RsKIdPv5HrIqXLYVQ9asDj1xiRil0qTRaJVO8JqZZjeOthusvACoumh1Z6a7+GihpNiOUcJLR+F
 tyjD2b+AP5Y2NdndMGFxilR1EYyuf4EP9FzZF
X-Gm-Gg: ASbGncuM0qaJxj55SLeHO/DNWs8fgW3sZ1wNHe+84Zxprb26Z9x9PyI2kjvsWdRlMf5
 LNi1QY0kyvwZ+H096xYuNA5laCY7fZtfYhxHTv8t3hbv6tTTbKUDCR/L/myonhjILmH5aZ5tWB6
 qZ0EfCWPHFZcrg58gdIjU/zjmCEs57LMDv2RmSvM6pakOh32rKGmXMMy0h
X-Google-Smtp-Source: AGHT+IFDP/ZMXc4Gg1tiy+iGH9Z9PuU2wyZGcPPTsVzR+4zUii6ZPpB17Q8vhY3dm/41vDgq2+mpdkusoZXV9/VQHqo=
X-Received: by 2002:a17:907:7f92:b0:acb:58f5:4529 with SMTP id
 a640c23a62f3a-acec874d326mr206784366b.45.1745923557607; Tue, 29 Apr 2025
 03:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
 <877c3cgwsf.fsf@kernel.org> <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
 <87zffzwfz9.fsf@kernel.org>
In-Reply-To: <87zffzwfz9.fsf@kernel.org>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Tue, 29 Apr 2025 11:45:46 +0100
X-Gm-Features: ATxdqUH3u19y1UQb7-D4-XU8xmE22CRjaxSKRit7RSjoNR3IV_3t4XI5P_TEcaA
Message-ID: <CAOWkq4kKyFjfeQviK+3rtEppeqNdmMg6uvHNXApN8zFQUuLU5w@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

>
> Dmitrii, are you okay to re-licence this code under GPL v2 (which is
> common licence for this project)
>

Yes, I'm ok with that.
