Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0ECC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 171D18357C;
	Sat, 24 May 2025 06:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TeheR2kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0275A83559; Sat, 24 May 2025 06:25:45 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E98983303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-601d66f8cafso809864a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060742; x=1748665542; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s45ufKDAW6UGl1P4MfZGciZSdub7ooMFKcDTw4g57MY=;
 b=TeheR2kqhLq72VuDFCB63LXjcHtOeLEIBMZWP3wADV1lHbrUYf1qVfguPYmJelog8g
 3MHWqG/ixIDQmCshwE1syAEB3VNvxyrRyUKcB29tORY1VcdLNTucRsSfZK0cFIgMPbs2
 +frYLAOn7mNqc2avtt5gbt8MzN5puJHR3IMgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060742; x=1748665542;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s45ufKDAW6UGl1P4MfZGciZSdub7ooMFKcDTw4g57MY=;
 b=Beirjg6rMvtkuDyUsDDTWBZwqaJ/gbvKfdeb2VLo3GbAwiHJz5RT+J3xc3cwz88rUz
 cu+hG7UcKTsUciL1Qtfmtt0a9Wywv4EZ3xW2ZLZDhCa1Bcipvv4bGQtMO02M8/jXM+MJ
 vz4ai3f6GUbqa8TPgd4cFFDXeEsUFdnU25O/KP29BJekQnCIXsLoyI1mRZQlCnP0nJ9h
 pP1otqcQzngxoC60tXxPzI2qD8LwRnUPCwqop2jHznnviQftdk6Hi9kD7cdjOY2SzEys
 rzmDT1ae8xHujkid8E2DzMoUZpInJCz0h524ovK19bFDTC0QEyavng6QYxqgBDau6hkm
 LTVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlF5f7adfG9VqOPi2dzhlTfNLG8k11rkmbwwF3d3/6YjwuO0phkM9vWph+aD+cZIa6DU/t0PE=@lists.denx.de
X-Gm-Message-State: AOJu0YxbfHGArP7iKp6KlkHdgV49rVbSSEUFcio0xSYE/jqTLqbaeo1R
 Kxf1LD7hH52w8oUVmtvJBD9HCPkZCZPjl9xdF2klNY9i8ptmyKlXfxkRDIptjuJcmG8HoDSDPtC
 FUSiU5HSMUO8gc7X/hawf3/hUp9RmjhuDDeXJTpAZ
X-Gm-Gg: ASbGncskCDAGrojlPp2XQKQdpbv/vu3+pcIn2wXJFiZ2r894pEgR7YglDjKy3xi3Rpi
 WhhZsSAkLCY5j08F7rdyVaDQIMLt8CRvkZ7RcAJ5LSKWiVdLIkvaTmSogueJ/7curirvxZhPt7D
 0smO5CEueCXllP/Oj5I16WVSQ8vL06zFU=
X-Google-Smtp-Source: AGHT+IFBuZT8vKPi8Huh7QY7dcLsqZOl7BuVEQagk8QokBlcgCTjR6fsDSTF7mx5K9wVrWXOSUlCxTq2PO7yKTb73TA=
X-Received: by 2002:a17:907:3e06:b0:ad5:27f5:7174 with SMTP id
 a640c23a62f3a-ad85adbbbf7mr139915966b.0.1748060742642; Fri, 23 May 2025
 21:25:42 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:41 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:41 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-7-sjg@chromium.org>
References: <20250508072907.207175-7-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:41 -0500
X-Google-Sender-Auth: JkPGE3yOJl8RTEjEucDu57l3NXc
X-Gm-Features: AX0GCFuH5czH_yiKclmI2k0rLpJ85l31birmfvh83YI5uPWpMqAbQKKuju6jbBc
Message-ID: <CAFLszThuhtZGXythgrq099=G+6ugKHpeBaVY3NKdisNBad5e8A@mail.gmail.com>
Subject: Re: [PATCH 06/20] patman: Allow setting a git directory when sending
To: Simon Glass <sjg@chromium.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Support specifying the git-directory when creating and sending patches.
This will allow better testing of this functionality, since we can use a
test directory.

For count_commits_to_branch() support an end commit while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchstream.py |  7 ++++---
 tools/patman/send.py        | 16 +++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)

Applied to sjg/master, thanks!
