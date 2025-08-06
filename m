Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A47C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 487DF8431C;
	Wed,  6 Aug 2025 17:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lz9JsJFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81508842C7; Wed,  6 Aug 2025 17:24:39 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC02842EE
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459e39ee7ccso273625e9.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754493876; x=1755098676; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fH5ZTUIMfEgUsRbeWTsqPGiTZFZo/TRM1+wl7cZMdi0=;
 b=lz9JsJFlLgUeRyFdG5bbOmSzoNn9WonS53+1xan6u+h+fxYSv5xwj9tjRFgM+Om9jt
 Axn7mXllCffexCzJvjP2l+oWjUhmo/GLG77dV63b8okUEIsg3hsjKkrWEo9k/8soEX+Y
 qWHFAtwtAOxhznr6FzpGK+cVX5Q6QdKyRmUHccv6zXLi7kFcGiX0gOTNoYahkjFcPK/N
 +edny+mcQaBEJZLM6W8divko0SeBoRU7QcAPjWGwpd3Zfqxf247JbYb4X1b0I2VLIail
 dxRb26RhI/D7z01zNRDjvCKbKULR+/aSkTJ9WGr4FTqnmP2aeyJS9rD9I3x0ZfOeufTz
 /nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754493876; x=1755098676;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fH5ZTUIMfEgUsRbeWTsqPGiTZFZo/TRM1+wl7cZMdi0=;
 b=bwhq6/XU/EbiF4XHjj1iSliSSf3Mxm1Qrqcz6JrwQrb/eGAi6qJY0DA4Frv+QpiiGi
 W0AZn0SsPpESLZZQUg//ROi3TCBhsiKis2bti3mQX+oB8atv4m5ZwMRDzl8pKlMnmc5r
 YfCIWJwCNpwiOVCr0JevjSxQqdARLjRNj9zpHmepNG3jhMAWCNdVnxLoBmTUePcvO8Hu
 55F1mmOOZJQvuDsj1NjunplWXXkQiBF8UrbtVXisZafbMXJJmI7xPhh9T+wpGV01Lq5l
 sqpr0ZSVrW+TM5i+X7+d0Dssv1N5HKajlx7V5Bj4D4n5T+z9kcdB8Yxjev3SpwAlwHNB
 XaUQ==
X-Gm-Message-State: AOJu0YzbLHFm0bFRhp36C7w4eZbkKvfuT0ijGzoTefKDM/VjW+mmZdz1
 eCOdmUt3oFEMyfnKnjmyO1t//fiqKyNFJIfA2iq/lcgcE9Ib5WbLFtHZn5zGJB31gc8=
X-Gm-Gg: ASbGnct5oQSMZaLkSKQKerortbmS3UIRqcByDeK5S9nB5Hm5ehC2+6fiHz0Gkt1mBZ+
 0OUu/gfipQKrAnZEylDbogFSGJBjrJ9uloa1fF5gfRp6A6OMMAVTaTZCJxIS2Ek32qYsI+xAxLN
 Su4+PlIHI45eJ9uw4aO4TQEZ6cLY8noZtGBAwLXSHLVE4i4EJwAG73iIeEq1X3J6bunXqQAzt8q
 sy6LJtLG19M6T+Z23vVGZ5QtWO84m9OqhWRhfoXNIS40ZCg1uFrGWHJyr5D4b/imOAA3Qd6Khh4
 IALS8XGKgvrlyQafI/cbwFj1EUX7GevmPZtLbTOoemzjzT7M4lyQykmlRN4wuf4Br4sPvU0I+zE
 8XTQ6Nj7ltBS6zFgCsA3qpVy2sIHUEBM3/Fej60lzvs/fHbvSxno=
X-Google-Smtp-Source: AGHT+IH5e3djWg5HQvARgl2QR5DSOD4MNIFCZsI/ey9DoDRxoKvQizdcEA1XYtlAa/FDUW8xn0EqcQ==
X-Received: by 2002:a05:6000:18a6:b0:3b7:b3f2:f8b3 with SMTP id
 ffacd0b85a97d-3b8f41ac8bcmr2961921f8f.38.1754493875897; 
 Wed, 06 Aug 2025 08:24:35 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:6501:9a0d:7129:a02b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4595cfea56fsm98132075e9.1.2025.08.06.08.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:24:35 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] phy: cadence: Fix two Smatch reported issues
Date: Wed, 06 Aug 2025 16:24:32 +0100
Message-Id: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALBzk2gC/x2NQQrCQAwAv1JyNhBXLcWviIdsmro5uJZEilL6d
 7ceh2GYFULdNODareC6WNirNjgeOpDC9aFoY2NIlC40UI9z+aLwqFUUw9SdUU6Jhp7OOU8ELcw
 citm5StnTJ8dbfRez62Sf/+1237Yf29kW530AAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported issues with an unitialised variable and an error exit
that did not set an error code for return.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      phy: cadence: sierra: Remove variable that is not assigned to
      phy: cadence: torrent: Set an error code for return

 drivers/phy/cadence/phy-cadence-sierra.c  | 4 ++--
 drivers/phy/cadence/phy-cadence-torrent.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250806-phy-cadence-sierra-c3208604bbf0

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

