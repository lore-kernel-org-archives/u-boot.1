Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EFCCCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E5C2838DD;
	Thu, 30 Oct 2025 13:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nvL8okxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0709D838AB; Thu, 30 Oct 2025 13:16:40 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4547838C7
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so216582166b.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826597; x=1762431397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYRLS+9WA2XAspyLza4Ez0+28rk/DYTD967mB/6DjYc=;
 b=nvL8okxbfxOTV+83CKaCO8gPSXXJ0KbcOPF27DucAKe9PV9RtwfWAbdnlA3a7UsWbR
 ryZie/TMIynQM2wJ5i6NXwbJShgs4thINwMO78tPjtPjxdEleF8LE84gOYeqlhCFvHmR
 vc+m1kNZZZzFPHVPdg2kFb1213ZR7K/KV+vmnBZQw25H6EnEKI749kTAch/Gkb3eH9xr
 zaRX5R7RY0rf/i/74rjtr6r2gD4xbvRIeNGXCWAmQaMGWwJ/sZF62WAYk9Pj6mJhkyQL
 YYZ/Wr9LzxR6idkvQni37FE8vGdi21IQXrp9CIsv9PFNNlk4+o84LPTjYOSXo4a71l6X
 UN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826597; x=1762431397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYRLS+9WA2XAspyLza4Ez0+28rk/DYTD967mB/6DjYc=;
 b=LuEShJ0oUWVlfFDK28kHlWkCtLWfRy03tsgcw5YL9e42VPAyXAhUKLrziM7u/5lFI8
 uY04a1WKFAHwmsIr/R5ob/ZvmtIYqaJrh7Z8S6YA3vF33c07XhNt8cSS9e1uWS0LMTk9
 Fwz9TqIF/ASxUrWSE2KSahCF3ekJSe56fze613bL3E4cjXcU7i72euxUzm36vJZzoqhC
 /W0nFPAwZe7uBN2/zvtzbTKFLEyfAalgN5hZa+5DyKKKS1pfHrmR4sbtyLXjJUeQYJRO
 rEobi5WjWk1NkV1RC+dwnH4Hj8OJ50b1fcz9ZU0Ar20s5SfNkAeQvHcFLUg7jeff8WXV
 FKtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0lI/B6vm+W6vCrvkwtEyFT2fwz4+tHzNWnHA2e1B4G1cY2HWSgDxqoHhMyBiFWYc8FgHUO/U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy17J/jNici6xWTmep+LF6H6bAQlTTHQXpVu239QMJZbQ6abeRJ
 /Rl/OnZMppbgzwt8SoVpwPaNPA1AEJjT3NEsk4OzT4SPqBeVfYR5FHWEcT4NHhP6JjqWsqnQxr+
 DZBzXv5o=
X-Gm-Gg: ASbGnctEoxhvJOcZGW0hWWbRZ9YSmCEE7qFHEKdNe6sMDHkCPPkGmHjMNrNuJJ+LXsJ
 VJ9ZV91HUlobL81NOE+RVxXZd67sRWzt3Vh4yoL/HlxELVyBqG/3NWdVLb0IXGXkRe+5AgSe9vb
 1YRJAheWbrYxKa5iRRdt+/JGdEJxp8HSCNjT58X/oQ/AFusM2kTeI4az5W3WlkCDKRrwUxluYe9
 ANs6IHnXWZS1yeAVXkxni8kehqdffxyEG27xFKWpCR6A1oFFEHQ5EFs7MtpmbgvN1F8m9YY/K3y
 SqbROZQQH0AJSZwJzPOa0sCOs52N1oYbbp36oHzzmLb/fune6s9r/150zI0WSsQXnyMpQaYnfsc
 HSV8va9QLDyWxtj7vpxf/1f5F2+r/UbWISuHZw63gjsXzoYRTQfS/TJnDVSe1DzjmLxE9AOU3u6
 SlYzprVTvHrwJz7cD1aOHXRSjPl1xA6EGj+I0VgdZx9tXgpZH9uyvYKRE=
X-Google-Smtp-Source: AGHT+IGCqMFGjWCAhJ7KyfnWPpCYziE0mIpa7jRYSkclu9frw1aSXr0WoitJvdvpgPgwgJhPBN61EA==
X-Received: by 2002:a17:907:9815:b0:b41:12bf:e3aa with SMTP id
 a640c23a62f3a-b703d3111b4mr720246366b.16.1761826596852; 
 Thu, 30 Oct 2025 05:16:36 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
Subject: Re: [PATCH v2 0/6] Fix UART autoboot issues on DragonBoard 410c
Message-Id: <176182659545.4111945.6570663996014659084.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Mon, 08 Sep 2025 13:31:20 +0200, Stephan Gerhold wrote:
> There have been issues with autoboot on DB410c for years, where autoboot
> gets interrupted by spurious input on the UART console. I've tried fixing
> this back in 2021, but it turned out this fix was not enough. Looking into
> it further, there are two separate issues to fix:
> 
>  - Spurious input with UART disconnected: The RX pin is floating in this
>    case, resulting in garbage or a UART break event (0x00 byte). This is
>    interpreted as input in the autoboot prompt. Fix this by adding
>    bias-pull-up for the RX pin. I've made this change upstream in Linux
>    6.16 for all MSM8916/MSM8939 devices and it has already landed in U-Boot
>    through the recent subtree update of dts/upstream.
> 
> [...]

Applied, thanks!

[1/6] board: dragonboard410c: Drop now unneeded bootph-all for console
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/4e26c1e2fa6a
[2/6] Revert "serial: serial_msm: Delay initialization to let pins stabilize"
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/080d19b6e64e
[3/6] serial: msm: Cleanup register naming
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a8f5b34ec578
[4/6] serial: msm: Reset after writing to DMEN
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/eac35b902715
[5/6] serial: msm: Re-enable after resetting
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5b83a081a762
[6/6] serial: msm: Use single character mode
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/ff701837850e

Best regards,
-- 
// Caleb (they/them)


