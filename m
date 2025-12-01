Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC829D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 02:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B87B8839B1;
	Mon,  1 Dec 2025 03:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kj/YkPgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46ACE839DD; Mon,  1 Dec 2025 03:44:18 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4394283935
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 03:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5942bac322dso3854141e87.0
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 18:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764557055; x=1765161855; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pfAqcOhYqS5S/bX5zDa+WuRJxrwWer0CBKKGuCPWlM=;
 b=kj/YkPgChE9NTg6tKSgp9KL0zNH0Cx1IH7c0lk3GNrQ1np9QHBVF1aMgo+wGPlPPjk
 Px1cZ0hQnH3b+iUO9VFYjAdxkosiqOQMMfOia87y8FGh0Qb4X2XWcgY5/TqaxuKGgE92
 +O9AvuEtSD7aqPaaUZVzmypr6ZdeiwaSlMpkA1kE8A8uVm7uUbzBbyVydhfxjjHL2LXV
 U9v7w3tx1h9gk/QQdSWpq35z85FvJHF6UO7APp6ikgmuW4IztBNPMIDlZcNX3BTOekgw
 QEpMBwLBNeHuwBllHeXKvo2T7RE8aZxArav8R5ePJXRKzKh8876W2iH/9ETV7YWzPQUX
 Pg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764557055; x=1765161855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6pfAqcOhYqS5S/bX5zDa+WuRJxrwWer0CBKKGuCPWlM=;
 b=CHZIUMiyAmzQKQModfA9OVUHEweCiK4EII/Kw5JSQvpyHX6sHuSjEhtllB5NaWthwQ
 scAxGwzWDJr2L85PRhnGLFdzLUGBzQCwrVat6lHM3R0aV0jtEO6NVfdUIAvJ8Q8gXjlA
 UUp4iQ4idZZXbG4cIS3nXItGTrdLCDQC9MdW4J8ra+OucxONHOWKyoxG5vp1iojtptip
 aF3w6XGR2IpU80SR88PH/N6+tJ08SqLkF1cinFXr9aR+5mAy4uOWCTZwZLLe5vjEWN2d
 6frAu+hI62wz+3EppeAkUUj90/WduM+KEcH9ha9IVu1C00/ytAjwgsnC5n48tKnxeFDR
 K3ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1k4mCfo1YWWWJPBjecGvUwq6j3jj0XT+05xaNRTWJ7Bwl/gfhUA17Uo2FeXISFWQ5PV+MnXI=@lists.denx.de
X-Gm-Message-State: AOJu0YxrhPc+AAM+CIuC7ciW2d7c3BRz3ooSiKsUhVySwlPlJP/ZqPtn
 qTQfH6RdogSrN4lq3vm8H5/St20RMQ6Jh9ukUZae0rBiMlugd1p/2C6xa3zPAIHxUhDaEd7QUJt
 wozwSPW5ThAKHgYU8rMdsE71rdZY9q9o=
X-Gm-Gg: ASbGncssfzP/R/GKxadJfw45wSkZl+Ib4up0YVSovOl0EzyVBD95x9552KkdtmapQO/
 NMaYWRX8OIuAzkm8n3Z+H0xk/FKuvJZaSomgzoWEuZRbSPA2hfUx8FZrUxhxiN+OoqNyX8QoZaa
 jzGlxuX1r1rqqxAI+Ann6d3HpGOO/czXWY5l0rz5DUNvYB94GU0lPHPTPYfz/YXyAvjv6yPIxn2
 CK8C1hqxsJMVNN1z1YrRp+cczn0YRD5eilKQF58pZQTT+FKUZrKuOu6fn4hlg+wLtzduF83H8u8
 47f9h7l0/dBnCtHnhx7FxDvq6Eg=
X-Google-Smtp-Source: AGHT+IHezemzSt2UU0wCejhAmyJ84p2MtJ/XYcY1bHUf1/DDtDnZrNJYV8uDecLBf7g8Pni+4F6kg1buHLnRxkHBrHk=
X-Received: by 2002:a05:6512:3992:b0:57a:2be1:d779 with SMTP id
 2adb3069b0e04-596a3ecf608mr11694212e87.31.1764557055151; Sun, 30 Nov 2025
 18:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20251127-imx91_frdm-v1-0-8f42646d89ad@nxp.com>
 <20251127-imx91_frdm-v1-2-8f42646d89ad@nxp.com>
 <20251127141451.GV2125796@bill-the-cat>
 <aSz/0jfNn9A3pUmB@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
In-Reply-To: <aSz/0jfNn9A3pUmB@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 30 Nov 2025 23:44:03 -0300
X-Gm-Features: AWmQ_bmlkXafaqx-OAW56BnJdswd9ctdNtiiH1VtQxzgEljZE6tei4TY1ZIl2M8
Message-ID: <CAOMZO5A9Le6GKXGtR87Dpaj+2esYCXLO_WZq0DRZ8RNsPBoN-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx: Support i.MX91 11x11 FRDM board
To: Joseph Guo <qijian.guo@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Nov 30, 2025 at 11:39=E2=80=AFPM Joseph Guo <qijian.guo@nxp.com> wr=
ote:

> Can you please point out which node and why?

Tom is referring to the bootph- properties. These properties are
accepted in upstream Linux.
