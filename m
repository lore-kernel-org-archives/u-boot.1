Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBBDF364AB
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF03984106;
	Thu,  9 Apr 2026 20:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xig6a2O4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CAFA841C2; Thu,  9 Apr 2026 20:18:46 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD22284106
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  9 Apr 2026 20:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47018d341f8so896624b6e.3
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 09 Apr 2026 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775758722; x=1776363522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpyFGZ5jzHSWmU99jbEMREx7iGdaq1yEJah8Z5q7oPM=;
 b=Xig6a2O4lFr4EFY6ZQApzqm4Gh9rCHIUxxBSwWr/9VW9J7Vjx5CFO5JxiY/vF3jh07
 +GNNS1IsJyFT5OanqNincyYE6fK61I9We7BJwwNeWRnXacSAQx7BaLUcJOO04Fa384gc
 wzrKmtTIRhU5pdZPhyN87sXC2YxTm6ukWG3nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775758722; x=1776363522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mpyFGZ5jzHSWmU99jbEMREx7iGdaq1yEJah8Z5q7oPM=;
 b=ss0/CO44R4JMeJ9tWLs6hAn17ZHKU07wKL9NOd89LE99mAfs7nKc9V3/NN2iMtpK8O
 1X+gouM2V60d5HteJfixFugjLOABbWUXC001+PLjhkqIMdv/uzzME81kxraQCYG8W50k
 G7dm9wIznn/iXWlZr4ljzjaJ8s+fBhEQR5tlEGmZuHtL3dKUCMbx6ks6w4fDUyssAlyT
 OfTF0oEoU0CBDnTsjOdHmyM1X8yEN4e3yMKR2LZTysmy7KcHBixqMrVq/26/A4wwQZm6
 kpWvIKUCadwYDSnfKySS1VZ+6YfSpqEWdjMH4QK5sAHMTzaGqw8OK3v9YxTQp3xdPdaU
 25Jg==
X-Gm-Message-State: AOJu0Yzc6GVrSaQWKKY0l8sxdNmZ0J0V59S8Q04XN4haBGSYYen4z6Me
 zeA/ZePYgnVr7406ddHbU1e/rK0ylotEvT28lEd+b4tARgxxsnQP2h1PJahbNtkFSAM=
X-Gm-Gg: AeBDieud0FA2JMbnzVfYB3uphtnJDsRSjtcoAnsB4UZ8kZUFFgVls+Hh97PtzMeszkM
 XEfDO3IZ9FTC0Oc4dtj+AlqGYOCM5rw0VkUdoXZZ+hmIg5gw6NJcwBDbs4/q5GJfATJMd7MXwqA
 DhNhcw3/HiIZ5OqAAeZm89wtFMEF5VmDPelj/inuCCCxblplcwi4W+C8F/DjSNKPpTE5VbhYIw1
 PHk14iq6xLZKH6w/2omKkwhO0Wh6ZQWREsyhD8HTtNAv5u1hqqLM6jo/7NeYf2Qu6B5Zr1mrWhY
 o1lN4pEJpBWrgF/rguVQ0HdKIddetaRQmo0UNz+NE8e1RvOOqbSMrls11mU9G8Uf8QhygVptuIC
 vr8+p+S0Jj8equ1+flUW2cV5RT4QFFCxYzTJzReQ4NVRC6MuJV1SAS5LXgzczxrBtAuV18oo6h1
 eeqIVr6hwe2Mgo3VhxCMiv2EmcSS27/ewOVLUorlEVRzE40SBGsI0VcYxpwWPMK/AncXNfpFWpe
 ZFbg3a+m64OORRc6PrzJZHqV5QieEJrcrbWkSPMrRhj/XTzAwD3XQ==
X-Received: by 2002:a05:6808:1796:b0:462:b520:273a with SMTP id
 5614622812f47-4789f9ff5c2mr182455b6e.25.1775758722514; 
 Thu, 09 Apr 2026 11:18:42 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a2f565d1sm76328b6e.10.2026.04.09.11.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 11:18:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: sjg+nodisclaimer@chromium.org
Subject: Re: [PATCH v2 0/1] tools: u_boot_pylib: ensure all Python modules are
 installed
Date: Thu,  9 Apr 2026 12:18:39 -0600
Message-ID: <177575860172.1153156.9979437266936408022.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331080636.380507-1-paul.henrys_ext@softathome.com>
References: <20260331080636.380507-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Tue, 31 Mar 2026 10:06:35 +0200, Paul HENRYS wrote:

> Add setuptools package configuration to pyproject.toml so that
> u_boot_pylib is installed as a proper Python package without changing
> the existing flat directory structure and making sure all modules are
> installed.
> 
> Step to reproduce the issue without the patch:
> git clone https://source.denx.de/u-boot/u-boot.git
> cd u-boot
> python3 -m venv myenv
> source myenv/bin/activate
> pip3 install tools/u_boot_pylib/
> ...
> error: Multiple top-level modules discovered in a flat-layout: ['command', 'terminal', 'test_util', 'tout', 'cros_subprocess', 'tools', 'gitutil'].
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: u_boot_pylib: ensure all Python modules are installed
      commit: 2b9828c8024617f14e13ad6bf7d474552d880240
-- 
Tom

