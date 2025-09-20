Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C5CCAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A094A832DA;
	Sat, 20 Sep 2025 18:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="szWzOsOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44CF18003E; Sat, 20 Sep 2025 18:01:37 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94CA82B07
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-621cecfcc04so1614024eaf.2
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758384094; x=1758988894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxPvhpcyz1OYsVOAdG9J2L1EICOSAGLXjuB753wth8Y=;
 b=szWzOsOrNVM6JrbU/e5Oc5ZVFSAKFeuMTFsycX2RbchKxfcSHTX0uJYL7KK3iqS5xD
 g9jqQwBfevmDni6nIn/PbPVjYcH/UgjzkNF3gJ2k2Sr0tmy87QgxO9ixR3cppRXu52ce
 s1fYiyxGyNTTOeme5GEFRHEgptpaXAMWpYqP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384094; x=1758988894;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxPvhpcyz1OYsVOAdG9J2L1EICOSAGLXjuB753wth8Y=;
 b=O6Y5zCtaq5hh14TnlQP6Rdnvpnw/w1HGB+j1z2wXiGBDo6wV31BkPFuhrfRircLWQ1
 /T8mUecufnYloxOF9N5doickkS57kaj3VfPwAVGvTDB1S8DmRhnuomOJkEvA7Yqymitn
 k8DZTUqcOFi2vrlYHS+esvEmTS9dMxzFJCggZERHMdmDfF/4BG3pD5CIBrawiIS+rdut
 7gqzz18T9QIc1SJD6RGqPH3+boZ4qLmgCz+GU3pXTR5pY2KDctkU5mV1y5z3+QPndV0o
 q1dPN6IzN20uo2DyVWAHdV1ORV3jmnAHQIhEmXGyBIlPMiRHzHKbXgqDe8WJGO1myr/1
 voBg==
X-Gm-Message-State: AOJu0YxC4/n9rgwqe8xXWRIqyD8AMUKvUBZAs0/k3my4hMv/57ciNMlS
 wdELUqTiheEiKmRmbC7gr31FinxpQQOOCAUG1/Y4ImtHCLgY8iehJ+OYLUeDcWMM0/g=
X-Gm-Gg: ASbGncu6CTrWiu1/NeJtwaxHHE00T0MnbZxLWfDxO0SJClRjnG+WNg6SuIqF5lUwbAw
 HAFUkYc8klPYXYz14M1vtUIreBhd+9ru55fatNL71EpPi7OmU9HwtLs8TKDyDpDzmI/jjO/Yvs4
 h3vYOQtBDtaQvLYb4PfadBHuHP5/vxKqba0hZWjqm+lSnYOhEzRBhFFbMKvmcB9gsZPib+A44lv
 Lsjjm1vfsvGEfqgqieA2uHDUbhhyAyeQx7LCZkQWyLNqLudrYgEQ8t2lw3AQwQvuJ2fiobg5eKL
 OR3mWBRzNaYV7HDE4QhULHFNMgIW7KuYCRTmbNso2AgXZ102H5tD2yvdixIqXLenRZiH5CcV5a2
 Nz8Iet/ZEWnXPop77W88sq4/kIYCeCgni4TqkFZMTqwAWgyx6wD9y29Y=
X-Google-Smtp-Source: AGHT+IFIL4+U4dGQ6S51ydDnby0MAXU66bCsBmcKOntXAQG67zzrqmfCI0IL6abibdsxAHZim4L6iA==
X-Received: by 2002:a05:6808:15a6:b0:43b:55c9:3a2d with SMTP id
 5614622812f47-43d6c2450f7mr3029243b6e.27.1758384093654; 
 Sat, 20 Sep 2025 09:01:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c82396fsm3161060b6e.19.2025.09.20.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:01:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
In-Reply-To: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
References: <20250910092327.279749-1-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 0/2] qemu-sbsa: Fix GIC enablement
Message-Id: <175838409246.1266689.9324869013052247636.b4-ty@konsulko.com>
Date: Sat, 20 Sep 2025 10:01:32 -0600
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

On Wed, 10 Sep 2025 18:23:25 +0900, Kunihiko Hayashi wrote:

> In the qemu-sbsa configuration, the GICv3 definition is disabled due to
> a typo. After fixing the typo, GICv3 is enabled, however, the GIC register
> base address definitions are missing, resulting in a build failure.
> 
> This series enables GICv3 and resolves this build error.
> Confirming that U-Boot successfully starts up in QEMU SBSA environment
> after the fix.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] configs: qemu-sbsa: Define GIC register base address
      commit: e246e2b65885e6d5fd052ec2acdf2b07a53171f0
[2/2] board: qemu-sbsa: Fix mistyped GICV3 definition
      commit: edaaedb5dd0fee9fcdfe41d92659914dc9d1d44d
-- 
Tom


