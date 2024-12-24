Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09308E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 07:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657EA80708;
	Tue, 24 Dec 2024 08:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U9SNSZYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBA780786; Tue, 24 Dec 2024 08:24:36 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A1A980655
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 08:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-85bb13573fbso1017873241.1
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 23:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735025073; x=1735629873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eY6phzSny/tZ1rZJwoSvXla46FqONySk5qeZylcpwu8=;
 b=U9SNSZYIrogY3WsIzC/cuJlIRiELBsh2UdxNIYuoKLOPvS9Kgm2hFUsz5SvTdZyJG7
 87jatNRkf5L4dbzAAIJ4PbAernVg6ex+L67Gzuouc+I4BEVRlg1i1A5TfpM9YXsgvsBV
 a2otkdeJA+Swx/boV+lVxNjEYvA1nDdotFxvLcuify+vX6gwzz2yTPIVNYp1gYELaVSo
 bF9quBenKlQjRlU4RT8YZN6zzOxcKohYqTuh4h+lC1svu5YR9hx4hTJZcmlFQt9MjAzI
 DM3xEapdGQerlmfx6Ki8Z07YAw2n8P1tj79h9ujQ1zWpPQcRCGDZuzlWP6ZWNOpzVRZa
 9Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735025073; x=1735629873;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eY6phzSny/tZ1rZJwoSvXla46FqONySk5qeZylcpwu8=;
 b=XB91u4JGxjbYfu5pcclTgr33JOMRWAXJNjeaFkCJqiWqUVnBpmX5vwkfx0PQ+8QZ52
 IWPhdARImPnz8L8KnuYhL30WS/UEPhpqBpnToE9KQ4wqN0EhGs+vNdSuQJQ/YlLA/pt/
 huo+dTWUJn1O6jy/41VDmWR79/HcFV5FDJaE16Y9DadqyilmZs1IKbAiIxWKGbLMxezl
 aPtk66OGm1p/djPB0AzEwQIa5GpRAc/k1lf2bgMY4s9tT5j4uaJfkdJ/DgYi99cmWwFp
 C7pX0rA6RBJczH9Oy7Q0woohhLTs1H27GWdnB7VqjdX1OGJXbXJbtWm6JaKqOjBGBGFU
 YH9g==
X-Gm-Message-State: AOJu0Yyh9fUWk0/h+E/TzLwXeNtsV8SMoJEbjXRfPbPAAkz/CHLG+X5J
 dg+gZT5q2vuelXaxfgtTAOxvXJiXr2eTZSBMyP5T1bHt5LkAhDS/Z+nezMXoYPKkNdeO424eAS/
 +TSPx6JCQOGPCwKFKvUuF24OyRWL/EkS+LHb12A==
X-Gm-Gg: ASbGncs1BEaQ2/9t12vdaLawp1U9DQYG7mSrwUcm+sb5q5Y9fH3A35FS1JRIb/7P87a
 YW+vSQvS8bRqtctBHrcAXTtpOQ5w1t/nvT3KnDzo=
X-Google-Smtp-Source: AGHT+IEcwvN0sb4wgbHaPE0l/EiPkWT8UVulFdpOdTaL0z9+5ryj59y01I++ULCUUTKrdhflsvxyQgxqjYDe639EYRk=
X-Received: by 2002:a05:6102:5f02:b0:4b2:5d10:7164 with SMTP id
 ada2fe7eead31-4b2cc113bd6mr16531825137.0.1735025073075; Mon, 23 Dec 2024
 23:24:33 -0800 (PST)
MIME-Version: 1.0
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 24 Dec 2024 12:54:22 +0530
Message-ID: <CAFA6WYMvXXi19tjxhi-N4D3-tbVkbJQeUHwzuC5FME6vzPir=Q@mail.gmail.com>
Subject: DT subtree sync for v6.12
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

Do you plan to perform DT subtree sync for v6.12 which seems to be due
for some time now?

-Sumit
