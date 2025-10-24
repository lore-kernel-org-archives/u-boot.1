Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE3DCCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 19:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F3DD838C8;
	Fri, 24 Oct 2025 21:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xx+YugPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A36838B7; Fri, 24 Oct 2025 21:55:13 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3382A83869
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 21:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-442003b80d0so958643b6e.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761335710; x=1761940510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+blx1eJGk83esU613SiIRVENAp3WnL/wgvxwxpxMITM=;
 b=Xx+YugPmFRWgaYfCnEv/l5hrCfwH0SKWypRFqz1rh1yMxkYyokUY+XbUHlbBK+LBxm
 xDZltzXT8PixE0JxfBnK7ps6WYNWWPYnebE6Eiz6TPum0d63W5KGaMrAi3dE+q/m7ysl
 f7LaCBoIXbHU2G7WkHNngw8fxOIOAjaHuNhjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335710; x=1761940510;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+blx1eJGk83esU613SiIRVENAp3WnL/wgvxwxpxMITM=;
 b=RojlWEdTlgU8EU8N0VyiF22gvOJu60Y87KGhkjPrBHT9HAh2+NLhWt7VrQ/RJKz8yT
 yPwnK69VM6nYOed4ySYhL8jJSCKdrMpMhFo+1p35SHhJvvKNWV94wn7nukPyt+aapfyx
 f1ES/KbDm78ep/+rNFdpXhcmWx+FC82QOoeHbzr72YBoIuX5+z474YnCkAuwvO1OuyAk
 Iw+yQ6oJznTgDHC7rIfy8JFU4ET31Q9vF5DsYrs7pngi0SmCZ959MK2iV385OjLK3Nt8
 F+z9A67DZmtsweLH8Cvek2GZb3/yko8CzjYVBRU/bKfsAWXiZR6Qhq8nXpZhdt6KJbUQ
 S+LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrUiXBlCryCFYj5xa7bVHn37qqNZ2uW6cN2JW8Ojp0X3VdtmedLNb3wx4JKcX38CH8mFD6NnM=@lists.denx.de
X-Gm-Message-State: AOJu0YzdmnszrXh75xs3ZD/fFDmCV09wCzGkBQ5v/dBjJugq5w4+nT+4
 Q9fiIh14lEViMI15l5x0ebbGtNq0oJs35ud9mRyiyg+GkGsQkper5KpsjIUtL3ktrlDuKkkNkLF
 5IXc8RV8fzw==
X-Gm-Gg: ASbGncso+Fuxn+0RoN3tDhSnZ4kYeV+4kwhYxm5VGOSv49vr7DGh1SJkdxx5sqpXUpz
 i5aQK4HHbL+p/s9DkJElqkJCUyrGAXvO5ZUC1vsAdgimXijtjxuuvYgepwFHKo/bEB/YkbmXn/g
 jsyN1YomErsjC6J5/5g8m+WB0ehrvzW5UrpkSFaYt0vRJsX1B8+EDMT1ZDoS95UdKYuppTY3iU7
 KuGP5Bt52Uyw9gov7I96m8tz7dkbCdyRSS1wL0YG6Mwpje5RiAuaN0KRl1c0B6g6ItSj37fy9Hd
 g7HmgTbw4NMgZejorqI7CD1jHd5r+tyCw+7iwOlaPT0bwaABIS7UMDPOoc5fzJed/LACj9/A+uw
 ObLXhAHnLS0UpmxixRbusAp/51xgBd0AE2LfoEO52dUx8csWgJb6HWUKLNmYZE62r39MQuEsOnc
 14/SzCjR881E4itrioNfvE1PbVia7SAXgBhnVXPrVNfUmHeGv3
X-Google-Smtp-Source: AGHT+IH8u2KyrTzrgq3b1167jl+FOjjPpGT/2oANe2MsJPGvIiwhqb616LtVge32UgnJphrp1WAY/Q==
X-Received: by 2002:a05:6808:4f6a:b0:443:a4aa:4a8b with SMTP id
 5614622812f47-44d916d304dmr1890411b6e.14.1761335709974; 
 Fri, 24 Oct 2025 12:55:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2eff7fsm10013eaf.17.2025.10.24.12.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:55:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: raymond.mao@linaro.org, Xu Zhang <423756212@qq.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20251016132745.237295-1-ilias.apalodimas@linaro.org>
References: <20251016132745.237295-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] arm: armv8: Make save_boot_params simpler
Message-Id: <176133570890.2586772.13037020286363315832.b4-ty@konsulko.com>
Date: Fri, 24 Oct 2025 13:55:08 -0600
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

On Thu, 16 Oct 2025 16:27:43 +0300, Ilias Apalodimas wrote:

> The idiom used in save_boot_params is common for armv7.
> In armv8 is much easier to do the same thing with adr/adrp.
> 
> So let's simplify the code a bit.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: armv8: Make save_boot_params simpler
      commit: 104a0de7844eee51d183d92f5bd22fa6202bb699
-- 
Tom


