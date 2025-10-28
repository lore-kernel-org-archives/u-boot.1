Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71883CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 18:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6272683966;
	Tue, 28 Oct 2025 18:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fLIPjzIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F6608391C; Tue, 28 Oct 2025 18:59:18 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A48680422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-654ee10146aso1162211eaf.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674355; x=1762279155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApCfxeZjXbLISNYRmSlaI3fL45CkBqSuOc3ZIXYRtak=;
 b=fLIPjzImrNPNPK/ApabRqJifgafFNUAcqrd+k936kCIXK9Pt18SiOI9XJ0VHgWY3qb
 0t4pDZKoGLwDqCgeKz01x3xyB5PyHhO+OVAySln4lpUUWoeM630isrNO475fYLZWFywC
 oosqRrI6Xo+7Ez4Rhp/RQkCjbpve35PjbgmWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674355; x=1762279155;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApCfxeZjXbLISNYRmSlaI3fL45CkBqSuOc3ZIXYRtak=;
 b=hpKWtE3zeFMIjbr+PSrsIBXZinCiQWbQ7w8gqzyywQGhCATfx9vpZ06OqWxRbqvAKG
 BhR2l3vP5TsCclsPpwscb3vUIqIbfvj7L4RmMGGlDy2boiecrQt/FdcYuVTO5gVd3mHf
 HyNzpSnNhQBRa4u+qIvsCL/1V94KdV/59jTZVrCLLNT4xpPCaP1lpDj24Dz1GqWT9qBy
 gCAB5iWP1o0+iiisan6P1Qneovbc3RloxxJI7pfBNEiRWR1WLoWce72j7RsNs8e2PUVZ
 EN/3D3u9a5I4Q2LkBRaYBUpPPFHsL50/y4A55i/hYevS/dBBzmgtARwoZVgfGXTzHhYa
 gf5A==
X-Gm-Message-State: AOJu0YxwT4hSyNFngXEyllVVWOqlmr5wC52CTxOyYS7NbdPdtU0MpD0Y
 mDypVgrJU44Tmq//zN+2PWt0plwfV0bV6E9hpv5LngT6OPicC5riMIlUfkWr3ohxtEY6hYnE6lz
 atlpo0vkKs2sS
X-Gm-Gg: ASbGnct3QNFOwIBbyU3O023IREB5rOvDMBuiOCo1W956tHnff2bhnRJJ99SWL3P4hpT
 qmhCDSHvQi8O7/AysBXeZS9z5abOWv023wrLZSifVDLJUpJNIEzpff+t+9vIFpDpYoHxZCLe4mH
 ObkwIEYx0izcBJbAkl9Fq1hwQHdMKFD9GtrMRCyFbs5hWxfVesmiNM2KCl4RXjnIwdLIMhz4STA
 10hD2T59jMRuLY0SQd27OKHTaOqsiHH/Ju+56Grld2oAL3yL/OUQeFCHbKrfpOQA/xpcfzu6f0K
 7MZkP7cXASe75W25YwEfWtaLXjZleQNzpuGg5yDF3+WqlRNUuKk4tf9Bf6dD1MxfoClNmLWGFzf
 fuGzH4cEyWIIcASQxQumjBNTYBRLbaHY4kfDs7C8BhzPQEq6ZwhK7LM/G4KrEurB1yqFLjWbu6a
 zPBfGFOglc33VHU85HsXiJbQhUDxT8ztnbrL21Fg==
X-Google-Smtp-Source: AGHT+IHgyMjHxKhAva0HcnonhWfN8rCeEfWDb8lMmylXpDFBdXQPKydBg+lyrn7BKaXkH2IDlpjw2g==
X-Received: by 2002:a05:6808:2192:b0:441:8f74:e7c with SMTP id
 5614622812f47-44f7a8b605fmr103014b6e.54.1761674354849; 
 Tue, 28 Oct 2025 10:59:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251006-spi_uclass-v1-1-6dec8be15fbe@linaro.org>
References: <20251006-spi_uclass-v1-1-6dec8be15fbe@linaro.org>
Subject: Re: [PATCH RESEND] spi: spi-uclass: Use unwind goto
Message-Id: <176167435363.2025892.7071567580831419954.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:13 -0600
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

On Mon, 06 Oct 2025 16:09:25 +0100, Andrew Goodbody wrote:

> In _spi_get_bus_and_cs the check for stacked parallel support needing
> multiple chip select support does a direct return on error. Instead it
> should set the error code in ret and then use the unwind goto.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spi: spi-uclass: Use unwind goto
      commit: f12ca3e2b81beef901c182981bb70b0b2aec8f6c
-- 
Tom


