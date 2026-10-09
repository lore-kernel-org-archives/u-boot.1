Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB52CA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3DDD40931;
	Fri,  9 Oct 2026 16:15:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b2iCoRr3Rk4X; Fri,  9 Oct 2026 16:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 340C940934
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562554;
	b=RSlkRJf/im0YEAvWlSYYhEGyekQp3XdoiUW9d8XlFfMFgaOLZAbZfqMcCNnB9W5Zyh0f
	 Xp1ggNHXMwW7mp+gIRBD6J9CyEx0yKMFzp/ZYjYNhfqZ13cb5vQNpqjSvHBhx34vElyzz
	 4sdI98ElIpaGNKE49yaupE1QEuCXHK54xkFjHDIjCUJ6jRzU3ooWO/FfcrvG6ebozJJWJ
	 48Y+idaL11Pqmc+i1yFFD0KAh8bVrQpemAAqbFEUVygGUFpnjSZN7ynjiXtafbBtCFlKm
	 WgZUYQUfcK46B3ez55zWs2q8VUX1TPwoRCsHhZVEM5mbeoXxbAizbkVPFiRaCgxWWRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562554;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=k19PL7c2q3rh2qRrgJh7NvwkmZzVT4e7CGU2rhL+g+s=;
	b=kEnZu1CDM5J2V1oRXLBMPp2+snxwwHNeBwgdRgnrJDN8+7pfCnFXbbZWrqbd0Pbgoil3
	 G5OQxnxOV+dLXjIRwCC1TdbkkHPmcnpU6RccdAoSmWDUgM7v7J8HXw//YXsDrpm6axvrf
	 WV45ZPzBrbqGrlj6IvxdhtzG6VW98/GxFYIWomGyIKjYAUeD1OailKC/e3GQxopqd/WWD
	 9ZlzVRyCGM9Ht3mKos48MwJdkgoQXek9onBuGqgRB5CEm1sqtuAi/P/6xd7PAjWBwYhAP
	 +GRCiHMKZBW5BVeLUlrslGNUHW5mwIjnyEUAmbhmWhbEkt4/Vbc+ML3oC6w6H3ZAlvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562554;
	bh=k19PL7c2q3rh2qRrgJh7NvwkmZzVT4e7CGU2rhL+g+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ddyEFInsxn1b2WWPi6aZk2f0dPdq/ZMwBiW/ZqIE1v14pnxa8HCCFRNi3fCoKE1zj
	 AXdOoSNcWVIgO5XrlmZpINBazD1gQKA1g4rsnMGq/GvJBF77QizM1WpBri2udYz6G9
	 J6NsoZSHUxanjracWa19kv/hMCaqsU4D1KnhqsRQreyymzQOF0tCzCYeWz658uDVGC
	 VcvuvfqzCrczI69jteOe0GD3hGC7ngXYR5EI5rM1cxrHlHtbxEw91cVV+SXyhAWPpo
	 4bCbRxM3Fuf3jwDn8vcUhhEb1RRkFzhKQh4nJ1JGLVhUzMJfgQ54ezLCib02HsZy1F
	 X5JaRaz3aHGSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 340C940934;
	Fri,  9 Oct 2026 16:15:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14347184
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 069B4400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCdhH95Zdcrc for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:15:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2500840050
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562551;
 b=O5ds5jlIPz2e9oaq4BLL6mgC+EdQMsnupFvxuOYXAbbafDHDscOPAecHaKvF5BkBxwAp
 scbv7IQIEG7NgDh4qlPUIIzyGoyrb3lSdA6rng9FgsoK48DgFADv1/AH/cbdcaTyXFWxq
 pXXH7x4+zpw/bVvfUWyLiKsxHaS6lN5bqg30JLCnxNACh4f3W+oxFf24piHF4Bvqo2By7
 45nN6bCrjlLpuM0UZc+O3R0g5Hc989uVV324nF4/V2M8yJsd/fyHrXex0hlv2yckCg8a/
 kxXH3EXcpHNk3Gp1emeX507X3RjOcnYZkrTzq8cA94pTFfD2ubp+VO2J6h834qVcuFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562551;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=k19PL7c2q3rh2qRrgJh7NvwkmZzVT4e7CGU2rhL+g+s=;
 b=UoyacXYSja8dtaN5B7mVDX3ht1ESTx7Jcka6Ne5GLdZI0Qhzpo6OB/svqZqTCVMwT/qv
 /2AAxJrQm5Xix65gfeJT4D4CdF1EsP1BO8nkDPSQypm/s81jEKxrifT1sIEgs1nUE8yth
 ciXUsrIwY6NofFcAjC9L6UVcFtg8/sFMp152FF6Kvt92jH8QWkblmFefrNEvta/EgRmCU
 WN/Rhmly0bCX0IS5hmU1d/x5bC+YBi25e6ovG9bRGVlZ2zxZXXS9zQeFUrX8teiujeT/A
 ubGfT/C6cMq4x63LfS72NQ9YRlS32LTvAyGp3IDl6DWB9enq3kIZCZBqmH1jvvWGkJQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WN+Uo2C0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WN+Uo2C0
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2500840050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:50 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-823b938464fso5059113a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562550; x=1792167350;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k19PL7c2q3rh2qRrgJh7NvwkmZzVT4e7CGU2rhL+g+s=;
 b=WN+Uo2C03XiYwqzhgoy8fO6UHDEvTljJy3Jd7fuF2mIP0NEfEbhl4/uLeqptw7cJue
 26MSLo0zopTIwa4a+Lbb+EFZCEFB2f/nTGfsZmq/Xfn64ktglfBJYhnNScIiPxSEWUhC
 UTQbzcvHiVWuXlqhC38hDouMY2rlMD3WSYkdk9uOS8NZzpLge0zVaRunNHpKFShctxn0
 gl55cE3ErPmqN15NH11/VsBJIoNclpU0YqbIhULbZgpDxGO6/NaWQjoIQyi80At+KnIQ
 4pbIRqWdVk/dtc1trykocPNMzwn1Be3jLFF2pLWezy7xZo4f6ragJk/wr3D3ot/cZPvO
 QMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562550; x=1792167350;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k19PL7c2q3rh2qRrgJh7NvwkmZzVT4e7CGU2rhL+g+s=;
 b=XTs8KlNFozorkPDsMXqATsAUp7gu4h98IC7FBs6YIfLl/ZI5vip4ztKKyp7NBoQk4U
 6o39/Z8gN0Ua38ITl60MoFwhXvR9v0s+HjRS/P5Y1NVq4TT8JR+6Ydc0/QJbeFukkKCs
 0Gx+qB7Rxdj6xNgQ10R9pJEexThbb0H3lARKsTZ1lM1XNvyGOFNm+CgxabkmJMz1GjG6
 r9cMpVkxz18Irv/6VDrSl/ouwqf5ynaIdG10tGmsHUlni6biIada/qpp7HFP74nSsYjE
 dSBKFfJdpChlK6Q5KZO53OizbxC2agC1FYbOicpPSxoTBfuwOxkxBc5lWqPH4IHIZUiO
 40gQ==
X-Gm-Message-State: AFuF++kofN4gNW9MjbJGXhNQb4cbWPxU61U62DigG7MECgsZAzbZ3xXC
 S1eB4bJqKOlX+plLw1Gz+R3mcGeoy0zJTVR0/NitC1YeFsTbtbMc9x65xJs2qlda+8g=
X-Gm-Gg: AYBFou0e7wcW6qMsacuGbnZmMQc07XVp26KlJuAE0lxiPZDl5TbZ/Md5lCaem+8GqNN
 I0IwWhxcMK5ttr3Cgo7uiSSCaWKCmj3ZZvwxtfmEL/a042SJlRkwexfTgfC0d5w8CeRkrPDmjCI
 y7iO5G2M+tk2+NTg6eBml77INWLptAy+i+e5pjIq2YG836NyZT76rWPrlOdMtU/MiZYsYwos4b1
 VDcX1CMFQLwKghZ3+0h3gyRgftDAoF/nH6vt5lfatqD0vXoHZQkdswa+KCARuOgGskqwumEuQ8p
 LTJRE5NITh/Gy6zmy7Op+fV4DrLpfXUD2Oy0BQkfzBZfDIR+Kr8SWPaphfLtANkoqgL+DohY62N
 2gdqwzs5pRTsBUeLViuaKim/MGifKhz3kNw+cdTGYpA2Nm9SFAoPwY1+LX5ZQ+QfcKPpbQ+Uji4
 Q1Sitmv3mtJr/0TasNSQkKWS+Rlwsqeq1DQAQHVJD333t6GlMZ9ALXTotZCAmSm8RMJ04rD7yYA
 CUGkVD15qbPih8=
X-Received: by 2002:a05:6808:2507:b0:4e5:79ec:5bf8 with SMTP id
 5614622812f47-50c590b3f9dmr1934427b6e.67.1791562549727; 
 Fri, 09 Oct 2026 09:15:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:04 -0500
Subject: [PATCH 01/13] board: mediatek: MAINTAINERS: match the Genio
 520/720 files with globs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-1-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=qIAAoq+i7q4ja1e278G5qH8co8jFFNta5AzlR++Qb6U=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRLWCL5QaS92ZobrQzslJ/fTVGSCRVHm3fTkD
 D2nVKh+nSyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskS1hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AnDAIAIFz1mF/ffCPnVKhMdYDMupr2Ij57kW7faH/3pq
 ddNOpB/qCv9wqzi49qEJ2pcVgjdB9QUYF7fkmTOo1O0R0ZkvzxB59DaEWkKxwTvpkXOpqQc4uRw
 d9+fVnNyB+F7BKDVdyTk7UGlsl0304r9SEgJiNIE4HUkGUJEgkDjdYlqjlXeB7NWFevZqdQDqyI
 cXgJmNSPI0kmPAaRSfaLfOYjJPtiudDiu4/pAdRRa99RxXFdqn00LtYBqDbgwvRwlxcFZTAKhKQ
 sQ94cAHyBIf39yzdDM7zmGwvZVAB/xsml8PB2LUz+DgLvOxTI/GpekO9vfQKm/9DgPKIjK5NrH+
 0PHI=
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

The MT8189/MT8371/MT8391 EVK entry names every file individually, so each
new device tree include or overlay has to be added by hand and, when one
is forgotten, falls through to the catch-all ARM MEDIATEK entry instead.

Replace the per-file lines with globs over the two board name prefixes,
and add one for the SoC files. This also picks up several existing files
the explicit list missed, and it covers the overlay added later in this
series without another entry.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index f8e488d459a..588e7952692 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -1,13 +1,12 @@
 MT8189/MT8371/MT8391 EVK
 M:	Macpaul Lin <macpaul.lin@mediatek.com>
 S:	Maintained
-F:	arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi
-F:	arch/arm/dts/mt8371-genio-common-u-boot.dtsi
-F:	arch/arm/dts/mt8371-genio-common-ufs.dtso
-F:	arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi
+F:	arch/arm/dts/mt8189*
+F:	arch/arm/dts/mt8371-genio-*
+F:	arch/arm/dts/mt8391-genio-*
 F:	configs/mt8189.config
-F:	configs/mt8371_genio_520_evk_defconfig
-F:	configs/mt8391_genio_720_evk_defconfig
+F:	configs/mt8371_genio_*
+F:	configs/mt8391_genio_*
 
 MT8365 EVK
 M:	Julien Masson <jmasson@baylibre.com>

-- 
2.53.0

