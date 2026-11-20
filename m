Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9857606A69F
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gTknmUnW;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=phtQIvW/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B43B781991;
	Fri, 20 Nov 2026 22:05:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VO7GjzbKH2Gd; Fri, 20 Nov 2026 22:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7ED481A0D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212349;
	b=O5xSyCkNCZ8ZCYGUf1FhfLeWTA+LelM+8dZLrUnK8y8LL5HZ8ARObU1M1wt3t/zh5eTw
	 KxHGP8ChIOLiM4PzNNkzt4bv37PXly4EJmRDfzq2ViRI5ILOSgJgtAw4xkkLDtmhTNhWS
	 S26gdX9ZW2aXe6lBWN7z30fpdKHJnGxps0vGMRCjDuTTTBsDVt8uyYD/DPSMYORWrETyB
	 7Z6FCP5saVeTxxwSLq7ai7BIbfYSDafNigDT6SlLbJx9w4IyLrJhbukTv0p/7vHvMqr78
	 46TgyU/N6yQCat5Ictz8AcW+9KXkpdE0TCJzd9fq/HSRWpP5bAfK0ytsVs8+Ckp3Kdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=diLHzkBfk0G8/wsfZa/r7SB04yW1nO16hNwosCYkjhg=;
	b=pCTgYY+lJlKeRxMmL+jnm0B49Bnh5LX73UbeSD1s853CUihAfclZLEhxK3gYNABDC8Dm
	 JmjdAupn4r3DbtgnmNigeiHNRxtYCn5o3Bhez5IbVUAloVmDDU8XnKeiA5aYRBrwddl3e
	 ciE56+0wQe5cnZZzFpywFkpmHdubdolVbGYnLjSGABEEHkK/LYeGRtCLz39/JhXedt9bG
	 gY1ZkJEfFvXT51F97lQFOKg9HwCv5+plUJi+CGK3DMk8MdWTNAm3dUkwwZhS5Yt2lDEn9
	 JyjWK+F0nQZtfvKFgbPRghtpfWX9l0zyWvQhi64o5F3/ppp5iPX+jPKQWVY8/Yl6H2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212349;
	bh=diLHzkBfk0G8/wsfZa/r7SB04yW1nO16hNwosCYkjhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gTknmUnW1b8YUb2gnU0W5kU6wPeDZrLipRGkD49c+mTc8w6i5vR7EEguI0wddjlYP
	 eGBre6jXAX/dfEPyLXZ1jRUOIzzRxPM0G2MN6iAAfVXB2WBmQbmgrHGIcE0+bmcTE8
	 IxmsBqaXGGp0WTwfX7u7ZtN19t9M3E22VR5p1tf2HxXyySuK+Q+0DyYoC6ZlQXOkKk
	 xbEdpf38wDQ4tMtXPml4jH9VVM3zPxeBSYX4/TQaOs5BHrpDmLr5K/JDTTUDgZ/g1Z
	 XtikAJewy0BEMnY6YdbJcViz/nHpB/qIVOn3/LTedZ06JGsCllJLK4eoD05P2/yymi
	 sj7L+nDYRXFnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7ED481A0D;
	Fri, 20 Nov 2026 22:05:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DADF2465
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0B636063A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oSKrB-nRCIgX for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D539605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=phtQIvW/
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D539605F7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:35 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-71ad1db7e31so1726874eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212334; x=1795817134;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=diLHzkBfk0G8/wsfZa/r7SB04yW1nO16hNwosCYkjhg=;
 b=phtQIvW/9x+bw1O2SmdQZY0+F9Ky0uDzQxR8bTH7jwxyy1D9eOBEtyOAyaIXOAdi9+
 oEE6Seyzzp7e1QoxE5BsbCCf2b0bFASPSI3atgR09BUtkTcFddxq5VmWOePJi9+x4UYJ
 WE2k/bxNYQtRotj+DUH9kiT9tKUla06/Tq18K9NgRogXCrHOOIrdjVJ+XRzKxupa7yqZ
 76vuB25DKWB0EH8ta8bcL72XLZZbqrkCf5YhAhhcN5BeRHJNaSoWVsWl1SHRFaa7WcR2
 zfC+5p2cTN0hFy/2LkG/ODWvKvqdAyHp1qVSxop/3iUKRFtC2zoHw2WG8Yv3eU7UwlxL
 MCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212334; x=1795817134;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=diLHzkBfk0G8/wsfZa/r7SB04yW1nO16hNwosCYkjhg=;
 b=OEH96TMb+dvU73Ex+iu3qGRxkc1GJvBnafFj4fxreyQKKvdY7gGzu7DTXXmGeBZ8xG
 oRKiXwXsB9mOnYL45TAJWkOp9QgO+nJ/weOIALF15OfFIu4rdKXZV9VSdtXT6VGBpG81
 THJ6QWhGzm0y+/nGwYR5rVlbjCniUvIPaJOsRcQ1UidKE+sSdJqDnXiwTRXvnc1X4gzz
 YgoXJNyvt+vSR0Nh/BPedmZ2wK/ap+4phyjRN142lMbxKH+H/kqELLZpiU7YJCH0Kd6j
 AABpVX2hBbol5KQfSxgm/vbkQbYfz68vZTs/4/eopOXdWHAqE3leI/d0sVMb8zZyHdlo
 kMOw==
X-Gm-Message-State: APuU4Z/bsr1S2neF9QlOj+jeDjMlnpllfrCzZikfKVpBF2gCNyNc1VUS
 Di/GigwyjTB6cq0pmT0xzMg1UhSlYz4/+YUtiBRaFGOvzTq/0oAHU9gLn9BLRY+bmrk=
X-Gm-Gg: AYBFou01fdNlY2B1QC5dnEB70Bn1wsxzbrZ0ad5PoYDRLWc0Fl3JIUeeWNEA8spFvsu
 V50YfZ0PYQbo0QPXz0JsKGs+/JSXprYmSNuIPyM0CKJ/nYBNJ2rxTJDFxfQOhjmdwtGyI/rDYJR
 Z0033ddakNDLzecY/pq93PxG0WfPkN8qdpmxy3RJwjAW9kRXM8ACJTu/GYkKxhb5pEaN7JqTy3y
 D0XnLhjY0UZmSkfP7/8gWUIItB92TBc9rKgzEz1p2YatDJtjpM1kr//QvY10dDYxIJzNM4+n753
 jQvfgPucWEaxAW3VTh7mNngLCFL+LnLEiUwbThwfG0GrgJs83Bnw/f2m61HcJhGayMI0Ar3H0oS
 6a7tq0aFn2MBDbp5FQSHw5gE6XmdRn2hOlpfFXvZLH0n4MhoQFriNosWmf8eEbG1B+AFw4Aa2Sh
 PNSK5Cxuvudc1hlLeXCIiUjIgAwab4g0xtQKJebiivmUN4XR7od+5IIXBh6Q5FhC+auAOq4nDxx
 NQgMkWovsuSbMFaDenCtn0AH7mcLWwPBwMa8Co+rtLwkbLQLPEem76K7ZJNCIgsj1NXlEsmmc9Z
 hN37PXJkzG9h85t1zG87hlUbwj/SG2YfaIm/nUwvEalbz41430lboA==
X-Received: by 2002:a05:6820:1c8a:b0:71b:1542:33b6 with SMTP id
 006d021491bc7-71b3267baaemr4379497eaf.18.1795212334345; 
 Fri, 20 Nov 2026 14:05:34 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:51 -0600
Subject: [PATCH v2 10/10] doc: board: mediatek: use the Genio boot images
 config fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-10-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
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
 bh=xvq59tXkC5MuiEzrhrnso1jkteik94Jjz6YkyB2rDDc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMQLBKloUFO8t7PRQ8WYQSSomilRD8nBH2SKw
 X4+vVF6bBWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDECxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AM98IAJ2lfS8XFoZGXz8rDLRf9LG4XAyeU5pX0zL6PJm
 5K9Iw0cUgA/a2VAeULO5AUp/CZfDGTYZCo+7f9gMWI22zxC8N+YShYKnFOLMoAWyaadZf4T7PsQ
 J3wLoNMESOAIU4PRRA6ZUIfiUM/wfLucb0NvKnFKWEVUUGqKxyoOiPP5FSB0F9P+elJ812mHzh6
 sTT+uEtVyfFNY3MglCo+4kmgd7jQxKgiS23XAB8gifwwV9y4Yfi3+0i5CG2qalAm+nJ6rJJl7c8
 Rl1g/bunFBJwL9t1sHUaOiAV/BOPBu8kju4zDg5T21je1AtqXhvnKiBGMiJ6D97YBc87CfjYWhB
 mujE=
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
index 69b696201e4..ea1d37467e5 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -256,17 +256,15 @@ Building
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
@@ -276,10 +274,8 @@ reports that it used fake or missing external blobs.
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

