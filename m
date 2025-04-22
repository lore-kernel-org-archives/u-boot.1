Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51AC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 13:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4D781273;
	Tue, 22 Apr 2025 15:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OWI0Y3qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDCD812BC; Tue, 22 Apr 2025 15:58:45 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194F180EE5
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 15:58:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-604ad6c4cf1so1502825eaf.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745330322; x=1745935122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l/FmxOVuEl9UjSTWcJLh77wCzdjnsRXSeFIdGVVMZXk=;
 b=OWI0Y3qrIj+2YjOk6dMY8/9nrf8obSsepdV3ls1gMk3UY1U9Mkvk4Hq3Jw1+RvPiYn
 V5KMGc02cQOeCQf9KOYZKw9sGm4BLVrXIzWB8QKYw43X3ctqB7R83wuVwbhC4d3JLzAJ
 42Bjjg1oVmYQhvE5BIA9W6+n0ujkWUd8mMVtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745330322; x=1745935122;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/FmxOVuEl9UjSTWcJLh77wCzdjnsRXSeFIdGVVMZXk=;
 b=sivT2zwgwFU7FBWRZZU5W7+Z1cvreT9O1deGbRwqM81DCITXI5qDq6a8c2u1nmQm5r
 S7JJRl+TbLbpvrtWfUEzNlRw9Ng+75dIyQXsY4kABuKq20u2wXlqJ/Qnezy6nFiLaZep
 HP+v5muBPhUh+c77pgtJn9tnsuNkrcrMEtKUcy0xelr/DyOJpgTXnrunJOgY9YSx16HT
 9TzeAf4HCAX3wXSpMN8zleekh4sw1R7U4sVcNhd85aa/zzIHvSE7NvK7Edq4+6xGpJYX
 lcE2aVE6kjyYktnSuDP1s3bKK/GWAI8gcnLGu+rcxXHS8QOWwapBWff2wk6ZQN6H/63W
 AucA==
X-Gm-Message-State: AOJu0YwM4k0p4CC1sBevHXxhivrM2ftcBpgierxXZHE8UflmrrtJsJ59
 01bINSIl7Qk0FY6c50J4UKA2v7nX+t8HP4i8Xk9eFiQedkSBj3GGsgDpeQh6o1/RSGuMeOfF4xd
 N
X-Gm-Gg: ASbGnctMmdkTc3VwHwOqqYradDDJXTten+Zpk1BDrTTJOI60+bdCuRyiw7XnnjiSaEn
 tUUHX515YbSaclqISN5USjlEZfTMT9+RuwuVlxokAuV3Jnc7DK0Bdi+H31q383Czr7XNyJ8EEfj
 gQg8x+DcHQQW9gCFeqVFHi0Fg23JWJYCEApFuGBK4t/1ArRRCkxH+Hyuzm/qQM+wDnEPywB9BH8
 vTKq9I4QbITG6Dgd2nsly1CePUsouQ1GLVoVSRfdtF03nvDux7xA0TT9lDYT0WLnYctJv0yKVW7
 2oNGnog3YnmvpS/06jDR2vacJ3I0OX2+r4WNjTtaEjLqFG9ya8b2IWtjaJPkK3AmP5v/5HmST60
 Y
X-Google-Smtp-Source: AGHT+IFYrKb9okh7kVU0dWvzGzmG0yMp1gHMaOWOCqhaAdV3rCx+m1X5oeVKmg0wSNnnYzx54ABI0w==
X-Received: by 2002:a05:6820:308b:b0:604:db:d10b with SMTP id
 006d021491bc7-60600548dd4mr9332648eaf.3.1745330321802; 
 Tue, 22 Apr 2025 06:58:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff69c9c7sm2094443eaf.28.2025.04.22.06.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 06:58:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250421161057.3502238-1-trini@konsulko.com>
References: <20250421161057.3502238-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "net: phy: Add the Airoha EN8811H PHY driver"
Message-Id: <174533032111.481060.7281636468091291106.b4-ty@konsulko.com>
Date: Tue, 22 Apr 2025 07:58:41 -0600
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

On Mon, 21 Apr 2025 10:10:57 -0600, Tom Rini wrote:

> This was applied prematurely by me as I missed the feedback provided at
> the time.
> 
> This reverts commit c9c8df2c377e512553f2e9ad5d19c4b85efbf07d.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Revert "net: phy: Add the Airoha EN8811H PHY driver"
      commit: d36aa5057e6b19c5ff2075a02d12f1f13c39817b
-- 
Tom


