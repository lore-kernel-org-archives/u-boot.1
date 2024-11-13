Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C3FD637A3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA0489177;
	Wed, 13 Nov 2024 18:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LIECQBP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF17F88FFC; Wed, 13 Nov 2024 18:40:41 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FB989177
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e5fee32e76so3279321b6e.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731519638; x=1732124438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF0FBUhSlvw3m/VQvnsWffdx54wZgnZ/427EXDTdOVY=;
 b=LIECQBP69CelDO3sWYpaO1cAN2/iq60ZUcBq1zSyDhWu+F8iigWI7XiTR1h07DZMaH
 HqgdiP0mzqr59BcAE2kOgKRcjYcbeOR194Zccp8nZ+OMO0regMNxZhboavkpvMdCvxTo
 Pn03DlNqiDb3+Ucuxjzl24VCcDb2+cmUcdltE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519638; x=1732124438;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jF0FBUhSlvw3m/VQvnsWffdx54wZgnZ/427EXDTdOVY=;
 b=IBrtI1X4SWWJwDYR1b3w24+8Zrj7b0R9yBWwTF6OQ1j/aq+7Iq1ujbrk+F6QHD1Qr3
 MOkMsrpBxFAY3uVyQLPSA6gjh/VqUM8rhRBlKklWpfMOrlynIE/JSYmEwJcHnfyfoRBE
 OdC2/FjcxSGxuevCBqXi0FL8IwFPnnXEg9Pek0jy8uUHyvsxptXkCMcFepUavy4YPqr4
 JbKZi26Q2WcilVHcrJrZo4gyruFPiqO/Hca+5OsodgtKr8GLaW1bt2/mv4RZzWnumMRn
 NpBWAt5GEVUk3/KpZR35z0HqE8CWwSJ0x/jTbmrcOZHcx4SbD1qxPagkVLt8amQ8V0p1
 Wodw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpdnEramaCaLry2oxQvlYR6i87UURVdtrbTYa0IpqRv3gMcQjXmbpcXdBY6HKjlQiTDClj1zk=@lists.denx.de
X-Gm-Message-State: AOJu0YwYgZWpCvWgakHtC/S5fgr4+zIgXz421izZdZKhjAFX0F49YLuJ
 G4yYLWcVBLeawX1l+k3+wMWJwyvY1Vr0jh1gmlaixlQuYqwXmBp1OTwludTzLXQ=
X-Google-Smtp-Source: AGHT+IE10OIk/UutXcs58q1X0YPCqlPngiJlS5rxYRi7o5wuDsWvJvYorVzNP0GrOd3s+jNrCdgodA==
X-Received: by 2002:a05:6808:21a7:b0:3e6:3777:76a7 with SMTP id
 5614622812f47-3e7946af87cmr18389063b6e.23.1731519638205; 
 Wed, 13 Nov 2024 09:40:38 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096bdabsm736295b6e.21.2024.11.13.09.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 0/4] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
Message-Id: <173151963631.1299521.6535425532210143721.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 11:40:36 -0600
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

On Sun, 03 Nov 2024 23:42:19 +0100, Heinrich Schuchardt wrote:

> The lib_test_uuid_to_le and lib lib_test_dynamic_uuid tests fail on
> 32-bit systems. But we never caught this in our CI because we never
> ran any of our C unit tests on 32-bit.
> 
> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
> 
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use the new function hextoull() instead.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


