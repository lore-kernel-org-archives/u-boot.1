Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A66CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 18:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEF9830E4;
	Mon, 25 Aug 2025 20:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f4y3g7tN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 587D383020; Mon, 25 Aug 2025 20:34:48 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7A682C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 20:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30ccebcc7e4so2142123fac.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756146885; x=1756751685; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTjr/X9ZtXNX8jfs+wxDEtdSVb3yudo8pmSPyjvsmiY=;
 b=f4y3g7tNMfm/Rxwwwbgdzj6jq8GDUlkXs3apVZ3ZPNxtu4mw53XFwY+uifMp7ZyR3i
 DYXOMTau5rzJiTSNOXvhwsJMa3UQhRgnOAZUSd2LNlJKbXheNc85s2dpREtA1+e6jdbx
 FLlp6xfr3RfMAHztUoFWqafavMzi+lSGyitjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756146885; x=1756751685;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTjr/X9ZtXNX8jfs+wxDEtdSVb3yudo8pmSPyjvsmiY=;
 b=Amg/lg+6j8s/2D9ThgBnL1sroHwjzlW8Y+x/ZLr6C6kw7M9/CND8Kpl3axZvMjSTuD
 R+rrFPuC6YT7cNXao1rwp8g5o46MDyRagxh+nxkRAmgqkCv1SY1oLE3GWZ17MK8W59i/
 b2W6qz5ZhPj6I+4G+goo8rPGJ5rTZQkRDM0rBSTHi14q2dKXsdFQOnCtb5MorFcDsmC2
 PZZ8/zUkd7gbt5WBuyJazx8UAerB0heOa6WkYqMoK0OFtUOLDiDbv8iV+X1ess7SNROb
 SYO2l6Hp6Y/LJzrXqtnIKEUgT9UMZ8uC17IgaZ6l88/7JkpkyBH7ANleMCUxtkjUisp2
 NU+A==
X-Gm-Message-State: AOJu0Yx25dbf0f/nghsrkWKZ09BpD4xPk8JE/x3e/PHNf2OlKE+fLXaP
 0xgTs93OwS/OEvkyVyQYsTaf4NFYm56/Dtg7ITM3G+gqMExQX9hSDTebgo9ewyXLdPY=
X-Gm-Gg: ASbGncul8ERVMJzXSjVEjnQucvCgocFCTyY9nfExVRlBUzJC9fb+AwPKGpUMHKax3ga
 kespm/KtKibjpnT3Q5TYJkqA+jwbNqfJtIJj3fDPWEiBPmNWanZ0PnDkRXHXiPuMq30bgxYO87g
 tDI8ydgIkbh3/3qJjpX2n8UcA7gAn+ZBLI+1uYoo7vTBa0XwqjknO6l6QwzsnX4H6c0EFJLv4gt
 s91tcB+vE/9S6qfAr9qRf5ffaDgmF73L/hi9CP/GdRxFu7x2KhmzBDHid0BOIXM5PIKNyfNLkfT
 KjTrOW+dBL2E7HJPIrWshC5O7CsgsCGg+lXV9a4zQxC2NHD0DVV5O1E/LElH/X8tCnz7ClWT8S3
 TqQLuNCfFvJFUsCi/DIwDNBbW+NfpxAmbybwaQmUgVF9FzVbfU6Jpgxk=
X-Google-Smtp-Source: AGHT+IF1xNfyDNGMvW21LbrdlGoVjpbUtlMORVfV9K8xXEHF3vWWBRO6U/xtCAOvf+RKJxuKOXB2hA==
X-Received: by 2002:a05:6870:2481:b0:30b:8cb9:e709 with SMTP id
 586e51a60fabf-314dcaac1eemr5239948fac.8.1756146884790; 
 Mon, 25 Aug 2025 11:34:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79bbcfdsm1931051fac.7.2025.08.25.11.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 11:34:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: d.schultz@phytec.de, ggiordano@phytec.com, m.schwan@phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
In-Reply-To: <20250818102605.2248056-1-w.egorov@phytec.de>
References: <20250818102605.2248056-1-w.egorov@phytec.de>
Subject: Re: [PATCH] board: phytec: phycore_am6xx: Add rauc to bootmeths
Message-Id: <175614688398.2891795.3073723610707927494.b4-ty@konsulko.com>
Date: Mon, 25 Aug 2025 12:34:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 18 Aug 2025 12:26:05 +0200, Wadim Egorov wrote:

> Add rauc to bootmeths variable if BOOTMETH_RAUC is enabled.
> This is setting a proper default for RAUC enabled systems.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: phytec: phycore_am6xx: Add rauc to bootmeths
      commit: 03baafe0623b558f3a6b19fad94f34b42abb537a
-- 
Tom


