Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976F1E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB7A805EC;
	Fri, 20 Dec 2024 05:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QcEW6Erm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C51803F5; Fri, 20 Dec 2024 05:06:42 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACC28036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa692211331so276233266b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667600; x=1735272400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IGiNvxqxFRujZlaajIQvuqQsONjYU2hXccBM7oLI8zs=;
 b=QcEW6ErmP6Pn1x+7lNqTIEpq2NI7nJL2gahbcdk27qwjRsr8uYFQS9/9NJrmvQ21rv
 rIjJr+ti7m5ESSy/oKaa208CtO8TuibqGbIKGc4y3AWTIqoDpi0zrvNhNanlMPQSoUlo
 5u/+bTzFEdG9O7hV/Z7B1b9IIcbsGnKolxdUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667600; x=1735272400;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IGiNvxqxFRujZlaajIQvuqQsONjYU2hXccBM7oLI8zs=;
 b=UKcN8a7G1fN0YhmzGwP6FLxigsvp9mTGFH3WLNsJIYUSi2MStbWr3X6ZkV0WQxGH76
 O/4AfPTmmaQ94UV0FAyonrE0g3+5pFbIQGZqRRgNhDoStLgjJ39kQU3mBMrWAfVvy/qm
 5uGPiU1wEBX0A6P1qmNl86TBoLyhiNOY0W05lYvGElTs9cLnZfZ2VXZICwqBwuDO00S8
 6sHPg8WzpKNz8TOcS/mS25NtBqMVDQauI5P4O13GsDgWhkSFR4aZeCYoMg+VnuCA58tv
 5E6v1QLMYwD3CK2RJkTXKadUEz4L9y1kAon7DePmxmHPBR8NZq5L7eTp0BeruYJcC98Y
 n8Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7d6RO6ZnfvHLvjI8FfzhHqA96RD6+EFS/4v7PLlEVwXRwVllCPy59fsrRyLwhRM6k+mjeAdo=@lists.denx.de
X-Gm-Message-State: AOJu0YwZOKXHQ4/gY7hqenF8iwBtrk7vz2kjClm4RH+LeE8uUC2PFiJU
 8yoA/t97zOOpYaiJ2Y61YeuhoPdsjukGZtVsG2N0G9/pVXthXPcigsam0K284AJT08J76bAApqw
 Qck9uxqlwqV7TK0g3Kb8tmHRT8Qw5gV7qxI01
X-Gm-Gg: ASbGnct0seCDGbbqizQ4cODACo4kEHhXYj/bMF+x7IQkvAFLvL1MhVAyTuSW4o8xqzZ
 CgzYb0E7Kb9F1yMSVVNfwUPrNBkSP/m+jgijzT1Q=
X-Google-Smtp-Source: AGHT+IEFhyG4C2PiKUZEPl9u770Mu8AVCqJqjEvzx904iKZtwoouioeUCmnmA0pjRR6jBnjyncEqOP/2wPSM+IsJxk0=
X-Received: by 2002:a17:907:3f0b:b0:aab:daed:9ee9 with SMTP id
 a640c23a62f3a-aac080fe50bmr543893666b.6.1734667600338; Thu, 19 Dec 2024
 20:06:40 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:39 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-10-sjg@chromium.org>
References: <20241206023626.2456858-10-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:39 -0800
X-Google-Sender-Auth: aQJ5b2wHtE-6NdZvAKM2K2B0iT8
Message-ID: <CAFLszTh_5Kw_DRu3daMgQ=6K=5wTQjOgR_0nOZOzfWnvBRjqsw@mail.gmail.com>
Subject: Re: [PATCH v3 09/46] boot: Use strlcpy() in label_boot()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
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

This function is recommended instead of strncpy() since it always
terminates the string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split out strlcpy() change into new patch

 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
