Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9160A2604
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1D3cRrt7;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kjkEBfIp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E2FE812D4;
	Wed, 18 Nov 2026 23:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQHrUSTKnzZV; Wed, 18 Nov 2026 23:20:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AACB812DC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044031;
	b=IM6tVMaewruamZFYocoO2OoUzV6YVgSIRQvZfu0KOW+jCzxn1kX/rPbLaL91A5TZHjnd
	 tTrrmIZg7WCsvo6cWm0rJ74CsqkAGGjVB3KbTPWlieULaCM60gI4QpbPt3c7g26H3rRrf
	 DBNgjXPY6s0oF7h5iWPaYfDGgJllzCTUCnrocOEdY44AkqhQarzLutvsPWHNfwrfSO6EB
	 tWEKMz3tqvDJfkNFUrIqM3F1cEOgbCszEyDRbp/1em/pMEg7nmNLD86tqZeFiQr2aHGt0
	 c5brjl4+C0n6ZwP9DAaR7xE4nkvEL4Q8RX3eGtmc+xnlCFJhbl2xFthsOLqwbPFCAAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1sjIcUdYbR3EMtqbomprnVzGHcxSXSxeDZ6CI+soyJo=;
	b=njMAeFsky0GpvHEHJxbetIJBy5jJYl2fWqmr3ydE0Ecm85rKD8F6PPWfGakXkCKzRFk5
	 ePGwoSFsymTPUgoNOYFVzODS/N0Md+OqxjVyMNtkIWyo5XO0YZ8riBCVw8BetKFDbWcQe
	 Urw8JmdiUIuCp2enVHVjG55kbmv4G5U9Edwo6B9RQ4SJZRK3U9FE2aHhRESQ0Xwn3Iieg
	 5wvNH8eNurK4h/zF4nTU3ascxoDhcWVogSuD9q8WtQ/hpxAG4nCV+DfSSQeZX04K5Stqg
	 vonCEo9eSkfhBxURuON2xzDAn63yrSoUa2yh8d7hS5y3dYi07Y5f1W1g11LqGDY7pvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kjkEBfIp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044031;
	bh=1sjIcUdYbR3EMtqbomprnVzGHcxSXSxeDZ6CI+soyJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1D3cRrt7bDgj65QChrQHwCNN4sku8VtMa1r+am2p3GOZzIXSdXO9GISI2AFTqYWz3
	 4yiFUJuwVVHQ45u2KO0QJe7ICJ5U9Lx5sYERvgw7ThG56Ev7E3TVeeSIeD3kNfLB5+
	 s8cqRzAymLLxY8OQNG/v5aQmXOn6anqGymUldfIUgvxW1zpaDoFEHiY3VsjtC+s08s
	 onWlL0yLALaB0Y4cSL8r15Jr4hQKNN9/zHQwtliNqQWb1yYsIgmD0YHaNmvPCLHC1/
	 MYnpnRi2J3Fzqz7PIq2zTJimIe+37RcTvz2q8Xc5i/PSQVaj9Orj2Nad5qf2mmPg6S
	 9nMVzlq9JTCvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5AACB812DC;
	Wed, 18 Nov 2026 23:20:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64CF7798
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 531478128D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVPJYUy4GbAk for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 88E11812C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=kjkEBfIp
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88E11812C5
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:28 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-833e671ee9fso1439010a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044027; x=1795648827;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1sjIcUdYbR3EMtqbomprnVzGHcxSXSxeDZ6CI+soyJo=;
 b=kjkEBfIpCOvKd56NPpbIBe/mi3G3UVH6WvzkPtAkTXz/EIHyfGms9kZuWp0OkMQZ61
 K7VlTYBB48xENqHo2W41Leeb/ujWBr749+fwXbnVbCL0zIf81kwHF8/uCuyHVwP3lwKu
 es8jbK7wUN77o3EnfANoBeGHF/126ZW8mz0baRkQ9JSi+jrIzDWpOdXFIMDhIRLrx1v8
 oI8DNA5o+Ij/+NTN0h/c5i959t9BzjA4M7Avd4o74o8BF+67tqx/Z8uwHzjfu0ZWoPDR
 QrNrAOu1PgtsHGZz4it7pMTn0HgFJM9AZAoeJFnWXs/xHJhzs4JzpzPeE96tP86hAr3Q
 n8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044027; x=1795648827;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1sjIcUdYbR3EMtqbomprnVzGHcxSXSxeDZ6CI+soyJo=;
 b=SDET0DR8Bwz5WK1Ps1VxaEpJeUV6PKInqpCWWf5qdHtxpu8kOWukqRVGi6KkFIOK/B
 DEpetfU9JjTU0y2Roc7Y4/+U57jac3QVieu75SFBLXiUAaNx5j03NCBlrjrx6p5j+xgo
 0mLFWO0tadvzmQnuL4bYB4r/dB11/M0y0+cYC52ZvMNpay3RNuMWSBBD+9652w7SL2tx
 +LkGfxa412HcwfSyLyLWQPyiXIQ4udfG3QKxOY4nZ+nv1bsk5VfxiuHsygiVsNyVsn4f
 cLbs22tCmbgARnflhyBV9DEgCIdGnQEjH3AebZX7/PFXbZKl1ERSHrG+aRKXURtoWsRU
 e7jQ==
X-Gm-Message-State: APuU4Z/pyjDgx9pOio3IZKeCVNUpxekputnc2kVsoYZEe2JwpFkA9gV3
 80Kzo8qCAofuvVJDLLOGFfp6Ijq3LQ6ZXx/hEU8eIRgdwyzBRv8DC7TH3mlulsBX5O4=
X-Gm-Gg: AYBFou1q+xtaokYoapbE6qnLtPEpbrbVpHCFpxWDJt4OSqc9hq7F+3Vp48VEpn6mKkQ
 HQMx2YSowgbmx3FldnS0jbY8whr++YkjFfDpbHfcZ3YHF7PpZTh+QHkTA8VXvaCnK8dX9mKJcIw
 1CnWbELNQ/gYQ41zw8We729VK79ltFhlAaxtxnBn7GKrAoV3XIW6IH2gxpfo7pl+qEQ6einctBh
 NoyYq6CXwIS160zmLLi0PnSdAR7qmc5aYAKVoFC21RqeTFAm8EaSlP7wRiYnskZJWEzsEhgk4IM
 6EpaEarYBFbRZYe1zZLAK8N/dvXR4TgPep7hTCXQuQUQGK4DE3+WkB7E2SRmIRCb93S3wivcMtr
 RshU50d/98Pqbk2Qnka2inLZh/LzbxvE5bX6isawTCc1evAOtIxK8C7zaS9LFs7oC7NnleWKwPG
 kZ9cF7WQ9hYZLocjVtKO4l3DTljfQdcQF2teQ8rh+0vmajjZjESYRx4zB3loEbgHusvT2/DeUlz
 /uPUyAiGLNNwAHbzmJyJJo/WSNDbyBnWxx9ztoFFL1TdQSrwmg9oHsrQN6PWqam2XT5wGDJ+88/
 n3t74Vvh8/MGPU6K7HwrPrlkuoK5W9oh
X-Received: by 2002:a05:6830:680a:b0:83c:1efb:6424 with SMTP id
 46e09a7af769-862f08302d4mr4691392a34.1.1795044027149; 
 Wed, 18 Nov 2026 15:20:27 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:03 -0600
Subject: [PATCH 4/7] configs: mediatek: build the Genio 510 EVK devicetree
 for Genio 700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-4-1505d27fdfcb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=CSjoybO76rT5Nah96AaRA9Ykh8Ogu3J7SaPlX8l27Nc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKUNt18zupOT+7EK8vZfzzl2KWXX8gxicVIE
 yKwvQR4gVCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4ylBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AddoH/2acNgCanuKmXRxz07c9l4i1U462g4dynwwms35
 /gO/uWugOER7zCHxbo3aB/oYXTtJfG4/Gieu7GRhaW9zgi6sTmcbRRk+qCtjr/7V17kelKh+OLp
 7w+g0EF8H525IZuzXRHvGi11LV1DOVMKkr92itegWCVMIsws2dZWbR9ZUR78wxY6tyWcgjXGemC
 T0GxKH/GvQO80Zz/Nb/rBdw5WRsVBOG9yZXuI1Ix5ap2k/Ef92pxtIGsUUw4OhkO0/MCcIrzN4c
 ejhZUxbldYjPELu19LmMz50jB/ohavBfT4q86aVfg9wvQP2XVoRvbE99hdEinrj+JHjL+rvDJpX
 7VEk=
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

Add the Genio 510 EVK devicetree to CONFIG_OF_LIST in the Genio 700 EVK
defconfig, so that it is built along with the Genio 700 devicetree.

Both boards share mt8390-genio-common.dtsi and can use one U-Boot
configuration, with the board selected by DEVICE_TREE=. With
OF_UPSTREAM, only the devicetrees named in DEFAULT_DEVICE_TREE and
OF_LIST are built, so building with
DEVICE_TREE=mediatek/mt8370-genio-510-evk otherwise fails. Set it in
the board defconfig rather than in mt8188.config, so that the SoC
config stays usable for other MT8188 boards.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8390_genio_700_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/mt8390_genio_700_evk_defconfig b/configs/mt8390_genio_700_evk_defconfig
index fe4f6ad9016..54996aaa3d0 100644
--- a/configs/mt8390_genio_700_evk_defconfig
+++ b/configs/mt8390_genio_700_evk_defconfig
@@ -1,3 +1,4 @@
 #include <configs/mt8188.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8390-genio-700-evk"
+CONFIG_OF_LIST="mediatek/mt8390-genio-700-evk mediatek/mt8370-genio-510-evk"

-- 
2.53.0

