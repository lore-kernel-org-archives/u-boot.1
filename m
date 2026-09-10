Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562CBC79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 20:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F6C181193;
	Thu, 10 Sep 2026 20:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b_ubbJC1u8Rj; Thu, 10 Sep 2026 20:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 414A0811E7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789070605;
	b=AXMW+SKWklfh1TkDDd+YziR5H9d1aer5k66NpJ+3FzmIvOGl9STkEUQiMn5S7g9B0pkf
	 pox8+32HxHD6CZibgk+Hwl6fsuyg1hBjn6Cw1ZMEKtQqb51Tn8gOdvNSGaeQw1B/ordw8
	 rg1tGvGpPrP7MkmFWPtVqahbit8TQjRUJqrqNjXp/ajt0XA7Xm0qw7fLFQL3vcsE7dqOJ
	 VMV7qFM0zppJsxHjxSGonrJomRgLNFbP/NakbvqY+gLZmfhXq2BT51ZAuT0nt1NKEW0SL
	 sIxO2FQ06bJ/cztbiuKKw4ogscXYeMUmYjoPocMKqKX1zAdV7fe7iAEaRLTc88tJxAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789070605;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
	b=eZKISq3P/WjewFQY17KX+aCUzj41WIwSbPA2A4jtdEc7tkCEiSYmulAzfucNXOcbHCj/
	 C96wloP2olXMP0NE6odxB94D+lEh5UzQ9i8idL9VmXaoRL4FpLHsnWdSw3ftzSXfLGPVg
	 rkujTwX/aNme2c6w+57MD9PWbs8dMLccwp6I3vWuWYJmru9w/yPR1ergYMsqraLMmn5iF
	 Rqo9hw2dEZuqZ6HHaghX6RUz9ezcXiTXqXfLLxT+vrAo9ZCu+Mnvo9aaKYyyJxNzy4c9R
	 Itd+N3b8yEWIN2cY5Lxk//9S/EoSlumcYNoS2uWwDONLZ4PfH+F9kWcuPLdiwEUlEvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RMlh6wVX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789070605;
	bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ziAH3lMtVrSr93VTMDJ6jNEehQQQMXl6jcyqhTqMKVNEe+WJytJdDxQnBnTEFf21d
	 U4QpuC9vXoJASHkaFEROAxLXPsrZexssZsrR7gWv6dBDGS1sFbpfxWubBgl3PfRY0V
	 Kn+4RUbBmgJGc9lohNye1PQCqXc5CA4ChRnG1AnoHrWrwAv84ZuASmmAdppXil2w4G
	 RBdVwNvrthTrUroK5H8hc91GoPHfouUoTvT3IWyRX1RIIX89s9lKwqMyrOfegAodVp
	 Z4JHKMUbUbrfrLJ3Tf/6J5Et4YUevsxsM6t89JFrZDjTEZGYvrLsZYcUu70HRUazhQ
	 WGaUQIsGSWf8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 414A0811E7;
	Thu, 10 Sep 2026 20:03:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A6D0514D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98D06811E0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RXAG00-5EPZU for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 20:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 997AC81114
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789070599;
 b=CHsha8ujN/mCBEaCdKR+yUm6dFz+NH0y47YIypzYsFKbOJaMrpMOCcI3+Ewhe/F/vL2s
 kdp6DCJuAo6gCiHur1MpRU+l095rOk+Rx3gAzpDSzzi5cgGgho9gTmizyWWLs+eYiKh8F
 r7altwsfIqdn9fGkaZJB3/9OxYJDOarpNVfuIRcY6tjgXj0hN637IlUcqcyEhMGuWKGFQ
 MT/HMSh9V4qpdHCzSZQDUY8v12hGs1VMDtkMCo/TZzyIP/snIE3YEdjVGGqkbN7YBcQeQ
 8pWCYLs00HX+p0BFa7erzSj27o4ajVibQbpS0RdZjphjuCItsGVJaU5YJBrg8lHbfIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789070599;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
 b=OuFM1kYJUKV7C5/xnGQF2zv9HMeqTHNO+gx4jqCTXkxxBoEkf4cnL3YJLkpRunu93OJr
 LK+/N2Z6iisskjhzQIZBUzxZcj2KhYXXrbD4bv+pM9dAMVWtQw9ecv4+ycH3BQMA52SyF
 RcKGDplSOFnaW27CittbsV/MuoxJ7NLWv9EFxrZ3eQpLVPgpKFVlJNcXMdRxSNfWGy+Ht
 8WFGU2TObERqPFOE1sYXQ4+zAjK2P/BUQc9gYYh8KiQ6PRuom78YwnHGa5mtxOZcSgz4m
 4L1F6CvXcmpbdH8XAKI0k5yfRBBmZxicg/GBPfPum657sQU2E076dmy4a/KVozx8qPQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RMlh6wVX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=RMlh6wVX
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 997AC81114
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 20:03:19 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b3a61bdf22so160740b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789070598; x=1789675398;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
 b=RMlh6wVXVjyfrdR5Xyz7W5jhp/7xsOTwmA1UqG3IU4MX54X4WtbNOs9gPQwNW/dHvq
 ETl5skQeGMFsFEVbp/M3VgwTcCONsLK/Os1c7ulSfSsfhtgqgXZ6HhrkrDPn0fZZlxh3
 jzWQpyEg+J2zTItba29n2eMRR+7WUjeh7CsSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789070598; x=1789675398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VxcZHRhXyZjXWFw5fTwzwYanmFn4gqjohZ8NmcLOfqE=;
 b=LdFVTxgQ70dPfYkhq1gclU4vyVqfHEsBaajB7csaHtuFH6UQVEjOKk4rQKMXEycBsb
 3JFCXb4tdxOHL477qUvvqEyhEKsTLI/Ng1U7dXMR/zvUZA7QleTwB8eKjVJQguCDKoRB
 W4bjtJDJfnmg5JrrJocDKRxBbAiB6wAuVQjPIS3z8Re8YHpSA9F31bdLEqjLCS4Ph/NS
 c5NShh6Io2AjaoiqKyqK4QAFwSLIGGuT4doOgwlXLVwNFZoN7+UJcSmxYS8tD9zE5MRu
 rIr0Tk25nToLpO+UKSTDIelx7v10CLMVZorcyBCChsEoKPyHF7gEeDpalhUxvks+LQdj
 twIA==
X-Gm-Message-State: AFuF++k9h1QgDLqu0TQGqBN2jpgZ3JaY1NPW2tnnemNaD3rmFYmGU4LD
 cdtkC2LsXF5C0hewSL2+7veEKZSZRVl9WMJqeolkNYIlj5UG9N3gVXMJqBJ+SNHqYWNXG+ju9Pd
 d+N7xbLvEWYdY
X-Gm-Gg: AYBFou3NyjTkmiIV7MVArO8fB/loetD0EYIYWHSM1SbRm9Hj8WNPxxJZIuw0eNx1q/L
 jTv9XUHh9MoNKZ3P08iAlboy+ctMyEeoT9eNqANm2vXFr9Le6kLMgNbwpdnZmm6iV+OEcg6qKFv
 XvoKgB+cqeSAGwVKBLg541aFzpRJloze97BJrQWVsWqkUTIqLB7GhEI32P7dVuDX0FV9gZ9DAPy
 l2RHkddNmp8ljoxXaXK+cg0i6bezZHkRSok1GUYERcFJ82xtpHulD0lBY1XJJHm2yEVDMsuuFDx
 9CZL7VEcH2ig0cm1I+cMBw/tepdsHz8Q51c70z0pK2NsfVnZYMpRjlfGIKtVfM3NOA9b3pCSEgK
 aSdbTn86K1gyNvTQbAdNRjkAbKeSxDl6InfW0wbzqXKAkXokzaHxJ6JwwR1EQiAm171/zb+rIM+
 TUIRh6gCypa8Ga1SR5SSdC4WkMvP8zER8ZaGiEXBwNdK4AD7LJoS3ztsVEFnljASgnMfWIeLCNr
 +B67Ky2+lB/rxOFyym9bJQnJAZmc/W+4gXMo2DKuDw0iGgDIHjjbcTyqHSSkkDxuXTfscpzrxwh
 2NPX+A0/7kwyFw0w82zDB55AHMHlM9o3DGZsYq+e31weFSyas7BjM0E=
X-Received: by 2002:a05:6808:5384:b0:4bb:e62e:49c9 with SMTP id
 5614622812f47-4c31bceef3cmr513142b6e.28.1789070598124; 
 Thu, 10 Sep 2026 13:03:18 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc937bsm208357b6e.11.2026.09.10.13.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:03:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 5/7] MAINTAINERS: Correct entries missed during renames
Date: Thu, 10 Sep 2026 14:03:07 -0600
Message-ID: <20260910200310.3503830-6-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910200310.3503830-1-trini@konsulko.com>
References: <20260910200310.3503830-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In some cases, files had been renamed or merged and their existing
MAINTAINERS entry was not updated to match. Correct these places.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 board/amlogic/p212/MAINTAINERS             | 2 +-
 board/amlogic/q200/MAINTAINERS             | 2 +-
 board/amlogic/s400/MAINTAINERS             | 2 +-
 board/engicam/imx6ul/MAINTAINERS           | 5 ++---
 board/keymile/km83xx/MAINTAINERS           | 6 ++++--
 board/qualcomm/dragonboard410c/MAINTAINERS | 2 +-
 board/qualcomm/dragonboard820c/MAINTAINERS | 2 +-
 board/qualcomm/dragonboard845c/MAINTAINERS | 2 --
 board/qualcomm/qcs404-evb/MAINTAINERS      | 2 --
 board/renesas/eagle/MAINTAINERS            | 2 +-
 board/renesas/grpeach/MAINTAINERS          | 2 +-
 board/renesas/v3msk/MAINTAINERS            | 2 +-
 board/samsung/starqltechn/MAINTAINERS      | 4 ++--
 board/wandboard/MAINTAINERS                | 2 +-
 14 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/board/amlogic/p212/MAINTAINERS b/board/amlogic/p212/MAINTAINERS
index e73a4e52c1fd..869264285c37 100644
--- a/board/amlogic/p212/MAINTAINERS
+++ b/board/amlogic/p212/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/p212/
-F:	include/configs/p212.h
+F:	include/configs/meson64.h
 F:	configs/khadas-vim_defconfig
 F:	configs/libretech-cc_defconfig
 F:	configs/libretech-cc_v2_defconfig
diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index aece8d5e05c7..dba49eb33248 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
-F:	include/configs/q200.h
+F:	include/configs/meson64.h
 F:	configs/beelink-gt1-ultimate_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
diff --git a/board/amlogic/s400/MAINTAINERS b/board/amlogic/s400/MAINTAINERS
index ca51bb6b3ba1..2b909f4b276c 100644
--- a/board/amlogic/s400/MAINTAINERS
+++ b/board/amlogic/s400/MAINTAINERS
@@ -3,6 +3,6 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/s400/
-F:	include/configs/s400.h
+F:	include/configs/meson64.h
 F:	configs/s400_defconfig
 F:	doc/board/amlogic/s400.rst
diff --git a/board/engicam/imx6ul/MAINTAINERS b/board/engicam/imx6ul/MAINTAINERS
index b9c6af27245c..a1b5b1778421 100644
--- a/board/engicam/imx6ul/MAINTAINERS
+++ b/board/engicam/imx6ul/MAINTAINERS
@@ -7,12 +7,11 @@ F:	include/configs/imx6-engicam.h
 F:	configs/imx6ul_geam_mmc_defconfig
 F:	configs/imx6ul_geam_nand_defconfig
 F:	configs/imx6ul_isiot_emmc_defconfig
-F:	configs/imx6ul_isiot_mmc_defconfig
 F:	configs/imx6ul_isiot_nand_defconfig
 F:	arch/arm/dts/imx6ul.dtsi
 F:	arch/arm/dts/imx6ul-u-boot.dtsi
-F:	arch/arm/dts/imx6ul-geam-kit.dts
-F:	arch/arm/dts/imx6ul-geam-kit-u-boot.dtsi
+F:	arch/arm/dts/imx6ul-geam.dts
+F:	arch/arm/dts/imx6ul-geam-u-boot.dtsi
 F:	arch/arm/dts/imx6ul-isiot.dtsi
 F:	arch/arm/dts/imx6ul-isiot-u-boot.dtsi
 F:	arch/arm/dts/imx6ul-isiot-emmc.dts
diff --git a/board/keymile/km83xx/MAINTAINERS b/board/keymile/km83xx/MAINTAINERS
index af0d6afb2b44..291d4f053355 100644
--- a/board/keymile/km83xx/MAINTAINERS
+++ b/board/keymile/km83xx/MAINTAINERS
@@ -5,10 +5,12 @@ S:	Maintained
 F:	board/keymile/km83xx/
 F:	board/keymile/common/
 F:	board/keymile/scripts/
-F:	include/configs/km8360.h
+F:	include/configs/kmcoge5ne.h
+F:	include/configs/kmeter1.h
+F:	include/configs/km/km-mpc83xx.h
 F:	configs/kmcoge5ne_defconfig
 F:	configs/kmeter1_defconfig
-F:	include/configs/tuxx1.h
+F:	include/configs/km832x.h
 F:	configs/kmopti2_defconfig
 F:	configs/kmsupx5_defconfig
 F:	configs/kmtepr2_defconfig
diff --git a/board/qualcomm/dragonboard410c/MAINTAINERS b/board/qualcomm/dragonboard410c/MAINTAINERS
index 9c10fa3053b0..a8eae9a05485 100644
--- a/board/qualcomm/dragonboard410c/MAINTAINERS
+++ b/board/qualcomm/dragonboard410c/MAINTAINERS
@@ -4,5 +4,5 @@ R:	Sam Day <me@samcday.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard410c/
 F:	include/configs/dragonboard410c.h
-F:	configs/dragonboard410c_defconfig
+F:	configs/qcom_dragonboard410c_defconfig
 F:	doc/board/qualcomm/dragonboard410c.rst
diff --git a/board/qualcomm/dragonboard820c/MAINTAINERS b/board/qualcomm/dragonboard820c/MAINTAINERS
index 7ef905bdf69c..08fdb9903414 100644
--- a/board/qualcomm/dragonboard820c/MAINTAINERS
+++ b/board/qualcomm/dragonboard820c/MAINTAINERS
@@ -3,4 +3,4 @@ M:	Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
 S:	Maintained
 F:	board/qualcomm/dragonboard820c/
 F:	include/configs/dragonboard820c.h
-F:	configs/dragonboard820c_defconfig
+F:	configs/qcom_dragonboard820c_defconfig
diff --git a/board/qualcomm/dragonboard845c/MAINTAINERS b/board/qualcomm/dragonboard845c/MAINTAINERS
index e555953df697..3b5c63459fe0 100644
--- a/board/qualcomm/dragonboard845c/MAINTAINERS
+++ b/board/qualcomm/dragonboard845c/MAINTAINERS
@@ -2,5 +2,3 @@ Qualcomm Robotics RB3 Development Platform (dragonboard845c)
 M:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	board/qualcomm/dragonboard845c/
-F:	include/configs/dragonboard845c.h
-F:	configs/dragonboard845c_defconfig
diff --git a/board/qualcomm/qcs404-evb/MAINTAINERS b/board/qualcomm/qcs404-evb/MAINTAINERS
index 0a2e194ff608..c6c672d6c3c4 100644
--- a/board/qualcomm/qcs404-evb/MAINTAINERS
+++ b/board/qualcomm/qcs404-evb/MAINTAINERS
@@ -2,5 +2,3 @@ Qualcomm Technologies, Inc. QCS404 evaluation board
 M:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	board/qualcomm/qcs404-evb/
-F:	include/configs/qcs404-evb.h
-F:	configs/qcs404evb_defconfig
diff --git a/board/renesas/eagle/MAINTAINERS b/board/renesas/eagle/MAINTAINERS
index c28b6502478c..8b458a3ca4d0 100644
--- a/board/renesas/eagle/MAINTAINERS
+++ b/board/renesas/eagle/MAINTAINERS
@@ -4,4 +4,4 @@ S:	Maintained
 F:	arch/arm/dts/r8a77970-eagle*
 F:	board/renesas/eagle/
 F:	configs/r8a77970_eagle_defconfig
-F:	include/configs/eagle.h
+F:	include/configs/rcar-gen3-common.h
diff --git a/board/renesas/grpeach/MAINTAINERS b/board/renesas/grpeach/MAINTAINERS
index c0f4fbcbae16..37a3df5f2b52 100644
--- a/board/renesas/grpeach/MAINTAINERS
+++ b/board/renesas/grpeach/MAINTAINERS
@@ -7,7 +7,7 @@ F:	configs/grpeach_defconfig
 F:	drivers/gpio/gpio-rza1.c
 F:	drivers/mtd/renesas_rpc_hf.c
 F:	drivers/net/sh_eth*
-F:	drivers/pinctrl/renesas/pfc-r7s72100.c
+F:	drivers/pinctrl/renesas/pinctrl-rza1.c
 F:	drivers/serial/serial_sh*
 F:	drivers/spi/renesas_rpc_spi.c
 F:	drivers/timer/ostm_timer.c
diff --git a/board/renesas/v3msk/MAINTAINERS b/board/renesas/v3msk/MAINTAINERS
index c198cf8c9b89..062133b0259e 100644
--- a/board/renesas/v3msk/MAINTAINERS
+++ b/board/renesas/v3msk/MAINTAINERS
@@ -5,4 +5,4 @@ S:	Maintained
 F:	arch/arm/dts/r8a77970-v3msk*
 F:	board/renesas/v3msk/
 F:	configs/r8a77970_v3msk_defconfig
-F:	include/configs/v3msk.h
+F:	include/configs/rcar-gen3-common.h
diff --git a/board/samsung/starqltechn/MAINTAINERS b/board/samsung/starqltechn/MAINTAINERS
index 135cafdd69ca..7ca1a9bac896 100644
--- a/board/samsung/starqltechn/MAINTAINERS
+++ b/board/samsung/starqltechn/MAINTAINERS
@@ -2,5 +2,5 @@ Samsung S9 (SM-G9600)(starqltechn)  Board
 M:	Dzmitry Sankouski <dsankouski@gmail.com>
 S:	Maintained
 F:	board/samsung/starqltechn/
-F:	include/configs/starqltechn.h
-F:	configs/starqltechn_defconfig
+F:	include/configs/qcom.h
+F:	configs/qcom_sdm845_spl_defconfig
diff --git a/board/wandboard/MAINTAINERS b/board/wandboard/MAINTAINERS
index 3c2a06cf09bc..f5a6db3aa9e7 100644
--- a/board/wandboard/MAINTAINERS
+++ b/board/wandboard/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Fabio Estevam <festevam@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/imx6qdl-wandboard.dtsi
 F:	arch/arm/dts/imx6qdl-wandboard-revb1.dtsi
-F:	arch/arm/dts/imx6dl-wandboard-revb1.dts
+F:	arch/arm/dts/imx6dl-wandboard-revd1.dts
 F:	board/wandboard/
 F:	include/configs/wandboard.h
 F:	configs/wandboard_defconfig
-- 
2.43.0

