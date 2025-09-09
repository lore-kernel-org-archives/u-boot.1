Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D7ACAC583
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 14:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E729830B4;
	Tue,  9 Sep 2025 16:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qoQfBiwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BB78319C; Tue,  9 Sep 2025 16:13:22 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E9028309E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 16:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-887745ee6ceso73421039f.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 07:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757427199; x=1758031999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6oevkLyJR4owOfbqEjG0nLXu3jnYwkpJRolPEDmcYI=;
 b=qoQfBiwlbXQjc2lvDemGn7+0h7KJQT/CZ+/6E7Y5vU9Ri8JeL5t1B3PX22/4pAVUBE
 4B68usjRP1BmGcq0foK/XL+Y0p8KTwEshfwwGT4ml7+jxacOUA/BfqdhKHkXDUhzWeJY
 8xn0Q0uRq5y5bXRMrl35RVaUcC8qzW+cyE6Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757427199; x=1758031999;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6oevkLyJR4owOfbqEjG0nLXu3jnYwkpJRolPEDmcYI=;
 b=Z4Booke7EZcLdPHNY6OHUUeWCVFONlER+ENLPxZ8sLwJchPTxXmh7AOLNwZs0cQI/A
 dvX8l9Sa2nOp7Zkr2BKsLUmlbgyrhlQ3Ol0OCQtnJNr5l0FkC4xQShSxsf6QW+MLkYKA
 cghkXEnlRiMNsWplfrNKo4QwUQ6NgNs6ep2p1MGPgmAprCQjsMERNnNQ/mt33tQKhQEJ
 GM7fM96DTVV8RPGQ3CocnfsIcS/qEr5eJMpw3VXQ10DRGXDm7urqOZStH36eH6P3Ki/9
 7TuAbpR4bBy+VQnMEdc2q0/NOWvbV3wn6i5JTX+aSNnlPNON6QPScjxJzWKLU9duTOCW
 z9iw==
X-Gm-Message-State: AOJu0YwuLbBlvfANSILNYSB3HGI1T1Rvndt2F6IyJuDUIWc+BHDQa97Q
 L0mWJS1x1quhmavjJHLZwVT7cpFSXmagYGDU4iQnpyFRnVpUGJjOmYUjLsqjeKjXbRjxjn2RehQ
 RxGa8Oak=
X-Gm-Gg: ASbGncsXWmO/voyBLxQM+xDgKS7BkMHKuu7ky39R8/3cSV3OGtAJT9E0yKQSZtEYPgs
 27yJvmXctbpRRqsGH0Lmkl68vgw/SiXBn9/YhGFDqnT8OAynd+8DYCCKSeVaTnS8QRdR3V8vpMg
 47M+23EJjpd1JTFCiPil0nrtztCwkgKihAUYX8fbRaTlF7QkHYZ3S5gm8cTqOKsqarINdvAgDxU
 abECebtCwIpz+8mTi6WrosPjnhGeNo5qb0yjPap+IXf62JVaZVBR7IB+HMRIkyypzSZdIS3wPBm
 AE4twQdBCT+ZQJyl7IKbfmhV47kiPao/inCoz8JTab4LSv+X+AsOan/CFVfV83VHFh+4pkKGD7a
 JntWtH+iD/XYNGud7Kh9DkCsxSwq9CLsrfgYg11HYSPfvCxLixf44SAY=
X-Google-Smtp-Source: AGHT+IHv0gdeUbEFn4mptX+jLDsyyiwaDD5+GRPX1wpmEz+mhPs+oM/3dZGfcTKoL9gN+a7HLpnClg==
X-Received: by 2002:a05:6e02:1a45:b0:3f3:3140:bd00 with SMTP id
 e9e14a558f8ab-3fd8e98d182mr183165055ab.11.1757427195332; 
 Tue, 09 Sep 2025 07:13:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50d8f31d0b6sm9669006173.42.2025.09.09.07.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 07:13:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250903070502.136681-1-patrick.rudolph@9elements.com>
References: <20250903070502.136681-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH] configs: Fix crash on coreboot x86
Message-Id: <175742719436.1649309.14428693786511063635.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 08:13:14 -0600
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

On Wed, 03 Sep 2025 09:05:01 +0200, Patrick Rudolph wrote:

> Booting u-boot as payload with coreboot's main branch is currently broken
> since commit [1] on x86 as U-boot assumes the active GDT matches what
> U-Boot would have installed in start16.S.
> 
> Make no assumptions and always load the GDT when building as coreboot
> payload to make sure the segment registers are actually matching the GDT.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: Fix crash on coreboot x86
      commit: 77ef938212b1b273389ea1560b999e79a6c285b3
-- 
Tom


