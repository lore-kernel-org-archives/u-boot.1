Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC4FCCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 14:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9375683885;
	Sat, 18 Oct 2025 16:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="haXPuyfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2486A83768; Sat, 18 Oct 2025 16:07:35 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A988386B
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 16:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-651d3204fe8so483069eaf.2
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760796452; x=1761401252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S3nRDVM0jm0TILsKjZQHir5dVe8B7JZemleAIKGFCec=;
 b=haXPuyfD1U1uKskwcNITrY2HnuE1rvyplkvtkkqYo3Z06Azqm7wDXAHmdCnJBOJ18x
 h0bPYTbv535p9VM89KQKBCTL4X5B5/sWVOCFdQexgM4/Mng9GFMEJ1rT46/HoAbNI3zM
 SwkTOSS+254m5sdvZ9YXWZApk5oCUUfQGQcBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760796452; x=1761401252;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3nRDVM0jm0TILsKjZQHir5dVe8B7JZemleAIKGFCec=;
 b=qrZttgHIxTxmmnkGX2cmSUikpdFen7/PkDgrOEjfjGQO4BfUTkdwTmCGFpEW0CpuEh
 QfiFYp25URo319FWXu4N4Igcuaf1dDHTWfX65D0oWJGutEePqwHlI1GZZxFzTjXWXhhS
 BELva4hkU4JPgmSyO+mnanWCXZf+xTz4D2Sw36dKSyXrjFyt2lt4NsDhBoWQK0juER9l
 3a46NpzVWNmSXhyzIAx+0kkCFv0BLyQ4lOAXjf0iGbPpszOZ1x3w2Pa5LTbgVUdRlxjQ
 2qjJfX92U/ciJ+dCGg9FLYnmjFPiL7WuZRd0ir+b1RiMe0t4NKvaxJwa++FUszEn4MGm
 Q3pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO7CPwwee5flan43u1a8PIJy0B0Dd6rfmdLsbwNtYAaX6ZldUd/DvxfU4SkKlUdW7nXePdtKM=@lists.denx.de
X-Gm-Message-State: AOJu0YzDadRmpvIEEXtpBPiBMuvWuNpD4YW3hUIRJbUaIQG3aGAkjV2q
 KhfzZ0ieJvgkHUJWP8WdBm9sOEAZ4AvKZRCohkh/rRn9ME9fC0DA085njbG8TTeYn2YdqmlU0qJ
 VTL1eUd0=
X-Gm-Gg: ASbGncul52UwVR1mMvRi0gcXOeQ4v4w4neOHUdsLE+9XFNBnoMuANRWpwnxQnvmT5M5
 tEbc81wWQ0UyfL/0nt52aq94C60xZpBuvDN4D74OlBPL8wNRMJyomypYJT+eYX4uqCrgpUxJEu/
 zWIpO2Ejz0EBxuWjAwdu5sdYoTta2+qN+Ryx/HwEGn6MojhujHo+qFumwCz4JDs1sa3Dl9ltnYP
 gKLPjY1Qz/EUXwCklwzClcZVG1BNQITSniC5tIdqItzIwkrbi7FbYMRZmJhKuPrKOyNn3RCOugo
 QfpdT+nY0KNlVbluMo+11YAKsvbmW0EepRiEoaxKK7x7XEwN2eMAC72AYJpnznp/V08cuOXJ+JZ
 VUp1aq2TTICV8mh9zrfAQzRPi+VdwVEdLPXlOvCZDLjUERYs+TwYbAjb5ZAEK8h8+W+mTwazAya
 tEpx+z/WILwHdnKQ45dH6pFt7C496v0yKwg577d6F7TkmqGLr1
X-Google-Smtp-Source: AGHT+IG3hhTEOiFiTEMMME11FheLjfNBZCFzyQcmxnXY/Dm6JJMejKBFZc7n/eVwkteLz0kKDechCA==
X-Received: by 2002:a05:6820:438b:b0:651:c81e:e6ae with SMTP id
 006d021491bc7-651c81ee939mr1977852eaf.5.1760796451801; 
 Sat, 18 Oct 2025 07:07:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651d3f2fa57sm618972eaf.14.2025.10.18.07.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Oct 2025 07:07:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
Message-Id: <176079645001.1878470.9768079302243100245.b4-ty@konsulko.com>
Date: Sat, 18 Oct 2025 08:07:30 -0600
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

On Thu, 02 Oct 2025 10:39:58 +0100, Andrew Goodbody wrote:

> After calling a function that can return an error, the test to detect
> that error should use the return value not a different variable. Fix it.
> 
> This issue was found by Smatch.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fs: semihosting: Use correct variable for error check
      commit: a58089ad2e41e88f81360f0e99bfd0715aceb556
-- 
Tom


