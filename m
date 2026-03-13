Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143B6107BCCD
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 16:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664B9843C3;
	Fri, 13 Mar 2026 17:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E4TXyuO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B246884372; Fri, 13 Mar 2026 17:52:25 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA7184379
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 17:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso1624904a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773420742; x=1774025542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBc2HAwqz4KZPFwHfg6coWWKeIulO3/xFWIEvs36mGA=;
 b=E4TXyuO9s3OcEiatDu4gExdqHGgYFuFX9hrKwX83XcKp+lNS4un9ApO1eWJzHEz8P9
 EZMtub86r1FtD+BO4q4ebQ1knL6QYc3+FswUHo2kGzNSPJIYpZWUcWhkKVLMTxPOiciY
 yHj8pyQgmYbHEIeuetoR2IS5q+hnMxxvByc8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773420742; x=1774025542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PBc2HAwqz4KZPFwHfg6coWWKeIulO3/xFWIEvs36mGA=;
 b=TwMMfszSDj81KRmOClzWHwyWseQhdUiA5/5ddBEjemd0Hh9BEclDVAD1mBEzmSDurZ
 9317kmeITQxt7x9NVAh8FNkvMcwhd0I9GU3EFPz0tu17qWNu08zYTNMJJNX54ThWpx2S
 ahAJ169Lbqx1b08u2tghtx8JBZqWtsmXk2aRO+l8PL9Ts208ecshLUtzVd79WXZUl2HY
 7mcLoKwvvbsmRbX+g/Zn9t2cnDOPr8m7vArUeMWfMlPQR3+xW8K1/55Pp+IoOL5SegMO
 6ZPhUDhSo1UERrlIiAHMtDjct6sSa/QH8s9ybsLUKLPig+7Zy6zFZxnxLmARmV8gA47J
 wyLQ==
X-Gm-Message-State: AOJu0Yx4MbTGjc9xCoPzUQTqxrXMlfNFgNy1S/iojIGWF++Xph0gIOXL
 bZjT/7Ghi+v+lvDuSKGk4JSpSN8h2GJVzxWkxpGamggYhDKhzU03N3lVxmjT4Nz44unZmeFZCn2
 WoAkU
X-Gm-Gg: ATEYQzxe0fpo06HncmXUzSAS8zM1Yc5rgvXZyI5ulWGVdNvyiUVRE9Gy56wwckKrGJQ
 xDNP8vJCDshrf10vsSoKoycpDqj/Grc4jWcYVRqyB//bVEwrTgkBenEAsCz8fZDgEi/qnSUHvD+
 gVS6mD2dUo3lLuK9a1m0t1i0qE3eeRsrvejtS5PAklB0rxy1U/b50yy4BclJXME3t7JQXr24dzf
 dFsAdDvsM0F08Ly0fJ4wUyW30jgjFN0hyWLtMkLI2+9MMIYqz/PyoUfxKECnohxR2RxPSPvW3pZ
 Rb9d9gVxdgWL2PDrf/qm0Bc3Ta6pJa5RApk5Vg1SpStg3WYqTpCRd3iyMXSxEOKTSrqrP1OxGcx
 iahMkzZTwc2KaINKTd28Ji671BUl1Pf1eszuguYrl7EaiFpxa1TfgY9fYy/XqYzE5Kp6gFihinp
 k2DaC5mFNFGUZwPvl0DBC0PBCSP7GWghHa6Wyh6iVI+D5iYFqa4tp/2XV1Vxum7bh8r79n86Yhb
 GOsSwSQOZcYYPzz9BojlEdw7VTwUijFXF+r6LZz+3YpT1aeiS2UICZgfRPu7Q==
X-Received: by 2002:a05:6820:6ac8:b0:67b:a1df:2079 with SMTP id
 006d021491bc7-67bda9e9cfbmr2328845eaf.31.1773420742244; 
 Fri, 13 Mar 2026 09:52:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bdd612b6esm1241304eaf.10.2026.03.13.09.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:52:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-20260313
Date: Fri, 13 Mar 2026 10:52:18 -0600
Message-ID: <177342068509.1062380.6133314696440109412.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9808f640-2c8f-4da7-9276-95ab5448d701@linaro.org>
References: <9808f640-2c8f-4da7-9276-95ab5448d701@linaro.org>
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

On Fri, 13 Mar 2026 12:11:23 +0100, Neil Armstrong wrote:

> This is small set of UFS changes for next release, UFS SPL support + reset
> support for Rockchip platforms, and a small callbacks ops cleanup for a future
> mediatek UFS driver.
> 
> Thanks,
> Neil
> 
> The following changes since commit c0ca147ac6228949a6d6497531c9f2f4a0dc6c67:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom

