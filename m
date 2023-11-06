Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF387C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F2386BEC;
	Mon,  6 Nov 2023 09:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="odtUVliV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515A486BEC; Mon,  6 Nov 2023 09:47:02 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5020F842D0
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so2702178f8f.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699260419; x=1699865219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iHMBMQe24ZRisUd1uPFxpSVdGqw2WtE6BHmcrCsx2s=;
 b=odtUVliVtvu7IO5dV26o9JrCWC5IEzpZJiyw4teQK7wUkLQkOOpP9Im32EyV5his1G
 TjwIWQvRi9me6MXkVSwbbHyUxBSog/1r6AcUdNE4OqcP3C+6UWwuCrZ7LU4xbsbYxByg
 7g3m3R7K3sYlQOvZHcw+FTeMxxIFtVZb36nOcfcgHXwDmp7t1NWWRD9M1FPGFYy12JXy
 WqMCA+6hI7iY8SeCCD0fHuMf05JSJ8TjuD0PAqk2BwtRXBMerb0QmQsfI8152WsVRjr6
 x6oxfC8QVJpCaXRshyOIOYKDEgig5OY6yV3YspE7FME8Vm0B2DiJI1ve2Y47Q6XGVhQb
 mjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699260419; x=1699865219;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iHMBMQe24ZRisUd1uPFxpSVdGqw2WtE6BHmcrCsx2s=;
 b=HMFynKmaNq3lvvNl6B7YQtpJWbHxinjhj4FaEo6PtM7p6hz+ki4TFoXc3i/eV3ZGH+
 7u64YOxtPHH/ShViEv8OxeG9jr8oo7ug93dOZmFhrnR7uk47yC9xEt/hbbJcHc/5nLS8
 9mU7c0Eg6QrwT/fGA68hTtCamO5VmLu0/tiDmnZD4ckB7LwUgvKvyGCsFn/vQTdIqqy6
 Ed1T39vhCBgd1jBniu1UT/4caBsUTOHrLyEykA6RFQ2inB7QAXH1okl/yG51JsGFWGcH
 DvL32nx86lE+Vag3u0gbE8/gulVhQjUW4JU8vb+ikXObmXzM4AJIqTJnO3ukZ+lBwqEz
 +zUQ==
X-Gm-Message-State: AOJu0YzD0ImAQ+b+VDbRBXlxlEJ3eIAfqtHrgrLWGruFGmv4lTnsfQ8o
 wDga66Pph+/q2DsHhUZhiLD/ig==
X-Google-Smtp-Source: AGHT+IFCGqmvGOU3ee8vR3ebaaD2vRmONAeqrKP8nLRS0O2PQetswUbv6QhunsnFELMurpwADmJOgw==
X-Received: by 2002:a5d:6d81:0:b0:32f:811f:5046 with SMTP id
 l1-20020a5d6d81000000b0032f811f5046mr21822248wrs.11.1699260418680; 
 Mon, 06 Nov 2023 00:46:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a05600004d000b0032dbf99bf4fsm8937827wri.89.2023.11.06.00.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:46:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
In-Reply-To: <20231101140500.9025-1-avromanov@salutedevices.com>
References: <20231101140500.9025-1-avromanov@salutedevices.com>
Subject: Re: [PATCH v1 0/2] Meson A1: fix USB and NAND stack
Message-Id: <169926041799.983914.17615678438055862098.b4-ty@linaro.org>
Date: Mon, 06 Nov 2023 09:46:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

Hi,

On Wed, 01 Nov 2023 17:04:55 +0300, Alexey Romanov wrote:
> After a recent sync device tree with the Linux Kernel,
> some drivers broke. These patchset will fix that.
> 
> Alexey Romanov (1):
>   clk: a1: add new clocks for USB stack
> 
> Dmitry Rokosov (1):
>   drivers: sm: bind child sm devices in the device tree
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] clk: a1: add new clocks for USB stack
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8ec790399aa88bb8d0a02282e411f34584c74950
[2/2] drivers: sm: bind child sm devices in the device tree
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/e9f4f7789cdcda342b2f7edb82a6141f82f4c7c2

-- 
Neil

