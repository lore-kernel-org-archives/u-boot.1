Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2812CC46CD3
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 00:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E419876CA;
	Fri, 22 Dec 2023 01:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hn0zozhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5E0876CA; Fri, 22 Dec 2023 01:03:44 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A178877D5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 01:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7811b05d23bso81028185a.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703203419; x=1703808219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vseWRKdOOZ3I2aZ/HETu5m6IXzSyvLr5QJxJAGL7rn8=;
 b=Hn0zozhDrP0PN9A9UPXUi2vXRLd/mwj41wtvxh/LRZplU2JdwywGY/JP8A+9zsphnb
 e0u3VMn0sxwq1vnKdEn40NqGzjqyx1BZcpC0Qz8613VqHnwbTAGiNdStC22tia1H/mox
 4R2bTEEDlmy1ShxX/x309RtKC6opRdRPSBjhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703203419; x=1703808219;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vseWRKdOOZ3I2aZ/HETu5m6IXzSyvLr5QJxJAGL7rn8=;
 b=nCkVLeyz68baqMFqT1VfxZp/pfVTY2P/1dOjjeGZq9Y+NXZMyoBUlmWUSIp58GiwRe
 6rKyFBrEBnocnITJtLMS6P5M1jI7ZAVvYVFovSxVga4t7HU2PgXRn7YrCsP9whgfgpnE
 /HIWtZfbOIbAobITtOEa0Z9eqd8tM5dF5UAAqQZyc3D3mDyEDujIN+D9+aEMZhwC/I1S
 KlBXF2XXmlBovaWVHL3YFnMyGA61hTJf+9NrZwPXbS0myk+bq7ZrHEKPbHtlj64YFEaN
 bAGkiuOXCrYAXbEctU3EqI4b9blw6+qfyGN64qc9ZmX53bT4q54m25Ke4jK1hEy5k0rj
 B+Kw==
X-Gm-Message-State: AOJu0Yw/0+ho1oN1AItFi1SgDt7Sf+tD0KsAhz7OAfWPjKgiq+X7YGPg
 VNRzkCgcP0I+2/8l6vJr0DI5wq8obFlZwpd0ITlIto68mtE=
X-Google-Smtp-Source: AGHT+IHrB9XCUEQqgyF4hvfzgcL4Hyn5ERp1Y4oHKD1Vuf0CxZjKB+Civ8gtnCSL6l91diIGO//UoQ==
X-Received: by 2002:a05:620a:2441:b0:781:129e:100 with SMTP id
 h1-20020a05620a244100b00781129e0100mr759474qkn.98.1703203419044; 
 Thu, 21 Dec 2023 16:03:39 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 bk7-20020a05620a1a0700b0077d7326c60csm1008515qkb.38.2023.12.21.16.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 16:03:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>, 
 Chanho Park <chanho61.park@samsung.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nikita Shubin <n.shubin@yadro.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>, 
 Safae Ouajih <souajih@baylibre.com>, Scott McNutt <smcnutt@psyent.com>, 
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>, 
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>, 
 uboot-snps-arc@synopsys.com, uboot-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/22] Complete decoupling of bootm logic from commands
Message-Id: <170320341698.2190413.10444075609654502560.b4-ty@konsulko.com>
Date: Thu, 21 Dec 2023 19:03:36 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Mailman-Approved-At: Fri, 22 Dec 2023 01:04:16 +0100
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

On Fri, 15 Dec 2023 20:14:04 -0700, Simon Glass wrote:

> This series continues refactoring the bootm code to allow it to be used
> with CONFIG_COMMAND disabled. The OS-handling code is refactored and
> a new bootm_run() function is created to run through the bootm stages.
> This completes the work.
> 
> A booti_go() function is created also, in case it proves useful, but at
> last for now standard boot does not use this.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


