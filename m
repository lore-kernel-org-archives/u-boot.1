Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D40D61015
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 13:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE31683F32;
	Thu, 29 Jan 2026 14:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k5gvljDe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB4B83F26; Thu, 29 Jan 2026 13:26:31 +0100 (CET)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7456F83D9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 13:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-12339e2e2c1so571381c88.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769689588; x=1770294388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zW/cptgt+w8hLE/3Ef65Wt5ieXngBRhQvjAvVN/BGEQ=;
 b=k5gvljDePZIZHaNtZedQKj8oF5v/F2t6iepEwnzzftYlM2cT5d4F1wfJU6WR8doW+T
 9MPv/RU7qjYnHC8UH3xRPHKuRMc2M5R8DzG9Od8LiDMKhdwKtrzo9qxmqB+nXf+psA0N
 2ilODxBcxYeIp0x3xk+u05QpoPCsW5AECK7NmYwZUOxs9eIGiT1pvni0Xp34/eHM5i3Q
 2nd+9ia6bPXpBVtYPm/P3PK4dttgKIZ9UOHnuYMPe5g3bmSUVWQAQi0qxzIcfeNl3IpV
 fmkycusnKYdX+QsECkJXi5PjnHZnpR3bNgcQlMxUp7zsbTkUDiZULph/9edMB9sPdtb7
 Lk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769689588; x=1770294388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zW/cptgt+w8hLE/3Ef65Wt5ieXngBRhQvjAvVN/BGEQ=;
 b=j2EYCAO6UBeUceLx9jVJ8834BHtg7j8F6WxumstEQ76IzJ2gYf5FdYdqllI7L9eQ+S
 nd7IsmaM88lRtVg0NeC3JXlVqjG3+fl+v4suiUZADfa3CDry3mVgTc2balY+kWtdAlq1
 eM9FD6ppNQVWPcwif8f2gpXqy8C1jzXUNgCp8zKUyLes9d/6HguOKoi8FCyEMt1eVAbn
 u5xaXV7hwSAzLNckcydpnZLEn+T6Ra1nNk0FTEyesmOjxMffMkqNNC/ewypZTd0UgpQ+
 Gwds6RydT4CA/64QOyLz8JyF78xCIgmEOKoItdwwJB0pbe3z3BH9q3qSKX1rzwHgnZD7
 /sbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXViDccBNQqkEjFnOYbufnYEmwYwEj2gVkpNQPIAiBCtjsONOt63Af61gi/9VAtaDCS32ZPVLI=@lists.denx.de
X-Gm-Message-State: AOJu0YxgH/zxQ/E0ObFqBqzE1nc2G23P/Nxy2kywIBktIUOtP/oQ1gIA
 uyz2YmWliCsyCutyel1BUsMsj1z8jTsy4kjJ1DLhlGoXLXypbqNoTljG
X-Gm-Gg: AZuq6aIQpp7ZEQhgDj3iw+sN8WkqXsFz31QF8NEuDYEgpuzCLxTD2yJQGUPwQT6E9qZ
 T8WO3Mv8CZYImOs1W1gDDSmgKYzDGEMFCcAVvM5fxDcfrrD1PUmCbRAbM0HqTySAZYAuYA0lH5K
 +89ncC+dVKA1EufrZ2RRcYbbwaV+EWxIA6vjyfx7eNZkL+tPQJmBasrSJi28a/V8iYnyIg3dtWy
 4Yl//vm7locrV0Y82Xhf83mbIDrsHTbljEhdKc/2YCEl5nQFGXC5uOBw2iDUjEPwjYxbxyVgGtY
 qEVvkwxSVrHrYhMj3UJZBUfsxAHcL8kY9S54dsGuCJEFWyoH4esjeGIdmekxCOCzRvde1h7VQNh
 zZ2+Xo1skJq85VM0gbkvJzfIYOxuARu1KNDgdblZyBtdvE1mZ9Zbju5XeHSuYO1KkcdN3UTJuOX
 Lw+HY96IwlKWwLg9a6zc4HiCgqzDeOgsnYwA==
X-Received: by 2002:a05:7022:6886:b0:124:9f56:832e with SMTP id
 a92af1059eb24-124b1093e80mr1562628c88.18.1769689587667; 
 Thu, 29 Jan 2026 04:26:27 -0800 (PST)
Received: from sun-virtual-machine.localdomain ([107.172.49.54])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-124a9efb4casm6059955c88.16.2026.01.29.04.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:26:26 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: ssunkkan@gmail.com
Cc: Takahiro.Kuwano@infineon.com, jagan@amarulasolutions.com,
 marek.vasut+renesas@mailbox.org, pratyush@kernel.org, trini@konsulko.com,
 tudor.ambarus@linaro.org, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v3] spi-nor: add support for XM25QH01D
Date: Thu, 29 Jan 2026 20:26:06 +0800
Message-Id: <20260129122606.4183-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251102112018.5334-1-ssunkkan@gmail.com>
References: <20251102112018.5334-1-ssunkkan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Jan 2026 14:29:46 +0100
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

Hi all,

Just a gentle ping on this patch below.
Please let me know if any further changes are needed.

Thanks,
Ssunk

