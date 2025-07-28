Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F2FC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 14:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441D382CBB;
	Mon, 28 Jul 2025 16:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GZkFUoQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A994082E26; Mon, 28 Jul 2025 16:10:33 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6898A82CA4
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 16:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2efa219b5bbso1229679fac.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753711830; x=1754316630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+5xZ6FR0cFoLC/SMHcsNO+CNhHzBkWgGpyw+U+p4KGM=;
 b=GZkFUoQgein6yqgdwnzqiYtRANmkCv+XITeyyeecwe4ZoCJaBMrMuY3mlsuGY8vThM
 MaUJ+4fUG0el3RCx4l1jQL3X3AFq02u9TS/+drUJRcjpPKkE8RYfxjgVXxpW+kUmOJGi
 VzD9sV+wngqvwJ82FjHkRUT/Wu5JUub53msBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753711830; x=1754316630;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5xZ6FR0cFoLC/SMHcsNO+CNhHzBkWgGpyw+U+p4KGM=;
 b=vzpcixoTBECbTgCNcxaFYZPY6tvkFEBTCjP+NotovX2ou4/dlu9ikKqHMepDvD4U25
 d+WrRmTjaCAo8eN5apr8dHXbl8/h/8dW0f94ST5VQ/D6gvL1rBU02GVuT3NpbqQ5Dl8M
 7G9Lv6BnWwakqKwqE5JpMz68/+TOPQ/EpbXpcOKeIrG+miiC/K3E30h66T99xGWb0m7W
 kj42f1rj+MT0S1bN0nEpj50+3EiWc0p5nHF44OCSeyDNxYW1Zvl64QQMyiUKkBU/di0S
 lwBAk9bDpzeZqI7B5kjYtBU4keMMc3GW3m1RhGML882bHwN843HsoZNK80QEvZBF5Ou7
 ijKw==
X-Gm-Message-State: AOJu0Yx5ifIKJpSPlLjePkY8gLJ0oRXBDJBaYD2eM8AruQV2JPWI1Rtd
 H78WWbwvLhBe50JmQTOzr6vFA0ik1O8p6B1nfSIBrQtDBICmysUUpQxAe6jvMJ7rp1g=
X-Gm-Gg: ASbGnct5grfZTK9bgsmXHqZyBaAPa+jmvWVsZ9jFCmbmGWqP8qE0JMF997wUbf0G8kH
 SURN/R9vSbyBpl494rgeyoc+InmpVGQqQUNQxrb/vc2ksHR/OPEA0Qq6VNQ5JmLkm2Ieb3KqA5i
 S7jhMS3d8Oc50vNFeiEhrmpEJniRTSXyXjDMqNT/5Qw44wJMXFF8G0Blr1xiCNAyMcx6SjwmU/h
 bl71TQLH+VKwnCsRbUgittysYAKnzg/ZLP+XbbUQzMoHlmyl/7HUPLl3ggFVNOm47B1jnZpPEYX
 2ut0tZh7DQ47SgXvZsYkwLhUzgoIO9Lf83XFqpBddE8WwRMkZbDuTf5GXHSbnzfb7ncq8JKakD2
 WYqNSOtXudK51CVVxA163W9f3K+bx/9TpwKAIKKrfacdSEpJEH3TGvnJ7/MlTi6dyjQ==
X-Google-Smtp-Source: AGHT+IHVz810xzvEjnN2/KQfRD+hk9eyzfDqv8cna6CBVtbAUGUFK6wZQetW5lCCCk1l2F/u0rwIiQ==
X-Received: by 2002:a05:6870:b41b:b0:2e8:eccb:fe1c with SMTP id
 586e51a60fabf-307020ebe2emr7666721fac.31.1753711829084; 
 Mon, 28 Jul 2025 07:10:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74147f4a38asm1036274a34.5.2025.07.28.07.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 07:10:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
In-Reply-To: <82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com>
References: <82725079ee90362468fe8096db24ef2959725af9.1753181505.git.michal.simek@amd.com>
Subject: Re: [u-boot-test-hooks PATCH] travis-ci: Wire MB-V targets for CI
Message-Id: <175371182788.356508.11888113515912214299.b4-ty@konsulko.com>
Date: Mon, 28 Jul 2025 08:10:27 -0600
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

On Tue, 22 Jul 2025 12:51:45 +0200, Michal Simek wrote:

> When QEMU v10 upgrade happens MB-V targets should be wired to add them to
> CI that's why add configuration for it.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] travis-ci: Wire MB-V targets for CI
      commit: 6e697d557683480c14934f96d72a2a5ef29b49b7
-- 
Tom


