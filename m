Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F1CCAC5B8
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 17:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6187808AF;
	Sun,  5 Oct 2025 19:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HWdvUiEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E62F809A5; Sun,  5 Oct 2025 19:48:46 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2C4807C0
 for <u-boot@lists.denx.de>; Sun,  5 Oct 2025 19:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-355102ff142so1391310fac.0
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759686522; x=1760291322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCLYQfWtHFyP/8+/u8zTRvwQPgyllsTv46yPfCIMP/A=;
 b=HWdvUiEGMqwp0mOM8djZaNxLTPpo2ZfxdW3EfLinDnCmMOFcpa+ng6E8b8ivznDbcR
 n2dcVuzLEfc9GwsmyEqDiEifr9HKoYEmhzWy18u3jnouuKcbR/Fb/v2ejmy8MUn3MyBF
 NZx1+NJCvQZGmjJYF7hRLnscvfDxH0i8pRWMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759686522; x=1760291322;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCLYQfWtHFyP/8+/u8zTRvwQPgyllsTv46yPfCIMP/A=;
 b=nAlOCnSXgwNon/BXNNlaru+P7lC56l6aXuZbWSefhIepcHjcBklUfcZSyrTxQ++KKo
 /aJiWoeF1Nu19iCCgCN4wppPSP12nar0jhbqbVhG67+A00PbU5+EvcCjQGFZ1X3ZDQM3
 sbjDD1rtTZ9KYFyeQ6W+BXvzh7Od/kRbRFLGTXyEfWRd657o0cyL8UHqsCTWz4DqqpfD
 3xvUwjh/NmlujIG4yU+fWlObpqRQQpQWbjUcJ8HmJS7KZeXUUOVdmwh/S1JuuEouOxPT
 qzwvJO4vBdKb1rFkpzEse5yW2Ev3im/7prnsn3O7deWaIWI3ym4vLNTybZyYsQLaz3Vn
 wSWw==
X-Gm-Message-State: AOJu0YwXaMqn9AaQQRHbC8m9Vkcp19jNTH7AmYBI3Me1XPoDQ+7N3XbQ
 2CJ8hiR48RrKdHnYVfuo2HAzvcJ30Pc0LUmaNUHraM4iFkRhU8E/ZrAZ3ih1V0FCJ767O5W45xe
 3cPUwuck=
X-Gm-Gg: ASbGncvgNDbuOXVDixVw1+DCaY1eaNncGLUnuOM+Z0Z2sHMQI513t3zf8pCdgs1cqZE
 17O+U9HIkkRXCg/XHAyyhT1JBWe6Ykd7SHNx7KwcQrMV8y/SvSMuwQv6W44MbO2wD3FrcisAm1/
 z0CsP3MSXxmMkSM6dQzEW2gGnfyRHX8U+MveuHSnMRUsbHAcPepRCeEcYTXC7IUG0zcCi0Bb8OT
 Xrf0JOYDGnp2iBsh9bqt08KuAdV34+r0pBF40A9aA2GaSbtIldXcd+cx0ER1Bql7SkRNqDrs7Uu
 aYD8RJpdM9d0wkJUX8tgJyxzvjfOliNtSGAXTjGiBqvFLSJpdlJq1vBEnWwQssStG+JmUstTGSL
 M9sWHQqawQCi2lGOAEU4dRYIvZAyvTDHaT4eTtPff8qIK46FZu/wPeHqgiOY6H65bK5i3qdFDzZ
 wlTUXcIdg8RkpbAxwEIxymBBLqyMNbdA==
X-Google-Smtp-Source: AGHT+IFZaG+t2KDWWMsEh27mwKK9hdEnFkW2mxAwe+8lRKrdoq03mDyHmjD8P9cvlq4mrUk+XTbliw==
X-Received: by 2002:a05:6870:89a9:b0:3a6:bcc8:8043 with SMTP id
 586e51a60fabf-3b0fb7a2529mr5453502fac.47.1759686522452; 
 Sun, 05 Oct 2025 10:48:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ab91e6835bsm3353634fac.23.2025.10.05.10.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 10:48:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20251005130014.5562-1-marek.vasut+usb@mailbox.org>
References: <20251005130014.5562-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/next
Message-Id: <175968652127.149534.15915679097485450255.b4-ty@konsulko.com>
Date: Sun, 05 Oct 2025 11:48:41 -0600
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

On Sun, 05 Oct 2025 14:59:51 +0200, Marek Vasut wrote:

> The following changes since commit eede1fccec4d0adf1934d9a6f51ae6d3675351e7:
> 
>   Merge patch series "Drop ATAGS for B&R boards" (2025-10-03 16:55:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


