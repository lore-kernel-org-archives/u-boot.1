Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD17C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 13:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC1181E6C;
	Mon, 31 Mar 2025 15:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TJKUNDlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2277881E47; Mon, 31 Mar 2025 15:46:17 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA6308144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2c239771aeaso2318608fac.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743428773; x=1744033573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQQ9d4ptfHInRrPHJCMNuc1toBFXnogVt2/sQbIe1LU=;
 b=TJKUNDlvFYV3SRiLBxRym5gZXizzKYZiXUXJIiriBfL4y5S/Je7hyoPtzLv8Bzkp2Z
 e/ufhxduPtAcWfXgagCaE3GGFQv5q8BKag1a3RR/N+VxjEeVX+AY93eJp/A6MuZUgH+4
 cmR17t76demNEJdsnRNYKZEhJ3kKka+2ovRYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743428773; x=1744033573;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQQ9d4ptfHInRrPHJCMNuc1toBFXnogVt2/sQbIe1LU=;
 b=eimVCAZHa2C2mEyT9odeBlzAmFyUSWB47zGvxj5VENLdqO9ND0X1vEcwdiggwamUV2
 awi5w3ky19Pvy7AcnHJgy/g/D/kmpqrvO+WnTGY3Gj6ObWdHCfeT2tO/TTNHwUjoEjWE
 f05P822cquHXnSraa+hgVnUlMaSrLlSUgc3oIGUEAraN7cT2bUXz0PehdJkTJxGi6UKi
 SrLuYTPYTIGs7rB7RIJ8TCBEP9wqlrTJS6sO4xlJ9/SA/708tNM0PJ2j48ytTioALBQ6
 smdwckkLJiRr1RrC2nOA+58VYf9OdA7lNubAx0zRFNbkd665ZlIvMl3E3RADIhWJnezm
 l8kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvsIpb+pKSZ2tlNDStmVq9uysF2of3cHuCxmuC7es2ixl55csp+OyyamcFOf8+b4g+cSB54rQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwNj/4GZ22LT7MGMthRXa4vyWyyCBdBcM5CAU2M9fo9rhvRd9+C
 3o8nBUncA1pGKDfnXcFIrjXD7AqANnHaSl5Vq6QHORdC2a45Ctw8x3k3MXHKYkQ=
X-Gm-Gg: ASbGncvPV/9pN6M0Rgy/E1aehAvbhn6qA3TPV1sSvNG1rU2Z26WoGBMuedZYynea1GA
 tUI0M/DXX+VGg7fsaH/QBeOseWc3+CpxmJ7StS7MN03AxRVOY9oLuZXRwCuffu2wWLDqYM8xJrE
 UxAlQXsEEMCY0pfEXB6KO0WjleMMk9p2uThMp1lmNzBnbgHYHkG6NXZOvBjsqsKiZttaSBaTmh2
 W+Box0irsidx05VdyFfcOsVtv9kz45GgPCXOnpJWiwCZv36uvBc7zA2bvYYpgedtXDKQVETVwVb
 X9ixutl0jaBHsLgvlgQ5TNnqEIaO+CmR342hV2tPWEizMXjEIUVnpBT6LrSMMQz4oGScKPmKSR+
 ek4hb
X-Google-Smtp-Source: AGHT+IGxzaV9b9vcU7cIAWo85GPnwsleEz1Am9K7U3ED++wwviPw+ci1HhYkpZmBHZm5j2tzjfv9Pg==
X-Received: by 2002:a05:6871:4081:b0:29e:354e:5fdb with SMTP id
 586e51a60fabf-2cbcf74ed19mr5190285fac.37.1743428773509; 
 Mon, 31 Mar 2025 06:46:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828ae78sm1456331a34.60.2025.03.31.06.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:46:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>, 
 Stefan Roese <sr@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
Subject: Re: [PATCH 0/2] Clarify DM_FLAG_PROBE_AFTER_BIND behaviour
Message-Id: <174342877248.1318045.1130007844214442006.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 07:46:12 -0600
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

On Fri, 17 Jan 2025 08:28:55 +0100, Caleb Connolly wrote:

> In Simons series reworking autoprobe[1], a discussion came up about
> DM_FLAG_PROBE_AFTER_BIND, specifically that it wasn't very clear where
> this flag should be used.
> 
> This series implements my suggestions made there to clarify the use of
> this flag, and fixup the two driver which erroneously apply it to their
> driver struct (this does nothing).
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] dm: clarify DM_FLAG_PROBE_AFTER_BIND behaviour
      commit: 8a0e6212bb5ef547712e922a41555eb7d1aee1ab
[2/2] drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags
      commit: 44450434ea9f0f2e0d8ddfd853f4990c1719b4aa
-- 
Tom


