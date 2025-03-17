Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BEFC28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E47D68198F;
	Mon, 17 Mar 2025 14:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jdpSooG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8768081A; Mon, 17 Mar 2025 14:48:35 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97F8D81B5C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso14015885e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742219311; x=1742824111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rUe5EIUSoxVGczviAoIz1SV7XkFGIX/XpF3oACkShY=;
 b=jdpSooG47JuDw0+qSn5JGCFdNSR1rZFc/TCWu/tEf/kkzzcBoYb+kCulJEs21XGnm3
 78FaU+DXvuQVZvw7taEn+qBoA4Y186rGYJs1UmEt96gBx7ghxBJ4FdmKzdVq2vGcWy/8
 N7Hg+pO+y1EQc/uHwMiZnTqu/85/fqM5VjSUjbWqgD00dJvrULZxO5VUsn/2B9m0zO88
 ClVYAwv+rdycE97LIZdPCtkTO+ReGRxrTNYLLJ9uKe+oZIRbmj0zEU1R+fjn0soVrcEJ
 5vijFVzqczainkeQQTNuoPy17r+TkXyki1l5RXOrQTZqwT3DHJ8LQ/0mjLtVoiwZnOKG
 xEiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219311; x=1742824111;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rUe5EIUSoxVGczviAoIz1SV7XkFGIX/XpF3oACkShY=;
 b=nzFZWn3vQ9lIQn7Z+0YPXYFfxSvgegvndQvZGw19vs9DJmSVcbkJkUWRwNEnLTnGMK
 NWMRiY2rytF5b23jOw/rM3kuDs5p6Ioh9cvCVVzBXBQoxqYqttDU4Zt9fLylZuR8cNW1
 A3mt0inD/nlnpbGVtDUOuB7b0ATFF/VTay9C5WZVA6BxGAdY7BkzLpN+wX76M4l+2X5o
 +9S6i1zZoPNdttD6W/anm1zQnjbv6VyZrLTYRXI86IafX17R0giypzUNzsqvTiDQ/slK
 J1XLzd7cEPTC/OK+s22XB9pHr4i4oSzdLOm0wJSHfG0X5+zzonZyZ9mNSTqI974FcfJx
 AUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCElVUoOkmRwlyisNXgEjKSKWQ9BwkfOgS6jN2clb3hFEektCz/smo7ziqczeFVaFg/n36daQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzEUzpU28AT0QJ/XRyftKB0WQJJAw49xMQfB112F7i308+kFbjs
 c/UzqkycSvLRoqQNGY8kJPR05S4wauDHNk2idDct9FAi+yl9bUjinaFFW5ldbZWFXrNV/BolGgr
 7rk8=
X-Gm-Gg: ASbGncuQxs2egDNbCCzqKL72eRVPUS8YLj9T1MpCcoeiz6zD45Cmw/LGPpJP0BY2bFo
 hvSZgHwcZ3QKct73//ijL/zb3sOPihcUppGw5FgNC03xJdnYCgNDG/3VQjj+FKBxKnblDe1dOTe
 GBY5NX/c8rJ88GG+Jjn6xi0hRZdZhCMiZW8LMQcgiMVjDiEZ7Am6kKLoX11CzM7HdRfF6WidHpF
 OIBrnhSnniejtlMhoXq1IbY2VXR9my9xq/WmEsiQlTQrRx0iCseLwzh9l95pkctmJdM49SvqCnf
 4m0Ezs/846N+H69aDW2m06HKo5sZ1MIdXhrQtgXKToJ8wmXVca6ppkFGiILt
X-Google-Smtp-Source: AGHT+IFhe9MobBE1FwapPAAmEaaYb/RcXlzfESyq7XbwTUeMvVGyMwi16yArMwVUb0K23bF6D3jTZQ==
X-Received: by 2002:a05:600c:3b97:b0:43b:c878:144c with SMTP id
 5b1f17b1804b1-43d1ec784dbmr128564885e9.12.1742219311098; 
 Mon, 17 Mar 2025 06:48:31 -0700 (PDT)
Received: from [192.168.1.116] ([2a0a:ef40:1d11:ab01:670b:cd84:4753:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d200fae4asm105655945e9.27.2025.03.17.06.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:48:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Julius Lehmann <lehmanju@devpi.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250317132519.46080-1-caleb.connolly@linaro.org>
References: <20250317132519.46080-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] pinctrl/qcom: fix kconfig option names
Message-Id: <174221930997.73541.15483519776374375595.b4-ty@linaro.org>
Date: Mon, 17 Mar 2025 13:48:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Mon, 17 Mar 2025 13:25:14 +0000, Caleb Connolly wrote:
> A copy-paste error is starting to get out of hand... Fix all these so
> they don't look like clock drivers in menuconfig.
> 
> 

Applied, thanks!

[1/1] pinctrl/qcom: fix kconfig option names
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/364f6610278d

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

