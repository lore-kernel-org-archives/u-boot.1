Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99CCC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4868357F;
	Wed,  9 Jul 2025 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ph4MczYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BA908349B; Wed,  9 Jul 2025 16:22:06 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D7D8349B
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73a44512c8aso1427348a34.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070923; x=1752675723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cI+PPijpgb1x3tfiyTf4o0z3CYDHCpZajbMYBuKl6kU=;
 b=Ph4MczYFELeJygcPy+33ZISQlpHfKNgAnI6m1e6A6d7YpOWV8JcV4H2bQddpXvh1lz
 SL3xZxoJaGybeMXwkDWeTthZRp80mVSpPA1NtAMBdZkXpDN2/xmKfMXOHeY9rE5h5Xam
 8KkkzJqyj3Biyq3IOgSs9vSiUyYFB2PF7YFck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070923; x=1752675723;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cI+PPijpgb1x3tfiyTf4o0z3CYDHCpZajbMYBuKl6kU=;
 b=U4qMkWRxzrU9/pDCJcFJisC3R/vZJjnkWg0vTcd1qxJ/le7LEOPdeawYlycpDfydFs
 /p3yNEoNw+R7Z8JY3JEzrXPo38wjyLGIWd6u/4PjjR61nMsE+wOV6ss4BS1L/qbWWoaW
 /1dthf/iFPwUHyY4N99uy+9JAeAR/lJwxzYtetvNmNS29OYAdU7vp5/SahZXEVarRuQZ
 CsbdoHyoDYfdxXqVu5VXaKOXJzZQU3dRQRYV/UKzUS/oSpaY6e/iZsOORysin2MwKdiO
 Pk04hqwqe+NT5VEjrIVm2IU2xqYGNUWXGvOCV6CvUA+SdFS5NGu9C5/o2vYlGVYG/nw8
 cUYQ==
X-Gm-Message-State: AOJu0YwIOZkOExztxLsdVi992RuUwZs4aHaxdkS0nwlHRXgjYQFvN2e5
 uEtlbyxPSKzpUj0R+vrxJtN4BhWvVoUzYw3fALkEnLwohvsqpfQnfYAvyJLO5RnytmE=
X-Gm-Gg: ASbGnctSfM2hcIIzTG6PinxsCeXniboWH8MugPNQuau6qdKJiPWIxqauOMd2YpXr6Q8
 +USieSCRpsWhWVQHFOnxAqCI5fbfRjnKuGG6qX61VJ/XPgCz11OGfKoAd7z+/f0cirrF7F1Gfo7
 JTECbE3Q5XSQwBNpJpDtx9uuZ9f2HEpCtEWcZyAFVLWrm0ZAuTtO4RM8c3KsZOzxftjXieVzG65
 dNfOQ+icojn35XJ2qCS9zcnuq1rZKwLwwUIUKeT1md33XzcZsLI52q8gZ3LsnWru342SqXHYm6j
 PocQuJH/PgzPxN0N02JzOrKlg4A05DIawNWsFnlY5zC9J4qT9R72tybLc7i+JAJBPdjVI6zYAgP
 bPrBRtG5CCJwgRRegWus=
X-Google-Smtp-Source: AGHT+IHSGBXpF6mVzwh4EGiXV/+dzAflJVSO+6XO3jjzfHYLTr7PEv6L2Slyu25zrJHQ8+SUjwPzhg==
X-Received: by 2002:a05:6830:4c84:b0:735:b053:912 with SMTP id
 46e09a7af769-73ce6087197mr1354659a34.4.1752070922775; 
 Wed, 09 Jul 2025 07:22:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:22:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Javier Martinez Canillas <javierm@redhat.com>
Cc: =?utf-8?q?Dan_Hor=C3=A1k?= <dan@danny.cz>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese <sr@denx.de>, 
 This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <20250627135355.2731430-1-javierm@redhat.com>
References: <20250627135355.2731430-1-javierm@redhat.com>
Subject: Re: [RFC PATCH] tools: termios_linux.h: Fix build error on ppc64
Message-Id: <175207092161.1813324.12464542532272635162.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:22:01 -0600
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

On Fri, 27 Jun 2025 15:53:37 +0200, Javier Martinez Canillas wrote:

> Commit 93b55636b09f ("tools: kwboot: Allow any baudrate on Linux") added a
> tcgetattr() function to be used, instead of the libc's termios functions.
> 
> This was done to allow using the raw TCGETS2/TCSETS2 ioctls that allow to
> support arbitrary baud rates.
> 
> This breaks the build for PowerPC, because that architecture does not have
> a struct termios2 defined becuase the termios and ktermios are the same.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools: termios_linux.h: Fix build error on ppc64
      commit: 6df1b1cd4e38575019c8b4f605c07a784c63f40e
-- 
Tom


