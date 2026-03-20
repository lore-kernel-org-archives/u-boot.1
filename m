Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C461093199
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 09:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B674D83FEC;
	Fri, 20 Mar 2026 10:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EPOC59Ha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1409583F8A; Fri, 20 Mar 2026 09:46:08 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B0DD83CF3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 09:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b48ac2727so1310580f8f.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 01:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773996365; cv=none;
 d=google.com; s=arc-20240605;
 b=jVhoDioK8VEbzk3MTZhu/jJCfSbtt3ClN6mtc4+Rdys9DCicWJLyBoUQceLA7dSCeX
 ZUTXoKOifgY7rei/0Rtalgcj9eOcNS9BEU1iBagKUmXKQeMYVUZMucrt4G4D6aUp8nE1
 qKOyBapAWTgCej2BoTFxKV1PvE5iun2aEUqoQfQc4/s8QhBBBs6P5YUxUM2sIyjApc4V
 1Pb2c0zQNPi+ZjEVSwCpibTyhkF5ZrOHsiYuJ+l/N1hs8sPeKbFiyeyx83OcnStxXSlv
 GOxDGU3/n+j+BrssJDbA1Q8UXm2mzl5LiIqGb8O887aXsyRFPTdfmMF7jssBfsNmAKrC
 Cw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NzjrLGvYXwAoegWxWX8Fr18o2HG2OSxigt94VETtEG0=;
 fh=qm1UqnaKZLuedpzbn35UV1wUbiy24Hpk3LcZXA4bkgs=;
 b=H9LYcRLlMtFztCCbfcdPx4IMhzAmQmZcLlVycUAIHgNl2y5YUPGbkdWEcXuvaymcRT
 Eys6YUsKHlrWcbNA/9TnmeJTVGvcBPgeohM6H+E+qi71v6rAl6AnGLfkv0Srf/fCOJGM
 55SEIBHLjQG0lijvo2qSCgZpp1pwipC2d0lLGYUd4xq1E9WwKjunMnAmsiE4LjcRllI7
 5vx3FZ8Auamvek+39uv4QArN9egYaOZVmpZXQv0CcI2qH2v7UvYbDFzaguJX8ZGUrUDw
 SJ9/UcbiR2BrK3TXACF4gAQu4apHQ+U777n8znV9IBq7FN5RPB0uZ/ykbnZO3VoMhJm7
 0h8w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773996365; x=1774601165; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzjrLGvYXwAoegWxWX8Fr18o2HG2OSxigt94VETtEG0=;
 b=EPOC59HakI7rIbrnb1lWepLcC2Jncwm13dOKeVB6POGvLyCZimcg5fu3SdxyNMcwv/
 OnpLWXEHieL9UV79wHfQT/wvH6RphE+ZiqFCjRcZo130divZdficAHoI9YwwMJo5Wuka
 BrQ2WwJcLJUimv3CldXje5P4BlUN1icNGCOvFlpAHbZbET2T2ozQLmRv3e7lyL+sCogO
 ++Gnvo9aNuLkegIAh0JXknaKnJpynTsUhG5wa5R/z6d35TJi0LMkeYMvUUA84o2HAYuP
 hb7q+a4EFnshhdv3jAgNwZ6kTaEGhSCNmFgeQEX4DiV0xeLikMhdzoNggRgt4AHHgKbu
 UQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773996365; x=1774601165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NzjrLGvYXwAoegWxWX8Fr18o2HG2OSxigt94VETtEG0=;
 b=mHBvryc6p8EcyFbi+0mZOX6V37/3uYBF9WxY8ot1tOvsUqXUcrQNuSLoDZ894ZBP5C
 wvgu4Glx4iASsDm6TO0ySZhTan26OYScrOJW3sGIxs6Ec+oDgS73zfjcVDYAd8v9uQxz
 Nf84/VFVuMKiIRkFTFVIZTV9nDKMKrLGh6JLkBwF9Ehb39GQGE6R1O1Na1u4rgP7XdZL
 w8/kou9XAqADQ1yPtKeWxKUmN8aDuqYCu9D0C+8Mw6amrJdexvQpmTwUonUBYWrKPr97
 Wgnl1IrtB8Sx3Fuuk+EPzC7K19RmUlR03VXbWMxTanURYnw7i/Pd3i6NF6GWGFuYIT8n
 A1Cw==
X-Gm-Message-State: AOJu0YyCtpVJiChYE8GLTMnR37CWAZMrbZuisSsG9l0AWRK12/pvdaz6
 nd+9WJezeENjG4qHR1kAn4CIDYDwovXV+DykITCcPVW7Q7A0c+HQPSSAk98i0eQPgP1QpgRgbhV
 iQbhWzoXQrF6tfjpNfGneZzvJ0uSQIjQ=
X-Gm-Gg: ATEYQzwzqZS4nj3vsQEp7ad87bY+m0B/tpqzivKG6BFCXAP3EpbZvnSCYGLTdk/cPpM
 cyoByvLot0enyjXtQ6T1NuB/ZakdrXhTC/WMenFT+NefZWwsXfOidvNgK5JeptTvVe9P1vhEFhn
 +fdPuq+Eg1UCoyudQcuKOOwP3VgW0mG/tNb7dM0Nu56aHoN1gOKgwabTQdzTM8QmIwB7Sloqftw
 WvY6Rd49qQjNVvultueds9ENmhbE68CP41XST9GX6v5ymQ29j2t5mauFY5Mt8YFuQSIyHVgf6jq
 pfvvYwNe
X-Received: by 2002:a05:6000:1a8f:b0:43b:43ae:8c25 with SMTP id
 ffacd0b85a97d-43b64291eabmr3603207f8f.52.1773996365312; Fri, 20 Mar 2026
 01:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Mar 2026 10:45:52 +0200
X-Gm-Features: AaiRm51Mwbxlj-hl5Dpc9uqfgwctj4ALzZG2MKiLKqmxjj9fG2skgTxP_eci6f0
Message-ID: <CAPVz0n2zRSTj7iNDCA_ExnRtcf5s0fDkzu5KdNjDjyr8mDZbkg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to
 U-Boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 u-boot-qcom@groups.io, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com,
 uboot-snps-arc@synopsys.com, 
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephen Boyd <swboyd@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Korsgaard <peter@korsgaard.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Thierry Reding <treding@nvidia.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Philip Molloy <philip.molloy@analog.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ryan Wanner <Ryan.Wanner@microchip.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Jens Reidel <adrian@mainlining.org>, David Wronek <david.wronek@mainlining.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>, 
 Nishanth Menon <nm@ti.com>, Alice Guo <alice.guo@nxp.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Jonathan Currier <dullfire@yahoo.com>, Sam Shih <sam.shih@mediatek.com>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Sam Day <me@samcday.com>, Rui Miguel Silva <rui.silva@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Shmuel Leib Melamud <smelamud@redhat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Andrew Davis <afd@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Heiko Schocher <hs@nabladev.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Paul Sajna <sajattack@postmarketos.org>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 20 Mar 2026 10:16:48 +0100
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

=D1=87=D1=82, 19 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 22:56 Case=
y Connolly <casey.connolly@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> This RFC provides a proof of concept for using the full Linux CCF in
> U-Boot and consequently porting full Linux clock drivers with extremely
> minimal changes.
>

Hello Casey,

Patchset is incomplete (32 patches only). Split it up into smaller chunks.
