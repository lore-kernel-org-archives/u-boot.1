Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACB1CCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39AF83849;
	Thu, 30 Oct 2025 13:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AahYNqxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76DD83826; Thu, 30 Oct 2025 13:16:31 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44999836D1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63c45c11be7so1550660a12.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826588; x=1762431388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kNwnOsSM56+kAFnc64o27Z6LLWpSMxdG+2xx0mAA+UE=;
 b=AahYNqxSubwlNjRL2q6D4h2BaXbQTmLgJ7WP7L0LGh8Zau13hWGsHU2PJNmSOSUZGy
 +MDnD7XU8kgQq1xYQB4adIB34IXtVN6CaqwAJRgQ26fnbE0HqBNhcpMO9LbAj0vGUSOt
 7IqhkkqynSzSwfJdQ1KRoKg641K1/1MvXb0/7Gvnw6mfyUBTiGnks1TJOXDGk3AvYfIj
 Mkvkvk9oDFW7hAvOHJMvjck6DxwJ7rOYDaiJcwU0lc8wvWUhj4T8J6GF6Vap8/6mk/sW
 e9Dn9A8XeTalV+7hYSfYN6f61LIFkCP76ON4FnenVVkJ9yFoTUUcjl+JUd5VICKLuh01
 X2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826588; x=1762431388;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNwnOsSM56+kAFnc64o27Z6LLWpSMxdG+2xx0mAA+UE=;
 b=dfRA/7DTa3ZCEdqNlyL2jyPwGo40/zcyU9pLcaBaHCYM9pQvIF9oKngGBkj/4C1d2s
 z7dTlcFj/NnCncWo8hRo5nTNXpy5cyrYgiVSF/rjseRSfp16VduCivtsi1Fwgr0U50ay
 TsWWcZHoxfVOTdBufX0ck2VaH4C1HzB1VYPSgdIaqO9Oc5Y40QHYOwqEIbxjfDK23IsM
 rqe199upaiHBWyuSOmsBlie6TZJKs+m9WSdaxMWoVKprulER5slbHsC5d9rzN4jIcRuX
 Lb6yKhOReCKIwI+AFOu+ViAKCyT5xfYmiWeq/2wdQ9KeAPzkagxh2ulxU/1lLlu1qQVG
 XXZg==
X-Gm-Message-State: AOJu0Yx65+fcUV/piDXF4M3ST7cUqllBWuu6+r1Wmii7a5KPnfgQcpN1
 3fBDtVOzlY2PHSsmS5MJvmypaKuHP3MENpqwJPjyVWTxAUnU5Gztok+KCKZodXwNSMbYLV/Apk5
 LPCaHOjU=
X-Gm-Gg: ASbGnctw9lSv6kDkbc4kFG02Fp/h2lWDdThzqrU0K3nB/fJPZmh2ftgwe+YcQ1Sh+73
 uLP7O8EbBflRpoUCk5mPO5cJwtnYhgBqmX5r1NV9Dm6yzDIntVjZs+qTojOinnTXSUf39a+cS8W
 boYbq0JZpVSFEaRnKmSqK2HQRl1+mr9AbCZtcYiSazUI7f+mW7CQxCZcEJkgnF5P8txjmGQ1ORj
 2ozRwQzZHnun3LVUlcX11+PmGuntDAUhFYwVVR18V8Z7vSyc3spQzaCXthk3+xVpFD3wez1eZmz
 MoHujrAXOim8PLbmOzMveM3booPXu1YYW5oAl6I2d8I2hPS34YzBlJWrqWfby2UpArn3ASbBVAI
 V9YZHQKEdKnhJXmZZODgTZ5G1BC76falR9x0LE3yOo4yeaD7iN5Ou3MIgZbqgoKXZFNdgxygOaT
 dfo+xNEvE3XV/D/UWPoGSfcJ2ZmAN84M2xFbkjpEW12190
X-Google-Smtp-Source: AGHT+IH6SRuOSUYJroLcUvOf4cLesfgqGz+lubT6UQsRhd95pJLdZb12AA3ilDeIh5kc7GCCLrUlng==
X-Received: by 2002:a17:907:d29:b0:b6f:198e:c348 with SMTP id
 a640c23a62f3a-b703d5392demr615108666b.46.1761826588379; 
 Thu, 30 Oct 2025 05:16:28 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:27 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>
In-Reply-To: <20251010051200.2313081-1-venkyada@qti.qualcomm.com>
References: <20251010051200.2313081-1-venkyada@qti.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Enable meminfo command with mapping
Message-Id: <176182658725.4111945.15659133151094956735.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Fri, 10 Oct 2025 10:42:00 +0530, Abbarapu Venkatesh Yadav wrote:
> Enable meminfo command to be able to see where things are mapped.
> 
> 

Applied, thanks!

[1/1] qcom_defconfig: Enable meminfo command with mapping
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e51d4d23c714

Best regards,
-- 
// Caleb (they/them)


