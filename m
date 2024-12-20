Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9517AE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888268021A;
	Fri, 20 Dec 2024 05:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IF9O2Ra8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0F908021A; Fri, 20 Dec 2024 05:05:39 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF7680446
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so2245073a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667535; x=1735272335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PLxCDTd3Dy/+S6/hDoGpIenPlJ2NqXele6mol8zfvzo=;
 b=IF9O2Ra8WoYZfEJ4MTkK8x04BIeauDFzG4+VRyTiT1IjSeVKu9WFJ+919JG3cCCJx9
 Dh5zhpKiTLDxOatOF73eNVQdwbgM11JGQEgkYS0nIPV/s3cWAtdvlsWiMuRQC41hYRkv
 Ykz+iRHCWApgi1IEBxPqnhELH6AwQpiI35NYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667535; x=1735272335;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PLxCDTd3Dy/+S6/hDoGpIenPlJ2NqXele6mol8zfvzo=;
 b=rVE0PHO0Y0rmFAINCnrzv71ZwBz49ohihxHuBkSb028Ih8P2TX9KrWw/eEviVcMkf9
 u9nvG6SYqFvv/6NhvfyRu4XE3jkb12TUN/zXyxR2IncHpiNUzvMDgr6ZcWDkwT72Y+1j
 8Tt5KPOCy+LpjhUBce3yl/4L/Rib0kkFliu5D1IMWrjCI+K/hOakDc4sNf2f2Rc6af04
 TojmPUKDajBaHuiVy270sd9kzQEBbBEM7I+P/sscFEQgz3HpyW54ZT4c98DSS/uc9xqp
 Mh/1ZAUSColYLucFqBDF6ZP79/IMJk1yEdK06MUifmtyZDa0k5AHrs8Pqk7kevI1te3h
 isIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGu1itALw1DlJ7S3WC7rC6vC2+IIWvqS2eS6Emp85rURE3CNu1ceMehdBtcwcY3FJbl82p+os=@lists.denx.de
X-Gm-Message-State: AOJu0YwwNJjJbrQzxPnlTGslksD8jWvn+uUatiRu+nLP1ZyD37LgWW0m
 Z1saJ6s9t/MJuEOPO1Pl/7hqmtGDIbtyfnUyNDrDy6yB8krfJFYQlq1/pYx8JBnWNLPv9k6yeYT
 bfB4z1FXWeiSLB2IoBPkk/VjYC9Zs0mrgqwkO6mv/MRVcZuA=
X-Gm-Gg: ASbGnctOX5scr1qTHK/velDmngpE7KcMWlT1XyUdcaBKNX2NArQWem6kFdRAWTwt54+
 6y4IJVUDPntfKEDaAK1NQ9KSjfmWEANnE0VhCWlc=
X-Google-Smtp-Source: AGHT+IFea+TDGdWkQ9kkOerMo0xj0dzjG0vGDjI0QpdpRntIYAYBO7fxCaETqiV5OZc/syDRUYFZKSNo1X4+yMKv87s=
X-Received: by 2002:a17:907:802:b0:aa6:6e41:ea55 with SMTP id
 a640c23a62f3a-aac2d455695mr86986966b.7.1734667534991; Thu, 19 Dec 2024
 20:05:34 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:34 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-32-sjg@chromium.org>
References: <20241206023626.2456858-32-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:34 -0800
X-Google-Sender-Auth: UxxjYxktRoMbXVkXOTso2DOAfz0
Message-ID: <CAFLszTjf=Oui_iv572mxnc+joR52yd=y3kqf=8dgtfZvY2Aahw@mail.gmail.com>
Subject: Re: [PATCH v3 31/46] pxe: Drop the cmdline parameter
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Now that PXE can operate without the command line, drop the parameter
throughout the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c |  5 ++---
 boot/bootmeth_pxe.c      |  4 +---
 boot/pxe_utils.c         |  8 +++-----
 cmd/pxe.c                |  9 ++++-----
 cmd/sysboot.c            |  4 ++--
 include/extlinux.h       |  1 -
 include/pxe_utils.h      | 10 +++-------
 7 files changed, 15 insertions(+), 26 deletions(-)

Applied to sjg/master, thanks!
