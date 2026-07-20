Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C29C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FB1980E01;
	Mon, 20 Jul 2026 18:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5MtV8FMgZ-C; Mon, 20 Jul 2026 18:10:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C171180DD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571031;
	bh=4zZvYMCqMKetb/5qSAxLLlu5eM0+W4XYFTVlUaUpOe8=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=pUumrp0FdF33ddXJxFxdQcg4OFhLbzYD1GKX6C2QrIHIrSyz3ftJ78k2HHlipGEGG
	 bpEGKRtLbLfnf6XvFSnaZSqclXumUhAJcL3P16KuWx8tUtPwgyey45v6y9sX33cZOZ
	 PsGMHLdGo65Ezenw1VdbKti/qG28tKuGCdAOOKV4d3J28Nni2FHoRRYxIDOBQfLlQT
	 jPwUR6kAmPa/yXZBu1gIPlTvofeOwPons42Ey1syKlV+9dnqtaPV3eAFO3wTTP2bWf
	 MCNeKJotTW86MwNdC23UixeahhqYlES3Qo/959qsrjKf7sWZg44bhxp9LJ6t+sTpJa
	 e/2Cx2whdf4EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C171180DD8;
	Mon, 20 Jul 2026 18:10:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE57E1E65
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC11A6060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFvrhxCpOCrb for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 255C7606ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 255C7606ED
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 255C7606ED
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38DDD84659; Mon, 20 Jul 2026 18:40:46 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249E680433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:40:42 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so1144708f8f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565642; x=1785170442;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4zZvYMCqMKetb/5qSAxLLlu5eM0+W4XYFTVlUaUpOe8=;
 b=k7Strh0h2OlfWkS/1R79F2llqJSY2+zur85CNAE8Up8LY7hLN19rroWUHODy8ujpen
 cslEUxVquKZsy4/KHp2dQrKd0z0tBVpjT4X3VJSkFxdn1IPTPvV7VU2yDMQ6ZT4lIZdU
 GkhDrsSe6GihOzeDRQYuVWM119VCs8VBdq0ngrwX1EiSC5E6Sahd0jDl8Z06maZpPbWU
 GyBFprczgfSBA6A0n+XWwWJwSq+f2lPwb+nTIcrOxr+ZEXYjcn0yrbjPDvrZtGre/T25
 2gcf+DpPP7rWfpGHeTU7+xVz1tuzneLaFFMdVsVv6pfAhesAhqI/vN52si71I4e0fyqg
 8rKQ==
X-Gm-Message-State: AOJu0YzwD+wb+X6M8Tg3ub/3uUJMziC07lAfRQ2KWYTAyJ5R0Ef3GuzG
 SNzd1jSi7++W3GUfgxWaTwzqZFLgdSLMs9TSGDRUapeGP3L1yT6YS7cOfZgZP0nZZYs=
X-Gm-Gg: AfdE7clN1HiA+nSRuU/YKvZOUKFByFmhF7ER20lUybazaJJogbmftZaJSWpqUf0JQ6L
 ZFTF0ZShYfFwGMThnOHst84hOlsk/iLY0QI3TLVKk5WlGJyvqzuX2XjVd8ru3k8FnYPf4vcBZU0
 ZQ25d7WELZQrD6P15ywPN2k7Ifr+WgPHc+DNmdRS19ipno5fD14QioU3e0ASUKIK/IYmQ1OmIvI
 TO+OZbCBAd6DqV3ZbQ50qhfwG9iB+tjvIS+JoDQNkTcuKUMcV9PAa/8DUhj+LOG+My4A9s7xKmY
 zLFUwKT5umz3/MPP2iwILJzVzubodKYxBzJh5WQQS7HdqJHMF/spGnaRiDrYosU4bRHTrhCLicv
 rnjesvrFsVx7qT58d1Qw+BMcKYiYs/bhVQ2IR3iNp0I8BACEffGRdsxJXBXeJMqoUDB432wCUlB
 n8U/cEwTDncQFZybSMze6O85Lz7JSb9g==
X-Received: by 2002:a05:600c:1549:b0:493:c601:3e23 with SMTP id
 5b1f17b1804b1-4954a3d08c0mr159935615e9.5.1784565642133; 
 Mon, 20 Jul 2026 09:40:42 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:40:41 -0700 (PDT)
Subject: [PATCH 00/36] clk: port Linux Common Clock Framework to U-Boot
Date: Mon, 20 Jul 2026 17:40:27 +0100
Message-Id: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQhqjgVcRFMv7VKVpLpimW0
 rsbdfkt3lvJkBVGp2aljFlNX0NFu2tI7nG4gfVaTd75gzt6xxINC4t0XEabMuKT+/JY2LWyT1F
 CCgFU6zGj0/fvfL78bSX1kOm7o237AJwDGLN7AAAA
X-Change-ID: 20260720-casey-ccf-upstream-july-01c5bac4b44e
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=23785;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Rk1YEzKS1DzTNaj4sarpSyrvgLc8cEydbdKWr9tf3Cs=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk9/VamDNMsy86qVmawnkSpUTgI6jIh1hjP3W
 rMXdHZvLYaJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PfwAKCRAFgzErGV9k
 tuqQD/9tgpIgD/Nj4cvUscds0FhSMz6cjwvgSarc5BOCKXlit4wJ5RZjI47FaazFgCwHzJLisde
 NBTVbz7ltONaDseTe/iPoysBEHCaNIiYkOc8UHFgtEeiYpUAOILXiqiaCQTK4DIWlwmfyxYGZ60
 ySNpPDAW/lCteZmlOZo/o3elChikzHR62prgfyCvuQZO+y57UxpOZ1g8dw/tsGO2XfGnWJ8JR0J
 W05wO5ty/vuWhq1QpPufA6tOCn1gXvEU0Ph1qcv0AKEhfuJmimq7S2axtOtxq9YzQZ9Er1fkxW9
 mS3Lp4wj4eD4okn8/VPKxwFpANBFeTiTz7gObT1GMhY4HKuR2RYAHWPV60+SC6PrcGhxqXelGgc
 x5ucCgkLGolALc2zolCX47x0gVeJHX3Er6NmRm+1IjrG9frui1ykIUnncEUbznyP3R8FkFnaUCM
 V2mTBz9r7+q2sHwIfrdOq7q38JnbTnTZ0FkQ9eTP6SzpO3jOE2SrdWjrtUX1VhHGmbbMqjL1IkL
 6ozwHvVHsQb8saiyRFu/v7c1xTQCk30Mgj+mczNbB8o1+W/GH0/Iv5PTtt8j46IUtnMsVN0jq8g
 jwqZU2Myh3UdyEA6bRGIKSFJfXJjjgf6ABV3uFLesVjiWyugy2H/sTW6UrZjFyf/UDHb5HrArHt
 j/eFfXeyMI0RMFA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565642; x=1785170442; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4zZvYMCqMKetb/5qSAxLLlu5eM0+W4XYFTVlUaUpOe8=;
 b=GpOZRDhuYfu1673fuGTAnbF2NfyGMaw7FIKeMBzHivPv96CxbzY968ClWaO6I3dS8F
 i+6uIi4w/n6dmwXvnSfS/SqvTAjDW5VDeanj9zSRgVH5XI20j82ldaWxJjYh2F5YLuPw
 lZSjL4KUOPtKqldViy2zMgsmZAyVfwzza4IaIGVt+MKNDMZKy7C5O74DzMBw0VR0QxIB
 p3PAZ8CA1GE+TbKN1+PfFNuAEAbb7AY9TfmhCxQvZ5p1QeVss2sl4hLj1m2t2uZXoZFd
 VBeE5d9IT/IKUU/NqkV+PiHVEd0s+kRZMsd/QiErexMLRFm0tlNSFIzoclu8fva82HDv
 74bg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=GpOZRDhu
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="GpOZRDhu"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series introduces support for the Linux Common Clock framework in
U-Boot, when enabled it replaces UCLASS_CLK entirely, instead offering
the typical clock provider API from Linux. This has the significant
advantage of allowing one "udevice" to provide an arbitrary number
of clocks without the need to populate U-Boot driver model with dummy
devices.

Historically, U-Boots clock support has focused on being small and
simple, allowing platforms to configure the clocks they need to boot.
But as we support more modern SoCs it's become clear that the existing
API doesn't scale as we need to be able to calculate clock rates, handle
reparenting, and other more complicated configurations. Rather than
trying to re-invent the wheel here (which would likely never leave us
with a truly satisfactory solution) adopting the Linux API solves a
whole host of problems in U-Boot.

With the Linux CCF, complicated Linux clock drivers can now be adopted
with relative ease rather than having to painfully rewrite them to work
in U-Boots limited clock model. This also drastically simplifies the
bringup process for new platforms.

To offer an example, the DSI PHY devices on most Qualcomm platforms
have their own VCO, PLL, dividers, and muxes which are programmed
based on the pixel clock of the display, if it's using D-phy or
C-phy, display stream compression, etc. This isn't directly modelled
in devicetree though since the PHY clock outputs are routed into the
"dispcc" block which is what the DSI controller itself sees. Modelling
the relationship between the pixel/byte clocks in dispcc and their
parents in the phy must be handled by the clock framework and though
assigned-clock-parents, something that U-Boots existing clock framework
simply doesn't support. Additionally, dual-DSI panels are even more
annoying since both sets of pixel/byte clocks are sourced from only one
of the PHYs.

U-Boot did already have some very limited support for "CCF", however
this is essentially just using the driver model to maintain the clock
tree and registering a device for each clock. This simply doesn't
scale well for the huge number of clocks on modern platforms and still
requires significant effort to port drivers from Linux.

There is one notable limitation with the full CCF port, since it
requires the entire clock tree to be modelled before it can actually
manage any clocks it isn't feasible to run pre-relocation making it
unsuitable for platforms that require clocks at this point. My hope is
that we can continue to reduce the complexity of U-Boots pre-relocation
stage to mitigate this issue, but since some platforms are already using
CONFIG_SKIP_EARLY_DM I hope this won't be a blocking issue.

When it comes to U-Boot SPL, it likely doesn't make sense to expect to
use CCF in that environment. Since the scope of SPL is so much smaller
it should still be acceptable to use UCLASS_CLK here and only build with
CCF for full U-Boot images.

-- Overview --

This series contains a few preparatory patches to align U-Boots
existing clock API with upstream and rename clk_ops to clk_ops_uboot to
differentiate UCLASS_CLK ops.

The generic CCF mux/div/fixed clock drivers are in drivers/clk/ccf along
with the CCF core.

Sandbox also gets CCF_FULL support for the purposes of testing.

Lastly, the Qualcomm clock drivers from Linux are ported over with
minimal changes to enable CCF support on the SM8650 platform, this will
be expanded in the future to other Qualcomm platforms. This demonstrates
the ease of porting Linux drivers and acts as a template that others
can follow.

-- Architecture --

The CCF port is fairly straightforward, clk-uclass.c has some its common
API split out into clk-common.c which either calls into clk-uclass or
ccf/clk.c based on the configuration. To keep things simple, CLK_UCLASS
is completely unsupported when CCF is enabled, by not building
clk-uclass.c we don't provide any support for non-CCF clocks and they
won't show up in the device model at runtime.

Devices that provide clocks can be of any uclass, they will be probed
via ofnode lookup and should register their clocks with CCF (via the
typical clk_register helpers) during probe.

Clock consumers still work the same way, although internal API
differences may require changes to some drivers such as the UFS fixes in
this series. Notably it may be necessary to actually call clk_set_rate()
with a suitable rate, I think it's safe to say these calls being
missing and relying on the clock driver to pick a suitable rate is a bug
regardless of CCF.

-- Merging and maintenance --

Given the scope and complexity of this change and that it's entirely
opt-in, I'm hopeful that we can focus on issues that are important to
solve before this can be merged, and focus on improving any rough edges
after the fact. This will also make it easier for others to try it out
and investigate using CCF_FULL for their platforms.

In the short-medium term I'm happy to maintain this port and help others
who are interested in using it. However I very much invite anyone with
an interest in this to co-maintain it or take it over in the future.

I previously sent an RFC for this which can be found below, it has gone
through some significant rework since then and quite a bit of testing
locally as I've used this as the basis for Qualcomm display bringup.

https://lore.kernel.org/u-boot/20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org/

---
Casey Connolly (36):
      clk: move U-Boot CCF to clk/uccf
      clk: rename clk_ops to clk_ops_uboot
      clk: move fixed clocks to clk/basic
      clk: make clk_set_rate() return signed long
      clk: make clk_get_parent_rate return signed long
      clk: compat: add clk (un)prepare and associated functions
      dm: ofnode: fix parse_phandle_with_args API
      clk: import full CCF from Linux
      clk: move clock flags to common clk-provider.h
      clk/ccf: adapt clk-conf for U-Boot
      clk/ccf: adapt CCF core for U-Boot
      clk/ccf: adapt CCF generic clocks for U-Boot
      clk: split clk-uclass.c into clk-common.c
      clk/common: add CCF_FULL support
      clk/ccf: optimise orphan clock handling
      clk/ccf: debug log enable/disable calls
      cmd/clk: add CCF_FULL support
      doc: describe Common Clock Framework
      clk/sandbox: add a CCF_FULL port of clk_sandbox
      clk: sandbox: fix set_rate and move to clk/basic
      clk/ccf: add CCF_FULL port of clk_sandbox
      test: dm: adjust clk tests for CCF_FULL
      configs: add sandbox CCF_FULL defconfig
      CI: add sandbox64_ccf_full
      MAINTAINERS: add entry for CCF port
      clk/qcom: move existing clock drivers to clk/qcom/basic
      clk/qcom: drop in Linux Qualcomm CCF drivers
      clk/qcom/ccf: drop in Linux rpmh clock driver
      clk/qcom/ccf: add sm8650 GCC, dispcc and tcsrcc.
      clk/qcom/ccf: add uboot common code
      clk/qcom/ccf: adapt common, gdsc, and reset code for U-Boot
      clk/qcom/ccf: adapt clocks for U-Boot
      clk/qcom/ccf: adapt sm8650 clock drivers for U-Boot
      ufs: qcom: use clk_prepare_enable_bulk()
      qcom_sm8650_defconfig: enable CCF_FULL
      ufs: qcom: fix core clk max rate setting

 .gitlab-ci.yml                                     |    5 +
 MAINTAINERS                                        |    7 +
 arch/arm/cpu/armv7/bcm281xx/clk-core.c             |    8 +-
 arch/arm/cpu/armv7/bcm281xx/clk-core.h             |   14 +-
 arch/sandbox/dts/test.dts                          |    4 +-
 arch/sandbox/include/asm/clk.h                     |    2 +-
 cmd/clk.c                                          |   21 +-
 configs/qcom_sm8650_defconfig                      |    1 +
 configs/sandbox64_ccf_full_defconfig               |    5 +
 doc/api/clk.rst                                    |   25 +
 doc/develop/ccf.rst                                |   35 +
 doc/develop/index.rst                              |    1 +
 drivers/clk/Kconfig                                |   54 +-
 drivers/clk/Makefile                               |   21 +-
 drivers/clk/adi/clk-adi-pll.c                      |    2 +-
 drivers/clk/adi/clk-shared.c                       |    4 +-
 drivers/clk/adi/clk.h                              |    2 +-
 drivers/clk/airoha/clk-airoha.c                    |    4 +-
 drivers/clk/altera/clk-agilex.c                    |    2 +-
 drivers/clk/altera/clk-agilex5.c                   |    2 +-
 drivers/clk/altera/clk-arria10.c                   |    2 +-
 drivers/clk/altera/clk-mem-n5x.c                   |    2 +-
 drivers/clk/altera/clk-n5x.c                       |    2 +-
 drivers/clk/aspeed/clk_ast2500.c                   |    4 +-
 drivers/clk/aspeed/clk_ast2600.c                   |    4 +-
 drivers/clk/aspeed/clk_ast2700.c                   |    4 +-
 drivers/clk/at91/clk-generic.c                     |    4 +-
 drivers/clk/at91/clk-main.c                        |    8 +-
 drivers/clk/at91/clk-master.c                      |    8 +-
 drivers/clk/at91/clk-peripheral.c                  |    6 +-
 drivers/clk/at91/clk-programmable.c                |    4 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |   10 +-
 drivers/clk/at91/clk-sam9x60-usb.c                 |    4 +-
 drivers/clk/at91/clk-system.c                      |    2 +-
 drivers/clk/at91/clk-utmi.c                        |    4 +-
 drivers/clk/at91/compat.c                          |   30 +-
 drivers/clk/at91/pmc.c                             |    2 +-
 drivers/clk/at91/pmc.h                             |    2 +-
 drivers/clk/at91/sckc.c                            |    4 +-
 drivers/clk/basic/Makefile                         |    8 +
 drivers/clk/{ => basic}/clk_fixed_factor.c         |    2 +-
 drivers/clk/{ => basic}/clk_fixed_rate.c           |    4 +-
 drivers/clk/{ => basic}/clk_sandbox.c              |   12 +-
 drivers/clk/ccf/Kconfig                            |    8 +
 drivers/clk/ccf/Makefile                           |   19 +
 drivers/clk/ccf/clk-composite.c                    |  495 +++
 drivers/clk/ccf/clk-conf.c                         |  189 +
 drivers/clk/ccf/clk-divider.c                      |  663 ++++
 drivers/clk/ccf/clk-fixed-factor.c                 |  409 +++
 drivers/clk/ccf/clk-fixed-rate.c                   |  217 ++
 drivers/clk/ccf/clk-gate.c                         |  260 ++
 drivers/clk/ccf/clk-mux.c                          |  282 ++
 drivers/clk/ccf/clk.c                              | 3250 +++++++++++++++++
 drivers/clk/ccf/clk.h                              |   53 +
 drivers/clk/ccf/clk_sandbox.c                      |  281 ++
 drivers/clk/ccf/clk_sandbox_ccf_full.c             |  220 ++
 drivers/clk/clk-cdce9xx.c                          |    4 +-
 drivers/clk/clk-common.c                           |  255 ++
 drivers/clk/clk-common.h                           |   45 +
 drivers/clk/clk-gpio.c                             |    2 +-
 drivers/clk/clk-hsdk-cgu.c                         |    4 +-
 drivers/clk/clk-stub.c                             |    4 +-
 drivers/clk/clk-uclass.c                           |  202 +-
 drivers/clk/clk-xlnx-clock-wizard.c                |    4 +-
 drivers/clk/clk_bcm6345.c                          |    2 +-
 drivers/clk/clk_boston.c                           |    2 +-
 drivers/clk/clk_k210.c                             |    8 +-
 drivers/clk/clk_octeon.c                           |    2 +-
 drivers/clk/clk_pic32.c                            |    4 +-
 drivers/clk/clk_sandbox_test.c                     |    2 +-
 drivers/clk/clk_scmi.c                             |    6 +-
 drivers/clk/clk_versaclock.c                       |   22 +-
 drivers/clk/clk_versal.c                           |    4 +-
 drivers/clk/clk_vexpress_osc.c                     |    4 +-
 drivers/clk/clk_zynq.c                             |    8 +-
 drivers/clk/clk_zynqmp.c                           |    6 +-
 drivers/clk/exynos/clk-exynos7420.c                |    6 +-
 drivers/clk/exynos/clk-pll.c                       |    4 +-
 drivers/clk/exynos/clk.h                           |    2 +-
 drivers/clk/ics8n3qv01.c                           |    4 +-
 drivers/clk/imx/clk-composite-8m.c                 |    6 +-
 drivers/clk/imx/clk-composite-93.c                 |    2 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |    4 +-
 drivers/clk/imx/clk-gate-93.c                      |    4 +-
 drivers/clk/imx/clk-gate2.c                        |    4 +-
 drivers/clk/imx/clk-imx6q.c                        |    2 +-
 drivers/clk/imx/clk-imx6ul.c                       |    2 +-
 drivers/clk/imx/clk-imx8.c                         |    4 +-
 drivers/clk/imx/clk-imx8.h                         |    2 +-
 drivers/clk/imx/clk-imx8qm.c                       |    2 +-
 drivers/clk/imx/clk-imx8qxp.c                      |    2 +-
 drivers/clk/imx/clk-imxrt1020.c                    |    2 +-
 drivers/clk/imx/clk-imxrt1170.c                    |    4 +-
 drivers/clk/imx/clk-pfd.c                          |    4 +-
 drivers/clk/imx/clk-pll14xx.c                      |    8 +-
 drivers/clk/imx/clk-pllv3.c                        |   18 +-
 drivers/clk/intel/clk_intel.c                      |    2 +-
 drivers/clk/mediatek/clk-mtk.c                     |   14 +-
 drivers/clk/mediatek/clk-mtk.h                     |   10 +-
 drivers/clk/meson/a1.c                             |    8 +-
 drivers/clk/meson/axg-ao.c                         |    2 +-
 drivers/clk/meson/axg.c                            |    2 +-
 drivers/clk/meson/clk-measure.c                    |    2 +-
 drivers/clk/meson/g12a-ao.c                        |    2 +-
 drivers/clk/meson/g12a.c                           |   10 +-
 drivers/clk/meson/gxbb.c                           |    8 +-
 drivers/clk/microchip/mpfs_clk_cfg.c               |    4 +-
 drivers/clk/microchip/mpfs_clk_msspll.c            |    2 +-
 drivers/clk/microchip/mpfs_clk_periph.c            |    2 +-
 drivers/clk/mpc83xx_clk.c                          |    2 +-
 drivers/clk/mtmips/clk-mt7620.c                    |    2 +-
 drivers/clk/mtmips/clk-mt7621.c                    |    2 +-
 drivers/clk/mtmips/clk-mt7628.c                    |    2 +-
 drivers/clk/mvebu/armada-37xx-periph.c             |    4 +-
 drivers/clk/mvebu/armada-37xx-tbg.c                |    2 +-
 drivers/clk/nuvoton/clk_npcm.c                     |    4 +-
 drivers/clk/nuvoton/clk_npcm.h                     |    2 +-
 drivers/clk/owl/clk_owl.c                          |    6 +-
 drivers/clk/qcom/Kconfig                           |    1 +
 drivers/clk/qcom/Makefile                          |   31 +-
 drivers/clk/qcom/basic/Makefile                    |   28 +
 drivers/clk/qcom/{ => basic}/clock-apq8016.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-apq8096.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-ipq4019.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-ipq5424.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-ipq9574.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-milos.c         |    4 +-
 drivers/clk/qcom/{ => basic}/clock-qcm2290.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcom.c          |    4 +-
 drivers/clk/qcom/{ => basic}/clock-qcom.h          |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcs404.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcs615.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-qcs8300.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sa8775p.c       |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sc7280.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sdm845.c        |    4 +-
 drivers/clk/qcom/{ => basic}/clock-sm6115.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm6125.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm6350.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm7150.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm8150.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm8250.c        |    2 +-
 drivers/clk/qcom/{ => basic}/clock-sm8550.c        |    4 +-
 drivers/clk/qcom/{ => basic}/clock-sm8650.c        |    4 +-
 drivers/clk/qcom/{ => basic}/clock-x1e80100.c      |    4 +-
 drivers/clk/qcom/ccf/Makefile                      |   21 +
 drivers/clk/qcom/ccf/clk-alpha-pll.c               | 3196 ++++++++++++++++
 drivers/clk/qcom/ccf/clk-alpha-pll.h               |  251 ++
 drivers/clk/qcom/ccf/clk-branch.c                  |  203 ++
 drivers/clk/qcom/ccf/clk-branch.h                  |  125 +
 drivers/clk/qcom/ccf/clk-rcg.h                     |  217 ++
 drivers/clk/qcom/ccf/clk-rcg2.c                    | 1765 +++++++++
 drivers/clk/qcom/ccf/clk-regmap-divider.c          |   90 +
 drivers/clk/qcom/ccf/clk-regmap-divider.h          |   22 +
 drivers/clk/qcom/ccf/clk-regmap-mux-div.c          |  232 ++
 drivers/clk/qcom/ccf/clk-regmap-mux-div.h          |   44 +
 drivers/clk/qcom/ccf/clk-regmap-mux.c              |   57 +
 drivers/clk/qcom/ccf/clk-regmap-mux.h              |   23 +
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.c          |   62 +
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.h          |   33 +
 drivers/clk/qcom/ccf/clk-regmap.c                  |  104 +
 drivers/clk/qcom/ccf/clk-regmap.h                  |   38 +
 drivers/clk/qcom/ccf/clk-rpmh.c                    | 1030 ++++++
 drivers/clk/qcom/ccf/common-uboot.c                |  188 +
 drivers/clk/qcom/ccf/common-uboot.h                |   34 +
 drivers/clk/qcom/ccf/common.c                      |  248 ++
 drivers/clk/qcom/ccf/common.h                      |  106 +
 drivers/clk/qcom/ccf/dispcc-sm8550.c               | 1825 ++++++++++
 drivers/clk/qcom/ccf/gcc-sm8650.c                  | 3846 ++++++++++++++++++++
 drivers/clk/qcom/ccf/gdsc.c                        |  545 +++
 drivers/clk/qcom/ccf/gdsc.h                        |  103 +
 drivers/clk/qcom/ccf/reset.c                       |  112 +
 drivers/clk/qcom/ccf/reset.h                       |   29 +
 drivers/clk/qcom/ccf/tcsrcc-sm8650.c               |  174 +
 drivers/clk/qcom/clock-sc7180.c                    |    2 +-
 drivers/clk/renesas/clk-rcar-gen2.c                |    4 +-
 drivers/clk/renesas/clk-rcar-gen3.c                |    4 +-
 drivers/clk/renesas/compound-clock.c               |    4 +-
 drivers/clk/renesas/r8a78000-cpg.c                 |    6 +-
 drivers/clk/renesas/r9a06g032-clocks.c             |    6 +-
 drivers/clk/renesas/rcar-gen2-cpg.h                |    2 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    2 +-
 drivers/clk/renesas/rzg2l-cpg.c                    |    8 +-
 drivers/clk/rockchip/clk_px30.c                    |   12 +-
 drivers/clk/rockchip/clk_rk3036.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3066.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3128.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3188.c                  |    4 +-
 drivers/clk/rockchip/clk_rk322x.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3288.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3308.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3328.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3368.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3399.c                  |    8 +-
 drivers/clk/rockchip/clk_rk3506.c                  |    4 +-
 drivers/clk/rockchip/clk_rk3528.c                  |   10 +-
 drivers/clk/rockchip/clk_rk3568.c                  |   14 +-
 drivers/clk/rockchip/clk_rk3576.c                  |    8 +-
 drivers/clk/rockchip/clk_rk3588.c                  |   12 +-
 drivers/clk/rockchip/clk_rv1108.c                  |    4 +-
 drivers/clk/rockchip/clk_rv1126.c                  |   12 +-
 drivers/clk/sifive/sifive-prci.c                   |    4 +-
 drivers/clk/sophgo/clk-cv1800b.c                   |    4 +-
 drivers/clk/sophgo/clk-ip.c                        |   30 +-
 drivers/clk/sophgo/clk-ip.h                        |   18 +-
 drivers/clk/sophgo/clk-pll.c                       |    8 +-
 drivers/clk/sophgo/clk-pll.h                       |    4 +-
 drivers/clk/starfive/clk-jh7110-pll.c              |    4 +-
 drivers/clk/starfive/clk.h                         |    2 +-
 drivers/clk/stm32/clk-stm32-core.c                 |   22 +-
 drivers/clk/stm32/clk-stm32-core.h                 |    2 +-
 drivers/clk/stm32/clk-stm32f.c                     |    4 +-
 drivers/clk/stm32/clk-stm32h7.c                    |    2 +-
 drivers/clk/stm32/clk-stm32mp1.c                   |    4 +-
 drivers/clk/sunxi/clk_sun6i_rtc.c                  |    2 +-
 drivers/clk/sunxi/clk_sunxi.c                      |    2 +-
 drivers/clk/tegra/tegra-car-clk.c                  |    4 +-
 drivers/clk/tegra/tegra186-clk.c                   |    4 +-
 drivers/clk/thead/clk-th1520-ap.c                  |    8 +-
 drivers/clk/ti/clk-am3-dpll-x2.c                   |    2 +-
 drivers/clk/ti/clk-am3-dpll.c                      |    4 +-
 drivers/clk/ti/clk-ctrl.c                          |    2 +-
 drivers/clk/ti/clk-divider.c                       |    4 +-
 drivers/clk/ti/clk-gate.c                          |    2 +-
 drivers/clk/ti/clk-k3-pll.c                        |    4 +-
 drivers/clk/ti/clk-k3.c                            |    6 +-
 drivers/clk/ti/clk-mux.c                           |    4 +-
 drivers/clk/ti/clk-sci.c                           |    4 +-
 drivers/clk/uccf/Kconfig                           |   22 +
 drivers/clk/uccf/Makefile                          |   11 +
 drivers/clk/{ => uccf}/clk-composite.c             |   20 +-
 drivers/clk/{ => uccf}/clk-divider.c               |    4 +-
 drivers/clk/{ => uccf}/clk-fixed-factor.c          |    2 +-
 drivers/clk/{ => uccf}/clk-gate.c                  |    2 +-
 drivers/clk/{ => uccf}/clk-mux.c                   |    2 +-
 drivers/clk/{ => uccf}/clk.c                       |    4 +-
 .../{clk_sandbox_ccf.c => uccf/clk_sandbox_uccf.c} |   12 +-
 drivers/clk/uniphier/clk-uniphier-core.c           |    6 +-
 drivers/core/ofnode.c                              |    4 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |    2 +-
 drivers/phy/cadence/phy-cadence-torrent.c          |    2 +-
 drivers/phy/phy-stm32-usbphyc.c                    |    2 +-
 drivers/phy/phy-ti-am654.c                         |    2 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |    6 +-
 drivers/power/domain/imx8mp-hsiomix.c              |    2 +-
 drivers/ufs/ufs-qcom.c                             |   31 +-
 include/clk-uclass.h                               |    6 +-
 include/clk.h                                      |  102 +-
 include/linux/clk-provider-ccf_full.h              | 1461 ++++++++
 include/linux/clk-provider-uccf.h                  |  256 ++
 include/linux/clk-provider.h                       |  253 +-
 include/linux/clk/clk-conf.h                       |   22 +
 include/sandbox-clk.h                              |    5 +-
 test/dm/Makefile                                   |    3 +-
 test/dm/clk.c                                      |   32 +-
 test/dm/clk_ccf.c                                  |  117 +-
 test/test-main.c                                   |    6 +
 258 files changed, 24032 insertions(+), 997 deletions(-)
---
base-commit: e0ef25054db31fee49d031ac337099b12c67e5b8

Casey Connolly <casey.connolly@linaro.org>

