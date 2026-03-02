Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50616D58E7E
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 08:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A45583E63;
	Mon,  2 Mar 2026 09:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oVcS8JgM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E723D83EC6; Mon,  2 Mar 2026 09:55:27 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA9B83CDF
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 09:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so129956f8f.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 00:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772441725; x=1773046525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b7iFIPXjm3EMN3znXMHEzzLZEPjgHg1iyP4KvaYCwNg=;
 b=oVcS8JgMk+e1Q8YyEOTm6kse/40jcnLcwv63sA/jRdCvBlPsExApQrJJdJOeZl6XMc
 ymFikP0+tiKNjCRZQ7iSEiJ+szSZAzVvI2n4hmchGWFaebGzk6OcHLJunG8sZdoH/RkZ
 2w6aYJCnkpxiS9MMVu/W8gx/6sIVlWePlxLBiA+EBprTqTJpxyUGNSEGR0baulQWSWbb
 c0t5eC8jkkd64xUje3Fv3mDeXOybMIrq0KAJUx/Rx+fPsamVIBV+ExxMq98PgmJwQr2h
 c9gokOC6Cdn0eonaAc9ssuBN9TCXvFxp1GF0k4BDjPXSLiozm/tL9lNKft6+a2OXbY4Z
 t3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441725; x=1773046525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7iFIPXjm3EMN3znXMHEzzLZEPjgHg1iyP4KvaYCwNg=;
 b=tTXJLXdiVdUC5xnIwiLBbFkEX68t2jSFmY7oBm90p07el9LqDcIHNZ97Y1762nRvSX
 VkK56O3n2WLKk4JgmSchcri1amteKGXVd5qqJTJyCFppmmdHBaQb6flOo6WgtaBU8CyH
 4FWW7wxtmzx2X7PMOzKZdCmJJ7No3T6pDlMHC5iZRk2tCUG66eF3PW5wAnVMSg62XFaf
 UxJc0UvUEQHM3X4bH0LfvmZIIuZcGrTJZdMacubzjsE3028tB2Wn4WhNUZ0e7EAMZNPJ
 sJVbTDRnzgU9J8F/k3GAsggMK55VU6LOXC4foSeSMccJ+uobKEeS7eoPnU11D9zzVO/z
 UGXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVddlItrKXunLkyAWNhMA1OUOO11AEf8SpZk5RAedbSdjFpmwSJPYvH5ZGnKjIq7N6lnyO0TpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxbNIeA/6ABvsuaVBLNZG43fC3jpqHXUgMIEqofNLswnVQmuf/i
 SlCnuJMPvipnDmUsIowoEqmi/kUxa0ntiwme4k1Wn61PXGOhoNxkYDzonk2sI/OS1Io=
X-Gm-Gg: ATEYQzxJ7wDLfgy1n6M8NJsbFN8TK4o36RaHOoj5b4doyTF/UsGAzTB6uM/sAdAKnsF
 SoOP3Qsc3j+/Gd/QS3rf0AUsITCQhj0NxZ+e8UINqnbsY4kc6rl4qJB9KS1+dOD7VwBJlEkHhtd
 TaAegbMH8mP7idQ4eYOxcnQveNzGZgRLvoHEwLdCQFYo3a84XLw4DeSJfVzP6scgOXgHRQGiTE6
 3m1AfFHGsG73SuAc+cB/ziImh/rkebhfi+WZ26bbJoHdXREOIhXX5IOI/w69+7IEEGpPsNwo+Gb
 4Vx1QXtEV1gEuP9kRa/poXeOd7587+t/SXouUZFjfGwMRjBSeOnh2TFKEZU+/FvI03VO9IIrIyW
 DQMu+6lVVMjoCCg7hMM+7YXvQ4PsgqVl50pz6KuKT8IVu7jSkI1aZ1KH+aEkmRu/T7BHDsZhm1e
 va8tULyPRKAhoph2F2tKRFHwF5jMKaBxRS35zZ7rof3ks7yL/jiyCBdlZb9vJlHlqYnilPQWzp/
 KmPahxXByAajZTSt7IH0++K7ulUR1P66YACsKvHMExL8pdxv06i/BQLRfXez2PeD9Zh650Ul0Qy
 YFU7OPjs934vDpJGIF/EQn67LMolEGSWgVf0gKrvUTG65ue0Z/Bq7toHyzeFNHVUbty21o5GpSG
 CzpOeq0cgn2dw7RXHanbgWh4Vqj7rqL5eeKGhYM4sHkhEr42XQ/pDWAe5Vv75LuSAl4eSaOHGGT
 9yL20Ere29VrhPfkoVZ1WmC9ZPZBtHIwlURYn+lxt48vyFrOH+1CsPax+NKoE/
X-Received: by 2002:a05:6000:2903:b0:439:b5d4:249b with SMTP id
 ffacd0b85a97d-439b5d42936mr5890128f8f.21.1772441724736; 
 Mon, 02 Mar 2026 00:55:24 -0800 (PST)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b3cc2e65sm10014515f8f.2.2026.03.02.00.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:55:24 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com,
	frieder.schrempf@kontron.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH] kbuild: fix cross_tools compilation
Date: Mon,  2 Mar 2026 10:55:07 +0200
Message-ID: <20260302085508.39076-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Frieder reports that after the kbuild sync running
make tools-only_defconfig
make cross_tools
fails with

UPD     include/generated/timestamp_autogenerated.h
PYMOD   rebuild
tools/Makefile:359: *** insufficient number of arguments (1) to function
'filter'.  Stop.
make: *** [Makefile:2191: tools] Error 2

After the sync 'hostprogs-always-y' contains the complete list of
the tools we need to strip, so the $(filter) command is not needed.

Fixes: bd3f9ee679b4d ("kbuild: Bump the build system to 6.1")
Reported-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index 0ac683ac3ec7..5d8e8f349e13 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -356,7 +356,7 @@ override HOSTCFLAGS = $(CFLAGS)

 quiet_cmd_crosstools_strip = STRIP   $^
       cmd_crosstools_strip = $(STRIP) $^; touch $@
-$(obj)/.strip: $(call objectify,$(filter $(hostprogs-always-y)))
+$(obj)/.strip: $(call objectify,$(hostprogs-always-y))
 	$(call cmd,crosstools_strip)

 always-y += .strip
--
2.51.0

