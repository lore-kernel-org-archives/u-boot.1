Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67796C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 16:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 38FA060BCB;
	Thu, 24 Sep 2026 16:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfBXTSIKIjIz; Thu, 24 Sep 2026 16:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D3A2C60BBC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790266391;
	b=iCaXQxzLzA2vH0/RZj4UDfFeOHclQ13DXiXnRfRA700ylBuvjPPoO8+sRAN+XKZiXV2j
	 jfWjYEej2L57vSh+7eeb7TPjvC3wcLSTt5qcO5kubv7OnhX3k9iY+jWFyif5oqfoE1pqp
	 S3fQUUcppRn7cFfRinkIP7bPY3PxaGmDBFnAXJLRAki0K/T0OR4bPxJLvnzm5MuaqEDKl
	 +O4FoaOUT5wnz7PVzzPl/b3uCXYE+VFlikvJmq04JbiESbnsko//x6A7iwzNFi8jZ8iQ6
	 MioHoyznBbAdNeukL+gsHeIdWhinsZPhbjrj50ZilvTDZdN7hxU3gKaHNhoAVXkhCgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790266391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZO4WaAOjfuhf3KA/BSHYvtLRA+Bq+tf3pI6057tOPMA=;
	b=NVWObGXIrpIgaY5EyfBtEXxf58DwXbP+OcWdAzKNDUQA3Im+g6BB6b8E9GBWcbG64okq
	 Td93lvaIIdCZV5OulAL72Xyi9HSzswnqNWbhKVKNdK9Ex4lKNmu/US7UhkKpCET9DOH4k
	 mYYqCr8MCwGLURc21AfERyQ9iTtiSg9tX55c5rz28n5avQqrFI3Ws1Sd8bpVBpNwRE6yV
	 J00tXbIsuGcDKF/DVOpS/+Q43eAnwXEjuBGLQjUun3N+0eAaNdChsC45wXtTmj1tzNqrS
	 NCbfeaX7dKtu/jPCXTZa7JXekiBktV6WMAeA83f2RB5HK+YpBaEz9QCGe+nQ9AA5y6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790266391;
	bh=ZO4WaAOjfuhf3KA/BSHYvtLRA+Bq+tf3pI6057tOPMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LE3JJUm9xzv18rKKxcA5th52orAX0iLOfd9jpu+1jGLM87SyK9qZunRq4hdOQ/XjN
	 0RXnY2TdFHErWO05BjqQxREtUFzGMX14vuRWEqwGkp/Flu27Z3sx72/kStp6blQA0S
	 Sde+uGeleBMlBhDO5MaYIdFPxCv9OgSyoa6KbPjjrB3r6tG3a2yhSJH/hnrt1ivarD
	 1G41LJQ9VClO8ILalOQtbTDucjZNc4Kpu+q30HOieW48kkZA1ml6erKLRV1atf8yOY
	 BSHLcbZjJrrE0yS1/yXtfUggmqxfmTiIuWQly9jukgZnax1t2DNB1JhEqvxMcJdyGR
	 mwGFQBSDxECNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3A2C60BBC;
	Thu, 24 Sep 2026 16:13:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C3B493B7
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B51F1407FA
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txXeC_MNcTgP for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 16:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DCD4040765
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790266382;
 b=rebUGmDOOAK44c5mJmqgV+M5OexWUWokfuszdv3pz39uUYAR5/Rxx0t4oMbOrqFrmXRQ
 sljiS0ZtPMXpQEZIO/jFEIqRW07wtilQcKTjTDKshGcHOruKLTk5B2pYGo66cWKidaxuH
 PWzn8v92SpHnAs6sxP+omA8gs3BcRpcOTMZzk64nnBHq6EtFeWSBTBh+rd4LWqU+PQemR
 +jP9Kl17wSJBxyY9JlP4P4a28us11gXel+7nudKy5/3l/0hYtxkePyUdhcslzpuD5XgNb
 q5YwLIV2XVUR37D3j5bWnWBVB4vb2o1s5IbbLSdTsaxPC59zAPO1VgoTeuqtkhWsPPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790266382;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=ZO4WaAOjfuhf3KA/BSHYvtLRA+Bq+tf3pI6057tOPMA=;
 b=Yq0N/CZ3geUcR25VA2d7vTlAoavpwwnIVhZei1vIMWr+2cCvpPQaXVXC1wgEzVkohUOE
 muZWd9kt+6jf+HEnYjJr4Z13QuQIdkGf+CsBSnFnAR020Ra55oFP6nZQPyfJTP3Fe7tCS
 Vl2UxsssrJl1sTH5Dn2iGHCfNECyhAGA3juGh84Pjn2lYhZzsmlHv32tBNYdfWwKYICEs
 BmA4C5b6mSPMESPhdNTUMncb68DDPL4SzAHutRNyCf2jp57SBPcqy+z0IHNabBJ/n1Q9I
 YtFRie53wvhYR2nsdU8bK98UAOCeKILjOgw5L+i9YxAdqtGOB/i/T8e32Fl+pUK0chw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=collabora.com; 
 dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256
 header.s=mail header.b=LVHDE19h; 
 arc=none smtp.remote-ip=148.251.105.195
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.251.105.195;
 helo=bali.collaboradmins.com; envelope-from=arnaud.ferraris@collabora.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.a=rsa-sha256 header.s=mail header.b=LVHDE19h
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCD4040765
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790265773;
 bh=jEiPB/yZneEd/LbiMmTbdAeAz8LdBcdKaY4/VXmPcQ0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=LVHDE19h91XyyoF8cLt04j1B/5umAVqzTlLPI73eXjdaf+fkG9UKwhkO33M8HPVBQ
 XQjvIRy+M75sThpGcfibxaD1KIS9GQepHN6D0pFGHoblapgiDf7Q7NCKyoo05m1DSB
 9p1V/brTjihRRZvIQECePnTzgi3s9JDKeslJkYqa81du6TQxTYKaPvZ5kMMyxAYQYs
 NyKcp9hkkdxEeDBCRuKXHGifRXltjaZMdgCz511X8+hTBLLuIBVWWdHTtDlifRm3Hc
 GfqKzItHmqFWO0AErxU+IKas22RlP77V6LHIMnkYjfGqoAKRgMeOXbv7ZUUcUYJbSc
 ELVTnxvCXAG5Q==
Received: from johnny.home (unknown [100.64.1.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: aferraris)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 414B717E0A68;
 Thu, 24 Sep 2026 18:02:52 +0200 (CEST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Thu, 24 Sep 2026 18:02:50 +0200
Subject: [PATCH 2/3] drivers: power: pmic: add driver for MediaTek PMICs
 over SPMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-mt8196-spmi-v1-2-dd2263403691@collabora.com>
References: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
In-Reply-To: <20260924-mt8196-spmi-v1-0-dd2263403691@collabora.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Guodong Xu <guodong@riscstar.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=jEiPB/yZneEd/LbiMmTbdAeAz8LdBcdKaY4/VXmPcQ0=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBqtUmp2eheHWwQqAVZYqK3wAWh766rtAcsXCTit
 xLkwga/kpmJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCarVJqQAKCRDT67WWa7mR
 lv24D/9Rn5mrV4oxfrXHWvEA8HgJNCgt29zuNN+90pq1AaOvPtAbARVcen4UDWNaQtYSUawUsPo
 HoH6xDNhOfhQxvr6NpGjwxNJGwOuaGcNxzhlS6pSj29uFjN2lvJWdxbUUW7ZX12rnL0KA5sgx0g
 WniNs/Udq+9BTlC3z5EJO2eYCHSGMSHjSJfQFxRPeibA7bxsbAOREScRHMaNVIAkA4718gFFXzd
 eMLnjiet1FWN+YZMotBpCe7ur08wB/dHVPK+0wheoAmaLpxTAyoYTcp/V1XCMlNy1mPM2hv9IHP
 a5z5DcLlg+vbFMIGF+wW8V1aMtQRJ/P9H+nV6ZwoQ0ZN2zL5nZtoZswYoHmoURpmkRn0DhPP9ex
 c4l8BaY0pluq0EGQ9sKIGahipFfenT0SEtWeuj2lduiAT4z8P4f1YtUOVyEaqUEtmEeAVCnyIQL
 agyHU7QgaXg66Jovfh2DXJl/XATZZOAqNAEsnFkDA7eT+1CWkXQhRNbY4SMtEA6Dp9B4JmiMaek
 7B7gluWDbomxLON18MfJleEYLB64WA3jR0X6zwQCUI7ULZf/lYLAqcogeyfEadvZYRnfyw/UqgE
 HkQYdOl1HYO046p4/XOA+Zom/mBT6mj+0dr5QdWieBk/fXLirnAF1KSi06hIC4pdB45ekprzElk
 WFS0tircWDmPI1Q==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

This driver acts mostly as an interface between PMIC/regulator devices
connected to MediaTek SoCs over SPMI, providing read/write functions to
those devices.

It has been successfully tested with the MT6373 PMIC but should work
just as well with other PMICs as long as the corresponding compatible
string is added to the driver.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 drivers/power/pmic/Kconfig    |  6 +++
 drivers/power/pmic/Makefile   |  1 +
 drivers/power/pmic/mtk-spmi.c | 88 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 95687d0bdfd..8f35dfdea84 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -464,6 +464,12 @@ config DM_PMIC_MTK_PWRAP
 	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
 	  hardware to connect the PMIC.
 
+config DM_PMIC_MTK_SPMI
+	bool "Enable driver for MediaTek PMIC Support over SPMI"
+	help
+	  Say yes here to add support for controlling MediaTek PMICs using the
+	  SPMI bus.
+
 endif
 
 config PMIC_TPS65217
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index da9b810de90..a6a16b90bc6 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 obj-$(CONFIG_$(PHASE_)DM_PMIC_CPCAP) += cpcap.o
 obj-$(CONFIG_DM_PMIC_MTK_PWRAP) += mtk-pwrap.o
+obj-$(CONFIG_DM_PMIC_MTK_SPMI) += mtk-spmi.o
 
 ifeq ($(CONFIG_$(PHASE_)POWER_LEGACY),y)
 obj-$(CONFIG_POWER_LTC3676) += pmic_ltc3676.o
diff --git a/drivers/power/pmic/mtk-spmi.c b/drivers/power/pmic/mtk-spmi.c
new file mode 100644
index 00000000000..39895bf9c0d
--- /dev/null
+++ b/drivers/power/pmic/mtk-spmi.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MediaTek generic PMIC driver
+ *
+ * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ * (C) Copyright 2026 Collabora Ltd
+ * Author: Arnaud Ferraris <arnaud.ferraris@collabora.com>
+ */
+#include <dm.h>
+#include <power/pmic.h>
+#include <spmi/spmi.h>
+
+#define REG_MASK 0xFFFF
+
+struct pmic_mtk_priv {
+	u32 usid; /* Slave ID on SPMI bus */
+};
+
+static int pmic_mtk_reg_count(struct udevice *dev)
+{
+	return 0xFFFF;
+}
+
+static int pmic_mtk_write(struct udevice *dev, uint reg, const u8 *buff, int len)
+{
+	struct pmic_mtk_priv *priv = dev_get_priv(dev);
+
+	if (len != 1)
+		return -EINVAL;
+
+	return spmi_reg_write(dev->parent, priv->usid, /* pid */ 0, reg & REG_MASK, *buff);
+}
+
+static int pmic_mtk_read(struct udevice *dev, uint reg, u8 *buff, int len)
+{
+	struct pmic_mtk_priv *priv = dev_get_priv(dev);
+	int val;
+
+	if (len != 1)
+		return -EINVAL;
+
+	val = spmi_reg_read(dev->parent, priv->usid, /* pid */ 0, reg & REG_MASK);
+
+	if (val < 0)
+		return val;
+	*buff = val;
+	return 0;
+}
+
+static struct dm_pmic_ops pmic_mtk_ops = {
+	.reg_count = pmic_mtk_reg_count,
+	.read = pmic_mtk_read,
+	.write = pmic_mtk_write,
+};
+
+static const struct udevice_id pmic_mtk_ids[] = {
+	{ .compatible = "mediatek,mt6373" },
+	{ }
+};
+
+static int pmic_mtk_probe(struct udevice *dev)
+{
+	struct pmic_mtk_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	/*
+	 * dev_read_addr() can't be used here because the reg property actually
+	 * contains two discrete values, not a single 64-bit address.
+	 * The address is the first value.
+	 */
+	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
+	if (ret < 0)
+		return -EINVAL;
+
+	debug("usid: %d\n", priv->usid);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(pmic_mtk_spmi) = {
+	.name = "pmic_mtk_spmi",
+	.id = UCLASS_PMIC,
+	.of_match = pmic_mtk_ids,
+	.bind = dm_scan_fdt_dev,
+	.probe = pmic_mtk_probe,
+	.ops = &pmic_mtk_ops,
+	.priv_auto	= sizeof(struct pmic_mtk_priv),
+};

-- 
2.53.0

