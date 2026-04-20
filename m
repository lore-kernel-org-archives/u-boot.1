Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFEAEA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A9F8419E;
	Mon, 20 Apr 2026 04:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oXLGPqn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B68842ED; Mon, 20 Apr 2026 04:13:27 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DD484297
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b24fdac394so23764525ad.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651203; cv=none;
 d=google.com; s=arc-20240605;
 b=i/hxJa9X/QeCOKAwiq7DSO0uevSDFb9c2jfuuG2g7LsPmCtANCfnsgobxJ0rqc+TG+
 5l0fQwKjdWMpdqgX6ecFcwDv0cpWKXjzgvdbA+Hy7+BlsfLbAtYOc94mMPGkTwrHaIof
 ybWlPxF4OakaWwiZwouv0qUKy2fbcJKC/VGXGs46MKU6SqGCeCzThBuema1qul4JzLAp
 lRKwFm70Gj4X7EDCicH3yE4luBlD+S4LZ14JSWF66O24/WfPiE3ZNWAp/AHa20Lzd8ih
 m8W5r2zvRyleE8XMAKw/FUNJ9PItfvpANOJYFuM8/Xxpi2ILepNLwZkkxi/YyAfCtqYm
 JODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GJePTvi5ZboAZzybOLsm8nqLucIGBjrnjzHzSqPf9kI=;
 fh=JdYuey8wYmmx/AtEosXUVTN8d8L/5S4NrdlkDKNw/io=;
 b=WqcfojoEkkTKx+KS5ylx9BSK3OKRjPVtmQ0AohuCW9j/moN7qtJhnOk4ck3FnGi9ZB
 J0GXt5huFVkfyybxdvyO3BWZHFp9fA7qGWnAJQarIC12dDXlfkrlNpwyGbShkoMM6VVI
 VVUvvOtgO3dB6+fD0E9Ee1t6wIIyhgLxwJiQBXH3XDKGxfNlgQ9t9lD2b6quEyIm3ruF
 654dPcMMPh1jhMvSp6BloJY+51XOIpfADv7/F3n4QH08q9QpIdvvgN9d3PqCh/6x4lKS
 vnPWN8eMLWhEGf7gaYmrzR2oTmziq9udArp5p1zNinMw4/KuiAipXjSbwjyMZpSaOB5q
 15Ew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651203; x=1777256003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GJePTvi5ZboAZzybOLsm8nqLucIGBjrnjzHzSqPf9kI=;
 b=oXLGPqn8ey5EGs43y6vvuSe3HAfFggMzj862Zc5X7qDxvc4Ovjet+HMCazDhzykxSQ
 lATjNlYwYmKQc+a05YsxSo4OiZVgPw+9kj5JSLmRBmAssAl2ugDP1zuWpRbbHiXEWSEz
 tXkT0gMIuQ4Xe0c5Baf4PLh8wa6i6A1DK5CJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651203; x=1777256003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJePTvi5ZboAZzybOLsm8nqLucIGBjrnjzHzSqPf9kI=;
 b=ZcKwIBRZO+XtJE+Y0nAQT1bONVmi0F5dMoR0t/+DodCxwicgQflI0jR/pfUrXExFF8
 FnX1neEX9x1KBEHAghGq4tzFjwqngLNh3k8kWCu4/c+Ia0euYH1VhGJ+ZR81sge9h6t9
 i3r1GR5TKdceQ+cp3k7q96vICR9w3U1UVTeGr4POhs9RDEK8kFY+nevtSVObyWlS1NHO
 nRP2rgKFCf2SZIa4CjwpCoFIiWJXwlV4NSQ7k+9GmA6Da2siHn3LqtqT5/XCQvSKQpKR
 ilK1ZChwaTJW5HwDxLsa8EoqrfgvKr2IGtOD8e6BlC7UJl9l92VooWkqNb66roOMfAfF
 vluA==
X-Gm-Message-State: AOJu0Yz/Lu17t9odbMeETxTVWTzBNElzszieyuNQBsfsanip6+SIRU9O
 9yiz29E/0Up2gAXPmntHh9/wcVnU1zPOOFpoRnHcWlIeBU5Wkzmuu4SDjJD8f2s3S5cAtVT8jb/
 DxV+frOe7fNDJrf1+zDMRoyYBIj9uBdI2Ie3kCp0SImpH2w6DbrbDMQ==
X-Gm-Gg: AeBDiesM5l5sG+Hth2Tuu9csbNwCyAlpMfL8+jvjSIXLM0cVi9YnRBFf3NwBkiwVARX
 xgGmoM9wFsYR2Hv0HoCuVjQdMhfy+3MD3el4wU+MQe2+68Q/SUx86nWbhEA8zpmHmKF6ByfK++3
 M3DF8i/N86MQWZLeHXNbOphsnYUSvjMqKd9lf+ZcM8cJBzR5TNz/CiPG3xFk6jIHii5AKFfY/J6
 sDO6oiyIHuDS6e2gGs0RlJe/zU2kVK/F8iI7LB+ZS8/bnnL0o9zVZkoO2KKl/0SRhjC2Eare2B+
 jDug1oJORvJoq9VbPT07ktdueJq1o2Y=
X-Received: by 2002:a17:902:e746:b0:2b2:42da:25c4 with SMTP id
 d9443c01a7336-2b5f9ef6877mr139861405ad.14.1776651203482; Sun, 19 Apr 2026
 19:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:12:50 +1200
X-Gm-Features: AQROBzDakq2nArwXfYl-yY_GJEz9fZyw2J9nDXBRURqr10VypoCGtOXse23xXzY
Message-ID: <CAFLszThtrGC4KerPxM1jFtoycnbuYZYDvni6J+hsTF-Y=YONgQ@mail.gmail.com>
Subject: Re: [v4,00/14] add software ecdsa support
To: philippe.reynes@softathome.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:

> This serie adds the support of ecdsa with software using mbedtls.

series

> ecdsa: fix support of secp521r1

Patch 5 fixes secp521r1 support added in patches 1-4, suggesting the
initial implementation was incomplete. It would be cleaner to include
full secp521r1 support from the start in patches 2-4, making bisection
cleaner and avoiding patches that claim ECDSA support but have broken
secp521r1.

Regards,
Simon
