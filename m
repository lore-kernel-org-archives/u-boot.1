Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EDD889AB;
	Tue, 30 Apr 2024 01:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g40n0NBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7013889A9; Tue, 30 Apr 2024 01:04:01 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCF488966
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-790c7785ddbso189059385a.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431838; x=1715036638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scWRPDQedx6Wi9dpYLxBS2YuMJa6bWwcx+3HxjsO/vc=;
 b=g40n0NBffmKcDuEKnVugGlGgWc7drLmgXyba+wFpabP0/E5j//MpQw/Q+Ekh9KEQma
 aHIOqdFKlfHEkQnNgthrWBoJSDojI67aWd5v93fhN7fVeefYgWUC8CiVnPRNdcmSie85
 gwhh2Jw56IZzti7ZrzdYcC8/BFzNmXM86NJ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431838; x=1715036638;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scWRPDQedx6Wi9dpYLxBS2YuMJa6bWwcx+3HxjsO/vc=;
 b=Sb7sNEqNPOlqnQcBM8KXBlA9dfm//lG4libt6K8ghuMfNGBy9yZKC1VtPeOf1wuJIY
 M+3poNFxREoUz75V4yYn6SLAIPq6IxJRLg+dsddMzQfRJqHNxDk7/JMROmEjfuY9Ypwp
 UvcixCE2Dcjgp/V5JmH/jgrn/ZLXfV05OJ3uAE2SGwy6AmmvaR/jbj/esaT/cU2VcY0h
 PCam42eoyPZ7KTNpHU01O+yF2sj6cvxPxe+CPdypvfjFv4bIQ6BcyRxr+gJmANgiiLLT
 HL92nucShaZ6VoqKkbmHNTeGKNNJIkgfwMhGrvXri3xrPIhx3wdn90Dob5vn0n0uhIUX
 xrNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2NU6cpuWS6WImIHkKPgvesid0CjgHvhn/k0C0X73AjrnfnBNGnGlHUGaJAYpBFAYV984dpNkTuV2MJ4XjoHWPU0BKLA==
X-Gm-Message-State: AOJu0YxLuNibcs+sW+ZeEdghm40L0hcYkU7mnmCl1tUEy1eaaBToycFg
 zNdoflvGfB6wgRXMvPJLWhMSIAopSsiZrW6i3FdS8cy2RaBGa+D9nOqEaTRID2E=
X-Google-Smtp-Source: AGHT+IH7I+fO4QPvztrkSwDZKNRdMycS79W7FnfzdFTXUXb182NnH+WtoD+0RrxmYQ+rmqqJ1qzUww==
X-Received: by 2002:ae9:e101:0:b0:790:c7f6:5958 with SMTP id
 g1-20020ae9e101000000b00790c7f65958mr921871qkm.1.1714431838199; 
 Mon, 29 Apr 2024 16:03:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:03:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20240415075458.8584-1-francesco@dolcini.it>
References: <20240415075458.8584-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] arm: dts: k3-am625-verdin: add tifsstub to
 tispl.bin
Message-Id: <171443183684.1749944.8813302336946379136.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:03:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 15 Apr 2024 09:54:58 +0200, Francesco Dolcini wrote:

> Adds tifsstub binaries, this is required for deepsleep functionality.
> 
> This implements the same change as commit 128f81290b7d ("arm: dts: k3:
> binman: am625: add support for signing TIFSSTUB Images") did for TI AM62
> SK board.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


