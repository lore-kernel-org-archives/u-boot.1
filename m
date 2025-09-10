Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E55CCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53763833D0;
	Wed, 10 Sep 2025 20:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hXuSPyK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE145833E9; Wed, 10 Sep 2025 20:14:53 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A46A83323
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-746dae5ff93so5920148a34.0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757528090; x=1758132890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UETsnQ8ewd9IS/fgVLjDkwxeF7pT973sP0sdf9V1F/E=;
 b=hXuSPyK73vp5cTD1rw2hZTYPG4H7SHpTm/o7rRyFJYnK96BzDEiiV1zCljWNyaUHFh
 NXc90MK1Agwgei5YMf216L97n4pIoJYmnStI+T16oUjptgYt3ya6cDnbPCkStm6sn6va
 DW7DBO6Dm+w+0vJUZw6b+iNnHWz6SE4bcS0Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757528090; x=1758132890;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UETsnQ8ewd9IS/fgVLjDkwxeF7pT973sP0sdf9V1F/E=;
 b=Q0iq0QDE7X7BD4yshyATx+K0vmz4HOskHdKLeulvBj2+txn3N3k4Mq8SQaDl/3Uyc5
 Kq84pZwmjFFmOW17DJesTLlCBLs+PoS09PPK+ylraA3f29RzRt0mvf1j2R9tdJvno1f9
 356dEWy6zBW9A02qOiitUjuLynuowh1YD2f4GYoVpIvRhlZvu9qugnKNQjEE/7brDVpp
 7iaNodJnPQcPP77wIac91EVYUtK/OZLUwFsuYN/JoWQ+/Lgk/MR+qZZGwSH80Pr+xxNQ
 9tflwYfNcKuijzPIAjSoMy0ywQAiLVtPF1QGuCDezWGCG7sZoax4JMh0cPZU6nkWZCbg
 jzaA==
X-Gm-Message-State: AOJu0YwMgofnkwpVz4p2BfU8BxpvYVc/pUFZOWHQ2mpBbj5uzeXCnGAp
 vdNKDLtHzkJLVmvmoIoZO6t641MQddJ25JjBVQMkv74/ERou+1PADZWqbAm3iyv2UgkXugvXZxx
 6gw2p+cc=
X-Gm-Gg: ASbGncvLJuF3YrPRdxNzmM0O+qs5lyXBf3Nu7vfOINIPmaINFiKzGJUkVl93VeRSBC9
 eVFjRMAzflSKK5BqgsyCakGv7roGw0pjN3x945E8C5D/tvwreCLdv296KtTTkceRiTkXSLh8dLU
 mUGqcuIa6T/wfv5VwSikvuzaxrDopKwuPBbphlNlwsJT/PxjUcgZPDtSx5ZAqB/1c9Ib0pWKX0o
 dqoOFk3e/WkKAYL27XrGb3P0n1lQUDhKBzOkJgTbWVqUl1KHsafFWhMotqFbo+zGwBRjjMXIpGj
 zprXpzuBuVHu6E1NVP3vV5ci1f8H2pqO8sAaVcC5VM6RA4SLF0vBGGr7Pu0V2a95pm3mwVhh+Jq
 l4LGUVxiOuu8wZOHBPiSvndPqfZdGP88VhGK9wGvqcbriS1/OSaoyOfs=
X-Google-Smtp-Source: AGHT+IFbOiiSprWBbyt2TaK7ZvIfZr83KX9uIx5ka8G+Q2Y0GfigGeU4pWC19MGJJlGnFFFYq52fcw==
X-Received: by 2002:a05:6830:490b:b0:745:a390:8662 with SMTP id
 46e09a7af769-74c71d0cfc7mr8196209a34.13.1757528090369; 
 Wed, 10 Sep 2025 11:14:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75200e6a1casm18100a34.17.2025.09.10.11.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 11:14:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
In-Reply-To: <20250829021131.28451-2-bhimeswararao.matsa@gmail.com>
References: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
 <20250829021131.28451-2-bhimeswararao.matsa@gmail.com>
Subject: Re: [PATCH] i2c: davinci: prefer kernel types (u8/u32)
Message-Id: <175752808947.1959855.8194506848638314755.b4-ty@konsulko.com>
Date: Wed, 10 Sep 2025 12:14:49 -0600
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

On Fri, 29 Aug 2025 07:41:29 +0530, Bhimeswararao Matsa wrote:

> Replace uint8_t/uint32_t with u8/u32 to match U-Boot style
> (checkpatch PREFER_KERNEL_TYPES). No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/1] i2c: davinci: prefer kernel types (u8/u32)
      commit: 5964c6f4ef0934130f41c347c771dfb97210490c
-- 
Tom


