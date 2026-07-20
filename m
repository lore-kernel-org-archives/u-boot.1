Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F512C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFC2280D5B;
	Mon, 20 Jul 2026 18:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iba_gEh0w9sC; Mon, 20 Jul 2026 18:10:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A54080D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571002;
	bh=1yvAbqKO8pKreOvQaHz4ZB6zQ8UZxAal3RiiFNPTp30=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wH5fRpusGtci8Rz65iUCqFDHROsIv+UKzQJ4Gei4WsHbggSbwLyOx1WjIX98y+9S3
	 Typs1jrM/C/A2qz1JdOP1+AwbOp6h/eYNtJXqJE19FSllZu0aFOQURvDIzf8vVKOqx
	 0cuZ0eWkkVjTss4tPkrh3J4KoDDfRpsLV+Dt/X322MTLY+DbBgyqHU08rDNwQD8Uy/
	 ImCMhsSRRvLsNsoOsQA/jPF8SQe8egXIPIaa7mwQNhRleFT0jEetDaGjPHVU56o7KL
	 QzzNoDCLhTg5Ruxe/sgswLcpmtTRdh7JEgW7Fg9wDoAt0OlmyfHWmi8XSO0Ivb1Cas
	 CJdk+9JvjT7sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A54080D4B;
	Mon, 20 Jul 2026 18:10:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CDAB1D72
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E28640136
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kx_UK--70ws1 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 852FC40154
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 852FC40154
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 852FC40154
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DAD7847AF; Mon, 20 Jul 2026 18:41:03 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513B88484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:40:54 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so15170125e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565654; x=1785170454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1yvAbqKO8pKreOvQaHz4ZB6zQ8UZxAal3RiiFNPTp30=;
 b=rsEvjmhpT26D2y1wR2VRYRfeJlSxbV+1tOOj2oQWtl03XoK2d63imRtpJljB4etBE1
 GfSSuEo6ir7Kj0mSdkDh7oOKzJ1MJ33KHvtDp2+p0dD0AD4xnHSaVORYoNHcwXXGYiTB
 gXmPlpN9qMxYxsA/2mF7tdPVZsTgqnEf9IeDDbO2LAyiNS39X1NmKYyLbIx3hwRM9Qr2
 bw7fQMoe/EpHUikoNg/LxXK7ipHCuz5dEL9WPVYSNKUyE7siJA5UZDo2gQQat26QmGVd
 v8AdsxFZArF1BS4pBa3+woucCAuDtUuIbcvuevQGExvhS25bD9XhW4tGeM8rUDf4ejxT
 r4pg==
X-Gm-Message-State: AOJu0Yz5TbuUNUFlg4snQaHAa5FmYk0ZfW2qDzMLlZFl4ZkH7OXV3qsa
 JMoXmdcclY7tWltCVLUEUKjRZiXF0xzqd+ycAV5bS6Or8Mw4x05oApsSe+7fwrnxnMU=
X-Gm-Gg: AfdE7cmrPWFdgYioBX8bw0lN0hjF+sG07iO5+rvPmKUDl9jSRbuIeHYYky7KOxd/VrM
 VXnR15gBA9i2Z8C7MiLlPI1ehzxsdOjBGS86JxwrpHCc0uQrwENVJbvZmgYmsgqawl/evSfNYGa
 Sv5H0CiEX9MX8NPc+tfaNIBebccAohXyAZDOgaBfjnyI/IJoT7yWuxN0/KOuHgOgK02AorT2L+c
 +KUs3w7h6KdbOu4Uxy907H9DETpMhX4zBXGVdwUdY++vaz/Zr5cTZ5hmHxPeryUvk3W9MoKYZH9
 S/YRmIlPU8mcrw8QVXhdmAT33/RDHi0DDYBBwepeDCSmUxvZeUO+tmHIaQzZb0q+bl0J1U3Eqh3
 4WnFjX77kcOyO8Pru6VuXOd/WyTUAFu6hxO/LUbAh2SAB3RgL/qWoq2RwOBPvfXlh1OQjzIhC50
 tko21WlqRi/LyRApbP6lYMiKS47ElV/EquipN6zSxV
X-Received: by 2002:a05:600c:45d5:b0:495:4056:9473 with SMTP id
 5b1f17b1804b1-4954a40d0c3mr165499445e9.28.1784565653125; 
 Mon, 20 Jul 2026 09:40:53 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:40:52 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:31 +0100
Subject: [PATCH 04/36] clk: make clk_set_rate() return signed long
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-4-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=92552;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=cX6AgJDnIfmutwUhoDTQ2KC/RbvKddpi1dptFv/r3xQ=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+AAdPE5ZrbQzsGScU55iJyrMcSBGixk7hhJ
 /vNT7Tdh0OJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgAAKCRAFgzErGV9k
 tmg8D/9vNpA65KTFWpswPN/vFO/JWP85PeqCUQHZuIgDEdbegKlhEWiLnPj6nWwmu6tjiKx0b55
 41R2SLgihHl7SeBmZlaAODfCFASSaX5ritNLoPnUn6qKGMOIYLGkj6O95GjoRoBjFetiFOfTx2U
 XE4eFbf3efU6tR2nX/59arnVlQleyBuUJroQdS9XRAyWVZAjWUCvlxE/jOzwwRSo71CLOSQ03q9
 z9BlYi7qewdYN733JiA8hf1bNKJzJ5m+/+6GyYYArAyJrExsZgxNZHFf0JQf5zyQ1iNnX5giWj0
 d6ZZ9RkqiqbzARkji8fI0sCovWX73OOemJuii/mhny6JghFWRqD/TWSqO6ID5kCUCdXw3CfR8XZ
 FTh4y1el6fQKeUcPX7IOeoPsidcn1Jl30Dr7cjebui80RBkRzS5bIDkC8j4SRN7hsM+++hGA4h4
 haNFvcMSuUByC8O1+j1MUEVAtVKW0vzukfdAn/1Z8rgFkeBSu/s4vo6EPbm5wyTTLCDZHMFDz+c
 KdjFS9SPrVc8HkVtP28v+jJaoJdCcPfruRhSdXu7MSb7t+ZFc1X+7ZHCNc7XzDIysvGzVp/aQ0Q
 fHB3jtmhkhjFs+P1bKyG08qH9syZN/TqaaiBZ4DSA2iHzY9UIXgYW/nTj7BrvJRLJeUR15X8W7U
 TTaUzvX3Ufs2Rng==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565654; x=1785170454; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1yvAbqKO8pKreOvQaHz4ZB6zQ8UZxAal3RiiFNPTp30=;
 b=GPXhh/9CYR2S10P5csT8BW+IPOwpPRSYlXP4WeY++lg2yi+DLhG8D5LR6jFIZbBkxa
 r4RpK4oV1/Ie2xJjoI9jCA+dwV13ecgsW0pzYXTEKmnjhc2wLP2iFzN74XQnRploOQRu
 n/E3kP302w8mqDWBlUAm+I4ATPl3gskEcrvbPH7yVZ05IbpNQYxI4Pb3pr2DWv7Fv8Ya
 pDbH9ABx/EGJxloNxMrOcJJ5pN8TRinEy2Mxq4d6JihcQatlVPtvj7VoVrHXlnrkDIqs
 ybKfyh9xJ9EX98XIgPyuL0AsQ5ueQddrnAJM01E2E64f2W5lYRiMFcCaM5bcrSxB7X8n
 9Oxg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=GPXhh/9C
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="GPXhh/9C"; 
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

The docs for clk_set_rate() indicate that it can return an error and
this is desirable for clock drivers to do, the ulong return type however
implies that this can't happen.

Fix the return type and adapt all clock drivers. Consumers can now more
easily handle error conditions.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/adi/clk-shared.c             |  2 +-
 drivers/clk/airoha/clk-airoha.c          |  2 +-
 drivers/clk/aspeed/clk_ast2500.c         |  2 +-
 drivers/clk/aspeed/clk_ast2600.c         |  2 +-
 drivers/clk/at91/clk-generic.c           |  2 +-
 drivers/clk/at91/clk-master.c            |  2 +-
 drivers/clk/at91/clk-peripheral.c        |  2 +-
 drivers/clk/at91/clk-programmable.c      |  2 +-
 drivers/clk/at91/clk-sam9x60-pll.c       |  4 ++--
 drivers/clk/at91/clk-sam9x60-usb.c       |  2 +-
 drivers/clk/at91/compat.c                |  8 ++++----
 drivers/clk/clk-cdce9xx.c                |  2 +-
 drivers/clk/clk-hsdk-cgu.c               |  2 +-
 drivers/clk/clk-stub.c                   |  2 +-
 drivers/clk/clk-uclass.c                 |  2 +-
 drivers/clk/clk-xlnx-clock-wizard.c      |  2 +-
 drivers/clk/clk_k210.c                   |  6 +++---
 drivers/clk/clk_pic32.c                  |  2 +-
 drivers/clk/clk_sandbox.c                |  2 +-
 drivers/clk/clk_sandbox_test.c           |  2 +-
 drivers/clk/clk_scmi.c                   |  4 ++--
 drivers/clk/clk_versaclock.c             |  8 ++++----
 drivers/clk/clk_versal.c                 |  2 +-
 drivers/clk/clk_vexpress_osc.c           |  2 +-
 drivers/clk/clk_zynq.c                   |  6 +++---
 drivers/clk/clk_zynqmp.c                 |  4 ++--
 drivers/clk/ics8n3qv01.c                 |  2 +-
 drivers/clk/imx/clk-composite-8m.c       |  2 +-
 drivers/clk/imx/clk-fracn-gppll.c        |  2 +-
 drivers/clk/imx/clk-gate-93.c            |  2 +-
 drivers/clk/imx/clk-gate2.c              |  2 +-
 drivers/clk/imx/clk-imx8.c               |  2 +-
 drivers/clk/imx/clk-imx8.h               |  2 +-
 drivers/clk/imx/clk-imx8qm.c             |  2 +-
 drivers/clk/imx/clk-imx8qxp.c            |  2 +-
 drivers/clk/imx/clk-imxrt1170.c          |  2 +-
 drivers/clk/imx/clk-pfd.c                |  2 +-
 drivers/clk/imx/clk-pll14xx.c            |  4 ++--
 drivers/clk/imx/clk-pllv3.c              |  8 ++++----
 drivers/clk/mediatek/clk-mtk.c           |  2 +-
 drivers/clk/meson/a1.c                   |  6 +++---
 drivers/clk/meson/g12a.c                 |  8 ++++----
 drivers/clk/meson/gxbb.c                 |  6 +++---
 drivers/clk/microchip/mpfs_clk_cfg.c     |  2 +-
 drivers/clk/mvebu/armada-37xx-periph.c   |  2 +-
 drivers/clk/nuvoton/clk_npcm.c           |  2 +-
 drivers/clk/owl/clk_owl.c                |  4 ++--
 drivers/clk/qcom/clock-apq8016.c         |  2 +-
 drivers/clk/qcom/clock-apq8096.c         |  2 +-
 drivers/clk/qcom/clock-ipq4019.c         |  2 +-
 drivers/clk/qcom/clock-ipq5424.c         |  2 +-
 drivers/clk/qcom/clock-ipq9574.c         |  2 +-
 drivers/clk/qcom/clock-milos.c           |  2 +-
 drivers/clk/qcom/clock-qcm2290.c         |  2 +-
 drivers/clk/qcom/clock-qcom.c            |  2 +-
 drivers/clk/qcom/clock-qcom.h            |  2 +-
 drivers/clk/qcom/clock-qcs404.c          |  2 +-
 drivers/clk/qcom/clock-qcs615.c          |  2 +-
 drivers/clk/qcom/clock-qcs8300.c         |  2 +-
 drivers/clk/qcom/clock-sa8775p.c         |  2 +-
 drivers/clk/qcom/clock-sc7180.c          |  2 +-
 drivers/clk/qcom/clock-sc7280.c          |  2 +-
 drivers/clk/qcom/clock-sdm845.c          |  4 ++--
 drivers/clk/qcom/clock-sm6115.c          |  2 +-
 drivers/clk/qcom/clock-sm6125.c          |  2 +-
 drivers/clk/qcom/clock-sm6350.c          |  2 +-
 drivers/clk/qcom/clock-sm7150.c          |  2 +-
 drivers/clk/qcom/clock-sm8150.c          |  2 +-
 drivers/clk/qcom/clock-sm8250.c          |  2 +-
 drivers/clk/qcom/clock-sm8550.c          |  2 +-
 drivers/clk/qcom/clock-sm8650.c          |  2 +-
 drivers/clk/qcom/clock-x1e80100.c        |  2 +-
 drivers/clk/renesas/clk-rcar-gen2.c      |  2 +-
 drivers/clk/renesas/clk-rcar-gen3.c      |  2 +-
 drivers/clk/renesas/compound-clock.c     |  2 +-
 drivers/clk/renesas/r8a78000-cpg.c       |  2 +-
 drivers/clk/renesas/r9a06g032-clocks.c   |  4 ++--
 drivers/clk/renesas/rzg2l-cpg.c          |  6 +++---
 drivers/clk/rockchip/clk_px30.c          |  8 ++++----
 drivers/clk/rockchip/clk_rk3036.c        |  2 +-
 drivers/clk/rockchip/clk_rk3066.c        |  2 +-
 drivers/clk/rockchip/clk_rk3128.c        |  2 +-
 drivers/clk/rockchip/clk_rk3188.c        |  2 +-
 drivers/clk/rockchip/clk_rk322x.c        |  2 +-
 drivers/clk/rockchip/clk_rk3288.c        |  2 +-
 drivers/clk/rockchip/clk_rk3308.c        |  2 +-
 drivers/clk/rockchip/clk_rk3328.c        |  2 +-
 drivers/clk/rockchip/clk_rk3368.c        |  2 +-
 drivers/clk/rockchip/clk_rk3399.c        |  4 ++--
 drivers/clk/rockchip/clk_rk3528.c        |  8 ++++----
 drivers/clk/rockchip/clk_rk3568.c        | 10 +++++-----
 drivers/clk/rockchip/clk_rk3576.c        |  6 +++---
 drivers/clk/rockchip/clk_rk3588.c        |  8 ++++----
 drivers/clk/rockchip/clk_rv1108.c        |  2 +-
 drivers/clk/rockchip/clk_rv1126.c        |  8 ++++----
 drivers/clk/sifive/sifive-prci.c         |  2 +-
 drivers/clk/sophgo/clk-cv1800b.c         |  2 +-
 drivers/clk/sophgo/clk-ip.c              | 12 ++++++------
 drivers/clk/sophgo/clk-pll.c             |  4 ++--
 drivers/clk/starfive/clk-jh7110-pll.c    |  2 +-
 drivers/clk/stm32/clk-stm32-core.c       |  2 +-
 drivers/clk/stm32/clk-stm32f.c           |  2 +-
 drivers/clk/stm32/clk-stm32mp1.c         |  2 +-
 drivers/clk/tegra/tegra-car-clk.c        |  2 +-
 drivers/clk/tegra/tegra186-clk.c         |  2 +-
 drivers/clk/thead/clk-th1520-ap.c        |  2 +-
 drivers/clk/ti/clk-am3-dpll.c            |  2 +-
 drivers/clk/ti/clk-divider.c             |  2 +-
 drivers/clk/ti/clk-k3-pll.c              |  2 +-
 drivers/clk/ti/clk-k3.c                  |  2 +-
 drivers/clk/ti/clk-mux.c                 |  2 +-
 drivers/clk/ti/clk-sci.c                 |  2 +-
 drivers/clk/uccf/clk-composite.c         |  2 +-
 drivers/clk/uccf/clk-divider.c           |  2 +-
 drivers/clk/uccf/clk.c                   |  2 +-
 drivers/clk/uniphier/clk-uniphier-core.c |  4 ++--
 include/clk-uclass.h                     |  2 +-
 include/clk.h                            |  2 +-
 118 files changed, 173 insertions(+), 173 deletions(-)

diff --git a/drivers/clk/adi/clk-shared.c b/drivers/clk/adi/clk-shared.c
index 5d0b7eb34655..7376b9b5668d 100644
--- a/drivers/clk/adi/clk-shared.c
+++ b/drivers/clk/adi/clk-shared.c
@@ -20,9 +20,9 @@ static ulong adi_get_rate(struct clk *clk)
 
 	return clk_get_rate(c);
 }
 
-static ulong adi_set_rate(struct clk *clk, ulong rate)
+static long adi_set_rate(struct clk *clk, ulong rate)
 {
 	//Not yet implemented
 	return 0;
 }
diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 200324a4fffd..4e0ad1845021 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -399,9 +399,9 @@ static int airoha_clk_search_rate(const struct airoha_clk_desc *desc, int div,
 err:
 	return -EINVAL;
 }
 
-static ulong airoha_clk_set_rate(struct clk *clk, ulong rate)
+static long airoha_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct airoha_clk_priv *priv = dev_get_priv(clk->dev);
 	struct airoha_clk_soc_data *data = priv->data;
 	const struct airoha_clk_desc *desc;
diff --git a/drivers/clk/aspeed/clk_ast2500.c b/drivers/clk/aspeed/clk_ast2500.c
index dbd588e17bb3..820e20e1219b 100644
--- a/drivers/clk/aspeed/clk_ast2500.c
+++ b/drivers/clk/aspeed/clk_ast2500.c
@@ -467,9 +467,9 @@ static ulong ast2500_enable_sdclk(struct ast2500_scu *scu)
 
 	return 0;
 }
 
-static ulong ast2500_clk_set_rate(struct clk *clk, ulong rate)
+static long ast2500_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct ast2500_clk_priv *priv = dev_get_priv(clk->dev);
 
 	ulong new_rate;
diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
index e5a521a8b59d..6c29c5d65486 100644
--- a/drivers/clk/aspeed/clk_ast2600.c
+++ b/drivers/clk/aspeed/clk_ast2600.c
@@ -572,9 +572,9 @@ static uint32_t ast2600_configure_ddr(struct ast2600_scu *scu, ulong rate)
 
 	return ast2600_get_pll_rate(scu, ASPEED_CLK_MPLL);
 }
 
-static ulong ast2600_clk_set_rate(struct clk *clk, ulong rate)
+static long ast2600_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct ast2600_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong new_rate;
 
diff --git a/drivers/clk/at91/clk-generic.c b/drivers/clk/at91/clk-generic.c
index 0424fb1b6f4e..00b27612096f 100644
--- a/drivers/clk/at91/clk-generic.c
+++ b/drivers/clk/at91/clk-generic.c
@@ -83,9 +83,9 @@ static int clk_gck_set_parent(struct clk *clk, struct clk *parent)
 
 	return 0;
 }
 
-static ulong clk_gck_set_rate(struct clk *clk, ulong rate)
+static long clk_gck_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_gck *gck = to_clk_gck(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 div;
diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 53652efc5740..feb7aea13bd8 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -267,9 +267,9 @@ static int clk_sama7g5_master_disable(struct clk *clk)
 
 	return 0;
 }
 
-static ulong clk_sama7g5_master_set_rate(struct clk *clk, ulong rate)
+static long clk_sama7g5_master_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_master *master = to_clk_master(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	ulong div, rrate;
diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 8f0c7524e4cc..8c74b7015789 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -167,9 +167,9 @@ static ulong clk_sam9x5_peripheral_get_rate(struct clk *clk)
 
 	return parent_rate >> shift;
 }
 
-static ulong clk_sam9x5_peripheral_set_rate(struct clk *clk, ulong rate)
+static long clk_sam9x5_peripheral_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	int shift;
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 9cf8e38af08c..ce4f63902c7d 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -83,9 +83,9 @@ static int clk_programmable_set_parent(struct clk *clk, struct clk *parent)
 
 	return 0;
 }
 
-static ulong clk_programmable_set_rate(struct clk *clk, ulong rate)
+static long clk_programmable_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_programmable *prog = to_clk_programmable(clk);
 	const struct clk_programmable_layout *layout = prog->layout;
 	ulong parent_rate = clk_get_parent_rate(clk);
diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index b896be5fe238..cf56e2c86032 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -89,9 +89,9 @@ static long sam9x60_frac_pll_compute_mul_frac(const struct clk_range *core_clk,
 
 	return tmprate;
 }
 
-static ulong sam9x60_frac_pll_set_rate(struct clk *clk, ulong rate)
+static long sam9x60_frac_pll_set_rate(struct clk *clk, ulong rate)
 {
 	struct sam9x60_pll *pll = to_sam9x60_pll(clk);
 	void __iomem *base = pll->base;
 	ulong parent_rate = clk_get_parent_rate(clk);
@@ -299,9 +299,9 @@ static int sam9x60_div_pll_disable(struct clk *clk)
 
 	return 0;
 }
 
-static ulong sam9x60_div_pll_set_rate(struct clk *clk, ulong rate)
+static long sam9x60_div_pll_set_rate(struct clk *clk, ulong rate)
 {
 	struct sam9x60_pll *pll = to_sam9x60_pll(clk);
 	void __iomem *base = pll->base;
 	const struct clk_pll_characteristics *characteristics =
diff --git a/drivers/clk/at91/clk-sam9x60-usb.c b/drivers/clk/at91/clk-sam9x60-usb.c
index 92bfd45f5353..308548519c11 100644
--- a/drivers/clk/at91/clk-sam9x60-usb.c
+++ b/drivers/clk/at91/clk-sam9x60-usb.c
@@ -67,9 +67,9 @@ static ulong sam9x60_usb_clk_get_rate(struct clk *clk)
 		(ffs(usb->layout->usbdiv_mask) - 1);
 	return parent_rate / (usbdiv + 1);
 }
 
-static ulong sam9x60_usb_clk_set_rate(struct clk *clk, ulong rate)
+static long sam9x60_usb_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct sam9x60_usb *usb = to_sam9x60_usb(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 usbdiv, val;
diff --git a/drivers/clk/at91/compat.c b/drivers/clk/at91/compat.c
index c3be9f93fa97..91c6f20f7f49 100644
--- a/drivers/clk/at91/compat.c
+++ b/drivers/clk/at91/compat.c
@@ -299,9 +299,9 @@ static ulong at91_plladiv_clk_get_rate(struct clk *clk)
 
 	return clk_rate;
 }
 
-static ulong at91_plladiv_clk_set_rate(struct clk *clk, ulong rate)
+static long at91_plladiv_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct pmc_plat *plat = dev_get_plat(clk->dev);
 	struct at91_pmc *pmc = plat->reg_base;
 	struct clk source;
@@ -391,9 +391,9 @@ static ulong system_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(&clk_dev);
 }
 
-static ulong system_clk_set_rate(struct clk *clk, ulong rate)
+static long system_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk clk_dev;
 	int ret;
 
@@ -774,9 +774,9 @@ static ulong generic_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(&parent) / (gckdiv + 1);
 }
 
-static ulong generic_clk_set_rate(struct clk *clk, ulong rate)
+static long generic_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct pmc_plat *plat = dev_get_plat(clk->dev);
 	struct at91_pmc *pmc = plat->reg_base;
 	struct generic_clk_priv *priv = dev_get_priv(clk->dev);
@@ -908,9 +908,9 @@ static ulong at91_usb_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(&source) / (usbdiv + 1);
 }
 
-static ulong at91_usb_clk_set_rate(struct clk *clk, ulong rate)
+static long at91_usb_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct pmc_plat *plat = dev_get_plat(clk->dev);
 	struct at91_pmc *pmc = plat->reg_base;
 	struct at91_usb_clk_priv *priv = dev_get_priv(clk->dev);
diff --git a/drivers/clk/clk-cdce9xx.c b/drivers/clk/clk-cdce9xx.c
index 9689283cec48..c4694aa86c28 100644
--- a/drivers/clk/clk-cdce9xx.c
+++ b/drivers/clk/clk-cdce9xx.c
@@ -170,9 +170,9 @@ static ulong cdce9xx_clk_get_rate(struct clk *clk)
 
 	return parent_rate / pdiv;
 }
 
-static ulong cdce9xx_clk_set_rate(struct clk *clk, ulong rate)
+static long cdce9xx_clk_set_rate(struct clk *clk, ulong rate)
 {
 	u32 parent_rate;
 	int pdiv;
 	u32 diff;
diff --git a/drivers/clk/clk-hsdk-cgu.c b/drivers/clk/clk-hsdk-cgu.c
index aa526e00e655..200df43e4fe9 100644
--- a/drivers/clk/clk-hsdk-cgu.c
+++ b/drivers/clk/clk-hsdk-cgu.c
@@ -707,9 +707,9 @@ static ulong hsdk_cgu_get_rate(struct clk *sclk)
 
 	return clk->map[sclk->id].get_rate(sclk);
 }
 
-static ulong hsdk_cgu_set_rate(struct clk *sclk, ulong rate)
+static long hsdk_cgu_set_rate(struct clk *sclk, ulong rate)
 {
 	struct hsdk_cgu_clk *clk = dev_get_priv(sclk->dev);
 
 	if (hsdk_prepare_clock_tree_branch(sclk))
diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 8482e1fec805..84ecb02975ae 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -25,9 +25,9 @@ U_BOOT_DRIVER(nop_parent) = {
 	.bind = dm_scan_fdt_dev,
 	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static ulong stub_clk_set_rate(struct clk *clk, ulong rate)
+static long stub_clk_set_rate(struct clk *clk, ulong rate)
 {
 	return (clk->rate = rate);
 }
 
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 8a7033386a74..db4f056e4816 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -585,9 +585,9 @@ static void clk_clean_rate_cache(struct clk *clk)
 		clk_clean_rate_cache(clkp);
 	}
 }
 
-ulong clk_set_rate(struct clk *clk, ulong rate)
+long clk_set_rate(struct clk *clk, ulong rate)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *clkp;
 
diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
index 18c5ae43789a..598aac5f3a2a 100644
--- a/drivers/clk/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/clk-xlnx-clock-wizard.c
@@ -86,9 +86,9 @@ static int clk_wzrd_enable(struct clk *clk)
 
 	return ret;
 }
 
-static unsigned long clk_wzrd_set_rate(struct clk *clk, ulong rate)
+static long clk_wzrd_set_rate(struct clk *clk, ulong rate)
 {
 	struct clkwzd *priv = dev_get_priv(clk->dev);
 	u64 div;
 	u32 cfg;
diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
index 329fc5bffd18..af9e5f172509 100644
--- a/drivers/clk/clk_k210.c
+++ b/drivers/clk/clk_k210.c
@@ -862,9 +862,9 @@ again:
 
 	return 0;
 }
 
-static ulong k210_pll_set_rate(struct k210_clk_priv *priv, int id, ulong rate,
+static long k210_pll_set_rate(struct k210_clk_priv *priv, int id, ulong rate,
 			       ulong rate_in)
 {
 	int err;
 	const struct k210_pll_params *pll = &k210_plls[id];
@@ -901,9 +901,9 @@ static ulong k210_pll_set_rate(struct k210_clk_priv *priv, int id, ulong rate,
 	serial_setbrg();
 	return k210_pll_get_rate(priv, id, rate);
 }
 #else
-static ulong k210_pll_set_rate(struct k210_clk_priv *priv, int id, ulong rate,
+static long k210_pll_set_rate(struct k210_clk_priv *priv, int id, ulong rate,
 			       ulong rate_in)
 {
 	return -ENOSYS;
 }
@@ -1108,9 +1108,9 @@ static int k210_clk_set_parent(struct clk *clk, struct clk *parent)
 	return do_k210_clk_set_parent(dev_get_priv(clk->dev), clk->id,
 				      parent->id);
 }
 
-static ulong k210_clk_set_rate(struct clk *clk, unsigned long rate)
+static long k210_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	int parent, ret, err;
 	ulong rate_in, val;
 	const struct k210_div_params *div;
diff --git a/drivers/clk/clk_pic32.c b/drivers/clk/clk_pic32.c
index 0b8e2f7ad8ec..b51921240a1c 100644
--- a/drivers/clk/clk_pic32.c
+++ b/drivers/clk/clk_pic32.c
@@ -368,9 +368,9 @@ static ulong pic32_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong pic32_set_rate(struct clk *clk, ulong rate)
+static long pic32_set_rate(struct clk *clk, ulong rate)
 {
 	struct pic32_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong pll_hz;
 
diff --git a/drivers/clk/clk_sandbox.c b/drivers/clk/clk_sandbox.c
index dceba88852ab..667526810fc2 100644
--- a/drivers/clk/clk_sandbox.c
+++ b/drivers/clk/clk_sandbox.c
@@ -40,9 +40,9 @@ static ulong sandbox_clk_round_rate(struct clk *clk, ulong rate)
 
 	return rate;
 }
 
-static ulong sandbox_clk_set_rate(struct clk *clk, ulong rate)
+static long sandbox_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct sandbox_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong old_rate;
 	ulong id = clk_get_id(clk);
diff --git a/drivers/clk/clk_sandbox_test.c b/drivers/clk/clk_sandbox_test.c
index 87350212775c..b30888889ce9 100644
--- a/drivers/clk/clk_sandbox_test.c
+++ b/drivers/clk/clk_sandbox_test.c
@@ -89,9 +89,9 @@ ulong sandbox_clk_test_round_rate(struct udevice *dev, int id, ulong rate)
 
 	return clk_round_rate(sbct->clkps[id], rate);
 }
 
-ulong sandbox_clk_test_set_rate(struct udevice *dev, int id, ulong rate)
+long sandbox_clk_test_set_rate(struct udevice *dev, int id, ulong rate)
 {
 	struct sandbox_clk_test *sbct = dev_get_priv(dev);
 
 	if (id < 0 || id >= SANDBOX_CLK_TEST_ID_COUNT)
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index fe361d699cc7..8f2d4e140510 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -283,9 +283,9 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
+static long __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk_get_id(clk),
 		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
@@ -308,9 +308,9 @@ static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 
 	return scmi_clk_get_rate(clk);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static long scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	u32 ctrl_flags;
 	int ret;
 
diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 35f7ded0137b..19f67cce1267 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -324,9 +324,9 @@ static unsigned long vc5_pfd_recalc_rate(struct clk *hw)
 	else
 		return parent_rate / VC5_REF_DIVIDER_REF_DIV(div);
 }
 
-static unsigned long vc5_pfd_set_rate(struct clk *hw, unsigned long rate)
+static long vc5_pfd_set_rate(struct clk *hw, unsigned long rate)
 {
 	struct vc5_driver_data *vc5 =
 		container_of(hw, struct vc5_driver_data, clk_pfd);
 	unsigned long idiv;
@@ -413,9 +413,9 @@ static unsigned long vc5_pll_round_rate(struct clk *hw, unsigned long rate)
 
 	return (parent_rate * div_int) + ((parent_rate * div_frc) >> 24);
 }
 
-static unsigned long vc5_pll_set_rate(struct clk *hw, unsigned long rate)
+static long vc5_pll_set_rate(struct clk *hw, unsigned long rate)
 {
 	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 	u8 fb[5];
@@ -498,9 +498,9 @@ static unsigned long vc5_fod_round_rate(struct clk *hw, unsigned long rate)
 
 	return div64_u64((u64)f_in << 24ULL, ((u64)div_int << 24ULL) + div_frc);
 }
 
-static unsigned long vc5_fod_set_rate(struct clk *hw, unsigned long rate)
+static long vc5_fod_set_rate(struct clk *hw, unsigned long rate)
 {
 	struct vc5_hw_data *hwdata = container_of(hw, struct vc5_hw_data, hw);
 	struct vc5_driver_data *vc5 = hwdata->vc5;
 
@@ -616,9 +616,9 @@ static int vc5_clk_out_set_parent(struct vc5_driver_data *vc, u8 num, u8 index)
 
 	return vc5_update_bits(vc->i2c, VC5_OUT_DIV_CONTROL(num), mask, src);
 }
 
-static unsigned long vc5_clk_out_set_rate(struct clk *hw, unsigned long rate)
+static long vc5_clk_out_set_rate(struct clk *hw, unsigned long rate)
 {
 	struct udevice *dev;
 	struct vc5_driver_data *vc;
 	struct clk *parent;
diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
index d882b1955b91..c2360d4f0d3a 100644
--- a/drivers/clk/clk_versal.c
+++ b/drivers/clk/clk_versal.c
@@ -745,9 +745,9 @@ static ulong versal_clk_get_rate(struct clk *clk)
 
 	return clk_rate;
 }
 
-static ulong versal_clk_set_rate(struct clk *clk, ulong rate)
+static long versal_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct versal_clk_priv *priv = dev_get_priv(clk->dev);
 	u32 id = clk_get_id(clk);
 	u32 clk_id;
diff --git a/drivers/clk/clk_vexpress_osc.c b/drivers/clk/clk_vexpress_osc.c
index a6f0ba595a23..5e129b894f67 100644
--- a/drivers/clk/clk_vexpress_osc.c
+++ b/drivers/clk/clk_vexpress_osc.c
@@ -37,9 +37,9 @@ static ulong vexpress_osc_clk_get_rate(struct clk *clk)
 	return data;
 }
 
 #ifndef CONFIG_XPL_BUILD
-static ulong vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
+static long vexpress_osc_clk_set_rate(struct clk *clk, ulong rate)
 {
 	int err;
 	u32 buffer[2];
 	struct udevice *vexpress_cfg = dev_get_parent(clk->dev);
diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
index 229972fb505d..2a1ff3bd3feb 100644
--- a/drivers/clk/clk_zynq.c
+++ b/drivers/clk/clk_zynq.c
@@ -311,9 +311,9 @@ static unsigned long zynq_clk_calc_peripheral_two_divs(ulong rate,
 
 	return best_rate;
 }
 
-static ulong zynq_clk_set_peripheral_rate(struct zynq_clk_priv *priv,
+static long zynq_clk_set_peripheral_rate(struct zynq_clk_priv *priv,
 					  enum zynq_clk id, ulong rate,
 					  bool two_divs)
 {
 	enum zynq_clk pll;
@@ -346,9 +346,9 @@ static ulong zynq_clk_set_peripheral_rate(struct zynq_clk_priv *priv,
 
 	return new_rate;
 }
 
-static ulong zynq_clk_set_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id,
+static long zynq_clk_set_gem_rate(struct zynq_clk_priv *priv, enum zynq_clk id,
 				   ulong rate)
 {
 	struct clk *parent;
 
@@ -401,9 +401,9 @@ static ulong zynq_clk_get_rate(struct clk *clk)
 		return -ENXIO;
 	}
 }
 
-static ulong zynq_clk_set_rate(struct clk *clk, ulong rate)
+static long zynq_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct zynq_clk_priv *priv = dev_get_priv(clk->dev);
 	enum zynq_clk id = clk->id;
 	bool two_divs = false;
diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 1f23b06553bf..873862113b73 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -638,9 +638,9 @@ static unsigned long zynqmp_clk_calc_peripheral_two_divs(ulong rate,
 
 	return best_rate;
 }
 
-static ulong zynqmp_clk_set_peripheral_rate(struct zynqmp_clk_priv *priv,
+static long zynqmp_clk_set_peripheral_rate(struct zynqmp_clk_priv *priv,
 					  enum zynqmp_clk id, ulong rate,
 					  bool two_divs)
 {
 	enum zynqmp_clk pll;
@@ -734,9 +734,9 @@ static ulong zynqmp_clk_get_rate(struct clk *clk)
 		return -ENXIO;
 	}
 }
 
-static ulong zynqmp_clk_set_rate(struct clk *clk, ulong rate)
+static long zynqmp_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct zynqmp_clk_priv *priv = dev_get_priv(clk->dev);
 	enum zynqmp_clk id = clk->id;
 	bool two_divs = true;
diff --git a/drivers/clk/ics8n3qv01.c b/drivers/clk/ics8n3qv01.c
index 04e6a349436a..f0d8b7bcc660 100644
--- a/drivers/clk/ics8n3qv01.c
+++ b/drivers/clk/ics8n3qv01.c
@@ -105,9 +105,9 @@ static int ics8n3qv01_calc_parameters(uint fout, uint *_mint, uint *_mfrac,
 
 	return 0;
 }
 
-static ulong ics8n3qv01_set_rate(struct clk *clk, ulong fout)
+static long ics8n3qv01_set_rate(struct clk *clk, ulong fout)
 {
 	struct ics8n3qv01_priv *priv = dev_get_priv(clk->dev);
 	uint n, mint, mfrac;
 	uint fout_calc = 0;
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 848c7b9d3fb1..cbeb2bcc9f59 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -83,9 +83,9 @@ static int imx8m_clk_composite_compute_dividers(unsigned long rate,
 /*
  * The clk are bound to a dev, because it is part of composite clk
  * use composite clk to get dev
  */
-static ulong imx8m_clk_composite_divider_set_rate(struct clk *clk,
+static long imx8m_clk_composite_divider_set_rate(struct clk *clk,
 						  unsigned long rate)
 {
 	struct clk_divider *divider = (struct clk_divider *)to_clk_divider(clk);
 	struct clk_composite *composite = (struct clk_composite *)clk->data;
diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index b885c4bc01d4..d0b0f1e0479b 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -224,9 +224,9 @@ static int clk_fracn_gppll_wait_lock(struct clk_fracn_gppll *pll)
 	return readl_poll_timeout(pll->base + PLL_STATUS, val,
 				  val & LOCK_STATUS, LOCK_TIMEOUT_US);
 }
 
-static ulong clk_fracn_gppll_set_rate(struct clk *clk, unsigned long drate)
+static long clk_fracn_gppll_set_rate(struct clk *clk, unsigned long drate)
 {
 	struct clk_fracn_gppll *pll = to_clk_fracn_gppll(clk);
 	const struct imx_fracn_gppll_rate_table *rate;
 	u32 tmp, pll_div, ana_mfn;
diff --git a/drivers/clk/imx/clk-gate-93.c b/drivers/clk/imx/clk-gate-93.c
index ff3ae5b57d36..b6f905365178 100644
--- a/drivers/clk/imx/clk-gate-93.c
+++ b/drivers/clk/imx/clk-gate-93.c
@@ -92,9 +92,9 @@ static int imx93_clk_gate_disable(struct clk *clk)
 
 	return 0;
 }
 
-static ulong imx93_clk_set_rate(struct clk *clk, ulong rate)
+static long imx93_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk *parent = clk_get_parent(clk);
 
 	if (parent)
diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index b5cd1b31036e..d570915d3b64 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -72,9 +72,9 @@ static int clk_gate2_disable(struct clk *clk)
 
 	return 0;
 }
 
-static ulong clk_gate2_set_rate(struct clk *clk, ulong rate)
+static long clk_gate2_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk *parent = clk_get_parent(clk);
 
 	if (parent)
diff --git a/drivers/clk/imx/clk-imx8.c b/drivers/clk/imx/clk-imx8.c
index 423b052cc5b6..101f66c16a4e 100644
--- a/drivers/clk/imx/clk-imx8.c
+++ b/drivers/clk/imx/clk-imx8.c
@@ -20,9 +20,9 @@ __weak ulong imx8_clk_get_rate(struct clk *clk)
 {
 	return 0;
 }
 
-__weak ulong imx8_clk_set_rate(struct clk *clk, unsigned long rate)
+__weak long imx8_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8.h b/drivers/clk/imx/clk-imx8.h
index 6e850ba26669..a5e73fcd95bd 100644
--- a/drivers/clk/imx/clk-imx8.h
+++ b/drivers/clk/imx/clk-imx8.h
@@ -14,6 +14,6 @@ extern struct imx8_clks imx8_clk_names[];
 extern int num_clks;
 #endif
 
 ulong imx8_clk_get_rate(struct clk *clk);
-ulong imx8_clk_set_rate(struct clk *clk, unsigned long rate);
+long imx8_clk_set_rate(struct clk *clk, unsigned long rate);
 int __imx8_clk_enable(struct clk *clk, bool enable);
diff --git a/drivers/clk/imx/clk-imx8qm.c b/drivers/clk/imx/clk-imx8qm.c
index 466d71786cfb..3239e7d9be6b 100644
--- a/drivers/clk/imx/clk-imx8qm.c
+++ b/drivers/clk/imx/clk-imx8qm.c
@@ -149,9 +149,9 @@ ulong imx8_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-ulong imx8_clk_set_rate(struct clk *clk, unsigned long rate)
+long imx8_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	sc_pm_clk_t pm_clk;
 	u32 new_rate = rate;
 	u16 resource;
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 79098623bc8c..bf29443be060 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -142,9 +142,9 @@ ulong imx8_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-ulong imx8_clk_set_rate(struct clk *clk, unsigned long rate)
+long imx8_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	sc_pm_clk_t pm_clk;
 	u32 new_rate = rate;
 	u16 resource;
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index ed31cb2d09ef..289d23dc0b81 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -27,9 +27,9 @@ static ulong imxrt1170_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(c);
 }
 
-static ulong imxrt1170_clk_set_rate(struct clk *clk, ulong rate)
+static long imxrt1170_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk *c;
 	int ret;
 
diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
index de26b1e3f83d..58702034ab51 100644
--- a/drivers/clk/imx/clk-pfd.c
+++ b/drivers/clk/imx/clk-pfd.c
@@ -52,9 +52,9 @@ static unsigned long clk_pfd_recalc_rate(struct clk *clk)
 
 	return tmp;
 }
 
-static unsigned long clk_pfd_set_rate(struct clk *clk, unsigned long rate)
+static long clk_pfd_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk_pfd *pfd = to_clk_pfd(clk);
 	unsigned long parent_rate = clk_get_parent_rate(clk);
 	u64 tmp = parent_rate;
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 0bb4d2c7e28c..dacd5851f292 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -210,9 +210,9 @@ static int clk_pll14xx_wait_lock(struct clk_pll14xx *pll)
 	return readl_poll_timeout(pll->base, val, val & LOCK_TIMEOUT_US,
 			LOCK_TIMEOUT_US);
 }
 
-static ulong clk_pll1416x_set_rate(struct clk *clk, unsigned long drate)
+static long clk_pll1416x_set_rate(struct clk *clk, unsigned long drate)
 {
 	struct clk_pll14xx *pll = to_clk_pll14xx(dev_get_clk_ptr(clk->dev));
 	const struct imx_pll14xx_rate_table *rate;
 	u32 tmp, div_val;
@@ -275,9 +275,9 @@ static ulong clk_pll1416x_set_rate(struct clk *clk, unsigned long drate)
 
 	return clk_pll1416x_recalc_rate(clk);
 }
 
-static ulong clk_pll1443x_set_rate(struct clk *clk, unsigned long drate)
+static long clk_pll1443x_set_rate(struct clk *clk, unsigned long drate)
 {
 	struct clk_pll14xx *pll = to_clk_pll14xx(dev_get_clk_ptr(clk->dev));
 	const struct imx_pll14xx_rate_table *rate;
 	u32 tmp, div_val;
diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index e907fd378c6d..2527ade99c88 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -54,9 +54,9 @@ static ulong clk_pllv3_genericv2_get_rate(struct clk *clk)
 
 	return (div == 0) ? parent_rate * 22 : parent_rate * 20;
 }
 
-static ulong clk_pllv3_genericv2_set_rate(struct clk *clk, ulong rate)
+static long clk_pllv3_genericv2_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(clk);
 	unsigned long parent_rate = clk_get_parent_rate(clk);
 
@@ -78,9 +78,9 @@ static ulong clk_pllv3_generic_get_rate(struct clk *clk)
 
 	return (div == 1) ? parent_rate * 22 : parent_rate * 20;
 }
 
-static ulong clk_pllv3_generic_set_rate(struct clk *clk, ulong rate)
+static long clk_pllv3_generic_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(clk);
 	unsigned long parent_rate = clk_get_parent_rate(clk);
 	u32 val, div;
@@ -162,9 +162,9 @@ static ulong clk_pllv3_sys_get_rate(struct clk *clk)
 
 	return parent_rate * div / 2;
 }
 
-static ulong clk_pllv3_sys_set_rate(struct clk *clk, ulong rate)
+static long clk_pllv3_sys_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(clk);
 	unsigned long parent_rate = clk_get_parent_rate(clk);
 	unsigned long min_rate;
@@ -217,9 +217,9 @@ static ulong clk_pllv3_av_get_rate(struct clk *clk)
 
 	return parent_rate * div + (unsigned long)temp64;
 }
 
-static ulong clk_pllv3_av_set_rate(struct clk *clk, ulong rate)
+static long clk_pllv3_av_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(clk);
 	unsigned long parent_rate = clk_get_parent_rate(clk);
 	unsigned long min_rate;
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d9289e3ced90..d4bbd2166129 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -531,9 +531,9 @@ static int mtk_pll_calc_values(struct mtk_clk_priv *priv, struct clk *clk,
 
 	return 0;
 }
 
-static ulong mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
+static long mtk_apmixedsys_set_rate(struct clk *clk, ulong rate)
 {
 	struct mtk_clk_priv *priv = dev_get_priv(clk->dev);
 	u32 pcw = 0;
 	u32 postdiv;
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index fdbc6b77ef80..fdac4292277c 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -475,9 +475,9 @@ static ulong meson_clk_get_rate(struct clk *clk)
  *  ---------|\
  *     ..... | |---DIV--
  *  ---------|/
  */
-static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
+static long meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
 {
 	unsigned int i, best_div_val;
 	unsigned long best_delta, best_parent;
 	const struct meson_clk_info *div;
@@ -525,9 +525,9 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong id, ulong rate)
 }
 
 static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong rate);
 
-static ulong meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
+static long meson_mux_set_rate(struct clk *clk, unsigned long id, ulong rate)
 {
 	int i;
 	ulong ret = -EINVAL;
 	struct meson_clk *priv = dev_get_priv(clk->dev);
@@ -569,9 +569,9 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned int id, ulong ra
 
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static long meson_clk_set_rate(struct clk *clk, ulong rate)
 {
 	return meson_clk_set_rate_by_id(clk, clk->id, rate);
 }
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index a2e5f38ca3ce..53703889c25a 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -95,9 +95,9 @@ struct meson_clk {
 	struct regmap *map;
 };
 
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id);
-static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
+static long meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate);
 static ulong meson_mux_set_parent(struct clk *clk, unsigned long id,
 				  unsigned long parent_id);
 static ulong meson_mux_get_rate(struct clk *clk, unsigned long id);
@@ -284,9 +284,9 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 
 	return rate;
 }
 
-static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
+static long meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	unsigned int new_div = -EINVAL;
@@ -862,9 +862,9 @@ static ulong meson_clk_get_rate(struct clk *clk)
 {
 	return meson_clk_get_rate_by_id(clk, clk->id);
 }
 
-static ulong meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
+static long meson_pcie_pll_set_rate(struct clk *clk, ulong rate)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 
 	regmap_write(priv->map, HHI_PCIE_PLL_CNTL0, 0x20090496);
@@ -957,9 +957,9 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static long meson_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 201c03fc8054..af0aaa75336f 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -74,9 +74,9 @@ struct meson_clk {
 	struct regmap *map;
 };
 
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id);
-static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
+static long meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate);
 static ulong meson_mux_set_parent(struct clk *clk, unsigned long id,
 				  unsigned long parent_id);
 static ulong meson_mux_get_rate(struct clk *clk, unsigned long id);
@@ -326,9 +326,9 @@ static ulong meson_div_get_rate(struct clk *clk, unsigned long id)
 
 	return rate;
 }
 
-static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
+static long meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate)
 {
 	struct meson_clk *priv = dev_get_priv(clk->dev);
 	unsigned int new_div = -EINVAL;
@@ -911,9 +911,9 @@ static ulong meson_clk_set_rate_by_id(struct clk *clk, unsigned long id,
 
 	return -EINVAL;
 }
 
-static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
+static long meson_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong current_rate = meson_clk_get_rate_by_id(clk, clk->id);
 	int ret;
 
diff --git a/drivers/clk/microchip/mpfs_clk_cfg.c b/drivers/clk/microchip/mpfs_clk_cfg.c
index 294ee0f5cc0d..d24017b5cc11 100644
--- a/drivers/clk/microchip/mpfs_clk_cfg.c
+++ b/drivers/clk/microchip/mpfs_clk_cfg.c
@@ -80,9 +80,9 @@ static ulong mpfs_cfg_clk_recalc_rate(struct clk *hw)
 
 	return rate;
 }
 
-static ulong mpfs_cfg_clk_set_rate(struct clk *hw, ulong rate)
+static long mpfs_cfg_clk_set_rate(struct clk *hw, ulong rate)
 {
 	struct mpfs_cfg_hw_clock *cfg_hw = to_mpfs_cfg_clk(hw);
 	struct mpfs_cfg_clock *cfg = &cfg_hw->cfg;
 	u32  val;
diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index b25b3df3b666..988067afa3e0 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -383,9 +383,9 @@ static ulong find_best_div(const struct clk_div_table *t0,
 
 	return best_rate;
 }
 
-static ulong armada_37xx_periph_clk_set_rate(struct clk *clk, ulong req_rate)
+static long armada_37xx_periph_clk_set_rate(struct clk *clk, ulong req_rate)
 {
 	struct a37xx_periphclk *priv = dev_get_priv(clk->dev);
 	const struct clk_periph *periph_clk = &priv->clks[clk->id];
 	ulong rate, old_rate, parent_rate;
diff --git a/drivers/clk/nuvoton/clk_npcm.c b/drivers/clk/nuvoton/clk_npcm.c
index ecb23431ecbd..b609e6236cb7 100644
--- a/drivers/clk/nuvoton/clk_npcm.c
+++ b/drivers/clk/nuvoton/clk_npcm.c
@@ -245,9 +245,9 @@ static ulong npcm_clk_get_rate(struct clk *clk)
 	else
 		return npcm_clk_get_fout(clk);
 }
 
-static ulong npcm_clk_set_rate(struct clk *clk, ulong rate)
+static long npcm_clk_set_rate(struct clk *clk, ulong rate)
 {
 	ulong parent_rate;
 	u32 div;
 	int ret;
diff --git a/drivers/clk/owl/clk_owl.c b/drivers/clk/owl/clk_owl.c
index 832177b8547f..5782ce89e12e 100644
--- a/drivers/clk/owl/clk_owl.c
+++ b/drivers/clk/owl/clk_owl.c
@@ -165,9 +165,9 @@ static ulong owl_get_sd_clk_rate(struct owl_clk_priv *priv, int sd_index)
 
 	return (parent_rate / div);
 }
 
-static ulong owl_set_sd_clk_rate(struct owl_clk_priv *priv, ulong rate,
+static long owl_set_sd_clk_rate(struct owl_clk_priv *priv, ulong rate,
 				 int sd_index)
 {
 	uint div, val;
 	ulong parent_rate = get_sd_parent_rate(priv, sd_index);
@@ -207,9 +207,9 @@ static ulong owl_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong owl_clk_set_rate(struct clk *clk, ulong rate)
+static long owl_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct owl_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong new_rate;
 
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index b7bd9c9a342a..46a962f29bfe 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -109,9 +109,9 @@ int apq8016_clk_init_uart(phys_addr_t base, unsigned long id)
 
 	return 0;
 }
 
-static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
+static long apq8016_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index 551f52d51977..063867303966 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -77,9 +77,9 @@ static int clk_init_uart(struct msm_clk_priv *priv)
 
 	return 0;
 }
 
-static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
+static long apq8096_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index f6760c6fb3df..8b9c19dfae64 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -20,9 +20,9 @@
 #define BLSP1_QUP1_I2C_APPS_CMD_RCGR	(0x200C)
 #define BLSP1_QUP2_I2C_APPS_CBCR	(0x3010)
 #define BLSP1_QUP2_I2C_APPS_CMD_RCGR	(0x3000)
 
-static ulong ipq4019_clk_set_rate(struct clk *clk, ulong rate)
+static long ipq4019_clk_set_rate(struct clk *clk, ulong rate)
 {
 	switch (clk->id) {
 	case GCC_BLSP1_UART1_APPS_CLK: /*UART1*/
 		/* This clock is already initialized by SBL1 */
diff --git a/drivers/clk/qcom/clock-ipq5424.c b/drivers/clk/qcom/clock-ipq5424.c
index 40823a30ead2..a26ceda972c9 100644
--- a/drivers/clk/qcom/clock-ipq5424.c
+++ b/drivers/clk/qcom/clock-ipq5424.c
@@ -19,9 +19,9 @@
 #include "clock-qcom.h"
 
 #define GCC_IM_SLEEP_CBCR	0x1834020u
 
-static ulong ipq5424_set_rate(struct clk *clk, ulong rate)
+static long ipq5424_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
index b0af40360598..1c5f5ec195d9 100644
--- a/drivers/clk/qcom/clock-ipq9574.c
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -25,9 +25,9 @@
 #define GCC_SDCC1_AHB_CBCR			0x33034
 #define GCC_SDCC1_APPS_CMD_RCGR			0x33004
 #define GCC_SDCC1_ICE_CORE_CBCR			0x33030
 
-static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
+static long ipq9574_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
index 0a598f361637..6e8c96a8484e 100644
--- a/drivers/clk/qcom/clock-milos.c
+++ b/drivers/clk/qcom/clock-milos.c
@@ -154,9 +154,9 @@ U_BOOT_DRIVER(gcc_milos) = {
 	.bind		= qcom_cc_bind,
 	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
-static ulong milos_rpmh_clk_set_rate(struct clk *clk, ulong rate)
+static long milos_rpmh_clk_set_rate(struct clk *clk, ulong rate)
 {
 	return (clk->rate = rate);
 }
 
diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index c38ff1a1e4a5..0f23c2d1dc94 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -103,9 +103,9 @@ static const struct gate_clk qcm2290_clks[] = {
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, 0x00000001),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, 0x00000001),
 };
 
-static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
+static long qcm2290_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6df8285cb301..c6dc4d8ebacc 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -241,9 +241,9 @@ static int msm_clk_probe(struct udevice *dev)
 
 	return 0;
 }
 
-static ulong msm_clk_set_rate(struct clk *clk, ulong rate)
+static long msm_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(clk->dev);
 
 	if (data->set_rate)
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d85366..324094f5c7c6 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -94,9 +94,9 @@ struct msm_clk_data {
 	unsigned long			num_rcgs;
 	const char * const		*dbg_rcg_names;
 
 	int (*enable)(struct clk *clk);
-	unsigned long (*set_rate)(struct clk *clk, unsigned long rate);
+	long (*set_rate)(struct clk *clk, unsigned long rate);
 };
 
 struct msm_clk_priv {
 	phys_addr_t		base;
diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 8b11de03a7d9..866666fe4549 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -92,9 +92,9 @@ static struct pll_vote_clk gpll1_vote_clk = {
 	.ena_vote = APCS_GPLL_ENA_VOTE,
 	.vote_bit = BIT(1),
 };
 
-static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
+static long qcs404_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	switch (clk->id) {
diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
index 7b3fe49de9c8..1832400401f1 100644
--- a/drivers/clk/qcom/clock-qcs615.c
+++ b/drivers/clk/qcom/clock-qcs615.c
@@ -64,9 +64,9 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
 	F(150000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
 	{ }
 };
 
-static ulong qcs615_set_rate(struct clk *clk, ulong rate)
+static long qcs615_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-qcs8300.c b/drivers/clk/qcom/clock-qcs8300.c
index cd8aecdf788a..fd6359773e19 100644
--- a/drivers/clk/qcom/clock-qcs8300.c
+++ b/drivers/clk/qcom/clock-qcs8300.c
@@ -16,9 +16,9 @@
 
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
 
-static ulong qcs8300_set_rate(struct clk *clk, ulong rate)
+static long qcs8300_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	if (clk->id < priv->data->num_clks)
diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index 7eec4aeae489..add73c47e397 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -73,9 +73,9 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
 	F(300000000, CFG_CLK_SRC_GPLL0, 2, 0, 0),
 	{ }
 };
 
-static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
+static long sa8775p_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sc7180.c b/drivers/clk/qcom/clock-sc7180.c
index 38b1fefcf03d..0674ece6ce7d 100644
--- a/drivers/clk/qcom/clock-sc7180.c
+++ b/drivers/clk/qcom/clock-sc7180.c
@@ -81,9 +81,9 @@ static const struct pll_vote_clk gpll7_vote_clk = {
 	.ena_vote = APCS_GPLLX_ENA_REG,
 	.vote_bit = BIT(7),
 };
 
-static ulong sc7180_set_rate(struct clk *clk, ulong rate)
+static long sc7180_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 91e3fcc27cb2..359820d38f91 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -84,9 +84,9 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
 	F(300000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 0, 0),
 	{ }
 };
 
-static ulong sc7280_set_rate(struct clk *clk, ulong rate)
+static long sc7280_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index c9a057cf6f9b..6f76dbe06f44 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -67,9 +67,9 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(201500000, CFG_CLK_SRC_GPLL4, 4, 0, 0),
 	{ }
 };
 
-static ulong sdm670_clk_set_rate(struct clk *clk, ulong rate)
+static long sdm670_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
@@ -83,9 +83,9 @@ static ulong sdm670_clk_set_rate(struct clk *clk, ulong rate)
 		return 0;
 	}
 }
 
-static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
+static long sdm845_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/clock-sm6115.c
index 17c2e5617580..542153b1f67e 100644
--- a/drivers/clk/qcom/clock-sm6115.c
+++ b/drivers/clk/qcom/clock-sm6115.c
@@ -93,9 +93,9 @@ static const struct gate_clk sm6115_clks[] = {
 	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, 0x00000001),
 	GATE_CLK(GCC_UFS_CLKREF_CLK, 0x8c000, 0x00000001),
 };
 
-static ulong sm6115_set_rate(struct clk *clk, ulong rate)
+static long sm6115_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm6125.c b/drivers/clk/qcom/clock-sm6125.c
index 1fd72d55e88e..c28f7284abe7 100644
--- a/drivers/clk/qcom/clock-sm6125.c
+++ b/drivers/clk/qcom/clock-sm6125.c
@@ -103,9 +103,9 @@ static const struct gate_clk sm6125_clks[] = {
 	GATE_CLK(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0)),
 	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK, 0x8c000, BIT(0)),
 };
 
-static ulong sm6125_set_rate(struct clk *clk, ulong rate)
+static long sm6125_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm6350.c b/drivers/clk/qcom/clock-sm6350.c
index ee6653848c7b..46a01981538f 100644
--- a/drivers/clk/qcom/clock-sm6350.c
+++ b/drivers/clk/qcom/clock-sm6350.c
@@ -63,9 +63,9 @@ static struct pll_vote_clk gpll7_vote_clk = {
 	.ena_vote = APCS_GPLLX_ENA_REG,
 	.vote_bit = BIT(7),
 };
 
-static ulong sm6350_set_rate(struct clk *clk, ulong rate)
+static long sm6350_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm7150.c b/drivers/clk/qcom/clock-sm7150.c
index 8fe2076e55eb..132526ffd01f 100644
--- a/drivers/clk/qcom/clock-sm7150.c
+++ b/drivers/clk/qcom/clock-sm7150.c
@@ -78,9 +78,9 @@ static const struct freq_tbl ftbl_gcc_usb3_prim_phy_aux_clk_src[] = {
 	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
 	{ }
 };
 
-static ulong sm7150_clk_set_rate(struct clk *clk, ulong rate)
+static long sm7150_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm8150.c b/drivers/clk/qcom/clock-sm8150.c
index 7dd0d56eb430..be88a280fcbf 100644
--- a/drivers/clk/qcom/clock-sm8150.c
+++ b/drivers/clk/qcom/clock-sm8150.c
@@ -92,9 +92,9 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(202000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
 	{ }
 };
 
-static ulong sm8150_clk_set_rate(struct clk *clk, ulong rate)
+static long sm8150_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
index 37268c4eaf5a..eb5d802786cf 100644
--- a/drivers/clk/qcom/clock-sm8250.c
+++ b/drivers/clk/qcom/clock-sm8250.c
@@ -53,9 +53,9 @@ static struct pll_vote_clk gpll9_vote_clk = {
 	.ena_vote = APCS_GPLLX_ENA_REG,
 	.vote_bit = BIT(9),
 };
 
-static ulong sm8250_set_rate(struct clk *clk, ulong rate)
+static long sm8250_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index 02d6e8d77345..538b5f0bf553 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -66,9 +66,9 @@ static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
 	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
 	{ }
 };
 
-static ulong sm8550_set_rate(struct clk *clk, ulong rate)
+static long sm8550_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index fbd1a186d1ba..3cdb7ff9877a 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
@@ -63,9 +63,9 @@ static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
 	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
 	{ }
 };
 
-static ulong sm8650_set_rate(struct clk *clk, ulong rate)
+static long sm8650_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
index ee57a02564a3..c0421d7f6023 100644
--- a/drivers/clk/qcom/clock-x1e80100.c
+++ b/drivers/clk/qcom/clock-x1e80100.c
@@ -63,9 +63,9 @@ static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
 	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
 	{ }
 };
 
-static ulong x1e80100_set_rate(struct clk *clk, ulong rate)
+static long x1e80100_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
 
diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index e659ad39da7d..435ea3f5f37e 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -240,9 +240,9 @@ static int gen2_clk_setup_mmcif_div(struct clk *clk, ulong rate)
 
 	return 0;
 }
 
-static ulong gen2_clk_set_rate(struct clk *clk, ulong rate)
+static long gen2_clk_set_rate(struct clk *clk, ulong rate)
 {
 	/* Force correct MMC-IF divider configuration if applicable */
 	gen2_clk_setup_mmcif_div(clk, rate);
 	return gen2_clk_get_rate(clk);
diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
index ae21f2a663f8..4fe22b27c284 100644
--- a/drivers/clk/renesas/clk-rcar-gen3.c
+++ b/drivers/clk/renesas/clk-rcar-gen3.c
@@ -432,9 +432,9 @@ static ulong gen3_clk_get_rate(struct clk *clk)
 {
 	return gen3_clk_get_rate64(clk);
 }
 
-static ulong gen3_clk_set_rate(struct clk *clk, ulong rate)
+static long gen3_clk_set_rate(struct clk *clk, ulong rate)
 {
 	/* Force correct SD-IF divider configuration if applicable */
 	gen3_clk_setup_sdif_div(clk, rate);
 	return gen3_clk_get_rate64(clk);
diff --git a/drivers/clk/renesas/compound-clock.c b/drivers/clk/renesas/compound-clock.c
index 2dc3e2e0deea..fb8bf19398ba 100644
--- a/drivers/clk/renesas/compound-clock.c
+++ b/drivers/clk/renesas/compound-clock.c
@@ -42,9 +42,9 @@ static ulong clk_compound_rate_get_rate(struct clk *clk)
 
 	return clk_get_rate(&cc->per);
 }
 
-static ulong clk_compound_rate_set_rate(struct clk *clk, ulong rate)
+static long clk_compound_rate_set_rate(struct clk *clk, ulong rate)
 {
 	return 0;	/* Set rate is not forwarded to SCP */
 }
 
diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index f47ca3e8413a..c730ef142eb9 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -54,9 +54,9 @@ static ulong gen5_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(scmi);
 }
 
-static ulong gen5_clk_set_rate(struct clk *clk, ulong rate)
+static long gen5_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk *scmi = gen5_clk_get_by_scmi_id(clk);
 
 	if (!scmi)
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 3ef98237ba15..91e1ace17ad9 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -842,9 +842,9 @@ static ulong r9a06g032_div_get_rate(struct clk *clk)
 		div = desc->div_max;
 	return DIV_ROUND_UP(parent_rate, div);
 }
 
-static ulong r9a06g032_div_set_rate(struct clk *clk, ulong rate)
+static long r9a06g032_div_set_rate(struct clk *clk, ulong rate)
 {
 	struct r9a06g032_priv *clocks = dev_get_priv(clk->dev);
 	const struct r9a06g032_clkdesc *desc = r9a06g032_clk_get(clk);
 	unsigned long parent_rate = r9a06g032_clk_get_parent_rate(clk);
@@ -1018,9 +1018,9 @@ static ulong r9a06g032_clk_get_rate(struct clk *clk)
 
 	return ret;
 }
 
-static ulong r9a06g032_clk_set_rate(struct clk *clk, ulong rate)
+static long r9a06g032_clk_set_rate(struct clk *clk, ulong rate)
 {
 	const struct r9a06g032_clkdesc *desc = r9a06g032_clk_get(clk);
 	ulong ret = 0;
 
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 03cb4f26d474..0401205bb96f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -279,9 +279,9 @@ static ulong rzg2l_cpg_clk_get_rate(struct clk *clk)
 {
 	return rzg2l_cpg_clk_get_rate_by_id(clk->dev, clk->id);
 }
 
-static ulong rzg2l_sdhi_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
+static long rzg2l_sdhi_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
 {
 	struct rzg2l_cpg_data *data =
 		(struct rzg2l_cpg_data *)dev_get_driver_data(dev);
 	const ulong offset = CPG_CONF_OFFSET(cc->conf);
@@ -345,9 +345,9 @@ static ulong rzg2l_sdhi_clk_set_rate(struct udevice *dev, const struct cpg_core_
 
 	return target_rate;
 }
 
-static ulong rzg2l_core_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
+static long rzg2l_core_clk_set_rate(struct udevice *dev, const struct cpg_core_clk *cc, ulong rate)
 {
 	if (cc->type == CLK_TYPE_SD_MUX)
 		return rzg2l_sdhi_clk_set_rate(dev, cc, rate);
 
@@ -391,9 +391,9 @@ static ulong rzg2l_cpg_clk_set_rate_by_id(struct udevice *dev, unsigned int id,
 	dev_err(dev, "Core clock ID %u not found\n", cpg_clk_id);
 	return -ENODEV;
 }
 
-static ulong rzg2l_cpg_clk_set_rate(struct clk *clk, ulong rate)
+static long rzg2l_cpg_clk_set_rate(struct clk *clk, ulong rate)
 {
 	return rzg2l_cpg_clk_set_rate_by_id(clk->dev, clk->id, rate);
 }
 
diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
index 9fb2c47060af..c820b90319b1 100644
--- a/drivers/clk/rockchip/clk_px30.c
+++ b/drivers/clk/rockchip/clk_px30.c
@@ -1125,9 +1125,9 @@ static ulong px30_clk_get_pll_rate(struct px30_clk_priv *priv,
 
 	return rkclk_pll_get_rate(&cru->pll[pll_id], &cru->mode, pll_id);
 }
 
-static ulong px30_clk_set_pll_rate(struct px30_clk_priv *priv,
+static long px30_clk_set_pll_rate(struct px30_clk_priv *priv,
 				   enum px30_pll_id pll_id, ulong hz)
 {
 	struct px30_cru *cru = priv->cru;
 
@@ -1270,9 +1270,9 @@ static ulong px30_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong px30_clk_set_rate(struct clk *clk, ulong rate)
+static long px30_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct px30_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
@@ -1560,9 +1560,9 @@ static ulong px30_pmuclk_get_gpll_rate(struct px30_pmuclk_priv *priv)
 
 	return rkclk_pll_get_rate(&pmucru->pll, &pmucru->pmu_mode, GPLL);
 }
 
-static ulong px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
+static long px30_pmuclk_set_gpll_rate(struct px30_pmuclk_priv *priv, ulong hz)
 {
 	struct px30_pmucru *pmucru = priv->pmucru;
 	ulong pclk_pmu_rate;
 	u32 div;
@@ -1709,9 +1709,9 @@ static ulong px30_pmuclk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
+static long px30_pmuclk_set_rate(struct clk *clk, ulong rate)
 {
 	struct px30_pmuclk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3036.c b/drivers/clk/rockchip/clk_rk3036.c
index e575143341d9..c0aa23825410 100644
--- a/drivers/clk/rockchip/clk_rk3036.c
+++ b/drivers/clk/rockchip/clk_rk3036.c
@@ -290,9 +290,9 @@ static ulong rk3036_clk_get_rate(struct clk *clk)
 		return -ENOENT;
 	}
 }
 
-static ulong rk3036_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3036_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3036_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong new_rate, gclk_rate;
 
diff --git a/drivers/clk/rockchip/clk_rk3066.c b/drivers/clk/rockchip/clk_rk3066.c
index 9b6f7a2b6b00..ce7c5956df31 100644
--- a/drivers/clk/rockchip/clk_rk3066.c
+++ b/drivers/clk/rockchip/clk_rk3066.c
@@ -539,9 +539,9 @@ static ulong rk3066_clk_get_rate(struct clk *clk)
 
 	return new_rate;
 }
 
-static ulong rk3066_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3066_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3066_clk_priv *priv = dev_get_priv(clk->dev);
 	struct rk3066_cru *cru = priv->cru;
 	ulong new_rate;
diff --git a/drivers/clk/rockchip/clk_rk3128.c b/drivers/clk/rockchip/clk_rk3128.c
index 4665f0d31152..0d132a1624c0 100644
--- a/drivers/clk/rockchip/clk_rk3128.c
+++ b/drivers/clk/rockchip/clk_rk3128.c
@@ -503,9 +503,9 @@ static ulong rk3128_clk_get_rate(struct clk *clk)
 		return -ENOENT;
 	}
 }
 
-static ulong rk3128_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3128_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3128_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong new_rate, gclk_rate;
 
diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index 1c75c2d9bf5b..d54a5dbb14b8 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -494,9 +494,9 @@ static ulong rk3188_clk_get_rate(struct clk *clk)
 
 	return new_rate;
 }
 
-static ulong rk3188_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3188_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3188_clk_priv *priv = dev_get_priv(clk->dev);
 	struct rk3188_cru *cru = priv->cru;
 	ulong new_rate;
diff --git a/drivers/clk/rockchip/clk_rk322x.c b/drivers/clk/rockchip/clk_rk322x.c
index f40fe68de45b..fb438c6fabee 100644
--- a/drivers/clk/rockchip/clk_rk322x.c
+++ b/drivers/clk/rockchip/clk_rk322x.c
@@ -372,9 +372,9 @@ static ulong rk322x_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk322x_clk_set_rate(struct clk *clk, ulong rate)
+static long rk322x_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk322x_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong new_rate, gclk_rate;
 
diff --git a/drivers/clk/rockchip/clk_rk3288.c b/drivers/clk/rockchip/clk_rk3288.c
index b672e728fb0a..10aed7c757a6 100644
--- a/drivers/clk/rockchip/clk_rk3288.c
+++ b/drivers/clk/rockchip/clk_rk3288.c
@@ -787,9 +787,9 @@ static ulong rk3288_clk_get_rate(struct clk *clk)
 
 	return new_rate;
 }
 
-static ulong rk3288_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3288_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3288_clk_priv *priv = dev_get_priv(clk->dev);
 	struct rockchip_cru *cru = priv->cru;
 	ulong new_rate, gclk_rate;
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index 9c7d5acc6d1c..a9604a75d244 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -1006,9 +1006,9 @@ static ulong rk3308_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk3308_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3308_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3308_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3328.c b/drivers/clk/rockchip/clk_rk3328.c
index cb5df70bfaa0..b251a48e17f5 100644
--- a/drivers/clk/rockchip/clk_rk3328.c
+++ b/drivers/clk/rockchip/clk_rk3328.c
@@ -713,9 +713,9 @@ static ulong rk3328_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk3328_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3328_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3328_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3368.c b/drivers/clk/rockchip/clk_rk3368.c
index 9949ebaf23fe..d056ed01e81d 100644
--- a/drivers/clk/rockchip/clk_rk3368.c
+++ b/drivers/clk/rockchip/clk_rk3368.c
@@ -484,9 +484,9 @@ static ulong rk3368_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk3368_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3368_clk_set_rate(struct clk *clk, ulong rate)
 {
 	__maybe_unused struct rk3368_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
index 976afc57f0b7..3c736ce0de73 100644
--- a/drivers/clk/rockchip/clk_rk3399.c
+++ b/drivers/clk/rockchip/clk_rk3399.c
@@ -1008,9 +1008,9 @@ static ulong rk3399_clk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk3399_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3399_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3399_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
@@ -1626,9 +1626,9 @@ static ulong rk3399_pmuclk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk3399_pmuclk_set_rate(struct clk *clk, ulong rate)
+static long rk3399_pmuclk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3399_pmuclk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3528.c b/drivers/clk/rockchip/clk_rk3528.c
index 3df16a0165e0..9a88c45ddda8 100644
--- a/drivers/clk/rockchip/clk_rk3528.c
+++ b/drivers/clk/rockchip/clk_rk3528.c
@@ -244,9 +244,9 @@ static ulong rk3528_ppll_matrix_get_rate(struct rk3528_clk_priv *priv,
 
 	return DIV_TO_RATE(priv->ppll_hz, div);
 }
 
-static ulong rk3528_ppll_matrix_set_rate(struct rk3528_clk_priv *priv,
+static long rk3528_ppll_matrix_set_rate(struct rk3528_clk_priv *priv,
 					 ulong clk_id, ulong rate)
 {
 	struct rk3528_cru *cru = priv->cru;
 	u32 id, div, mask, shift;
@@ -397,9 +397,9 @@ static ulong rk3528_cgpll_matrix_get_rate(struct rk3528_clk_priv *priv,
 	/* NOTE: '-1' to balance the DIV_TO_RATE() 'div+1' */
 	return is_halfdiv ? DIV_TO_RATE(prate * 2, (3 + 2 * div) - 1) : DIV_TO_RATE(prate, div);
 }
 
-static ulong rk3528_cgpll_matrix_set_rate(struct rk3528_clk_priv *priv,
+static long rk3528_cgpll_matrix_set_rate(struct rk3528_clk_priv *priv,
 					  ulong clk_id, ulong rate)
 {
 	struct rk3528_cru *cru = priv->cru;
 	u32 sel, div, mask, shift, con;
@@ -1197,9 +1197,9 @@ static ulong rk3528_uart_get_rate(struct rk3528_clk_priv *priv, ulong clk_id)
 
 	return rate;
 }
 
-static ulong rk3528_uart_set_rate(struct rk3528_clk_priv *priv,
+static long rk3528_uart_set_rate(struct rk3528_clk_priv *priv,
 				  ulong clk_id, ulong rate)
 {
 	struct rk3528_cru *cru = priv->cru;
 	u32 sel_shift, sel_mask, div_shift, div_mask;
@@ -1420,9 +1420,9 @@ static ulong rk3528_clk_get_rate(struct clk *clk)
 
 	return rate;
 };
 
-static ulong rk3528_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3528_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3528_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
index dfd7661e9fb7..3c6d0f664e07 100644
--- a/drivers/clk/rockchip/clk_rk3568.c
+++ b/drivers/clk/rockchip/clk_rk3568.c
@@ -383,9 +383,9 @@ static ulong rk3568_pmuclk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rk3568_pmuclk_set_rate(struct clk *clk, ulong rate)
+static long rk3568_pmuclk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3568_pmuclk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
@@ -645,9 +645,9 @@ static ulong rk3568_cpll_div_get_rate(struct rk3568_clk_priv *priv,
 	div = (readl(&cru->clksel_con[con]) & mask) >> shift;
 	return DIV_TO_RATE(priv->cpll_hz, div);
 }
 
-static ulong rk3568_cpll_div_set_rate(struct rk3568_clk_priv *priv,
+static long rk3568_cpll_div_set_rate(struct rk3568_clk_priv *priv,
 				      ulong clk_id, ulong rate)
 {
 	struct rk3568_cru *cru = priv->cru;
 	int div, mask, shift, con;
@@ -1332,9 +1332,9 @@ static ulong rk3568_crypto_get_rate(struct rk3568_clk_priv *priv, ulong clk_id)
 		return -ENOENT;
 	}
 }
 
-static ulong rk3568_crypto_set_rate(struct rk3568_clk_priv *priv,
+static long rk3568_crypto_set_rate(struct rk3568_clk_priv *priv,
 				    ulong clk_id, ulong rate)
 {
 	struct rk3568_cru *cru = priv->cru;
 	u32 src_clk, mask, shift;
@@ -2239,9 +2239,9 @@ static ulong rk3568_uart_get_rate(struct rk3568_clk_priv *priv, ulong clk_id)
 		return OSC_HZ;
 	}
 }
 
-static ulong rk3568_uart_set_rate(struct rk3568_clk_priv *priv,
+static long rk3568_uart_set_rate(struct rk3568_clk_priv *priv,
 				  ulong clk_id, ulong rate)
 {
 	struct rk3568_cru *cru = priv->cru;
 	u32 reg, clk_src, uart_src, div;
@@ -2490,9 +2490,9 @@ static ulong rk3568_clk_get_rate(struct clk *clk)
 
 	return rate;
 };
 
-static ulong rk3568_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3568_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3568_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3576.c b/drivers/clk/rockchip/clk_rk3576.c
index 2ed8b5954b8c..4a1a86712e06 100644
--- a/drivers/clk/rockchip/clk_rk3576.c
+++ b/drivers/clk/rockchip/clk_rk3576.c
@@ -1698,9 +1698,9 @@ static ulong rk3576_uart_frac_get_rate(struct rk3576_clk_priv *priv, ulong clk_i
 	m >>= CLK_UART_FRAC_DENOMINATOR_SHIFT;
 	return p_rate * n / m;
 }
 
-static ulong rk3576_uart_frac_set_rate(struct rk3576_clk_priv *priv,
+static long rk3576_uart_frac_set_rate(struct rk3576_clk_priv *priv,
 				       ulong clk_id, ulong rate)
 {
 	struct rk3576_cru *cru = priv->cru;
 	u32 reg, clk_src, p_rate;
@@ -1830,9 +1830,9 @@ static ulong rk3576_uart_get_rate(struct rk3576_clk_priv *priv, ulong clk_id)
 
 	return DIV_TO_RATE(p_rate, div);
 }
 
-static ulong rk3576_uart_set_rate(struct rk3576_clk_priv *priv,
+static long rk3576_uart_set_rate(struct rk3576_clk_priv *priv,
 				  ulong clk_id, ulong rate)
 {
 	struct rk3576_cru *cru = priv->cru;
 	u32 reg, clk_src = 0, div = 0;
@@ -2104,9 +2104,9 @@ static ulong rk3576_clk_get_rate(struct clk *clk)
 
 	return rate;
 };
 
-static ulong rk3576_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3576_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3576_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
index 6e214a59494e..bea54d33b013 100644
--- a/drivers/clk/rockchip/clk_rk3588.c
+++ b/drivers/clk/rockchip/clk_rk3588.c
@@ -1327,9 +1327,9 @@ static ulong rk3588_uart_get_rate(struct rk3588_clk_priv *priv, ulong clk_id)
 		return OSC_HZ;
 	}
 }
 
-static ulong rk3588_uart_set_rate(struct rk3588_clk_priv *priv,
+static long rk3588_uart_set_rate(struct rk3588_clk_priv *priv,
 				  ulong clk_id, ulong rate)
 {
 	struct rk3588_cru *cru = priv->cru;
 	u32 reg, clk_src, uart_src, div;
@@ -1436,9 +1436,9 @@ static ulong rk3588_pciephy_get_rate(struct rk3588_clk_priv *priv, ulong clk_id)
 	else
 		return OSC_HZ;
 }
 
-static ulong rk3588_pciephy_set_rate(struct rk3588_clk_priv *priv,
+static long rk3588_pciephy_set_rate(struct rk3588_clk_priv *priv,
 				     ulong clk_id, ulong rate)
 {
 	struct rk3588_cru *cru = priv->cru;
 	u32 clk_src, div;
@@ -1647,9 +1647,9 @@ static ulong rk3588_clk_get_rate(struct clk *clk)
 
 	return rate;
 };
 
-static ulong rk3588_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3588_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rk3588_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
@@ -2084,9 +2084,9 @@ static ulong rk3588_scru_clk_get_rate(struct clk *clk)
 		return -ENOENT;
 	}
 }
 
-static ulong rk3588_scru_clk_set_rate(struct clk *clk, ulong rate)
+static long rk3588_scru_clk_set_rate(struct clk *clk, ulong rate)
 {
 	u32 div, sel;
 
 	switch (clk->id) {
diff --git a/drivers/clk/rockchip/clk_rv1108.c b/drivers/clk/rockchip/clk_rv1108.c
index bbc443a91755..9e9022cd6fe3 100644
--- a/drivers/clk/rockchip/clk_rv1108.c
+++ b/drivers/clk/rockchip/clk_rv1108.c
@@ -568,9 +568,9 @@ static ulong rv1108_clk_get_rate(struct clk *clk)
 		return -ENOENT;
 	}
 }
 
-static ulong rv1108_clk_set_rate(struct clk *clk, ulong rate)
+static long rv1108_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rv1108_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong new_rate;
 
diff --git a/drivers/clk/rockchip/clk_rv1126.c b/drivers/clk/rockchip/clk_rv1126.c
index f6b0b74f2db2..545f54a54aa2 100644
--- a/drivers/clk/rockchip/clk_rv1126.c
+++ b/drivers/clk/rockchip/clk_rv1126.c
@@ -66,9 +66,9 @@ static struct rockchip_pll_clock rv1126_pll_clks[] = {
 	[GPLL] = PLL(pll_rk3328, PLL_GPLL, RV1126_PMU_PLL_CON(0),
 		     RV1126_PMU_MODE, 0, 10, 0, rv1126_pll_rates),
 };
 
-static ulong rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,
+static long rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,
 				  struct rv1126_pmuclk_priv *pmu_priv,
 				  ulong rate);
 /*
  *
@@ -402,9 +402,9 @@ static ulong rv1126_pmuclk_get_rate(struct clk *clk)
 
 	return rate;
 }
 
-static ulong rv1126_pmuclk_set_rate(struct clk *clk, ulong rate)
+static long rv1126_pmuclk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rv1126_pmuclk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
@@ -1512,9 +1512,9 @@ static ulong rv1126_clk_get_rate(struct clk *clk)
 
 	return rate;
 };
 
-static ulong rv1126_clk_set_rate(struct clk *clk, ulong rate)
+static long rv1126_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct rv1126_clk_priv *priv = dev_get_priv(clk->dev);
 	ulong ret = 0;
 
@@ -1705,9 +1705,9 @@ static struct clk_ops_uboot rv1126_clk_ops = {
 	.set_parent = rv1126_clk_set_parent,
 #endif
 };
 
-static ulong rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,
+static long rv1126_gpll_set_rate(struct rv1126_clk_priv *priv,
 				  struct rv1126_pmuclk_priv *pmu_priv,
 				  ulong rate)
 {
 	ulong emmc_rate, sfc_rate, nandc_rate;
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index dc84d4b6386d..f8e9d77e18fe 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -580,9 +580,9 @@ static ulong sifive_prci_get_rate(struct clk *clk)
 
 	return pc->ops->recalc_rate(pc, sifive_prci_parent_rate(pc, data));
 }
 
-static ulong sifive_prci_set_rate(struct clk *clk, ulong rate)
+static long sifive_prci_set_rate(struct clk *clk, ulong rate)
 {
 	int err;
 	struct __prci_clock *pc;
 	struct prci_clk_desc *data =
diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 0e0c82895ff2..35ee9a4978f2 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -710,9 +710,9 @@ static ulong cv1800b_clk_get_rate(struct clk *clk)
 		return err;
 	return clk_get_rate(c);
 }
 
-static ulong cv1800b_clk_set_rate(struct clk *clk, ulong rate)
+static long cv1800b_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk *c;
 	int err = clk_get_by_id(CV1800B_CLK_ID_TRANSFORM(clk->id), &c);
 
diff --git a/drivers/clk/sophgo/clk-ip.c b/drivers/clk/sophgo/clk-ip.c
index 7ac631126721..78ba582b4096 100644
--- a/drivers/clk/sophgo/clk-ip.c
+++ b/drivers/clk/sophgo/clk-ip.c
@@ -93,9 +93,9 @@ static ulong div_get_rate(struct clk *clk)
 
 	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), val);
 }
 
-static ulong div_set_rate(struct clk *clk, ulong rate)
+static long div_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_div *div = to_cv1800b_clk_div(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 val;
@@ -136,9 +136,9 @@ static ulong bypass_div_get_rate(struct clk *clk)
 
 	return div_get_rate(clk);
 }
 
-static ulong bypass_div_set_rate(struct clk *clk, ulong rate)
+static long bypass_div_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_bypass_div *div = to_cv1800b_clk_bypass_div(clk);
 
 	if (cv1800b_clk_getbit(div->div.base, &div->bypass))
@@ -291,9 +291,9 @@ static ulong mux_get_rate(struct clk *clk)
 
 	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), val);
 }
 
-static ulong mux_set_rate(struct clk *clk, ulong rate)
+static long mux_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_mux *mux = to_cv1800b_clk_mux(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	ulong val;
@@ -347,9 +347,9 @@ static ulong bypass_mux_get_rate(struct clk *clk)
 
 	return mux_get_rate(clk);
 }
 
-static ulong bypass_mux_set_rate(struct clk *clk, ulong rate)
+static long bypass_mux_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_bypass_mux *mux = to_cv1800b_clk_bypass_mux(clk);
 
 	if (cv1800b_clk_getbit(mux->mux.base, &mux->bypass))
@@ -432,9 +432,9 @@ static ulong mmux_get_rate(struct clk *clk)
 
 	return DIV_ROUND_UP_ULL(clk_get_parent_rate(clk), val);
 }
 
-static ulong mmux_set_rate(struct clk *clk, ulong rate)
+static long mmux_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_mmux *mmux = to_cv1800b_clk_mmux(clk);
 	int clk_sel = 1;
 	ulong parent_rate = clk_get_parent_rate(clk);
@@ -561,9 +561,9 @@ static void aclk_determine_mn(ulong parent_rate, ulong rate, u32 *m, u32 *n)
 	*m = tm / tcommon;
 	*n = tn / tcommon;
 }
 
-static ulong aclk_set_rate(struct clk *clk, ulong rate)
+static long aclk_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_audio *aclk = to_cv1800b_clk_audio(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 m, n;
diff --git a/drivers/clk/sophgo/clk-pll.c b/drivers/clk/sophgo/clk-pll.c
index 6ef50f00171d..72dfead33dd1 100644
--- a/drivers/clk/sophgo/clk-pll.c
+++ b/drivers/clk/sophgo/clk-pll.c
@@ -63,9 +63,9 @@ static ulong cv1800b_ipll_get_rate(struct clk *clk)
 
 	return DIV_ROUND_DOWN_ULL(parent_rate * div, pre_div * post_div);
 }
 
-static ulong cv1800b_ipll_set_rate(struct clk *clk, ulong rate)
+static long cv1800b_ipll_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_ipll *pll = to_clk_ipll(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 pre_div, post_div, div;
@@ -187,9 +187,9 @@ static ulong cv1800b_find_syn(ulong rate, ulong parent_rate, ulong pre_div, ulon
 	*syn = syn_min;
 	return new_rate;
 }
 
-static ulong cv1800b_fpll_set_rate(struct clk *clk, ulong rate)
+static long cv1800b_fpll_set_rate(struct clk *clk, ulong rate)
 {
 	struct cv1800b_clk_fpll *pll = to_clk_fpll(clk);
 	ulong parent_rate = clk_get_parent_rate(clk);
 	u32 pre_div, post_div, div;
diff --git a/drivers/clk/starfive/clk-jh7110-pll.c b/drivers/clk/starfive/clk-jh7110-pll.c
index d12dec9a1f86..e9299aceee17 100644
--- a/drivers/clk/starfive/clk-jh7110-pll.c
+++ b/drivers/clk/starfive/clk-jh7110-pll.c
@@ -299,9 +299,9 @@ static ulong jh7110_pllx_recalc_rate(struct clk *clk)
 
 	return refclk;
 }
 
-static ulong jh7110_pllx_set_rate(struct clk *clk, ulong drate)
+static long jh7110_pllx_set_rate(struct clk *clk, ulong drate)
 {
 	struct clk_jh7110_pllx *pll = to_clk_pllx(dev_get_clk_ptr(clk->dev));
 	const struct starfive_pllx_rate *rate;
 
diff --git a/drivers/clk/stm32/clk-stm32-core.c b/drivers/clk/stm32/clk-stm32-core.c
index 834f0d8379e3..fe581a422eb2 100644
--- a/drivers/clk/stm32/clk-stm32-core.c
+++ b/drivers/clk/stm32/clk-stm32-core.c
@@ -165,9 +165,9 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 
 	return ops->get_rate(c);
 }
 
-static ulong stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
+static long stm32_clk_set_rate(struct clk *clk, unsigned long clk_rate)
 {
 	const struct clk_ops_uboot *ops;
 	struct clk *c = NULL;
 
diff --git a/drivers/clk/stm32/clk-stm32f.c b/drivers/clk/stm32/clk-stm32f.c
index 6c3a369797d9..1cfa511ff088 100644
--- a/drivers/clk/stm32/clk-stm32f.c
+++ b/drivers/clk/stm32/clk-stm32f.c
@@ -494,9 +494,9 @@ static ulong stm32_clk_get_rate(struct clk *clk)
 		return -EINVAL;
 	}
 }
 
-static ulong stm32_set_rate(struct clk *clk, ulong rate)
+static long stm32_set_rate(struct clk *clk, ulong rate)
 {
 #ifdef CONFIG_VIDEO_STM32
 	struct stm32_clk *priv = dev_get_priv(clk->dev);
 	struct stm32_rcc_regs *regs = priv->base;
diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
index a7d0b55e060b..74ce9b15eef6 100644
--- a/drivers/clk/stm32/clk-stm32mp1.c
+++ b/drivers/clk/stm32/clk-stm32mp1.c
@@ -2155,9 +2155,9 @@ static int pll_set_output_rate(struct udevice *dev,
 
 	return 0;
 }
 
-static ulong stm32mp1_clk_set_rate(struct clk *clk, unsigned long clk_rate)
+static long stm32mp1_clk_set_rate(struct clk *clk, unsigned long clk_rate)
 {
 	struct stm32mp1_clk_priv *priv = dev_get_priv(clk->dev);
 	int p;
 
diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index 6e315f502aa5..fd2b9082a96b 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -59,9 +59,9 @@ static ulong tegra_car_clk_get_rate(struct clk *clk)
 
 	return -1U;
 }
 
-static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
+static long tegra_car_clk_set_rate(struct clk *clk, ulong rate)
 {
 	enum clock_id parent;
 
 	debug("%s(clk=%p, rate=%lu) (dev=%p, id=%lu)\n", __func__, clk, rate,
diff --git a/drivers/clk/tegra/tegra186-clk.c b/drivers/clk/tegra/tegra186-clk.c
index 99e0a9f28d9c..90c91096c411 100644
--- a/drivers/clk/tegra/tegra186-clk.c
+++ b/drivers/clk/tegra/tegra186-clk.c
@@ -27,9 +27,9 @@ static ulong tegra186_clk_get_rate(struct clk *clk)
 
 	return resp.clk_get_rate.rate;
 }
 
-static ulong tegra186_clk_set_rate(struct clk *clk, ulong rate)
+static long tegra186_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct mrq_clk_request req;
 	struct mrq_clk_response resp;
 	int ret;
diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index 16188d56f73a..697a561f8030 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -989,9 +989,9 @@ static ulong th1520_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(c);
 }
 
-static ulong th1520_clk_set_rate(struct clk *clk, ulong rate)
+static long th1520_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk *c;
 	int ret;
 
diff --git a/drivers/clk/ti/clk-am3-dpll.c b/drivers/clk/ti/clk-am3-dpll.c
index 1726233df173..df90d157bb07 100644
--- a/drivers/clk/ti/clk-am3-dpll.c
+++ b/drivers/clk/ti/clk-am3-dpll.c
@@ -201,9 +201,9 @@ static void clk_ti_am3_dpll_ssc_program(struct clk *clk)
 
 	clk_ti_writel(ctrl, &priv->clkmode_reg);
 }
 
-static ulong clk_ti_am3_dpll_set_rate(struct clk *clk, ulong rate)
+static long clk_ti_am3_dpll_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_ti_am3_dpll_priv *priv = dev_get_priv(clk->dev);
 	u32 v;
 	ulong round_rate;
diff --git a/drivers/clk/ti/clk-divider.c b/drivers/clk/ti/clk-divider.c
index f959b5633d64..4d216dded96b 100644
--- a/drivers/clk/ti/clk-divider.c
+++ b/drivers/clk/ti/clk-divider.c
@@ -179,9 +179,9 @@ static ulong clk_ti_divider_round_rate(struct clk *clk, ulong rate)
 
 	return DIV_ROUND_UP(parent_rate, div);
 }
 
-static ulong clk_ti_divider_set_rate(struct clk *clk, ulong rate)
+static long clk_ti_divider_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_ti_divider_priv *priv = dev_get_priv(clk->dev);
 	ulong parent_rate;
 	int div;
diff --git a/drivers/clk/ti/clk-k3-pll.c b/drivers/clk/ti/clk-k3-pll.c
index 9766f50a2e4d..b47f7cd3a19e 100644
--- a/drivers/clk/ti/clk-k3-pll.c
+++ b/drivers/clk/ti/clk-k3-pll.c
@@ -343,9 +343,9 @@ static void ti_pll_clk_bypass(struct ti_pll_clk *pll, bool bypass)
 
 	writel(ctrl, pll->base + PLL_16FFT_CTRL);
 }
 
-static ulong ti_pll_clk_set_rate(struct clk *clk, ulong rate)
+static long ti_pll_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct ti_pll_clk *pll = to_clk_pll(clk);
 	u64 current_freq;
 	u64 parent_freq = clk_get_parent_rate(clk);
diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index cb7e016c637a..f2afc7e7ec91 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -257,9 +257,9 @@ static ulong ti_clk_get_rate(struct clk *clk)
 
 	return clk_get_rate(clkp);
 }
 
-static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
+static long ti_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct ti_clk_data *data = dev_get_priv(clk->dev);
 	struct clk *clkp = data->map[clk->id].clk;
 	int div = 1;
diff --git a/drivers/clk/ti/clk-mux.c b/drivers/clk/ti/clk-mux.c
index 60bdde35e510..1b29f2149b76 100644
--- a/drivers/clk/ti/clk-mux.c
+++ b/drivers/clk/ti/clk-mux.c
@@ -99,9 +99,9 @@ static int clk_ti_mux_set_parent(struct clk *clk, struct clk *parent)
 	clk_ti_latch(&priv->reg, priv->latch);
 	return 0;
 }
 
-static ulong clk_ti_mux_set_rate(struct clk *clk, ulong rate)
+static long clk_ti_mux_set_rate(struct clk *clk, ulong rate)
 {
 	struct clk_ti_mux_priv *priv = dev_get_priv(clk->dev);
 	struct clk *parent;
 	int index;
diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index fdf49a759983..08637c136ec5 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -83,9 +83,9 @@ static ulong ti_sci_clk_get_rate(struct clk *clk)
 
 	return current_freq;
 }
 
-static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
+static long ti_sci_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct ti_sci_clk_data *data = dev_get_priv(clk->dev);
 	const struct ti_sci_handle *sci = data->sci;
 	const struct ti_sci_clk_ops *cops = &sci->ops.clk_ops;
diff --git a/drivers/clk/uccf/clk-composite.c b/drivers/clk/uccf/clk-composite.c
index 0fdc8c2e6fec..a77646d4f3f3 100644
--- a/drivers/clk/uccf/clk-composite.c
+++ b/drivers/clk/uccf/clk-composite.c
@@ -57,9 +57,9 @@ static unsigned long clk_composite_recalc_rate(struct clk *clk)
 	else
 		return clk_get_parent_rate(clk);
 }
 
-static ulong clk_composite_set_rate(struct clk *clk, unsigned long rate)
+static long clk_composite_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk_composite *composite = to_clk_composite(clk_dev_binded(clk) ?
 		(struct clk *)dev_get_clk_ptr(clk->dev) : clk);
 	const struct clk_ops_uboot *rate_ops = composite->rate_ops;
diff --git a/drivers/clk/uccf/clk-divider.c b/drivers/clk/uccf/clk-divider.c
index 857c72ee59f1..777102e388db 100644
--- a/drivers/clk/uccf/clk-divider.c
+++ b/drivers/clk/uccf/clk-divider.c
@@ -153,9 +153,9 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 
 	return min_t(unsigned int, value, clk_div_mask(width));
 }
 
-static ulong clk_divider_set_rate(struct clk *clk, unsigned long rate)
+static long clk_divider_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk_divider *divider = to_clk_divider(clk);
 	unsigned long parent_rate = clk_get_parent_rate(clk);
 	int value;
diff --git a/drivers/clk/uccf/clk.c b/drivers/clk/uccf/clk.c
index f04b3b23dbd1..ee410db76932 100644
--- a/drivers/clk/uccf/clk.c
+++ b/drivers/clk/uccf/clk.c
@@ -87,9 +87,9 @@ ulong ccf_clk_get_rate(struct clk *clk)
 		return err;
 	return clk_get_rate(c);
 }
 
-ulong ccf_clk_set_rate(struct clk *clk, unsigned long rate)
+long ccf_clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk *c;
 	int err = clk_get_by_id(clk->id, &c);
 
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index 3a4c9f6687f7..f10c402a3e47 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -172,9 +172,9 @@ static unsigned long uniphier_clk_get_rate(struct clk *clk)
 
 	return __uniphier_clk_get_rate(priv, data);
 }
 
-static unsigned long __uniphier_clk_set_rate(
+static long __uniphier_clk_set_rate(
 					struct uniphier_clk_priv *priv,
 					const struct uniphier_clk_data *data,
 					unsigned long rate, bool set)
 {
@@ -228,9 +228,9 @@ static unsigned long __uniphier_clk_set_rate(
 	return best_rate = __uniphier_clk_set_rate(priv, best_parent_data,
 						   rate, true);
 }
 
-static unsigned long uniphier_clk_set_rate(struct clk *clk, ulong rate)
+static long uniphier_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct uniphier_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct uniphier_clk_data *data;
 
diff --git a/include/clk-uclass.h b/include/clk-uclass.h
index a26603bf2f0a..6272dbb35799 100644
--- a/include/clk-uclass.h
+++ b/include/clk-uclass.h
@@ -33,9 +33,9 @@ struct clk_ops_uboot {
 			struct ofnode_phandle_args *args);
 	int (*request)(struct clk *clock);
 	ulong (*round_rate)(struct clk *clk, ulong rate);
 	ulong (*get_rate)(struct clk *clk);
-	ulong (*set_rate)(struct clk *clk, ulong rate);
+	long (*set_rate)(struct clk *clk, ulong rate);
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 	int (*enable)(struct clk *clk);
 	int (*disable)(struct clk *clk);
 #if IS_ENABLED(CONFIG_CMD_CLK)
diff --git a/include/clk.h b/include/clk.h
index 90b42a618675..3cd080b43264 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -501,9 +501,9 @@ ulong clk_round_rate(struct clk *clk, ulong rate);
  * @rate:	New clock rate in Hz.
  *
  * Return: new rate, or -ve error code.
  */
-ulong clk_set_rate(struct clk *clk, ulong rate);
+long clk_set_rate(struct clk *clk, ulong rate);
 
 /**
  * clk_set_parent() - Set current clock parent.
  * @clk:	A clock struct that was previously successfully requested by

-- 
2.55.0

