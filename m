Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02290D6A221
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 18:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29D4888F2A;
	Thu, 14 Nov 2024 19:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VB3J2sK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AC888D90; Thu, 14 Nov 2024 19:13:48 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B808965D
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 19:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso172856566b.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731608021; x=1732212821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bh0u6dahQdktwc2eC/kSm5zZbVGePWoMbY4Gqz4Dsxg=;
 b=VB3J2sK3R6rcwRpP94Y+98E/NWZYddzRV0lMrI3dpp+uybfTNUHJ4j77UsegHuz407
 AtoQtHYT232hmveE4BecQDFlajXrgLFVgQVVnJuNwroIiDPfQkj32VcA7vZ3dHzbSBnI
 I7A/cDGFr40KLdIZWzjPEXSK67CU/er4jysss6EfO4hASocDBt1sf4H0YufgB3jOoHde
 PyxU19yXcQOmwe9x8gOSIs3PWsHPUzjX5TEILQnUz9Emhs/6Ibwy/aWgdUbGZUZgmsUr
 TKrsLh9WycwMsOz0Pqy+TyVtW4rTvqnA6+Oe11+0+GI2zE+QMGAuMbkUug80jdW5xNqB
 BeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731608021; x=1732212821;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bh0u6dahQdktwc2eC/kSm5zZbVGePWoMbY4Gqz4Dsxg=;
 b=jVuM2GjOw9ZDlyNZdt3VOrQjEgU9wDSTDU9amYeFIHmMUoH+lWHvwONgxBpbiWmbUb
 4QBWSCIGML9dhDYsk0Kq7Jidbh98g1LbtjEeiae61dy+aQPt33w9O10DE+F56GZQW4I2
 tW7iWpWLUYac7m93nAoWH+ZqjQXcHoBJutyQ9HpUWTzgGTY9K6xS0F1w/DiBKQWrwVG/
 zxOZ+lmoUhr6IFXNKwRjKGZ6ilC0BTOnUlaifQTjfFqR/i2BL44IsmHd69t2pIfC3w8Q
 n387D+lc5xp/wgl6Ex+h1yqk9XK6iBvQ9hqadNobD2+VN2/7+AY52gf9nMPYWsmRe8Qj
 UYQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU57Ffi9OcCN7XstugbcsZygP5AundgXhVMztPPDNJm4/9H3EITKWoxkxis7zKPy9QvIJ2960g=@lists.denx.de
X-Gm-Message-State: AOJu0YwFQV6KRcIAFygQ7rCVDlXPnEQ2Ak4oPFrkO+V7KGSpbPJmageQ
 JsA/v2U0amhC7w7wn+o8hmPwRKWhWv0R+ncutjTMT3meH3MZS9CDQXEewDePPIsCYUJWi2c7Jct
 P
X-Google-Smtp-Source: AGHT+IEAQlcwBf8TlsYR/Gz6llVsyUWPhRnvne7Y/ymhnELe/gmLR4gSyPQ2RqVXsEbcCfvwuUEpmw==
X-Received: by 2002:a17:907:980b:b0:a99:92d3:7171 with SMTP id
 a640c23a62f3a-a9ef0052bf9mr2316503166b.61.1731608020684; 
 Thu, 14 Nov 2024 10:13:40 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0860d5sm89590366b.186.2024.11.14.10.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 10:13:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20241113050214.1845595-1-caleb.connolly@linaro.org>
References: <20241113050214.1845595-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] iommu: qcom-smmu: allow SID 0
Message-Id: <173160801901.3344230.9783853843420815669.b4-ty@linaro.org>
Date: Thu, 14 Nov 2024 19:13:39 +0100
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


On Wed, 13 Nov 2024 06:00:56 +0100, Caleb Connolly wrote:
> It turns out this is a very real stream ID. Who woulda thought?
> 
> Drop the 0 check on the SID, there's no reason for it to be there in the first
> place.
> 
> 

Applied, thanks!

[1/1] iommu: qcom-smmu: allow SID 0
      commit: 2417f56520bf88f97ce791adcf713727d381dae1

Best regards,
-- 
// Caleb (they/them)


