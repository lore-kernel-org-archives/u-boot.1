Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCC6FD4F3F
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A3983FA7;
	Tue, 10 Mar 2026 21:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TT2tCLHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5D684006; Tue, 10 Mar 2026 21:45:29 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FC283F8A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4670464029eso1662549b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175526; x=1773780326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZiqxO6VuO7oq1HwgweBO2aZ8TJqcnyAyVu9wfMyNQo=;
 b=TT2tCLHPNxgb6anVwfjgErvR3iQGslRYKpnFXnRH1q83G+Zs6pWQCPNcDmazNKsNEB
 9ItPtfF3HIg8PimMSmjk6rVyNxQQ3B8lvMYzoZvsSnZbR/oEIPbzsGQ2fG3XwUYjEJI4
 IaZtzeJOYD04e+uyen0TJw9dLyWQnuZtF6jm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175526; x=1773780326;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CZiqxO6VuO7oq1HwgweBO2aZ8TJqcnyAyVu9wfMyNQo=;
 b=pnF4epSwnf7CMSqqMKK2r2ehSk7v9CPPftK3dyCEPeoXEJIJW+HiYijttmZp/QENuZ
 4+/XP1aGEeDkex6hvaFQ5nia3nGdoPbSIjjldMI20jQzQKqIOWXQJLyOqT0fs478NauV
 yeAJ7UqPweC2h3lohdUYkycaoHhjz/kjxWW54NyvmNHDMRatpXPvauE332U0IQlyHNxQ
 KcHyGzm9Dx5A7g6TehUARXLkclV3ZJY+PvYfcWJE6IU+Vo2jBM58ve10RQn5/dPJ46DX
 ihKRtQ4waOv7yGqGrKJ+lE5sShLYpZXR31LavSa16avPRF5I4WuW9HEMMxFG/PsyEUiu
 s5BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3HcOwB/gbT54J2E5HMOhqBRkBOIaSOue7hHjBZVHGqakDL/iwMpLkumEvSinY0FOIRpfPQtA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe9z6MPsCsb1P9KxkQnVyD8VGTRai0on4+RUHXKaWlZyqy8Rvm
 tRsUtoTcmtouyjEDXIUeQR64zW2D4NEEEvH23oAV2WK44bNtABWXVw19Kxf+R0NKZCM=
X-Gm-Gg: ATEYQzy3Za0s9/1tl4gCVDgKoV8tuNTkXUA2TWDj37LBRnNM7DwpumL7z20My7wuKc/
 1kFuP6D737WUfrDgPIq0ayMBJKjPBFyyfTwoxLyoDSEv75O7TPnAZMCFecVrYmYzeEduH/ovyZH
 gjonDBFfk+09uxsVj3YHTCPBBWr93dLzDuaYLpxfzHROPWebhFwm5M30SwGsPeyvZGDz+xkZw8C
 N0DOaaNsRpwgP+meezQjFVhUjgrXUH7PfaBj+MmqRtXjo93hAbo+yUprbmQtuFpjHyo3b3R6RAS
 EUXzl/L5VGsajJoGLBE51DoOloMjn2CAMXZF/l72BApvh1+phr1E/JujtY5njiVQFzrbcPLnZLD
 nPCAPB617EuiiHFB1T2PC/CP8wXeR3Laxx2zLzD5D/b/UWQC6b2MIrWiqbK5qJyEE2v5s4P0a5v
 O7cgqaqkLU5/oC44BGrTicpyZmT7Dbz6D/wc4qjnQM+Zgl3MgzABNeAgentTD5k5tGlekqIVBJT
 G45rh/n8sucNny9BocG5KbrRHEg3AXBT3yJFmEbWaDx
X-Received: by 2002:a05:6808:1441:b0:455:daf0:9998 with SMTP id
 5614622812f47-467335084admr49654b6e.41.1773175525908; 
 Tue, 10 Mar 2026 13:45:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: lixinde <lixinde@phytium.com.cn>, 
 weichangzheng <weichangzheng@phytium.com.cn>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20260225054337.12488-1-heinrich.schuchardt@canonical.com>
References: <20260225054337.12488-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] arm: don't select non-existent CONFIG_DM_PCI
Message-Id: <177317552498.23044.15603182959851650625.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:24 -0600
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

On Wed, 25 Feb 2026 06:43:37 +0100, Heinrich Schuchardt wrote:

> We removed configuration symbol CONFIG_DM_PCI with
> commit 3232bdf0b30b ("pci: Drop DM_PCI").
> 
> Don't select it for TARGET_POMELO.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: don't select non-existent CONFIG_DM_PCI
      commit: afea129b3da6433d7bc40b8fb943cdfa5ebc31e8
-- 
Tom


