Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1AECCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D354D835A2;
	Tue, 14 Oct 2025 16:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nyi8HemQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D31F833C6; Tue, 14 Oct 2025 16:20:39 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC419833F6
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso2514520fac.3
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451635; x=1761056435; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DGXeGJnr6wdikNaFMdrGDBrBs733VfLThN7w0rmPfS8=;
 b=nyi8HemQVm0zyFJRS32Q6XxR/jcifhkcPibVoioqH32EkWGnZEixHSr4fRbgTCr8Zw
 jOWXav19cNZALPRZt8ifRxhQ7r4Qj+K7rj5JGcGlqOKnjn+ekvBu4jBL2dl561AIQslD
 qhu98OzZBJ0zr/xYVGrz6U9AYhk7o7iBo5x4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451635; x=1761056435;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DGXeGJnr6wdikNaFMdrGDBrBs733VfLThN7w0rmPfS8=;
 b=E/KJ/FNMNJk6hwWrlRD8ddVB3vgo2z2puiHj1Bsfizwq+nr0axMCXC7mJT4HOTuslN
 I7kgThp3kpoPuo0bcNyrb/3KFkIfSGD3FxGn6vdU3nMp7xq6OUYX6A1+D9Jjhx0T88Vb
 mZwNxIZUKPJeigvculrMN/v7rs1FrMvut656ih4bbCGct0YmW4VFSJyLWndfR89sHJ9R
 dB8tiTC/WELM1TtQGhu5DYfWNP7Qu68dxmQnblQoODVKEz/PoHvU26K/C5RTiM76km22
 dzsEpH5nIqkn4RiK1q7miZmRtZXwMRIK1ZirCdFm9Ql3yqMy99Dli9o8ceuPVvhNoSlT
 VG8A==
X-Gm-Message-State: AOJu0YxIDfwdGmk1rItMKF2ajGLmXE1Z+ZsXh+eRp4p8Men65zsGOy5D
 Sc6CY9FomzWcsrpPJczMQO6nMWA0CvT6zWhIi/l/RfJD4yhCp/ChjTJPJs3QDmJ3OT0wtHawtDx
 nI171pCY=
X-Gm-Gg: ASbGncsMgHcTSc2LIMMCiJaU98P+loWHlPGZzdsGyxzsV5tlTyFh/YCs0RqqNVmQnBp
 C3lp0p8CK5igo7MIvSMjl1DXRn8I+zFkLd0sSmlv7V99pOo8tMm3tsqQZlHiDTZydw98lGPxmfC
 aXudBcs8wnzgmY5zDtUVaSFoBH3bNkLFMNrdJSMYBAEAtOeDETB8ExutO8F/TIq2XzcwQQ4C/2B
 3OZ4VQYvSMSA/kPfib5GVTpAyPS2xI3Txbg82TjbirWDDvQmi5Ms9KZWNGzBJLwKFJIW1sHFsZD
 eVbQ4P0o2oOBnRMIIYEcGWmF4WSvXSqD4AiTsjCPwByTIa/cN/Gr6nedkXDUWMKJHv3kVH7EruF
 zYlJUSB/WVwbNJM3K6GwwTaNlMBqj5RZ6Y9OICgK6ShA3GxAlWLltcIa97pUFLzLCTnv58nXsTC
 4YFP6Kfo9j2YyCLy84nHafhmLP
X-Google-Smtp-Source: AGHT+IEDhoNfwAVRlEm8g24XWKGZVQikAY6dH8XARPUTsAk22Gu+l194SgBxlCE3RFjKjqTW75RrBg==
X-Received: by 2002:a05:6870:8899:b0:396:3593:d1aa with SMTP id
 586e51a60fabf-3c0fa754970mr11609054fac.43.1760451635610; 
 Tue, 14 Oct 2025 07:20:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251003203934.1030125-1-trini@konsulko.com>
References: <20251003203934.1030125-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Disable xPL phases when we have enabled
 COMPILE_TEST
Message-Id: <176045163499.284655.12410169172567134362.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:34 -0600
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

On Fri, 03 Oct 2025 14:39:34 -0600, Tom Rini wrote:

> Due to how we implement the logic for selecting what should/shouldn't be
> built in a given phase it becomes extremely cumbersome to make these
> phases link when configured by "allyesconfig". As a starting point for
> being able to enable "allyesconfig" and expand our static coverage,
> disable all other phases in this case.
> 
> Future work can be done to enable other phases as time and interest
> permit.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] global: Disable xPL phases when we have enabled COMPILE_TEST
      commit: ee7d07f9d00eeecab6671d8db2c8d22cd8b13d89
-- 
Tom


