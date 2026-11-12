Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712F606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AFSG5MDX;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=bBTfY7UN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66CD640DE9;
	Thu, 12 Nov 2026 21:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BX6W0lVAq3NJ; Thu, 12 Nov 2026 21:16:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8FC8C40DF6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518213;
	b=ZkSuZVaA1pVbGx4tl7yUE/sGZP9TD8CmR/m+cdsUwxxbg+wR9/0V6PjzNiZuwqECkLkP
	 XYQgtuLGDtgVOXxB8zBHYNUe8hqGpDD7VXVxyDZaE2wOL89Jq8CBjdgbLAedMhB1d8m1R
	 KsMajma9r6xXrB/CcjNrtq42fp8LGtGbCfhimd6Lu21sFcohXU38IiNcKH4Gvy03jjz+Z
	 jDS8l6RdTQOBeSw7DHV9aFxsGsHy1FBR0Rr0vhe+FkiUaGYqx7mfNSMbiOQod4OT3HMEJ
	 gg0B+G46rXX8zWcToWKWFj478MMWkCyFLbs6eHDBZB2GXsfddsB9WiN+0uQsl2TSeGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZF0ZVV0JH26LxLnicNmyOj+dl6R5o1zhPvEnPR+fIck=;
	b=ltd8pXsCB7/urzOQP6Zt8q6wO+8epwWYGZbffZYLxu4QTPp2sbJG32b+bmN6pZhdSawG
	 kzlm4Varae0OyXuVt+Z644isQTlqliGWLMh6K4Z8T0psREP72tKhmcbTFjoVP0XR7lGFJ
	 8y5vNWb012EPBO4k4tCoR0zOnvMWjf2PmJz954yHfuLjxTKIvoMDuCkmEbahLYGYrAl2w
	 nByAJYissAJlHZFuMt53r0VkT77qwuSbFnpUQgFRsRoWtmJYXmjnpLIR00UvGvE4SokgE
	 +wqe8P98OndMaJyDu55bIjDsoV5yloDWgP2ALEkH5G6jt5oJ+/6VXrWDcU+T/f8KphA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518213;
	bh=ZF0ZVV0JH26LxLnicNmyOj+dl6R5o1zhPvEnPR+fIck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFSG5MDXYVWMHUXpTNf6Jv8Q9jt6t9SQOseQ1qfVrFFHYwvtkB3yEZcEOtJMtf38S
	 Mvmj4GrVlYHLV7QVgng1A8tvcPO9N02pftV4dmyF7kWpz4xsdwcvfzXxLHAfc+gtnx
	 c3t/ACgbB1cLDtdMRGTcdT4dBJyIf7YMqJcZBymMLnDCMcCcxyN+KtEWmjW61yd9jr
	 4F3eiHb8kKqfIP0eTJWmmmWdz5oVolmTLCgMIPKBRR5Rv7dxi8vGtXgBPqoFmMC7n8
	 RXZsCjgrL2sp33MYKf1mESJ1ApY9uKPdt2LdZ51IbpaIpX3WCpBdZfhxPg9XM9dG1Q
	 zRhTgPxtbZ2vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FC8C40DF6;
	Thu, 12 Nov 2026 21:16:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D30AC1790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C17708188D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOzfCgWJnd5U for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB7C98183D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bBTfY7UN
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB7C98183D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:48 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4f66bb2ab57so128118b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518207; x=1795123007;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZF0ZVV0JH26LxLnicNmyOj+dl6R5o1zhPvEnPR+fIck=;
 b=bBTfY7UNELvF+5vfqwUSA+DS8i92c0R2ZjU5OdiXPzqZKKZlgeAci5yvHIU6WHTUxt
 QQGu+V7xlkOIoVry0ja5wvXilzaVPwwyiw8WaBYJvbPU2yM9oDlg7/P+AYOCJsCVhL3i
 18bu46uS6OWzk5HHV66fSVP6vzm5GPIjUQnRzSqPtru2wq7tPueXxPL1jdfW5OrkeqTO
 sMoKH9eKnIzs2i/8t8kgpNtpi9ZUj487TbOGlSwRHK8QPWTYJWwLok/04F2o4iXlwmRr
 17WegLB9pe2dg6l71nXDtvyYleKxgeoa43x2Lk1fmHDR3sy/ShKor1VRRu0QpVU3Okvo
 ls2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518207; x=1795123007;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZF0ZVV0JH26LxLnicNmyOj+dl6R5o1zhPvEnPR+fIck=;
 b=t1a30pehsqDavxsHgkGmb37Jzgk+hH3VT3UQKS2vu5XV9VU+04b/Cn9HdVDbaHH7Th
 +h/y/42zwjLJrICA5b059JGdL5oUznyGg8Fmf/X5h3OneUO5DDKsKGpH8S+KgsJHAhAG
 NXYx/AJ+yNPMRI45O8sUR6kIXDfF6EvNMHEeII+B5HQvTIZb0kYgR94jlII52l3sx3A7
 A2ECeXjODW+h4Aj9RzYBV1rR1OZ7fG+YYEw2MlXV2qSwLwCxFMCrHKW1HJ4+qx/Bi2tE
 jEdLfWqBZ32o1Mc7sR+cXc6BlUZd+Szmk9CDAmYVfrXqp0ujY85zhENbQGh0ddY+NS60
 WnLA==
X-Gm-Message-State: APuU4Z98MAF9YNFXjp5YMcwzZGXNMVQL8cB6wMGXhamDyZ4Fe4Km2OCa
 rOp3C4yR5fi+AyZfGJ714n2wqp+QBx/zcytDPcloTuU0UPcao9qomTNI62UjMa/Ccmw=
X-Gm-Gg: AYBFou31zHNX3SpBwBW4RIaMUh2p9CQyETJ+MCJTp29q8bf+hmcD/23T+8KYCssHeAC
 BjotCetQDdxBiTkAcORi7dO5Asc4rYyqBYydRjlZ0UxJW/32R3a4c/CevvBB3h31bgcHjhVW74R
 DLCUm/YpssQvViYLWJfyeh4gmekSFFFsumrLQOXCZG9QzkdxmSb/ktjiR0l/dkwWshr2toA4kBf
 QPpWJ3oZy+D1/VR4br3ZJrUiHx9e3VaR/URBO3gkQ0EzaO1sNquhtCOEE66reN1rAzFgXyBkXYO
 2n6hX3ULqdV8WpXiiqJJFLCrbasn2EYIz2h2n6y7KUQxujtN5Z1z7Z83J75V+xkQkApfFyFDGp0
 QRnUtY80/0r+VAD6U8nhvRWTlVfCrLVkt1BfTRWJEq94B2Krcy0Jr2Z+ilP95vkVztYRFUAIPVA
 4tUgT2HbJZwroGWXbZv65rKOaEwNNOk0Vxjkhdc//fHG8t+QI+eohpJ8FBNcshwRyfiSUtCTPSo
 POujydI0N2ChXpEOOXMY6TtmD9h1jP40DCGid/usgqxbWoEsVDJl8qdSXidBRtcBgmP5H+ZLg6W
 m5R8hROl94MUskKEmbyOK0ztvp/RR0a3NQ==
X-Received: by 2002:a05:6808:221a:b0:539:e1c7:c05d with SMTP id
 5614622812f47-56e64f0752dmr436019b6e.49.1794518207470; 
 Thu, 12 Nov 2026 13:16:47 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:45 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:15:05 -0600
Subject: [PATCH 10/10] doc: board: mediatek: use the Genio boot images
 config fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-10-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3243; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=y5WmP8/jFsG0F99/mVqQ1xDt9wnKr/L6xCM3Ld1csfs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9iyeKsr64zkApDM7R1nZDI7OkVlczxfLnob1u
 uz+rBH+lo+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYsnhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A10AH/jBCPybalBmeIXJwoewrtPciRBF6sERCxoFs4Uu
 CruOb8D0IAmo83vvCCuT2W4c6BuIFKojFiyIqKyPFdTG/5lGksrlH/dHlHBycw/QgCx/ruTNNko
 6R7glLmXG7seLWrzbMQYrXD2GWsxXTALaqlUzjc41X7FLph4H950yjl2N/HOXaZNTaHG8fSpRo6
 XqJX7K4HWfqFCEj3x4uSBOxch0VthoagHGrSnaASK55Ul/VgBRL5ISIAhxDc+OVViw3QDvGCKum
 DBVrAAp+UkBrvHdpJRTlMwNWowTOJAxtp9LIemo8AlDiDGjKw5hyiV1xhOxUI7hwzjS9QAIJsHB
 W4X4=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the scripts/config and olddefconfig steps that enable
CONFIG_MTK_GENIO_BOOT_IMAGES with the genio-boot-images.config
fragment.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/board/mediatek/mt8188-genio-evk.rst |  7 ++-----
 doc/board/mediatek/mt8189-genio-evk.rst | 14 +++++---------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index 4b3871e02de..683c2b0b7bd 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -164,7 +164,7 @@ Complete firmware images
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Enable ``CONFIG_MTK_GENIO_BOOT_IMAGES`` to assemble the complete firmware
-images.
+images. The ``genio-boot-images.config`` fragment does this.
 Packaging disables ``CONFIG_SPL_BINMAN_SYMBOLS``: U-Boot proper is in the
 separate firmware FIT, not adjacent to SPL in the BootROM payload.
 For example, with the DDR loader in
@@ -172,10 +172,7 @@ For example, with the DDR loader in
 
    $ export BL31=/path/to/bl31.bin
    $ export TEE=/path/to/tee.bin
-   $ make mt8390_genio_700_evk_defconfig
-   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
-         --enable MTK_GENIO_BOOT_IMAGES
-   $ make olddefconfig
+   $ make mt8390_genio_700_evk_defconfig genio-boot-images.config
    $ make BINMAN_INDIRS=/path/to/firmware
 
 ``TEE`` must be set for both configuration and compilation. U-Boot uses its
diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index 6879a1e9060..dde77a678b8 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -252,17 +252,15 @@ Building
 ~~~~~~~~
 
 Enable ``CONFIG_MTK_GENIO_BOOT_IMAGES`` to assemble the complete firmware
-images. For example, for Genio 720 with the DDR loader in
+images. The ``genio-boot-images.config`` fragment does this. For example,
+for Genio 720 with the DDR loader in
 ``/path/to/firmware/ddr-loader.bin``::
 
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export KBUILD_OUTPUT=build
    $ export BL31=/path/to/bl31.bin
    $ export TEE=/path/to/tee.bin
-   $ make mt8391_genio_720_evk_defconfig
-   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
-         --enable MTK_GENIO_BOOT_IMAGES
-   $ make olddefconfig
+   $ make mt8391_genio_720_evk_defconfig genio-boot-images.config
    $ make BINMAN_INDIRS=/path/to/firmware
 
 Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520. ``TEE`` must be
@@ -272,10 +270,8 @@ reports that it used fake or missing external blobs.
 To boot from UFS, merge the UFS fragment into the configuration, select the
 UFS devicetree and pass the directory holding the DDR loader built for UFS::
 
-   $ make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config
-   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
-         --enable MTK_GENIO_BOOT_IMAGES
-   $ make olddefconfig
+   $ make mt8391_genio_720_evk_defconfig genio-boot-images.config \
+         mt8189-genio-spl-ufs.config
    $ make DEVICE_TREE=mt8391-genio-720-evk-ufs \
          BINMAN_INDIRS=/path/to/ufs-firmware
 

-- 
2.53.0

