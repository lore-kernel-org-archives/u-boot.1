Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D34C531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD8988BC3;
	Fri, 16 Aug 2024 17:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MeyjqSR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F46188BFE; Fri, 16 Aug 2024 17:48:33 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6E488BA4
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a20b8fa6dcso140564385a.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823307; x=1724428107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sl17ktVAsUr1sjkZ2RK2CE7HkfbYfreg3uXPGv2DaWc=;
 b=MeyjqSR/77HbqhbEXNvg0zltjOb9jx7HofPNF2XD8ShGtZ8uCVDT5k9R8y9KzUSk+e
 I4G/f2wyX/VVt/an8lrVGomM3+/lmiAQerpNvJ0eN2+RTGDvYv/pDWZ6xFDCAO5/phwi
 aAVtoTEFjHoJaY8Z7gyXCgNjtnDY3T2h9EdI2iHf4f0QF0rQ8JoKX5M76PIqrQeS25+a
 5IDf6EnOWogQMYisHN1sHSSHJK8vENd3iUJ54wdWejOk1qgVJYHZV3wvt/zWLK2421mX
 qaIpRoPOZ3v6OW7l0KFjaOq4fpNmx+ZJHNH5CtrfdJM83Kvq9wHWDqdV3h06szP4BhG/
 5/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823307; x=1724428107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sl17ktVAsUr1sjkZ2RK2CE7HkfbYfreg3uXPGv2DaWc=;
 b=mv6ZVyOrJOH38bTKL8Wi2J0Txg4EY9WxoLFmGWPEmHa2qwllakxgOWuRPAAYK8zD/f
 bhuO/gNepOGNWaXvOMuyRWMzQQU00n6CIOFQJMcxUwxrShJzsvwALzMhPigxMGS7skuV
 LrbZC2R1QW8SmXCLhrIHUme8kWv9gEsgaC6qJ37WWHAhH8i0Z50t7stwW1ufyJ1Cosf4
 G0oNtSMS1mBnUVuzMeEIGiEDdCElDpXsTPO1orP554SCAyjCyuwjLzyy2EzDuRhAbSwp
 HtTbtNb/InnuOBH5V8brpKrS7XTDlgA40WuyTsvqs5O/38bPAIB8PD8kV7Ug/FFQIPZD
 ieGg==
X-Gm-Message-State: AOJu0YxtUxKkVM0Z9xFX9rR4+3sc+LyGlb104m+eSqDMsefMU2Reu0Ok
 SyMd6pJOqofxZgtcyg6IJVYzyltZqJ54wUFaieStazxa3yKdjjqQC3aFCN0pEuZPRYD5YLse4MD
 m3lw=
X-Google-Smtp-Source: AGHT+IGJu1GdBri5PS+dUHKsa1Ew+rIoljEvhjtojgEDu6UB4Z+i7XD8ARxn1Sk4u/yxQhtimhRrQw==
X-Received: by 2002:a05:620a:28cc:b0:7a1:e001:bb1b with SMTP id
 af79cd13be357-7a5069e0638mr430965385a.60.1723823306886; 
 Fri, 16 Aug 2024 08:48:26 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:48:26 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Stefan Roese <sr@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 10/10] tests: update smbios pytest
Date: Fri, 16 Aug 2024 08:46:53 -0700
Message-Id: <20240816154658.1866186-11-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

Update the expected test result to align with the smbios library changes.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 test/py/tests/test_smbios.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_smbios.py b/test/py/tests/test_smbios.py
index 82b0b689830..ffa4ea795ec 100644
--- a/test/py/tests/test_smbios.py
+++ b/test/py/tests/test_smbios.py
@@ -32,7 +32,7 @@ def test_cmd_smbios_sandbox(u_boot_console):
     """Run the smbios command on the sandbox"""
     output = u_boot_console.run_command('smbios')
     assert 'DMI type 0,' in output
-    assert 'String 1: U-Boot' in output
+    assert 'Vendor: U-Boot' in output
     assert 'DMI type 1,' in output
     assert 'Manufacturer: sandbox' in output
     assert 'DMI type 2,' in output
-- 
2.25.1

