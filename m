Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C91C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD12588535;
	Thu, 20 Jun 2024 16:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBf5LQHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A31E28855B; Thu, 20 Jun 2024 16:35:32 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FD8C88550
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-259884ef4ddso462654fac.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718894129; x=1719498929; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEVVDsuq+TTUVm8XezY98YZcj2ABJXWBIamUjsvtGyE=;
 b=oBf5LQHLbtZgorquVVInhSQuCyLie9J8l2oTiDlAbg7uBM+iht0UA/+qfXq5KfRHxw
 /yN+fCXEzCNzhVOTQBxx+inWxoGIs5k5vC3DHCHQv7rAWNXU3Gc7jQcUP/0v0pYiep81
 /mkWAjdLacAp0BrplslwXDLqMRSoTA9RF5W7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894129; x=1719498929;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEVVDsuq+TTUVm8XezY98YZcj2ABJXWBIamUjsvtGyE=;
 b=Sou6r+NkIimIkLwcgCFmAnEp7QqLbVbGSAJAkQxyX1YhLina6jrIrZm185lOKqhwIr
 vvTXH6+TeL1s+IWuILHRKeDZpHukGRJZM6FtMYHYhZZP7iP+j+Jfs1U1o2njSMp8E/la
 mEhdz699ubg/EWHhMcEpA+RrJmb6U3N3x18vlTaZb9hzQpy+bYdDX7kX6UaMc/TkOsja
 vmRgprvzfHq+YQ27K8dMQS/Q6j5nXeiOfZQVkYztv7AxxRzwFT62LLZ3w6I8rEE1axg3
 XfNDsBrNtRx++gIq1A7UZ7GVDGkisG7gqf4dSTEL2kmYjBpo6Oyzgk9HhGlivQEoBpMF
 tLVg==
X-Gm-Message-State: AOJu0YztHchg3UQ+OyYH6D8ahc3lomXpLZyvZpV0rhw4EfmtJiOlKrJK
 avrnXDG6UgGiXyulAsqCnJ4la+B/d5tP5oCszvSxao6S+5cjACxXHmtdV8lTXRc=
X-Google-Smtp-Source: AGHT+IHINbOdsdqkwk59s4ESkZ4sSUgjGqWWDpJX7qI/b5iL2nchimD4flrHPDc7uBzwIiTKFl1Phg==
X-Received: by 2002:a05:6870:1645:b0:25a:eca3:6b5e with SMTP id
 586e51a60fabf-25c948f40e5mr6329903fac.9.1718894129185; 
 Thu, 20 Jun 2024 07:35:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cc7165817sm176573fac.14.2024.06.20.07.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:35:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Simon Glass <sjg@chromium.org>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Nishanth Menon <nm@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20240612110749.1699824-1-danishanwar@ti.com>
References: <20240612110749.1699824-1-danishanwar@ti.com>
Subject: Re: [PATCH v2 0/2] Enable ICSSG Driver for AM64x
Message-Id: <171889412796.3544072.7944394681653850274.b4-ty@konsulko.com>
Date: Thu, 20 Jun 2024 08:35:27 -0600
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

On Wed, 12 Jun 2024 16:37:47 +0530, MD Danish Anwar wrote:

> This series adds config changes and env changes to enable ICSSG Ethernet
> Driver on AM64x.
> 
> Changes since v1:
> *) Dropped the patch [0] as this needs to be fixed in driver as suggested
>    by Andrew Davis <afd@ti.com>
> *) Rebased on latest u-boot/next.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


