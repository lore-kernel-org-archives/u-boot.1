Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017DBC02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9245680A45;
	Wed, 22 Jan 2025 17:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fhgu6ziT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B435980A23; Wed, 22 Jan 2025 17:13:01 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C77680ADE
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so1328377466b.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737562378; x=1738167178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fh5svnZyqq/DrY3iZa0C4WPxAjRh8MZ85KtYmwotkHQ=;
 b=Fhgu6ziTgVkKh8ZA/hI18wqDVOCeveqpBv1egiJuuwVTNYwQC4rczkn1dEFfQ1d83M
 3GWnFe71PFGXw6MFFgB9xnLuJK7u1NuOraSubf42XE7sIzLi/tGv3RNlO+7wmA1ZG0ht
 qTt8RoZQJ9oWLRizsV4SsA9uB4zTo95JG66w82iNlZ5WeQzbos0j0uRkDbduWCrMPiKc
 j5xtI7m9fapfdMvlyyRU9rjzE7tV7eWeylOGvlgnwtLmqhmBkOlbaPpZLdneqrA8LCrN
 zwplfqPjeMKQ8HYgfW4/KgU8g0vEFYF8MWo2z6XW1drVzh32GoadcQIkwlabHLnzf6y6
 slZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737562378; x=1738167178;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fh5svnZyqq/DrY3iZa0C4WPxAjRh8MZ85KtYmwotkHQ=;
 b=RiG3pjZ9aOj1E3S8ccK6ASIXcubXazU/R7bjyR0T7mC0J+/Dnv7N377ANOkbt7Bbpv
 Jrv3C/y4mdUJcXkpGUJN6iq7h9mq3XQOENwxUXDOV8G03CZqx//DpqdGFrUdadg0Gipg
 6MeBK6UvEhLEvUGXSiP8fSEcjTYAizMB9ZkbXNm78g+KQotVC2HGYB+p7FkD6o7lNSrY
 0+UF9RDvxR41z7rgUzhZdjd54rMnkDX4PhF7Wfz4NVo3Cf7XTUEfJa54zgeyMHgk4srR
 Aiox3KtBi43h/yLw6/GDkUoSSxivfUgQlrn24gVhfe0hIBbgXaj5aFYdyp82PXXuDOzp
 Ijvg==
X-Gm-Message-State: AOJu0YwQHgc8JWYyMxNq4nuo5i7u2nfuiWGXIcbzXaabMoardWWMUMtK
 C1GEQ7/wyTZwb7OVo8MQJnx5RRbhLft+jZZC60ZR/1eZ9DzVcFOBqPoxdhVHBTFPwEwvWIxIvHr
 j0W0=
X-Gm-Gg: ASbGncsKeXWvmtsJaZnFp6ZNoIH6eN0Z680uEUEf2ee9Rts5d+nrjBP34Wa/h58IrDW
 /Ak6jDeOrviHnG5CMvES7SS73HZhilQko1ZCqoQzIrkHp6yKwec0UiezXNKk4Kd9ZkPmuZDGMTf
 hOywnNdtyMdBUoYiYfccrpctTJxQW98Cb2x7c9HUR0M9xDkqmpUY7pRy4TOZk+L+JAQKyA6fFre
 2cDFwFcxUFss749nvC30BWU7skTTy4OVxAr+V6kT1yrJJDc2ehAJ+FjYlhMKsFCLPhkqsggiefE
 OX3Hc7J4/Hne
X-Google-Smtp-Source: AGHT+IFpgRjkaLU0x18PMKnkcG7ox/6IlFFqSOA+8XQhCxniPvVG9Aqs/r7jpbMkP7qb5aB1cRBZiw==
X-Received: by 2002:a17:907:6ea6:b0:aaf:117d:4525 with SMTP id
 a640c23a62f3a-ab38b10cf13mr1930142566b.16.1737562377747; 
 Wed, 22 Jan 2025 08:12:57 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce105dsm924966866b.39.2025.01.22.08.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:12:57 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
In-Reply-To: <20241125-topic-pcie-controller-v1-0-45c20070dd53@linaro.org>
References: <20241125-topic-pcie-controller-v1-0-45c20070dd53@linaro.org>
Subject: Re: [PATCH 0/2] pci: Add support for Qualcomm PCIe controller
Message-Id: <173756237665.1864727.561532603684897850.b4-ty@linaro.org>
Date: Wed, 22 Jan 2025 17:12:56 +0100
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


On Mon, 25 Nov 2024 10:46:15 +0100, Neil Armstrong wrote:
> Add support for the DWC PCIe controllers found
> on the Qualcomm SoCs, it requires introducing
> pcie_dw_find_capability() to properly configure
> the Host controller capabilities.
> 
> 

Applied, thanks!

[1/2] pci: pcie_dw_common: introduce pcie_dw_find_capability()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/aeeebdadc56e
[2/2] pci: Add support for Qualcomm PCIe controller
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/5b7ec7fb4437

Best regards,
-- 
// Caleb (they/them)


