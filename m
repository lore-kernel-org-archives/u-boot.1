Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05136FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 17:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E768495B;
	Tue,  5 May 2026 19:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gjtV+3ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AAE84915; Tue,  5 May 2026 19:57:33 +0200 (CEST)
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A5A8486B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 19:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc43.google.com with SMTP id
 006d021491bc7-6967080e6beso1698354eaf.2
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778003849; x=1778608649; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rbl47OpgWvQn+pJjagIlakAr+RnpjOfpFZg+VSITCKE=;
 b=gjtV+3ov+ecbbynEx4YQYdREAC0giOtZ5QHTxItVXu98zs7vvF995j5B53O1Ya+Axa
 cQgx186RH7MLMt9TjQjNq+sWM063at1yLwbQ11NSWV/bIxQtIbSXHQ18pXCXu6Iac7Gp
 qmWDmMpp/tcyVwP/EwSyo5iJWMU4jPYavF+dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003849; x=1778608649;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Rbl47OpgWvQn+pJjagIlakAr+RnpjOfpFZg+VSITCKE=;
 b=jF3DdpM2E6zI1opiFldlJzo2spYoc1EZtnmn7gihMEubZaxE/pc5t/RFj3lne5kFRd
 uRyNXE8s/2IdtK8AM0Jkgk4CMO1NzvmPMIVErEP6KXHuh5+akhsUiT1Y10igVlLj3OvB
 X/Yvj6SqUk0azlv3mnWYVtCYRb8R/ABDnnHPrRNQyi6gANUOy4vMMny5futHVgZe8ABz
 0BYKWzA0qBxmZD1PG84hn4UPIaoVvlNbjY7bZwJ7Nste+hdxicYTYkWVs6Un4zT0joRj
 J71Z6S6vF3RE4gvSNOmaUJYEVcQe+SaQJ23g4NjCB7OSoSQVMZ4KVyIfqVMDlLN400qR
 5DjQ==
X-Gm-Message-State: AOJu0YyC5Uo2aB5jbVjEi9P5D0loOfwMgh6nMUzUrXZ/YzhrO3w3Z3Fl
 wCjDpaKGaNV5bWdG0+tfv5g9fwUhO+nj1RWMO38UE6xPVqQvSgmMNiP3AUpSPWWq/JU=
X-Gm-Gg: AeBDiesZeyJM6H95UBvqPBzKJNEaqEqYPqG37YUHBfh5JOouyBRQ0GK8I/NVwNhxYbZ
 L62IL9/mXG1GIyvcKJr3O++I0qCSEEeyftpm06AM0xz4VT9JH4dBd2C3nof60fO2KYIr689M9E4
 r2qFfCZHEHlGG5Ry10AbYyCmTuVv4zs8t8QJuvYbh7YXww/0c5WL0nqGI62xZd7fu2auuBSjwtv
 DPimXseDT6VfF/eM4J0KKzksiM3WxDZzaa+JYFNFHVzuHSLKUI/77QYM880v5qFEaF8yClpB7pG
 izyXOt6/jSS+rfjDucDpyFBjAaMNi/8R5D7Qkc0MhLP8O/M2eNoWRGcWxwJ+zEce0xQFBi+bsus
 xtBzK9mW5EhdmPprOekWcF6iGoNIPxc1cqX7beCT59F7tgZX5IMwNGalYfCizA08ArHvxcwAU+a
 w5j/K8CfA+ekrsUkt+z2zSC1N7fbL3OJQH9zdpRi6VDbD3QRD5lFwxZXOHKusXMJGuY2iUikJAC
 IrYEayJxvUohRlVEzZn7xkVzUgnj/4n/Je0lATyW4lLqVmoe1oX6b8iqKBQ
X-Received: by 2002:a05:6820:2d05:b0:696:7697:6472 with SMTP id
 006d021491bc7-696979c9856mr7756033eaf.5.1778003849091; 
 Tue, 05 May 2026 10:57:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454d324e2sm13561561fac.13.2026.05.05.10.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:57:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260505125518.15795-1-marek.vasut+renesas@mailbox.org>
References: <20260505125518.15795-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <177800384848.2525131.12367262509071993145.b4-ty@konsulko.com>
Date: Tue, 05 May 2026 11:57:28 -0600
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

On Tue, 5 May 2026 14:54:17 +0200, Marek Vasut wrote:

> DT clean ups, Kconfig clean up, R-Car Gen5 remoteproc and watchdog driver,
> and R-Car Gen5 CM33 initial build support.
> 
> The following changes since commit 57460fde4ba84d67de4066ee1141e89e8139ed23:
> 
>   Merge branch 'master' of git://git.denx.de/u-boot-coldfire (2026-05-04 14:41:59 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


