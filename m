Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6AAC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E408141D;
	Tue,  4 Mar 2025 16:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KHeiJV9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B827800C1; Tue,  4 Mar 2025 16:32:09 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0484808A2
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390df942558so4522842f8f.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102304; x=1741707104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO+IZXT9LKk1KWA6F31yvd9awjDoLLpIxOtHfhwxtmw=;
 b=KHeiJV9cVCFui7QH+pEY9+DmL9ot1GpvXh8J44UYv9pcvCtLzi31uXgsb5cIF5cld2
 rczuOTqfknBLF31mYFnI7L0rAc5xdPZ7S3DG/aa8PugAjmdPXhWG4Xm1ZU5XuqDA19j9
 ta0blnKgWCZ1x9nUJTtZoF0JfKcjhVO5Dt8X8LG8dC5c55mnb+wfWwUk6kCtjDIyeCoZ
 6//YYcGU+rvUBax6zNKRljxyHbJWwve358DjnGEW+ag9lAYns8yomozLK7+TurjzOguQ
 wsQ34gtOpSb38czHuCOtClgddnYw2tpPRxh0d3Z/6lFkiMcaqJjLm/uUaDyxKlR0iP+0
 zrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102304; x=1741707104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rO+IZXT9LKk1KWA6F31yvd9awjDoLLpIxOtHfhwxtmw=;
 b=k+xu039PJlU2027VQJZyV9koQHVRDHQfotCmi6W1l7qyNS1B0griIryWrAx4EOkC79
 NsKjUKHLzkuvCFHUMkYFuZZpDuNMYQ+0wGh5d52T2us7p52yOydPK5VtppCaWRs4XHx6
 y6fFQ3M6IUWDOzDucjloR8I4hvXqXr+v0c3aMOh1LmAGY47SxCBlMZn2jVEb8NWtCcWs
 AwKmmNAWNOxHukcMlTjHCt3KIbYFWK2vzXWeUw8IMRnZXgTaMCcGhzhXBU9zJSzqjLjj
 uMW0seWdO5Np56Rs0tdOJKVEwYmsbGZ5++dXeBU5doEdpbs0lmUJiqhplN/W5l+M4dNP
 9Xng==
X-Gm-Message-State: AOJu0YwM0C9B+fK4nywPsus+BS7TOLcgMgAqIxh44iyWGv+vAgvKi/o2
 Mj0T2Kg4O6lH8Ypb/x2UuSKzKRjj85DmE8679EqMo+fhwUFJqShylk8XXEop59neRaxiO5/WtJJ
 x
X-Gm-Gg: ASbGnctUm3bVEomLMSYQjqC0MRevtZzwUXj32JfcD7V6OXnV8B/+nr44+T4uV6bielz
 H3NnKxC4LioO/0a8fcTCIeFjaX92ivpkFZRtKHIo3R3zIOFdlRQ8wbVibd5dclNEQ3Ds2XshTn+
 AZ7Lrai1CUY3ollNV3Pt8m5CGA4eaOicY3vUOaKWaSD3wiQWKsKZpegpVGxgp5BAyWCbWnukHZO
 /2ZC+qnggD6JsF2crmruMTruZ974fEcGdAVPTwR7G52WMsdveHccbzEiUUvsw02uQJlp+QsjM1H
 oCKAQ8dl6K2BrpIQ7+5xfl+PqLhByLJPW1cpI0Vq3C9eEO9R2cT02A==
X-Google-Smtp-Source: AGHT+IETWTxgQ4h8Z+UHJrg3ESg8U7LOlfWvq8Q2jdRLkbyT5Z5b4rrdew84Axu89ersEwsfaPwAvw==
X-Received: by 2002:a5d:5f84:0:b0:390:df83:1f5d with SMTP id
 ffacd0b85a97d-390eca52f6dmr18841852f8f.35.1741102304259; 
 Tue, 04 Mar 2025 07:31:44 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:43 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v3 14/14] MAINTAINERS: add UTHREAD
Date: Tue,  4 Mar 2025 16:25:02 +0100
Message-ID: <20250304152510.2832340-15-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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

Add myself as the maintainer for the UTHREAD framework, the spawn/wait
commands and the associated tests.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c1851280e6e..27887bca55d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1800,6 +1800,15 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-usb.git topic-xhci
 F:	drivers/usb/host/xhci*
 F:	include/usb/xhci.h
 
+UTHREAD
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	lib/uthread.c
+F:	include/uthread.h
+F:	test/lib/uthread.c
+F:	cmd/spawn.c
+F:	test/cmd/spawn.c
+
 UUID testing
 M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
 S:	Maintained
-- 
2.43.0

