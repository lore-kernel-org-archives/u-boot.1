Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C16EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 14:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6F4984BFD;
	Wed,  1 Jul 2026 16:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nXwhrrPk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B8384BE0; Wed,  1 Jul 2026 16:00:11 +0200 (CEST)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1312E84B86
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-664b3831a20so807409d50.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 07:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782914408; cv=none;
 d=google.com; s=arc-20260327;
 b=LkQwidnRsQ3YuEpYAmJ8XSREdhunSx1Xz06uIjfMNaXMHVOC5jsUBJ7PmPmpICmyMD
 4HbJ7nCDSS8xvbAf2UOpy5BO2fYvtZVWXAQjYQiCR/j2V9HG/rXfHzDsI8iOH11Gq+83
 4VJpjlKepB05W5cwLckvbhfYfOthigV2/t9uKdV/mCvWbAAy62WKTEx8bViepWBk+K75
 4D0H9bGJ0JL7lr94Vv8d6EvX5ATlmLHli6T9wcKi8PQR1+EMOJQVHcmGdF5K6jqKGS1S
 n9NEAwdZT3abzAeidHU/I5mQSfNlShUSE/cbXpS86WOPOAmIrQvxgz2UOBd621yL8xS1
 aimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CDZrwYtDTpJPbj5MkN6zj+jQ4Ey6FYCpEoixZZq77ck=;
 fh=ImUlq5X5PTm8yLMTWig4dzxPpH7liUFxG2zCFCr2ynk=;
 b=SljwTZXAU3FqwTlxHXzCxeKGeQdGrx/BJHHkLQjvWR7r3HDLt6wxmy3P7w7tMqIr40
 OoS/mp1tSewk9xBlIgGRILTKKch9qz+7Zve4NBeGlXv43LCs4s+BbSNBYoFxVuhCmmMY
 CU6I9AVJNLl9eCfeD12yMbjdvZUcYqnXInsJmZ9mZLg5E4BEl49S/oJRDzac8kUEuqeh
 BIsN0V3zlZ+Im/KEcAdAlc+/8U8TQK3C6szbK4QYJbKK+UkV5yHws/H18BK/SwZB5REj
 Nfua5d0z2eTj8q/pwx+3B6OXKA8L+miRgABWKTvqgARMB7AwbenHBlFPwCmItJ1ZZj1Z
 Azpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782914408; x=1783519208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CDZrwYtDTpJPbj5MkN6zj+jQ4Ey6FYCpEoixZZq77ck=;
 b=nXwhrrPkWBqitUueUIDZz09Krpsc0+Msnzq4aYJXJZ3Ma09BxhdbSHbB5MKywQkhea
 n0QgK69kfa+C4XtXts5jlHHq/keN/+Ax28w7XTYbHLivSAh/HnlKefDfCo3xh7vBZPHG
 I0/1ivLSWoh0iLjnxRE3e+xBMaM7Kqdu6r6CzhmVDaOGxldW0DQBa02JWW2ZLLM2HVU+
 be7AKGS5BNZHfOTDJJqKUxGtVkYPZuw+b1na+UwRWhqKlfVaD3/M33DBkCEvuXSNHZds
 lLTynDmaN/OtodSLKqLiBmeC7NJvZF6qM5CGvhe68dHynygcbcxaDDi0PL6y+ZdV6YJ0
 ps0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782914408; x=1783519208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDZrwYtDTpJPbj5MkN6zj+jQ4Ey6FYCpEoixZZq77ck=;
 b=PUKjvLq9F3V/fda4PtSHxT1wL0J+hVFgmOjJA5PINzO9qLXFQZVAaXMYQogaBAVNCm
 G+5LqX6kANMfvjwzIjXMR8dvBYkGRPLKVENe/xoiRbuHVdnCNQ3XenZ2PrgYF+hg0O/P
 x+jqwxq9GOSmOAwNDzVHsr759ijbjlZQ0ojQED/pZc5lNILrqKv7x72cNJD700+8R5eH
 yWGyUNQTHjvy1W1ypB2MOV7jg4f+5Gq4aU3ueoiNw0MWXzGMwYdd0P9pwAWoprNzbeaA
 WD/uV0CpA6gyGS+RstuDzjv3fp6XAQLqgHJdY6D/dWdxIN8LuKuHtaKbkHhp+9sIhJxq
 qF0A==
X-Gm-Message-State: AOJu0YzQh5w+oiO2pIiaSsakSnzcXkZa2faDPmoqjfqO37CRfN3lYjxe
 /WJaciEU05ev9qvN+HtF+0q4pzwfWn9u+4xIYN3mZTgAmQdIco9+jMFn+PUvtYk+KtO9y2rwJtz
 lr7LfWNQcQadI5/Vy4F3xCh+CE93fDSzonRxm81IlCw==
X-Gm-Gg: AfdE7cnAV7aue7UPy+VeCViVI7r3CyYIS4x3E+9YAALMz55YfVwsgoZVd5kJsTMQHY/
 f4LsNOzKKq8yh1qDJsWxXztsITQnMJQFH7RQ7Gj5UbbeVHyz8vfkrxAjF2+YYIT/2ZPJrGMB5So
 cFkXY+v8g+SH/LpMDG5R6NwTgHfsk921e01Fr+uTKoAmLjsz9LG899L/VReIMYOVwI5SUQ6znYm
 DrmzavgVyKhirTpWEF1pwCWGa6mvlOiWZR3M5hyoGBuTLvZkdhIqAVpLmhamnnsD2IEfecImvt1
 ES6TJoIhntVwsyIpAMpSgIcVkc5pRFJugT9MbVLLsOH+PV7tGwtaNT/etf4TopB8nEKGwbq/JMy
 zX73BXmXy3bbA3DSoDacedKQTomh2Sh/C9YGvTpep8xR3oIXokhlRRFa/2z2bz/NG5L2Qn+S/QR
 cDugmZ1KOyrcPaYEn7fXrZFJ5+uWHmq2DWM0GIDbAg9+Evs9rwiaYMr7TTrDWNw7ke4eSpAkIDk
 QjB0635KoE2iBRBRxs/UjwJ/5/loImnaIm/zWSYzZylSMk3gSE0qL6W/0gdQHGFFrLW55og+J1V
 b5TeQ8g2rLZhe2Ndj68PUuuwy7ibjXtGIfNofpK9UX9cJP1wRyU2I54fbI9urqjU9I5L6z4=
X-Received: by 2002:a05:690e:1243:b0:664:b436:7a41 with SMTP id
 956f58d0204a3-66521a3fa84mr1702385d50.22.1782914407625; Wed, 01 Jul 2026
 07:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
 <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
In-Reply-To: <20260627144421.2067410-3-harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 16:59:31 +0300
X-Gm-Features: AVVi8Cd_Dw7tuN7RQKgy3Cviv72Ed9zEXeIgdzf6UvK1soI1oaX6o6Pb263ApQE
Message-ID: <CAC_iWjJ2yuqRSbktSAdaoGt_Tc66RguE_JMZ62X956H16qA5OQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] arm-ffa: add FF-A bus runtime support
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>
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

[...]

> +
> +/**
> + * ffa_sync_send_receive_runtime() - Runtime implementation of
> + *                              ffa_sync_send_receive()
> + * @dst_part_id: destination partition ID
> + * @msg: pointer to the message data preallocated by the client (in/out)
> + * @is_smc64: select 64-bit or 32-bit FF-A ABI

[...]

Just out of curiocity. Why can't we use the runtime part in boot time
as well and keep one function?

Thanks
/Ilias
