Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48870D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8D8A83AB8;
	Tue, 20 Jan 2026 15:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bOFyZ6JH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF4183AB8; Tue, 20 Jan 2026 15:31:05 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EDA83A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7cfdcae466eso2931298a34.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919461; x=1769524261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EhlILxjoZhxMoQUOj6XvHJ777HVzpZlsyUcG5/tdTo=;
 b=bOFyZ6JH5LXiUL/Vk1WtQ+pxUb+BOM5CQSPJKv4eLVPzDBY8fnMrrKhP8aEyArCBRX
 0uNDG6azoqjKyI8TumuPSRH30mEsFj9VQIlUhAYTE8NiCBdlv9ILwE9oDeq36jhSaysd
 O3+OZjnPlg3jiZ6VgdPTay3z0eF9QJydl9d+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919461; x=1769524261;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8EhlILxjoZhxMoQUOj6XvHJ777HVzpZlsyUcG5/tdTo=;
 b=n0fec2nDept9ORGRV/jvMBEBbx/ewyEbVD3+nvYagBXu+l5wB8y5oP4bMkhrR3yRBC
 s8jQS6Gj5GWm1h+/CZ6g5JsmTW0sN4czFLARRGgamTzb7av8MJlwURsf0IEA/cSk08uo
 xFu8PhqwMzSRR5umYPQhLeL2GAfe/hK2t+5U7X3dpCGQHa62e45FeC0wWAr4bPNPkqCp
 iZadijS4I4K9HJLBgJn6gcVvqDZXP5t2WcH8upPbIKrjUEw4uGR2wIyFlqRVWTMm5eWq
 5nDXZhHy1NqoBqCQZCGRojX22yPNVAwli2SWAdLmtnl6UDrmJ0xzn4pYHoVBuj98vsVl
 7ZPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlUF2hoKXURhWgfru5nUReeX4XAP4l/8uaKMsrubV1/Q5ArfnKek4Q+TNq9J++p0x9L/zzpMg=@lists.denx.de
X-Gm-Message-State: AOJu0YzOjnDTuXwn7O+9+b4DX2X1Hv3V34dU9oeJoFougGDPZgfcuhcg
 XXhIgt2FSzpPI7J+nEj86KyLwH8RVM06uVIjjcO8TMV4FMvWWc6QKqK0pKHLRXBeXfc=
X-Gm-Gg: AY/fxX7P5OibV+1XW+DbTE1ZOJZU/BrR6QR0zkhtusIN6BB7qxtThKQK50AxlbI3aO2
 8oLjP1ME4NlNwYxyESyWqbMLBFp1UJVczKEWygjI2cF5TOzmyp10VIdmMzDRfcI7oLpTav/YneM
 d/YuaX1eUAPNxC92jq57UVjnCMRTy6HyVFa8vDuWFZdWcW1+qUxMgc7Anmc/oexxnC4O7TkllGp
 v8ZQE/fgE+3iRhiGcmyBrM9hyiQ2xKp/JjXvlwKF2WGenxwBKYABKLZXHgOJj3cOaMgFOZ7Bp0o
 8x9Ct5p6QsZI2tXFgozNU2hAOEO2trWVh5fcNXzxT5WmGBWos6t/AT+Mq/XdfOW7HFoMIGlNOky
 IvtnGzRNJrpIlEahE0LUoCztOIrun8AfYvL5bQSMMWLdrZUs0r0WaL7H9XhHQWNLQL6pQfXmBpo
 i7QH+TMpsQOhqgKJrkmUf8RA/X17VXwWd8D16mVKxf9eMMPpxFxKdOME8/DMYwKCECHE/2QlO8S
 BDTJkq5oDZKkUIAA6ASzLECTNXnsAytZ7Absg==
X-Received: by 2002:a05:6820:16ac:b0:661:1ad6:1073 with SMTP id
 006d021491bc7-662b00641ffmr687664eaf.52.1768919460968; 
 Tue, 20 Jan 2026 06:31:00 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044baf38ffsm8657418fac.5.2026.01.20.06.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:31:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org, jonas@kwiboo.se, 
 funderscore@postmarketos.org, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de, Robert Marko <robert.marko@sartura.hr>
Cc: luka.perkov@sartura.hr
In-Reply-To: <20260113110806.648534-1-robert.marko@sartura.hr>
References: <20260113110806.648534-1-robert.marko@sartura.hr>
Subject: Re: [PATCH] tools: amlimage: include <inttypes.h>
Message-Id: <176891946008.379251.4344949458921511050.b4-ty@konsulko.com>
Date: Tue, 20 Jan 2026 08:31:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 13 Jan 2026 12:07:38 +0100, Robert Marko wrote:

> PRIuN, PRIxN, etc macros are defined in <inttypes.h>, without it being
> included errors like:
> tools/amlimage.c:124:38: error: expected ‘)’ before ‘PRIu8’
> tools/amlimage.c:126:31: error: expected ‘)’ before ‘PRIu32’
> 
> Can be hit depending on the host compiler and HOSTCFLAGS.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: amlimage: include <inttypes.h>
      commit: 6f42057c67fad2ad66ed73b9c13347ac7881876f
-- 
Tom


