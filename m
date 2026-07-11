Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF6DC43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3130884AD9;
	Sat, 11 Jul 2026 02:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WhGWpEe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8651484AE2; Sat, 11 Jul 2026 02:17:23 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FEC84A92
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a116bd18ebso968857eaf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729040; x=1784333840; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YbWZ7HwoLgjxsiWWPZQJEsYuNxWCaNpuIjBuIajUoLY=;
 b=WhGWpEe+BZ/nA71cvGd6hEtJbCt1ywlNiOePAl0DVkAHHSUqBIBHGykw51dc+xmWbB
 UcuVTD1hsLhg4YeMgYyEZhCXqD3X4/mKx3CeUsHgD7g0W1zgpWhd8VNfmCIabbfbSjxo
 rJ5Yjg3ofsKmK6jABGFRFEzgiZ1xuFtcpuGqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729040; x=1784333840;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YbWZ7HwoLgjxsiWWPZQJEsYuNxWCaNpuIjBuIajUoLY=;
 b=N7ikFqiREKlFfAgrZZYU1h6/tmye6tby6mSOKWTHCbQ96Z89I8Khw9jH13fTVP8jjZ
 iwIxVnTe28mmsP9WCX4GsJmV2QL+sZnXhRnkm65E7PciRpxcHzRyf47Jliql3a5JzBQs
 QeRTX4WIuLAeLEukJDFHIXcnu9qDsw88h1136fnoUgG6OXG9V6PEHD+mZZ3EddmtR34J
 jc1cnf3SB2vYrvqApFguPq0SjEY7NLl9CpIOnqnf+kZjMFVZbB/INeKYKwME24qvrsEM
 9oY14j32YDHUgLNlxnTm/OTKObFDmC8PpnMq+zhEXu/NTogAIpkacoiPRdF76FazpQpI
 vwCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KM052DitRXrg+79jDbVMueizvGLeDcOCsGZKvTLkxtMswPj7Zk01pWLG31XhN/ZBSPb67ZF0=@lists.denx.de
X-Gm-Message-State: AOJu0YwGWnARR1D2A11YOAm2bkzvv+SqP/xHlnHb714U8DPkyWv9OLGF
 0U+hiL+MKAsy9XKZomXjo+SjcH70eyIjO3ARhuWykowUu1gwFFB6pY8rQPs0i7JLCAU=
X-Gm-Gg: AfdE7cm3eHvWrfoKAu4/Gd/UpiaYVB48KjB/pqPS7Jw2tKupZDiO6pJ8dTul4acIg0y
 K/d9N99qiNVP+gPAgVsrjDpnWZ+rGQTvi/ynqGgF/qUn/yiKk3mAnZql3fpUlbwZpfX+SDeLae9
 aOeuMxgECnFpGzrFs8NyHuTKdBxqIHRO6h3wd4MON/cQtiTxuDMPg9RAMaBK392nyZwh5qRayDD
 TSeLUAj2ojTQYkvddgU1SF0/A93TLtBmP5izEp7mjKjrVV5bbcmXeGMrxDH0K/RHhyc79O+hvwa
 Di1P+nePIdIhS7qPrhLt5f0d6HARmUAVabPX+NwFudTsZFAnAcaciwbY0ar6J/NDgI4PqKjgov1
 3p1cm76zkQIp8/Vo6cFsIa6M5jzVYWUt670NihgfFQlsyzVuU4uIwywJJDtVA+aV+KyHUgUvZLR
 1rllSE1wyHLDeK+D9tkp3eU7OXyBcZL3mTqiAX1oMGewfYUasB9ZxM36W3ZfpDkTIqV0bvl3/on
 IDeP7nDVRmbBfQn3Gws+K7VWzRmf8wz4V0A
X-Received: by 2002:a05:6820:1b0b:b0:6a1:42b7:1e15 with SMTP id
 006d021491bc7-6a39a55e354mr900142eaf.14.1783729040170; 
 Fri, 10 Jul 2026 17:17:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de, 
 Anshul Dalal <anshuld@ti.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Dinesh <dinesh.maniyam@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Marek Vasut <marex@denx.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Nick Hu <nick.hu@sifive.com>, 
 Jimmy Ho <jimmy.ho@sifive.com>, Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Jonathan Stroud <jonathan.stroud@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Beiyan Yun <root@infi.wang>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, Alice Guo <alice.guo@nxp.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Alexey Charkov <alchark@gmail.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
Message-Id: <178372903629.2905849.17715604108602528341.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sat, 11 Jul 2026 02:25:52 +0200
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

On Thu, 25 Jun 2026 08:47:06 +0530, Anshul Dalal wrote:

> U-Boot does not support modules, so having tristate options is useless.
> 
> Therefore this patch does a blind replace of all tristate options to
> bool tree-wide.
> 
> 

Applied to u-boot/master, thanks!

[1/1] treewide: Kconfig: use bool instead of tristate
      commit: 199a088b96c9d352cffa59ce4043e5ac60917697
-- 
Tom


