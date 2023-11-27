Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B69EC07CB1
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A6C877A5;
	Mon, 27 Nov 2023 14:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPhL9c+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD07D87792; Mon, 27 Nov 2023 14:01:46 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56358778F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso5449360e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090104; x=1701694904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4tmMAI6bN3rmmIrKHT0WUsmCiaKDkfjRDPTN49RrJQE=;
 b=mPhL9c+HbXWw/opy6Ndzn+/bDmFBWOj5KNLXkTkn5NYQ/qw8U9p+QvGdysQMoH6YoE
 EuieMEr25Z5tEWzJEObhTlbKTodWGHL4mO5BS0h/k4lLj2Sm2girN0fi9GW55r7PRKXe
 SLIn/YtYmEsOju9VLK0v2VRHUvOuqY8G+8QAvi18fRGanxecDPqdHeJCgSxEepbkGtnw
 XxeGZopfrQ/CBT9tXlXuIBMwEAKTfNmrjOLqF+CRCeP+lEkzwXfZvlwST67fVVU3ywMY
 f7skMSpLMgUB8EzMUfxTo6dlOTrTgv9cyPJev4nkjnuSObGuUVQfzLFD06uosn0+2jr9
 29og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090104; x=1701694904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tmMAI6bN3rmmIrKHT0WUsmCiaKDkfjRDPTN49RrJQE=;
 b=XIpi7q+zhWTP0daYbRx6RtTaTgozSj7NAVVlMZ+MpucYEsgaTo/Py1AkjyDHtWSBHB
 uQmw7DRDeTbHxE4n2z6tFqgdQoTthbKbR8dbyl88b1QAJZWvK6YrWwNTkvR3hJMzlMKY
 kpSF7Tm8+aEoCa1Q0XyE8UJlAS5t4QH4WTGFkQHWmJ2yERGgeDzIVcW0pgu/7z2fBn3L
 WUCuR18JZJYkzf5ps9oEN2+zkT9nck5PGNh6LronLg2jO5SkZVBAOH1xKvQn5OGDUIEh
 auuFlRpt9q3uFx7viqeXCk6tYd5MEc4OJLzkJC6KPtfLOdjKqjDbKo8Ti41vf/MehGd2
 YDhA==
X-Gm-Message-State: AOJu0YxZSu2F2L9H6l50EQH9MyHPp/l4Sm3PAMIZ+qezHJ4utIU9G9Fu
 pmyBnJxFnKFbIMi2NWcbuSVQ8O8vtr32a7P1zge/zg==
X-Google-Smtp-Source: AGHT+IGjy73FeyG69aFcNDMBNsr3uILNPA+YR9tX5+dEsCHFMnLRx6ZvtqdUssIv2ZTiBmiCuNwqpw==
X-Received: by 2002:ac2:5544:0:b0:509:297d:b7a2 with SMTP id
 l4-20020ac25544000000b00509297db7a2mr7161138lfk.65.1701090103706; 
 Mon, 27 Nov 2023 05:01:43 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:43 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 41/43] mach-mtmips: inc SPL size limit
Date: Mon, 27 Nov 2023 18:57:24 +0600
Message-Id: <20231127125726.3735-42-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Increase board limit on 0x200 to fit new IP stack.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 arch/mips/mach-mtmips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mach-mtmips/Kconfig b/arch/mips/mach-mtmips/Kconfig
index 15b2792e61..2f07e3a491 100644
--- a/arch/mips/mach-mtmips/Kconfig
+++ b/arch/mips/mach-mtmips/Kconfig
@@ -37,7 +37,7 @@ config SPL_TEXT_BASE
 	default 0x80100000 if SOC_MT7621
 
 config SPL_SIZE_LIMIT
-	default 0x30000 if SOC_MT7621
+	default 0x30200 if SOC_MT7621
 
 config TPL_TEXT_BASE
 	default 0xbfc00000 if SOC_MT7621
-- 
2.30.2

