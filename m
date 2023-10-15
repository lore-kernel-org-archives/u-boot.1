Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E80CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 10:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1BA86D56;
	Sun, 15 Oct 2023 12:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GhoiBRnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2400986BCD; Sun, 15 Oct 2023 12:31:43 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B5586D4A
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 12:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-406650da82bso33014615e9.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697365884; x=1697970684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6bllY5ZfW6e2qBlt9RZnRPLPH/FnoMwRDhXc/SGUEs=;
 b=GhoiBRnnydIC1a8T4ca+K9hL1sTHJLoAdNHkUleI64vML97eyOWy5L4x5ee/5tUh1e
 q5S6JhHGDp8QfHBPy55t28bkReTNVjudAbzLqGB0tJwd7PhXzXQFh/9gNxG0TjXzFVBh
 LP0rVa/HYjvPVRFpKTloG1KSQTANlaDU+SUk8P8Dg4eM1pKpgkFulKx1nECl2WhRKb3x
 OgaEw3D0LHrqlW6a1QH78dKQ/it+Vr16dIJYWJiA61P+H875NWoWzzgnSaqzjDiWYQlK
 033KFbviXugDqXr6eUM7H/X3JbQJuntKMLgRsIpn9OTmBrLj4ZKYFyh+odB2kUxkzpUD
 KkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697365884; x=1697970684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6bllY5ZfW6e2qBlt9RZnRPLPH/FnoMwRDhXc/SGUEs=;
 b=VdUBycDBcGNbkB2mRxDyoZpbeDadT6erqIcGn7IFPimJxLiLXnI3JjqC8GT3pznM53
 QDmbiQw7/0xxd9ivQ8cRnpWl18ME1nHvHiSOQ7UZALLoFb37NvgmlatgOFKLF6JXhN99
 U+GWwXICDytcLhBmjJuE/iik5az8wzJ4YaTdUHlyemVbJqlEdAIHCKxmH3FOaSa7yMim
 P5nysUf/BJtMIiMuHq5nwIsyu9zHTAbjrci7pDeXREPaaAaltfWc9PK7d1psxk7GCKxF
 xsJrh2jc/SBYbxgGkS4olyV9c93PNF99Akpq6cdIeSsGMFVKc1gJWQiXRaXXF6RfI4zD
 xYsw==
X-Gm-Message-State: AOJu0Ywp6JRPRMeAjmKcd0rcRUg0bEn94KB/4F+9revbrj4twBwQJAA1
 RPmyRjbLzYeGYJKgDBQAvAe39Q==
X-Google-Smtp-Source: AGHT+IF4JRdcUhXfWq3JgFDxuSvHZU6YO6EAGmyyieHhnJUtwT7tDZ/EG9DyPQiipAJqdDqAMQTAmg==
X-Received: by 2002:a7b:ca59:0:b0:402:bbe3:827c with SMTP id
 m25-20020a7bca59000000b00402bbe3827cmr26517496wml.31.1697365884341; 
 Sun, 15 Oct 2023 03:31:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d6109000000b0031f3ad17b2csm5820598wrt.52.2023.10.15.03.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 03:31:23 -0700 (PDT)
From: neil.armstrong@linaro.org
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	kernel@sberdevices.ru
Subject: Re: [PATCH v2 0/2] Meson A1: add HW RNG and AO Secure nodes
Date: Sun, 15 Oct 2023 12:31:20 +0200
Message-Id: <169736585436.4181364.2812477812180681189.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010100623.74475-1-avromanov@salutedevices.com>
References: <20231010100623.74475-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Tue, 10 Oct 2023 13:06:15 +0300, Alexey Romanov wrote:
> This patchest adds HW RNG and AO Secure definition
> in device tree for Amlogic A1-series.
> 
> V2:
> 
> - Rebased over latest amlogic U-Boot branch.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] meson-a1: dts: add hw rng node
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/87dfb37d54e59f89b61d43970861ad81d66f38ca
[2/2] meson-a1: dts: add ao secure node
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/7b4116f8f78f73906da59cbc93c7874948323e4b

-- 
Neil
