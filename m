Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C63EC88E64
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 13:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D62FA80DE6;
	Mon, 14 Sep 2026 13:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QKQr80EICjdI; Mon, 14 Sep 2026 13:36:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D71AB80E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789392973;
	b=cDRgyU7ED/QHRgisk6U5EIjTgwVhsA5OdPtQp4mMg5AIwSqj0G/EbIrJLIj2sGL2p6FW
	 dIAt9BmzOwLfI1UeDffCDJdTc6ZmM/9kG/hrCuubBXipVKNFjSVvCVdeBlQ5qFPEqCZGA
	 cUFd+knw1lxnhhCvKUHJ/vpk3LqGDKfwFzANdZ5niadPSgXshWLRcpRT0kKhuLCWkj7XO
	 DWaHhb6i0UaJ8u/FIKRd+LU7gK2GtHJlFaAIleZja6y/ymJA8mKr6miyEcAC/5N3fpuSa
	 j4SteOFlskh1tFiWDU+kvS34tWDIT8GDQbAr8TNaqEeUGF1nPUrGvz3tEAGHd+PBjWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789392973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gJt76jU/eyxHq9/I4D7Al5uMFp7R4ZiC/aaCJGLT3yU=;
	b=U7VbXbzZthbtZojMxbPwyi2TTuA+YiWb2ALF/P+uSyvz6Tz+/nlz/09Q50fDYCcDmiwJ
	 abkJWqobNm/jHVdxjCJJ11jhmq7Sf61H58XZr8W63yPxknEZrDE2/WPETMWD70vZw3n2k
	 aCde8rBrlSa7WHKO1ePKSZge3auNkwuNo+lnfVOGGiQIa6bJEHhACEtE2BOpGEno1UjJs
	 TzA59X5uPJgUK2/hUVz+8c9ZRw+1G4ZnNAx6obwcQEkk/HcfQmh2G0bHYod6y28uT1E1d
	 JqB4c7qbDmcusScxxkhX16x0UPUP1IJKNXK6KfiMtQU3lqwnWvCBWYBPvPOytKbXpjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789392973;
	bh=gJt76jU/eyxHq9/I4D7Al5uMFp7R4ZiC/aaCJGLT3yU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CU+zsdy39GdItd+TbyTh3/Gy452FFrhYAUnzR58JJ4zM5KsDAEg/tUq7Mm8EiZ3f1
	 uCEblUETvgvJl84aWjKiSk+PuqJ8z7vEvfYfp/gcCUl1Gbj3l0qGko0VufvUl2tFHL
	 s8jeh277aZ/n3kQipmdlcG0AugZnMjnzbm5NMFuV9acua8qjbUL05CTZ+xzoYe9mna
	 AwYeYUTDdshqhRwEb+VRbREbV2F736aEyFYhSJ4/ZLmZJnloiSU7lO5BOkvf3JVAYe
	 fmq7rlu/C9d7nzAdU5g+8JtYPTGhKl1fIbyXrJNATXQkeXlCqOX8SfqX6P8/ijs+tM
	 sokJ/RpnaGSjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D71AB80E0D;
	Mon, 14 Sep 2026 13:36:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A1E8EB
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BE6A400E2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aq6h3rgBfIqW for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 13:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1FBD140026
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789392967;
 b=MZ5CnUSsvasIRsw778pG8j5ygNDuZ0I4Z+WY1Glz+To9PC4yVo2s/ZDIB5iiyd/qdEOS
 Wd0alOLHl0J2X6wSSbGI7rpXS8ajuWdiFeTetMUuxFL2YUxmBBosB5YYPq+A7CSoYrHuy
 bg1SdT9/U0yOjViEUAfT7S/u34l8k4nwekXdE9GhzC1yitIDOv7l1kulyA4TFI+CdYs6f
 GZHLXeeaj8GQlLP1y0Xzu/e5XWCJxpZnAa3ugOhcnW/DDD+hkR7aWW70GcaRZb2OLUnrH
 DDnvEr99RwI61HQqyJ8EfqyKrKIJAKHChSicoox+XbzcHI3IvXvETJJr4TKiWds4pcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789392967;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=gJt76jU/eyxHq9/I4D7Al5uMFp7R4ZiC/aaCJGLT3yU=;
 b=SbXzmolVPony3A9gj5g48z+9MF8/KHarQzj4VZiXCjcOfgRrwSZ+GVqrS6Z7GE3l+UBv
 9kCNpIfVYDyJxR93DSddl+FofPDn3XnS2F2c3zYI3tqj4Z5deo98nqOZNW4F627ENxH8W
 Qu+TsNrc22yiMN/F27ZwnScZoddU1F+Mg62UW4RHt0jIhvxnwodObR15S5pCIsYMEdCO9
 qA0WyDcVoxVc9Qqpbaup96jz/SuJc997/9cKkPpRrdOnfKu4DYZYKaPXWyJZRI0HV5nDX
 B1Ydc+vAivTEOS81E6gMYxwHYtTNZ4Me3obEBe449J0IQ/ikQ81/SRut403znr2jDPw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=IvYJcqBB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IvYJcqBB
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1FBD140026
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:36:06 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so36072455e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789392965; x=1789997765;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gJt76jU/eyxHq9/I4D7Al5uMFp7R4ZiC/aaCJGLT3yU=;
 b=IvYJcqBBJt8wgtj4HkSHuX5jZoknAZvqZNP5QmiXRup30KShArzR/4pQujYtExk08L
 L9l9AP48Zs/SGwu5fxB6kiQfqFex7GMqaPrSdKUTrk0f7rZhYMhgjj0RNOFqDxnytFwR
 NuopFfxdgryvqT8ScVs5eFPlBIeJ2euX42+9r7WoUV+NLPWSJ4T3vFh0E/Y+rdBRRI/j
 wVtC34awqVjJIr+0A0JAs+/RRvT+fpzdr8tVlKSJiVv/r+JPrSDsH3VkSwOeifXeURS5
 v2y8QgJKFLaaCrRfv5Xba4o6aSf3S4dOEP+/PWVGM41zG+eh0acB+/YY6NdRpovNcj/N
 kqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392965; x=1789997765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gJt76jU/eyxHq9/I4D7Al5uMFp7R4ZiC/aaCJGLT3yU=;
 b=FajXWz2IGz/EOx42lRP13FbBqMDMjdZF5Gr7nmbWe0v+umVUR+NaSvxs52FAEnM03n
 5Yldax4Fj6NR6U1sVuJaYwDbrMN/ROqjdDuqt3fUSjLIcipb2wC+JD0Qu76X5iNCFt6F
 P6WzknvL5O3UnmqiV+njw0rpsTxS56xISnn4C/y/yXRsQfmvNEg5mhyOWE3NKxwFMcUk
 UtZsbS96SartyL9PVZsjHKEkoRjyAvHVYA/BkCK5xpEY3jDMD0sGimq4+Q6jUQ97EQX2
 1mSRflnVi8IqLeBN6TKPdOwHPmsuT7r9pm166xNdLct4EGkC7m2KQ+yd48meXhWtIzo+
 B0Aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwek1/Yd4mBZKLokhIJX11asnGJwuK262bfVehOv8BkFxkaGos0PGUm4++9hCgFMtD2bkybvLI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kHLRUgXEMRkPy/oT/FDbRK+n6wPWZt/hm5s02iTqsnVCKLsWCP
 rvvVhGFdAcJZ2j5FmyDDS32eNKEJ/VtubP/FExxDbta8aPiCbBsZixENOr5Wn+B0S5U=
X-Gm-Gg: AYBFou2k5cF5ukm+pFCw4ZymzH1iIACwkLIrJAEkxvSPyTiLZDZAWx7pSzZop9XeauH
 ZxCqeeLK9THTsGZzFp00H6fB3Bd64Kx1ffNZs1StNYEEOqX6C7iT8z/chTIukFr6q9hpALLTUgB
 owfL2HZyy3Qsc+7n3ipoWg59Sx0UKNjPCSlLhPAZVn9PLTlyQB8BTTmi0a52ROUolPB+EGPcC0V
 WnN9LYBHcQLSK7qy7n9rYtceO6xGsuXqBpj5fq4We4FOBMDmpuOBvt6gOZ/YMNSA8kEkPvEZlXS
 EbjnjB2u+nKh9t0BKYAJS9Iv2fFA3JjQeUY81H32hC90vcaVs4Iva1I6Viq9BbXRvhHgcT0THCM
 upgo8Yzc7Kb4ToaL+NILGHIobBhVn/HCImZDxbWgYKPwUNO0/nYpawZV12DePO79R7xGzwYQhhy
 cqKEFFiH1TLuUvrkWMcUfJS0fnXZD/Ug3gP5cl14laSBOHU2ziJbRYj+bIYbwPMmFwjgTlFrf42
 6CjE46N9P2l9VuJfAmphqI3Em2DYG+sjLGuuuub6TW2QF/dMZjijH03YOo15OzM2OAAbnjxxgh1
 6HmYcDV4eulcSlY=
X-Received: by 2002:a05:600c:4688:b0:49c:fc6c:be14 with SMTP id
 5b1f17b1804b1-49e7a68b6fdmr31848135e9.26.1789392964609; 
 Mon, 14 Sep 2026 06:36:04 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6c0cb676sm236400905e9.14.2026.09.14.06.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:36:04 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 14 Sep 2026 15:35:47 +0200
Subject: [PATCH 3/3] doc: board: mediatek: document Genio download agents
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ccaione-upstream-mt8390-da-v1-3-b76f9e30ac38@baylibre.com>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
In-Reply-To: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
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

Download agents have different firmware and eMMC provisioning
requirements from normal storage boot. Document them so users can build
compatible images and understand which persistent eMMC settings each
agent changes.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 doc/board/mediatek/mt8188-genio-evk.rst | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index e36e8faeb48..43948bb4365 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -279,3 +279,84 @@ Genio Tools uses the default bootstrap from the image directory. Keep
 ``bootloaders_b`` unchanged until the new images have been tested. Add
 ``--dry-run`` to check the selected files and partitions without accessing the
 board.
+
+BootROM download agents
+-----------------------
+
+A download agent (DA) runs from RAM and exposes eMMC through USB fastboot for
+provisioning or recovery. The BootROM downloads ``da.bin`` into SRAM; the
+external DDR loader initializes DRAM and enters SPL using the same execution
+contract as normal boot. The DA itself is not installed in an eMMC partition.
+
+Two mutually exclusive modes are available:
+
+* ``CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT`` runs fastboot directly in
+  SPL. It needs the matching external DDR loader, but no BL31 or OP-TEE.
+* ``CONFIG_MTK_BROM_DOWNLOAD_AGENT_UBOOT_FASTBOOT`` uses SPL to load BL31 and
+  U-Boot from a FIT in RAM. U-Boot then runs ``fastboot usb 0``. This mode needs
+  a matching BL31 built without an OP-TEE dependency, and a DDR loader which
+  implements the additional FIT copy described below.
+
+For Genio 700, build the SPL fastboot mode with::
+
+   $ export CROSS_COMPILE=aarch64-linux-gnu-
+   $ make O=build-da-spl mt8390_genio_700_evk_da_spl_defconfig
+   $ make O=build-da-spl BINMAN_INDIRS=/path/to/firmware
+
+For fastboot in U-Boot proper::
+
+   $ make O=build-da-uboot mt8390_genio_700_evk_da_uboot_defconfig
+   $ make O=build-da-uboot BL31=/path/to/da-bl31.bin \
+         BINMAN_INDIRS=/path/to/firmware
+
+Use the corresponding ``mt8370_genio_510_evk_da_spl_defconfig`` or
+``mt8370_genio_510_evk_da_uboot_defconfig`` for Genio 510. Each build produces
+``da.bin`` and ``da.map`` in its output directory. Use board- and mode-matched
+firmware inputs; do not set ``TEE`` for these builds.
+
+Image and loader contract
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Both DA modes use the shared ``mtk-genio-*-binman-u-boot.dtsi`` templates and
+``CONFIG_MTK_GENIO_IMAGE_CONTRACT`` settings. The image starts with the DDR
+loader padded to ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE``, followed by SPL padded
+to ``CONFIG_SPL_MAX_SIZE``. The loader copies that SPL region to
+``CONFIG_SPL_TEXT_BASE`` before entering it. SPL fastboot reserves a 16 MiB
+heap, including space for the sparse writer's 8 MiB buffer.
+
+The full-U-Boot DA appends a FIT at ``CONFIG_MTK_GENIO_DA_FIT_OFFSET``, in a
+fixed region of ``CONFIG_MTK_GENIO_DA_FIT_MAX_SIZE`` bytes. The external
+loader must copy this complete region to ``CONFIG_SPL_LOAD_FIT_ADDRESS``
+before entering SPL. Its ``DA_FIT_OFFSET`` and ``DA_FIT_SIZE`` must match the
+U-Boot settings. The FIT container is directly parseable; only its BL31 and
+U-Boot payloads are gzip-compressed. SPL decompresses them to
+``CONFIG_MTK_GENIO_BL31_LOAD_ADDR`` and ``CONFIG_TEXT_BASE`` respectively,
+then enters BL31, which starts U-Boot.
+
+These fixed regions are part of the external loader ABI. Changing the image
+sizes or addresses requires corresponding loader changes. Binman rejects
+payloads which exceed their reserved regions. The generated DA is a raw
+payload for the platform download tooling; it has no eMMC BootROM wrapper.
+Its FIT hashes do not authenticate it. Platforms requiring authenticated
+DAs must use their external signing and BootROM download tooling.
+
+Provisioning behavior
+~~~~~~~~~~~~~~~~~~~~~
+
+Before entering fastboot, the SPL DA selects eMMC boot0 (BOOT1 in the eMMC
+register encoding), enables boot acknowledgment and sets the boot bus to
+x1 SDR. If ``RST_N_FUNCTION`` is still zero, it permanently enables the eMMC
+reset pin. That field is write-once. A previously programmed reset policy is
+left unchanged. Preparation errors are printed and fastboot remains available
+for recovery.
+
+The full-U-Boot DA does not perform that automatic eMMC boot preparation.
+Its provisioning flow must configure the target's boot settings separately
+when needed, particularly on a blank device. Neither mode changes the GPT or
+writes firmware partitions until commanded by the host. Use the platform
+provisioning tools with the matching DA and partition metadata.
+
+Use raw images with the eMMC boot-area aliases ``mmc0boot0`` and
+``mmc0boot1``: these aliases write the downloaded bytes without expanding
+Android sparse images. Sparse flashing is supported for GPT partitions and
+the eMMC user-area alias.

-- 
2.55.0

