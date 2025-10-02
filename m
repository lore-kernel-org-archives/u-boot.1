Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76624CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 19:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC95B8365C;
	Thu,  2 Oct 2025 21:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EZYvJMVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D558D83655; Thu,  2 Oct 2025 21:30:50 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0E1881D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 21:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-887764c2868so133639539f.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759433447; x=1760038247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asYcdX4wNSyotOGFI9fLE+EWxal6jOHv+K/TrgzTH0Q=;
 b=EZYvJMVRkZpj7z5Xbvw2z8PMcCguOXEKnqOITY9UYAz7ymqk5fVybTOGMs7vWOWDf0
 +eWnSHAV65hKb8RkPgLKoaVVk7V6xTeVL1R5IcCkUzWc33Q0iuNLvlQsIk+TpFaCJmrz
 yUXOSh8lwN2MQviKxbTcYM2up6REf0nw9LTpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433447; x=1760038247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=asYcdX4wNSyotOGFI9fLE+EWxal6jOHv+K/TrgzTH0Q=;
 b=wCh8XlsuzL+9whoAwt3bWMr++K27iY6SCL+8OLApn8nLeIaYspSY9WuNpdC5+9zpie
 DMbzpzPXWW/kFEUCvIJxOQNXhQjSxO0lESiFrMlcwT95vdye+oJkXmm/lvkJuneE4b4z
 q9Evhk2mgOip2c2DYWKLIm1iUIFN7X1QRxI76ZJURvGktxFcskEcitH3cLAAPZYFSj+E
 yoUBbaARMt0oYk8uMi/ox1pardIIg68NZnY4csWTRNPR1gHwvDeK70p+uVlt5QDLeLLF
 5pZ27+8WaUkFOAR+cD81nMYJuAszWsfPMzUq2C1UUj/S+V+vgpAu6qwvvkEn+G9mjVP2
 lPxQ==
X-Gm-Message-State: AOJu0YwHrM8AlkaUsFF5bOLKNxBHbI1TVdWAZRH/HjxJY9XXUK/HH+eW
 As7lbDa1PBV1GjGjOIB2t7wyB94zPwkZmk+jCXbFJAnWbE71Inzi7nUWVzcVAdO8WDv9JGFcNOy
 8NE/EbOA=
X-Gm-Gg: ASbGncvWHEPRhFE5GKqYtwhjRCjv7kHqyQcVQFHinSscF/M0nkwfD+CQjw893FRl7f9
 0dUjTvFO8iWjOWyu3JmMsv6BQlZ8p8KLfF226lhjmsDhyfp0QswBg2DaqxYRJoaTox8dvObSrQB
 DXosQ53xPh+EOJK+vwJHhdjSBIkIZKtVxEUNhJfavWFuD2CMqMkycejp0dM7ANCzA6tr9IJAqlL
 uPSikHK8sDWAH4V8wBV7dZXl/2IcdV1VmndJb4XixWKHSeOZppRqv+z1GOtiDs3nY/tyaIgA/v9
 Y0vEOV4gpSzerz3G5hYvr7EegsVvs2QaC0fIUksBCgMn3lZzp9/ZpMI3iTdSI7xB07GCVbeirVj
 jIKY3Y87A+igcOt4LesYKFcwY90y7AGDTK2mI3yYI3mvejPbNSUTp4GQHJZFJxe9FMrfn+OxNlb
 H5+lTFRi4s
X-Google-Smtp-Source: AGHT+IGINMpYnXlnHoWsDTyZqpNMu4Fd2w8SrhSAHfJTi2PwznLGUkxmakBZomGhQWuukhJHCpZnkQ==
X-Received: by 2002:a05:6e02:3a05:b0:424:8013:c7d3 with SMTP id
 e9e14a558f8ab-42e7acfbb29mr7468905ab.2.1759433447267; 
 Thu, 02 Oct 2025 12:30:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b2815dfsm12760755ab.26.2025.10.02.12.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 12:30:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Chance Yang <chance.yang@kneron.us>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <877bxeir15.fsf@kernel.org>
References: <877bxeir15.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20251001 into next
Message-Id: <175943344590.3005247.16780944270763569485.b4-ty@konsulko.com>
Date: Thu, 02 Oct 2025 13:30:45 -0600
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

On Wed, 01 Oct 2025 17:24:22 +0200, Mattijs Korpershoek wrote:

> I'm finally back from paternity leave.
> Thanks again for picking up the urgent things while I was away.
> 
> Here is a small PR for next:
> 
> Fastboot:
> - Fix has-slot command when using nand back-end.
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


