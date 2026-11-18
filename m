Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD7606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kFRT6Ybx;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BQOt6g5p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6B97812AC;
	Wed, 18 Nov 2026 23:20:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rc_XD-kAtI7V; Wed, 18 Nov 2026 23:20:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B81EF812EF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044039;
	b=XJVHCBqzNqKWdIf4bx3vXF0Z6gcbvSDfjdSw4dXNdI8RM07qbiX2fSii8X5a/wKVfxTp
	 kAaOIqJpqcwbgMuhNAa4/4MUAjJW4mZ50u9vqiVSMu4/K+n5Aak/fyqXVi+VCF5kYMdmn
	 b0v7f6Y0N6Ei4sOm7YNekAoKw1wAKEgWrTN8/odHuyhBEO0SKVHhrJcSO1JPNBC1bZVxE
	 RkY9YubeKny4+OLW1wHChXAb9e8BYWBrSDTeNigpwfgq23lxaZlaT6Flw6SfQu07g+fHx
	 65t3jf3x1kRlrT04A2URn2oBMmufwNglCvLqi5ZuyX9IftmffEEpgQVSZ1DqiYZxJfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xJ9yQyZeIk2CBPfdVh8aXq4X2gwCHXF5zrd/jxzAHss=;
	b=i7D/G9CGHfMyFpfOtdw5de4xEK6L1wih31P2oYg9qWyIg7x4jURcZ3v/jkxVjgWeOkK4
	 365of5bewYZ0ghrWgFcdgQaJ+U02/YlaFjj6eJerzcG3NN8WFdVO0btxd8WwLex9cINPR
	 5LK8YQoCBbvJQrU37MpzP546d/LL8q5sz0VKRaD5J6JgP/5Rg+Z8RsnlC9COWZACq4MBE
	 iitun+hEoub2fjzBRbxj9ZhFgeSOdwezOJcP3Q8t+DDu13H4Ef2cEUxTWnVsYbkn+CPgn
	 D/U/GzXDyQDaVSxkqZdCRwy98b96fP0HNSo9JKHr2zWVB0Cgyscnl467AQFsmPtXxFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BQOt6g5p;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044039;
	bh=xJ9yQyZeIk2CBPfdVh8aXq4X2gwCHXF5zrd/jxzAHss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kFRT6YbxupY6C3BLn48o2+rzZXOXEhbaiSOk0v2RARcCxwUghUIzierxR8PyxaLaW
	 XC/UA4lV9limK/puLQD+qX+4hNE1I9vhq1lzdbNTJsPmks30ydiAyeQlbacUsf2dii
	 D5Wzq+Pqig/dHX9aZ+dM4osU5YKAfNNIkcb2X6pHmEmd3uQ3Pd8Exd4Rlke3A07QaR
	 4v0uPZ2ydaEF9C792rNSto7xBfO87+dIn/lpB/JEtP6u+P5FlXajYivx2uVTt+C+ap
	 EqPpTPMbQ9wnUGlYdIRpaVbMXQUPyNQeG+zKKn83SB1GMlg1qqtSvfHiIUXYtHiQG7
	 QJ8WvP4Vb11WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B81EF812EF;
	Wed, 18 Nov 2026 23:20:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C77D99F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD7AC8128D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLVbBZuz2oBF for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB056812D8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BQOt6g5p
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB056812D8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:36 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-8490a7d6696so905513a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044035; x=1795648835;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xJ9yQyZeIk2CBPfdVh8aXq4X2gwCHXF5zrd/jxzAHss=;
 b=BQOt6g5pb1FnSFsepTcavo4Cgma5Jy6Iax7XlfUCIh8Zky7Dr76F29KDS0mbgoinse
 geORJVWsdGABWJ30crPLHWuD4/0WlcQf6umK5iFIqVp1QvOGp2cTpVIkIpaFrfGS+Ssk
 A4M43jSxc464D/0dD+0wjNl1sl28o+XGsehb0mYOoGiopIG7rSiaXtF/KC8BRTGpwHq4
 U6bLtdLzTvw30RM1fTbgQo7DC5yIm7LotHgWy2oDUATEUQIWbyUDPiKOf62kpkh/kEYY
 vwQNZ0TTB4JlEuFmkQc8ro49uTFaOghQyyYJX7ygEl7/qePCyazbBsuJ7jWWfbT8XUi1
 wLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044035; x=1795648835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJ9yQyZeIk2CBPfdVh8aXq4X2gwCHXF5zrd/jxzAHss=;
 b=HsVdZHBOX7x/T6g8eTHmLXLmvqn/2GQu/OwTwc2ZW8Km+s5fzghFAJHtMQHnuJ40pR
 atKGCvTsDzydLbi/MjJ6iL7P+m0FCjERQdHvfBueanMyyaYsVMWTF15L0eGMW7ySu10F
 svENIHm9vM9UW354UM6Fsn0X82QSUwaxnUoHk27URdIplwkf4aIQcuExKFwZ7Ek5VfF7
 cvOFdcvopOGx90HyE2C8Dt86bGsT/q1R3SZBMxMnEub9qVjFykweMXbYwsNvawxSDEcj
 r5Q2D/r2uwnjUekySDJiTvdgvh2nfQu9IIHtXhd7DafngUWu7e9/9VshUiTzn5Tor71j
 tOvA==
X-Gm-Message-State: APuU4Z+B4b/PaTQvE8vKbPV4j+pKEDtUQNvuj9Gprsu7vuRWp0wUu2Ap
 uKt88WA6nevosL6w+28F7kP3B4d5OIwbNhRtXVCBi3wDpgdGv4TBTaxdVXfYMDz6CE0=
X-Gm-Gg: AYBFou2OVTZ1Ubgep/B1fPKIl/KiaRV2r0WBe2OxIv/oQH67/OBwDDMbguFY/dFq5dD
 mYuKQJvz7X9UJKpd+9d3hDoix03JyLLcndAu3vToCuGoeYbCtY1SApSgj18E402Dx8ykh7xX4N3
 FRU9Qdw5zlI3+Na1TYeF+49tFSpbE986NS/R+WvEa6sVR8eTeh6zxkctT0kGA7WSZmZJsidkYV8
 aSC86TTOEstUXbkvP4xL25l/5nT2xlkYj2schyiDWXniAOcKheIEVPCArsm5I+Svfufmlxis+Rx
 QIkTpSOimQvH+ocT40YGhtCbDbcHq1JfElne9Kwm11y9ccra44NeSTzfhJQ/v+vgYfPTWxdrQxE
 y3st9OI63B3ErOrS/MGu3xauhVTYec02n3alHRTpZawo/JSJqPi4aazcA9JLX1G8B1XvpE5TUua
 sDUZDxARvVYIFGtPsqY/nHFzfryhFgJOTkezt/fTNxm4ZJ7j+DzwMLJC33FvyOjk9Fss/1VCH1Z
 579T5k70unHSLZkyRneMlP3iCahrZmYH6VY91blaW/dN3+fvcsQ0dbr0NVmobyxwpzTVnJ5sYAA
 TNhKrqBMkBnslOzT530I7dW1GmXCU16k
X-Received: by 2002:a05:6830:640d:b0:846:7d51:d9d7 with SMTP id
 46e09a7af769-862f087fcb2mr4736706a34.28.1795044035473; 
 Wed, 18 Nov 2026 15:20:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:06 -0600
Subject: [PATCH 7/7] configs: mediatek: drop the Genio 510 and 520 EVK
 defconfigs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-7-1505d27fdfcb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7293; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ByaUFQ2fmZn1T0U4z9mDxKAlg1qvv6O6rNxXKxBJWek=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKnfRSwSgEQ5cl6QNamYOmbQKvs+1dGfs7Ds
 xsmmfrY4E2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4ypxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvwgH/3+KlfR7zVA7TVJePiA4S7lMNr++8bHhfJwLM9R
 A8jl//C7sdnK7g61zPCaHu7eIWjC50isVBrEZaWLhZegcFaeXtI68F7kQ3UV1rDndaU7Qaee/ql
 UNgHxLssWfJsT3I3tRkpM+KY6NpjzpAJd1QiUtQ04+HW/r1UV+0la4LTTpdOpZuSjSNIMZ7Xt7N
 qiiljmJfA4fjNzc1J+YHrcQC2RWd+KauU76uuJe6Q2Er5TKMOJuiZHsAEDDKLoUQOzTI3xpMm90
 uHS0NOEWtMg2tUTo85AHXOJoeUD9YEjyh2DrHfDe99xrjUPAlJfH6ZctE0kPSEWXztLhtUaFKac
 XYkM=
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

Remove mt8370_genio_510_evk_defconfig and mt8371_genio_520_evk_defconfig.
Build the Genio 510 with mt8390_genio_700_evk_defconfig and the Genio 520
with mt8391_genio_720_evk_defconfig, selecting the board with
DEVICE_TREE=.

Each of these defconfigs differed from the other board on the same SoC
only in the default devicetree, now that the DRAM map comes from the
devicetree. Keeping one defconfig per SoC means fewer configurations to
build and maintain, and new boards on these SoCs need only a devicetree
(and, for upstream devicetrees, an OF_LIST entry).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS              |  2 --
 configs/mt8370_genio_510_evk_defconfig  |  3 ---
 configs/mt8371_genio_520_evk_defconfig  |  3 ---
 doc/board/mediatek/mt8188-genio-evk.rst | 20 +++++++++++---------
 doc/board/mediatek/mt8189-genio-evk.rst | 25 ++++++++++++++-----------
 5 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index c0ca788555e..a0749ac331f 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -11,7 +11,6 @@ F:	board/mediatek/mt8189-genio-spl-nor.config
 F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	board/mediatek/mtk-ufs-rpmb.config
 F:	configs/mt8189.config
-F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*
 F:	doc/board/mediatek/mt8189-genio-evk.rst
 
@@ -40,7 +39,6 @@ F:	arch/arm/dts/mtk-genio*
 F:	board/mediatek/genio-boot-images.config
 F:	board/mediatek/mt8188-genio-*
 F:	configs/mt8188.config
-F:	configs/mt8370*
 F:	configs/mt8390*
 F:	doc/board/mediatek/mt8188-genio-evk.rst
 
diff --git a/configs/mt8370_genio_510_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
deleted file mode 100644
index b45ed21c646..00000000000
--- a/configs/mt8370_genio_510_evk_defconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-#include <configs/mt8188.config>
-
-CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
diff --git a/configs/mt8371_genio_520_evk_defconfig b/configs/mt8371_genio_520_evk_defconfig
deleted file mode 100644
index 612cbf3783a..00000000000
--- a/configs/mt8371_genio_520_evk_defconfig
+++ /dev/null
@@ -1,3 +0,0 @@
-#include <configs/mt8189.config>
-
-CONFIG_DEFAULT_DEVICE_TREE="mt8371-genio-520-evk"
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index ae9bf5d0469..835217c81c9 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -4,18 +4,19 @@
 MediaTek Genio 510 and Genio 700 EVKs
 ======================================
 
-The Genio 510 and Genio 700 EVKs use the same MT8188-family boot flow:
+The Genio 510 and Genio 700 EVKs use the same MT8188-family boot flow and
+share the ``mt8390_genio_700_evk_defconfig`` defconfig. The board is selected
+with the control devicetree:
 
 ================  ======  ====================================
-Board             SoC     Defconfig
+Board             SoC     Devicetree
 ================  ======  ====================================
-Genio 510 EVK     MT8370  ``mt8370_genio_510_evk_defconfig``
-Genio 700 EVK     MT8390  ``mt8390_genio_700_evk_defconfig``
+Genio 510 EVK     MT8370  ``mediatek/mt8370-genio-510-evk``
+Genio 700 EVK     MT8390  ``mediatek/mt8390-genio-700-evk``
 ================  ======  ====================================
 
-The configurations share their SPL addresses, size limits, drivers and
-firmware-image layout. Each board retains its own control devicetree, DRAM
-size and external platform firmware.
+The Genio 700 devicetree is the default. Each board keeps its own external
+platform firmware. The DRAM size comes from the devicetree.
 
 Boot chain
 ----------
@@ -140,14 +141,15 @@ which can be passed to binman with ``BINMAN_INDIRS``.
 Building
 --------
 
-Select the defconfig for the target board. For example, for Genio 700::
+Build for Genio 700 with::
 
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export KBUILD_OUTPUT=build
    $ make mt8390_genio_700_evk_defconfig
    $ make
 
-Use ``mt8370_genio_510_evk_defconfig`` instead for Genio 510.
+For Genio 510, use ``make DEVICE_TREE=mediatek/mt8370-genio-510-evk``
+instead of ``make``.
 
 The default configuration builds U-Boot proper and SPL without requiring
 external firmware.
diff --git a/doc/board/mediatek/mt8189-genio-evk.rst b/doc/board/mediatek/mt8189-genio-evk.rst
index d33ac8ccab1..7b50c49feea 100644
--- a/doc/board/mediatek/mt8189-genio-evk.rst
+++ b/doc/board/mediatek/mt8189-genio-evk.rst
@@ -4,17 +4,19 @@
 MediaTek Genio 520 and Genio 720 EVKs
 =====================================
 
-The Genio 520 and Genio 720 EVKs use the same MT8189-family boot flow:
+The Genio 520 and Genio 720 EVKs use the same MT8189-family boot flow and
+share the ``mt8391_genio_720_evk_defconfig`` defconfig. The board is selected
+with the control devicetree:
 
 ================  ======  ====================================
-Board             SoC     Defconfig
+Board             SoC     Devicetree
 ================  ======  ====================================
-Genio 520 EVK     MT8371  ``mt8371_genio_520_evk_defconfig``
-Genio 720 EVK     MT8391  ``mt8391_genio_720_evk_defconfig``
+Genio 520 EVK     MT8371  ``mt8371-genio-520-evk``
+Genio 720 EVK     MT8391  ``mt8391-genio-720-evk``
 ================  ======  ====================================
 
-The configurations share their memory layout, drivers and firmware-image
-layout. Each board has its own control devicetree.
+The Genio 720 devicetree is the default. The boards share their memory
+layout, drivers and firmware-image layout.
 
 U-Boot can be used on these boards in two ways:
 
@@ -44,14 +46,15 @@ to BL33, together with the DRAM description described in `DRAM description`_.
 Building
 ~~~~~~~~
 
-Select the defconfig for the target board. For example, for Genio 720::
+Build for Genio 720 with::
 
    $ export CROSS_COMPILE=aarch64-linux-gnu-
    $ export KBUILD_OUTPUT=build
    $ make mt8391_genio_720_evk_defconfig
    $ make
 
-Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520.
+For Genio 520, use ``make DEVICE_TREE=mt8371-genio-520-evk`` instead of
+``make``.
 
 The EVKs have DIP switches and jumpers which connect either the eMMC or the
 UFS storage. The default devicetree is for eMMC. When the board is set up for
@@ -274,9 +277,9 @@ for Genio 720 with the DDR loader in
    $ make mt8391_genio_720_evk_defconfig genio-boot-images.config
    $ make BINMAN_INDIRS=/path/to/firmware
 
-Use ``mt8371_genio_520_evk_defconfig`` instead for Genio 520. ``TEE`` must be
-set for both configuration and compilation. Do not deploy images if binman
-reports that it used fake or missing external blobs.
+For Genio 520, also pass ``DEVICE_TREE=mt8371-genio-520-evk`` to the second
+``make``. ``TEE`` must be set for both configuration and compilation. Do not
+deploy images if binman reports that it used fake or missing external blobs.
 
 To boot from UFS, merge the UFS fragment into the configuration, select the
 UFS devicetree and pass the directory holding the DDR loader built for UFS::

-- 
2.53.0

