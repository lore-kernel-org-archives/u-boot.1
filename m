Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3FACE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 21:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2049286BF1;
	Tue, 19 Sep 2023 23:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JgfvmV5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E44F86A9E; Tue, 19 Sep 2023 23:44:56 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033A986C15
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 23:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1ba5cda3530so3966298fac.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695159891; x=1695764691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MGHSXiHXGnkacY6Q01thyNvgTxlXgAkEpcodBmkPq0=;
 b=JgfvmV5fUknL78WBh7g4Mk8HhP1TQh5kFKzykTDrZ5+MOxAnyNECAuA2w48gnT7O4Q
 psjpvpRwJEQZDqxgM9dG7L3OKRcL6elgffyHbozFCpYMpYa1ratU7Zb78aN3Dvtiu+WK
 0rPuNCCzqTV91dTmUSEoQpQXDLh0n+EZnvRzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695159891; x=1695764691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MGHSXiHXGnkacY6Q01thyNvgTxlXgAkEpcodBmkPq0=;
 b=G5KsksDshPW+gUJGi6i4Jyr6ysiwS0QWIOLe5wxFUeIn9Qv9tL6o+QdRAI0gxqFioL
 AdsgmbfVuOsc44vF1rm4ajXQG1TZxndSgG02N3bixk9BS0/jAMUTC85c8F+JimH1gqM2
 Vzo3+eKnZAPfZCNy9NLGlrD2Yzpp8GZtxX9SMwq46956icIpH6gHM78dixIkn8HeaB98
 UYLzK41/idclSZpdCvoGLvBJQsDJcObM6fDZSsBMAhx5DR+F80Idu7LPyIfuJyL+/qxs
 AT3+S97t2ugxf9PrLdax7nHz7EJE0rEeF/3iQ73BU2JDAt+8vBdMVzxQXCd8NWTlQioD
 1qPg==
X-Gm-Message-State: AOJu0YxFOLJIyCrIIwXXO7WRk6eFpT9ruO7o6c5ooXApEv5Za5H2PNOa
 8q6Qed713eCXGpezXZpuNIspWqLSNB1VXd0+eazERw==
X-Google-Smtp-Source: AGHT+IEjYETBSEsVR/hVm5+rqvqAdETRqQx9hpz99PTH96OuApTR9CsrFN3Jt9xlG9A+Uu0ny7FR7Q==
X-Received: by 2002:a05:6870:64a4:b0:1d6:5dd2:d0a2 with SMTP id
 cz36-20020a05687064a400b001d65dd2d0a2mr806597oab.30.1695159891425; 
 Tue, 19 Sep 2023 14:44:51 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-eb6c-8990-1b3a-d2e2.res6.spectrum.com.
 [2603:6081:7b00:6400:eb6c:8990:1b3a:d2e2])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a81a112000000b0058451c12076sm3446458ywg.14.2023.09.19.14.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 14:44:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Harald Seiler <hws@denx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tero Kristo <t-kristo@ti.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v5 00/21] Kconfig: Tidy up some options
Date: Tue, 19 Sep 2023 17:44:48 -0400
Message-Id: <169515987640.3048065.10392427422272624884.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 14 Sep 2023 10:55:38 -0600, Simon Glass wrote:

> The view from 'make menuconfig' is confusing in places. This series aims
> to improve the top-level menu and also the boot menu.
> 
> It also groups FDT-fixup options tegether, at least the ones I could fine.
> 
> Finally this series marks the distro scripts as deprecated, so people have
> a pointer to standard boot.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

