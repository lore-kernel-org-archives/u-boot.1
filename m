Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8541ACFA457
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 10:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1208488F2C;
	Thu, 24 Oct 2024 12:46:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RUL7kdMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A9288F58; Thu, 24 Oct 2024 12:46:36 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B3E88F27
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 12:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1224185a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729766791; x=1730371591; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kWgWN2er0232aH5xCRDl6Gy4bcvkBPWzvtMD9Ahxx68=;
 b=RUL7kdMnUb//SFHwKy/npRvxRh42ISXBlJiv9fQ+TUwtX5DqNlA9NCbuZXBepO/hfZ
 up7Tq66O786TA6D3E0MCB3HCCD76HfpckAvEQWsuWmOgnQWdt4HRTgA4keLF9G+U+SXg
 AxHkciUvg9JMIg7HCWUVdNItloDrvM/s4v1VxoLRlsR6ohjMeLX4TUZtaZIQb6cg337B
 MQhJ+IJDriiYw+tQ6lUizgIKOPMx2W8XPuqNTdz1vv4HVvwOIIUqK97yXUETwMs1rf40
 v2FF68uJ9zQS8HEANTo5XDEcpgDQ7Hj7uYb9qDcIsqOaTlb09nbUAFk05lVpkc9HHC09
 D/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729766791; x=1730371591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kWgWN2er0232aH5xCRDl6Gy4bcvkBPWzvtMD9Ahxx68=;
 b=C/6zBSQd6xed8L1Y+UGKNMEwfGm3jePSoSX1vSawRFx/Qg1NGVZ1Ar76sUWIOlqwuT
 wRM8ew6LpyNSAKO3fP7ONVsZSYr3z9RSJdll+U/3T5GxL50hW1PWlKjGYxZ+q6FqkU8T
 hkLGOlPVCqEPUZKEJ2Mi2rvfSkGNP1RgJslDWVwOKQ4u7oXRjdtS62d5VQFQKyNJ7nLS
 BmupnV278/NiW4EK7dL7bIhmGOw9cj5sWCmPK2vsrcKBb64dgiEhiycJbxaPPdvnyeHu
 lnT8x9RqyAMKSiHPM3ylrj06ouN+k3LJdF0/A6uYoBSK45ybA48QCGeZD64M25TpCjss
 1/Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRLeArsqQ+oLl1cgsc8gs6WsJakgwDuZWku8uLyveDxe9YOf/FqMy/LGS+QoexG2QByLACMzM=@lists.denx.de
X-Gm-Message-State: AOJu0YzPqcJEsSaamnIAmInRQBJW+slUxNbescy161ZlNU2C0EhoXAhv
 FPzX1dqh+vqDavXTtTltK9vTpW2bWsAVPVHtZvj1mnWB0jbGRlQ1sXKKOhJ5f+8=
X-Google-Smtp-Source: AGHT+IHEHMZsVZ1jA+er4Ox2LBQ54DyFlh4iYLyNccaxnnNzIDPJOPixNM9OurUewk6KLf2LLMhMGw==
X-Received: by 2002:a05:6402:5383:b0:5c9:88d3:b1bd with SMTP id
 4fb4d7f45d1cf-5cba20d1689mr1719975a12.12.1729766790666; 
 Thu, 24 Oct 2024 03:46:30 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a654c4sm5580301a12.31.2024.10.24.03.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:46:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] lmb: Correctly unmap memory after notifications
Date: Thu, 24 Oct 2024 13:46:25 +0300
Message-ID: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We never unmap the memory used to update the EFI memory map after
notifications

Fixes: commit 2f6191526a13 ("lmb: notify of any changes to the LMB memory map")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/lmb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lmb.c b/lib/lmb.c
index 890e2cbfdf6b..38c6e1d5ba8d 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -65,6 +65,7 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
 			status & ~EFI_ERROR_MASK);
 		return -1;
 	}
+	unmap_sysmem((void *)(uintptr_t)efi_addr);
 
 	return 0;
 }
-- 
2.45.2

