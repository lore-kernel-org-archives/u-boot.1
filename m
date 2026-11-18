Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69738606A33A
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wa+Fc9af;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hbqsLscW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 425D7812B3;
	Wed, 18 Nov 2026 23:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gARu2XKsCv2g; Wed, 18 Nov 2026 23:20:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BCD1812AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044038;
	b=ACKVLP/CKO3En5fIfi3hav59XsX2QabexNjakMNzI3MlrozrQkbSko/XXuAKNeao2U92
	 RfF/3cBNyD6FFnxSj2dT+soLwhrQM1PkTXpxi3WBKdiNEBG2Hms5waMmxHq1axSqZp0uj
	 Xyt2iNPoeRPW1rONoLVF+SucxXWzM6r7zTDMaGGi4/Ui7BT72KPOYsC3jGCKSjuFjPpS0
	 loEe/gGAD1lRC9avXbUvQgtTTKQqe3+KbIb++r4ULLi7WV91V4oS1k0DmqJtzV9OT8Ioe
	 PYuZ9a72dYEpbbSzXA4huSetWLcjh9wvi+xZBEC703HMitZqaN+gpRUCGHfnObBez+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IVb9lOltYgsUTaQURpecwzv/3VOmMD+in/aFWD720dM=;
	b=p33/3aPftTaebOu8kVbpHNVr5W/yeGklM2ssDc8pdAhcl9u/lnf9CDSQrFfG6unlEClL
	 6Igjlv1oTuAzEqNbOT98JbUGVJUYeQ+7R2CsaoWgCT3qgSAoscWUOiovJDkr7Y9oOSFrX
	 wmSyo13bK97h+CcC3/JJtFbtltazbpCw1RTh3rxWiIx4LSIew9VNjXSMAuB0XyZBU4cfb
	 YJKuFp6qI1Hp+q7Jec5UnTtrLzUJktE8VxomdW5MnlHEfbZBZUi79SGW+yJ2b8JKhx0fY
	 GFFeRbHSvIZiPoWJo8N+7DpWpDQD6WoLv98RrW/k5u4ASK6cgZqdJBuMxgtHhe+2ROA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044038;
	bh=IVb9lOltYgsUTaQURpecwzv/3VOmMD+in/aFWD720dM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wa+Fc9afHgGROhe2N97meeCWpKh3GirQPdDVjTmUvfvFOrtRhH05zEUTeVZDBMmsz
	 GEtiokrewFFL3mcFxihVgIqPUw6iax4jt+I3pGDLYeNsqMGveYtLivXONmCSwMeJfO
	 sPZDSThZJ7zw6awkvGgr6s1aDAftQBeZeqDUHpWEWAHGUDpfMUT1BSjGPAP6I5UOut
	 CYkUabsz2LvxpMKoQkabs9eKOwInQvx07/au0D1MdGnFRLEhJeckdWY9B0+F+ip7/O
	 /V/Euv/7bqEobushMnI7fvV+HvifMONW2u3pLr00uj3Tm6RMDRAHOeFoOJqL5kdRRU
	 LdxjQcGixDFUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BCD1812AC;
	Wed, 18 Nov 2026 23:20:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B266422B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 979A8409AD
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhBr_Gi-NgtK for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3DEB40938
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=hbqsLscW
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3DEB40938
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:34 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6df5e315bd1so1296421eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044033; x=1795648833;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IVb9lOltYgsUTaQURpecwzv/3VOmMD+in/aFWD720dM=;
 b=hbqsLscWWjVYxrMrBOvx0R9dqELqlfng0+OlfwC+pvvaJAFLa5ZyEjqeY7f6CM/F1y
 5WPbRvDIoiYWrrTr0/SmqDheL1nFNbKOM3Jmde8SeSI/XyqJ0Kzp/3JoO21KQc0RVUIm
 sF3kwZDYyxXmKggCniqCExgQQW0XDNEuXmCtWNkcrpis2aZs+cxVmlBGxAKsEqGwbg2r
 3jRaibA+tg+sK/8SvdxmQGxJbfUm3WPOGcgHdyK4IOHXSVyTq+j8mY6Lq/9Jyu5tagc8
 QUdHAN4HcwrBJ9HNwXaAZJwkydW/pdzSd9oMGqL3SIWcandlMfPMExGOZqHsqe8f8xXT
 y0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044033; x=1795648833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IVb9lOltYgsUTaQURpecwzv/3VOmMD+in/aFWD720dM=;
 b=ET0QItJ65YrL5O2ptEB049wg1ji/aLUFKnLmNsMGN1y3itsjQqc63Tq5bxalVYM5uN
 nAvuZWuy6nYB1K1FhGQ+u1QOYTMZiVc8JjsQOf/TbbnNCA2ekl324O9qENsas3DuMRDo
 UiqYEZbhBrXd2Ny6PBXj/MuSQVGO4MkT5qZCioknxEPehJF6i3F9NmLOc3geKinSpeVh
 TyPongyZMcYnRlHposzyl0T/Qz4kLC1juMdw3YgRrkc+Ah4F6XeyH6TrXXYIgmb8zL02
 qHAvmrAjuAmzYSnHoyTwH5G3n/p2TYiBes9djqY6/kBkB5wmYOoLWaz1+QivxFGwtPFO
 P8qQ==
X-Gm-Message-State: APuU4Z+0U7JLj3YFyBLCySeEm/p5PduYAw+y8qIn81rdRhyMRAeARKn6
 981PIPj5GZCaNqamzYIrOoitUIJJmnFwhaiTj6oG9ETT5WQfMMcfFflPKMsR4CbQpz4e7Mca9N1
 gGMErjWU=
X-Gm-Gg: AYBFou3vvyX2lzU+9UOxlgkBh9wKIdIV+DEYvYpYLzChVmxYzAN/kS7+U48OAJwPZdi
 qZhNVagai682nT9t0lR07Z1gbQd70RPZxbE/otjSVT7FvysccvsKNTb1razxXvD7LiTVVhXtK4u
 +dQpOa4LqWAO7PCyGRyx4Aie3Tf/H6kWmKHy1bkswkK5sg/h4vWty9nkI/bS0lgaEJTpYoVz7+y
 ivu7RiUS6VSxlu593OKJeKyVgh10ewhUJlaA3cSF1/ccLH3xtWUEuEhxigJQ8nIxhWm4/VOdgaa
 UD1EPYczQYvgNv38ra6TkmcysjigTzig35AYlycfT8xucje5ADRiDxQbd+0IYEIYvgjxQLUy/jU
 QbHPXnjeP/BMHhxl8NY8hrhH/Zoay/qqOIxcOfLdnsYt3c3UjePVrWJFtUCFtOYTjjoI3V0yTLQ
 cUy1vtANoCXCWpFI28QbcWeKeTkuT6Le1nMvwKG3xcXo+ZhtvDVJfSxswyBVCXfkmUfpd7UMfUY
 OC052tXyvJYdjtcuNUviMQEpkLoqWfTJoa7BnBOCn7/T7X7cYwEjwaCjaVYLtC0/E62ubZ1lmoD
 9+F7U6KHUfxz8dbzYJIEEW7Kcs7StsiF2WjzFf+zPAel58aYjGefHZs=
X-Received: by 2002:a05:6820:f02d:b0:6f8:8385:52a with SMTP id
 006d021491bc7-71b1858455cmr3901073eaf.58.1795044033404; 
 Wed, 18 Nov 2026 15:20:33 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:31 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:05 -0600
Subject: [PATCH 6/7] board: mediatek: turn the Genio 510/700 download
 agents into fragments
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-6-1505d27fdfcb@baylibre.com>
References: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
In-Reply-To: <20261118-mtk-genio-one-defconfig-per-soc-v1-0-1505d27fdfcb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11501;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=9a8freYuvpi7TuysegdvgAl9xxRpsQ3SHAYRrl4t/Yw=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKhal8bVxXdxZC9Fg0SOx1Ub+PsavF2a1/av
 DoiPDxR7rWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4yoRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AiC0H/imr9PS3TWl0ikvq0VZGiegoIvciaS42KDRpC3P
 jDkKH+Tta7Ep7DPo2yRm/AwJWx4weh13aCELNLp9yEQTsJjB/gYsS1RsydkUozJTqvfqYOFFNYd
 1/Mb93YNbxdp8LtvwzkV/NZAh1p2JErjeS5DMd0ebWgjQIl3x+iCveWIOUoUH6/SHR8cmWULxZ9
 RkFUAVUYsHqCYUqr4fnAlne1NX25yifhsf/fNyzlU+0v4+m1/d1GKrm9aphs/7z/yKcBeA+XpZM
 GLMMa64/TwvzW2We5DgKudfRG2aJjTTsjlm6zNU3S4ffK6Ry/bc3DzPwM/iPHStLwB32oClSK3J
 Qi4s=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the four Genio 510 and 700 download agent defconfigs with two
configuration fragments, mt8188-genio-da-spl.config and
mt8188-genio-da-uboot.config, which are merged on top of the board
defconfig.

The download agent defconfigs only combined a board defconfig with a
shared fragment, so each download agent mode needed one more defconfig
per board. Fragments passed to make are looked up under board/ and do
not support #include, so move them to board/mediatek/ and fold the
shared USB settings into each one.

A fragment is merged onto the already resolved board .config, so
options that the board gets indirectly (mostly through BOOTSTD_FULL)
stay enabled when the fragment disables what they depend on. Disable
them explicitly in the U-Boot download agent fragment to keep it small.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS                         |  1 +
 .../mediatek/mt8188-genio-da-spl.config            | 16 +++--
 board/mediatek/mt8188-genio-da-uboot.config        | 71 ++++++++++++++++++++++
 configs/mt8370-genio-da-uboot-fastboot.config      | 29 ---------
 configs/mt8370-genio-da.config                     | 12 ----
 configs/mt8370_genio_510_evk_da_spl_defconfig      |  2 -
 configs/mt8370_genio_510_evk_da_uboot_defconfig    |  2 -
 configs/mt8390_genio_700_evk_da_spl_defconfig      |  2 -
 configs/mt8390_genio_700_evk_da_uboot_defconfig    |  2 -
 doc/board/mediatek/mt8188-genio-evk.rst            | 17 +++---
 10 files changed, 94 insertions(+), 60 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 5c2f5e7852e..c0ca788555e 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -38,6 +38,7 @@ F:	arch/arm/dts/mt8370*
 F:	arch/arm/dts/mt8390*
 F:	arch/arm/dts/mtk-genio*
 F:	board/mediatek/genio-boot-images.config
+F:	board/mediatek/mt8188-genio-*
 F:	configs/mt8188.config
 F:	configs/mt8370*
 F:	configs/mt8390*
diff --git a/configs/mt8370-genio-da-spl-fastboot.config b/board/mediatek/mt8188-genio-da-spl.config
similarity index 59%
rename from configs/mt8370-genio-da-spl-fastboot.config
rename to board/mediatek/mt8188-genio-da-spl.config
index a1c7d8d3d8e..5d9acffefc0 100644
--- a/configs/mt8370-genio-da-spl-fastboot.config
+++ b/board/mediatek/mt8188-genio-da-spl.config
@@ -1,5 +1,15 @@
-#include <configs/mt8370-genio-da.config>
-
+# Build the Genio 510 and 700 EVK BootROM download agent, which runs USB
+# fastboot in SPL to provision the eMMC. Use with the board defconfig, for
+# example:
+#   make mt8390_genio_700_evk_defconfig mt8188-genio-da-spl.config
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
+CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
+CONFIG_FASTBOOT_BUF_ADDR=0x65000000
+CONFIG_FASTBOOT_BUF_SIZE=0x15000000
 CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT=y
 # Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
@@ -8,7 +18,6 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 # Resume from the user-area FIT after fastboot continue.
 CONFIG_SUPPORT_EMMC_BOOT_OVERRIDE_PART_CONFIG=y
 CONFIG_SYS_MMCSD_RAW_MODE_EMMC_BOOT_PARTITION=0
-CONFIG_SPL_MMC_WRITE=y
 CONFIG_SPL_PHY=y
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
@@ -16,6 +25,5 @@ CONFIG_SPL_USB_MTU3=y
 CONFIG_SPL_FASTBOOT=y
 CONFIG_SPL_FASTBOOT_REBOOT=y
 CONFIG_SPL_FASTBOOT_FLASH_MMC=y
-CONFIG_SPL_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_SPL_FASTBOOT_MMC_BOOT_SUPPORT=y
 CONFIG_SPL_FASTBOOT_MMC_USER_SUPPORT=y
diff --git a/board/mediatek/mt8188-genio-da-uboot.config b/board/mediatek/mt8188-genio-da-uboot.config
new file mode 100644
index 00000000000..99f4d4c4925
--- /dev/null
+++ b/board/mediatek/mt8188-genio-da-uboot.config
@@ -0,0 +1,71 @@
+# Build the Genio 510 and 700 EVK BootROM download agent, which runs USB
+# fastboot in U-Boot proper to provision the eMMC. Use with the board
+# defconfig, for example:
+#   make mt8390_genio_700_evk_defconfig mt8188-genio-da-uboot.config
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
+CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
+CONFIG_FASTBOOT_BUF_ADDR=0x65000000
+CONFIG_FASTBOOT_BUF_SIZE=0x15000000
+CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT=y
+# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_CMD_FASTBOOT=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
+CONFIG_SPL_MAX_SIZE=0x25000
+CONFIG_SPL_CRC32=y
+CONFIG_SPL_GZIP=y
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
+CONFIG_BOOTDELAY=0
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_ENV_IS_NOWHERE=y
+# CONFIG_ENV_IS_IN_MMC is not set
+# CONFIG_BOOTSTD_FULL is not set
+# CONFIG_CMD_BOOTFLOW is not set
+# CONFIG_EFI_LOADER is not set
+
+# The board .config this fragment is merged onto already has these enabled
+# (mostly through BOOTSTD_FULL), and disabling BOOTSTD_FULL above does not
+# undo that. Disable them explicitly to keep the download agent small.
+# CONFIG_BOOTMETH_SCRIPT is not set
+# CONFIG_BOOTSTD_DEFAULTS is not set
+# CONFIG_CMD_BOOTDEV is not set
+# CONFIG_CMD_BOOTMETH is not set
+# CONFIG_CMD_BOOTSTD is not set
+# CONFIG_CMD_DHCP is not set
+# CONFIG_CMD_EXT2 is not set
+# CONFIG_CMD_EXT4 is not set
+# CONFIG_CMD_FAT is not set
+# CONFIG_CMD_FS_GENERIC is not set
+# CONFIG_CMD_MII is not set
+# CONFIG_CMD_PART is not set
+# CONFIG_CMD_PING is not set
+# CONFIG_CMD_PXE is not set
+# CONFIG_CMD_VBE is not set
+# CONFIG_DOS_PARTITION is not set
+# CONFIG_ENV_VARS_UBOOT_CONFIG is not set
+# CONFIG_FS_EXT4 is not set
+# CONFIG_FS_FAT is not set
+# CONFIG_HUSH_PARSER is not set
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_LAST_STAGE_INIT is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SUPPORT_RAW_INITRD is not set
+# CONFIG_VIDEO_ANSI is not set
diff --git a/configs/mt8370-genio-da-uboot-fastboot.config b/configs/mt8370-genio-da-uboot-fastboot.config
deleted file mode 100644
index d5766c34e25..00000000000
--- a/configs/mt8370-genio-da-uboot-fastboot.config
+++ /dev/null
@@ -1,29 +0,0 @@
-#include <configs/mt8370-genio-da.config>
-
-CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT=y
-# Sparse writes need an 8 MiB DMA buffer in addition to the fastboot state.
-CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_CMD_FASTBOOT=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
-CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
-CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_LOAD_FIT_ADDRESS=0x41000000
-CONFIG_SPL_MAX_SIZE=0x25000
-CONFIG_SPL_CRC32=y
-CONFIG_SPL_GZIP=y
-# CONFIG_SPL_MMC is not set
-# CONFIG_SPL_LIBDISK_SUPPORT is not set
-# CONFIG_SPL_EFI_PARTITION is not set
-# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
-CONFIG_BOOTDELAY=0
-CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="fastboot usb 0"
-CONFIG_ENV_IS_NOWHERE=y
-# CONFIG_ENV_IS_IN_MMC is not set
-# CONFIG_BOOTSTD_FULL is not set
-# CONFIG_CMD_BOOTFLOW is not set
-# CONFIG_EFI_LOADER is not set
diff --git a/configs/mt8370-genio-da.config b/configs/mt8370-genio-da.config
deleted file mode 100644
index 46cb42b37ba..00000000000
--- a/configs/mt8370-genio-da.config
+++ /dev/null
@@ -1,12 +0,0 @@
-# USB identity and transfer buffer shared by both download-agent modes.
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_PHY=y
-CONFIG_PHY_MTK_TPHY=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_USB_MTU3=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_VENDOR_NUM=0x0e8d
-CONFIG_USB_GADGET_PRODUCT_NUM=0x201c
-CONFIG_FASTBOOT_BUF_ADDR=0x65000000
-CONFIG_FASTBOOT_BUF_SIZE=0x15000000
diff --git a/configs/mt8370_genio_510_evk_da_spl_defconfig b/configs/mt8370_genio_510_evk_da_spl_defconfig
deleted file mode 100644
index bb537616b53..00000000000
--- a/configs/mt8370_genio_510_evk_da_spl_defconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <configs/mt8370_genio_510_evk_defconfig>
-#include <configs/mt8370-genio-da-spl-fastboot.config>
diff --git a/configs/mt8370_genio_510_evk_da_uboot_defconfig b/configs/mt8370_genio_510_evk_da_uboot_defconfig
deleted file mode 100644
index c696e89c892..00000000000
--- a/configs/mt8370_genio_510_evk_da_uboot_defconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <configs/mt8370_genio_510_evk_defconfig>
-#include <configs/mt8370-genio-da-uboot-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_spl_defconfig b/configs/mt8390_genio_700_evk_da_spl_defconfig
deleted file mode 100644
index 7f1ba02c6e7..00000000000
--- a/configs/mt8390_genio_700_evk_da_spl_defconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <configs/mt8390_genio_700_evk_defconfig>
-#include <configs/mt8370-genio-da-spl-fastboot.config>
diff --git a/configs/mt8390_genio_700_evk_da_uboot_defconfig b/configs/mt8390_genio_700_evk_da_uboot_defconfig
deleted file mode 100644
index 102f61a3afc..00000000000
--- a/configs/mt8390_genio_700_evk_da_uboot_defconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <configs/mt8390_genio_700_evk_defconfig>
-#include <configs/mt8370-genio-da-uboot-fastboot.config>
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index 683c2b0b7bd..ae9bf5d0469 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -409,22 +409,25 @@ The two paths start USB fastboot at different stages::
 Build download agents separately from normal boot images; do not enable
 ``CONFIG_MTK_GENIO_BOOT_IMAGES`` in a DA configuration.
 
-For Genio 700, build the SPL fastboot mode with::
+Each mode is a configuration fragment added to the board defconfig. For
+Genio 700, build the SPL fastboot mode with::
 
    $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ make O=build-da-spl mt8390_genio_700_evk_da_spl_defconfig
+   $ make O=build-da-spl mt8390_genio_700_evk_defconfig \
+         mt8188-genio-da-spl.config
    $ make O=build-da-spl BINMAN_INDIRS=/path/to/firmware
 
 For fastboot in U-Boot proper::
 
-   $ make O=build-da-uboot mt8390_genio_700_evk_da_uboot_defconfig
+   $ make O=build-da-uboot mt8390_genio_700_evk_defconfig \
+         mt8188-genio-da-uboot.config
    $ make O=build-da-uboot BL31=/path/to/da-bl31.bin \
          BINMAN_INDIRS=/path/to/firmware
 
-Use the corresponding ``mt8370_genio_510_evk_da_spl_defconfig`` or
-``mt8370_genio_510_evk_da_uboot_defconfig`` for Genio 510. Each build produces
-``da.bin`` and ``da.map`` in its output directory. Use board- and mode-matched
-firmware inputs; do not set ``TEE`` for these builds.
+For Genio 510, also pass ``DEVICE_TREE=mediatek/mt8370-genio-510-evk`` when
+building. Each build produces ``da.bin`` and ``da.map`` in its output
+directory. Use board- and mode-matched firmware inputs, and do not set
+``TEE`` for these builds.
 
 Image and loader contract
 ~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
2.53.0

