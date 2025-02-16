Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E11C021A0
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 00:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18AAF809A4;
	Sun, 16 Feb 2025 01:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="igCpk+B2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C52C80C7E; Sun, 16 Feb 2025 01:33:29 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0878056B
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 01:33:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2211cd4463cso3896865ad.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739666005; x=1740270805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rkzLWQal01T3nsg8NGfKcBRcucriPiScZcGlqzRWiek=;
 b=igCpk+B2ZV9wIwJm5UM/KyvWKktvODa0RIHLJsx23gRfhbjhrrQNRjZuMOfjELkCQc
 wQL24mxtCo5iAfAALtPUmbAshhdDgp83MFmuBvO/lib985jCMnegWoIN2gdXS6z934pS
 85VpAGoIyQ2eBwk895kzIaxKoDFZ65Vi9O94M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739666005; x=1740270805;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkzLWQal01T3nsg8NGfKcBRcucriPiScZcGlqzRWiek=;
 b=ZQTFCBkIHsg8Kpmo3NMlgcechVtzakB8rDauILDDYbCoeBEzJXZv49cKk6dY2l2v98
 niad0S2TefezymEIqWlRCiAL5XxWxMl2p+xuBlHC1d6wQ4P2RZ9Hz1De9ZW3AiTuSwwS
 NjL6SyRJKoclUYIgaKtcPjfDsZlNghJkiK+wg9JKN298wL0pkFP2Fg6l2U6n/1T/glPf
 /NWBVxQEBVevIfKp8jHJCzsg8BScTuLqJA66+uJOixTu9TxHVgBik/XcNxHQ0TLTbDqq
 g5B+ld+COAXdonxk4vws42RTinMPCCWuF5YRaNy2k6YTdHP7JjdyLx+AhwD4vqcwxb1d
 uikQ==
X-Gm-Message-State: AOJu0YyUBL3QZS8OwcM4NbVTzFflZhIKTrFVd7YVUWpsELFRGqaRAk/M
 A5/ulkUYaMEwKPM8j1QcJK6QzzwMGKQlfdt4KIFdjz+XOJxx5VlcwmtLVWfqZ80=
X-Gm-Gg: ASbGnctZ5hssQIN5Vkw9KFcokYsB4S20igpKrRpyiBidWyR/4ApQDay5mdb2SDvG5qi
 5q1XDQ+KQ+7vfecnJycNzwf5SqOXZBLao51qtQlHVUSGGHBIMYpdBoE8eQSGXHx6vT7ZFS7K0lR
 WnFewqeYZ0Yhrm4Qm5sBqmvGGdJa7W6SszOkcarf0Tw9Z6XmjyiBz8y2DSjuKW7nYaDy3gWON4c
 aMXnGFCQSZLnJOvWESGRdVrW4/28ITmVdOFt+U6pvq2eF5kBcNZY8c23WamOZGmszH0HWSp9B7q
 UYQu/+WBTLsT
X-Google-Smtp-Source: AGHT+IH97tbeIyP9rRbfMn2LtC4zlU8qIAy2bVdYybxz9WA/Eq3JQGDx0OCaSBq8ZtObVhR8I1cd2g==
X-Received: by 2002:a17:902:ce03:b0:215:7446:2151 with SMTP id
 d9443c01a7336-221040135f4mr74004175ad.4.1739666005583; 
 Sat, 15 Feb 2025 16:33:25 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d7a540aasm47327035ad.245.2025.02.15.16.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:33:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250215212352.101971-1-marek.vasut+renesas@mailbox.org>
References: <20250215212352.101971-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <173966600456.139614.3721080976098970310.b4-ty@konsulko.com>
Date: Sat, 15 Feb 2025 18:33:24 -0600
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

On Sat, 15 Feb 2025 22:18:51 +0100, Marek Vasut wrote:

> Add empty weak assembler function armv8_switch_to_el2_prep() which is
> jumped to just before U-Boot determines which EL it is running in and
> decides which path to take to boot the Linux kernel. Add IH_TYPE_TFA_BL31
> into supported images type, to allow implementation of board specific
> U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TFA_BL31, ...) TFA BL31 loadable
> handler for fitImages.
> 
> This PR contains common hooks which are noop, R-Car Gen4 board specific
> implementation using these hooks is coming in next PR.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


