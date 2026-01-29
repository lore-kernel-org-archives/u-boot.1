Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3664BD358D6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 17:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8625A84082;
	Thu, 29 Jan 2026 18:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nWj0zm+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE6384081; Thu, 29 Jan 2026 18:19:02 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40E0A83FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45c715116dbso851452b6e.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769707139; x=1770311939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ad+mYZJ40A8L8YrasdJGLK9VcqETo18jFbYHMVYbSMI=;
 b=nWj0zm+F2ZR8zCP8A/gmsE5bl9bM5Hjnte6XqEfAB9sg77yqXby9IEoRS8ZjWJK1k3
 rVeb/KNXnaBllTFa9bip3IUfNFvSqA7UssUqtDPeE1xgOocOAreKevebEQDWMgyg5bbP
 VU67YonD1RGIIF6v1456lu3L9+RsFlQ23IETg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707139; x=1770311939;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ad+mYZJ40A8L8YrasdJGLK9VcqETo18jFbYHMVYbSMI=;
 b=jja9+NBrJdI4LjfGO8yR0gSUXPzhTc0ldEa+grah+bAY2taN+X+N8ueE9yXNe2Wlgn
 0DHqviSrUQ3BtgYUmzFSGV1n0o4mdeHraV2zV93XklWR5sN+4kCNeLy31GLl+zm56ZCx
 PHloBM8uexlnWfMPTmxvm4Q1StpwM62vSmfkDDQ3rK3uYV6O4aqMycRzgUirPYY2g96E
 QgFD/eRKSAffaskahy8lFRLX2DOyxCEHKlywibMB7DUFhJXL6WXzHWqThyAl3tJ/OFOg
 RoY+w+YXyUPtxrZyK6uQu7TwObnls3KspaYySB4joxK0Er9h4GglOp3lp8fCxWTvbH6b
 rzJA==
X-Gm-Message-State: AOJu0YxMNoEwKhNXBsPbRL+tBDcOJTW8gEENy8DjtqA3/4StmJYbd8uP
 r6EcYE0AthYL/uDenE1P9TIB0kA+N55fUbhRxnIeH48iumSjdALLtpVXggREvaC6xjI=
X-Gm-Gg: AZuq6aKa1cfiq4u52BzJPSLFVGNblzDBFTPYzIuJIispAC5ebw5zDIoHRkk3Jycq2bB
 lKXhAVSVydnW14hldP1Y6otVZPtEpPS2PoJT670dBJOeff+NT1ECdt5z5tvoKqDfc6U62YQrB0d
 vf5SWoF2CkZzWMrb/2wGISyobffXIkdv1PUEBTo/x9T+XJEzMiIYYwd01/fHwzg91TBxIVmzvxk
 qxympI8Jd15KASVaK8LkBTgMx+dkaAIfLdZ6t7H///BUA/QNLqUANmRJ+XHt8GELTr0TJw5Kx8U
 ICACAHfqj+6roLhwPw1s+qHVIv6Xh5GmuZbo2v/0pmyuu02b3Cvr44pEhEj/5tztqXdARvlLD8/
 JmgxCm+X+V+/3zOPS3B7pKdNLFFFXdOVmF9khEmVQsF/kpgUs6zJW+XKIMk5czOsFxdaMUC04yN
 7dkt5p2JoXoURlIEb58DHPOhPdExXcJm9TjsnwEgFMPZ3gGgZqD+h+GxWU+tnu3xZoacYwy8aLl
 hVSltu4TLV7syCzC5GK/12lqpMzg+TtUYiVMoFF7M1xTMay
X-Received: by 2002:a05:6808:c1ed:b0:45e:ed0b:88a5 with SMTP id
 5614622812f47-45f34b9ec08mr178572b6e.25.1769707138954; 
 Thu, 29 Jan 2026 09:18:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d894f5sm3413822b6e.5.2026.01.29.09.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:18:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>, 
 Steffen Kothe <steffen.kothe@skothe.net>, 
 Neha Malcom Francis <n-francis@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Bryan Brattlof <bb@ti.com>, T Pratham <t-pratham@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20260122-am64x_speed_grade-v1-1-8a8db3147428@ti.com>
References: <20260122-am64x_speed_grade-v1-1-8a8db3147428@ti.com>
Subject: Re: [PATCH master] mach-k3: am64x: add support for speed grades
Message-Id: <176970713798.2054445.15380911243036484111.b4-ty@konsulko.com>
Date: Thu, 29 Jan 2026 11:18:57 -0600
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

On Thu, 22 Jan 2026 12:49:56 +0530, Anshul Dalal wrote:

> With the support for common speed grade configuration added in commit
> 65a6b83a9b7f ("mach-k3: refactor A53 speed grade clock-rate fixup"),
> this patch extends the support to AM64x SoCs.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mach-k3: am64x: add support for speed grades
      commit: d8d9421c5cc9c5bca710a082d771e75ad2aa9117
-- 
Tom


