Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6523D1099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105CD84132;
	Fri, 20 Mar 2026 21:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a+GB3dJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB8984129; Fri, 20 Mar 2026 21:53:50 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5CD8394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-679b072ed3aso509464eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040027; x=1774644827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RWstvQJOWRG1EulCKHbKvK2yFlCD74MRGA+CfuXRmxU=;
 b=a+GB3dJKAN1Ei1IGxjRTYrvWfIwkndt59m3giL4TTxbDNvbz+kGEkM6Va3L6LdmfJ4
 bi1f1dOGv1/NMpVED3Fp+eWtXNH84UH8P4R78DX5F+i30W73eaQb46LNRrvGH7W26Sg/
 7HJ3xiiKEC7gvHJqsFRMYqnkTKAckqzQfzj+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040027; x=1774644827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RWstvQJOWRG1EulCKHbKvK2yFlCD74MRGA+CfuXRmxU=;
 b=dU/OHWgS2dx4Hqp7upBM5FX9wKb6B3oIU3kKh6U2d8+tmY+q534HqU2F0LkJqMVlqF
 XimeF6IAyumJgFhNZqQqylZh4LmAuSZzFN4RuJHNwLjhr8mAy/gdJlRP9x07nt87lXuv
 7UNj7i1q+LeuDmfbx6iIWy1B+Pg0E/PHcemB9vLr7W+5SH58GWnchL/c733thZQMFFg5
 0pkqTWSbXeqfEhw5X81NVRwTqcSnjT8AnVAcwQi34n4WIyF4ShddwbyLej3zpAw8pNc/
 ifvZT1F7ngsB9+BvaxI5dDPS4r99ceBKOJXq7+4OnQDiIpxF2X3/hbNrGcFsNsfu/g7y
 pZVA==
X-Gm-Message-State: AOJu0Yz1StqLp21A0dZdAEPG/yepupjuavvEOuf/Vo6m7xAkjdY729xA
 IbD8GPRPZ5aj8wyIHCen+kdm3TUViHnwcVAytK/ASvLq8aDfuHzeXnPstMAuBmNF38YxOSkBLRz
 z/os5aaQ=
X-Gm-Gg: ATEYQzzrD/1ry4AA8VZNIarOfAbTWQ50VdzwCUGpXMezdx4ATQzY2um3JZNX8GuwYUm
 dazWQOkpcFpWY7wNShKpE5IjGnbD3IJ1NpMMZ3sDU64vnc/5JZVG2UZ6umzLHpLFVsSf8QATSDv
 AFQ9mHIAa4LZAPIAjX4pWJDschywrfU6ZmQ4n9wyeJc6fxKQOxHPPhKtKXmmycdOEVzxf+OFemo
 vNmlmz1uF1MNzoGgbrf00uNOOqs3lshtY8Hh2PGai/X3PclBAT6tccKYxw/799m0vXRj8NS7CTu
 VZgm9DVJNGQGnC1QAhwVctDID3Wrh5p5H+rGyNyPnRPhJlqPsC1CrY26HQteD/DOUXFucLHRdQd
 sZGVT1NYBLtD/smWtfi5uGplrR6GNcT58QiorKaEhytI7TRN3cvvFyfKJ11tE9ie17C11/buiQe
 b1KaAwiaULGbfm8qjM2QT+fbCLQTtd9MEkm/4F4DHnVJrhPUv/dr81SKhm+1VtTxyxNA+6K05H2
 KaKP1/i7oS2fgqknX/QIntQz8CGZtJRhcsky6nndD0mHX0VUujsEQyHuXissQ==
X-Received: by 2002:a05:6820:1b0b:b0:677:48f4:3c66 with SMTP id
 006d021491bc7-67c22ff695fmr3063022eaf.67.1774040026725; 
 Fri, 20 Mar 2026 13:53:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c253fceddsm1881456eaf.15.2026.03.20.13.53.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Add missing dependency to CMD_PMC
Date: Fri, 20 Mar 2026 14:53:45 -0600
Message-ID: <20260320205345.3789046-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We cannot build CMD_PMC without ACPI_PMC, so add that as a dependency.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e96b76cc8a86..bf47b440756c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -223,6 +223,7 @@ config CMD_LICENSE
 
 config CMD_PMC
 	bool "pmc"
+	depends on ACPI_PMC
 	help
 	  Provides access to the Intel Power-Management Controller (PMC) so
 	  that its state can be examined. This does not currently support
-- 
2.43.0

