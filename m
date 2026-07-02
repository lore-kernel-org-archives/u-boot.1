Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEFBC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 01:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C2A84C68;
	Thu,  2 Jul 2026 03:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1LAztxz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5C084C68; Thu,  2 Jul 2026 03:47:47 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA6B84C15
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 03:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-69dead44101so869984eaf.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 18:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782956864; x=1783561664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EN0Qg2kTM/0hI7rrWI9+DvFnvVXpN6Etp6yzx66Zirk=;
 b=A1LAztxzTH/4F8vxGHkpZ4wqukOkUgGY0CqLWT7LaaCVR/Cdy+BJlA0TNwo8xTKdE1
 mceNgG9YlBFj+yzk9ePp8tfepOatbHnzyDyZ7axGMUGc/tbe+5nT8rxtCh17D0K1BfHI
 vYz2gx/DcDPe1ULsp/7U6j8gZwLDmS9u8NE0EMrm40zqIZiskT6TCTueUrdfPigO8WLM
 dWBbWggjIzbDOrNXiYCOHrw8pT1dwuBEkHQc5dhTY5QLOS2HzgaIAnCLsj1Vo2rv9eUc
 m3hKw+Q93iR51fszxLqVRczZlEj3sJoaUc+LXqXAdlUoRORLUKFFfecH3vDJUhJBFBvr
 0OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782956864; x=1783561664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EN0Qg2kTM/0hI7rrWI9+DvFnvVXpN6Etp6yzx66Zirk=;
 b=JrwHKvbEkNHdwa9G0cN2yJoWMB4HWCMguMkqhjkLFdzBFK/aA6tZI14+EGWR6zKVIK
 qb7SnhR3CMkU1dU6wrHk2iyLzD0CqTSlaBP6dYu3+2tyPeIWwokQ+IcxCBREsRaBpxhn
 o/1mCkH57lRK5laqVx+jrwwAUrbzuAbnK9DtXEsCRVaS0XTjsyuPsnfR0MTMX9HpW/BU
 2rUXbhu5sAIpACcaSD9d7Y8Q6nbaifkSDtbk8+AfoYZ66Xp0i7/dfZ5ZsDsjXAXQyHv5
 yyjTiI4Z3QvfoqP/M4CLaFngamWwC2shvKHyzC3yqTisGCNE2DzO9D5TWjAy8FS0ModR
 GCvg==
X-Gm-Message-State: AOJu0Yxl8QSq4b3jofSsilthwLHA6wf/qHo51Q8A8PpEnUXo5wH/+qJx
 NxR/Um4BYqE/kQsRpHKFn99DqK9TsFvKAnYkingXaJOy0JW6+0fQjtmLxW3x66r5eKE=
X-Gm-Gg: AfdE7cnKjW1WiPMO9p+k8mhSFzQPy27d4FwfKja1C/oGdJqfQd7KoM3fzraEWntLfVf
 nNEzU8zFUu+y/KDtSjXL9zEAHSc0Ai1Y54OfxnOMqpjqylkcqSBj+x/TmoFBAqvb66NumdE8wWo
 5L8UVsKKkuA1jov/4zmEQKn8of7Wp1rL35tkrIPouf0w/yqvd+5kwFz9yzPnJL5bZ6nJ9DIeEbz
 IwEFa6YxauWBLSx8y9qdrpS7KPdCOSyYGbcPCpj0C3A+2T0+naJk5Spm5R+SK70OVggyXNyKfdo
 XJaIdAhj9p4DLC//fZ8bygkSBBUp4blxv6eCQVMzcColaPzpgDIMwAThAOMTByttG66rAJy57rf
 z+CKFlTzEYImiW6z/06GtPkxJ2BbsctYz494KHmRCF3OKIGnrwSCdXg9Uh05urjNuKixQ1bQabn
 jbhBoTeF2+bCXPKUbcFwmwxS06MrcCLsBxz0xjf+ctI1+SwB9yI4uQQ7MYPQBD/poucChp1dK0q
 fNVbW2Xsrz5+eIW6b3AYnzmgCak4jzj4iWy3YiPhSb4z5z3etlmSv3sAySlRvThGe6VomV/C8OP
 UTcLG7u8jeFfCuY=
X-Received: by 2002:a05:6820:8107:b0:6a1:50eb:2106 with SMTP id
 006d021491bc7-6a309b04cc3mr2732284eaf.59.1782956863834; 
 Wed, 01 Jul 2026 18:47:43 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (97-118-25-163.hlrn.qwest.net.
 [97.118.25.163]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a310051cfcsm1284511eaf.8.2026.07.01.18.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 18:47:43 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 2/9] crypto: aes: allow DM AES in SPL
Date: Wed,  1 Jul 2026 19:46:52 -0600
Message-ID: <20260702014724.1534351-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
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

The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
but there is no SPL_DM_AES symbol to build it for SPL.

Add the SPL variant so SPL code can use UCLASS_AES providers, for example
when decrypting FIT images before loading U-Boot proper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/crypto/aes/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/aes/Kconfig b/drivers/crypto/aes/Kconfig
index 7e1b1b2875d..19988b05271 100644
--- a/drivers/crypto/aes/Kconfig
+++ b/drivers/crypto/aes/Kconfig
@@ -4,6 +4,13 @@ config DM_AES
 	help
 	  If you want to use driver model for AES crypto operations, say Y.
 
+config SPL_DM_AES
+	bool "Enable Driver Model for AES crypto operations in SPL"
+	depends on SPL_DM
+	help
+	  If you want to use driver model for AES crypto operations in SPL,
+	  say Y.
+
 config AES_SOFTWARE
 	bool "Enable driver for AES in software"
 	depends on DM_AES && AES
-- 
2.53.0

