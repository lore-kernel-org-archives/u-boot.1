Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D3C5ACD1
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57CAF83C39;
	Fri, 20 Feb 2026 17:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dMJuhhTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57D683D2E; Fri, 20 Feb 2026 17:19:35 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E0B83AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-679b072ed3aso1075492eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771604372; x=1772209172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIjaooDhx1rZQqVG5zA+k4Dotb5Hp1+DoGw/oEwBVxo=;
 b=dMJuhhTslMNCB4V/VOIu9FV1kZR2rvHB6PcCmdqE7ItpkTXRdYOs6+MNyKLpucRPr3
 2o+/minsDjXj5HQ1alpCoUjGPYRFL3RzEW132ea/RC3P0Yr/w0p4W6MBSeAOeNqI7DHu
 JUMTtyYLRLhMXdAcPhicIe5TBQOrtfc5iLPTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771604372; x=1772209172;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zIjaooDhx1rZQqVG5zA+k4Dotb5Hp1+DoGw/oEwBVxo=;
 b=l5bQIPx6tPwk3PJ9WIGRSrZquap3pzMhOTICVblBgtUButNOr7FTruBStDadoXw+Dq
 I9GeEHthr7Vfs64O36+LcSnpd6Pyi+3XkPjZGRDl9/xOK/dE3HWc5Atsq03x2e0id9Rd
 XbtTuMzjOECTlkiIfCcfXUcq1mfNeC43O74u6LBBMux5/9xjcYFfhB0lswQFFH5AfbPi
 98/tfA1d1O+gOXM+rRv52JV7/V1xjyXpp33AruzQyb0JJ3wncG7pFoFR4ouSNQ19S+jH
 b1K3b12t75MeEZ7+Mrp43h0sOiN1RhgBAbayG/+gx/tnTQTw12fK3TDVfKEONdU6Hmsp
 RPAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr4QBbveXypiz2d0mhYkgWt4V6UaITjK6s+HXeT4ttXFFQ3AQB+tgndcCmWjX+e67NKYhnqJU=@lists.denx.de
X-Gm-Message-State: AOJu0YwarT30Ni59bOq42TF+NJLKohSe2qaCuaO3G20pb0QPU189RZ5o
 P8v1ixwxKEHiuvx4VzccXqyIcYTO3r44ViWejsEhI6OvWWGo1oMA9Kryuk9I8KhITVWoivKF9FA
 v9D8za4M=
X-Gm-Gg: AZuq6aJ6VDf46wvS95ZZdi1+UATRTLZ8DXkrBmYbu0wc/IuC6LFGW3dMTRMKx0djTiq
 zGQ9qxAgvjquNSV3uaKRzfpqBd2SZ4O+CXXBsI1lW3KTgcQGOlbQByJPzbX0VnZytQsgNPoVTR/
 Kv6GmdTLiIuI2n8kmVP2SjY9d+O4/obeBcZcrrCQurHaXiE47TI2L4SrW+fsUVz221y5fd7CQmT
 zp23/T/ePuLquuZ0/3z6L2EGPGQmZvqXZoutYlqhz69B2zq5QDVvO6jGxFA1ZluniTArFOv+tDo
 w8V4LW3T3U3XfHqcK2PuHkW8NJtns93C58Sq1OBx4SVXira2sgRPT0oxyitMeFOqA+QQuTAbAd9
 Eouc7ZPC5la+uW641Gsgg7YGlml9t6zSby8ip1ARAZsTPR1fiLpxkDpPnjLvOlO4+n0yBa0Xm/d
 9VjAViUKn2V3YWQNA+Xa1W6v8mzbhl4dxuXtkAsWj66X9OEltIgeaGi3L6wavBtfcPSt6AdHglL
 L4HkK8o2iqXPO7ej1/GazFEs/jhqek3qV2q9uK1/bFpggMmHg==
X-Received: by 2002:a05:6820:460e:b0:663:1239:9e9e with SMTP id
 006d021491bc7-679c4503883mr195000eaf.55.1771604372405; 
 Fri, 20 Feb 2026 08:19:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-676f444f315sm15499304eaf.1.2026.02.20.08.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:19:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>, Chintan Vankar <c-vankar@ti.com>
Cc: bb@ti.com, s-vadapalli@ti.com, p-mantena@ti.com, a-kumar2@ti.com, 
 richard.genoud@bootlin.com, u-boot@lists.denx.de
In-Reply-To: <20260205121551.3619582-1-c-vankar@ti.com>
References: <20260205121551.3619582-1-c-vankar@ti.com>
Subject: Re: [PATCH] arm: mach-k3: j722s: Update SoC data to add wake-up
 I2C device
Message-Id: <177160437128.83679.1741290695464680136.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 10:19:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 05 Feb 2026 17:45:51 +0530, Chintan Vankar wrote:

> Update dev-data and clk-data to include wake-up I2C device for J722s.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: j722s: Update SoC data to add wake-up I2C device
      commit: ebe62142fc623c70fcc80ed391c5b6a6ce4ab3f7
-- 
Tom


