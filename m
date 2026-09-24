Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49C3C98304
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 01:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C7D760B56;
	Thu, 24 Sep 2026 01:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EMA8bcsyP6fV; Thu, 24 Sep 2026 01:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2906260B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790214830;
	b=i5bP99KjLBOxgV7NgHBoxGsR0aEle21edt2zOAyVJUGLLcp8sV/MQNLTV0n3U/+Qlj8O
	 MOU6Ybtp1IF9Msfyzb/fkmlSpGnXKAGyjbtsb/pZHr9eUb0MrpnJXNXBuID7FpmTi6LD6
	 gB3WMITltV7xd+//jytr1L5uzc7IyRxfxcY1U7o5HzlBUENeGRvi8Dewy7DafJIHCMQof
	 IgkpyLgy0S5cPBz9PYNywEVwNnGxf5SvxbEmxZrkrrpTi05Xl0xSwrmhf1hXb8me3AS0r
	 W5PZ6DExoBvRiHAJssAK8GpDMzJIGhpHsyxqiDWYBXzwkdw1L1VK460ZJSLRO0enhcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790214830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BxFGRAsaEEEYuTeA+EjwH/PXfqCgBQ+HlJ1KuFKp9G8=;
	b=LlijhRNk4bfgg+gsAFO8miKgd6gSOf/tGr7287e46pwizYFUFCstkimuFFfaQZjpIzWR
	 Y+I5G2yxatIxNCKY1bkIYuJfrMdkraVAE5IB/4MykO+rcYQU6ztdlqswCGK41BQpv2HZP
	 s/03o31h09L/5Lo3f8fMRwNos/aQys3iR2eJNVL0bFSTpHVcxIZBJwzUHSjDLkpITfZPS
	 MRMuXwyzHWrMZ+B89ZJwgFyG6m99t/DjFPvhg+dt61Zae1e13apJBZndTqyyAoBjSLdgC
	 tMIKmSEwWCtQopBgBjKQi7eRUsW+zD3aQcLOC5k7apzgOUGJRscORf/SHYOd0Ujeolg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790214830;
	bh=BxFGRAsaEEEYuTeA+EjwH/PXfqCgBQ+HlJ1KuFKp9G8=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uzTbg7r40AK+Hxwd1Y47l+b5tnHtU6cvOml6tj4qbw4Y+jeCncRa02gVNmmKgK17R
	 gig07Up93rDJWSMv7GlRfzXT0LtsSmJGJI4ykRInlOG8Tk+xY9vRAHg7fkMaQx+IBg
	 EAmUQsvdxkNVwkSv3E7nOv/4oVQv6K8+18Eo89W7tdqnnNS8s47LHfveNSCSLCQDQc
	 eBfHhYv+rCsDh6JWJHskr8kU8l9KAH+v52+PAnLz9fa+xkCQtx2K58qnlAvccyhGrH
	 3mQMCsvdMhf9IDFAPpcZbnPUzVgSgbnwd0dk2YPBGB0rmlqwHsDrA1qDHP+/R4COFm
	 aVK6auzqIeMtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2906260B26;
	Thu, 24 Sep 2026 01:53:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A072D1344
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 870BA40E81
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dtwRqdUyorkB for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 01:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CA70B40E78
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790214827;
 b=cQGTpFFEJS1h/IbMRmu0cvBx9XExbQ/s3JNbrJR80C6BrWnOfKp1wjjiZwV1njNMGXEq
 N6SSbDvXKQVrMXAn+SGAd0uBSMOb10HjfAI/kOEiiiiV5PyKW24kI98beKUQUe7kmIrbW
 hLbFj7ccXXvRzuStJ6w+UjL5w6t5eiw7K2KHYy9L8/6e7fHDrNhGJbGO3YgIGir9mFy4D
 3TIc8QiMj+PorentWp0ibu7vx/Oe8vLHSQUr74D7EhrxsVZKcWpIYWAjglK7ejdvw9ejB
 qKX+qwSfbkUA+itNEZTiVT2ruoNoRk35UkkOAznzPuvZ92cZ/tnYaLepAE4LP72u+6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790214827;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=BxFGRAsaEEEYuTeA+EjwH/PXfqCgBQ+HlJ1KuFKp9G8=;
 b=NIiLgeV17X9TjRru95c1cTnnnNZbHUBgf8etfuGWkYUDnHLOCElTXyuedxUGmCqU8rzy
 xSKciKZHIVbOxFy79l38LjQ+DBVruOh8B7ovZ8gjJSiSIHCiDFJZqVPpSWPCArkGMzqC3
 qcDstZwljpj/kYcDJuB8+BPMKorQW+PQ7hq/VMLT3ETb5gcuIB8reHNxjd4wvHHVB6ZsV
 2D7DDefIpml1lltjlz0C8VJdOB72W0qGy0/XvJ8oUH2rE0/OXPapKkEGNf2mOTYIxBOJs
 bPYDFf8QF9Ae8z+vndpq4a+rqA+RgOEuBo7p2AT41G75RTTFGgp8unRJreCuH3dWf6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jDucM0f5; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jDucM0f5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA70B40E78
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 01:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C4E0429D9;
 Thu, 24 Sep 2026 01:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E5A1F000FF;
 Thu, 24 Sep 2026 01:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790214826;
 bh=BxFGRAsaEEEYuTeA+EjwH/PXfqCgBQ+HlJ1KuFKp9G8=;
 h=From:Subject:Date:To:Cc;
 b=jDucM0f5oqdESLR6Fu4G7u6lKJEVvklT2qDLWZfG9ncU8LrSDdBz/f3Vq6PLSqZtT
 /CiotjDaN0R1ijX8El55rPrbZFHBW4Cx6c7yyDiSvLig/PllIoZ/074yfh1982koa6
 uLpLsiodduCy44ICn+PNiWSQZuojUsa3/HWLo8gcrdOCNbRxPTwdaIdo7E1j4ny7Lc
 EsdWA4Cp8Li6JxTgfEKvSXfgXSFsa2NpE+LV6QYznn+GFyIoTSJ2XAfNZ0DhICT8kg
 fpZv10aVVz4nqRrlSfcAf2qV+zusF/hqlP51ewzqfQI1EiG8kAXMX3lX9cHQHzrrdq
 fWqP2eAbty6QQ==
From: Yixun Lan <dlan@kernel.org>
Subject: [PATCH 0/2] riscv: spacemit: add ethernet support for K3 SoC
Date: Thu, 24 Sep 2026 01:53:28 +0000
Message-Id: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORvoUnHOV5EdXBtdFLqSdDIYe
 3erHr/D/29grMIGl2YD5beYzKmiPTQQplt6MEqsBnJ0cmfy6AhfHrlMrIkL2pLzrAV9Hzvq2y4
 eKUCNs/Jd1t/4Ovxty/jkUL432PcPtfLbt3oAAAA=
X-Change-ID: 20260823-02-k3-ethernet-support-39d72917d42c
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894; i=dlan@kernel.org;
 h=from:subject:message-id; bh=yKGwax2WD4RCYL/hbe0moTrX5dM2YM4xR0xYeDlO7I0=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqtIKen4tkq9zz8LdM1zVhkVX3fil8T0+Kb/3Ot
 kS69it0x8OJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCarSCnhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0BQA/+PzTuG4qchEXf83X8mYYvJ1WRivrH+fVtcnAbwckD983x2uhjxEpI/
 GuG1TFO5e8+xgKeBAwhukE032qYbofcTedl8wpY+6K7Uxc7b5cWXvei1NdCowOKbbTOawIJKAqR
 VJ8dkYIBHXNuRg6x6SZeIEj2OPFJHNPm2ksZl8sexBg214ZFQa5N6As5FUtWX+EZRf/bA2i8n/y
 1BlMTNGYWr/WutgWajDJxGdAWoUtS3FlFrozJxaJo5SgJ7SuN9jX3pSPYeNqCPhcbXx5jFdUdri
 Mv21jw4BH4zR+ZaRjaYg93dl8RnaIiLQXHWd3wMlGdnt7p7beyLKOaskOiqRw4ofVcO1rPP7eBA
 INtzThJqIuj7LjVl6TUh0aPmOASGPaYPzCHR40ZXY6D2N+v39R8Ylh2CA05+26E8Fje3l1GzGuf
 SC11wTmQfMDDCmDjngcNdIAIyrdCZS+QsMtHgImm2kAgBTmP4iPoNu5weGZW6RwHSpoTBcaZ7pC
 z26z1aAAxynsRjdWflVx00chWNto7BRvLU3ftzVEpXVnn9dFDUxcgXP4ffoq9BGWOW5iUsEsP41
 dbHcnkmbzDZNwzaIIdc6Jy9n2UbEV/gyFl5wViKvlvViG6UMQEVlUDppXZo5xjpgZFlg/eBc+uv
 QCXJbtXoW2GgRwpPsvrv0RElOAkHAM=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

This series try to add a Synopsys DWMAC glue driver for SpacemiT
K3 SoC, and also enable ethernet support in the defconfig file.

Tested on K3 Pico-ITX board with command of dhcp, ping, tftpboot.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
Yixun Lan (2):
      net: dwc_eth_qos: spacemit: add support for K3 SoC
      configs: spacemit: k3: Enable Ethernet support

 configs/spacemit_k3_defconfig      |  10 ++
 drivers/net/Kconfig                |   8 +
 drivers/net/Makefile               |   1 +
 drivers/net/dwc_eth_qos.c          |   6 +
 drivers/net/dwc_eth_qos.h          |   1 +
 drivers/net/dwc_eth_qos_spacemit.c | 313 +++++++++++++++++++++++++++++++++++++
 6 files changed, 339 insertions(+)
---
base-commit: eddb50614effc8763a05088196fb07490637e04a
change-id: 20260823-02-k3-ethernet-support-39d72917d42c

Best regards,
--  
Yixun Lan <dlan@kernel.org>

