Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C934C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7436406F5;
	Mon, 20 Jul 2026 18:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtYHdk1xAExc; Mon, 20 Jul 2026 18:10:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AABA2406E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571014;
	bh=Oqo6ixlYsyk1iQ7M0B4fzUdeOpaX0QlUzEsGR6+ELqo=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=dd7gNEV8Yn3bNrO0Np8UszihOXLp5B8LYdXz8nhinj1h8X/zIlY/EhtIpKWBEQt4i
	 L8GHdsdOerk259iE8fj5MPnD6Hy2R9Ziy3iCSTvvQcJOX8Z/82VRkRHtH7YZj7G/WV
	 XKR+wbOBCR+vxW7YSlEf5hUsAE9ITYTpu9werdn/xPjAP5Ix4PB3S7TdzdBVi3gSPV
	 wjWid/iZhKzHDnJymVlpsR4IZ1C48rIV0nk4GfOtLZwlwQQFhGOgFpaHc+qPvoUo1y
	 lsMQnS1j19G00ImCZLMiOJK6LkpCugqaBk4+Kr182G44ycJ3QIwZpJ1eyf2jrbFs5s
	 QkvAEvmhi5/gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AABA2406E2;
	Mon, 20 Jul 2026 18:10:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C76C51E11
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD5876060E
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvAn4vUi4I6q for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5D8FA6071F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D8FA6071F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5D8FA6071F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D595884A12; Mon, 20 Jul 2026 18:41:36 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AC28484A
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:34 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso20735045e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565694; x=1785170494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oqo6ixlYsyk1iQ7M0B4fzUdeOpaX0QlUzEsGR6+ELqo=;
 b=YMM0NSWmgYJZbGhUtjei5yPvsysOnyaaRMK3C2pL+JSZWfiPJSD9gRrfjvApaixDBs
 MxmmPLZOs7+rkHvC0WQhXte/8N82vdXCe5k+UFzXBK+sY5ujO64jgxjDBqjIz6/mVl7U
 NPVkrNznrKpYPStaN7WSE6PxHwKcCmey2ajiucpA2iepd2la4AOcefLkobisvqROvNJ4
 tZEx/K0eQZ2NRkxc85VV2Zk4KhzrNoejdoFkU/GIORbi4p4mjKmZYdV/lvMZtXrJu1ig
 14ntz6Pya8AMMaBYeFCOVVd8ZU6unqj28vnTePXKvceQm6qbV/acD2juX78tTNJ3ckMh
 3aSA==
X-Gm-Message-State: AOJu0Yya6HyT6hfQKS7ujTcaHqZjy2+TYQ32aqswQKmcUZgoELBuQQM1
 aa17NgymM+cEQ677WoyVMwqYkKOvygJzOStkMozZ1eY6z3H9CPlKWQaiDDKzMgMdn9Y=
X-Gm-Gg: AfdE7clAqds64ziGZnxFamdxEx1xpH8L5WPHcM2JRQq+mWxB0c46HetdwuigrXURrIt
 WxFoPoeXyqSot78V5GXbuBlN54hGzdaTW6ble3VaN5LY1Y9Bq+fZ4a9u7D519ZTPXUy0duAc3aJ
 isEVDd1CxiVwSkjNJ/33gjKt+37sFUjpj7cY0yPUTkf8tM+n4yC0ymnoU4NFYp9qTiiRduZVsKX
 Fd11VSKD9jpyPO07WbpNUwBPM9/KV+YyZfQ9xmc2hZOy/dOb/MKxuFJZZ8IqtavKUN3omnsMK1p
 bdTueho2ZNocFdA609yZvwdxGJSfvvarKg0kMrs0roV94ji6Bcem1+GRKXODwvBAVKiBkW4PmXv
 TqYIJB4fV52/FQ2wtlbvVOYB3JX4ocUTK90Bod+SVE+UWccx3zi7yF3Rq7gPrGmIBT6hy3jmSFB
 p75FisUvwk5WmXA98LP+inG4LJNI8cMQ==
X-Received: by 2002:a05:600c:4585:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-4954a3eeb63mr165332105e9.5.1784565693778; 
 Mon, 20 Jul 2026 09:41:33 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:32 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:45 +0100
Subject: [PATCH 18/36] doc: describe Common Clock Framework
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-18-8fece1b0333d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4521;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=rSomRLjVVKCnU8cRpeI8BvmJsgQT9QMmhXl3h6TVXuI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+Dufha9R5N/qvCKGFGKLnnP3/wgiaWgY6Cn
 AE8yef3RuSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PgwAKCRAFgzErGV9k
 tkCkEACOYWXk2wA+JoKdN07RlAB7Ctg1dsEtTklhsagm/YGbqxnvUCjpDyGH0lJqSd/bvr9q9Ol
 XZBCqZil9l0cLm2SZv7aMeCPsFjeTCqVirIqKigYFlF7uKq6smzGf2VbVowXZIL9dDD8Lx6O8jg
 vzXTU+SM1t5NGOutU5q6dQkWFsl1hM3aJwebJEmEZbNKg4eH445Uo5teVJ8ZzyVYnIVKGNoFxjJ
 X0p4oM1x6Ns6DGeviE8HTxuzXEXWD3k5oPnYbowAFoi2kMKE6e/qZKqzD9PVVifqdrII5rxXrIs
 jBMvGx11Ly17HCdwtFef/CjkU6WKnPDpYafll1WTpAJRYGh2RACcNrLbcNBN5RY5fGm6D8ubcHb
 qSfrrmhtdV5u1woSlGPGt0eEHjNnBjfdZs4YkO+NE9Xe0Ba9AFzAPDOZmeL60OmIMv9QFfWcknV
 TpU4lj8EApYVcS+eVgRDjs+oiSm4yDvZ2Jg2ZTUcu+/4jbMspCJLEo7+Fsd2hMmPNKdMbdDgJ0w
 E9b3ZfZ7y+HdsYU21hbxTC1S9hiOdrHXPuvxrHw0Zx/wBoyKcJTPITEcjPHH+fcyIOwxKox53jH
 cYLkn2ol3vn2ov/kP9g2Bp6ROtbpQMxKWL64z4PSngj20687mj77mosIeDNZJnesVGRUtObZ0Di
 SPyd3cQ6tHiP92A==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565694; x=1785170494; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oqo6ixlYsyk1iQ7M0B4fzUdeOpaX0QlUzEsGR6+ELqo=;
 b=SUfv4HU30QIBPg6S8cejeOtRfL/KxxCqgnsq4DwmBEe71BX8QyU1RWIOYrS4Siv1Sz
 e1ZQsCTTPrO/JBYZWqCOKhaSqsHZu3hEHRN7aDuSSqm+QyU4QRwghpP4/MjWMBqSfrOV
 DjPx6+2TBq55Pw7BR6WIXizPt1nZXNmH99a/eGlVyiGka0qdH7Vl36cU1NXjr54fnZ8s
 ArT2RcvnVUY54tUwH9o0/APqwIHTWuk+OiiMRRza89EQM/03SXPqVndG/imhX8pfs03V
 Ao6Xo1VngwRu0mqDjlWc8S/rp+N4oato7oDRz+plN2nglXPoh4x6jiXq0GvFrnSTw/Zm
 o7Ag==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=SUfv4HU3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUfv4HU3"; 
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

Add some documentation outlining the two CCF ports in U-Boot as well
as documentatig the limitations of CCF_FULL with respect to SPL and
pre-reloc support.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 doc/api/clk.rst       | 25 +++++++++++++++++++++++++
 doc/develop/ccf.rst   | 35 +++++++++++++++++++++++++++++++++++
 doc/develop/index.rst |  1 +
 3 files changed, 61 insertions(+)

diff --git a/doc/api/clk.rst b/doc/api/clk.rst
index 7c27066928e5..bce58cebef54 100644
--- a/doc/api/clk.rst
+++ b/doc/api/clk.rst
@@ -16,4 +16,29 @@ Driver API
 ----------
 
 .. kernel-doc:: include/clk-uclass.h
    :internal:
+
+Common Clock Framework
+----------------------
+
+U-Boot includes optional support for the `Linux Common Clock Framework <https://www.kernel.org/doc/Documentation/clk.txt>`_
+in two forms:
+
+IMX U-Boot CCF
+^^^^^^^^^^^^^^
+
+Basic support for managing the clock tree, using per-clock ops, propagating rate change requests, and using common
+divider/mux/gate clocks is provided by the earlier ``uCCF`` or ``U-Boot CCF``, it uses ``UCLASS_CLK`` and the associated
+:c:struct:`clk_ops_uboot`. The clock tree itself is tracked through U-Boot driver model as each clock has a single ``udevice``.
+
+This is described in more detail in `The IMX CCF document <https://source.denx.de/u-boot/u-boot/-/blob/master/doc/imx/clk/ccf.txt>`_.
+
+CCF Full Port
+^^^^^^^^^^^^^
+
+The second version of CCF (*CCF Full*) focuses on maintaining compatibility with the Linux API. It introduces the
+typical ``struct clk_hw`` and other expected functionality. Clocks are tracked by the CCF core rather than through the driver model. This
+port uses ``struct clk_ops`` and allows drivers of any uclass to register clocks. This greatly simplifies the process of porting
+devices that like some phy's which also provide clocks, as it removes the need to declare an additional ``U_BOOT_DRIVER`` for uclass clk.
+
+:doc:`More information, recommendations, and limitations of CCF Full </develop/ccf>`
diff --git a/doc/develop/ccf.rst b/doc/develop/ccf.rst
new file mode 100644
index 000000000000..d910ed44218f
--- /dev/null
+++ b/doc/develop/ccf.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Linux Common Clock Framework
+============================
+
+U-Boot includes an API-compatible port of the Linux CCF. This replaces the traditional
+``UCLASS_CLK`` and aims to simplify platform bringup by allowing straightforward reuse
+of existing Linux drivers.
+
+As a result, there are some important limitations when it comes to using CCF:
+
+1. It is NOT possible to combine CCF clocks with ``UCLASS_CLK`` since neither is aware
+   of the other. When CCF is enabled, the CCF drivers will be used for fixed clocks and
+   the typical ``clk_*`` functions will only work with CCF clocks, essentially making
+   clock drivers that use ``UCLASS_CLK`` unusable.
+2. CCF clocks can't currently be used pre-relocation. CCF expects to manage the entire
+   clock tree (and must in order to properly calculate clock rates) so while it would
+   be possible to probe only the minimum necessary clocks pre-reloc that can still be
+   a lot of associated clock provider logic.
+   There isn't today an ideal solution for this other than minimising/removing the use
+   of driver pre-relocation and relying on earlier bootloader stages to set up the UART.
+3. Similarly, CCF currently isn't supported in SPL although it could be enabled if there
+   is enough malloc space available and dcache is enabled. It may be desirable to add
+   a mechanism for only supporting a subset of clocks and providing "stubs" for parent
+   clocks that are already configured to a good known rate.
+
+Porting Linux Clock Drivers
+---------------------------
+
+By remaining as close as possible to the Linux API, the process of porting Linux clock
+drivers is fairly straightforward. The Qualcomm CCF drivers in ``drivers/clk/qcom/ccf/``
+can be used as an example.
+
+Predominantly, ``UCLASS_CLK`` should NOT be used, instead clock controller drivers should
+use ``UCLASS_NOP`` or another appropriate uclass.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 3c044e679274..382de45221c9 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -32,8 +32,9 @@ Implementation
 
    directories
    bloblist
    bootstd/index
+   ccf
    ci_testing
    commands
    config_binding
    cyclic

-- 
2.55.0

