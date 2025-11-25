Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4092D0E6D1
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF3684011;
	Tue, 25 Nov 2025 13:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBD6Ma//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840638401F; Tue, 25 Nov 2025 13:39:07 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F7583FFE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 13:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7a9cdf62d31so6653928b3a.3
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 04:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764074342; x=1764679142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fVIKlVJR7qDUXQF+UaYs5xA2S2SqFJ/KM8ccoQc4DbI=;
 b=ZBD6Ma//hm/FOFFRpecCnaj8e1nYSgTHJCvDlymvRrlc8KYdSQBQhwEvwzckWnTlLM
 bpRygagKSEZCDKi1PYUFBrhIxPh5eoT+mTIE1SGRIlkxjfm8yGtMT6R+R2Su/PPZiLUw
 M440K+6ZmRgIXar+1B701wvP57yvRyu4VrQxybbw4WwUBT0sRiPVkVdPVuZCht75JTqb
 OaLnlQikYTr7088AOMr+a5ZhgxpoFqqMpejwbC6uvzsUTRKI2VAJ8cJBkbsWD54SBQ0K
 oDqOqE9tiR/KOj9IInesnK2ay26iO2Z4rG5aaWTn8GRj5PozTb4waHaxpB0/bXbVwRuw
 uVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764074342; x=1764679142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fVIKlVJR7qDUXQF+UaYs5xA2S2SqFJ/KM8ccoQc4DbI=;
 b=QYdSUUoNHo8MmoA/2/Qxd0BNNsTynghn9RJCtPNFMkr5QKK31b4gALDRf/HJ4EdW5s
 T/dDB2N9Ighv93cqm5uCVGMGCX9+k3WHFjZu2gJE139gIjxXgn8Ea8LAgN8daL8TrZkb
 s9/WAiA5nOEdN/AIeNybbCstSVFvf/xvbIibYh+HV6bWecBNfAHOAmG0POJJQTTZdQRB
 /BpYOoZZWnrt2H0NfOKACdX5mowV75fDk94NivTkdIkm4NoeVz46BaGku63DE4uoXbTh
 wyeybN7wpwH9aKWABhYcjmeQh/k3clXY3bAacvwVgwI6A0hPvU6MgVeb0KffIFzOvLp5
 NAdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2gWHVlzqCCGWEwsTFG8dMmAEguSP+cD7+S6U0KY68eK3/xGAqvHAaNirqFpNjKDGVIg6Uthc=@lists.denx.de
X-Gm-Message-State: AOJu0YwalyWavSMamFZ/u0wARzdCawTZrqegQpScte349xmwYTlQa7SA
 6pXgUrs8FNi7QvbYXjIKccOhlettmOxqZv52Ind+bvQs1WFi981BwUYvSNaXUvuINsOFXA==
X-Gm-Gg: ASbGnctgxAFRYwtajPKOlBg8hux08mZQZ6G6lozQpW0OIVdghbdQWYt0PP8PaNNWtTn
 imxVcYheHJNXsgAnLBXP+EOjwuZN2VxLy4UYP/vp2i842jBSeVmv+tdEVHGxb/SkHa3waNhTydA
 TqX1IyF/O4/JaoEkAHf5qBK8zT5CZdQzRhrZrFJq0YURutpfBxxWJdaBSqyuejHd2UTOisUQIq/
 4+B9UTrofw6FOoPJ33VAEc4eaTAB0aKT7OQKuRUTJ4IgW5BCn8PfgWFrNamN2atnhOLuWVlF67W
 jaO4eyqTJmRvAHJP+//6alJL4ZoYqwxQLtiRp+40BZNlm1f89NbnwVy6Ba8/QEBaCIIpuj5C+pt
 u4v2YJ7hBLOp6rCfrYT6VpBaAnsicq+wEII6Jq41kfl1dYGZaGkzJxefC0qTsGTjlbZSbv4OmCH
 vCER7Wv0KQ5Ocj8LPOMzKFZaT11Wv9QKiOCwM=
X-Google-Smtp-Source: AGHT+IEKxSHYcwmxyX68xF4rR54pxe45/f2GuZgBSov6E9eSzS9Qpel+sAsllM9+DqJcEdu/JLNayQ==
X-Received: by 2002:a05:6a20:a11f:b0:358:dc7d:a2cc with SMTP id
 adf61e73a8af0-3614eb83f30mr18468652637.17.1764074342568; 
 Tue, 25 Nov 2025 04:39:02 -0800 (PST)
Received: from localhost.localdomain ([185.213.82.8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd75def6321sm16268511a12.6.2025.11.25.04.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 04:39:02 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3] SDRAM Calibration Failed fix for GEN5 SoCFPGA
Date: Tue, 25 Nov 2025 20:38:47 +0800
Message-ID: <20251125123847.307-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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

New SPL introduce cyclic and without initial
the interrupt of SDRAM calibration could fail.
Initialize the default CYCLIC setup fix it.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/mach-socfpga/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..a06b677787d 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -117,6 +117,9 @@ config TARGET_SOCFPGA_CYCLONE5
 
 config TARGET_SOCFPGA_GEN5
 	bool
+	select CMD_CYCLIC
+	select CYCLIC
+	select SPL_CYCLIC
 	select SPL_ALTERA_SDRAM
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
-- 
2.34.1

