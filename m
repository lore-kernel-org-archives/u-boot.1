Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57895D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDAC84459;
	Thu, 27 Nov 2025 17:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YpaTCcH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9728443A; Thu, 27 Nov 2025 17:55:47 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948BD83B4A
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3e80c483a13so251629fac.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262544; x=1764867344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzoECjDWx1Pe5DEU/QVa937maoeStl0clfC4oOsSXho=;
 b=YpaTCcH0Eawb92sCd+7m70ANkW0ZRrqz5UtcIai3XxmsMBrWs9Md1RaQ72QcQfNx+k
 YoNsm1QLSIebdOHOyqSTDAD2wkTWyggQ5e7r4VQJ0/UBz02XfTgBotYpUhGtVvJsC1Xf
 +yyLpXGO3GzcxmaZI0CoC4L9oK3ED7A3IZ8f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262544; x=1764867344;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kzoECjDWx1Pe5DEU/QVa937maoeStl0clfC4oOsSXho=;
 b=UV+DGTanuo4jlnGNulFgClpxIr1Ko7hecWjchUYHvpt9i3J2o7/jwVC5azarzL4+X6
 wHxGMnQA9RC1z/DAhBb5B1PQ/LITGJtKTQg7AvvrH34ZK0YiZpdbc7W1CihhWSsPBckv
 lhTUhG7kNxDHIyS6GxDFVfocKV8iEQrZRfPzWdNK+mLkKbbYUmrxDRbcH3oJHldMjOx4
 08RUO6tI92/5yYUJgsBrCSRkCyWmQiuZMrbr1ihmCZN0ByWDWscvhLcIu63VPd6TOv0v
 2b3QuY4O5fep9oWrum1VwdgqtGzeuOb3gGARm51wZ+HPem+Ilz+vC2WhW67V7j61HYr+
 KDeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgVdq+a2yvs7m5s9dJp1diksSCAZJ4A+VdF6QZYHrz2rizTrstrLrgcu54OBv8nqp/Pwbkm6o=@lists.denx.de
X-Gm-Message-State: AOJu0YxrXZpnDr3fDEwktdS+XPCsaOxRp4UQ1U7+xNHjobwYnNRi6/rf
 o4prs7pegaOc7xNay2frahbTCM+qts8rOG2aetSOprKqzJO9ei6YluOkKQzcL12dM2pczXHEYXi
 nt3BO2P4=
X-Gm-Gg: ASbGncvtPrN1igugYu0xHc+CFprEZvZci8jd5+qpFyBtgNZNvDbulLezUXSaW1YoZea
 nyLmPsBISekytsGN8YfgtWlaMZdhQcsNCoL7b7thMNMXzRLskbc3OVx7DDik1TmS7rPazuKsdn+
 Fn8aTpJyARS+ib41BIRQz4UOuFiqUXA1RjyJzMLuCfHwhvtRhH/Vsjwi0SComIe4K4kbBO/jqDW
 Tsg4yhh9qetQLRAFzoF9kmr4vhvrg8j1oGkzIIZfnejUuaGmuBorj/EhRw4nKRbdsqgCC5FhBl0
 6yY52YJaR1Ph8yfw3Dw8Ra8kM4L/BzHEoRmIwKYWmaITL+Aolxh+a5d/vCifhS2mXWaWk4BwWr+
 qAFi/byjsaBi9uVL+m0z/uD8JyuhVdj28NGrHQsScQWotmwvJhdK+rcsXsK9kWHsSt98cckCt36
 TPl7ddhC2I3frvTPUAq1YOK4McCLestlW+xha3m3P/hxwn1tsO
X-Google-Smtp-Source: AGHT+IG/l/9uP7uhjZSGUAkLIC+NUao7xZfTyJ+3CL5exaGl8NdTbdPK2tEOEfwpkMAr/pUdWT/4cQ==
X-Received: by 2002:a05:6871:7a7:b0:3ec:5e8e:87fc with SMTP id
 586e51a60fabf-3ecbe5639f1mr12920344fac.31.1764262544338; 
 Thu, 27 Nov 2025 08:55:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
In-Reply-To: <20251116114153.118217-1-heinrich.schuchardt@canonical.com>
References: <20251116114153.118217-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd/extension: avoid NULL pointer dereference
Message-Id: <176426254356.4117678.6221981127942600299.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:43 -0600
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

On Sun, 16 Nov 2025 12:41:53 +0100, Heinrich Schuchardt wrote:

> extension_get_list() will return NULL if there is no extension device.
> Check for this situation.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd/extension: avoid NULL pointer dereference
      commit: 642a9e716e1e4ecfa64e01a81e815b74e9c142bf
-- 
Tom


