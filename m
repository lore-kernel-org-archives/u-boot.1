Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E8C107BCE6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21423843D0;
	Fri, 13 Mar 2026 21:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GYGR/57f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D247843C3; Fri, 13 Mar 2026 21:55:16 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8298F83DA7
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d73e0e0a36so1192180a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435312; x=1774040112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OtYQadaknNDiHcQj8g8JG1k/XQ1scwhoG8YIdts2WNs=;
 b=GYGR/57f+Q8pGn34B13187UO/xLGS0+69aPFZIxV0BjGT47UN1d5V4YNBGkaSmEsnW
 FR4qW8DMWEVWB2i9JhNiRw3B6cOqUgxz9kM+EmOBLVn4dp6/WvqpaHGyYcF9CjsmiGeQ
 dSWQ+QpcUCgYu+nVk5+Sl48fMOM74Q3FLGHf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435312; x=1774040112;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OtYQadaknNDiHcQj8g8JG1k/XQ1scwhoG8YIdts2WNs=;
 b=aY3iRXa0bDpsmZoFv9e3DLdQ4FG3C6DKZv0oqOLLGir3pOQLUxX8UNrRURPfhI7toD
 b1x6hq2yik9R6h0dZ8plzm9T/0pA9uEerwR/ppcQ+j5+dOAtpePLUGOyJK+qBbsYffyg
 8IqTOW5gZEAg8x85T4An7xc+taKfjL6NAxOMgxXsx75jAPOn17TpzMyUungJiQpMk6dK
 QtmZs7cfHJSgjaydY6Ke1UL+KZFU8cVuHh29bNf3mcsfDMn7ged8J1/yQM2d89IPUN1O
 YnJB5ILm1DWKtBFbc0dnHUa4mf5wcYFWxFSCihVwu4q4Fx9h2nCgnQZgo1hTGE4snh0y
 cmfg==
X-Gm-Message-State: AOJu0YwsJNqHXW/9ohEviN86DI6hAza1tOSsbr7d+2p9q91pkyRqC09d
 4XSru7zrMfcT1dJoEiO+0PTpO2M+t72pXCOGSvuhvPst9J8I5EYTe82+w6On2Q1Ncs0=
X-Gm-Gg: ATEYQzwBu3eYcbj6hX0dj/ztXLFf/awd2uO6zTGalKDqgPs8wYlA5OYSWNtj/HOqoUM
 ZPJKeDQwRslzmvzuPRHV9J0JGbm5G3yf4JaxqWY0iVrfF7OsUUI5GSHLa+yndkRBEb3jXziGT+a
 rBqQEU2Hm3aMUJimltrNDFGyJavM6lZUjMS7/TuxQdcn4cdN1SF2ic/evF0/ccHiEJnBYW/tjnk
 hgkYtIbQFS9B0BQOsbhua6FkL34x+oG122ec0FU+kZFoviVp+gZikN1C52C0AnLX0zNed5+7H2m
 SDvZY8tJSa+osAmR7pZfsOgVEHN8QfnsgAAT+zv/eY6OdJEuZCGb51D1cNEcn1l8yKLihviWRb8
 puSJ81qFidicDKF1pN4784Vvz0E3TqVH83gfGGh0msiO138089pIfB3Ki/BvTbKgQnO5kD8lQSt
 JZH6xkIwDIziNvXtOuzS6BQOzEmixEs2kHXhw0zuktEqO8Ir00fZGeTPozh4z/sBwrFpUVUjd67
 BCuaqV5KOaqAxi8sdIECpGWi1uoQ/8BHr5+YRwDWGkIEmE=
X-Received: by 2002:a05:6830:4124:b0:7cf:d119:9953 with SMTP id
 46e09a7af769-7d7824cb663mr4105368a34.16.1773435312156; 
 Fri, 13 Mar 2026 13:55:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anton Moryakov <ant.v.moryakov@gmail.com>
In-Reply-To: <20260226212728.61889-1-ant.v.moryakov@gmail.com>
References: <20260226212728.61889-1-ant.v.moryakov@gmail.com>
Subject: Re: [PATCH] linux_compat: fix NULL pointer dereference in
 get_mem()
Message-Id: <177343531105.1131472.7985622309841435659.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:55:11 -0600
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

On Fri, 27 Feb 2026 00:27:28 +0300, Anton Moryakov wrote:

> Add NULL check after memalign() call in get_mem() to prevent
> potential NULL pointer dereference (CWE-476).
> 
> The function memalign() can return NULL on allocation failure.
> Dereferencing the returned pointer without checking for NULL
> may cause a crash in low-memory conditions.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] linux_compat: fix NULL pointer dereference in get_mem()
      commit: 21edd76aded65d566f20a6937495c0c3965b4063
-- 
Tom


