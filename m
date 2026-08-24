Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A48C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C554780CC5;
	Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id biwhrYHWiaRI; Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577231;
	bh=NvS7MEJi+5anm/vGQIj9R0Hn70FCBFrUfyAy7wQU3yU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKfHejbne6Cpj4WNGKRC/fiwZivfkNr8XdOhI9LgonVdJzpdkALrILyH1/7Cr9CvK
	 eNS6jYSowhO5YfEpm30QCKq3EaPHpTQbk2sfDY4drD8CdwZikVaQosQP90cZouPOj/
	 9f7fAVrX61XBNeEDgeq6QNNzXmnvjtj3NPW2i2RPprv7w+Ky9bO20sShGcrsZUS9by
	 sBXagc7bs+zL+uNttfxGfpAon/t4rUOe5dZgbZR+TelgUyqi7iIe6EEsbc0JsupN8L
	 guG6qutfFaf265p25WN2TDT3ZwTpTpt71zLVKxzfJsBlJ8DWTyJrZfUEoGB97xcgnG
	 GHUs8+AcN2Z4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0A6F80AF3;
	Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 267C7279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B88A40702
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TuHhqtymTidn for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=sRPKdIe4
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87108405A9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:48 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-482c58a8683so1315203f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577226; x=1788182026;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NvS7MEJi+5anm/vGQIj9R0Hn70FCBFrUfyAy7wQU3yU=;
 b=sRPKdIe47I2ia/yftIzsMIP0xQdSPnG7vK2y+WZ15Hk4HpvbwI5aKQvUpMwuUoAFUE
 G+LdPVeTE7FtfuQeBwTJ0X8C2WcQIrbinMEBC+kxt4meaEsXdgGX+062nxb9LWy787U8
 eDSGcIXMA3iFFTfZUiGYkMh2uWx+n9veMy4SicZ1YIm8xmyMqRo6YPKfgEpWqF77+vNe
 VC8B+LGP/5KbedcS47AlFKzapP9Sl8QujKZnv8zVY3gEuWu88XDjQqMXkZxvkxahDBoc
 EgoyTsjBL1eAhQrt1Q1NNn1AT+DlxGGZgiOvHpKwA5YpfH6iCI0/BO2ew7jN8V5AaULo
 sbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577226; x=1788182026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NvS7MEJi+5anm/vGQIj9R0Hn70FCBFrUfyAy7wQU3yU=;
 b=JAqcyZhs8lMBtM3nU8K2Sk+D7S1rqSEnULM9wGgJbA2DrH3KYsxmRNVzUAnsYNktmY
 5iaNkqEShsd4/5ACBlqCG5iqY1az7wrceSY72FwI8xHixxcozvxxP+Y2f/hi+y1OA2QM
 JQZ/EMeP957D2xUXDysNC0PpQ0OPFq+uPbhwmPsqvobayySFkJmBBiTMqSXAiX/joZ6h
 y3OD28+9MHDb4kLptNXuL+ebCKwd3sUI4PGoOkpqYpkqyoew1Ae+OnRRRKuQozqmbIx2
 elxY41g4xsRBrrtR2klKSQlYEU9A78FW/Qri5y/623qW2kaQVTnOiKQkkpDJ0qYz6QeI
 1cWA==
X-Gm-Message-State: AFuF++n0U7y1pxT6xGkCCHTODiJZbvEAJ7pN/Siy4x7hgRTrPjMW0Z+5
 dbG59WPBEeBlhcpgJAT1M3JIBhZMqmPyyG8y4vSIvcHuChfCCk/mkYF+DZXjTwBn+Hk=
X-Gm-Gg: AR+sD13AHpegck6qtYUzh53MruyPfNIKxVnj7f/wQhdXxYY6rDCuPONx6tTyC9/8eGj
 MZ8bKDhihLAHNw9F3rzGe7nLbaLoHwA9zLIVFJRApGSIzhr3MvGojdMM/sfaYqgId2ueLj1uRsY
 rRkqpFUL9Lp6KVfg7rncR2YUhPLtd4LbLzyAr2D+7bD35C72xML7L+p8FNwfUe1iy25iTj9KbxW
 ARF9gns5aRAo+9yx8ALnXmpOyAvJfOeu4suC8DqSjGbDs9kC0yI0zl+nM+uLkpy8imAGd6+bNsz
 bpZw5TasWc/0FaEcqGH7XE8o/06gCh/hLMhl4F2Nz9j/H1NCZnJdGfqZ1KBF71iceKmNuGPSvC7
 V+OJLIPxGUilzizIGHRJBpvNC9n3B9Y9F3LappQxqCDxtJzatnrw6LajELkt8pChs7+S9YVIDBn
 HtW0sAQsdNF3vKxiZcUET/zMZpXgnGUnepL5VGV7H6paBSUk9DWwLrCUSP9R+udVEpp/frrrsv6
 dNCvIq/aUTl5xrKVjN9V+bK+ku0MAdsbUpTlNU4yA==
X-Received: by 2002:a05:6000:26c6:b0:482:a36c:a5e1 with SMTP id
 ffacd0b85a97d-482c0b44b1fmr32160922f8f.1.1787577226318; 
 Mon, 24 Aug 2026 06:13:46 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:46 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:10 +0400
Subject: [PATCH 13/17] pylibfdt: Grow the FdtSw buffer geometrically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-13-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2600; i=alchark@flipper.net;
 h=from:subject:message-id; bh=z2YBR29qtPIwh1SHJbbXeIQ3F0Wilp7LYXHBf0TwSi4=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGdd3GJnmCuSydf2kbPIIk16uZmneBE7Y83F2AUfD
 /Au28XbMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFSfkWVkmCDrZioW/m5p6onTMQtj+jSmJFvHd6QdSXjmLx4ZrPnOkpHh0+fjy1e
 cv35ARkth9iWlsE16f3Q9O302s7xMXSy3QrSaHwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Every expansion copies the whole tree into a freshly allocated buffer, so
growing by a fixed amount makes building a tree cost time quadratic in
its size. This is especially painful when assembling larger FIT images with
binman, as it assembles the image with the data inline.

Grow by at least as much as the tree already holds, which is what variable
sized arrays usually do specifically to avoid such excessive copying.

With this change, building a Rockchip TF-A+Falcon image whose FIT carries
a 31 MiB kernel takes 33.1 s rather than 44.4 s, with binman itself down
from 25.3 s to 14.0 s, as 7139 reallocations become 187. The images
produced are byte-identical and the binman and dtoc test results are
unaffected.

This is a backport of dtc commit 0748c384fde6 ("pylibfdt: Grow the FdtSw
buffer geometrically").

Link: https://github.com/dgibson/dtc/pull/189
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 2179515a144b..c00e74a46b76 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -861,7 +861,7 @@ class FdtSw(FdtRo):
     device tree. This will be increased automatically as needed as new items
     are added to the tree.
     """
-    INC_SIZE = 1024  # Expand size by this much when out of space
+    INC_SIZE = 1024  # Expand size by at least this much when out of space
 
     def __init__(self, size_hint=None):
         """Create a new FdtSw object
@@ -906,6 +906,10 @@ class FdtSw(FdtRo):
         -NOSPACE then the FDT will be expanded to have more space, and True will
         be returned, indicating that the operation needs to be tried again.
 
+        Each expansion copies the whole tree into a new buffer, so the size is
+        at least doubled rather than grown by a fixed amount, to keep the total
+        amount of copying proportional to the size of the tree.
+
         Args:
             val: Return value from the operation that was attempted
 
@@ -913,7 +917,7 @@ class FdtSw(FdtRo):
             True if the operation must be retried, else False
         """
         if check_err(val, QUIET_NOSPACE) < 0:
-            self.resize(len(self._fdt) + self.INC_SIZE)
+            self.resize(len(self._fdt) + max(len(self._fdt), self.INC_SIZE))
             return True
         return False
 

-- 
2.54.0

