Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F9C624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91B8F80F6B;
	Wed,  2 Sep 2026 14:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVfvqSfK7ogR; Wed,  2 Sep 2026 14:17:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788358609;
	bh=OHF/shYzABG/mP6wplNfvYlGm84JFqGiwG6b4N912Ag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wMwsbEdsosOpQ3YLCHWsOVlAlFIhUhkNNU2VXAAZlGqfZXOQ7zpFWfdLgMsfsuoVB
	 uqtgCEQAmt2xChLBZpxg/pCd+oQiQvmCBRbxup73/x3UjeUFSQf1i5T4S3pfwuWOsB
	 hOFz7zlypXbq0BjWVeb3+wW7IvwxKbAtuh4SWH8VJVea6BXbK9PXDCGZ843Pl/Weh7
	 c6yS1j9LY6+L2DGSe35lt3gNTpuVamKNQHV2N213Mqklo6qkznmQh0580yyUuYsMxh
	 VV5oC9nQ4Ax49+Ab3fooiKNrjpVpCXrPP92TRa3CF4Am1LawN89KDU27U4wu9sAYuD
	 4aPTxkHrjSs9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60DA680F72;
	Wed,  2 Sep 2026 14:16:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59799230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B482606CF
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id deqDpoHXjnrt for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:16:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=LgZnhZk1
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68FA6606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:16:38 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-484415c8bf2so890297f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788358596; x=1788963396;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHF/shYzABG/mP6wplNfvYlGm84JFqGiwG6b4N912Ag=;
 b=LgZnhZk1iogSppoibFDjX1U2JecrD0UxwbyD4GsxsnZvI1f75A4yUde+XB9rDwTfUx
 rLORsjxnrhW6BhF9P6GN2cl0X5MUSXoABX85ouKa+Fu16sDUm7F7bP2v3f6iGaoijn14
 vi5t65NNIMiHWMpz/liUTkl+dniexCMA70ThfsC5GQugCBMsFvMquo6x8x7tKOyH/Wie
 S4hG1fy8idECC4HRirREu3i7+2IrInjwDsihjyIhvB02nyewoc/uR6jdVIZ8TfcVZuWU
 kPuI4to9bwLMZ6PVB0Pyf8iVDiGhPLZP9bBzktHzzfHRG7474EThdCIkMUbQUoVUzCDa
 4BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788358596; x=1788963396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OHF/shYzABG/mP6wplNfvYlGm84JFqGiwG6b4N912Ag=;
 b=JVlaMeIn2fv+VPN6TzRmyaYzIjssLyzRmfPTUinCKaKFGQw6Z9yNTSdcXQF+KxF4ay
 Sk9cpaWv+WADW1s25a9k1/HJIMNvaFMd8C+piTqxsK3Fh+1I5GOg2iNKSVHLL6z+3xBD
 UYGpOnWd5NzQ2nlB5VdmXiFHCf5B8TRcVw7yWZsMbZX/Oh0Tz+0pP8HV5VjeIHhXkvMa
 tjVoIVKX1B6qtubaKyECfbl4D63YiqZ/gH1hjIpXQA5PYh985yuU083WYXYuIUsRHjXv
 vQM5nuxS6KdUz5qs9fLFToXBP3K3uhEgHSnRlweNpe01PCHj2doKyGfhVpBpX/Ctb0pq
 XLyw==
X-Gm-Message-State: AFuF++nIUX/NSS2+7r18B/ohUlaI9SDujBVac+F5DPTD1t2YSre/DoQ+
 84JqE0ZrbgmQjeGuvXahn/uhH2Csz0W3jvDU17Q5et9qDVtjWF3zgJg3A7AlN351WfQ=
X-Gm-Gg: AYBFou07VLWZ5mF4lKH5cOOHEZysDDJtghYOyoPXfVFSFniptkrQLcYvyT96jXS1/rw
 UzEdEi+4HqDv9oZDWMUs0VuwrV9ZICXOmI8P5LsTV3ukW/vhdxCxurMTu9I7INYqNcD2NE1vbQX
 klBjARtmbtUBMSt8lnpuZwpCUdcpQpwMiWhZO43t2qFbASjG/4LO2xaxJqnGIchZyh9F5fKRcjv
 vGV3uwjURmTDf4qdYKU/hIEnEF4WRsw9wbCTVlzHZ2k600lB8g4B1R8kirH1pwVrOs7M9LWk07K
 LqYFvz30avLrbjK3v8BdwaPPB8tmifzyhsa7GGmLEopVV5Wflj2TNchCsC5/ekxO+q2s/08AG83
 Ekp0DW874HnxoURVvmqOs52BAk2aqUJsxrBrS2vHgPFTyxZkT/tTMYTm57iJo8eCr58bbt/coC4
 Cg8W2lcDbUVOwrKFNt1NJXI4rJYEtFKohhpu0jNC0urNJfvZNujFUCXksQY8Zl0NgIR7qpBAdIL
 EWf4P2QFp5m6eiBIal7wpBi30I1wxzhr/xaX3grCN63siSs5iDxYchN1GK0ZuNWaaGl1fNN2v4a
 Wp8fG80cVaNzHNJdo4FdgZdJlVZ1n0n+fNmrbf4mDMch
X-Received: by 2002:a05:6000:471a:b0:484:3311:3176 with SMTP id
 ffacd0b85a97d-48488f22290mr9701077f8f.23.1788358596278; 
 Wed, 02 Sep 2026 07:16:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed3706sm6619546f8f.18.2026.09.02.07.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:16:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 02 Sep 2026 16:16:03 +0200
Subject: [PATCH v4 13/14] arm: dts: mt8390: add hdmi override node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-genio-510-and-genio-700-hdmi-v4-13-7c3b4f068a56@baylibre.com>
References: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
In-Reply-To: <20260902-add-genio-510-and-genio-700-hdmi-v4-0-7c3b4f068a56@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.15.2
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

The mt8188 SoC provides an HDMI encoder and PHY fed through the DPI1
interface attached to the vdosys1 display data path.

Add the U-Boot specific bits to mt8390-genio-common-u-boot.dtsi: a
"memory-region" phandle on the hdmi node pointing at the framebuffer
reserved-memory region;

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
index a4db2186e2e..be1543d1499 100644
--- a/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8390-genio-common-u-boot.dtsi
@@ -19,3 +19,8 @@
 		};
 	};
 };
+
+&hdmi {
+	/* U-Boot specific: the framebuffer lives in this reserved region */
+	memory-region = <&framebuffer>;
+};

-- 
2.55.0

