Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25383C79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926B883E43;
	Mon,  5 Jan 2026 19:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J0axe2bG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3086D83D71; Mon,  5 Jan 2026 17:50:05 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AECA83935
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3f4f9ea26aaso94927fac.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631792; x=1768236592;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PhS1LvMOp4GucQwiJ+mTobcf9h77o7qaMtD9MYeVtlc=;
 b=J0axe2bGHzE0u5lBsj+zdrkdYZ1koFAOKHibA9Z5VGPkTkWWcZMisQzqSpOEtU6EEQ
 AC6v6h7/FJBRF1FJCRkhDh2zjtiSQpHLN7KeoiCUhU+JhVC+rOhqHYQ+VTrAe895Jzap
 a5w8F/Pg1yPwK37EztUf9DwpC1RNplX2+CFWjzU4ojS1bEhu3Okng2wKgBTAfHIowkhF
 Xz1GHO/F8NngrxAzPZgewWYVsUHZ0bt3zBH3ru7SUF3SUSNjj61nOiSlx1uua70fY95u
 Ou61/jwKJDZr3zIYhKYJjzKvR3eVN6SSuMPsuYIaKzHN9QiUHcDXZLSSQDVkGz6Am/b/
 M7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631792; x=1768236592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PhS1LvMOp4GucQwiJ+mTobcf9h77o7qaMtD9MYeVtlc=;
 b=h5EmZVtPH/gyYPDpmEPh3jPkbI0cLDZJnpet5NSth90hf+2uoXwmUCaqMe4jeutkxI
 4ZeL7O5G+fXvGcYuis2pdDlZghQhP0Je/UmMTWGA0Vi9jzl221b43yUDxUHx0iXUdx0P
 VLyWTq4315Nq++L4wv6vKfz7+O/PuBEk0uqVEc/iXp1KblBxy7wZVH5VVH3d0pl1A3LO
 dIf76a95Plzilk9oub3Z4Zlt6NFRLHwzWIO7YvnxX4KDGZAY5D7EQY6DPRUeuGg4GgJu
 /luxoT/fPHHGcMg1AZXtfaBewCx1abDT5rrRvN3QjCJpbhs3wDnpMhJnSbYHYWEOjM79
 mlyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWljg7jRmi6UO8T6MY6V/02H1n+hGegZ9EgsNUkOOIoOzI+pvqCmQoWuMnIxLh+9qgqNaLhLww=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9N//Lw/0dGqucAP0aT4eNcHbzDZx/WuE9fyOQga4zm15sTJjM
 khowRoOghnkYU7ntfWCs6xcizoVjILTSgtMCIrSxM6EggvOj+kR5pwEkUPiV58/G5Js=
X-Gm-Gg: AY/fxX4dN4+H5kvRsJF1az5x6P0y4eFrONv+mEE3osZNxq6jQorJB1bmnDmItZ5Y6c3
 SFpOOtmAXnAUL9Xo+vgQbPCHvvXvO9DUThZ78mXOw6qTKlZn7YvG4pEURMFNxby6mT214yb0T2d
 JAMyv+4jGAtJ8F+F6k9OqvMVDeInl6Sjreq4EoaQqUIEipM5v+J5Z9NzMm6crPF6xrMLKcYnyyS
 LBEOEm7hcrR+sdG+ICgE9icCsli1nUbbaK86ITrNHwzTXr6fqi5l2lUBzsHrHxqNiSYD6snr/i6
 3paCr06jrz7gE+FShniI8WPSq2bw4T6/JasaqL0/vCBpjNENBqDnlDG3GojEKwUNRWsMQAM1bzo
 j0Rv9c+9MSB5eZaDdVXdCduQV6WZfJ2ouclhnOdZQB1GBueoCjwXHQ8f2JPwhzfJfL2LNPSanEm
 eZDxJEBqAMiTfRvg==
X-Google-Smtp-Source: AGHT+IFXtyJaIY80QC9zO+pxVibZywvmOK+Plgd/UuOm3ZzEe6+3r/4hIbzb1kbzH9TrUBNbIrfuMA==
X-Received: by 2002:a05:6871:3305:b0:3f5:4172:f with SMTP id
 586e51a60fabf-3ffa0dccd4fmr4607fac.56.1767631791653; 
 Mon, 05 Jan 2026 08:49:51 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:df5e:737c:7b32:e5d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa0078968sm67524fac.2.2026.01.05.08.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:49:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Jan 2026 10:49:15 -0600
Subject: [PATCH v3 3/3] pylibfdt: add requirements.txt for setuptools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-a-few-test-py-improvements-v3-3-fea38243ca5b@baylibre.com>
References: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
In-Reply-To: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <simon.glass@canonical.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zAXrNKJuvB+TDc2qdlssWzrdN6lJSIsDv6QlfuDV83w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpW+ul4q39DdSz2r/zrrYYY3nsUmEM3JjJiYdha
 5M0TD7HtCmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaVvrpRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Agm0H/2Ck8iDipnJZt0XhTY7jKZ3YshjKr78Tr0rWibY
 mwxBfVONNf0bo+shE48fh+8r4OIxBVKic4Z6aOrNm/D7U9S51DSO65f70BW6KghNb4TzAqUj18h
 fcIGC8mJQxpG8OSMzeb35QvFeYKbmY/95HdcOHSXeLaBvOw+2ikzY3srCYaMnrRuJaFrNk9FSjy
 Pr5kIVkSX28L0bxz/X1jG2yhKBz556+m6OVNA3wrT8nIjLtJMeR3V37K/fxBEuysImrMY65By5Y
 UJ9A4O1LfHsoXYA0WVcO3pz5VhoO4tT4WVEgLSmEGrCVEgANhUVHSGrPoinSazf//YYoG2T/KfF
 I3l8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:09 +0100
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

Add a requirements.txt file to the pylibfdt script directory to specify
setuptools as a dependency. This follows the pattern of each tool in
U-Boot having its own requirements.txt file. The version is set to
78.1.1 to avoid conflict with the same in tools/patman/requirements.txt.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # sandbox
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
- new patch
---
 scripts/dtc/pylibfdt/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/dtc/pylibfdt/requirements.txt b/scripts/dtc/pylibfdt/requirements.txt
new file mode 100644
index 00000000000..b7dbecdd587
--- /dev/null
+++ b/scripts/dtc/pylibfdt/requirements.txt
@@ -0,0 +1 @@
+setuptools==78.1.1

-- 
2.43.0

