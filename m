Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CEDC282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 20:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DACB81668;
	Sat,  8 Mar 2025 21:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741464984;
	bh=YiUigirF3DPMBKfT61qJsRZFgIFjw68Q8qD8UkOpE4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IjwKy+knlkCw8UBKnKY8kN/hHzTl+ZusgQL3e8V9iw7xyRGtdbvbgufjbx88HnfTx
	 Zb7usTP9rFX+qMtRAsjmSxpDGZP5jemjRZE723tXVzW1sTZQjOkmgStFO0Ij5hKLWo
	 FFXJp9rid5QYYub8ovm6jeZ8K09/4f8IuX/Q1muZASI/YXlYWfJQeKC4uAgDPfZdMt
	 oDkYGqqs5vpvWSdwNnJjLn4QjkJwEosAJRyLA0bGloBVc/ZpWVMlBAsyESP8NB1ZXH
	 VCieJpob/rxVNHJZERezOPb2b2GsTPECNq1gNh0ujgfLHJNyid3gkoB6d24zfZ/WNi
	 cEmJbBFmeIojg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 928D181417; Sat,  8 Mar 2025 21:16:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9067B81545
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 21:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="T5maaU48"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C4670103D0937; Sat,  8 Mar 2025 21:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741464980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YiUigirF3DPMBKfT61qJsRZFgIFjw68Q8qD8UkOpE4g=;
 b=T5maaU48uKXltr8GJf9heLSFldSruM/AFOeaC3/TXB8YpP3xb94Fbormr5qyytNblLjKOt
 f+Zbo3z4qdzvOYFQ43hrloMec5qoYLRt4yZ0eK3PpAs7rR2cKO19D5CLG/DPD9vNQKbtYi
 ybPupKulja9af5rGRzP4wooD8TFxEsrBL/Eok4sJhHEi8YJBe7D4y8kdS8oexCFhs/BHfa
 tLEQt8+XFBeAlXJ77OIz9C5U2E0QlUsYJ19xIMK9JSq1u6RQsk57b99r1oDaqWSli+LLhG
 XYViXwy30eV4ymSbsQyyrDboqeQTld32rCeo0iLqZt6/HyEuAbYZMW2LUqL/0A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/12] fs: exfat: Fix conversion overflow errors
Date: Sat,  8 Mar 2025 21:12:12 +0100
Message-ID: <20250308201533.1315951-9-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250308201533.1315951-1-marex@denx.de>
References: <20250308201533.1315951-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix the following conversion overflow errors. The input field is already
limited to 3/2/1 bits using the bitwise and, move the parenthesis around
to avoid the bogus warning:

"
fs/exfat/utf.c: In function ‘utf8_to_wchar’:
fs/exfat/utf.c:165:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 18 & 1835008’ to ‘0’ [-Woverflow]
  165 |                 *wc = ((wchar_t) input[0] & 0x07) << 18;
      |                       ^
fs/exfat/utf.c:170:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 24 & 50331648’ to ‘0’ [-Woverflow]
  170 |                 *wc = ((wchar_t) input[0] & 0x03) << 24;
      |                       ^
fs/exfat/utf.c:175:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 30 & 1073741824’ to ‘0’ [-Woverflow]
  175 |                 *wc = ((wchar_t) input[0] & 0x01) << 30;
      |                       ^
"

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
 fs/exfat/utf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/utf.c b/fs/exfat/utf.c
index b1d09e76478..5be8dcc2170 100644
--- a/fs/exfat/utf.c
+++ b/fs/exfat/utf.c
@@ -162,17 +162,17 @@ static const char* utf8_to_wchar(const char* input, wchar_t* wc,
 	}
 	else if ((input[0] & 0xf8) == 0xf0)
 	{
-		*wc = ((wchar_t) input[0] & 0x07) << 18;
+		*wc = (wchar_t)((input[0] & 0x07) << 18);
 		size = 4;
 	}
 	else if ((input[0] & 0xfc) == 0xf8)
 	{
-		*wc = ((wchar_t) input[0] & 0x03) << 24;
+		*wc = (wchar_t)((input[0] & 0x03) << 24);
 		size = 5;
 	}
 	else if ((input[0] & 0xfe) == 0xfc)
 	{
-		*wc = ((wchar_t) input[0] & 0x01) << 30;
+		*wc = (wchar_t)((input[0] & 0x01) << 30);
 		size = 6;
 	}
 	else
-- 
2.47.2

