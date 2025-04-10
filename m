Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4537AC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 01:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E235183994;
	Thu, 10 Apr 2025 03:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="peuj+Qux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0FC8399B; Thu, 10 Apr 2025 03:46:29 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B84883971
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6021e3daeabso142083eaf.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 18:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744249586; x=1744854386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3esFZJj7/PATJiwc2VoyFoXXlKTZhWL6v49LALFGQs=;
 b=peuj+QuxmI73xPzMcR1wksPgjWlY+lRXqRDD5NJX/uDZnqQBP0xkGEZRCQ60SpNvMu
 H+kZcVXQKuvHkQ+/LGygxmlQlkddIPe+ReJ6xAS4kE8lZ09jHIlQR0bqmMQpyyI6ZCYr
 xoFYXs2HwWoyHP0/3G1f+/ZSR6cWUHMNcu/e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744249586; x=1744854386;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3esFZJj7/PATJiwc2VoyFoXXlKTZhWL6v49LALFGQs=;
 b=b4go3iXYZMpGqCm+67dRDrr+SwJvYxlQjU1ZH3sPI4oOxGD37LAGDKUFj/AxH3ncDe
 1Yl3qGeuJVLgRcgd8q8WaPibV7rhpLpZ+Royka+HmKpOGkirjla34s9rdJIWAOYQ2UJd
 ZA3kngQnQw2ztLApccglsA1dDalX1jX5GnbL13vZlTx1FrbPpKNWbtlg34H9YCl6P8OI
 yJz4vXfQ+jg543dAUJb+lCcB+JW431H4vVBMBVM+V17VMECBYGEic6RsBS60eJKpQ3yf
 4lYsucu/COktrW16u1rSY2+OC3S33d0Y1Em/Eb9IKT+cy3TR/WcEnqwTZwEI0twWw/Ew
 4MHA==
X-Gm-Message-State: AOJu0Yxn+yi2H4GNJmTyIY2Yu9hID+lMd7nRRslZgcDiKGzyJ/wp2y52
 3wldkF6iRWCMqk/O317Fhrmx+B/MB9ig94OAJnCoFuV3tI5cj1N/z44DsqvkhOY=
X-Gm-Gg: ASbGncs0yQ4qJaV93yipe1kdtJcEsS5ZvUIqh4AruLk9PAdRvGsXey4fSdWQlTQFnM+
 5pOZLk6Xsp16AvJPGtKXIm+uI1Bk3+DONZE9Jy4Wp5AESzSlQQtH7ipbriqtp8hhFK2yQIIuqnE
 9MQRQQMOYbuW8yTpylagzhgMyP7o4JbfWUobrHra1q83SB2CR1oKJaDyAFHBiGgISl0YH81fGZ+
 38ybeOZDvUgO5RIgf6CGvEjQ40bO6C42yQrJO4fBIcVEZ9NZv5RN/58wqUTNpPz7wT3OKGv3+k8
 4vZlRbBp1QuEBqGiIUHd8xvosoOJxUkkrZG6B954/ONseCo5zBsL7ZTTiSclFhWFbT9Uc2b4FYz
 4
X-Google-Smtp-Source: AGHT+IH75jT0mUim13NLQvPEU61tfPpYOGeGWpRvdpa95wShIG+FoFPcy/Rj9jZUn2yu7Yw7iPT3gA==
X-Received: by 2002:a05:6870:6e0c:b0:29e:24c7:2861 with SMTP id
 586e51a60fabf-2d0b3612ecfmr546640fac.13.1744249585688; 
 Wed, 09 Apr 2025 18:46:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd3764sm474569fac.31.2025.04.09.18.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 18:46:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
In-Reply-To: <20250410003121.1818656-1-trini@konsulko.com>
References: <20250410003121.1818656-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Disable evb-ast2600
Message-Id: <174424958461.1824423.16565439652676009123.b4-ty@konsulko.com>
Date: Wed, 09 Apr 2025 19:46:24 -0600
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

On Wed, 09 Apr 2025 18:31:21 -0600, Tom Rini wrote:

> Currently, this platform is failing in CI due to seemingly platform
> specific reasons. For now, remove it from CI until the maintainers have
> a chance to look in to it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] CI: Disable evb-ast2600
      commit: 8a2cf6307a2ccc09c39dde486b6d9375b78c82c2
-- 
Tom


