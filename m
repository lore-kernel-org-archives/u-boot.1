Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B105E7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39C0A83D6C;
	Mon,  9 Feb 2026 19:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjFQUshL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2AD83CBD; Mon,  9 Feb 2026 19:12:08 +0100 (CET)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D0A8397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x143.google.com with SMTP id
 2adb3069b0e04-59e3810df30so5478330e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770660724; x=1771265524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqpoz4xjaaasAZa92PlQZeDQ6dWVaWAtFHKYGxtVdt4=;
 b=FjFQUshLXOjtUE6QOpR0FPCUAOjnB71KTwV267JWB5J7y+VVUIf1id/s+VTzWAjqWN
 jFofjlQy0bUpaiychoIbxCpyRMpCWtxyQt8XFtWKqD+2zFlmI3aGPAqSTyLRhX20qSVp
 JXv5oaa7zXHCiNJaUYOKN0scfelCFXWRmFz2DPqU9gFo3lLXnCbrIMfA+1G+36mYyDJt
 5Pzt+OnUCOSi4VbBJuXH6DTfUGuEMAQ/GfZR63lLW7ggxnroHXrSu1gbL8WYWLsRttdH
 e1ouyQ2gWWPi9X/giF/M8Ys5w6kPFFO4sW1czFfE/RkdrojuklRIrKHT4eBBxBWWDgZO
 eMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660724; x=1771265524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qqpoz4xjaaasAZa92PlQZeDQ6dWVaWAtFHKYGxtVdt4=;
 b=rhw/2IIUlS/At9E8hlUbe+DcjMJJItDNZqhFR8Bg/PYF745/WJ/BAjSJuAwLdcZhBm
 1mBjBZTytmTJIK0Hq1Lyi/fWjj8RPU/f8TdYMXYbITPlYIv1sm9BebFIkdwcJ8hU0DzO
 8PLSqHe57s/tmZe6zdtAAJDeFdwkgNsmvWwf1wutGFN373oS8ZjrpKjrCqhtQXMcoQBe
 VwRP37agobVuCpauWU4G2uTWOzVnoZUKznc+AQXRS6nCBSM4hfNAYNvjDsWVS0T7+Hkl
 fzjPnJwv/tz9r8n5iTaF32HSp1G2kZNWGIc2FXQpLgJWjRd3Hhmk7nQSdWphfoRTRPrt
 yNtQ==
X-Gm-Message-State: AOJu0YxWzG0/QfTCu1WVCfFK+9zc/CUH0UoywaYGGsh0/VvvuOxlStJ5
 xvSpzaJgBGNt8QvMcWAgoWnz0B1vLrnQ7vq2W6dGi7kNLfxfw3VFW/1R
X-Gm-Gg: AZuq6aLL3qs7HNtQbFhohtgJznh/21tSVZX8l4nrnu6LrLBzPWHoBUskC3f8CebvSS1
 U7CW3ffY/83au9AeuVjXXEwwkxrUmmwAs/t8jJco+HgPFScyDN8nNzYxwZ8ZtDsqB3PinBFlhIg
 yR3X5Xkg5FhjT35BMvrzaw6LjF2bZ+fQ+miy8ncox/x9rO4HEi99z4jwTICpjkqck8n6JY6V6VR
 gbLHeCgRSo9lB2T5ps+cIsHudi52OiWKTvKL07cdXOieLhIYTaw6ROLRfezUdwhlaSwOnaKQ8M5
 GdPcVcw6Mal02gCFjdZWaJ0EBcPg3MwdbnvvtXuKQcQSoikh6AZ2BvQVi+b2BtAOdh8fccTiO20
 DrXH1vzTq0YhQ3QaP21Fwv9u23fEF1nY6a4GswqZoW8as+EYJQSctyNja9bi9w6ixO7dcJbbFGx
 mK
X-Received: by 2002:a05:6512:10ce:b0:59d:df1d:acc6 with SMTP id
 2adb3069b0e04-59e450481aemr3945794e87.13.1770660723854; 
 Mon, 09 Feb 2026 10:12:03 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e25e4bsm2792801e87.88.2026.02.09.10.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:12:03 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] input: cpcap_pwrbutton: simplify parent verification
Date: Mon,  9 Feb 2026 20:11:49 +0200
Message-ID: <20260209181149.32714-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209181149.32714-1-clamor95@gmail.com>
References: <20260209181149.32714-1-clamor95@gmail.com>
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

Check for 'cpcap' within the compatible string, as various CPCAP
compositions always include this component.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/cpcap_pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/cpcap_pwrbutton.c b/drivers/input/cpcap_pwrbutton.c
index c52c0481f67..a2278617f5a 100644
--- a/drivers/input/cpcap_pwrbutton.c
+++ b/drivers/input/cpcap_pwrbutton.c
@@ -76,7 +76,7 @@ static int cpcap_pwrbutton_of_to_plat(struct udevice *dev)
 
 	/* Check interrupt parent, driver supports only CPCAP as parent */
 	irq_parent = ofnode_parse_phandle(dev_ofnode(dev), "interrupt-parent", 0);
-	if (!ofnode_device_is_compatible(irq_parent, "motorola,cpcap"))
+	if (!strstr(ofnode_get_name(irq_parent), "cpcap"))
 		return -EINVAL;
 
 	ret = dev_read_u32(dev, "interrupts", &irq_desc);
-- 
2.51.0

