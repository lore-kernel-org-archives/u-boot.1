Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E29CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCAF846DF;
	Thu, 14 May 2026 19:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="crnV2PDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC49846DD; Thu, 14 May 2026 19:55:41 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A0A846CE
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-479d68a9063so3152293b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781337; x=1779386137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSHn9DX1yR2tang8+43+01b/ryQxo1z5ZBtlVdM+vOg=;
 b=crnV2PDpbUU/QbPdunya5sYDdOhzfpS98Xrc5jcNaX5Teq95hu0dPB7EI545Jy1mbn
 N+YWETs6p0NDA03uH+G7Uv26evzm11qM0uoXyoHj1XBiYuvd9CG97CmRMAto77Q5XDRv
 8vElWWhZMvEHq3GStmMKsmTz3rMqzniPGmk6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781337; x=1779386137;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jSHn9DX1yR2tang8+43+01b/ryQxo1z5ZBtlVdM+vOg=;
 b=ojlaNd9Vi4IJziXd3CiiGk21tylJGcnuTAl5RT5w4+q6WLUPQ4ZEsK4URVs0mseBOf
 o8FQn+JhZM2QgTk3N8CmGHpTvqrD80JMPZ/xtB0wSl43xPBI+8szWhykdLD2nRpjpipU
 HU2IvOlTfClRpl07swsw2QNpZivPGTc3nVnxmDxLcc2C3HMml3i6JGvyG8911DcOydau
 x0RaJBC8Oz3dC+ND5fkSUYKFy22WRoLFkGKbRLXQuLYs/F3peoCyG7jxsLFSMR23Fyhm
 CHcipKu2R0YQ2oArkduvr8+/3SYMwrzkcb9oSJmQjYbD6htBx4rklya/6dSWLLJHIJkk
 eEZw==
X-Gm-Message-State: AOJu0YzOmi+Ac4Lj0GR2irQraDhm5VuCo4GjbY6GHt4LGT7KbYWs21he
 sUgI5gqzpAn/cLPjsSm7u6sl6CS4l1sF1HrNQPcHRaU6lic3sXBJnkdgCzcFbem21L/hfybTjB7
 e2na3Hferr/eRx5c=
X-Gm-Gg: Acq92OEhz60zEFSOo7Sqq1SY8erp3Xj3/29crw5WsdQgswHFObwn5/cFxGU8vMv8Zi4
 k/5UkyDNA22Akzax5sN/1n2vztaYXA6BLZr1brpTRJ6Ntz3ypAfJg1GJRsG7yE9HuHPrezNz6Rb
 SzSuYeM7jXoNE8TtMb3VcM7wbWmJTO33j2yO3ly6c+qIpiJvkcqcsooJFMJnzsugHa2GGAeAQUP
 HPbHF/Eu+QVvLsgUinDMuSN01AOCa/G/WxS0F7MoDO/u/hstOnDqTudiOLRMnmHn5xJJ0DiNBRb
 IcODRMXcD8xImA6hhBdmXIKQMTr6z3JmY6fD2sD1XrTfnvBEcrjCrhQL9Xcv1QeEwVuG3edlEEv
 KxXXYPn2UVeuNu/bGJmrotY1Wn8wm9cs4ipgZs+7G/4eCE1bGdqvWDtThgdkHnZ3trxxO9846Mb
 QWAclt12eqFqnPO/I6h9IgrXm3QPBIpgPKCD/DEb/1gCePeLRjR6N1IgLr2VCbM9p/dA4+fKw6H
 YXf7grdb2L7yopeorU+3welP9xVJAN92OjOy5q73kvELKj2gA==
X-Received: by 2002:a05:6808:4fc8:b0:46c:e542:cc25 with SMTP id
 5614622812f47-482e55e6130mr336035b6e.9.1778781336982; 
 Thu, 14 May 2026 10:55:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc53f2acsm2401711fac.14.2026.05.14.10.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1f922957-e56d-1187-4441-e98e9f8fe25e@nabladev.com>
References: <1f922957-e56d-1187-4441-e98e9f8fe25e@nabladev.com>
Subject: Re: Please pull u-boot-i2c
Message-Id: <177878133626.4050569.62323641465627540.b4-ty@konsulko.com>
Date: Thu, 14 May 2026 11:55:36 -0600
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

On Thu, 14 May 2026 15:36:51 +0200, Heiko Schocher wrote:

> The following changes since commit 36d4c653580824b16574560b21d4401614d8b68e:
> 
>    virtio: fix return value check (2026-05-12 12:38:49 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-updates-for-2026.07-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


