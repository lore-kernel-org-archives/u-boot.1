Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4A6C98324
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 13:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A95D4062C;
	Sun, 27 Sep 2026 13:17:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCOVqfJ_x5k9; Sun, 27 Sep 2026 13:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6C6F3405BD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790515043;
	b=Qsd5RImKA4YgDIe1pgIEi+/oyM/LdCO7mhDLUP6bK0Y/T5PXRDp++iupdsexhvKVK9NT
	 NndmG95M7s3GAi4wAb5PiewkzLHq/ZI2Wij3ESPOuD/kJrLgD6O0q7ax7kn6cIKRXy8jZ
	 ZuGIwNKSKvA5khcqeecgx2yEtt+cGz3D5j4jVHyW6OWH/m8SZZHloH/fTR1G536c+1g7U
	 QOByEGlyBEbDw8fuVOl3zeB3xO+OCjV/e0Vmq9sUnKCfCyjwpZGcLA3UuS+EaNtCsjAnN
	 zR0p4H/FsBVZVCBDtBtJjwXmZIvmle/emiCvs6zor08r+5Ofdqqn0prgA8bbtZEq89Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790515043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
	b=cToqPlKAzPntXrcWlFxSARuQwtRToa5+NKlo1v4jf3AH4gmnGU4amLcrHxb93F8MBOh5
	 g00koVZYi1Jqc7AcILIRcM9gywulPQ5SbLrXv2d0gXmctBtqBBFtdSz7CEZgD+10HTviz
	 DCVQa5VEwjkQYA64kIItxU3l5HQpzyTiyO1y2z5nFVKe4W9g7NaZKaBlQExs0y4tIF1dv
	 T8uI2ZuHIvP39BH07xWh//lYVtYGw12TvA63kIAMRoseigqo0Mvnv+GqNm7lBCqTTHMqC
	 VNMMmjJXcs3LPM8KfK7q7XIiIKQurtIyOQ3oEic+MPIg7WVZgPbXJvY8rc8BhbP5ExA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=cNawCM6n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790515043;
	bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRzPuVgo29CgFX8GgKV2tlpulSVzVJ0SanKoTxgGtosuO0vIMbVScpFn/IVqylCWC
	 A8JRHxtcIpoO2iJeWFVHqp4rtZPFq+FgBfcIgplEbSF9J8oH58mhEfcwC3gvz4i4zN
	 8N2WO9CCpifdC1L/s6Jh0idlLpcoVVWKUC/2sqgPEOAD/abYEKlSvsaitMAnsXX/Jz
	 lIg1sLF3psLmb1dVYR3zI8D82uAqY0uyvX3C26DDpdsW7VchrGE7IcrEglNuRVk8wF
	 coK+xEbIyYx36LKmtsxCloEQ3jlUiY7xGelSp4yKj0oIcbdd6XHrA1XS8+wZ4FI+8O
	 +yQRW7M1gMj2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C6F3405BD;
	Sun, 27 Sep 2026 13:17:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B72329
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 603A040A3C
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YU3tlR1NvJIM for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 12:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 71CBB40A2A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790511236;
 b=IWcVw1IXaU7svd5BGlNKhjc+TnEWLpUP1O8yS8qtgPlkEc9Y75XemcrgpuriPU0OfHm+
 GDo1VO/j6NOJK8O5jBLeO5YWqboI60qdNLFMuY+Bw9tdENQ14n+KA/JilHINZJqd6mmx7
 ldWzF4pK1JDFJEBQeEsQxegh7HQ98b0Fuuuxg5QFFeQzzplRuVgrueEyn4FFVRLiWu5V8
 ho8M/i84W1t9/lPsrt84pfqAIoj+FvFYc8FmDkOUczFqYjX/Pl8UPtEjaoARnukK6gduJ
 OpiSH6F8FSBY+D74PftVWh8bPX+MQrxl0iSDrbYRkCZz8zNNqrjrJ0SiTJXzMDmuvBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790511236;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
 b=ZxItAUG2ZnVoKXntgSvNkUyJpgN9uCMvNA7NkP3c22IHTDSAQnA1fd1ZeECBMXDjfN5s
 FkTKOsRQ1DomUgQpSJ8f0RBD2xslFzkRSoHcZYm33X0SeS9onA8MvuabGh2v1tYL1yWBG
 AafF0YonKiDLgfqmeEljOCTlWpf1xIOvaFBt1O+KdJceE0WC3yVHqy6JrW9f/Fzt0tatK
 xhEqzwmKZw/EO9bCY8WZFmXgMviJYKaRWP6dvyZsCt4rcHqonlWJz2IZl/hNr/l5IDJ61
 8/aRCXEDmFl7Cln7U7o4Fh1yOZ7zOWC0UKfiLmqMmMV/bAEFuWsXEoGWa5N1XU3JgaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=cNawCM6n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=cNawCM6n
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71CBB40A2A
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790510993; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DtdQOYA5uxCXrnO9PLL6A/sagBCq9SeatH4DWYw4D1k1jcsaZxIMIfV9S3Iaq6EAlVpD8gtxAEp00l+RfA36NS+tYDojirQybuPJ4KG0I1fV2fs9tDnsa927PcoaF5hjXrH/FZRkUtSpj4NqPRxQd2EZWbrsdX7V1Ql42YzmhXY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790510993;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=; 
 b=aqbxEaIC/v+TnaCkTrVjcWwhMW7exbbXEeH1SU7C/lE7FUjBTec1LaVr6C2+H0ZLeWYVBOI46F76PUsYrr7jtjtY4k2bIi4FTTAyw8uw3jbyscNZHK8TrCC082UFvA/49zQWYvEa7uSRzIPH/X/ednXWKr/wkspVSLmDczAbGrw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790510993; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=a2MCxSFBW2QbP7piP9unyouRDQLjmYwBSeJUGiX5utM=;
 b=cNawCM6n/lqXhZzR+EGpWvwviHhECk9Ka13i59vmEFPlb7xYOcdjliYvT6ev2Hxb
 Oe8XLDTaKSm69DD8Rm6BeRuuf2vGrzGHlEY1fe7VBE33eozuJ4QS2BmBpITRz2DpABt
 HeDVX8cthV47Y0EmNii7r9P4WTXYDkCdtDY3RLck=
Received: by smtp.zohomail.com with SMTPS id 1790510992363269.9311542707318;
 Sun, 27 Sep 2026 05:09:52 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 20:08:58 +0800
Subject: [PATCH v5 03/10] dt-bindings: soc: sophgo: add Milk-V Duo 256M board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-3-7f64983e59e1@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu0801122738a9fabc039f725df202387100009fd0631f7a290ec81604ee44f1f8fa50660cd6f6db728dec53:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:17:14 +0000
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

From: Chen-Yu Yeh <chenyou910331@gmail.com>

Add compatible string for the Milk-V Duo 256M board.

Signed-off-by: Chen-Yu Yeh <chenyou910331@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260725175346.139173-2-chenyou910331@gmail.com
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Chen Wang <chen.wang@linux.dev>

[ upstream commit: 06c236909705fcc92f59b0f2dd05a45b22902769 ]

(cherry picked from commit 39c49b7fc7a33b3af1c6fd80e599bd7d6db947be)
---
 dts/upstream/Bindings/soc/sophgo/sophgo.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/Bindings/soc/sophgo/sophgo.yaml b/dts/upstream/Bindings/soc/sophgo/sophgo.yaml
index 1c502618de5..fcb1d905da7 100644
--- a/dts/upstream/Bindings/soc/sophgo/sophgo.yaml
+++ b/dts/upstream/Bindings/soc/sophgo/sophgo.yaml
@@ -31,6 +31,10 @@ properties:
               - milkv,duo-module-01-evb
           - const: milkv,duo-module-01
           - const: sophgo,sg2000
+      - items:
+          - enum:
+              - milkv,duo256m
+          - const: sophgo,sg2002
       - items:
           - enum:
               - sipeed,licheerv-nano-b

-- 
2.55.0

