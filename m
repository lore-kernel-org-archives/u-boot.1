Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F34C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 16:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E486080283;
	Tue, 21 Jan 2025 17:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UciCzkZk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC3A80326; Tue, 21 Jan 2025 17:06:03 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4B1801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 17:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-436341f575fso64587695e9.1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737475560; x=1738080360; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmhgOXbNMFq87D9IuNURrhQ6bslW7sKX71tIVeDmzCg=;
 b=UciCzkZkRC5Ea3y+AhsSsBjpNxsOKYIR4J4PTm6EmIYTYOb9kllf4VcqK11zesnJyx
 Z1MsuIhirsau6fAVHOATSeArYoil6KJOtB0vuSg2RWdRkj4pL23Z2yuZHXtkzLTyBzyI
 yt+jMqB8oTWZD//uC7lrYehhmesDsH+LJiEKNQt34yKMbvXuK6+CAAsjw5Qx64qqNGtn
 75VrVo65qgRT/NCgqd+4NejNgeOnLkunKySLr5vUhaC0GOaUh3CDHFqiwzW96iQgmdQ/
 9hrQdTxHrqGtlygIXehUB6+FZNEZDlKaAtQi0ioJmNGTomELAVtQew41yg7rt/7CHeVB
 k4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475560; x=1738080360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmhgOXbNMFq87D9IuNURrhQ6bslW7sKX71tIVeDmzCg=;
 b=gS6qzrzLzk/H6vnS5vNG9BoppM5MEqooupp+Mp8Wmao5otW20uYdp+maYpFvL+DwP6
 PE587NLVhr7stL3SNam2lLyFCLg7iERJjLmLMbsteeZB9MfoR64PVS2dnuggi085u9BC
 3U1K4AYw6+OW00VTTuIBjsjIww6MbdKjvKXyMYJ3ggbvQ3/bn/AfICi/n9V24oRe0heK
 +6K/D8wd/Z5IGGiOKWYyzQrl0joi/xMJy9NzCf0/9nprKn5fm0O9XM/YHuioVUALRlop
 ojePWya7rMJsxDAKmJ4YqiYw/BNhllxGZH6RUw66v1MOpFhadrbT83EcUFrgQrUzYmRj
 kSlA==
X-Gm-Message-State: AOJu0YzzLC4Q/+cSBNOp/YrXsa3aQkRnnrbBbECTCi0Jko/WpFfXHkHv
 /jpSCNRU21uphCsTOMepsvHoyjs77HELGFAOCnls/gn76qfvP/JJcQOy4/RwORY=
X-Gm-Gg: ASbGnct5DuEZvVHtWGRnvi3F/+u09gEvpRjbv7TSBlbwqhJNyPgpB1xKiJhSPDzzSyR
 pFsAAZetLHXXJaz0d3NCDJRRTZPNab7j8UtrEpp44W223gjAMDUa2gIzrkdpuAJmall7B7PVak2
 /khk8LqP6GiOB5kZxi60Te1h7Mw1X6l/+GNsvqDtxTO4Fa8tTFUkQFdPtTpFS7NJd18pgGU9e2Q
 58IKC+qCKXkg/pvNuYMn65/TFM2bF8mIfsrQXPCsbwpmJ0iEJE6qpHnWv+46RlHZIY6nGlQS+ws
 RIZlUeE=
X-Google-Smtp-Source: AGHT+IFeJBiWdMYJ0tJtditF3PtwLLVR7AxvSrvMK0wYmDBuJUqVBPUbxdlBWVv+h4yi3QI60Kq4jg==
X-Received: by 2002:a05:600c:3c82:b0:434:f5c0:329f with SMTP id
 5b1f17b1804b1-438913f08a2mr195941915e9.14.1737475559923; 
 Tue, 21 Jan 2025 08:05:59 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753ca42sm239298325e9.35.2025.01.21.08.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 08:05:59 -0800 (PST)
Message-ID: <d81651a4-f849-4d4b-9e6a-d8fe277b3d03@linaro.org>
Date: Tue, 21 Jan 2025 17:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Static initcalls
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
References: <cover.1736174204.git.jerome.forissier@linaro.org>
 <20250117214621.GA2503843@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250117214621.GA2503843@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 1/17/25 22:46, Tom Rini wrote:
> On Mon, Jan 06, 2025 at 03:40:12PM +0100, Jerome Forissier wrote:
> 
>> This series replaces the dynamic initcalls (with function pointers) with
>> static calls, and gets rid of initcall_run_list(), init_sequence_f,
>> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
>> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
>> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>>
>> Execution time doesn't seem to change noticeably. There is no impact on
>> the SPL.
> 
> This fails in CI unfortunately:
> https://source.denx.de/u-boot/u-boot/-/pipelines/24241

I found the problem. It was a silly mistake :-/

diff --git a/common/board_r.c b/common/board_r.c
index 74ebbdc7de9..21a8b97d1bc 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -717,7 +717,7 @@ static void initcall_run_r(void)
 #endif
	INITCALL_EVT(EVT_SETTINGS_R);
	WATCHDOG_RESET();
-#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
+#if CONFIG_IS_ENABLED(PCI_INIT_R) && !CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
	/*
	 * Do pci configuration
	 */

Shall I sent a v5?

Thanks,
-- 
Jerome
