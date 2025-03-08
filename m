Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07533C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90576817D3;
	Sat,  8 Mar 2025 21:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464988;
	bh=/B1GK8J3Tjfr32otNl5kEAp1FqBdhZBN/AFbtgq0fLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jUoUhMYNledy8nFg+8rJtD4lKWF1ihzH1tdm9PzDA6ImepqerdBuBEC0VXn/AbSvP
	 8okEccPzwYkEDF3/vR9wz/y6odrvpDwPN2jJthmBprAl8O6NK/WQYJCmfl4GqtfVvl
	 Z3s/s8ykKZ+OKCga+gqH/vXnQEFAxfgap2zFmyGm+2bpMkZT9zBHvBUY4kqgrgSm5N
	 MQBE/YowWJmlUBTYe8uXl/zPDPFwD0Y2IFK0QlqWT4KQgtsMyIrEt+tTCy8PWak/23
	 dvYZa/T0brVF6AbLj2JfacuYT+TqyN1Jp9QWX3bbM3yJuJpuKK6bJcvlJC/22PNYhW
	 OxzIWZN6V5oVg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C4081760; Sat,  8 Mar 2025 21:16:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64CF803CC
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iaAITkgJ"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EE136101E8804; Sat,  8 Mar 2025 21:16:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464985; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=/B1GK8J3Tjfr32otNl5kEAp1FqBdhZBN/AFbtgq0fLg=;
 b=iaAITkgJZRc4jGc1xx/plzFmUeaYrCsttZCBZNp0TG4PdqSIbgcwEKrZsrQ0BCK62ETAX4
 /UOcthqTtso0q1H0nwSJG0DWmQbYMOD4KvqslTN3v5/h0XFCWjZKdjrnvkV96gWJ6BEEo4
 QFNS6rJemFCa8KllKLkcwlkxF2v87W8kzf+dJjJKoo7o2b1Ajqy5wqXdlg0Nkwm7QtZkFP
 QL/VxgmZuTsAhQC5XCAkZ1aIOdMEIiwQiUnblTfuJVk9LJLLLbBAtG4MWtrrZpdjOgopLT
 FpkvhloNoSQCxioPpWr7gLNp3T5wkooCQJztSHq3AMvHqFKEtXbDFzGyhxqo1A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/12] pytest: requirements.txt: Include setuptools
Date: Sat,  8 Mar 2025 21:12:15 +0100
Message-ID: <20250308201533.1315951-12-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

This seems to be needed for filesystem tests at least on
ubuntu 22.04 machines. Add setuptools into requirements.txt .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/py/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index acfe17dce9f..c726135b4df 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -2,3 +2,4 @@ filelock==3.0.12
 pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
+setuptools==75.8.0
-- 
2.47.2

