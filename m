Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08549C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 23:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAAEB889FD;
	Thu, 15 Aug 2024 01:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="akDB8iSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016F687B77; Wed, 14 Aug 2024 22:04:21 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F2D86EE3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 22:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukapanio@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso205401266b.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723665858; x=1724270658; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q0jT/170iEllply5+ea9zFKd/XKemq7pPYOzCWeVqnA=;
 b=akDB8iSYkbIOx+mroXAPILGZs5cm4hbuoRbcyQG6tLwb9SFb3STXG4j36bzoDvwmW2
 uSmlSCPZvKA9viUsvh9LxLDgKVbxPFHIGNmMf9zTqUQ3TM0Y3D0dbbMJU6DIhipuGiSh
 Rvqx0KxNtf2JiJUYieqwq097tXNzh075o+phz7LupPT+Qz15cfuNfzy5NbjSNCL9q7p/
 1szis28Be5uMMadeIBq7qdMUCK2nyWKJmGc8wNgTsYB7TgBl6hXv1jtX6GkiIRkp7tVc
 EfZccuhba8KlpWsGF/zeBc54J9qhHubDt3kL/tZHo5kh6k3R3xP4rMl6EOMNvgsSytKa
 iQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723665858; x=1724270658;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q0jT/170iEllply5+ea9zFKd/XKemq7pPYOzCWeVqnA=;
 b=euswXIhNsBlnh5QfCJHDWkbNiQEYjBivYQjaWyPUBJVFVZUDCoGfQwy/fX6dvSwKr8
 1ssno5oGjE4t81+ZAVge/YckEeyu+rTkEN2TwWNkdnmkQmw+ZaTdXzBEg3sJNXE1mnct
 7fuYOQzsEfy6YFcEinOANsWtDBINZ1rdNfxHxq24KUrQ8Ko6fG44dEWZjpqV+9T6LJbI
 gTRcjJlfQEpRk6G/+majoWVcKRoVlO2jtgQB/etood+q6CV6mgNf2m/mhhYPMzW6l332
 jDTLmT09gflLEMn1iTxzcDDnl63wZr4VN2ZuED0BbR5GDywiGoY7XWjF+HUv/Nk+BlQU
 WiaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYaVGbiA2BTdEwiIZhppJotqXHOrBA/hQuoTIP2WjQnzNNiiYmcN3SDblWlVW2NpiN7cjqPYnSWieJIN/86m9bkt6sDQ==
X-Gm-Message-State: AOJu0YxbxU3u0pjmV9eJrwa9a6HEAKCS5kj7EGQe2A38MacURPE4rm6+
 NkzTdykl8dBwxFSwDrQJV+kJlPhwYneChLv2k4ClXQkZ55Skbh2Kokzn25Kdl2NEXC2yEQZ/DdR
 FuojazgkpGh5TCjrcuqtYXiCyb44=
X-Google-Smtp-Source: AGHT+IGoaO5r1yLIZFvsOzbQLqsUrE5R2nTsz8jm3eAsjERTvYaiSZLEU/hsQ8Qw1VltEwwge4S0rV2U3s+e3/IJe7E=
X-Received: by 2002:a17:907:2d29:b0:a7a:c7f3:580d with SMTP id
 a640c23a62f3a-a837ccef216mr68575066b.25.1723665858249; Wed, 14 Aug 2024
 13:04:18 -0700 (PDT)
MIME-Version: 1.0
From: Luka Panio <lukapanio@gmail.com>
Date: Wed, 14 Aug 2024 22:04:07 +0200
Message-ID: <CACi=Ov7Gs7MwHfNRT+i3gK-cwGVwij_J1vfHHGFLPBPGzP6k4A@mail.gmail.com>
Subject: Re: [PATCH 00/11] mach-snapdragon: various improvements for newer
 boards
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 15 Aug 2024 01:28:08 +0200
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

Whole series tested on Galaxy Z Fold 5 (q5q) with sm8550 (kailua) SoC,
with these changes i can confirm u-boot booting to console. Without it
it's stuck at boot, as bootloader dtb is never parsed.

Tested-by: Luka Panio <lukapanio@gmail.com>

Best Regards,
Luka
