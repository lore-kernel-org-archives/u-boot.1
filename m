Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1055C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 21:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1268583438;
	Tue, 22 Jul 2025 23:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jFLbZvQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0746F8343B; Tue, 22 Jul 2025 23:48:42 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFE38339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 23:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73ff32d8b8aso164201a34.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753220918; x=1753825718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrWHzvzhz2i6FkRxCCmERKyjoA5ldBEs+WnkNXvEiQg=;
 b=jFLbZvQNQShdJYvuM/ci5Nd+lv1ai1XYeZw+6REeLFsYM74hCOttKuvY/WyNMccgPk
 aVRUmJgjrD3skNiE4o3vHVrV5Yr4tREVkAdM7B8U6pwMHztrB1WVX0+40iR5beDlBhnL
 G6AD7qTP4vQMJ3wiPXns7GvRqXUCzuhSTYl6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753220918; x=1753825718;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrWHzvzhz2i6FkRxCCmERKyjoA5ldBEs+WnkNXvEiQg=;
 b=ox1R4QcoxLwLJyt6XVf69a++BCBBT+7PMCvLivICWMgC40kHxKyD4hu6rXL6HN/P+G
 oUI/KFboG3tJ9+MRhIyIJ0wPDxgohXONk16lHiDFNcvbXTH1BAEPt7t4UO7jo7Fw44XF
 KMLGgz0eRaM1AYbEq5I/DgrZEcPtGagDcrIOy01Z35NIfY1JG8Q8dmqUxtqOlqCda0gX
 MzRK3JLZppo20VCd2MV42cylpvMspM3TiptQnchjZ2mnqtrsDAaprt89hy1jluyiLuDZ
 Z7o078BPng+Lz4g9LotF15eqbsgduaFfzprOP7hy9TCnhMGHoPF2ke81JugSzBlG4Z07
 7C+g==
X-Gm-Message-State: AOJu0YyIGnI4XKi7SfkqeIaQUPiEIKahIhIQxvmKnNzDk/F7irGYfW6F
 o4u13r3PDga3RFZOwFbeb/8Dh6xuMYH66bGl6dmxhHxfSbGTWVSQtN4+0IUMzDmsMY/WF4bMSza
 6MclI
X-Gm-Gg: ASbGncsGPf1nkmK5LD0Jyd72tbPOYCA1c5IA/0l0vh+blHVR9n45Hn0Zq9ZY8JSYGsN
 hqligbCLfnA2K6/e8MK8HW35AOxbVD+T+Yo0qNqWN9giNyNAX2xsBp4Vwr5PWThI99B0R6rui8z
 G55EzkllW8ouviJoFFGIc7od6hg8X5v47nf9ndCpQjpAfUEay2dSE+2pggTvyQa5mbnVFwy4eXM
 U0e8+SklvgCeexibldD0SMyRfG+70IDJteEVpznJQr5DsWFhMizjgLkFzgZrb6rKmhGpNemt2Vq
 Raw9VfvHwbVH+N5lhTpCUo9OEH03tz0eqGW+njuvlPP5nTfLaNpCiRCBaDCXabaIyFEMBxw/jNN
 /iuN2fb0CiE2iYEmKxSp5t+8ogY1Z9m+OJtbE/HdjC8oOzwddw5N1kNg=
X-Google-Smtp-Source: AGHT+IFTyFQLX5+sY5bKakEjh+XHssrSl4p3HGYHA6oYDk/VhkJcmp/BSbjq5/38qSla4gCRfTYXQw==
X-Received: by 2002:a05:6808:1649:b0:40b:4957:23d3 with SMTP id
 5614622812f47-426c6049226mr715780b6e.20.1753220918482; 
 Tue, 22 Jul 2025 14:48:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bcdbbcdfsm2248906eaf.31.2025.07.22.14.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 14:48:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
In-Reply-To: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
Subject: Re: (subset) [PATCH 1/6] km: qrio: fix set_gpio read/modify/write
Message-Id: <175322091683.89342.8903524637832610367.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 15:48:36 -0600
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

On Mon, 14 Jul 2025 15:22:16 +0200, Holger Brunck wrote:

> From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
> 
> Setting GPIO by reading the value of the GPRT register, toggling the
> correct bit and then writing it causes input values to transfer to the
> output. Here's how (example):
> 
> 1) set gpio 17 and 18 as input.
> 2) set gpio 17 output value to 0 (read gprt, change 17 to 0, write).
> 3) set gpio 18 output value to 0 (read gprt, change 18 to 0, write).
> 
> [...]

Applied to u-boot/master, thanks!

[2/6] km: drop KM_RESERVED_PRAM
      commit: 97e71c09bd7fc89cf01735b4addb6e101041d9b1
-- 
Tom


