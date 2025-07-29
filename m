Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C716C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4D082BCD;
	Tue, 29 Jul 2025 18:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k1Xt7Dx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A40A8304F; Tue, 29 Jul 2025 18:16:20 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDD882B20
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b7746135acso2901531f8f.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805777; x=1754410577; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8XuGKEOGZ7OI6L/gPUS07PcOryhMRnYzmclx6+K3kds=;
 b=k1Xt7Dx/2QeI1GvH0ZiQnKTzgZKvSS7nFjuOhMEHM4NZOgqn4EkL9tvOE4hHRPxQDX
 BHJluNBESZxvhuG2nE5U89dDUQGlv6ESpadUXUbyDHW1ou/1YGirqVa7400Zs0kL9DTu
 53mS0voD9b/06tpF3PETxqy7R1prKCZHrZhKN//kn98qTqo6bYP49Hfrrggg61hqrR/T
 Ze8qFW5Xg6FoAXynChIFs+ANmRqu1u6P2gkgZIn+1HGvADmqktZsPM50Z7n4+s06b5hc
 qrnX2iiI9hqY8rGNEhTomCMjCu+VmJ509cPefIfadZDRLDTz66Hzs5HByY3lVcGSbwbq
 VphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805777; x=1754410577;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XuGKEOGZ7OI6L/gPUS07PcOryhMRnYzmclx6+K3kds=;
 b=aBiuDu7FPA0B/Qzq6FaazxSnOvb32CXengSDbwj7DW3aU9e1YK1ev3gUF+fpLWivkw
 LSUqTZ8LTfVUz7GrZjizNACkOmyg7b2BuJZamxbbajSMP5zSED7xFwFMvhzhrcZfN+iZ
 kGhcUzO/YkVwHwELaO01ELECkAkkXtU3mBbdsyCAX7NHUxPDxZd9LzPyYJIi8NAeCKsc
 EiD8pUFq/w+WsX1jkdwrsLt3D/zfMYgJspBETy7M/EngB/qvB7TctYY7osEEo02QimAc
 s0HDLEjZD+1vehYWpWimTesjnKGgxCdPjYc+Q8LYQFINElVY7sk03PgaDxD3euBfHY6V
 S4hQ==
X-Gm-Message-State: AOJu0YyTMOMDvhaxmdFEG5KhTxKZBGvup0iMxTaRg1YSp39LWIOi6KEz
 O8tM+lM8Lg59xvJs4RwsmZCjUsT/bgRbnLmnnpC9UkZArjBJ5iCrL/LrrE6vkX7o6ttLH715nv2
 nihiG
X-Gm-Gg: ASbGnctOay/OO+hYZYMmZInghgvMqNd21PVzdFXMX9plnBub4pyoSCMQd7gi/8iIj5o
 brCyURLCMg8nHxTPQbx3hxEDTBrMa5Hsl3312SzbB20mZRcwiOXj9pLL47lZ9l7MzIRsNfK04Mf
 O8uz13KuBF12Re7TKJBcPztBShxB+yEPFY1W6EKkqv70mjZObiYEu5mQQ3ns7aqqL7U0Jz8KgbC
 JM1M/2tt5xqJsS7WfbS9JwicvhY8/ny0hOT8svl7Tdobcp9MVOgdQKcB65+PCHvb0PrYvokyZCm
 KaoDlxFeRG+tbEFPQdko2dxEfJRFjrdgfEIijmNrSyiJI5DTDMG2dk/HSUc6dtAOpR2rGzu9gIZ
 KqeMagTHCX0CVeYsval2+ClsZLvLSweypMjwfPemOrCrjuLE1dXI=
X-Google-Smtp-Source: AGHT+IFTogYBJdKrLtY2e5suob6GS8jcGd9HF29DNvxPGMZfRYgz3Wq+svRzVDpTs+j8Vy8/lSdWlg==
X-Received: by 2002:a05:6000:4383:b0:3a5:27ba:47a8 with SMTP id
 ffacd0b85a97d-3b795008875mr194088f8f.52.1753805777545; 
 Tue, 29 Jul 2025 09:16:17 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:b80c:a2c7:328a:9067])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5da136sm29993275e9.23.2025.07.29.09.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:16:16 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] mmc: gen_atmel_mci: Fix some Smatch issues
Date: Tue, 29 Jul 2025 17:16:15 +0100
Message-Id: <20250729-gen_atmel_mci-v1-0-ea0fddf587a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/ziGgC/x2N0QqDMAwAf0XyvIJ22LH9igxJY9TAWiURGYj/v
 rrH4zjuAGMVNnhVByjvYrLkAs2tApoxT+xkKAy+9m398E83ce5xS/zpE4mL7R1DCB4pEJQmorG
 Lipnmq0poG+slVuVRvv9R9z7PHwY3JpR4AAAA
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported issues with duplicated checks that could be removed.
Smatch also reported an issue where a variable was dereferenced without
a NULL check despite being an optional parameter.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      mmc: gen_atmel_mci: Remove duplicate checks
      mmc: gen_atmel_mci: NULL check variable before use

 drivers/mmc/gen_atmel_mci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)
---
base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
change-id: 20250729-gen_atmel_mci-b53a6662ac6c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

