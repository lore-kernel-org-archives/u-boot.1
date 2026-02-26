Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9623DFD8FD3
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1FB583AA9;
	Thu, 26 Feb 2026 17:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sfMasRCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089D483E83; Thu, 26 Feb 2026 17:21:25 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E18FA83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f10d7eb81so423669b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 08:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772122881; x=1772727681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylAy9gv4Up7G8nq4G+qhfmgho0VwZovrzn6CLk1G8Us=;
 b=sfMasRCaeSvKvMQG1FJuVbL8azpJkkr7No0CYJMK66OL7j0mnlKPWGgt8sNq52Ws1i
 ViKWCF1nNQJWlhJl8ulCXXF4WJ2CEds+QQziKz9OpPVWliFHc3erhO+UyrBYLCovc6IB
 De2jx1avAwSFqAgzKMLAaVZOo9PXa1AgEjeyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772122881; x=1772727681;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ylAy9gv4Up7G8nq4G+qhfmgho0VwZovrzn6CLk1G8Us=;
 b=laSbNigkJ+Mb18cKhR3M0yWJkz7JQwEubjkDTx2wXxcaC3Yw5onGWTpLxUEzFjScXQ
 2LHzmOvW/JZpzSBSfpcnub6LjWENlkD3QBO0QZjZ5kdtPTZ9bkSu+e+rcKuCmFG6C4MJ
 nGB0jTZLaGtPuskeR4CbBH/WzgjJTlTc2QNPmIFW3P57oPH47JDdykK0m2sBN7iqZDLE
 7AG7pbbEXsMj70ZzgSu4z+4LwEoULl5tuCGW34yjEvabza8/GjPSrMKP3WMUe8Y3zQhy
 vjt4KSS+s+1UrB6ACHjp5unXh+FmRprqRaele3S3rrNl7vRRRUOWYhLb4BkJ9WtGSPcw
 aP6w==
X-Gm-Message-State: AOJu0Yx9Vba6NqUt4M8pjRdWH0Y4sxUX5TwPCCRa53EPf9wmpDosTqyq
 oz4umEc+yhpU4mNFiDE75co/HtlTcfL6PatHdUYxfAGWkglNSGbIKXrhaXosxwDdEnfr3tqz5fh
 uSe1G1Qw=
X-Gm-Gg: ATEYQzw336rbmbiGY0sYIjLOE7nV8GFjrhNUyaJKScRuvljXpl0bKZOnk0O92I7ccdZ
 oSbC39zMnZCMIpAYTsn6YxnxcD1Vew7nNyaqkX3FCvqu1lqqeI8WtKVFlgUP9imvcQkji4NGJqc
 ikM1VfesbhbRfzDt0UPlALHZ69iWxaqQNBDP/TsrfE28QCvk9mte50qeyO1laPHfmCKpWWAu6ms
 WCaJpEXfb7F4mFTEVRKzOvDo/qMbl8etC6QVTbEU0Tp3E1IjfaQDqeWalyLh03Z3Y1pKx1ENl0m
 gZH1msJMqXqTYDuAiklYgVhzKDr7yFPd7FFrQNwFoLWwCRF45PYAml1mPfklJJEtQdX6XHWoOoR
 haNvS9QDDFT+AqMORl0UnpULIqAWhDeDY5QQtirLkl5Shvm0H2Ik09n0ov5m15I/xEGi64wNsQI
 sg+IhT228jLZ6OLf1LMaYJq8ZRgxxvtfv+Iw66i/V4x7NRCk7/8HWpz6uu7PMoP2xofu/Z90B8z
 8vsdO9c2O0MBCh5wZ5UW8lJV+g7PmGFlOUNA3RIFpmLhFIMOg==
X-Received: by 2002:a05:6808:1488:b0:45a:5584:9bf6 with SMTP id
 5614622812f47-4649ef953c7mr2220402b6e.39.1772122881597; 
 Thu, 26 Feb 2026 08:21:21 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58666ed17sm2203944a34.27.2026.02.26.08.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 08:21:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260224183107.124914-1-trini@konsulko.com>
References: <20260224183107.124914-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
Message-Id: <177212288064.15829.14919862925041332836.b4-ty@konsulko.com>
Date: Thu, 26 Feb 2026 10:21:20 -0600
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

On Tue, 24 Feb 2026 12:31:07 -0600, Tom Rini wrote:

> With the change to regularize the usage of TEST_PY_TEST_SPEC in the
> sjg-lab stanza with commit c7f360f20d84 ("Gitlab: Rework sjg-lab calling
> test.py to be closer to test.py stage") the leading "and " part of the
> usage under qemu-x86_64 wasn't removed when it should have been. Do so
> now.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
      commit: 437ea9f8be5afaebe2d8cbab6242f1182857f21e
-- 
Tom


