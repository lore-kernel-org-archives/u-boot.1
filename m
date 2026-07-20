Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE09C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6901D607FF;
	Mon, 20 Jul 2026 18:10:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id md-bX6bFYQ0s; Mon, 20 Jul 2026 18:10:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD5186073C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571038;
	bh=OStFY9BR8FfIjZREzO97CeaR2ZyD9Nhv6dlVXM+o66g=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0OZuz6LO7SkPleZ/3+HB5nS/vRoeJ9G0vt1uM2ihcFN/iNRQOYHICvccMuihCW+FZ
	 T4QaDitALZ8fk9X79bmthUkxUVhFXcnJZ+dCmeQeM+fFByB/a7CYevzArNv7TlT85P
	 /c0gDVfpjRQg9QFvXCRlGehcbyn2xkznDKc7jMjzJgx9kKu8snVelSHavxxgZjCEkb
	 UcrT/bPcV08fFe4hB/1TBlX8yv2YYnpjgc76BvumepQjn/qfTZcMnSa9vCMZRLC4Aa
	 ZQ2CRdnyrP6a/et3fbEiuHmnGZj5AGD6Wc0tW4dqWyK+f2YO+hWP+I1g93LxThiYBR
	 MFHunfwjMdXMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD5186073C;
	Mon, 20 Jul 2026 18:10:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54331132C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3997980D1D
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVn3dmQ5PLkE for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2878580BFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2878580BFF
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2878580BFF
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9996484A0A; Mon, 20 Jul 2026 18:41:28 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8148F8484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:26 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so45249185e9.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565686; x=1785170486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OStFY9BR8FfIjZREzO97CeaR2ZyD9Nhv6dlVXM+o66g=;
 b=JIcwH9BvMz1x7yBNl8O4mWEbi24iGuvti8pbVBqCctDft+BKUImNBnFQZ+jVnzlK54
 zxswxA4TZSQ17vRPSbmrGKH+7JP4i9aNL0EUSHvhljTODep8ykec9t/SSGSLbO9Rfgyw
 wTClhUZ9gM1FxgRAH25+b1tWGV1sUe++gtxL4KuZRz3RILNycheKbFiRka9i176A42vy
 Z5BRDLzejai79F74H6sxzgn+G3ThYq04q56nBy/VRCAQtRy73Ho8+3YMSZY7fT5KIjtt
 YdnNfu9idZJuZq8q2UwnR5ayvKsbhtdTBBNHdPum0WcyAyKn0dQR0gGObBNP9m32/4j6
 g3YQ==
X-Gm-Message-State: AOJu0YwgjMNzEkmxtxSGLeATDkHqcGacHWZql3KVFZU4M3RGGYfceB88
 BqNcaO7MyC4QxcQsakKxVTwy2G/ZHXeRVUZru7BaSWCQ6N9N/OpBifborc6MBZAhfhU=
X-Gm-Gg: AfdE7ckjZplanHMEVYTnsbmm43/W5llZRv/9n59t8Mh0u6aQkhaNuthoC3mjAjjRnIg
 65brDLdR8XG73JzCxucLC6Gy8LPqkhSsX//0luC2cmzma+r5TOLzoivZutahwbDNUWJqshYH7j9
 T+E9JF60I31L4KD8REqVaCmXXcqTu9BKn5x0bwin5nsg/SPgWSH0NPjDlpiCfGyz64FHbEYl6Do
 m1vVvWYSPAGKefhjcaZ4j1K9j43r8zjDLXzGXDN6Zbsu8CU2bN6iyuiIccjTQNkZZGYJyGB55l5
 4JPTR0Ji0ZjcSFef0nuOAqC7npARCDHc+eTSuQtjklIuFLMmDD1yO+VrsOrKfq/SFuqXOlqHPjq
 vt7r1/Cgql2p3BiZbMh7t2ZjgHF/NWET/ceDUWtAuclM4A20bxdjyw7riOEWx1z/k+bJGS7LHcU
 LWytwBcdSXwdPXmESKMo6q47XI3G4Pvw==
X-Received: by 2002:a05:600c:630e:b0:495:4856:2659 with SMTP id
 5b1f17b1804b1-4954a3db6b0mr169935805e9.9.1784565685921; 
 Mon, 20 Jul 2026 09:41:25 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:25 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:42 +0100
Subject: [PATCH 15/36] clk/ccf: optimise orphan clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-15-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3318;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=yRfYmU23VgPDB/44B4/gNGg7P/vRVrwNS/lrGqIh66k=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+DBH2grbL2WyD0EP8znP52V7J80DNLjb5/F
 vnIO+vebaCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tkFRD/0YZKE0M8K3D+MFJ/5+tyUuxTyMy1HV1imY/aW12kL+0FkYtN1Vq42q550Qd4qQWM98wd2
 btVlxB1gEZxX5DUNspfSH9dbCDc4J8Z/PZz7KEn61JJjGmS6PoSwpE04Lx4cI3L0jhiph8t9xXD
 FjF80JU8mcoGSWs1PqDRLGCY8u9MUGN3MmEMK6UH99+JxRdf5Ui8pIM5I5nHJaEyW530hyPY12F
 Nhxm5glHZyJh7s+VUAqagmXwjBa/g/IEqYsD2GB+FgiJXc6wSANhshzrOu/ADaQd7P51cMTydk+
 mt/dtVFQ87DKltevN76wP/UiBe/YrGvPLbCmv81vM+sAuobGnJBBRxnamUuCmkM0QFRLkxmDGFX
 Jbev9cPnXwyMgjXrZmeiJvvCI1ZcRkCq1rL4CLqgxxww7gUVrD5HD51XrN2QW3CMYw861QAZ3mO
 TdFptJchpXOgqHfs+UKMUifS7szR2Lqh3JM4Kl4K1XXV/TTTQ1uoFzo7GeEpv/OQIpZ0pDfHLas
 PakjUWNw+NxtsGRwS9iKZiZxvH1JzaXyqQ5cvTUMCuNqlcDE9a5AdlUDu3kSv2A0DWci3l6hDfZ
 fxhWoy1PFo/biHrQt0uS7G41jYTI5VZ79fe5Bg+WNhmSOqrSBaaJwLSIQG4LOCv/50SH+AVdqdg
 rQxGuA8QahDS1QA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565686; x=1785170486; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OStFY9BR8FfIjZREzO97CeaR2ZyD9Nhv6dlVXM+o66g=;
 b=BvtkibbmJNpPlTA1hoOWGXP3Ay1obf3iWs+T9ukMLypoWAPZ9BkdK51Ssi33eXa7/r
 wtaH+XI7IH8hDOaSN3+r4sxBxk3ijtmRPPErNksGiJcTsOPvnNnI4YZQxdws/pACZfoN
 N2Etry6fxpwxEz/OrDw0G1VlZ2jTf0/wYu8EarSagcf2XvVkGPOH+29pE1A52lT59ZjK
 FNIPDRkJpm2zj6WdoeD3efVDMtSNOh5X9xGeJ99hLQpSXxJ1+aOxjF46BLoS8DzhNrtd
 OD/Ae9fU1lb8i68TSHlqGxTQDMNxxAtrRXvFudxE/Wyxi93e43aPNpKkJ/S6akYSAAM7
 vrAg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Bvtkibbm
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bvtkibbm"; 
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

In Linux, CCF quite aggressively attempts to reparent orphan clocks,
doing so every time a new clock is registered. This makes sense in a
dynamic system where modules could be loaded at any point, but is much
less necessary in U-Boot.

In U-Boot we don't have to worry about kernel modules being loaded later
during boot, we also probe clock provider devices on-demand. As a result
there are only two cases where we will fail to find a parent clock:
either the clock provider device doesn't actually provide any clocks
in which case the clock will be an orphan forever, or the parent clock
is provided by the same device and just hasn't been registered yet, in
which case it will be available when the device registers itself as an
of_provider after all of its clocks have been registerd.

With this is mind, we can avoid a bunch of spurious calls to reparent
orphans and of_clk_get_hw_from_clkspec() by stashing the error and
bailing early if we know this clock can't be found.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/ccf/clk.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ccf/clk.c b/drivers/clk/ccf/clk.c
index 83d435dce02b..28692fbc7798 100644
--- a/drivers/clk/ccf/clk.c
+++ b/drivers/clk/ccf/clk.c
@@ -53,9 +53,17 @@ struct clk_parent_map {
 	const struct clk_hw	*hw;
 	struct clk_core		*core;
 	const char		*fw_name;
 	const char		*name;
-	int			index;
+	int			index : 20;
+	/*
+	 * U-Boot: Avoid repeatedly trying to probe
+	 * missing clock parents. Since we lazily
+	 * probe clock providers, if we get an error
+	 * then trying again later will never work since
+	 * we don't support loadable modules.
+	 */
+	int			error : 12;
 };
 
 struct clk_core {
 	const char		*name;
@@ -285,16 +293,32 @@ static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
 
 	/* Only cache it if it's not an error */
 	if (!IS_ERR(parent))
 		entry->core = parent;
+	/*
+	 * U-Boot: save the error so we avoid trying to get this parent again.
+	 * -EPROBE_DEFER probably means the parent is in the same clock device
+	 * and just isn't available yet.
+	 */
+	else if (PTR_ERR(parent) != -EPROBE_DEFER) {
+		entry->error = PTR_ERR(parent);
+	}
 }
 
 static struct clk_core *clk_core_get_parent_by_index(struct clk_core *core,
 							 u8 index)
 {
 	if (!core || index >= core->num_parents || !core->parents)
 		return NULL;
 
+	/*
+	 * U-Boot: if we failed to get a parent before we don't need to
+	 * try again, unlike Linux we don't have modules.
+	 * The only reason this might happen is due to a driver issue.
+	 */
+	if (core->parents[index].error)
+		return NULL;
+
 	if (!core->parents[index].core)
 		clk_core_fill_parent_index(core, index);
 
 	return core->parents[index].core;
@@ -1956,9 +1980,13 @@ static int __clk_core_init(struct clk_core *core)
 			goto out_list_del;
 		}
 	}
 
-	clk_core_reparent_orphans_nolock();
+	/*
+	 * U-Boot: since we probe clk providers on-demand it's enough to only reparent
+	 * orphans when adding providers not for every single clock.
+	 */
+	//clk_core_reparent_orphans_nolock();
 out_list_del:
 	if (ret)
 		hlist_del(&core->hashtable_node);
 out:

-- 
2.55.0

