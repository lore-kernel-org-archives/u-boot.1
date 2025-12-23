Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83060E6F085
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 17:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE488414B;
	Tue, 23 Dec 2025 18:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K0pJhHG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A1184154; Tue, 23 Dec 2025 18:18:07 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAEA84148
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 18:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3e3dac349easo5320127fac.2
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766510283; x=1767115083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcICWDvJlgd8xKLv620TVbJIQCRvsVBlsUFSrYy0q6Y=;
 b=K0pJhHG+51FSRWTYEuUQF4/GJ9WyYm41Wg/fiFE0U0E9txQb/Hk5NW83Q7r0z8u0JZ
 LaI1Mq/PCI/NSfBPIMrmrGHnnanLPge6HxOFt2xK7fFu2SMt8W6f6EpiMsSR/kaDYgjr
 XXfOlwNZnDV/8HIYREO3CmM43ZkQZHZvK8zW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766510283; x=1767115083;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcICWDvJlgd8xKLv620TVbJIQCRvsVBlsUFSrYy0q6Y=;
 b=uynKj1VVtNxX+13ajDwsz3LkK7vZTG/2s5SG1pUGFvOgpWBsdCSbH+yqLN+ysCg4xa
 eJ2y46mu5oJNo5pl9olmyov9f9oT5jEGgzejPEMTAM6ROrKYy+l4qhK+UhO0rWntoSrx
 agX4iHkwEbWYhKjHyI2LR51HgS+GtoQwoBOEFmVxi2C+WnR0LlDxfNXb8LqNnDkRUij2
 yPTezzo6lJ5uvF3JTwGdE5UTCQ8oZ9F6KAKqi7vTtwQ9hTmScv2kt2VW3A1Ars/jxdlQ
 orlRUc9DscggswzUEr8Y1YMS8steF85n7/YmrUkVVWcJjsH+tdBdGxC+ALoIdqdcBJJr
 Mo9Q==
X-Gm-Message-State: AOJu0YwCh8E0uA0N4lgVqK9e/JGRoxldvC9TH0uchnAQBZXLHYjN0PEC
 IYVxDOS4ooIBJzn24o6oiNES8xYcWBiTJsgKQFmYkdK2VngeIG+laj9s/qR6bzwq0jA=
X-Gm-Gg: AY/fxX7xKXy1DIXZ4I0pxcaTmMN25y3kgtwdVhj/OAD+tTrSA/xjrC3n71Safzbf3v1
 5XToR/uPO/KZbSwlqk3IW1ykimpRzsoYepOetkmybQ73dRy2yYUAVj63N0Lz+mTJGJmW2Z/kSW4
 yp60SJe/4UXL+k7U5VDSG6If7tsM3Lo9q/NSz7yFqIy+LXtjQzi8sg/PfrRI5FP6cuUvhyHholD
 OZb3cYVguSwJQZEczVfgyHP2gPAww7/3XQPt6dKhyG8tq1GJhZRmAhn51hfKHCHKn/cEOLOkXou
 m7OPd5AgGBaQ7qY3lgORnnGObVomWKg0rR0H3XM9cxt3mzzIbDB+hFZ+LTy3iY9/fcweq4zgRV7
 4CdpE6JJpp5P9512laImo3SXFsxS/eZOKITDDB9GIEQdOUYptxkOrd2xTvFDHbIunyAtC+qqbOJ
 xia4ZDl/qTd/BEHSFztzCKidq00nPY4hGhJ5BXNFNKBqaHkylV
X-Google-Smtp-Source: AGHT+IE5ZvMO/Yd1mWHk+METkUjS0OqKSfLM8eJdqhz0Qn1SORyWusjFWvHlccAtXt+7LW5ktT+mIA==
X-Received: by 2002:a05:6871:680d:b0:3ec:4b3a:286a with SMTP id
 586e51a60fabf-3fda566905bmr7443637fac.17.1766510282953; 
 Tue, 23 Dec 2025 09:18:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaac129c7sm8073514fac.21.2025.12.23.09.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:18:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mathieu Othacehe <othacehe@gnu.org>
In-Reply-To: <20251223165456.34899-1-marek.vasut+renesas@mailbox.org>
References: <20251223165456.34899-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176651028222.1176824.12419096038201860211.b4-ty@konsulko.com>
Date: Tue, 23 Dec 2025 11:18:02 -0600
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

On Tue, 23 Dec 2025 17:54:35 +0100, Marek Vasut wrote:

> The following changes since commit 0f6ff53d55ba254de8a995c2a2f5a313acd40ac7:
> 
>   Prepare v2026.01-rc5 (2025-12-22 16:26:11 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


