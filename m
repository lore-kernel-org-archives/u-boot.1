Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0487FC624D1
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 06:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34A3083C5E;
	Sun, 22 Feb 2026 07:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E/1at9mK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C4980FA1; Sun, 22 Feb 2026 02:27:56 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284E780077
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 02:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c6e266a3572so1082461a12.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771723672; cv=none;
 d=google.com; s=arc-20240605;
 b=KvGNq6rm5VU87b+Y0M/V2FiLwWzceNftD2iIv/ExzTrXEOlvjAHTIegMs8m1jRqsLx
 yjy8RFECjS2L1ym+q1O069aId9QaQKltXidsvFaC/q7H3mfb0BGb+ozKja005wPvwUMF
 dwVvOPZuTTn29YY90s5/i3cl/uxAtIfk3yWOy+aRTa9b6H8aDgVJSVwExGVetRXrbJRn
 CJVD5N09s+0HudR05N09h+FmiWzWjCsmt2uAzQ1P5LDDS7K71WGdcjeZYCiBkIi+e2KG
 E+82bwjpf7CpqcacxyI51ylklhF951zmVMWlQqlX7TnNlku7s9Ww7UfIJaQbr3AR00it
 g44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PEMywllvHVaWTMrC2cXvALvhk/OHqB0d7CXepK56xh0=;
 fh=YjJoQ29oBf8rid7ykNavip6eQGMiYMFM8lXCeWfCZ+w=;
 b=K8xwjwwO4Vnk41tZlSxxl3qe+OG+JyppoUb79+Orux+p45qB174mGmNO/+z8RJRP9k
 neDnGYDhMHVOXcvVWsGpkHcFwSMWh7OZYFRXSuHMglLR91JrjRbwXToU5+KIJeNj4HTr
 IMXjB+pFOHrOPF+slhH7QWrtQT1IepCf90W16/mgB0PrUASeoTZdp6qNKEs4Hw8gnPXz
 29EKIApLYTzYeqEQsRw/ggM7UBT0B9fvrvpxozqAcIvmcgbsZz3sJLgsnb7weZCuYb4a
 KP804mo5+EjQRv5QC673KoZAW5VmeZ0pQuQnBYxU5JyTeBxwAhEADXGXQv5Bpo/ndwTr
 ZWSg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771723672; x=1772328472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PEMywllvHVaWTMrC2cXvALvhk/OHqB0d7CXepK56xh0=;
 b=E/1at9mK7ArbFz03crkfjo5+bVZYqNKssufvwPSglGyPkjIEPW/4fD767migYVwXWy
 WsM2q5EST90T1LNmyEEqNnHfRr4OGgUcbGfCNzhmm0zC14bEieNEIJnj6sO/U26OrqBQ
 tRH780AAAyHa1rbPBc2h5lH1oML/aK9b+zkGah56WxU+kCXaNy1lxc5uzOCPSR3D36rl
 d0cMke2eYAqsJE5w2IvjerrFtd0AYAprzmk9HA+dfclm68c3FjCmEY3zIMDfXMiplHsG
 BzJ5VyuXr2pBfvngau7c5b1mL8fnM7SakxH8Iqq6iGJ/8yr+Em1ZEQK8n8tnz3Y2L7fJ
 ogHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771723672; x=1772328472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEMywllvHVaWTMrC2cXvALvhk/OHqB0d7CXepK56xh0=;
 b=L8VyV2eLJoIUlhcAFImDuHccw2duQSa47HaPZVM6I5PwuDtBSH7FvthV9ebGXl5XlG
 gES5b04geOb4C8WzcMpZ7SREqtLTywTCtP03KsL/TpYTs1noFDALnMAAP8xXQu5Iz362
 QDtr5aKPxACzK4h75HcmRdLhe9jnhy8WOu7IhStmG6rY5iF+DB1zCkH+hHaPyFE9tPpw
 lW9xHAkon0pKLE1M3T3SYiuFynaVtoCKKV6uy09ykj+MQgfm0VEiE4Vf69BX7uk2FQS6
 L6uAVxetRUS2F7QTOW1JLwCEDFMn+vi23jQCHHvCxu0iRP0FSjMnoihm7bU7gbK0Jnv3
 +nrA==
X-Gm-Message-State: AOJu0YxAUnaXlXm7xzZU+Bjg5iCp0IzKYUaMa9qgN8Kd2Rhc7PzOrqgL
 ZRAZdMKYHm4cnBbk3n36nx+b9iPb9o69CDtHRNfI8lu9/6HzYhflMabghcymanVSLS9uruK1hFL
 DEOU2n1H1RAOIXi8CL3uVBCMdfrft5VQ=
X-Gm-Gg: AZuq6aI8ol4K2aqt44Ig1bt4XICqW1bGEul2LUZ35K+ZtwrwlIzEGh3d+C4IvuqOLU3
 eDm5WQczUf6sca/a0H5Ay3PDOA5umJL4bQfC3fO2HS2upfhQ/ebc515XuNjQm4xM4V28mCm94r+
 HUvP/cYJ8Kl+oBg0G7G3sHVqC0L7pjJYcTAG6HnxI8aotPkhyTdxK5WHa1Re8xH5UsQJy87GtsA
 9nPiqm7flv7XwOFSZJRluq/xPoX6h9GU44C4TpqWpBmWmapGJ3tTttPntR7V3R57TKryyYwPgiF
 8pFVfkg=
X-Received: by 2002:a05:6a20:d527:b0:393:74ed:7dd5 with SMTP id
 adf61e73a8af0-39545f49d08mr3731480637.43.1771723672402; Sat, 21 Feb 2026
 17:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <20260203-cleanup-v1-5-4221c13e7558@nxp.com>
In-Reply-To: <20260203-cleanup-v1-5-4221c13e7558@nxp.com>
From: David Zang <davidzangcs@gmail.com>
Date: Sat, 21 Feb 2026 19:27:40 -0600
X-Gm-Features: AaiRm52fDpyyR2JBtvDrL4e_nxNMA9cikGT6QKNd5bMGIHNmFzL5II4XhCoiKzM
Message-ID: <CACwB3C9qsVasyMAq2Fw5Ly8RSuFL-k5xTAAEMP0+EdwWbC7=Zw@mail.gmail.com>
Subject: Re: [PATCH 05/14] test: log_filter: Include vsprintf.h
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Christoph Stoidner <c.stoidner@phytec.de>, kernel@puri.sm,
 Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot@dh-electronics.com, upstream@lists.phytec.de, u-boot-qcom@groups.io, 
 uboot-stm32@st-md-mailman.stormreply.com, adsp-linux@analog.com, 
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Sam Shih <sam.shih@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome@forissier.org>, Simon Glass <sjg@chromium.org>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Stefano Babic <sbabic@nabladev.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Stefan Bosch <stefan_b@posteo.net>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Michal Simek <michal.simek@amd.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Aaron Williams <awilliams@marvell.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Yao Zi <me@ziyao.cc>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Oliver Graute <oliver.graute@kococonnector.com>, 
 Randolph <randolph@andestech.com>, David Feng <fenghua@phytium.com.cn>, 
 Linus Walleij <linusw@kernel.org>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Gilles Talis <gilles.talis@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heiko Thiery <heiko.thiery@gmail.com>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Patrick Wildt <patrick@blueri.se>, Martyn Welch <martyn.welch@collabora.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, Teresa Remmet <t.remmet@phytec.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Angus Ainslie <angus@akkea.ca>, 
 Stephan Gerhold <stephan@gerhold.net>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Kamil Lulko <kamil.lulko@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Dillon Min <dillon.minfei@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Anastasiia Lukianenko <vicooodin@gmail.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Tingting Meng <tingting.meng@altera.com>, Mahesh Rao <mahesh.rao@altera.com>,
 Ye Li <ye.li@nxp.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, 
 Jeremy Compostella <jeremy.compostella@intel.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Debbie Horsfall <debbie.horsfall@arm.com>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Anshul Dalal <anshuld@ti.com>, Francesco Valla <francesco@valla.it>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Benjamin Hahn <B.Hahn@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Keerthy <j-keerthy@ti.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Adriano Cordova <adrianox@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Joseph Chen <chenjh@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Christoph Fritz <chf.fritz@googlemail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>,
 E Shattow <e@freeshell.de>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.ne@posteo.net>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, 
 Brian Ruley <brian.ruley@gehealthcare.com>, Swamil Jain <s-jain1@ti.com>, 
 Zixun LI <admin@hifiphile.com>, Antonio Borneo <antonio.borneo@foss.st.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>, 
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Alexander Graf <agraf@csgraf.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Leonard Anderweit <l.anderweit@phytec.de>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>, Peng Fan <peng.fan@nxp.com>
X-Mailman-Approved-At: Sun, 22 Feb 2026 07:59:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 3, 2026 at 4:44=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> snprintf is used, need to include vsprintf.h. Otherwise there will
> be build error after asm/global_data.h is removed.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  test/log/log_filter.c | 1 +
>  1 file changed, 1 insertion(+)
>
> Reviewed-by: David Zang <davidzangcs@gmail.com>

David
