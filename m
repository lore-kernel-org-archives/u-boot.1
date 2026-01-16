Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DD9C982E1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419A383A1E;
	Fri, 16 Jan 2026 19:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PbxVeHQ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 774B3839DF; Fri, 16 Jan 2026 19:03:17 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C608397D
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-65089cebdb4so3687661a12.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586594; x=1769191394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ayEjRNPC1FcMQbai6nTvFTXYkFPRpkuhSpNeTs+MVgM=;
 b=PbxVeHQ6n98btCGu4TmHsBJXBZYKzX0qocBtHaTYPEfI7yYNjid+1E7zpuB2BYkuMv
 sMiiwNGeN+keJFdwBzPNvS1EvD1vb25wOg2Hb9YxD9K+kn6a/hhyivaYX1cI4GY3pTPb
 KLXhiAHC88OQf1NOy18/r+a6/MajoWhXyNrEZSbm+zMrrxkRXZi6UilgttnBQYPNzl9t
 7rIujaZSkftcKhBFrXUu5W+X3WpdhU+Pjf2gic/2v3Pdohq/B94cRsm9HFjoFWBrhnjZ
 35uhEcbWQxbkTXZYsbSuMdTQ5jxNRQrJ99gkqUaSLgRAlnLB29AuZJDboY1FpEZXHm//
 uypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586594; x=1769191394;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ayEjRNPC1FcMQbai6nTvFTXYkFPRpkuhSpNeTs+MVgM=;
 b=c+/ryJwd0mqX7eIHxn7KNhQA4BAjR8DlJMIhHVkDa/DKqUDsXThixrK2+MOBiaYv92
 KKtwJI/Gi1KV7U3MKrgVRX1+9JISW3TNhpcR81PJBAzhbwD32qO4x8rxtl29R0YFDA5R
 l/B71To93g5fGaKlpaxpTd0V7pG4NuyH+vSAPXLjAvebpFrtWibB+Pwt53fIy/w3szTE
 vxTWgKJGSRQheFAuCvXbSlo4xgCPE/HUKRKgnjgCu+vFa9rJP9igQMeVNmr8gSnORrlW
 b3ga0HYRct737GJv0bXYwu5Jb6Aymqgp/oRREJvCMcsBXWGLYVfgaQ/pOH0yL95/kU6X
 QA7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVUQ90BN1kLeHNbpzoqj2BL6AYzkOHmvahmEQZihOOvYKl6U+UOTcMa3a4+b/mnTN4eFWzir4=@lists.denx.de
X-Gm-Message-State: AOJu0YyC1jkdMC/BiXwCGevuIt44R8/jxBFhCLotWr6Ti+DbfQVITSd3
 y5DoCIcESdrYyx7B9EnD+nx3twhUFOyMD3z4R56O77gqhLRa8uVpQT8eOhmVXE4O4aU=
X-Gm-Gg: AY/fxX4LIIq58hOEOW70a3JwHhHFnw5Qgbk7BFe6nS7Zn2ttbGoce5oqkckuqPlLdCB
 /cc3E0rNy83/ALRc6vqv6MXitFhGwLiGzCplQHr/VSV2/d0jWmRV1c9Mo04hvAnMQINQ0Xw9FlK
 pZE59U6CSV+Jqshz8n/aOgVxMBd5pqw5+sWsAHmawtY5xWJZsgvLN5v95jYMnSAvyYN6fCl1ZYN
 M5Xun6E9u+G3gzZZFr2/56QwWNZDDAIIxUphb3GBCKXZx4XNcO0ytChgWSwtbpy/nTGWvYAmuiq
 xOatsMviSPM75tR/ItY61wW9UxjcdjI8+N5phs0o5lj1xTdnDgAhLoDFbaWZT7dlfBhIJT9aMgO
 cIW9aV90I5TW2Wc3oulgvRZLcW+QvEXiFsE5bylFF9AFcO7Isd0hrtCOzff4r632o/eEY5PfgtI
 cQxUM0dXTGHpnLPKO1ikBqf+yCYQZ9tr7Tz4ddVNH0xpBP6lTH7AdI5w==
X-Received: by 2002:a17:907:dac:b0:b87:908:9ac6 with SMTP id
 a640c23a62f3a-b87968f20e3mr318018466b.16.1768586593619; 
 Fri, 16 Jan 2026 10:03:13 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:12 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, sajattack@postmarketos.org, 
 quic_varada@quicinc.com, me@samcday.com, marek.vasut+renesas@mailbox.org, 
 michal.simek@amd.com, david.wronek@mainlining.org, adrian@mainlining.org, 
 luca.weiss@fairphone.com, alexeymin@minlexx.ru, danila@jiaxyga.com, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20251112164758.1560041-2-aswin.murugan@oss.qualcomm.com>
References: <20251112164758.1560041-2-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v1] pinctrl: qcom: add driver for QCS615 SoC
Message-Id: <176858659200.3399278.2661279047603607611.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 12 Nov 2025 22:17:57 +0530, Aswin Murugan wrote:
> Add pinctrl driver for QCS615. Driver code is based on the
> similar U-Boot and Linux drivers.
> 
> 

Applied, thanks!

[1/1] pinctrl: qcom: add driver for QCS615 SoC
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/46a66c02e9d5

Best regards,
-- 
// Casey (she/they)


