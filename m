Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E03FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D8183693;
	Mon, 27 Apr 2026 21:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GvrH90+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3C1841DF; Mon, 27 Apr 2026 21:42:39 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4718184150
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479eb8bcacbso4076977b6e.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777318956; x=1777923756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tT2hp8+uLmbn2kwycSlwuPUUgNkBNqsvJj4q903zslk=;
 b=GvrH90+ltyjiIHN4Pl2A2va++LdNGsJkqnLcyAq+PI9zRZFFnDU4zRePhsme+Is02c
 g3GCxphgkcgUeXqx5Hvtt5o4EgdV4U4d6JGtW5unTV0e+Zv/BA/MaJCLmbtYvj+/+GAh
 2fedoKLlZvWVb2GqQZTQGiDaXsktMRWJQfcz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318956; x=1777923756;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tT2hp8+uLmbn2kwycSlwuPUUgNkBNqsvJj4q903zslk=;
 b=PfUgi4/iKZ79fPk9Y15/z/dMO79GcXt1J41OhXMqmYWeA9ejp+prygB27FCwz5fp6W
 uOrZEKwC8UFScZRGdxCoLN9Cd/TbaSrWQBqf+Du82REIVTp0kb5TFcpK+Kla+rYmxVjU
 oCybf+pBesiSfsLOi4xA7IwVUoJAoU2CRFT54m5G3pJXvBF9jlSaTOxaylCBYKymAlgL
 xJkkHBR/CRUbrS1K/Y/uNT9Fjk/qNanwOEHE3L1c3fHezlNySJRBSiDdckP+0JPNuUcK
 9gUB8MlQqHDowhZ2bsXTYM8TJf4YklXFjGrsc3c+r0mgi0xjy+kgehFGYlAKynZXnlvg
 VK4Q==
X-Gm-Message-State: AOJu0YyAxhktzFM2aw0heCRah2TvvnKR6tyNuOeWQKpWTBc/9NdCyb74
 attnuMYnnLp/2z6hZafDLoZcoEb/B3mQzhXs2wR0RrokGvhEBMAFPVL/w844Ngv8fVc=
X-Gm-Gg: AeBDieuDObStfsu5YZsx9GCtiPWYQtFRQvZ6hejljuPXyzgRZSr0GeBF3GkCUH7sWRN
 LVqz7ehwxIGMqKEy0vmTXL8HytwI0oaDAsA8P8ObZ8iyG5thFvs4Gn5b2vn++BGTXBjuBiOLsD7
 KD5NcAUsLSY6QhBo7MQWqKe7Njg0uNfUMYPcp839ozo8hwXWH6bdrDBPZjJzMKjK2INYpCfi1DT
 n0weo8jbR2ezE7rXBaz+K4wal/M1/CJgImeBmNcNplo7UUY3zxXOmikuPsnHg/JpmoErNZ21rQY
 hg72IpzZlTuIFe7UpY/rax7sXTocpl9BOv2grvPPOMwlmW0HL8Revmx2f26VIUR5MTL9KU46vNY
 72O5KM9dC3JXiqrtqFggyI2QC3CxVmHZuu8EdcDN+nS4680OWoWk0RfTozv2wSpYJUTtMAtMe2y
 yWJWTudCpKQb7RGuKF88SLQTtgBO0OCcGQtZD2vmdqadYjRRogqSxnuOrm17SqXuhnCCG0c5JLf
 4fUloYxeJnDcgak54nyXZq8z3Jur1VCX8me+qG2kFUN6vVyF7nJOAcOHb6y
X-Received: by 2002:a05:6820:987:b0:68c:373f:1835 with SMTP id
 006d021491bc7-6965b9ed9a7mr244412eaf.36.1777318955890; 
 Mon, 27 Apr 2026 12:42:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b94aa0esm187247eaf.6.2026.04.27.12.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:42:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Adam Ford <aford173@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Shantur Rathore <i@shantur.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
Subject: Re: [PATCH 0/6] net: migrate NO_NET out of the networking stack choice
Message-Id: <177731895134.3526444.5826356040065208578.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 13:42:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Mon, 27 Apr 2026 21:59:09 +0200
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

On Mon, 20 Apr 2026 13:36:06 +0200, Quentin Schulz wrote:

> This migrates the net options away from the main Kconfig to net/Kconfig,
> rename the current NET option to NET_LEGACY to really highlight what it
> is and hopefully encourage more people to use lwIP, add a new NET
> menuconfig (but keep NO_NET as an alias to NET=n for now) which then
> allows us to replace all the "if legacy_stack || lwip_stack" checks with
> "if net_support" which is easier to read and maintain.
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] move networking menu in net/Kconfig
      commit: 8080ab6c2843d3899a8ce941b5f6ae82b05b9e38
[2/6] rename NET to NET_LEGACY
      commit: b8cd4442257af4ec754838ea179568e0e7360b8f
[3/6] net: make NET a menuconfig (and downgrade NO_NET to a simple config)
      commit: bd275172a84bf32a3f392b852801dee08a94956a
[4/6] simplify NET_LEGACY || NET_LWIP condition with NET condition
      commit: 95d66d2eb02a4677c63d04c84ca21750a04c49f1
[5/6] doc: remove mention to non-existing TPL_NET
      commit: 0d98f68579b4d32b8593dae35695e8c7f8d7e120
[6/6] boot: remove NO_NET use
      commit: b06c5ef4ddf051b0da8276d2a00ee3df037cbf2f
-- 
Tom


