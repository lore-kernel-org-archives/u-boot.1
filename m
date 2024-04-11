Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4ABCD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 12:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4661882D1;
	Thu, 11 Apr 2024 14:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gsBWv33N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962158828A; Thu, 11 Apr 2024 14:43:12 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B1A88244
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 14:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a5200202c1bso316308766b.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712839390; x=1713444190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IuMi8bw6KQdrLWQuG753Oo7nB7A+KFfgT7rmsQ2fL4g=;
 b=gsBWv33NMv2rB5DNqZvUgPTSnS37SRgF3TsRPEAlxU9eEHDDKDqwb+K12BfNkuy7Dq
 JaB3R+Nofbpy8/idLePwGYYn+uTQ6YS+TraZ0BLWt9DIM/ARF+UXLOgG8a8mYyscs/MV
 MylnzOVv5EROa1nAiLT2aXNI9C02O0bHCYXpSW36rtQdKYJ/lBeYWRjD9JkI2eVSU0Uz
 dRzsVDcCZRwmwusajZHjkKxstZN/jludgPIZwHQG4fZs8Ug83n/zEEcmwQ1GSRso+fjM
 3aexRULBTj0uNFLesgqqvJba3+n+v9NGA4dm8AJ2EXi7DV47OPRHOrdmvd8pfXqsqlgK
 RUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712839390; x=1713444190;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IuMi8bw6KQdrLWQuG753Oo7nB7A+KFfgT7rmsQ2fL4g=;
 b=Jyj46b9bwz7Du6DyqaKrvoeCv3M0l2joEhosrRZG3PKv4QYZPjdMxvbrWl7oU0s3P2
 5t7VaFSf+n0/SIXMcvrvSC1jIZXvgi58WbtpaZ23r8kWf3bKhL9rlGj+gZCQlDbGyEfG
 iXq03hHZwNDHHdC0MthBhQFc4T/2cQO2oSgySZMjiXUfFx0bG/dlcZVAx2Rv7ZaE+KEe
 EQftyuc6BeW8J/KH0/SIRIew2a9OaHMNklocoIoCjR38c5pRhgjevXAB4s30W7TPCRQb
 2H+9SpHlAqd0bWNfMWLdGnr3UzmYtBvymTLsddODy/3KchLHhlUzmyaskIpi5/DTTYsT
 QgMg==
X-Gm-Message-State: AOJu0YzxHiNR5dknDZ+9bRge6htQRuwT/beZPDee+VzgfAHg+OUzWqiI
 F0wXlkP+u6377JJxksXBHjS6jntAOhxo5+NG+8vcnWiOADZjPxTZjabXQv7MqmznHlZfK2vjtn5
 p
X-Google-Smtp-Source: AGHT+IFvghBJaHN2GAX4nGmAS/yjhJ55wwvxv75a5NsAmzpxXmpzmI70jzmYihXQlTapeKTLoY6bDw==
X-Received: by 2002:a17:906:c10d:b0:a52:696:5c6d with SMTP id
 do13-20020a170906c10d00b00a5206965c6dmr5017647ejc.37.1712839389847; 
 Thu, 11 Apr 2024 05:43:09 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a170906844100b00a4e8a47107asm710491ejy.200.2024.04.11.05.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 05:43:09 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
References: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
Subject: Re: [PATCH v2 0/3] qcom: support SPMI buttons on SM8550 and SM8650
Message-Id: <171283938892.622116.10808128600906494293.b4-ty@linaro.org>
Date: Thu, 11 Apr 2024 14:43:08 +0200
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


On Wed, 10 Apr 2024 17:59:42 +0200, Neil Armstrong wrote:
> First add PMIC gpio variant on pm8550-gpio, then rework the
> qcom-pmic button driver to support data structs for each PMIC
> variant and finally add the data for the pmk8350 button configs.
> 
> 

Applied, thanks!

[1/3] gpio: qcom_pmic_gpio: add support for pm8550-gpio
      commit: 21e19a823aba68fe585ab48ff89c1414554ac929
[2/3] button: qcom-pmic: move node name checks to btn_data struct
      commit: 28b264674fdd0b50a396a22115e097dae47945fa
[3/3] button: qcom-pmic: add support for pmk8350 button configs
      commit: 43923bfb5040c245645aa91bc000b92117c587dd

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

