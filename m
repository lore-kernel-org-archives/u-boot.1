Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFD6C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5318D80F67;
	Sat, 22 Feb 2025 06:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="kdXxmYHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF7FF807C4; Fri, 21 Feb 2025 22:48:03 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D258056B
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 22:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cenk.uluisik@googlemail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54838cd334cso1419988e87.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1740174480; x=1740779280; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NrqLv/8P9qzVb3D7yPWeN/BqIo3VaZjYMyt7N1LNb4k=;
 b=kdXxmYHLCyKdy9REEZ6DW5xn2zNF8tyEeH0UwG9G6k78cH+i2RbWArOLXPye6+NswQ
 xwl4NoVGVs819k1TsZ7g3Q499jmx+BffuW5pCatjLocQybZcZ2I6Y38OZKJI7i+58lVq
 UHEgRxlEgeOwyDR04IhPgsK2Pqb+TPNUY1ivvP594xwl16ivjGI/xS4kKMUTiJIt6J+X
 EKSzOxbGRKzrHeA7sSK+mrRnUagkf1fUuGpgZ9j+PiYyPfgvsaqNBnh7il97rHhVYZ+N
 bruqMEkT9/8+F0l13YV7gQovplWN4xogIqZYyjDLoZxHsx5zmrEBhOK2X7BvvnnoogDX
 5tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740174480; x=1740779280;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NrqLv/8P9qzVb3D7yPWeN/BqIo3VaZjYMyt7N1LNb4k=;
 b=ULumn/yOpZkGQwq4oesDmQaTbWUvN0ViCBo86cX9PHx0WajUxaVgOXRY+ODO7tm0Xd
 rx4ooD463ffFkxxtIqlZ6WQVjKw8FJLa8kVJP3YNIneVJmQnjPwZ7ZPZV9Y1ilU/eYLr
 xl3YXTgI5tKNaHLLNazZ2xJyQFfRqCsq/tAffR6WTWl8lySUK5YiCarpI/hgavea23hI
 73x4R9UuZ/JKap7ZeqYU7/cEsXeDEOjt39/6jMg0zRntwMBFmqbROUx+JXV/Fza+XhmA
 j4gMevgT8tbYpdSjTpiXKyw3Z9i0JXEpemGFwKilI0sa8sbnQCqCxAN52tcJ2XSVavTr
 geBg==
X-Gm-Message-State: AOJu0YwTquwTZszZn7sP45VeefLCNwQud/7MbbKulyPErHmIW+xiHKFH
 4TwojHfviZFUyyyqwriUg4dMHq03vqDv8Y64uE4YNKg8FpUiov0NQSDjp6Uz26pjDOiGxsdvM12
 a9uHckjs6DTGUU6yG6uBwiQDTiO/9Rg==
X-Gm-Gg: ASbGncsVbhgKi0K+G4yn+9WRWTT/DedK4qiAwzvoudPgV2P94ywsOq2aecJqzeJhRSe
 Kcd/NQtEF1u7rB/d8sXRYQLmps+WG18wIbRrxnEjho7esdl0vSeWNGSfc5gCxwUgm4M4BBi8L7M
 hhmSQdLb3B6bUEOcUzs0aiaAUbxGqzm6cJXqDILdiD
X-Google-Smtp-Source: AGHT+IGa+4jbm1zZvD8w71omal5zi6qW7EPhHb60KgWfz7GcioJxCueJDYdRXzzKsAq7Jp/OWzemLcbnpNf5gs5ng5M=
X-Received: by 2002:a05:6512:e98:b0:545:a2f:22bd with SMTP id
 2adb3069b0e04-54838f79c8cmr2312481e87.48.1740174479857; Fri, 21 Feb 2025
 13:47:59 -0800 (PST)
MIME-Version: 1.0
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
Date: Fri, 21 Feb 2025 22:47:48 +0100
X-Gm-Features: AWEUYZmeF7hk5Xel2IRaEkPTLwcAhlLtPOodKQh20FG_CWj5-W1a-2HnmHSgscI
Message-ID: <CAAWLpRuxUZcnnYXCR4ACLv-oc09Ru0c+0J3y_8yzi8tYTsd0Gw@mail.gmail.com>
Subject: Orange Pi 5b defconfig
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello, I have sent a patch for a defconfig for the Orange Pi 5b, since it
differs a little from the Orange Pi 5. I have picked the e-mails by hand,
because I was having trouble setting up patman here on my NixOS.... Maybe
they were the wrong ones.

Is there any possibility to apply my patch and have a defconfig for the
Orange Pi 5b? Since I would also make a commit on Nixpkgs afterwards to
their u-boot packages.

Thank you very much
Cenk Uluisik
