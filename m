Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2B606A69D
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lJG4Cpz3;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=fPdJ9WCm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82E6A8186A;
	Fri, 20 Nov 2026 21:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R2r6Kr2Jm7Ol; Fri, 20 Nov 2026 21:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5372181842
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795211460;
	b=oijdomnRyqMhkzxPLTIt8ujDgc4lORhIPIMpmLoYKNusSpfT6UG0Zc2u6FPhoLEfwp+a
	 f/NQI7va8g/ms9Ept5DbG+mkmjf8Z3w4I0gopsnYy1okYFKM06HJXkLFmnZIuxaksq2bm
	 YY4sbsO41FMICUlNaYQMxhlAB5cSpmXbzKQ11UshBz79uYYZ+7ohmEC2dwJUXhqdCp/Rt
	 y0K1rxE5x1YaqQ2YQGfoRE1jSl+Ortziq5a7bRxXa+6IkLGYVFGJVA6814odJ5k2fwmlg
	 oSobUYWfU3MrFBZaUL04VENpJrwOS9YHbfAoVPAZJm/CZ6kMojmech623fSLpzQRFRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795211460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UaNUWv1K0Q1dCUNIOhmFTZjcYerAZbB9yVouEDkWZ38=;
	b=OsHnKeyucpLS4v2NZIZUGaVe6vPYpjuwsQDFzWKgcE/olLO+o2kArltl2XcrEYZ0dTQT
	 ciKt7leAWSAtJGwqVqX7CatkjnbNik6vIPsn/+iwjweeETCoOONOh9H8qlFMffb83cJMu
	 BT0kAv5zBcl6/cqEXf99H2Rr/5v4RdHpeQDWltY7/E379Ar4fzWul0ExrYRG/idSmYxOF
	 zPYgrEfoe/lMsclX1Z6YW9buLrlvIbtcVyQlT2HuYiWMfec87dOeS1xZGry16uq20mY55
	 KPi3of4wAHkNWZy0IqWLEfts1WTkJkkjqOkWOQhiU5xwsnT5H+kuX+29F7jQ04c4gkQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795211460;
	bh=UaNUWv1K0Q1dCUNIOhmFTZjcYerAZbB9yVouEDkWZ38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lJG4Cpz3PxGpVAf4FsSNFNTmLqVYvriuuxI4QsH3bbpMDE9LG+49UFOFwT2UFWhFq
	 btN3ASnSs3XIR8XeORYp1JRE+lT8CM3o+QpA8UqRw8IqsKE0t1bh0wni+D2JvywlmS
	 7bRjO7Pq8MPV4/XLwG9mB8kAyI27I7/iGSC3YWSAb+vIT8B7SRe6R9k8QAAWNArOYh
	 2BmluK7jvvwNGdT5xzik7l32AspOk0PRUn7RLtdbbzLKwGp9NBsDO2G/M5M1MZTVBC
	 1UIijDJ9mkZAns3vARk1UoASJQPddwYtQ+3bvgfHMSwfd+nhBhG13TyNdQYukfvWKC
	 eFvzk1wXfrDpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5372181842;
	Fri, 20 Nov 2026 21:51:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3D92759
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA27260EAA
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrglyPwnRn1z for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:50:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04768606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=fPdJ9WCm
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04768606C4
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:50:55 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4adae3eb4d3so603301fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795211454; x=1795816254;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UaNUWv1K0Q1dCUNIOhmFTZjcYerAZbB9yVouEDkWZ38=;
 b=fPdJ9WCm25DNfjZVYcOvZKcgNxdVh0mj93tkofymtrkUyQkrpWi4qXhuR6YoXGH87Z
 rMcne+zz9N/ImOhlnCyDfbR2ceQlcR8zRzMGpLvjUXDMwMXuRDc8EC4d1UFyNJI4Bc7P
 3jL7WCX0nfSqOIbh5/Vntx212Kb83VmP0aG4ozS9e2eKY/ulRb2yU8VqGPkDmXEn9VeR
 Bow6PpbQJC4wqRKjgJdvMU/I7MHRxMCDzjqnHs1JHi2Bse+EQBHlEXbYWQ/PFtVGQVJE
 +s4yj+ACTda5/GZ4xqrZehf3yBtbtED6vTA8qxUSymud1duDDpvGp4ABv622gjVrMFGd
 vB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211454; x=1795816254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UaNUWv1K0Q1dCUNIOhmFTZjcYerAZbB9yVouEDkWZ38=;
 b=ELJ4R+ibCrPSQNsFcfOk/Vr8RpxCMWqeKQ2v0LfGhH/C+L/qghZ/YLm8f6sufFfrKL
 BFPeQL22x2W1CJotxdsvBid4aUbuNxIJYJWwzDHTm/T5+C5dmGe4Sp6YEt+iKK2qN3Yu
 Eg64kuVbcivmH0nu1yjruEWQ+QKKj28WFKWpYB+kytsh0j0GUSQe2G/WupJg8Pg4Am+n
 UcRswZ41wkWhkI/PjCe/1X+NH7YGUZ/FzbJB1nRl45wskeMW59IXBtmIl6ygqwnO/Xqj
 Vl3feZTJQ5knMh+Jp18fC/kEXFbsfaRYzwd3rvnlGgv7VCe/p67+Pduyk+Xs7rv9BRa4
 RBig==
X-Gm-Message-State: APuU4Z+GX+smxRueTcPnN8rx+YkmZ0J8ibjGzIhThkpDDFDkeqJPpx8E
 p+SSjEF/4CHx2yyG1kEZ6+a4noNcUHVTzh9cw2S1LAetLlLInnCISMgcuOALwLptsjMa9m/aTRE
 N+Ie2
X-Gm-Gg: AZFdTZeHe/3/s+yMhZTmCe6vZp1Vc5Ml11oXeZOCBWKHk+3rm55v00QV8bPy0jxjwsb
 ngwaXeci51Zcif+uZo2TwABbLiWRxULwre0a3PgONF15ElNAvlKlN+NZwgCRypGjYIAThUZrS6G
 mKOeJDbELUc+HOXMj6tEBzqRLkAkcubMVeiCoUjn3/b2mVOT8Vawna8ZcFwCtLt/6GM9+TLiLwv
 P2SXiB7ZEwTwtPb+m09TaoP+f2j/CgaTlglpilbtiyBJ+BPV71iyN04RE91Vb5cU01ANd9W54CV
 HMMGbPFc++sQtuk580l0PxlQ6Us1VIyGHZ7lxwhFUh5oiF4Egeyej2SX2qI2bOkIS5PUMU+YExu
 X2Ull5aJ4PPx+2n2MpsD8vOY3qQ2FaUJ1ZIE5+OjfOTXR2gatGsdcwn4Xbsdxg2E+fPVQALAbsO
 tFkU+r/GiNsdybK92Db1dIt/O20OTEdiCqMPZLjiuuJzyUfJD+77ZwcUdecCxrhEVG7hjM2EBPW
 3hzxitL2FN+qfytirMnLuDrxsqOD/1bQj9BHIMstvbnbZcQifzgfU3XKmI4yQNWL+F38Tuzz9Rd
 JM8DHUjvYajtQlOXfK25WXAZfMC/E1bC
X-Received: by 2002:a05:6870:4692:b0:4a2:4e0c:593c with SMTP id
 586e51a60fabf-4bc8386b8ecmr4982070fac.33.1795211454608; 
 Fri, 20 Nov 2026 13:50:54 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bd044fc4besm2846726fac.7.2026.11.20.13.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:50:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 15:49:34 -0600
Subject: [PATCH v2 7/8] board: mediatek: add a Genio 520/720 UFS boot
 config fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-720-spl-ufs-v2-7-3ef93cb27dcc@baylibre.com>
References: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
In-Reply-To: <20261120-mtk-genio-720-spl-ufs-v2-0-3ef93cb27dcc@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=w0QuaBb2hculFRoBLawWvYrbxnYSLs6wqnzlXdC99Z0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMCeES3q3507waC/F02Q97yI1+BpeaDq8oise
 /JoMDCLlf6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDAnhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AeaYH/1JHLChM85VnZQCXqTsrDlb0HkD+QJVkkUEmyeH
 aIxEsuwRS0dsBpewGB0fuHsgrZAfJd5seq7m7SsvLE4oEk4wPsCNSfBMEfbW1kvDBOj+qzwLLh9
 rmd8cjbd0LdgK4icyI8ZsElKEVv64lQG5SmvQsow6pg148qKhEQZVE3g4oGNpgWUmliykX4en7A
 roWIkztkHyGXaxTXbBWwmTitrJ97GT8MosUF6zpBX/p9x9ouOfiVlo77/4mOs9hQFvYRWCz0CsK
 Oz1/d31UzbVB927ulf2zIOo0O/uUu0AzrI+YC8Yv8+by5vlSRfHlMxklYnjwMMz4BleD1br2jzZ
 iVdE=
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a config fragment that builds SPL for booting the Genio 520 and 720
EVKs from UFS. It sets the BootROM image header to UFS and makes SPL
load the firmware FIT from the bootloaders partition (partition 1) on
the main UFS LUN, which holds the GPT and is SCSI device 2.

Disable MMC in SPL, since SPL would otherwise pick MMC as its boot
device. This also keeps SPL small.

Use the fragment together with the board defconfig, for example:

  make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS                 |  1 +
 board/mediatek/mt8189-genio-spl-ufs.config | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 9bae3303065..98a3d889a3d 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -6,6 +6,7 @@ F:	arch/arm/dts/mt8371-genio-*
 F:	arch/arm/dts/mt8391-genio-*
 F:	arch/arm/dts/mtk-genio-*-binman-u-boot.dtsi
 F:	arch/arm/dts/mtk-genio-binman-u-boot.dtsi
+F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	configs/mt8189.config
 F:	configs/mt8371_genio_*
 F:	configs/mt8391_genio_*
diff --git a/board/mediatek/mt8189-genio-spl-ufs.config b/board/mediatek/mt8189-genio-spl-ufs.config
new file mode 100644
index 00000000000..884b9b97a44
--- /dev/null
+++ b/board/mediatek/mt8189-genio-spl-ufs.config
@@ -0,0 +1,10 @@
+# Boot the Genio 520 and 720 EVKs from UFS instead of eMMC when using SPL.
+# Use with the board defconfig and the -ufs devicetree, for example:
+#   make mt8391_genio_720_evk_defconfig mt8189-genio-spl-ufs.config
+#   make DEVICE_TREE=mt8391-genio-720-evk-ufs
+CONFIG_SPL_UFS=y
+CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM=2
+CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION=y
+CONFIG_SPL_UFS_RAW_U_BOOT_PARTITION_NUM=1
+# CONFIG_SPL_MMC is not set
+CONFIG_MTK_BROM_HEADER_INFO="media=ufs;arm64=1"

-- 
2.53.0

