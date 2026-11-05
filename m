Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE32606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qv0uPYV7;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=IrGDNPX+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE6A04091D;
	Thu,  5 Nov 2026 23:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CPRWj0kAQVjP; Thu,  5 Nov 2026 23:46:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21EC440913
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793922402;
	b=NSEvl4R2MHGZVfnAZrqk2VrUUy6hCAUm5xQb/HVJ5lCGU28TA8ba4+5TDfgnlg+u0R/i
	 Sc1CLtuEukeWtJOq2kPcrSgB0fS1uIr40oEtj3sijuMBCiIQXk3rE1PoI0B8GHRfAOo8t
	 6kjBDQ1N2fvRvvh9YkNhfXGH+DNgFs5erAJugnsiIEbzNCGG8Ealn2C8G8LMcs/QRena2
	 uyj/seK1M17AzXFzfwIx4eJVWB5yfPBveR7HUSTWG8OkfABfSu5HWpjaQt1lQmTQEPo6X
	 nxJUXfqsUGlgr3TFMq/OS71zf9AUFirdNQnYgGHxX7dNlfUh7vZN1SyzcwIVVnfWk0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793922402;
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
	b=j4Gx57W3K+pAt68mst8yyKhP7Qcxtit4/L7Rg9ua6UpgZnkwuqeeWsDPP6IQKMxovf8t
	 n7mcZ1X3xY77ikQ5x6iNf4WeLpiK4MNKTRgeD1L1SYfWhBu/T5BFdKbbfkhaHKali03Iz
	 3/KDSLdHvJcEo04GLEYcX0j7FipuYHUe5tHHVucxUOphy3v4Too1B5jrh4DWp/Idr7ePX
	 tRypGMmlygNC+NyaEnA62+w5drxXkcKp/ZwvLEYdVWXLLMKRCVyo00FXEVfmP9rOfOy0H
	 oEBCSjlYmLCnfIVp4qBDZ3ZBbgI6W2fbhlUIME+16yg6H6opnRP+WEFGgjEZ6OPZUSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793922402;
	bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qv0uPYV7+30grYzBoUb5duGhW0E/WWlPqEuyGNJ4V+5QjdMAPm1WswdKJHbu7CIgP
	 PPTTH5gp+qkttdwYeLJ49Yd7gdoa90W+UPkRnpOK8iPIsNWqv4lBWAcc3EfpVwNg8j
	 aXGYvYPaPOGk99syT2qo1T9VESZrw+JPjgBck7Xd28P64j8/tXXTve3CW9oEzBLjOM
	 Z7axoHEwzF7Mr1SOj+BfMY1OtEFdInarnt1lIceBOTD75P0HBYGrCwtVbk8C2NGRl9
	 1yogQUNpRFqIATnVaTIJfa8lhZ5CBlL+5V1KnYecrZcHEvGW43uvNBDXxLo3GniAgu
	 hCV0Adp7ucNPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21EC440913;
	Thu,  5 Nov 2026 23:46:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D656D32A
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAB4E811DD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dTywmlzjasgE for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 23:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8F24811E8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=IrGDNPX+
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E8F24811E8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 23:46:34 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8241a56cd70so82360a34.3
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793922393; x=1794527193;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
 b=IrGDNPX+G5n586YfK1n3N6tXex1gypKicQFygFu17NRKWw3k8yZypGFQblIIsniM4w
 568Rqeu/LXU7rlOFEZqzJn/mf171SPDX5m8tN8ImwG2c1V0EkvRNxFn301kGxwuhAcJt
 E+cIIGn6GHwJXfwvEr5nqqUJp8/uFN/Iq9Yv6lOMvaLToENH7UYsfNXCY5XaVKvQSoL+
 9PLS7zgLKw1n+/3pfKjY+rRU5sAeu/h5/pJHTofklxrge1MyMpIAEgK8uFeTyNEAkpSV
 56A6J/lH/HQO6T+APzTu0Hnxu10P/FOwqLMt4ojag20K9H2OxNjhkHMFoeDpQKZan/4t
 A5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793922393; x=1794527193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EqUOBMQSXvPA4e/EiQP20rLTaUw2b+M0V1RUvqS6sxg=;
 b=XotH47XJtatUQ9NxWDB8O17kqFi92nyaU+2p23asLs/c33vaEG8q8HV+63PXrnsZS9
 dpOFD/Q/bndwpjpG1KzVVH0UkvKJwSQO2zoaGcIun2I8xoW1f/fjACW2OwMDXThVl48m
 4QeyHOHHLZ6blqcen7JvbOB28JwSmeNexyN9niVqDixSUzNYleh8hLH6ySO/rv2QEr3Z
 mw+wk7FdHW4SZgvqYn6SOPRmgacAR45Ae6jY8x3K7WFO+r8jpbYKYFzBonT07BjMFciP
 w2QQvchX+AaAPs29YfRIkSNxNxeQY3hiLI2rRTEiUpSuHAQ9R4zt10fBP2qwVoFEYhRI
 bgrw==
X-Gm-Message-State: APuU4Z8n+PSsVgXWnJrTeH1It4bQ13rlkGWLTmkOTnth15fMawRBCUwj
 gKs5jZ3yl/blafqgngyCjN1ILMByFHms7BI/XVzxO8rkFvDx2CC/B6OiLRvtJXiGI5U=
X-Gm-Gg: AYBFou0LoHptzgMHofWVexNWkAx0ThndMR+tVYLpsnfSCw2Isq/RPlehEfCwYDXagqM
 uRRNOs8f7Bm9TorjtP2u8OC4yZE3lumBlr1ZiV8l5BVcxCTxiFMAxjTg34l4t5MrL0oAb1Le7v2
 4j9fWphu0jL0oaVyPQDvZwcFyTyIUNZ52f6zFZJSsLukNDEG79C6iRUNeDriud+gIOLgeMPHS6l
 E0r5BY7ZDbKRxAI2iIN1iANuXm/UamVXz/eD8H0u6TfoacdZ5hUuqJhz1gaQRS7HkPWd5+EQxSa
 8xItBZc0sbjjhx48kYoxvDTocRc0dtFO59amw+GDqpPQ+QuCMFXMX+4i71FzLwgrSvO7fVH1o5z
 RwdzSI6T4pa3/pBs4Sj/qK7ZSfKnaF2WjmBz6EfX7fhnZQ0O9VeazE1e/hnD6ieb+K7wvfCiMLn
 nwRuQbjsA6zUVgYHMWq8MAYu4BCnPg4vgZMoJwud7gCTB+Cxj//z0p5E5MpW/pNPi6w8QjDeqFe
 Oy9S8BA75TwKC9h6aNFRON8CHVkTdyz+thRo4Cl/bsACrQvAIQbZ/gN+8W0+N1oafn08EzFVoka
 yXAOSRegIwjQSMs4+OJwPDHW7pUHkO86rQ==
X-Received: by 2002:a05:6830:640e:b0:85f:aa6:b7f1 with SMTP id
 46e09a7af769-85f1d0b40edmr955868a34.23.1793922393582; 
 Thu, 05 Nov 2026 15:46:33 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1de4e53dsm592122a34.20.2026.11.05.15.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 15:46:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 17:45:27 -0600
Subject: [PATCH v2 5/8] configs: mt8189: pass the DRAM description from SPL
 to U-Boot proper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-mt8189-tfa-fdt-v2-5-c168a7b4041c@baylibre.com>
References: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
In-Reply-To: <20261105-mtk-mt8189-tfa-fdt-v2-0-c168a7b4041c@baylibre.com>
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
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7RU3Ep9qC6U3pSA6xMRhU34QTdOCjf4ps5QaM
 VQiYv2jAtGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau0VNxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASa0H/3aN0OsQcCYWzHlkjyCSkukm+a5SUD9ylOwm63H
 FD7tBxEWgnO6b98CmWFJqLhoom2X/ubha1NhA60MiZe3CM8FYDO15wcXITQrrMRndmqN2arxVVX
 WeIIgBedadYgki5YdCgsYDxcG8d/vuUefeqcUwJ2A75P6d94xXu/U4fAPp5lHGByvFjxLveopd5
 rOxiIg77q97idMPwbZ46Zy1KVxRe46MjwtUju9wrpKSGZDz/Q9poW3T6j4C5b8btZSfKKkaX835
 IOoaiRlZKInxqb7QthGts0nm8zrH8wGm97u68KuJsqUQFVNXXHUG7uo7vYaGfZ2MpZTAxja3Oo9
 3PNU=
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

