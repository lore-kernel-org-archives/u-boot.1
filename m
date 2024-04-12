Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28130C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 18:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D21687ED3;
	Fri, 12 Apr 2024 20:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WcnVaDOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C384B87ED9; Fri, 12 Apr 2024 20:12:45 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9EB887E82
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 20:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41802f985baso5137465e9.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712945563; x=1713550363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUiPhXuktebOyfc7alB0E1zjrecTZlfSYJGiwPsFgBc=;
 b=WcnVaDOFR5+wge3yEByIMAnSgxdQAsXK92+FTSwoshkqYP7OudW4eqeLeEyF5m1T2R
 Es0ksnm5nCx5awLUn0TWNlkSBYO6+v1/xjyf9HB/f3JSnHJjCWTmGQaHxf29NgChmfcI
 9wpVOVLgRs4YfcpDI5IcVUuLleRr/ePIP7p7eU9qT7UG44Ebm0EcUhnGNpNJUcW80E47
 RgLhwxXkdkeUwYaanPRXPG9J7i5h3MRGxeM3dzpY/UbE4u1wLQlvZCb6gfrKb1m8g3wt
 YviyK1a3+m9FyPbjmEBDN5S09Ch4vfu8U91qaJAWH2MnhwqYVxkMyxAlvJI2AeQikL1p
 +Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712945563; x=1713550363;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUiPhXuktebOyfc7alB0E1zjrecTZlfSYJGiwPsFgBc=;
 b=lAvPXmnMw3rP2oowwFgu+eX7dA5ykmvvU1+ePZpQJMlpfr86krNyk9BFJ37rb8WurT
 bI5LtZgQFRNNuG7w+SLpd4m8NcAHZxQkVBPjV4jHhF2w+jxRXK0fsn0FtNSmYIFOIwcC
 rVlcFubVGDg/8HmMcH4ku9HB4bP0iDqha5bRrPg64cOArFHxRnUoHcA6kflQuN9yt7lc
 1Sb0IDD3ccNqueFCP8OhUSJmhlUEfx/zOp86OFP8uvY82KylkA76dTWNk+uYe4bSZ6Tu
 kT2cbAq0/Rw+bo/4aWvh7KXVd5D+COctMvR0WwNhVDen/mbi8jZsH4XsiRDS7pzum+Z5
 914w==
X-Gm-Message-State: AOJu0YxWMbQ2hOryrDAyYRHv5vFIokEAikwwsw70bCOOwB7Y4Tl9qLfp
 wBaD0Qpf4eNJexgb55+4BAKfgIloZmfzbQ1ekbq0SvJwxlJtxLH61zbTe+xrpa0=
X-Google-Smtp-Source: AGHT+IE61iJL0RUYPnFMPkNyB844V7zu6faj5ZvvPI/pMpmdMjdvfLz9w9fdg93uMoC4Ck1YN3tpEg==
X-Received: by 2002:a1c:7902:0:b0:417:d44f:5c50 with SMTP id
 l2-20020a1c7902000000b00417d44f5c50mr2707209wme.41.1712945563153; 
 Fri, 12 Apr 2024 11:12:43 -0700 (PDT)
Received: from [192.168.114.141] (92.40.205.163.threembb.co.uk.
 [92.40.205.163]) by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b004171f151a5csm6294733wmo.16.2024.04.12.11.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 11:12:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20240412181031.1513372-1-caleb.connolly@linaro.org>
References: <20240412181031.1513372-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] mmc: msm_sdhci: fix vendor_spec_cap0 registers
Message-Id: <171294556150.1516536.5026780778600808079.b4-ty@linaro.org>
Date: Fri, 12 Apr 2024 20:12:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Fri, 12 Apr 2024 20:10:21 +0200, Caleb Connolly wrote:
> The addresses were mistakenly swapped. Put them right.
> 
> 

Applied, thanks!

[1/1] mmc: msm_sdhci: fix vendor_spec_cap0 registers
      commit: f09537bdd940c051b851c235e8906f1ba83233d1

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

