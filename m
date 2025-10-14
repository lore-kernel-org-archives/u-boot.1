Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A976DCCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A258367F;
	Tue, 14 Oct 2025 16:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CpMVjnKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FEC809A5; Tue, 14 Oct 2025 16:20:43 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87221835A2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6477f91713aso2559911eaf.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451640; x=1761056440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqRj+HeQXoREm3G8v6B9SVmH6QulKzz9JDyyUepoRho=;
 b=CpMVjnKrM8+PTlD+9MKWnc8fc/HNKjVLFkWy2Nj1wXC1pxBamAZfuEEV/9Ie6GyoMH
 OPQvaZ5deFwEU8vD0uqGc2fBFYys0NBmlrVgoz4otGNjFbV0RTim/fgaDqwlAUGus72Z
 6SJfX8/whHARH1+a3PkKB4we34Bv4SetXTGSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451640; x=1761056440;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqRj+HeQXoREm3G8v6B9SVmH6QulKzz9JDyyUepoRho=;
 b=IuiWBduqWQDwGcudaQ2wmGJQ610ps2tCRWosfwyt6oX6I3rMkcZmMrblxo3RMkTaRo
 +EWWGH3EkPcPzCWZqGZsptc6hZTfdbJtXHLbdOy9gMth8lHN7RK55kpbLaQ2qCFIqGrt
 xlevuxouRuO7HtU8Xd50fdz/vDrEGjVfpFq64ukKZ9v6N/g2rAYhFvtIV3IPOyMLR54e
 KF0s17AMe9fkhpl/Xt2kHY1QoMIUiu2qXGuNGoebSqrKabyxn0lk45EFSA9Wo/hyTwHs
 r9zcJXtqYfDUHQzjY5uVNjVV7RUTPxbYQiwkA5fSDfF0V0jtyxXXfmyyuT2L/Zjdfp8Z
 QLGw==
X-Gm-Message-State: AOJu0YwZEFxrhJrNBdYTgbcEXGdGtpu7GuJLOyqj/WP1cgktYam0PXb9
 UclkUQiLXNZF+DL6rjBlA6wqB61UtTM4iVBE18/3PRBNn67L17aJ54OVzQIGY4+mCiY=
X-Gm-Gg: ASbGncucVo9/2GcHoQzzpxYS/AzgDaKbzFumSO3dyQrYmRYY3LudtlDEFARI0ePmkPB
 EeLo3cTBopgwEoGzNbHEJLeVBxhhwLsIW+bB5XXxWwEh57aoBziS6hg86wH4ly8Bkpi+sRlRmdi
 eAFQ/8+AqaD5WbnNo2IwgOY0LA/h58CyvIw5YIO97lpCYTaUchG6jyde3wbm+DFXgLRgTOTVWQ3
 EGTYEzixGKmu1W3JTeYsQb4JELTOkroHVgg++Swi29QqHOsbrmLJy153u2zaBp6VJBvomJUK5cn
 CPKicV97G+rLcYMlP+GjdJ8PeD1vFvhWnfAwNohrA4DrS9RIWjtLVbuPkNt81yDxMo74MPT1tmZ
 35c+5gzQhiRotBW01LRbYkcP3elt5TOUKht0LCZv1JrKvlIWEqcwnYj/Tg6AE40C8FI+ZsynzNW
 5N8EBx4yUbphQRIg==
X-Google-Smtp-Source: AGHT+IFGatuxByAfIihHhXD6145vaQ000aArnCh3jdfirSecKiI5JeyG3+lyLIDnjur6Z50TkzC4YA==
X-Received: by 2002:a05:6870:d8d4:b0:315:663f:4056 with SMTP id
 586e51a60fabf-3c0f5d13930mr11690362fac.4.1760451637727; 
 Tue, 14 Oct 2025 07:20:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, jagan@amarulasolutions.com, Ye Li <ye.li@nxp.com>
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, 
 ye.li@oss.nxp.com, marek.vasut@mailbox.org
In-Reply-To: <20250919070156.1497268-1-ye.li@nxp.com>
References: <20250919070156.1497268-1-ye.li@nxp.com>
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
Message-Id: <176045163686.284655.1628133922757049102.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:36 -0600
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

On Fri, 19 Sep 2025 15:01:56 +0800, Ye Li wrote:

> Align erase and write on erase block boundary in line
> with how read was aligned in commit 622b5d35613.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: sf: align erase and write on erase block boundary
      commit: 865f6654226b2b933d1971f86eddb8664ca83a3e
-- 
Tom


