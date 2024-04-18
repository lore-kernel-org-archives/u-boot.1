Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FD8C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DE698856C;
	Thu, 18 Apr 2024 05:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MeKmNzJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB36B8856C; Thu, 18 Apr 2024 05:40:15 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3764788503
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78f0593f45dso27836785a.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411611; x=1714016411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3aKJ1/0PQ9pcRC2O8gdEw1DY0ceR1c91BtQjk3D7N0=;
 b=MeKmNzJ2pRtzUcz6S9Hukqt78kHMHqJU0vW/rDDlxjIvQHSW1BmJCf+wPuEls/q24R
 0yqD2ELwNZTA2Aubbziwk3sTa5qTlBq0FqU6HbK1o8HKJ79PHKBHd8CFGUaaoXLesfwv
 hDfEm9YRJdYDEwtYel2c01MWsPAu7+o89KngY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411611; x=1714016411;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3aKJ1/0PQ9pcRC2O8gdEw1DY0ceR1c91BtQjk3D7N0=;
 b=QNtF+oPaaokYS4hsZOJY78BQc3/H0iS8xlVxUjiqYeeQQ7QBa+TMvPmA1ECF3LI90P
 fTUWCxTOszT00slvjU2+/kPlz57yKxlU2+T7Qru4ssdlpioeGj+OPGAOzOE5E96Suhco
 81TVh/mER1pnkQx8WLapKyF2br+nxYHGD4q0cV7UHF30B0uzeG1HylhQsxSwYv49W75P
 25VE6Zho5R3TuVcXHdM8Nygj2EkFNJZzcedBPuyaq0yS7nz3O5H/abg4XDh4jvsRKHVE
 NsyZfqEwV+EnmU8j5krXSWQButp/pQXNcbIe7IzNFk170srAEwGZvGh+rcdgeL5oJb2j
 h7TA==
X-Gm-Message-State: AOJu0YwZ6v87Mf6NiNduSeQFJP4KFtY744WJ/EtW+t94/RqYXKe4lhRC
 X9kj6EFonUQOMrJy9x0AdJRFRnByM5NgGukpFxCFnncdm7epiTY9oOilcqmEW0BzCi+wdvcjZTA
 1dGMjYg==
X-Google-Smtp-Source: AGHT+IGd2PaaeNwB3vE8e9hrAHXhNIJqnB8PXY3F7Du99rIKFp7IE6gFGULgaHPefabTuMMxflMEkg==
X-Received: by 2002:a05:620a:2904:b0:789:fb78:5419 with SMTP id
 m4-20020a05620a290400b00789fb785419mr1602961qkp.69.1713411611122; 
 Wed, 17 Apr 2024 20:40:11 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240409075549.12514-1-heinrich.schuchardt@canonical.com>
References: <20240409075549.12514-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: typo curren
Message-Id: <171341161013.1250683.9103673981531002307.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 09 Apr 2024 09:55:49 +0200, Heinrich Schuchardt wrote:

> Fix typos in test_eficonfig.py: %s/curren/current/
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


