Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55510C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 16:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E8EB8164E;
	Mon, 10 Mar 2025 17:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VpOL2xF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17A481671; Mon, 10 Mar 2025 17:11:10 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D34811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 17:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22398e09e39so81013245ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741623067; x=1742227867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cf+HrC34+gH0lS9CS8UOMnzgHh6wl5oN6VVy1v1cCXk=;
 b=VpOL2xF5wqNqGZqjpHl5q9A1JQSbtC2YWwdJLmvdYwIWO6yKJQEu8S04tjLSh2yOU8
 mx3XRUGUkhduB4wrbxSmE3WBcB1eGgtG2jDXq0GHiu32+0BPkSz0toIqtF5lmK+IdT2y
 NOFw8l9FBakdsF9g60+6lJy8mu7SCXj1RTIg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623067; x=1742227867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cf+HrC34+gH0lS9CS8UOMnzgHh6wl5oN6VVy1v1cCXk=;
 b=Wh3OyQBqglm3pl+y3JsIInCbuZH0BEKvKpz3lxOZg2njRiJxB4WeQBrXS6SC6VPXNa
 op7irhebhEQ3oG84/seqHBlFVjVBl+xI4cUzQxT+rMig7C1rU13TywIdOMvxaqJ7Rx42
 wpcVfHBgiQFxvigkg5Zpxrv4mAMhMj9kvPvPh/nsuRGpT4gIVEWZvDBVuDQ8ffQ6/dq5
 vopf5N1i/LE25W2RNeYoIjfIux48bpQzyc3ViPiBbI0F/pjWE5um5qDyjeo1NV50RN4v
 QaIorm8kynJMAAcWF7vloegTKJ6RmYB0mor6hf0saynx88wvego/FSFuaAg1BjN9IIqN
 VQuQ==
X-Gm-Message-State: AOJu0YwauuDg7nC+luEgKZksq2OGeMACNcTIqAqOt1Y2DAEwQEABeJal
 tLq3C5uQvr0So54UGeUZP6+kKsQT01OI55HO1mD/DGF4dQTEBhw40QTcFH6DdE4=
X-Gm-Gg: ASbGnctN79jlhYfPhbdsUC079v7Z4TakYHM8xDX0Wk2CsCCNM7DCnkKsLDXo37oJuXd
 s0v0YcVlJEecpyatTBEwZ8OacG5bB7jMwF7UaZ3OVaIgu7/W5u2tc2OihOkYkhJ+h30zgK/ulOW
 zUHLRyEu89mLcAnGd7iM1tEUSua6jH0LAKX/3slSKN90ELSqY03inyfC8h0yg3Ww0htdtWwAAcQ
 UK/91N8FvtCWqQAz46TQ+dlhLyIpIUC5LtcGthfDJ2LKGxGYkKzDD4o/Oe++roME/Wxgl1u+xV8
 ep7ovT4zB5sTeg1rMd0sWeOGHlHS6i21ADIHBT2iVyMv
X-Google-Smtp-Source: AGHT+IGmkLdLE5P64ZQQk/b9TbsODY0U5r3q76ew03zlj+wXmmUi/z1JiErGBscGOYmfpGil9blzIw==
X-Received: by 2002:a05:6a00:c8f:b0:736:69aa:112c with SMTP id
 d2e1a72fcca58-736aaa1df1emr15424580b3a.9.1741623066890; 
 Mon, 10 Mar 2025 09:11:06 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698246387sm8486810b3a.72.2025.03.10.09.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 09:11:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>, 
 Yao Zi <ziyao@disroot.org>
In-Reply-To: <3f38b374-df82-420a-a253-372cdb2db279@gmx.de>
References: <3f38b374-df82-420a-a253-372cdb2db279@gmx.de>
Subject: Re: Pull request efi-next-20250310
Message-Id: <174162306579.363020.7062503165015821539.b4-ty@konsulko.com>
Date: Mon, 10 Mar 2025 10:11:05 -0600
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

On Mon, 10 Mar 2025 13:52:33 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 743c15b9fdd2f639012a2c26734dc146dc568218:
> 
>    Merge patch series "This series adds support for file renaming to
> EFI_FILE_PROTOCOL.SetInfo()." (2025-03-07 12:06:21 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20250310
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


