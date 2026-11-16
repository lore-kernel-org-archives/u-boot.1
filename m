Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E302B606A894
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H49nDjZ7;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iHYQS416
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDD1181046;
	Mon, 16 Nov 2026 22:34:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YAvA00bIGBZv; Mon, 16 Nov 2026 22:34:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0929D80DBA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794868444;
	b=Di3owodFGMj4+0K5wbDXjadLFar8U+uIq5HbPjbl7Ti0Ait0LB245rRKVpjR0ax2fBpV
	 KRN6ZbtCm/tMgxsu796F4kfPKXclGOcqQiiQv5UakSdCenGcgumceo884yKKm2XCoqzHc
	 Gs4EwcUW19s2Dm1227rcN3uJG2YYF66TjvXgmVNCamivkl+8mTZK6fGRxvtRjcRnUINA0
	 niXq3hLBip5XJ0a/xa17ZHcKAkf9iAOrD459KBWCZXz/u5bb7wGlseJ2D8s8NBrxNnWCU
	 /uKl2x0p7Iv2XI+qmyFfYjOj3BgwqV4zlPitAVQqWzAbodrNvKeUkCKMhemdjScCA/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794868444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
	b=IYRw1cKBx/XfRfzSJVWBPbr2pLcaAss5DH9J5pPFrotqj3W9hZwPIJQgKqiarIeb8xcz
	 j8aY2EaiG0Mb3qpKwj4eBWMRz69/X0f3q2JO3+tZRiJMkwIK1UvguTIUsWm6ioeyKRBJs
	 bPCCWSTJDJGNDrkxg5juOo1WmKqTmI8LpKNIiVxI2NLYNTtrjcGFCunkNMiMoetx8TcmC
	 XHm7A0tSCUGhXQDlh9k7bU3hiay3tUjKi+PxX8EMf6jhhxMUwd1+VLmQX2BsUyFfPtKEm
	 GzI+GWhdQk9GIkKG8QWzScuNALOIgzPlwrRQ24cLtvPPRl4iEVaaf0kBSHNVYs6VmOg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iHYQS416;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794868444;
	bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H49nDjZ7VyVdPwa3Hpm+hR+BYKpuBymX3oTTUgxYcsCALnOcZaM4xsPsiNYAg+CbI
	 86V3mMigrPHR4wfKHQVa8MpC+UAlqoGqYUL2Vwy5Wo0mgdy+APxqeoGK+rG9UxTd31
	 d7EyVR4IkSCNb7XiIUFdKvxtUi5eUrOSwN7S/Zf59+/gL04q9ug/EuQ1ptGQBU/4rm
	 1uFYOC80VqOXUk7gDlPzRi24f2KQOVn9Ast0kJgCyqRrTfvGofeUH+qvFlFBx0mQ6q
	 E5PCwMDeofxcLDQ74IAXD6pKqs5bAMSBFhlt1ccpWXyBVGx9Vstifv8t73oXWKfpPC
	 oKW3KhvnAAuBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0929D80DBA;
	Mon, 16 Nov 2026 22:34:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65FA6D33
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6404E80DBA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBoPy2qDUskA for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 22:34:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5B6280DB8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iHYQS416
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5B6280DB8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 22:34:02 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-4a85c656c58so3285749fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794868441; x=1795473241;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
 b=iHYQS416qAiSVANNGaG9NOmebUezFeEiOyeiuaO9wv3QwgTDvT0H2nUhFlc+fpm24v
 v99/k3tNWxydaqT8Ysvcp+O8krqrR/qjmrqK/nMur7/262LWGsiRGRa4CQBR3qZrrEFU
 tuo/k+mntxTEIYmT4nbUBg3ea//z7LzOi4wONWCC44hzMFBt12Z/lrC1asbm2jOlm493
 bRj3yivb/lqWWSZdoW1TipnQyde1ysrB4Z+Y4B2UkhARqQ5if78ZBGatcW4GpHYwMsXZ
 aKPnwkDi6fagS8x4iXHE2dPh5xnvCZtnfVzl8U83Wp7flzXns+Wi8gyKcsOFWKWz32I2
 /T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794868441; x=1795473241;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0QAMQ7Q0LKencEv+sePhyXehSmT9jF5bkrNHFfrjGqc=;
 b=XqieRRowLtHWz0jCb1apBzfalyApHanfFzRNGw2JWWkhOGZf+PfrwbHlZTEqj5L7Uq
 IHp/iEEyzOvamraAncOpq9xsXLDuDc6ah63VxDHM1R4CKL7vRAi4RypTH8cajk79vZYn
 Nye9/x9dly7JSC+wO/+93ayGQTqnf14mZNIqmqkFSXVpRIIllUyc0mZzJYqhEimqEqTR
 9IWSTiArttI6bak4DmlEa9jZjdV6sGcRou8NetocfNJ6NlWyivUsQJW4BPKWVScJe90v
 6tii+k2ln2C+MFOA8HOX0FzYjg1BrsqD8T2p8/+3OApBPF/dtjb/aBPcVLi2gibWnKtM
 ZeXw==
X-Gm-Message-State: APuU4Z8u3TX7tKujT9JABM9uZmztn1zyhjD0/uDXJX6tBvs1zRL0aNpL
 1hAcahVe0W/xiPFjhxBKmTbNb1DGvyt0lpV4cuKrmGXXX5uyZQPm3QmrD493SxoJUtE=
X-Gm-Gg: AYBFou2fVM+p2HUvr2n7yx+AFP2HHVe10CQSzRCwEAblFh5E7mHeF3iL5/6eMFew/W+
 AiH7wEpuzX8mEaTO5SBWSbM4QFCYa8yiTMkvUyoTcY8A4ovEAN5aPutyHto8zSKodbi7ZMa9Wdu
 54IY0tPJ6z+0a9I0XTL7yAu7AUAjjBcBaZyu+k33oM4sn0kkExby1qc07DT9h5kkYz9DrJLWhHK
 EpoaK302Eql39E90mm606+qfCUWlryG//pFk3CKFypYrGOri9osUfag6OUGlMZbGCESTTkIwFfJ
 so2v5DTLGDF1DE0oouzqHOOwSFYj1R9t+XBPNRPOWw65lOmoWD6umECr3SMSIISMWKgk4BWbWki
 Vv3e6JhPRo6TUol4zzGm3jcifOUTmvuBeDTAu8KbNUkiFDmvDZ/2DjOY14VvL76ODVPXX8HhRFo
 WT3obMSqPLTM9p1YcmaPmDMNYwDUXoNR5SF4HnvwouQ4Fw6Lpgr6ZBPLmYu2yd6N20joEAIsk+N
 V+tDAkjGkmmEUl7bZFTZL09Cw63WR1ggOCncsztCy9VcYjKQrqOeSTS0boAApp5sYTdfjX/qZPY
 3XaT+r1LubG6KcydElXBji/knHlMI4nntA==
X-Received: by 2002:a05:6808:2512:b0:503:8f9d:f11a with SMTP id
 5614622812f47-56e640d426fmr11640329b6e.29.1794868441241; 
 Mon, 16 Nov 2026 14:34:01 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70c58f9bsm10173280b6e.13.2026.11.16.14.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:33:59 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 16:32:44 -0600
Subject: [PATCH v3 3/8] configs: mt8189: enable bloblist support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-mt8189-tfa-fdt-v3-3-ca423d2d8038@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=QIiGeu0RlcPtvISTnFwTfRFWm4zx4eUS3GBGnJBRZa8=; 
 b=kA0DAAoBwswgAf8Bj8AByyZiAGr7hKSiVYYxO6u2uG3Yvc6tIuFVMWVrgkkKKdYRYjeXKpQdN
 4kBSgQAAQoANBYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJq+4SkFhxkbGVjaG5lckBiYXlsaWJy
 ZS5jb20ACgkQwswgAf8Bj8ApDgf5AVLL71IQgEOWuIE9Im3T44e+zSS75yiStnAbMyq7syec06d
 7CR9R8/cmGHNLjnfJOkz+36uctiVMZFlZt2gjLstfTsSCpE+TfULLpDSH7A7u+mt2nlN3yD/0TB
 sju4VU9/pHokOlATofD0O2Wy95RaKHXUrtOifnfzDrQe+CbsngN+vh5C1hsvqGFJb+k7Cx3m3e9
 YxsqMHc3iYcqnlxyvmEvHn0EZX8SewABtcC6bmv+On3OcSvp0meo5YLDI/yqXAmKZ/2nw/bf3oF
 IqBrPTB8e748yXFIRYrTdeoovY8LKa/GgQ4GO9aS5tHVCI0vEbyEgxI+cswhpriqEUAJog==
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

Enable bloblist support so that U-Boot can pick up a Firmware Handoff
transfer list from the boot stage that initializes the DRAM.

That boot stage can describe the DRAM with a devicetree overlay in the
transfer list: its size and the regions reserved for the DRAM
controller, which depend on the DRAM fitted to the board and so cannot
be described by the devicetree built into U-Boot.

Allocate the bloblist in SPL. SPL otherwise defaults to a bloblist at a
fixed address, which this configuration does not set.

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 7d526041ebf..efa95a2fe03 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -12,6 +12,7 @@ CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
+CONFIG_BLOBLIST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -96,3 +97,4 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_BLOBLIST_ALLOC=y

-- 
2.53.0

