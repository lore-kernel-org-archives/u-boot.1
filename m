Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C880C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD08849D2;
	Wed,  8 Jul 2026 19:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fnLsbzcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E46849F0; Wed,  8 Jul 2026 19:53:25 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D5D28497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9f829d75aso520873a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783533202; x=1784138002; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JsmMwd5WqbHFuyUk/y3N5iIhRyrppMGsFt7G4DLy3T8=;
 b=fnLsbzcRbK6MCcYvmK6c2wOidWeAAI9MPF4wxcTnCrN1TUlKvEskyXVRyR6SpSVXi7
 eN8whPEOF12hxVksbx3S/r6iaLn/qoT4l8xLIS1Sbwnl5YNgX6Zc7tOEVw4TCN+aAi76
 5cOM3zxFagKS9b5RUKhgNcXSllyXGfUFlFVGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783533202; x=1784138002;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JsmMwd5WqbHFuyUk/y3N5iIhRyrppMGsFt7G4DLy3T8=;
 b=U2s3rFzmvngifJBoY4Fzvg6XacM1a/x54d3BrV+Wc/3mKJk+EnzdJ5kM/w988kC6yN
 xbpL5VK2nY53w8gvGQ+WuHKR8ROSYFl8WjvIRui3mXoJ1OsGp+VoPsmKv8d+w+ny9rex
 c8TrIIt7CI2ahHaW7vlBoj6sXl1IPIHJ0L8kF8Hs1apFslxY8UUBhuZesbyDGq0tGkW7
 3r/RdsRKdsAaafESJYzXRY5GesCMjQBmZF71VoNtuci5uKTX4KWRL5+TkpRjSrrorkrj
 zPJLLygqYdI8h8aj2j2tO5t1BS3d7FUu8PtzuZ+dGOXJSjcjPa9gaof7GIbFTUcfk1vm
 njZg==
X-Gm-Message-State: AOJu0Yx0gdUsYqjl3p9H2Jq6MjRI5/mHFUMZkopiKTf9NT950ZwBIF+k
 W1sJaIXAQ/mM2V7gY+HBVrh8S6vvgV4VksyZgf9A/CzoQUIhWI7al8lBT6khDtqwPB6F7K2Pt6Z
 DOCuPSKU=
X-Gm-Gg: AfdE7cmE9xRpzBfCWiBEwhw6xW7iiJxW1MP02XWjma1OdlLA/Z87Tj/1EsJ5v/Rk56O
 oTS4nuijnD3dxMjviYErDWGkFKdcN1j/gQasW9hPWX8Zvwon3jDLmlyNY3MK+JjBIhUiempP6O+
 pGAheW9EbeRQOkWbfHpxMg7T0WpN1XocnwfhvfkUdyD0n3rl0ygYE2a116UT+Z33BMyDgKWULPq
 kOcqJjsr8nl7z/Ip9fxAoy1SaX2bZtXpk28t4d8tWraB/DwZv0OYFHv3gt4ILqYJgr91u+wbb6D
 Wq0zUjG4xgS8FNW6NX2Etbuxa+s7FFPzJX5cohOA5jqKXvjRnTy8mzaKXr+seClA3OjIhuZhM5k
 6vow9hofMQL4PJEb08inxCV4N0yq2Y/KdlSOb0W6zBhFdOJyIVDJIz0CagnMk8PLgiinVXZeUcc
 RgE+GXsba1GifcRXGa/H6imI74C3KIRyzFwSji8XqUwiNmzxQ4BvPFjxFz71Y/V3QiS0Yk1qHnU
 +zQfatdShV+1qBV+Dpv/rlnbxcFWOehja2N
X-Received: by 2002:a05:6830:8389:b0:7e9:b4d0:53a5 with SMTP id
 46e09a7af769-7ebd004384bmr2203952a34.30.1783533202117; 
 Wed, 08 Jul 2026 10:53:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb262f50sm2261540a34.15.2026.07.08.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:53:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <e5c267b5-2be7-4a86-aa36-a19ee56658d5@monstr.eu>
References: <e5c267b5-2be7-4a86-aa36-a19ee56658d5@monstr.eu>
Subject: Re: [GIT PULL] amd/xilinx/fpga patches for v2025.10-rc1 v3
Message-Id: <178353320102.1908983.2332397074452254420.b4-ty@konsulko.com>
Date: Wed, 08 Jul 2026 11:53:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 8 Jul 2026 11:09:30 +0200, Michal Simek wrote:

> please pull these patches to your tree. I can't see any issue in CI.
> The main part is firmware interface cleanup which I expect will continue in near
> future.
> 
> Thanks,
> Michal
> 
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


