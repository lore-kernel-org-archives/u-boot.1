Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A820C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D668193A;
	Mon, 17 Mar 2025 17:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="POU7DGu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B4A8168B; Mon, 17 Mar 2025 17:16:11 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E8E811DF
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e609cff9927so3236570276.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742228168; x=1742832968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+WdsIzAcOsZarjEqN7AdeXoWks98wfpQWS2ihksWXJE=;
 b=POU7DGu5SYt+Y1JFdtYQEPJjQTzatY2cSRZDJzLgcnNT2yBcEhs/PpPZeM8cryt8jT
 /up8AblR7Zb+RDlM18tAO9VX27ddscJwc6UfowbJ40LyIoac3c9yhk9jkCW7K0FQlKKf
 7PG1NLwP6658Yp/PKAdPVCUgPerruKI8+zIMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228168; x=1742832968;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WdsIzAcOsZarjEqN7AdeXoWks98wfpQWS2ihksWXJE=;
 b=cae49cGSUb46RtC5vv0MxwTQ6DLlg6ztTUqcA9ZfpW1h3oNw9jPNqiwwLopY4v4aI+
 cTiLw78dDJYCg2oI3lD530UYfAHlwSRtO0Krxx0zJR3OlUfbk2rAbH/l4XF8f7vygIS1
 sbtNco32DLx9LFf/wngw8kE+RIKrqcdDWxNPWmKyRHFojEYLkXCHYc4IbWy1u3X7wr3r
 E7u/fGjttr/Yi6FwIZo9XB2fzTmKKNwKAQbj8B7al7NiaeY+nmgFYW2H/ghq1oyt+npU
 Hw306+FU3BMRJgnqJ5uYWKuXsoExCAJSiWSccr9gUpqK5AaCb3XvxpIx0otwDtenG+le
 miiQ==
X-Gm-Message-State: AOJu0Yys1EfCnb5wjoBYGc1dzXlicMDg2Sx5fF6vTiHQWO2lEJEwwf+D
 Lf3+MX0tV/PBfGX/1noigu52wFipOjKEafRwczDQD++96GNM1IxzP48zsqJhob/BZM+jY3AqzpW
 8
X-Gm-Gg: ASbGncupzayeMIe8e7qqOKBJ3C1EgfELv/Gb7g2fw7Xv4+RD5JMlHkDU3QIECEr1c+A
 SzWxiyq6CqSsczkkIpMXa//YbqS7/pPLQ7PTxK5oez4hNEH7bxcsII/nX6EQnisiZrWDAEPZEOd
 4u+RJTmbDDr7PH0uXFrkyNqYZ0YpyGcbVTeZmGByR/69XjxEneZuBMGFFoFdvQL0Vf9zl+Ud1Cc
 mIoQzIiZTXXCkZSYuUZ29wqaqFMkeWWNP5wRfiyZVh4fyvI7VC9EdlpWCSW+gEqG4MD4AF70h1+
 yckAYDmEcRPmqNII4FTtLK0xbLKwNbWICXSRytGGk4wT
X-Google-Smtp-Source: AGHT+IFY+ncs2DsnwoyaExTwdEtnYb2rz9cMFf6yOqFFBJ1SDKAFpoje1BJiZsNGARrsb6ox1SU24g==
X-Received: by 2002:a05:6902:2385:b0:e60:a3f1:b13b with SMTP id
 3f1490d57ef6-e63f64f76a7mr16933059276.18.1742228167873; 
 Mon, 17 Mar 2025 09:16:07 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e63e50d2b6bsm2322155276.0.2025.03.17.09.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:16:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
In-Reply-To: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
Message-Id: <174222816702.1613115.81416553052869580.b4-ty@konsulko.com>
Date: Mon, 17 Mar 2025 10:16:07 -0600
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

On Thu, 06 Mar 2025 11:12:30 +0100, Michal Simek wrote:

> U-Boot version command is no longer showing information about GCC and LD.
> The reason is that version.h has been removed that's why CC_VERSION_STRING
> and LD_VERSION_STRING are not pass.
> Values are generated to generated/version_autogenerated.h which is sourced
> in version.h.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: version: Get information about GCC and LD back
      commit: ca3bea3fc415ce40dc58f1bea9327f6fa12928bb
-- 
Tom


