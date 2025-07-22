Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF93C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB33483447;
	Tue, 22 Jul 2025 21:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s1XwAyUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5961583444; Tue, 22 Jul 2025 21:46:12 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B318331F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-615950642d9so3328461eaf.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213569; x=1753818369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq/D9UtpLc4ZcxQ+IwoncTJLQb+obNvBy16Kc7R5U8w=;
 b=s1XwAyUllHLujfkZh+mJ7TSyk2LVRMhYgonmJ2IWto8A+FrLPStfC819mzV1N8EWmv
 Uglryevom9dX24tYxC6lh60pxQeCPlWsXgryo69+RvHaWE6yz5ds5AdgtThMEUd6XTo6
 dTO2XoOwT+5AZ1BgeR3m4n5l4sKet4NVyyPHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213569; x=1753818369;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq/D9UtpLc4ZcxQ+IwoncTJLQb+obNvBy16Kc7R5U8w=;
 b=U0lN3EGQSMsnnFsUhC12BUBm5rb54do1iGk4T/UqA2HH6Om4N2CcgLSOSYcnlr7mWz
 5JHt19n5q2dT7rzvFt5qWpdIC2NDAyx+FC+z8Q/9o1ko8WR3UJrhQboLe2VOe3QjYk6m
 OgVLBUx6whRTFdKcpwOevz5Fs8ay+ETJ9Q4vWWS8lEvCbzsZvCGTOw4G6+eRQWxDclOb
 j2S7IW7NR3ofyXoYjQrvjXjgJLW8S/L0O49oAkuli1Eayl44nDlSCnNMMAx3Zse3vLn4
 eNwksFWN2QlG5uw3PdKB0nrUQv7xq3J8DqagcIHRNjAs4EoBr0mmfQAgudKWRJE75wrC
 xcGQ==
X-Gm-Message-State: AOJu0YxjdmXDVVo0IZdPvtqlY/3d9dN5/6AYfJeh+i6pB46vsk7UyGGi
 Ri3EVJ/wkvEgDGsXbGxpv5qYcRacBO7ZSA+YdG2njCUqWScafBh/7KI2r0ZyWs0DuZM=
X-Gm-Gg: ASbGncukaZ92S7goyQe7oTDE1cx7qvFmU3aZLo4klx3EuV8MM1Wz8iSdoCdxjZE5IFH
 Ldx9LUlYUxYcF8jIz6Pc/HE7Hrr6JNYbI6DSb6RxB/e5StEHeZAkA+Cd2YT9srTJojPHhM7tOgV
 mAJDRrnxD0dqWUo7cJSqqgpUUTM1ZT1QY5VtsDgaGV60R1Na/9KqCFrzij6fW7YnrjuVF3o5E91
 UU3qY8Ag5LKN824CMkLJQUaHJCSG7buMdSYThhKalGgmLLReTzJ5m0B5OJ8+MfaCxkVpZliJgJA
 NKv3CUko6LVG6MoRJr03QhfX09XGzsb72UElQE5C5ze3pazg7KLb/77Hqdg7GudV97iY2rX6GVL
 fN9C9kMhyCpmtwCpgEBeeQP20oex/32G3D41oTiGgCg+EPaFPtu+FGFc=
X-Google-Smtp-Source: AGHT+IFtSCulWwv15n1lWeCcwL9WZMn5TZRNbzQ+u23tItJOVGjkUxa1OqpNMODqYLLJeFM9HgnVnA==
X-Received: by 2002:a05:6870:e2c8:b0:2ef:2af4:dfcb with SMTP id
 586e51a60fabf-306c72b3134mr155803fac.28.1753213568880; 
 Tue, 22 Jul 2025 12:46:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250714-lmb_unreachable-v1-1-20173f22b6ca@linaro.org>
References: <20250714-lmb_unreachable-v1-1-20173f22b6ca@linaro.org>
Subject: Re: [PATCH] lmb: Remove unreachable code
Message-Id: <175321356810.77222.8497081231103104402.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:08 -0600
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

On Mon, 14 Jul 2025 17:40:47 +0100, Andrew Goodbody wrote:

> Code after a break is unreachable so remove it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] lmb: Remove unreachable code
      commit: b9db211e3906c0a620ced344a2ebe5f87ccbf951
-- 
Tom


