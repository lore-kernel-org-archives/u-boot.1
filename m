Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A637C88E50
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 08:31:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1ABB4062A;
	Mon, 14 Sep 2026 08:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rr8PAJkulOYj; Mon, 14 Sep 2026 08:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C621940623
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789374713;
	b=Zzlsb/POR8hNHOQKOULnGk5zR24zRKSqr6+ycKm8mHh1WNObIDn1WYH7e0FaP3NdPVH7
	 Qj+c+FYIve36C7KlT2nJj6vtPmztdZXJ6WiYY40rIjkQZyz7RfCWW1/VeOa0X4vt2d1WN
	 X+aTh7Vsm+SdJ6C6e+vygwVs3D/WPi3qWVmo7nGIGXkfMfkGXcWHvdx+YcdL31mcMt/sE
	 warA2Mstbq9hhwPwZlUR0nBV9ZahpUtHHQN2fnMCpw7+11eSuS4dXXbKPI2u4HtvC6YB8
	 eD9/LDrMD3ebRqk7bczjvC2O9LlzuDcunKDAGVOF/8zk2Jl3QZfmBHu3r3q+DHOMUBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789374713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=rpeC2RjIEB3CS9A7FpEAnN/Ol4PK9Hm5SC4os+JS69Y=;
	b=LOkn+rsOPuiqnx3idJ8WxcJITwH/ZDQ+SJfl4dAh/dE/JxWqjblStiiOr0sEb68MSSFv
	 NM9XjwUZFhcXRSFf8w84WC4Us5y8PSFYOYnLM8e5LBMCFcfECgMq5PJRoyAXB3qlYl7GQ
	 geifn+er0f181YVO6oJL1A4P1VRb55GuQHwnTJLWxfjfgC5PQhCdNunJQDx+/Vq1A3caP
	 qV+AB97K8sMupixxIh4SPr4N8+MqQ3jLgi1Y8ZQo2VoaAVPgnbwAk7m+R6U5/4da1Tor1
	 OWtybYuZZcQHvOt/3bYR3TOw3GJB9LqqGWL4tlWt2SeO6/gCEDTcGreHQUnLkXKz/1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789374712;
	bh=rpeC2RjIEB3CS9A7FpEAnN/Ol4PK9Hm5SC4os+JS69Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndVS6Ykv1JPrIYbdfdA0ePqSq3mBpkS1m3gSzKz/W7/zwoAcqQn2DNJh53fTYm5ak
	 WRt9r48XYRxELNF3JTlk1ojPPnV/c1xL7TPUZWayXOLwFrjlPp5MyPJyi1fTwj0Z5e
	 VoArD7AypqoNlrL+Mv1hsEjYSOHnwtIZlIN+1WqbtisxFfM81Lph2aT5YZja/3Ou99
	 twGteDbyIxD35tAibQcwoSx25LXlQXve0rVWt96iWvGFy5TtxSIy/YdaaKUzorheGk
	 0sU3thJsJfb3M9nMZOKelBl3RiZTY2WEDQKOzwtGvY5yBxWEe9yaI5S8ojVea0vu73
	 Ts9bD7t1WVy9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C621940623;
	Mon, 14 Sep 2026 08:31:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 20A2D465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05E3E60664
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDNUvXLPVjy5 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 08:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AEAB360675
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789374707;
 b=WIBVVyEQ51OLzdjDSzPesZ5YYabaPWh4WLt/kdFDiXjysyHRxgbUkntmAOGm3+YrxxO3
 GBILFucNBO+iAiwefd8DVgIcHjkPZx+KQrDnjRIyrAhOBob/HWPgCPSNkw4Nz3ykAl4mp
 vEsSgH2q2VVf9zqXPCYM57bETRQPhtdakqveNaLPY7nYYqnejCWZexpGjC/4EkEKlV0e+
 nnllUuVMyWtsTnIxPmLnUhnDLGG43i5aHq6ZS3dX8alehoy/gMwyfGe+x4N2DsUa6NQAg
 TqVjXBnHurDKkMVuvPgdoNimN5HG0DYaPWV0HxqlEaTd9km7ZQyTvrDbahwVXJ6E9Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789374707;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=rpeC2RjIEB3CS9A7FpEAnN/Ol4PK9Hm5SC4os+JS69Y=;
 b=Bso5NJ4CNzDpMt6sq0rVh7Ythis2CVALO1IMgwTZY/kZwz19q3dCIhTFJYfA1whZaOzV
 5khhWDbmV4iH9EI3RExDbiY8mLqmXyxaeM9U6SKza4Z1YcFTYblfBmhcZN02/rYnVWRic
 L28d2CkhuB3HLwdImGMzIaw2tOI9TJeVqeXn/k3t2R/thU7nqcWp7+gOKOGWuk/pDsTBp
 CRsrd/DAX1I1CrzaN/DMEuS0NLuVjDQ5UENIrES9mojRefzG4/V7fOjUjy+rfJV8SsuNS
 eHZIDS2N8m7YvP4cTtcJThtGObz7ZF4z0izO8PY+vepxYDVGcq7vpruiDi83awUVUIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ZGIAnOZQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ZGIAnOZQ
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AEAB360675
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 08:31:45 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2949ed8cc3so487482466b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789374703; x=1789979503;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rpeC2RjIEB3CS9A7FpEAnN/Ol4PK9Hm5SC4os+JS69Y=;
 b=ZGIAnOZQF6ysKxEyNxbV1sgx1Lq6ynLw1We5qo2I8Fq4IIXIOPkDin6fldgY6t5C7m
 vKnPVvEgBE63DBaCUd9J2V9EftcQAHu6lM5jAjyQJETyi+q7ngdOtrIhtysiUIZWOQdv
 XuXfrFDAaziouxVWCJgj5gHA2LbS13hKxhrjhxZfJ0+hCstgKPyxC6RGF+opZrRxr9Hk
 zwk9BvaFy+BgYBrLI8gKiPYp4AlqsW7k3kcX4mUNaLq9a+DPt9IObIH2svKC91mOYCOn
 kmHd81uji+pp6gBfZBTqTU0UjFJ+0m1n11J9PhywmwNnKpzddiZmLjMawSyBO0Oug7iw
 3YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789374703; x=1789979503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rpeC2RjIEB3CS9A7FpEAnN/Ol4PK9Hm5SC4os+JS69Y=;
 b=IPff+NImHJjYov7IWn/M9i/Tvrq1ZkkAqTyTp7xNyryWvPJUusd5KcRAxTv+4p2YPE
 triDUDjiFIeotoFX7Xo3nK/C3GpGq0bRzydjfC/kXH/TXNWfn+NSzfTpygPO5UBSvAfc
 fWza2QhOdgY+LiB/S41TPhUjGwVs58XxvLPLFWQCnUw1M0EMJJzM3rVk2gwyefZgZJlW
 EOXvWk3oiqTJIq+lpd4LXbrs7nBv6P0nZsbU0E84Tk+udvzV5cnHCp8YEGRXK3+BS9Ql
 +KfLA6xizhngcDkmOvSSaygUaVkLW8BxOlsiW7b+rRjGateJR9Iq1b4MESBXbnJV4UMc
 IIXA==
X-Gm-Message-State: AFuF++lG9A0wSKJUmQ1Lv1HMzQK4VV7EfFfU44e7Dvj8NoeOQwighSQg
 4QUe9u+DtzLR3gO2Qyh3A9jb7R8n9A3KlIOJvmxadazScOfABLSy8o0WLRComF3y3ec=
X-Gm-Gg: AYBFou0OcfV0I5ztZQLqq18UXskC5VnJzlw0XtspOmFfveLDMd+Swc2B6SMtZyD8JRG
 gGXx/hw7DYlpLXe50bq48z1AhoVqpa0LsbOOFCcqldwau7Ked288JadTYIgLnuGeh/GfeKio1y1
 POGYE0qn5kS0JhRPUOFotnhIn1iq05rHsoDKQCp+BA9H77J2LJTCA4Z3YjP+zojppknrwSim+mP
 XVek0Y2ics7SOxi+b12uVC/RquTYQpTmlluSlqcWc5ovW2uwC1PNwfkkuj9QEhsEHZWjVHjtm1a
 rcBJ6Ko+DwMEz3wy0fVE1d3Ovw0VwDn+X8V15WUGQVjT/j5phfYoI8wcvWUv5pqJ2VMAl8eKLgE
 G7eENIwh0hWWTZ54abnlJ4S+pUjPmnxNX5hP9u4u2oc6xeUPWMQ5DPtNjIdhf+jT0h2uy9rj7fL
 9BVfdxOfTu6odPUCmc9OVbgXy5POj1I/6K78/EaAlRctlHm99AXodSmn4TUD54DlR5RWiiMENP9
 LP5eri9Gyuc74xOvQ9KvNe5AUAQ0OfRsQcuZvWqOMKBIQHLNuV7Ln1NdhO8iYGS3q3dpNbkl+GH
 heweNn5TL4otMy8=
X-Received: by 2002:a17:907:72c6:b0:c26:19de:912d with SMTP id
 a640c23a62f3a-c29b86f1ac8mr110725666b.32.1789374703233; 
 Mon, 14 Sep 2026 01:31:43 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c296598e8b0sm383944166b.0.2026.09.14.01.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 01:31:42 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 14 Sep 2026 10:31:38 +0200
Subject: [PATCH v3 2/2] spl: mmc: make raw partition selection a choice
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ccaione-upstream-part-dynamic-v3-2-a38c19e74563@baylibre.com>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
To: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Boards using boot metadata should not have to configure an unused fixed
partition number. Make board-selected partitions an alternative to fixed
numbers and partition types in the existing raw-location choice.

Keep the selection policies together so the MMC loader only has to select
a partition and load it. Selection failures in dynamic mode must stop the
MMC attempt instead of falling back to an unrelated filesystem partition.
Existing fixed-number and partition-type fallback behavior is preserved.

Distinguish shared partition-loading support from settings specific to
partition-number modes. This keeps existing platform defaults and guards
while allowing dynamic selection to use the same partition loader. The
STM32 fixed override remains conditional on its static partition setting.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/mach-k3/r5/Kconfig          |  4 +-
 arch/arm/mach-stm32mp/stm32mp1/spl.c |  2 +-
 common/spl/Kconfig                   | 13 +++++++
 common/spl/spl_mmc.c                 | 73 +++++++++++++++++++++++++-----------
 include/part.h                       |  3 +-
 include/spl.h                        | 16 +++++---
 6 files changed, 80 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
index 12335880e10..672c8a226df 100644
--- a/arch/arm/mach-k3/r5/Kconfig
+++ b/arch/arm/mach-k3/r5/Kconfig
@@ -35,7 +35,9 @@ config K3_SYSFW_IMAGE_MMCSD_RAW_MODE_SECT
 
 config K3_SYSFW_IMAGE_MMCSD_RAW_MODE_PART
 	hex "MMC partition to load SYSFW firmware and configuration blob from"
-	depends on K3_LOAD_SYSFW && SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+	depends on K3_LOAD_SYSFW
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION || \
+		   SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
 	default 2
 	help
 	  Partition on the MMC to the combined System Firmware and configuration
diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index 2229ebf5eeb..c1be468cb1d 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -61,7 +61,7 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return MMCSD_MODE_RAW;
 }
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
 int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	switch (boot_device) {
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 0618f42c941..56375ef287d 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -574,8 +574,21 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	  raw mode. U-Boot will be loaded from the first partition of this
 	  type to be found.
 
+config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
+	bool "MMC raw mode: by board-selected partition"
+	select SPL_LOAD_BLOCK
+	select SPL_PARTITIONS
+	help
+	  Select the partition at runtime instead of using a fixed number.
+	  The board must implement spl_mmc_boot_partition().
+
 endchoice
 
+config SYS_MMCSD_RAW_MODE_U_BOOT_USE_ANY_PARTITION
+	def_bool SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION || \
+		 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE || \
+		 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
+
 config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	hex "Address on the MMC to load U-Boot from"
 	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 3e637f5adbd..8f4df4104ca 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -106,18 +106,14 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	return 0;
 }
 
-#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-    defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
-static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
-					struct spl_boot_device *bootdev,
-					struct mmc *mmc, int partition,
-					unsigned long sector)
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_ANY_PARTITION
+static int spl_mmc_select_partition(struct mmc *mmc, const u32 boot_device,
+				    int *partition)
 {
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
 	struct disk_partition info;
-	int ret;
+	int type_part, ret;
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
-	int type_part;
 	/* Only support MBR so DOS_ENTRY_NUMBERS */
 	for (type_part = 1; type_part <= DOS_ENTRY_NUMBERS; type_part++) {
 		ret = part_get_info(mmc_get_blk_desc(mmc), type_part, &info);
@@ -125,11 +121,40 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 			continue;
 		if (info.sys_ind ==
 			CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE) {
-			partition = type_part;
+			*partition = type_part;
 			break;
 		}
 	}
+
+	return 0;
+#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC)
+	int ret;
+
+	if (*partition != -1)
+		return 0;
+
+	*partition = spl_mmc_boot_partition(mmc, boot_device);
+	if (*partition > 0)
+		return 0;
+
+	ret = *partition < 0 ? *partition : -EINVAL;
+	printf("spl: partition selection failed: %d\n", ret);
+	return ret;
+#else
+	if (*partition == -1)
+		*partition = spl_mmc_boot_partition(mmc, boot_device);
+
+	return 0;
 #endif
+}
+
+static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
+					struct spl_boot_device *bootdev,
+					struct mmc *mmc, int partition,
+					unsigned long sector)
+{
+	struct disk_partition info;
+	int ret;
 
 	ret = part_get_info(mmc_get_blk_desc(mmc), partition, &info);
 	if (ret) {
@@ -300,10 +325,15 @@ u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return MMCSD_MODE_RAW;
 }
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC)
 int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
 	return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
+#else
+	return -ENOSYS;
+#endif
 }
 #endif
 
@@ -429,11 +459,10 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 						spl_mmc_raw_uboot_offset(part));
 		if (!ret)
 			return 0;
-#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-      defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
-		if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) &&
-		    raw_part == -1)
-			raw_part = spl_mmc_boot_partition(mmc, bootdev->boot_device);
+#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_ANY_PARTITION)
+		ret = spl_mmc_select_partition(mmc, bootdev->boot_device, &raw_part);
+		if (ret)
+			return ret;
 		ret = mmc_load_image_raw_partition(spl_image, bootdev,
 						   mmc, raw_part,
 						   raw_sect);
@@ -462,17 +491,19 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 int spl_mmc_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev)
 {
+	int raw_part = 0;
+
+	if (IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) ||
+	    IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC))
+		raw_part = -1;
+
 	return spl_mmc_load(spl_image, bootdev,
 #ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
 			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 #else
 			    NULL,
 #endif
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION
-			    -1,
-#else
-			    0,
-#endif
+			    raw_part,
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 			    CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR);
 #else
diff --git a/include/part.h b/include/part.h
index 15daacd7faa..5268216b46d 100644
--- a/include/part.h
+++ b/include/part.h
@@ -462,8 +462,7 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SPL_FS_SQUASHFS) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_ANY_PARTITION)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL
diff --git a/include/spl.h b/include/spl.h
index 08a84536f51..d05623caaf6 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -599,13 +599,17 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device);
  * @boot_device:	ID of the device which the MMC driver wants to load
  *			U-Boot from.
  *
- * Called before loading U-Boot in raw partition mode, after any Falcon
- * attempt. The hook may select the hardware area containing the image;
- * it must leave that area selected. It may run for each MMC load attempt.
+ * Called in fixed-number or dynamic mode after any Falcon attempt. The
+ * incoming hardware area is not necessarily the user area. The hook must
+ * leave the image area selected for loading and any configured filesystem
+ * fallback; the loader does not restore it. It may run for each MMC attempt.
  *
- * If not overridden, it is weakly defined in common/spl/spl_mmc.c.
+ * The default returns the configured partition, or -ENOSYS with
+ * CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC. In dynamic mode,
+ * zero or a negative error aborts this MMC attempt without filesystem
+ * fallback; SPL may still try other boot devices.
  *
- * Return: Partition number to load U-Boot from.
+ * Return: Partition number (positive in dynamic mode), or a negative error.
  */
 int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device);
 
@@ -975,7 +979,7 @@ int spl_mmc_load_image(struct spl_image_info *spl_image,
  * @param bootdev	Describes which device to load from
  * @param filename	Name of file to load (in FS mode)
  * @param raw_part	Partition to load from (in RAW mode), or -1 to call
- *			spl_mmc_boot_partition() in partition-number mode
+ *			spl_mmc_boot_partition() in fixed-number or dynamic mode
  * @param raw_sect	Sector to load from (in RAW mode)
  *
  * Return: 0 on success, otherwise error code

-- 
2.55.0

