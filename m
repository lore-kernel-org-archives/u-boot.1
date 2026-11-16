Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034ED606A332
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RFobiZ8s;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ay98xZAE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D381340779;
	Mon, 16 Nov 2026 22:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MBr83-b-5qaq; Mon, 16 Nov 2026 22:34:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3570740795
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868451;
	b=h9WuR27dZea35VAPdE+XKDy7HAXAmtQsPV9x9HNQVFLetC0t7j3dHIT33wW9jW+s1Bvk
	 SUyQb5piq1A95j4ipR67qd8XHJVDhU7HbQNHr2xdA+zgkMWSuZq/nKtSLNnhTyn3jLGIR
	 /6GPk1fzZuMmtTVppQgsKd0z9Ru89hFwxAXDfN279TJkFU3GhMdjCAexmW083/X/61kc9
	 olIqTmS4VvNvRAq//CBqUTbt/3k7HFylVXH9dE4IU8+z04dOr/N4TFV4pMJq9cyrkpI1Q
	 9Jlp/nOfojQCAnnt2VGBC1cUGZS3mIW/GNcpGaL9YhgdtTaWkQBtee6KP9qk5C5oXmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
	b=np0t149PZP6Yb7fh2BcjOeV5HwG0Bc569w+9mWuyxraFcxkOv6+dUoY7gbGLSfoPVS6W
	 K4AGrbeqeIHBfnDiKINIBk90fKq8Va6V5eVrnVdjBg0lW66HIxHkX7exxeIf+0ETk0Kwy
	 JGhgN6kkwnJ7A1Wa45hXoJWIQHTrsosWL4RU+iyTFoKLBi/b+F/MRrugPc1zjVYm5c40e
	 c8KjF2pm7BmcHg9nfT6xU5QXm5haJ9QRK/seHRZhZJ4uHpGG/3NkzqIozawJK26WtHAWG
	 mHmqNFIWrTufgQXfyzsw0GBWevjCmlk+chwHAHCpTh1KH/uTdhaI/v13r7knXv6tyxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868451;
	bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RFobiZ8sQOhsatxpSXJOPxTabJsRqO3ygXoYRCS38O5hgQf/O6qY/fClbG+GnvEfa
	 RhllCNrCR+CAU7QPQd/IqmVJaBDDk7zr1KNdlxYOe+ycxFfKwWkHUi1V1voA3TRAXf
	 yphobpUoDiurNf9wD5E+omfFT6fGSxKMbmFhLH/cPkoyxB7hLavlPQ3Fq3yMdgnV4I
	 EhwPHH5t3I/VXjt5gnaujQXWxSg01MVYy6QqgtFcav57jq1HHClvYAsW+KAEjma/uP
	 l+7Qa4PoJfd5NJSveuXMDR9xeTuYEouiQivxs3AnkKnz3xZvNVDsReHoyIpFwWhKym
	 1Xq2q4FrrF46w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3570740795;
	Mon, 16 Nov 2026 22:34:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF43A1A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D023C60830
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9xmX84DdH5ge for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:34:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1026B60811
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ay98xZAE
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1026B60811
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:08 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-57148b8ec14so1164687b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868448; x=1795473248;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
 b=ay98xZAE6Biwct0QQPiWvl43Uj2arwmRIEbyoN6zi7FkqVUeoCtn52RmJIWGE54ywI
 vrsR7lmGaxEpZw+KiVB2vqw/nNZJA9NOYmFv8kiuwazmdzhwRjZbejdAmnM2P3DNY2wd
 k7fGR9T+JcRkj/Lm0eyfG61q59I8xgC72wtA4ZVT9By9Onv4j/MANMoK6kbJ3lp8t4J9
 1HF5jYRmBM+7Z9W/MSuHDoNuseJuTV/TVBfI4Ic8A+FlicdrBti6QSCVnT4di89RsrGn
 jidOxd1bYmXrHu2jRVMQ4vF8RNAfL53YJzo6PBb/wZCITEvRl2H8Pl7XIOLvZEDOYEd4
 InLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868448; x=1795473248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
 b=y3kUDe3QtylyeufqeH+FrgbJb72xQ/jwQT8TWfoCrsZB5Y5puosA54gxdG+WmzjkF7
 RQJyiUvsroHZ1LqeFd9lH8O02PnLSM0yW8NzOArMw1sKSygsSwWY8mOY0gPJpbfNl2fv
 gbmoD5sS1K5OOM159svhqFZlq20aWeNpPFQ4UY71R5CKoOA4CpUrhojpJu8tvLSVwJoH
 wr5eJxPLRxdND8WYHWMXXiz23Mv8j0tOJYSREZ1YUoxvB/Cmvzaas/RVzc8UuqTcF0K5
 s5uxtOb4j8yATn+Rj/dKmoHBFaDXLA1+w2gBT08xw/A65LIT+qmk9FsnmUZ9RKNjNEGz
 BUSQ==
X-Gm-Message-State: APuU4Z9HVyRnQgGwwf8rC8YQZYtTrFTfTQeVlGdGPR248aDElYt78n9n
 MUH2Pw3fRPl28GSU1nFVJAvRuayf+FncUcQ0tBCIC2PO3UMycqhkUZbNnRKY2saQHOA=
X-Gm-Gg: AYBFou1ly/VBlXCD4oDpY4FiKfT8arGgKQWrWMbtCDdqkuTiKx1VrU6WgKx9+Y/ojmt
 hq97mXss/XS7gbxsyL+4A+06DhGIGlVC1uZEAvCS8iF9DOa+Vi68y38XzgFggd6/0hqg4LNt5F+
 1VItlAFDe3dfpFkHPrQF0E8S0uBHqQUwd8QZI+ewK6zxE/tfaYOeHeczIr9i+2qMfx+inDyJ8i/
 12rTqKNQkkeytdzdCt8jGi3VB2GjH/oXaR55zjOwoTQyaBi9lES7mLSn9kGd17BUe7tox5oLDgO
 uRmRtARvpTrEcc0vR6h0CA8wlI0aDRibmRY4oxvS+xF4DD6C9VUbejPuSJ0OAw3Mzy1KdMPpz5/
 aR4nQpP5/Z8R/axeA/yg7rElMghAue5pdLH4HJT9z2gGkvy7ZElOjDKmeVMgIdsbN/edCOqGOZZ
 2MwoKGzuV8CPqTX6Oqp37iRzFSa3K6f7S9f7icAojtEtee77veuDJXSk7hku9wAetBuu6YhCYvA
 VolXbUJ/7/SxQwKcPG74V6JxnO8BZqWUE6HD3bXmR72woAJ4eliH5b6GF8dCxcTvHX++DaOJxl0
 U3qZSQP9XY2aXDeMOOYAtjbYfsASLYa4MHNEiZuLdZcy6Q28DlQhNsw=
X-Received: by 2002:a05:6808:11d1:b0:4f5:dc0d:e005 with SMTP id
 5614622812f47-56e63ba573fmr10099702b6e.22.1794868447659; 
 Mon, 16 Nov 2026 14:34:07 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:34:05 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:46 -0600
Subject: [PATCH v3 5/8] configs: mt8189: pass the DRAM description from SPL
 to U-Boot proper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-5-ca423d2d8038@baylibre.com>
References: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
In-Reply-To: <20261116-mtk-mt8189-tfa-fdt-v3-0-ca423d2d8038@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KvXRDSdfWZXX3+2baSyezcNEjkPV3NwMhZe58NYxTV0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+4Sx0xPyNrr5thuoc0MkkLNEA4xF635M5BAM5
 8OWfvYlCD+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuEsRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AW3UIAI2ivYZH2AGtVSmzlxoT+3gsEqqkilaHQYu56pv
 laH1y1jtS8uxqbzsp3Efy9axaciQlVStolPfsBHDRp3lxCo6gDo4t4N8M4zgWW5bjhy+ofn3RTL
 /xBFLJ9qg0Cj4jba72Mwr1YXSjBT338cwwj/VNVHIcwa+D2xYuIujnroyPWaXexMvlHDIXnp+nq
 kuxGVwVb3xHN1ChDxYpnKa65nhAP91eTamKzx+WaO6T8pQr5QE04ldM5ji59fyMJZ3cphu+4rLQ
 Iw2aOky6Q9LoYe+S6o2HxD2jSOmAYNlvtYnSQ1pJ1hPu3jcYxO4ahPc2EKZQi/LF83kvQpaEiDl
 APJk=
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

Make SPL add the devicetree of U-Boot proper to the transfer list from
the DDR loader and pass the list on to U-Boot proper in registers.
U-Boot proper then takes its devicetree from the transfer list and
applies the DRAM description overlay to it. As whenever its devicetree
comes from the bloblist, it also sets $fdt_addr to that devicetree.

Also make U-Boot proper require the transfer list. Without it, U-Boot
would use a DRAM size that may be wrong and would not reserve the memory
that the DRAM controller uses. U-Boot proper started as BL33 by the
platform BL2 instead of SPL then needs a BL2 that passes a transfer list
with a devicetree too.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 356673af059..06683b10945 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -14,6 +14,7 @@ CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_PASSAGE_MANDATORY=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -99,3 +100,5 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_SPL_BLOBLIST_ALLOC=y
+CONFIG_SPL_BLOBLIST_PASS_REGS=y
+CONFIG_SPL_BLOBLIST_FDT=y

-- 
2.53.0

