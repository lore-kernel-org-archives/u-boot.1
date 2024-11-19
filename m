Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7E6D4415F
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE21D895AB;
	Tue, 19 Nov 2024 14:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a2wndQ4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1811A895AE; Tue, 19 Nov 2024 14:53:06 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95460895B1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6eeb31b10ceso4891427b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732024382; x=1732629182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cI8LkW91XZQWeIqbQDaABiSYGNBWih5z271EijKKpc=;
 b=a2wndQ4GkGrJbRQdzU+YLLick3/4CIyZq46JssNgpM6V5eE4vRB6k+xsDYyoUmlINu
 /XdcON4qQmLgC39XsVXq4oot0M43m6mN5Q77MPRA/f41kFUeCqlfg2H6mbWYX2oFhuBw
 lbI3ZvaFdYj+Jc2D+wSvLR9SBwQPir504+Kl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732024382; x=1732629182;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cI8LkW91XZQWeIqbQDaABiSYGNBWih5z271EijKKpc=;
 b=jlc57B713sB0Rml0m2RA2H/oEN6wgD9MpeXs07w41uZXyP9Rz/cPN5Zj6vNcJoTgPb
 7tu0z4WdCCPpHwJqdVgofBBoe3pKelRySgjrTMgWcMJdeozK1pf/oD6Sn5eNZzaw6Xv4
 L8/LjLcvCMpDINNcVH/7RvzY/Szy4mngErU2zQdFRDdjidFET6OWm8Ymcsjn0o8nEUud
 ma9qixOnI128CRrcbxsPgBBkfATnL7YNNQSg41J68QH9yKzrmKgNnofqEIbbR8CP9Xlm
 wiGs9pARDWjAFu2zwgoUR3IbGUZeGemifWi2XQ18LhYOBHjO4CnW0q5qRnq4VR1QQRk3
 c63g==
X-Gm-Message-State: AOJu0YxtRbRE5ql7MwK+1Eq4qzIJ43V+qVlwJ34g+ouHYNxav2l7wMoI
 SofOUbzbT4DF8sOcOqvT4QWedCGhmv+2iS32peNmh5+4/q91J+Xwq0ndn87WZSs=
X-Google-Smtp-Source: AGHT+IFrUCPNPzW/opkb8LGnBKdRl33dO/uAzxvjQeknL8oBDtv38FrYnoJXWKEgHnf81LfRUvq30A==
X-Received: by 2002:a05:690c:6a0d:b0:6e2:fcb5:52ea with SMTP id
 00721157ae682-6ee55ca3765mr176966967b3.29.1732024382511; 
 Tue, 19 Nov 2024 05:53:02 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd23291sm48507786d6.81.2024.11.19.05.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:53:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, Marek Vasut <marex@denx.de>, 
 Jonas Karlman <jonas@kwiboo.se>, Hiago De Franco <hiago.franco@toradex.com>
In-Reply-To: <20241112154429.1532647-1-jerome.forissier@linaro.org>
References: <20241112154429.1532647-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v2] Kconfig: describe NET, NO_NET, LWIP_DEBUG and
 LWIP_ASSERT
Message-Id: <173202438064.3483935.16413185019140846223.b4-ty@konsulko.com>
Date: Tue, 19 Nov 2024 07:53:00 -0600
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

On Tue, 12 Nov 2024 16:44:29 +0100, Jerome Forissier wrote:

> Some Kconfig symbols introduced in commit 8cb330355bd5 ("net: introduce
> alternative implementation as net/lwip/") need a full description. The
> NET symbol needs one, too.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


