Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C931FCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 22:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 884DF605CB;
	Mon,  5 Oct 2026 22:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcVe6KpXnA0x; Mon,  5 Oct 2026 22:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C834B6065C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791238435;
	b=X2+8EJG4xYISECjRBWJAoGHvMvxbuw6A35NUD0twX6Q9DmJ8trlJyXowdcswWChqUhgI
	 4WJQZf/8/x6qJhFYoCIxZyJH1sND/BNEJBLKgmNck67Pmh17XbECumkSl188EcfLTD2GU
	 g7IdB9W7tkUlfXXMq+lTeaovAIoRILTSD/02pKzIIfyYwpcka7qWM6egDiVjSZQR6g+aK
	 VXe9qbgArNv2pqBGYOgNx0LZFoWLM8WpXm4bTSqwvb7Y1Hvtwo0A6h7r6gN61W168RF3m
	 gUX4rhF5vYGBN6+jp1A+eldomlXBEcs/KL4POu8SQ9H0D43PkmvyZO8zqSBZIwg3NNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791238435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cr9oKLkixbcjy7iUzUw2ACeFyBgPfOlIa0YHUZQYeGY=;
	b=QReq1C0f/srPa2qgjZzaZR1EzZigzIrbDOSoxGZuUEruDXl7sGvurIgPHr9ErqCDHifd
	 XmX1la/SJgb1JICvEjpjFRDy7obHWxZplwdtxI0PRUOJv8S6A50Vrhd0a7U2iRKnqZG1r
	 bawo8Ap7ykK6RoAQNarECMOpDP5s3og58yhvn3QQHOQGG90pWmfFV4DVTcEEqozYBqtlR
	 ovXb8hTg6R8x8kegVj/4+3LYQurSJlHyiSO+W5/oTfAGK9hJJlFTLeIvzAXAGvQhT0ZwA
	 FERXgsl/YaBwu9bjf5av15UdflMoi9oLB/Rtbx5bNOv6DS1TzoaoeOyz2z5wmyUbIIw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791238435;
	bh=cr9oKLkixbcjy7iUzUw2ACeFyBgPfOlIa0YHUZQYeGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=is3XNENJ5CLYvgubsYWGm2ydAoDpewgfJDmUJbD5M/sG0M6lO63znY8u6RKGOw9RC
	 4CU5afd2QpxnJkRkKl73w+Nn1gds8vy3orizqiSSGHOLymGVGaWkn1KxZHUFDDvG0Q
	 7bOPBl6qXYcUVkBltJP3xRgfoLMgdzX8JS51a2paf8TJATVNkmYQzf2B9D8ekgzFir
	 p+A/zo9+fWqhFvzitCOw1/fLz/GL0JRKtMgjSi0MH+9KjusJMhACN/lBbGFgHgH1po
	 gzSRn3T/TXJN18biEUcKZ0SMDcD7qtfL97GayTFIweHBXUd/E3txiFahGnfdqw/n/6
	 Bno2i4NjMiTHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C834B6065C;
	Mon,  5 Oct 2026 22:13:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 197121A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AEE94008E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ic_Utj8Ky8vr for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 22:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 27ECA40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791238110;
 b=fRj9JN66nbmo+7MgZyNaYXw8HK0in/MOuQYTgcDPiQwNMh9MlioV4U2G5tpKgAim3gy6
 mCVxxxGqusIpbfgGbHGzp6zUd6lqavSn4H+TTAux7LwjHnppDk4cPjDeS170ND0ZU08Y6
 UVppl2vZpYwJvRSEm/7oEc2+MLUhFtA78J6EIJrF+NCOYLcG6bF70w8I0596OtJH94ZNG
 nFH33QU7GEhLPieNqGtmJXqwSt1Nd6RE90xR06Ku8JGuMLBeE/6hMSKEkowH2ICe1QKKX
 cEHH1dQjUkXtZablVrKdTphg3NgklJ2R5eEXMgEmH8W0glkkK4HeL+hDu4nuBOsWdPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791238110;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=cr9oKLkixbcjy7iUzUw2ACeFyBgPfOlIa0YHUZQYeGY=;
 b=R06dl+1X9tX4M2ELdPj/g4J9sU99zQlxfDazY9csRxUghukcO56/wmUFECv5TVN8VZWn
 rPjeOqwnmqR5ZqPBBPxRqqoWgY3SOpCpCsPuvDk1xIqvEqmU979Rn9KtUlxLEKmsWGgNN
 S6TdQlB3pUlJgNqXshdb7ujEy3e3JbeULoOjDrbgm8QderFbsynQRysqdngg4kcUIl2DP
 c406TREVsiMjbAa2kymONgPQVEjtJaAym+9Fa+nkFLgw5+jSzZCd0wGvfBCBT28VpCw49
 2kfzNqKRv2QY+W6DE+7BfkHLfR8psHSM3Ji7sjqCRMVi4p9R7PXK6tCIW5lc/SdZ+hg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="QJWOm0/y"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QJWOm0/y
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27ECA40042
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 22:08:29 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6d821901872so184526eaf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791238109; x=1791842909;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cr9oKLkixbcjy7iUzUw2ACeFyBgPfOlIa0YHUZQYeGY=;
 b=QJWOm0/y+pJvJgKIhEqJJ+omKb32miL8gLyLP1SGjRTiu7QMvQHaoogoRUrmEQN1WN
 /yb/7MWxBPtfG+ZgvhHRevYFTKGkKdq1kRSrx80cnckXt2/dHuyYyTn41ZdEvHeMOrHS
 qkn2TtxvuY3hjyGfGkcp6r7Xe1LXMvsfPrikBmmsyKunwUAIvTtOAjzXZYH4vR3TpDT4
 +SY8WNkUBRdqtdo1LnWqYMfB6qDlAhO0HFAl8kPhTKpBl16p/EhatGWga47ZdJ7NM2ct
 Chw0Q/lqCBxGEdAsPrT7e+bxDZh3qxBSlPiODfn8SucupnyFfZIpw5UlRMxH9cTG0UFY
 YLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791238109; x=1791842909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cr9oKLkixbcjy7iUzUw2ACeFyBgPfOlIa0YHUZQYeGY=;
 b=f+gbY3O5BdLqKx+TlYwshsm26sMFKXkaMq/bVWpblTckM3SOgJLrbySzi8GLnyUROf
 DXRvzEwZ7IkRvLyxsWCstRgdhvJq2Xnn81kLJ77RM5RmkbjNKSGC/iCvh4oHLbyRLvq/
 kAkx6QAhnzj4LP1yFjRcIo+9odFO9wtFrYVIwIoktUk49xwQ/oRZdicntPNFFWiND/mr
 G55/P0ernJdx2VRchPjXuRtwTQtRYf9eKQHQzgDYZtbJXruVwyGNCS7nPePrwy8OWYHl
 trAyuDyJ3MAeS64Xoxj0qmbBFyO057kpLqhoiJQTTt1rcOFYYFuuzttHRHdhD45AIlKZ
 6v+g==
X-Gm-Message-State: AFuF++mNk/9dGkzAXlN7g+DS23zAD0Yd4NFQpuwP20iZN8UfkYsxE4Gw
 yv04238CsY9ngbpiiZvphVrTgwDAlGhC6llMv0ev7AxHNfwrTFtyeO/jyNyWWNEhG9M=
X-Gm-Gg: AYBFou0Qe2vQ1voUZ4GCr9Q/TtB2PXZ8qY+dR4ouQY41sxlHzt7iTdgN/8OqcTTrFNG
 pzdZZa4DoubdQeOfYgSxwTFJim2jIwe/RFTt2yErJ1O2q5l7cv2WnjTG6+hlHs3rBlfKRn2OWC5
 CxbDAbF7CbnWjdligjETpLTQQ2xOMDFhuHDjQBMVPynJY2jAeAzEW6CnUD7E2POwsAgecM+cBYp
 TbW8XbpO3A4/z9i9YB5kx7nxS3DV0gsht9CkyfGJlcpwd3KCCDIpCbG5oTChFVnKnCG0HOt1dlC
 fPCqYFlSsUabcvzybm4ej0PNHrDr+7Cnga0pqdxPuuXPhnio0cKTIdF1Yb5GPwTjGWjvfZWazYp
 UuCZLmaAWydXwBi3aAN3eagvrb4PeGduqT9lmye3GEjXxikY/yAtJjF9dA347EzqYBCw5uPaK9m
 nN8kuxav3/ui6LLi8aCnX96Dq59J3F42uVokTk5y9IzuBjdS6UZ5oguCkjZXT5bmVPtEa/g2Jy9
 jQ=
X-Received: by 2002:a05:6820:179b:b0:6b5:ec2f:3567 with SMTP id
 006d021491bc7-6e4a64f9274mr632150eaf.24.1791238108675; 
 Mon, 05 Oct 2026 15:08:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:33e3:ea0f:8b95:f69b])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8281db4582esm655718a34.3.2026.10.05.15.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 15:08:28 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Oct 2026 17:07:50 -0500
Subject: [PATCH v6 4/4] board: mediatek: add Genio 360 EVK defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-mtk-genio-360-bringup-v6-4-630f99bf3ce3@baylibre.com>
References: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
In-Reply-To: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2755; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XczBuINtonnQ63yyX1ZtZ57na7UyEKCtDfuAI6chv0U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqxB/Q8aB61PJkc63XvzqlkAAoFQvoz6FiNhtHc
 QJOffM0ROiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasQf0BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AI4MH/jlsGZqgVzeJacol9Yjlee0StIxU9w4NYTw8k+R
 oleQ6sV8kRB7EVSLV3mGtlWBSUluZOlH8ceuuhB4NOK8n28XKr0GDOfIxsS9Zi0SqeIj6VkyU/k
 MSQubYxnwGAgL2zuxjm4lkHgmK38/M+5Jo/080jLKcc0BhlqJQaL/wr1iMHlzw4pave69vdSFLs
 VGy4ls/knbj/ESOeDsKk7wrkf+BPzW4J+y62oBi2hwj+/aoJoeuZUQ0L/Vjm/1sHWch/4hMY2YI
 7Cb/qfFjQ/4gPICtt/eYmIOGydJEIJEGqdCJUoMpVniV50Ys371iSwdZqtP7IdK8LJqPn1qXVPk
 g8Q0=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a new defconfig for the MediaTek Genio 360 Evaluation Kit.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS             |  9 +++++
 configs/mt8366_genio_360_evk_defconfig | 62 ++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 20befdba0e2..12fce9fea39 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -14,6 +14,15 @@ M:	Julien Masson <jmasson@baylibre.com>
 S:	Maintained
 F:	configs/mt8365_evk_defconfig
 
+MT8366
+M:	Macpaul Lin <macpaul.lin@mediatek.com>
+S:	Maintained
+F:	arch/arm/dts/mt8366-genio-360-evk-common.dtsi
+F:	arch/arm/dts/mt8366-genio-360-evk.dts
+F:	arch/arm/dts/mt8366.dtsi
+F:	configs/mt8366_genio_360_evk_defconfig
+F:	include/dt-bindings/gce/mt8366-gce.h
+
 MT8188/MT8370/MT8390
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 M:	Julien Stephan <jstephan@baylibre.com>
diff --git a/configs/mt8366_genio_360_evk_defconfig b/configs/mt8366_genio_360_evk_defconfig
new file mode 100644
index 00000000000..c0e83e34ee9
--- /dev/null
+++ b/configs/mt8366_genio_360_evk_defconfig
@@ -0,0 +1,62 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="mt8366-genio-360-evk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_TARGET_MT8366=y
+CONFIG_SYS_LOAD_ADDR=0x4c000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_DEFAULT_FDT_FILE="mt8366-genio-360-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_MTK=y
+CONFIG_FS_FAT=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_MTK=y
+CONFIG_PHY_AIROHA=y
+CONFIG_PHY_AIROHA_AN8801=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
+CONFIG_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6358=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_MTK_SNOR=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_MTU3=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.53.0

