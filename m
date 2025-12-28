Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367DDE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97C8283A7A;
	Sun, 28 Dec 2025 16:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YKPmgwPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6722083A8C; Sun, 28 Dec 2025 16:18:34 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99A383A8C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64b791b5584so12158591a12.0
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766935111; x=1767539911;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRNpTd+bPwdublqSK5emP4Ry2+UqelFJUd6vEDbsapQ=;
 b=YKPmgwPMiencByzQxaVwnAujO6UzJfc6LG4Y9M5Fsm9ihJ6h9SPbeScmAQl++TwXXK
 HZhbh/pnXGLxgkG2Icj3nL8f60/5qd7CmZ6QEbqi6c8BEwlUHfVKHjipTPpoztRllg37
 PbgAPfP9lTDVGKqsG90CXdSx6RE6D8ggifB9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766935111; x=1767539911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gRNpTd+bPwdublqSK5emP4Ry2+UqelFJUd6vEDbsapQ=;
 b=bEAWz3Z0EvoHOZ/F9l+6ZiUlJgGIJ80a9WSlTB+LKyBbpXmsIDHrMfiGZxqAlrptOH
 LG3uqTt9Nq6JXQfDYKiijJjJ+hYWrbPkDxjBHZ8dPCy4TY8ABFVicAoV7EqquZLJ8HKk
 b0xTU0q3ADRZEy3gxP6v0B99K8TwdRVQVVxjnIhX+BbW6PyqReMwWrPDu+y/XwLtXgUM
 VKI7J9GBpc8GmG5eCpNVNSogOE9dLk6+NNaB/6YXqcgJiaLUZSpnn3p8gX7fQdHJPMLI
 jzTcia0AkgxlWQB+JWmST3/35fvfbEvtPn/CvbUfjxU2F9ZoUSboTyxJBao1aVYVUBgu
 4rUw==
X-Gm-Message-State: AOJu0Yzr9VbXPLBXjWH6zJ4ji20sxDKwD2N+KZAwlqDDXzUVkANYGdyA
 bsf6q+6opb76E/hEW1OR5mxl/0S7K8K7IXeK6GdPrk4iEiqJi6DHDCGajuZFHsGaPB0SDB0QTyz
 NU8BV
X-Gm-Gg: AY/fxX5Xu2q+Bx+A/rqdSFW9pnsDf8ZagkvodFn1FtatVj6KzkTyWPzNnqhrgvHXe1+
 cIPzbJKToZCPrqRGGXkbFzW+MeffS8akVZH7f7tm6HvZXhMSnUtRgprNefOPUGmkGEQiGy5gOH4
 +x/YXKTHh5LTg4SDZq958jeHeLkM5G32QYgnVDl4xmT2o0MxFxQCsYWnT14hQrdb0riuYJwrewa
 McS/43vyCf0jDyGTAhFR0t1JkxeEghC4QkHyUzpY63BexKNPr2E0CR/fS+7AxHilUrP09PnMhAw
 O7C/xf38dmxBI9g3u1/tWLn3ITilVSEmBV1mDbXYsTRCQC7Kq7GHva9CKR6IsXA15ldFUeZt2aC
 0WJ9TAayv6bJspyRfsXWtIFneYluaxfPbOCpZQyi9SRjhkRy84Li6SH5XGWRvgCvchmq7gvVAq6
 7JWre0Nypqwe630B4dNMjhvkzAOyUH9ATRORaUZx/Y3onYYOhFKIKmDRgv2KcZw8bGtAXXo9dAB
 2uvioN93/E1zkiCkYCEir1Er9sbUZZSI2nONNYUntXopKN/5apsEH6GaWVC6po9RpcJuLBWk2sp
 fw0HfGqtUYo=
X-Google-Smtp-Source: AGHT+IEPFU22PYden9bh2dWVXi4aeeQoltdApX5IrtAapqjzGutrai1H9GRl5Rw5gtajYFuiSaEP0A==
X-Received: by 2002:aa7:c3ce:0:b0:649:8652:902 with SMTP id
 4fb4d7f45d1cf-64b8ecb2620mr19718213a12.27.1766935111140; 
 Sun, 28 Dec 2025 07:18:31 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494cd7sm28502224a12.16.2025.12.28.07.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:18:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] tools: build mkfwumdata with tools-only_defconfig
Date: Sun, 28 Dec 2025 16:17:51 +0100
Message-ID: <20251228151824.25667-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
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

Always build mkfwumdata when using tools-only_defconfig.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 configs/tools-only_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index 42ec59575100..bdc646e29b32 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -40,3 +40,4 @@ CONFIG_VIRTIO_PCI=n
 CONFIG_VIRTIO_SANDBOX=n
 CONFIG_GENERATE_ACPI_TABLE=n
 CONFIG_TOOLS_MKEFICAPSULE=y
+CONFIG_TOOLS_MKFWUMDATA=y
-- 
2.43.0

