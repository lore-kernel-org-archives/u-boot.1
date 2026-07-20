Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9783CC44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3CA680DE8;
	Mon, 20 Jul 2026 18:10:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kFD_ceZpxm0c; Mon, 20 Jul 2026 18:10:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 26FCC80D93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571028;
	bh=9B8KuSBNTCEx9h5lEbVEkOqmp59pk2ZXb38H6qR6+A4=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ebw/7TagdEhowX93ZpEW7VfmmzoBvtlwKmL6cNNFqyD3F5wnhge2N3yQUFhRvVxzq
	 XpjyOBMXxNjiIMdSt4DKbhfohFTSG4B/L3i+zJF8+Z+KSmtf+DVNGc+b3ifX+SnQBF
	 X77NpFH9Hqj/soaicVqxmZ1ENUOR4w3baNkL7tmRtK3F+hUl3qEgzamAGzkvT/LujS
	 3nhryy3dXVglhSIf9tPfk1+x5rZA+bcpiHIMyvKDBiaCrBUOQPDml2ZnCIq7lHVXwy
	 x6Xj3NPlMI27lzaoU0aacwFe0bvKDpBIldkuJ4LkP5CWpKOBhcVKVJD0gQNFi7ljd/
	 9Bw3Rlz/MyEsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26FCC80D93;
	Mon, 20 Jul 2026 18:10:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 77F261333
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A44B80D09
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIxudwx5QfAE for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
X-Greylist: delayed 498 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 16:49:05 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 62C0D80D00
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62C0D80D00
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62C0D80D00
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513AE84A3A; Mon, 20 Jul 2026 18:41:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AB684A4B
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:48 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso17637585e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565708; x=1785170508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9B8KuSBNTCEx9h5lEbVEkOqmp59pk2ZXb38H6qR6+A4=;
 b=CI7mdlNgriAQVKZ/CU1I/8SSE37KqZHInXe1LGP9fSWUYLGq/5YVCsA0LDk7Hg/zAG
 rlKhX5jCTjG05vz2F/Wi1egUtH12oH04C9N3ap00GHQ10EjTOmVtS3QdMiAiapL/9QLQ
 INw+1N08tta73z/n5M3GspskeFP4Sk5Lp/QbMCEre/gY1XDJ1GEu5cXDdVGpmkIbLZN+
 ifTDflywbkZDFWlJviDzwASiuanW+wwc7JLPhZkiEdQtjGWjOZuF0TW/D27Xs7sgIZ9t
 65M+/zJyv/Kq7Vhq4w239ZCe6N/AQVqrhR/zAlK223zky0H23g5S+yHOUXXvkAtj3x0v
 R4nw==
X-Gm-Message-State: AOJu0Yxyvyo4abk7WZm3mfOSi0Z0lX8aawiG1tvd4mKUAgfQd7wHDtdQ
 xfrz64r2HBfUcdL8TLSm7edOrmq4Je7SmPznnyWdub+dcWKmRgsatyC5EFSuAYTYeJU=
X-Gm-Gg: AfdE7cn36kpumKY3INQwNr+VDSU54zmPGI7tbndwLebq7/9xZ/k0lI1tszSIzw3XKLf
 jmBMtRsYmwokhLyBkib2L29ufxQ4hwhB1h6hJX5wjIt09zdDxA4Fsg27dZrVYoqEeeI5LyfNkN7
 vRF8kH+9guaQ7Qm04o8bgfccAZLBmJ4wHJZSX/yblrg5M3vTZN1sO7fvYVoWiDAZ/NMCTzn0Sk3
 L/DQEx9MdHZ8pf28+oIgIPsdbtl1JCkAWzYXajp8phTXJ7hTe5cCNeP01wO3DGMHNZQTLnoPGOg
 vtv3H57InaLfe2pTygNRW9/VreLI6mp7bfp8bBNlc8/vH0Mv8ULfDgeA0ebz1Yo7ueRjW/hAj7v
 +hQVttxiy/RCNqpfVaZV+Oa2UQ8Ag+i+gT2wgrQAdrXuow/6VvqkF7bIM6iIpORJbyOKDRUXUHM
 Z4JJYhv4vQSqH/+NpUM+rolX/ymQI0lA==
X-Received: by 2002:a05:600c:b96:b0:493:f6f0:d66b with SMTP id
 5b1f17b1804b1-4954a3ec771mr164705465e9.1.1784565707702; 
 Mon, 20 Jul 2026 09:41:47 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:47 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:50 +0100
Subject: [PATCH 23/36] configs: add sandbox CCF_FULL defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-23-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=593;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=WlMfDTqVhXwTJ3LE/+5XU5i17aOuzSmZi7amObrz57Y=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+EZqBy/nFytM9Gx9sDqP1zD/hCW+RC8QwGa
 /+NveAHUjCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhAAKCRAFgzErGV9k
 tjOOD/4wfGd34iTCWn7j0+zQL6Nznnep43bw2kb3t8Pryml/6kJTIpjWq4+V3mKZkVOxCmjOfF9
 R/4mKi2ds8qq7/liYQgcs6mWxrVgadTiVHtVXs91+nIzWI0VTNy38v5zMo1KqMJCFkyTRkTO1eP
 MJ4bEUBeccqueYMly8lJfv6Jcfr3I8rufu3c3c0IHuRtBkNw3CkjmmCIQjUw0o9F1kprNeyVlde
 Lxt+x+L0S9K8AlInb9ItCbzKEc0bUREWgAi70mAN/+UBnY9jE9l9C1/idYeqsrKMOemZyCfcvx7
 NkjtNTDfL0Whpne3/4BvjTBPjyJMaIm8/xEb/ZOny+DC7qs+ZgYnPs29mXAI/LjnqAqJlr5FIzf
 txVlOzxU3f26uN5125tAQaB3zv+xZkE5cWxfB4LMbPTEqL6mPjUvi7Dk4W2hKIbVM23zYF6PC4H
 i+qfDQyfTdbN6jFnPeZGYInR7xpdhc7JCmXzCNwaFqClN/8NurgGho/q1l5gvd3oV5unnZ4ZQd5
 z5mWhKAZizsa1xfgHqfPAf71oYuNpNlxAL1vNeNeig1CNNOw+0+fMN/fdx7Qx7d08nPPcicHNfn
 eMUJMVJfK7/0AaGrmhbzJoI8aOaJhg8+g3V8njZ/8O+ngAf/WPToguvl/Mr6y/a59KY1k8tHIUX
 hF3ecsl11QjZOmw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565708; x=1785170508; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9B8KuSBNTCEx9h5lEbVEkOqmp59pk2ZXb38H6qR6+A4=;
 b=trMmKJxbUvtNVAsqX/RonE/gfUVmB8rDLKv2OqdkN0xcDzOYQqk29oYuUnAbym5twg
 l7YX+Z6I97aufCnYLyfquEEhnZKcfB15+OCbuI9GAd4V3XG466beaSY0I0qAgyXMGGcw
 i6x4onLBndvesvXBwKHnD9fFo4142nuJA1hd9XjsUhG0vz4wsLx+mZGIHIFEztfABkAc
 2NuGy0bipeMcqnw0OgIkhglowoACD9yNd400mWaBBWuR1tgxsEFtb+aAkn05Prs3S/wU
 8SDD2zmGbdhX/zYsFgNiqGD/3WUF3dRJDsT9lDXUHSatS3ojnD9SvZK0hpBwiXei30GC
 AJHA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=trMmKJxb
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="trMmKJxb"; 
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

This extends test coverage to include CCF_FULL which is supported by the
clk_ccf tests.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/sandbox64_ccf_full_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/sandbox64_ccf_full_defconfig b/configs/sandbox64_ccf_full_defconfig
new file mode 100644
index 000000000000..0cec3257a30f
--- /dev/null
+++ b/configs/sandbox64_ccf_full_defconfig
@@ -0,0 +1,5 @@
+#include "sandbox64_defconfig"
+
+CONFIG_ARCH_SANDBOX=y
+CONFIG_CLK_CCF_FULL=y
+CONFIG_CLK_CCF_FULL_COMPAT=y

-- 
2.55.0

