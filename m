Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D884606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FHm8CHL1;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=VAL/Y/HU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBE5260DB2;
	Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cM5xs_QEKE_Y; Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 33BA660DAD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001021;
	b=D3CupZlT9SPbHW91lax3NbYL6va+r1eYzp+ZI5MelWHiFIygnZsszFSkX1grcMjo7FYT
	 1VO4aPRD93WuVakp+J5TIcLaxSVg96IB+dfHRw+O6hoxyiT+Fwx1SG16tnlz6L2k6qkdE
	 cJoEjuZeKQMNgr/TYUJHlWAGavEp+furkc0dCyL66iZSK/Z6LMIVzm9vI9AF4DDDyLY2V
	 b+G/AvBd2cabwIuZ7F8b+q/za9n6IqL/gXNN4QAGXqck1/CBqprQBo2ecRWoq5rUo9HQn
	 OBPL55i/RESRQazWheDOh4jzRL+TRQrxW9NpGCOvG0LsBqx+KkFswFTbxe0u/r9AJ9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
	b=ggQyFRS40zbLp2o7Emz1DfQ3VG3GOc35dX2OpWFQdY6q4O0rceivOJ6HZ/ZWaERakSJP
	 5GLlxvKiCSyn7XXf4c7aMz4WNfh9JluvBq6B0M3T2sX79F1U7hcIPqODojZXxNzzjO4DP
	 wZkcE7a8pVZR3GQpvewT3WMxCcngC8uVfGBT0K3qBGwHNrMcsSLr3BHtwMeWwvhQiOz/s
	 yLJgUSS3QgnvMbk2eO5VDuzjvceYRMtYKG802XuyCxCbhWfJQOBXDvrkbkFPcgvaEa5fU
	 v5u12osci1Qp5HYHVdO2257Ex++IahqTQwPjOLEmqCNAKT7kiXAEaGddy+WgjQKRRTw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001021;
	bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FHm8CHL1x5FAB/lF1epTsufqrhQxyVcQFkTJFH4nY0k+wYMxdaBLSPADThtW+c1LI
	 JsL35xLKX6h0gwmq8eCk6+bL6lEc+DxHFsmciR+axqTISQEVuqcFm7d1iQvJTBqVUH
	 LFElx17eEpeKeLTwOflFp7um4OHhOitMVjsCdrjj1c5cXh7zwJnChU7V2WJEsbrjoa
	 NelTON+tZAYwtPUvqOFf9xxN1x/gy8IXKi3YcdE5Z97mO1wSBUd4zdq4FsoqxJ2GZ+
	 fcEIFRSlZcml8w9MByvvOeS4OkWoQcSbHMqbeg3VqVQaSFK6qNDwHVDrgycvFuIBrW
	 MHm7l8ksErN6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33BA660DAD;
	Fri,  6 Nov 2026 21:37:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A21D235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C08A81421
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pv8_NPs-p1jM for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6351481414
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VAL/Y/HU
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6351481414
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:56 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-563a0462094so525273b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001016; x=1794605816;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
 b=VAL/Y/HUxInKZT4WntzqjVSyr7WGjOZvwO73YE1vzGtWEG58IlkVTezCtMJpPCndJQ
 v/QjqkUflt8+RHpsWWvVjh4m4G+Ls2RkD9MXoZ71SQDzSbXj03HiswRy6d9bW98evOUc
 UCTV8wBJW+SGBbPvoSdpyYSb3R4I76eu/2QFjzrCLHVFr+BCr7KWAaOZUR6zJ+uHNL8k
 Ghxgyur1sTx42jD+TfD2OyFLQygaSNNhCL+sfAreFHuakjEC8NqKi7vvTVdO06XIH6TY
 474039a3u4ZzuSu7DWANDoS3xIMKRbkpn+BsO0wg35Mp5iWxQtISRke/p+JVUXxjRsT7
 9//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001016; x=1794605816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zKioeJJL7vCX8ELKXvvxBqOQ7oFFwfgXfKlWCZqRWYY=;
 b=a9kVsHGCuEuh6HJznIl8vvlA+38dKsFnR0ypVEYgMBxw8zDJQRULyuyrLmvcd8yw86
 cto7lpRtfA/z88IP5/dvrJggdoNIRGYMhTBa97DzBK31LWbQEM2c9jBemEpgNjaD+8QM
 pg0Vf/OXGNbyaNSdadlsOh7MdD5dG5BvKrQAsfanpp4JzH6ifxxU8drEuhYe1ArqDPgc
 ZLzQpMm02PP8YRaewkcmJoAGQHwi7b1xSZ6rAFtAVSqWgYfMcnxB3mSMfaxdIYjHuNWL
 51ZxKpLmCl5LMaidUj4WFzOnJeCTv/j9lIAriELFNXjlzBRfnzb6iMjSJH50j0HVGrVM
 BEBg==
X-Gm-Message-State: APuU4Z922mCjejNQ2Q2WCpWGCZ8CMcg8w0UiGfFKi4auLLLyMcmVYwJY
 8ocUjw1/hs4kPOoobu7UZNZlLeKxztw5THHZBnUW7WlP3zv5DfF9WDxDXJ+fnUAdJ3U=
X-Gm-Gg: AYBFou0jgjZoDyuVD79BPwwQGHBqf6eo0enmnRGlTxj5jQ1LZJE0Z/XYtv1N900Uy93
 Y86OUJIUo6b1LNo6mLVai2qBo4Orl5hsH6fgmN44F3ZoEbgbyCRtuWO8+gZeckjGVoqVakVD/yR
 0PAgzIWlt5K9WpVtLZzL5cf5K6kyLqe1QWF7pmwD3CmIODoodPLkm63KNuEv+h3dxPYV1a5iulc
 obJ/XwfJByK1oGP2YkO7Z+hwq8x0y9+WsRKpCZ6PlMZXo2eomy00+cjx35F3EbG+ZvImzNfFs62
 6O2FuHOyrVDFuSPZTSM8+Naa483YE9FCpg5xUY/zFWBR+D+V1r6bLqsEvMMWh9ugfEzw/15SmVi
 m2oREQ0mwQEun37ncSl/U28S0C/PfO9ZRtvmQUHFOxg33HTiDC1bJpTxtISks5M69tY0G0flIGZ
 cBozhxvil1KDGTTcyNMNskoMqIIE6ZZrrjem3Dz+vQ1/T7hFJkMQE4UgqwGSypwLoV6zrk7eHqO
 96BWJS8C3N5sVaVMQ56+jtMOfNxQQfMYoFfJtmgl43yyKIUeRUwohmsmERoYmr2vLmu7oMUxQLY
 nugK2OCkZoHXboSm86mshMB39HQZzN4NDQ==
X-Received: by 2002:a05:6808:c1b6:b0:551:2eeb:d53c with SMTP id
 5614622812f47-567e15893c3mr2817794b6e.44.1794001015711; 
 Fri, 06 Nov 2026 13:36:55 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:36:54 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Nov 2026 15:35:53 -0600
Subject: [PATCH 3/7] arm: dts: mediatek: prepare Genio 520 and 720 UFS for SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-3-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XWXnx2Xtc0xy5tn7f6lj48EMq2b6rzNQQx7IPHXiZDg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7khOL2HMhf7rcmu+R0nk9vD3EpFj2Kqo0Cw1w
 7hyVbGWHmGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IThYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AKccIAIl4WE7/xB8MNNmnyIm6ZHuTMd1Cm3fxlQ0jhds
 tsXoF56sunNG4Ih/PrPdEuFUPqWNNQpFGYtTStr+XO1SqSmr2ehSeYnPnxoZ0LCbIxjDDmfiBbK
 X7gw2K7ZBfsIwlXyrQ43RdSUyQZSfSuXwgV2QAOV5hMMHhG6YFLyGWLwZI9V9k6fW+L9GgJVIZ8
 aeG94i81IrnjikcvisKnREvmpr1wGQV8/CX5xyEWT2ziGFGN3y9Bhb7ZTDkrkyqB5YFERWnL5cD
 kn5FyOBBqhOoBFHnqHlx5nNxa3EseuhS2T1JtbQCKYohlNp7rDyO58Wj+NJZN9VSU/IwQHBg7la
 hnVg=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark the UFS host controller and its UFS configuration clock
controllers for SPL, so that SPL can load the firmware FIT from UFS when
the UFS devicetree overlay enables the controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
index 70c538a690e..7f614323c93 100644
--- a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
@@ -32,7 +32,10 @@
 };
 
 &gic {
-	/* Retain the eMMC interrupt parent even though SPL uses polling. */
+	/*
+	 * Retain the storage controllers' interrupt parent even though SPL
+	 * uses polling.
+	 */
 	bootph-pre-ram;
 };
 
@@ -64,6 +67,18 @@
 	bootph-pre-ram;
 };
 
+&ufshci {
+	bootph-pre-ram;
+};
+
+&ufscfg_ao_reg_clk {
+	bootph-pre-ram;
+};
+
+&ufscfg_pdn_reg_clk {
+	bootph-pre-ram;
+};
+
 &mmc0_default_pins {
 	bootph-pre-ram;
 

-- 
2.53.0

