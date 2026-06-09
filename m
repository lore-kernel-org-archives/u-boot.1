Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F013CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC8DE84974;
	Tue,  9 Jun 2026 15:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aAY2MAWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6950D84894; Tue,  9 Jun 2026 15:23:07 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F28E84979
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so27212525e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781011385; x=1781616185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5rOT04NDDlKqs6lxrJ4KMntz1f6Fzql5JvlSLJ06Ro=;
 b=aAY2MAWOssG7PfzL0YY5xvke5ly1TMSE3qPQgGQXe8fbC3AdJ+SZTJpAXSumRlD2tD
 mnAVbi8nrdcWs0lvNCFBT/dZrwqh9rxl62aGIls5IElOzecRBwt7vwrSPISCK/Xsifg/
 YWvyVFjYXICiZ1TkSqpdWSgNIJduW0uy+UwaeM578GVV6r5X6puKizDlw9ohxA8sQD1k
 8XyAdEFPjb78htDEXZK//Ib1Cn8vhb9tioGHWiyt4GHuZtkayiAcQBtnJdORJbv/33dp
 l0vaaujSLvRsIg2y/yu1v+Gv598IhsYS+aQAFWUEcnxCXDStuJj9uRtKV+Z7FM1bYdHP
 zAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011385; x=1781616185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/5rOT04NDDlKqs6lxrJ4KMntz1f6Fzql5JvlSLJ06Ro=;
 b=AnJzTxI+qnLRjrlyUJoXp9ac9lX6++V+rkVTn3pJogC9coQ/Ic5LYzXN5k2pxeGQfL
 2I2JDM3FIscfdaO2uPzCwfhmKpiJIRk1xi4FffSsTewT8upQdjAJgJ6Gw987j/BVWe1L
 rW117AJmgQ3a7tzL0TnAICwE0yb8F8j2xF+PPIQuSjfyPSBwpdQucOK0Xk95FS4XocVL
 mUFFfEjQeCs16PuUZVwYONSpp9X80sfLUIYm/LBL8Wt7fINxsLeLZrHf8KJ/K80YJKQM
 9l4A+aYx98pqo1d1dHI7zE276GFUyz1VIRpzpTaCQ7uPNeYUX1zR9oNKu6ZWDJcfV5MY
 DSiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ugp4TRXgrMjNkoIZHDwIZKxTkhGrx/LYxMlHsOKbxrNcNc3vh8/5ckIlYxBAdcP/Vzye0lU8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1pQd9cI86qd1H1W1DVjESIwfNKLz/iCQoYOL5GF1QcaJoUh1s
 gEYxlt59tc5wRwDmus3o+CsPSL2RRr/ZPjkT6tWxO3SwmtUWprE7/P9uQGT6pv+IFyI=
X-Gm-Gg: Acq92OHoLRy3Y2gXXojpbF+qwkEzZeOG/HLgHWnpNOR/bE4l2BjaAjUCGc//bVehJwQ
 nhGldGb/k8BtCafWt1B05vQPXJ9X9/Jabtcm9Uic0mZuvrGMb4GOpScGF56YUc5YC4tR4BUVsgz
 wTDUqb1f/JQcs4OzLSw1InaQkdqFhaKiZRvEtsgwLmGxBoZ/IQ8wd8YPoOFTax4KrHWsZ5VeicQ
 FdquRVc+UCEK3dcdEcoXngBCsNdlvKHiGriRMt5VtXdETZFz9gIIq/HMVIzoIB522mc5H7Fu1S0
 AVPn1tHpm1sdDKcFMNlgyNDxvmgExF11O4hrajK4kAlbRFdtFB33NAzraWpKR68T7vuVwoK2NOq
 +xMU0MPm718lw127Gq2OkTXkSp5LYJjFIqaW2P8+jLL0jGc43rUh1Mp9XnQvtGsyoLKkS1kOLvB
 jOkqaEac9NjKXI/j3n+yg+fsDv/GtSjlT8+U3olnd7czFbdHtGbo9UjvLYMoJPQfbvTAMsCGLWu
 MeLhZAKo+93l9L6cMFEk956g5l07S835aL/aUp1LYcYzynNgTRujaJmwVOaFyW5yh3HsLGrR/Mg
 EJu7Cqx4Hpj0Jineb98LBwqQ6hzY+Jv5dL31HNhYPJ1LJvlSuTgrol4rbBA8mmbSWIbrdSGE8FO
 1isiouynwoKPei9hpSsx75CwWeejIjs0d8LvDvkZbAKohhh6y4SvMR84PZ4tZhdXdJCBSSXSL31
 ylzDo2YaFYflmEW3nIWvjlxaICBGzknE9F1g9hhF1OLEcrPuAUhzRwwJFQSj5SYklMmLJdwdZpj
 yh+gP2Uc/iP/OvRSEqHljHYMVEt24kq6osT0JY=
X-Received: by 2002:a05:600c:524f:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-490c2622ad9mr355240405e9.16.1781011384929; 
 Tue, 09 Jun 2026 06:23:04 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm68477564f8f.24.2026.06.09.06.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:23:04 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v6 7/7] doc: Add a warning about using RELOC_ADDR_TOP
Date: Tue,  9 Jun 2026 16:15:49 +0300
Message-ID: <20260609131611.46399-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
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

Since devices that can't DMA above 4GiB will misbehave with this option
enabled add a warning on the documentation.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/memory.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
index 5177229630d1..3da39bb6c664 100644
--- a/doc/develop/memory.rst
+++ b/doc/develop/memory.rst
@@ -111,6 +111,15 @@ U-Boot Proper Flow
       This follows the same as in SPL flow. In board_init_f(), a part of memory
       is reserved at the end of RAM (see reserve_* functions in init_sequence_f)
 
+   #. Relocation address
+
+      By default U-Boot will try to relocate below the 4GiB boundary. If
+      RELOC_ADDR_TOP is enabled U-Boot will look into the dram bank config of
+      gd->dram[] and try to relocate to the highest available bank. Use this
+      with caution as devices that can only DMA below 4GiB will misbehave
+      since their buffers may be allocated above the 32-bit boundary.
+      Boards can override thre relocation address via board_get_usable_ram_top().
+
    #. Code Relocation
 
       relocate_code() is called which relocates U-Boot code from the current
-- 
2.43.0

