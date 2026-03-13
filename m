Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAC7107BCE6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1AE84382;
	Fri, 13 Mar 2026 21:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mwHg/p1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA8A84382; Fri, 13 Mar 2026 21:55:14 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D7F8439C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d741f61ee5so2238873a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435311; x=1774040111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNP1b2kOvb5vfhlgeD5XoJ0DHl3Nz6Uuj6+mDJqVJbE=;
 b=mwHg/p1mwHWJtyH7zQb7FTyF4hNO8YSo76norUhZczfHFG9OLcL9h8H/pSPidA4/cE
 mDFnh953UFZgeC4z5AdsVgg4+EyXRVJW/OZ5os/4HQ9Ri+Edy2WRkA2deS/IPBaO1Q/p
 RO15iOAPi45I6SiNvRZSeqAaw0MwuIrzfbIOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435311; x=1774040111;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNP1b2kOvb5vfhlgeD5XoJ0DHl3Nz6Uuj6+mDJqVJbE=;
 b=TcSukJ8xojDfilhI5+bWCd1xiY61gtdRuvWFOLkTkYQuVodOlrl2zmAM8Q0wsSIdB5
 4R8ax4O0lTa8k7ZedzWOSvCqQj1YR+yF3FHQI5tOBz4UttyFzxDU955UCJALbq/9BNKq
 uF3G0Ap37nHa7n1jMMhyMtvsczHnbmhGwV7fDXGYrfPockTT0qQaNLPherp0EoUIaVMJ
 OYodqeTiGpKkE5fiinJz5Q5E34hhUcndEunKAla+lyV2WxKVJOtyLxIJKZME7pHzabK0
 LMADu6lbeALURCSVaUWE3AxtXROjatINDKTlLGSMguGfK7p0POkkMCeVLwM83lw4ZIwU
 RSSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6X0TEFBs0A5g2mlF/f/NTAIAhArmtBYhkLcWLSf47GpxWp48IsnKT3mNonG2BbZc5bNAuDMI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0dPCWg+/UYl81uzI8CIAyiKH+8zphj+7oQhOmYGDH63X7Mc3a
 gp8FUGG7GX6s/1Xyq6HhYcUl4Jy5W+i1FmvhZVY1EYIj4Yi4acNAQWcwuFD+3TwRuKI=
X-Gm-Gg: ATEYQzza1C9CaZOcB13MUaRx9eYOL8EzRd00fAFza6fahku5HWvcGcIJkFyoE8ypWWL
 8e5zvDuhrQ48yoYXhazSE1gr50uXYHoFAVFQ05REEMfy9Xg/kMeqYB1YqDGQbqN+4OrttYLdlpi
 n1P2XFSK4F0kBpEYRQFa+7qP1OZ0j1JK5X5JG0+xJPwpn/xUJTO3D1RJzrUD81uJnMD7opaJ0Pz
 MGfISXUu8+YHrPrTtsPxwuVGCgYKlaiL9NDcVA/jY5MbvSPs/CnqF0alM+oplLtIHGJ3v+JLJUC
 wCJZR9vSdBl59nVRCTFLyd5c85jeo97mrKChur/UqQPJsGlxy8z5ZLYmb1uCqkAGgIGdZit0Wuv
 iUrJEE/r4FBo19jD3rx30DujBxdg57geO2JBvdF1TSYwvn5HNxAgDIbOUipjpsQVmtvx7JHbcD3
 lCJubQajhHQaZhVW67Fhzw8/hT+xoL826z0FBJyyIaBtOi879c50jxgx2xjjOhBX7JuG+AZ3uJ5
 ZHEt7dm6fW6VfY88UR2Me+YPkan+2AIx2ic7tC4rkd+z7I=
X-Received: by 2002:a05:6830:438e:b0:7d7:48fc:d985 with SMTP id
 46e09a7af769-7d78251b57amr3443403a34.20.1773435310926; 
 Fri, 13 Mar 2026 13:55:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Aiden Park <aiden.park@intel.com>, u-boot@lists.denx.de, 
 Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
In-Reply-To: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
References: <20260226-serial_ns16550_fix_warning-v2-1-738146c5df53@maquefel.me>
Subject: Re: [PATCH v2] serial: ns16550: Fix return-type warning
Message-Id: <177343530967.1131472.2067825168476910044.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:55:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 26 Feb 2026 19:39:10 +0300, Nikita Shubin wrote:

> Fix compiler warning:
> 
> drivers/serial/ns16550.c: In function ‘serial_in_dynamic’:
> drivers/serial/ns16550.c:153:1: warning: control reaches end
>     of non-void function [-Wreturn-type]
>   153 | }
>       | ^
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] serial: ns16550: Fix return-type warning
      commit: 660d8e4fe92e4ca3f2173e3d00a25f6ae5f6e97d
-- 
Tom


