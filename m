Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CEAD1CA13
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC57088F95;
	Tue,  5 Nov 2024 02:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ny2WEaV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB89C88FAB; Tue,  5 Nov 2024 02:07:08 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858AD88DE6
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 02:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so42301526d6.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 17:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730768824; x=1731373624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2qbotmHEfonnEIj5tDgPL1N3ErL2rgPWDm27YTTdXo=;
 b=ny2WEaV01t4kfHD8UlglexUxutV+wtVpKXj/PbWnIzcdMUV9VG6qCRvx2C9T7Ypwe3
 lb5wNqGMt+qsX522nfp2FRwBURyJ1LVcPfWO25MFCf2PGKp6W8c93MMD9Vckd8drCtLu
 md4mDDx+hvL4MscBUiaI5Vw90/rfmgEeay3JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730768824; x=1731373624;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2qbotmHEfonnEIj5tDgPL1N3ErL2rgPWDm27YTTdXo=;
 b=j6iTVxrVf7lw4Wb52xKlWq4ayx45oRtPmpsZiEslpzXue8JLuLQhgwXb/elzrittc7
 M0b4R/8YKAdWB0Z/EkMgrKIS7kFxZHeXWpbaAhonrHaTSJ8FgaXGmC4sfkUdZc7MCUqZ
 Tc6YhPP6eWZ1VucX8E5kXfStPhZ7r5sa2yDX3Jx/8Ut1WkG/pZNLRmI4fkYBoUzpO6n8
 VdnSq1wAv47VGAdr3dQfhBNcQ/MkHEb4791c2OIrgDdpAJVydIdMupAGPSUG76PSRczf
 Rh0e74KHRXH5fKs6w8mtEy3Lf6J69odHUSvZ7sicA7U4nywuPB1plulK5LneTFuls81c
 0ZPQ==
X-Gm-Message-State: AOJu0YxgBEj+Zy4TJadDs7CyGBqjCrLk3cLWHA5bcrOgEP3LLfIAEjWC
 AP+boDKYCddidKjNYpajpzhp5dcGTl32SShh23+PewvEPG3JEOWgrXBcDVf4oV8=
X-Google-Smtp-Source: AGHT+IEBKcECxBd0Th6VNgr+RvopVmaMorKuohztka6iKa6mSMky5IKYeepIJvHUEioZlmytVa5/Ag==
X-Received: by 2002:a05:6214:b2f:b0:6cb:f72e:4eb9 with SMTP id
 6a1803df08f44-6d3542b2fdemr229180796d6.11.1730768824421; 
 Mon, 04 Nov 2024 17:07:04 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fcc777sm54436686d6.56.2024.11.04.17.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 17:07:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241101130254.473017-1-andrew.goodbody@linaro.org>
References: <20241101130254.473017-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH 0/2] Fixes to allow 'ut bootm' to pass when run
 interactively
Message-Id: <173076882326.3917422.16674115782247398447.b4-ty@konsulko.com>
Date: Mon, 04 Nov 2024 19:07:03 -0600
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

On Fri, 01 Nov 2024 13:02:52 +0000, Andrew Goodbody wrote:

> Starting a sandbox session and running 'ut bootm' on the command
> line instead of using pytest with --verbose will result in some
> test failures. This series makes the tests more deterministic so
> that they will better control their environment and hence will
> work as expected whether or not they are invoked with '--verbose'.
> The series starts with a small fix to the parameters of
> bootm_process_cmdline that one commit incorrectly added using a bool
> when it had been updated to take flags by the preceeding commit.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


