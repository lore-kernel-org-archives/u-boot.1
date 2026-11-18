Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpcssFPa;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XEsfqT0c
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0914D40981;
	Wed, 18 Nov 2026 23:20:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeWkGII43LZn; Wed, 18 Nov 2026 23:20:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 596A4408AC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795044027;
	b=NubNPKUdcK6/Bpa6dJfS00bNRbtrYjgfaJrLrz6LGuopWoutMvIr+pSXbs0o+LAQR1pq
	 ZrFqkvicepMzcVZWLfinElzM8hwsEnM9NFSrhZFP6ClWZ0EpJqV1KMs41/dLCuk+Q5i+U
	 rZczWsoMvR5Lw1qZyP1LDDYTxdt0qGB4G7qJFR9NaRz62DRJ12SHPaGL9WPL4fZh6ZwcP
	 cafUKEic7f3XZTJYJLOxCraMjqFBdzprREgG223BFC0fL17e2MSVXqlLErwNMv2WSWN6O
	 6Jao7JUWjrDdNA5i1p/BixyXGbpMw+014erKn8mDZmyc6YWUC/W0w6tzGjieBereW/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795044027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KtRVI19Rs0iuiSsnkNe/Q6MXKj9GRC96vRoJMFF6DD4=;
	b=BqD3KtyvfDf2WkbmMHM5TqJY7QgRF2dQDmnZNPKRb+5kmpyJSBmhqfmSyPNdswtwaRxo
	 D+e5VQ9cah4vN5cNvKLEL7HXPAY59QAE+LeycRAJ2+OM+ACvrHvn1SuM0QHNmVORs5Ud3
	 GY9AdCqcibneYQYM6qwFbJg2IetUMdUudtc5B6C3vcQbj7sOFxgffFHjneUgEOMiYaHLF
	 xmKIIG+ykfkLuaxiHo288emYnaRMJLSXIASu2l9RH/y6Te7HQ+G6tCXSUE5n/KtqFI1O6
	 hC6EherhrMblq8JsAngStNqnulxd9BWP5kuty6d6AEbYUJvqOCTcOe2nY/LXLOjOGzQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795044027;
	bh=KtRVI19Rs0iuiSsnkNe/Q6MXKj9GRC96vRoJMFF6DD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpcssFPa0En2nPrZ/IKG+r+ePLWne/Ipxdx8cBijtzQyDlI99750NUGMBjV6bQHgM
	 YU1tU4sZJDW/FKmTxQ9mOPmF28zrKoTvmZbPLz18EUaAuUcJfi83Z3KVp0PkpqeKSQ
	 0+/TnRsjFWLxYipxF9nKZw0/V/QJAl3PxsQwMPJ4iyiQDAhwOeqvb/OE4rqjk5Oz8N
	 mSPheqnRO64n/7V4+IAp40K84KWBnOcnHLKQJbw94XvYQVbZL8hCRBZ67VocP17hoS
	 bjI++4kk7/m63wSys/m9DCWPzltPNFqpUx7tzwfpq1XOYv+NbhMsLASKI6p9L1xHpQ
	 0+aj2h+YRyw0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 596A4408AC;
	Wed, 18 Nov 2026 23:20:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0103F9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D44758128D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sH3lVevLTwjA for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 23:20:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8277F8129B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XEsfqT0c
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8277F8129B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 23:20:23 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-85a5455bd3cso819357a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795044023; x=1795648823;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KtRVI19Rs0iuiSsnkNe/Q6MXKj9GRC96vRoJMFF6DD4=;
 b=XEsfqT0ck9osleNiVbThHLVTI192VnrKKHh9LPElRAaVu4paJfxgUouCIiBHCjFqZ4
 t7QDrc1kqXycqKTuDoRt8N2r8xBPoZHYA0rUtKRezICeHVTLtdUPU41D3ktSGi1o6yPC
 grT0CPZD+XLYCfHJHquynrbbPIDNHubyVbPQPrFKc1tqa13Y8nB9n7jFryOBDT+iPcDQ
 HcR8u2od1eFRkfkDR1ed54TV7FllJuVVayTFwD+65j2iIq9y2hQ5C4Q7WlK5QJW5HAyL
 YwPedRITF7LnN93LqfZDbGoe9zqs0KjBR3zgtXmUYZPchXGEH9e6YaELOwi4HXuf8Yw9
 /vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795044023; x=1795648823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KtRVI19Rs0iuiSsnkNe/Q6MXKj9GRC96vRoJMFF6DD4=;
 b=Ms01c4XzKejpiQxlurtLviffy1US0EQhxAQGs06er1IGY49NY60iOJ6G7y9qXKmTIL
 bJf0f1OVNBbHANvceQ4q1DgLXhX7JKc7AlrjGhsYzOmnxuarFAwNc2ofFwK3sOnJy9Of
 fnWdGrnzVf6Mb790sp6CHxz9z02wOVJo+ke08umics1JlvBdS5TzfiIHNp+nSBlJncTR
 GZyYkVERKskpWKmwBpImInnW6d4Z1iRISKGPOjoczVIyZnjOshnN21WPhn47PoCEMRnP
 YxUzM7NaOTT13/Qn/rmDjfZfcho/yzJ3VK5h6FQyt/gE51nKhSiM0++r+9DZicBcPL54
 xrNg==
X-Gm-Message-State: APuU4Z/FLU35HBmnF3HSaSrp8NyyNxeeevrXRcHU7iUBn/X+QFWbbsyD
 SiX3n9ehROa2nVOk0sq3+gooDGQRSRGTzXDi0IsiD2W2VlQelYq1CcssVUAPLBH4sYY=
X-Gm-Gg: AYBFou1iOMqUNWCaNcCxMXfKQlAr+RAu7+v1fW7u6bLQQfG+H/uQUgEnEEPRJ/hpqal
 bBW5wZ/pYG9DA1uHqX3Qc1bKzs5opf/d7JuAwwuBWxeIBZCc3LfoyBgnPUReL4JEGqIReenewm+
 1LWIuLf/iyIUbdZggz+/Ep5zchiXIUlTEF38ETY/dqkEgz/hPuZ/kiPcSHKWXwACMTcB7eJA8ao
 ZB9gxcO29htyaMM7ocCJ6DbkO7OmVAqGuuuhpjLGO7zHYClY0ETFYxNQsf5X6UOkCGpetrhIrpS
 w3J2+JoWV7B6dqcA1LUe2i9cLsC+aohw9+rMkqwsluQ5gdV9Yp7QZd9eDw9sfdav3UtVqg7LXIx
 zqwzvfK3cErEQgG/heNCtjjV4Rl7906ZA9l24jhaWecIxIuqDQeF8GlTOq1UD4cjs0ABeQ5J+55
 7vElL6OYP6VINLfWGcYw7tUp7/9R5QlZYAJGBydYf9iAUA5t85gpSLKZI8MXz/3FsNtqDO8qCye
 xyeqbvsyTsmh6r9KOkaaSIK+hT55phHc3uJpgp3o6i/G1L7C8YDlIA6mGK3tETFuAkWHiulnX3H
 9r89fowaPWzwvwV/MpmAlVgczerFy80L
X-Received: by 2002:a05:6830:43a7:b0:862:c685:84b9 with SMTP id
 46e09a7af769-862f0953d11mr4772676a34.10.1795044023032; 
 Wed, 18 Nov 2026 15:20:23 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9834:2835:378c:43f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862f01d4764sm3025878a34.5.2026.11.18.15.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:20:21 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 18 Nov 2026 17:19:01 -0600
Subject: [PATCH 2/7] configs: mediatek: drop MTK_MEM_MAP_DDR_SIZE from
 Genio configs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-mtk-genio-one-defconfig-per-soc-v1-2-1505d27fdfcb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Py4eTq4lW8URKyMV2+iDgaBJoYinFPXUhWWT5V9Kzz8=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/jKH70oKAq4sWX5bRNFsahJ1aLore4Dy36tXl
 qUo/+gPk/CJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav4yhxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A798H/jsr2s666fyYIoGJCHj5VGKvwCcMlq1x8KlsUJD
 iCL6n2lXMI59nPMdh6GMqrL/dHgW2Ml7sbqrTpIlzXE+lWGYUVoQCo7MpnoXX/ZO9tAuRG909TB
 Lv7gPHCEhxnFzltxiH7Nyp/JPbwzaMPWADcZ3vz2WboEMdySmox/ROXwUTTkVGu1xmjH/UTCJYs
 Ji3oXRYPSBKj5zn5rc3P+YuRosE2CFSQzLpACu1KpWShu7SAOAzKcpJ7uVBLfQnf40SJ35U/If+
 zpD9UfdQ29qOBOOhxmih1ulIx2sobdW/NJGhFXgwxX45uDF5KtbrvgVk4xz1EixkyrBtk6Nik6k
 uuWs=
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

Remove CONFIG_MTK_MEM_MAP_DDR_SIZE from the MT8189 config fragment and
the Genio 510 EVK defconfig.

U-Boot proper now maps DRAM from the DRAM banks in the devicetree, so
the option only sizes the map used before the DRAM banks are known. The
SoC default, the smallest amount of DRAM on boards with the SoC, is the
right value for that on every board.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8189.config                  | 1 -
 configs/mt8370_genio_510_evk_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/mt8189.config b/configs/mt8189.config
index 52d9cfbc4c3..3ffa40a6c2b 100644
--- a/configs/mt8189.config
+++ b/configs/mt8189.config
@@ -7,7 +7,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_DM_GPIO=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8189=y
-CONFIG_MTK_MEM_MAP_DDR_SIZE=0x200000000
 CONFIG_MTK_DRAM_DESC_HANDOFF=y
 CONFIG_SYS_LOAD_ADDR=0x4c000000
 CONFIG_FIT=y
diff --git a/configs/mt8370_genio_510_evk_defconfig b/configs/mt8370_genio_510_evk_defconfig
index 2ddd8d2a36a..b45ed21c646 100644
--- a/configs/mt8370_genio_510_evk_defconfig
+++ b/configs/mt8370_genio_510_evk_defconfig
@@ -1,4 +1,3 @@
 #include <configs/mt8188.config>
 
 CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8370-genio-510-evk"
-CONFIG_MTK_MEM_MAP_DDR_SIZE=0x100000000

-- 
2.53.0

