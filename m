Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5394BCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88EB8486D;
	Wed,  3 Jun 2026 19:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZrgCuAgE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E1B84881; Wed,  3 Jun 2026 19:05:11 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7599483FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c8588ec1b44so3380535a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506308; cv=none;
 d=google.com; s=arc-20240605;
 b=EqXM9s02Y1Jeq6skhXX4qFfqSOa+cOHvXMzJErfudjbn3D4OfQZg7xOCnU/CYlTEmg
 vXJDdp+ZCu384grcD7UtfgNmjIGKFqv+ly6yCKGycXM0Eo+OB4ZeDCdBzM+QQS47Nrtq
 hEvuxU4Sy9NS+haXdUw3aZHFdqAe88m8AbMIeVF27reG5s4kRdMe8jUJMJpSEGfL5hcX
 BciQYss62toZjvVyYoqA4pTK03xHsUd/DD7CCsmew+ejIqwqtXgEMPqTnBb0JlvuHUqg
 tDyFGtGXqKWGbRM/Hqxth0ACo8X92IVGuPr6ekprqDSxYsLjPg58Z8Wfc74ZBcL+gnt/
 Zbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r5Bajh+Nb5Te0o2iY9H0J+LovJFvTRaFjeR41hjlv2I=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=M0zN0w/emod5hzyAatbOHcwPCot4A/7nBPkWoofx8Ho6+pkMIMPVM7i/DklUfwUV1z
 X3L7h1WopMOWzZ5dfRR/CCjJrPKa+lfsCvBWE9H6nsVtYpvop7Zg4ZoCM0wBBpmK9AWf
 vPvwgeYMAHAvY8R1AwHW3gLsAkg7tee9SmzUDT+ay/MD6l2yfpzX+XMZ93iXMZmoF53k
 OB1D8AnLNDIM96QYMLRfFgdg7CJQ8RTO7pnVkpE1W94YKAjPme1Ma5wWYdwXGe1Uok9P
 Ay1VXhMWCAG9JaRnNWRfkfXT0MdA9p436qlEV9jKgA2WiIjNQg9Kiu7F+WgGG+9zy3+N
 w4ew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506308; x=1781111108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r5Bajh+Nb5Te0o2iY9H0J+LovJFvTRaFjeR41hjlv2I=;
 b=ZrgCuAgE93jKEbNRxNDnrcV0MrurOAPUU0m10ZTYCgIFA6e/9ggBUDN96aIQT+nKvP
 zq1U7g28lnxwDiolCu9+3ZVBdE+xqW136jGcVPmS6R+EfpozwATd2jIhbIV3E73K9m1l
 hKOn33PLCM9MEnfDWlEU9GnLh8hiM69sbjMag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506308; x=1781111108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5Bajh+Nb5Te0o2iY9H0J+LovJFvTRaFjeR41hjlv2I=;
 b=Fp8Cn4SyuwQ6sT1HlBDZ8+JIi5hwzz+b9q8ITc60jn0NFwqpLOI6fh/XtAVvbUZ84h
 sYAsD7v7DJX2HXj5iOkafAGXwL/aTm5yBM9ne2e/34QnYmVu6vbHKv3HMx4zQbsp3SLs
 KCd4R2UVHFys+xhQt4Bekfk1U+/EXRbIPhcfXcqAyedLpPkToSyiN9EP2ORJ3K/Fmoq0
 ElnXvdov8LIIp3H2HlH+1Xt+2pkZPu07D0rZ6icDmNxHTzlhnLsg5430exd0Qeh/1+w9
 7ASbRLEH70UM/WDgsWG9eNDgPogqJd/QcIQBsJo+AUx6f1alak4YHO8Y1JQqAkRXwA7z
 tT4Q==
X-Gm-Message-State: AOJu0YxE05kdQrRtD7bKJo7kPsb1ds2DxtXVoIo+3bFCacclV1VJav09
 u9qx/+hCvppPitEdNZ/NE+UWGcAFQNHifYU9rpLaS9rXksOevLxg9JXKpOwb2EGkZf+a6HLkCzW
 oPjdjrrDBm3RAbUF+X5TH8boOF2sjiSyjtI5o4iLC
X-Gm-Gg: Acq92OFL0rOVnaGBrV7dFpznJ6Za8ou+N7Kg1gPagIbePaWC4fGdZYydK1YBJbdaQwl
 51IC3yQm8ILNrv9wh2JaLrw8iwDEC/jN7WMQl3KVTUqpJ+j5vS87cvN2/OuqjznXU9ZZ1VhstKq
 cXJHhuLxJ/q6CfF4RyAHYLMwPaDuSatsi0o3nY3hbsuYo5V04bILitYB1SZOxw35B0INCM9Fh/M
 wBSpKtrrDLkf/aCcnHN4u4fuDDnMk+IlXltDK0ybC+Ea2+trnhnHptKsFFWx2P4nwBVVY+9VYhE
 NqasxIYjjtwu0hkD
X-Received: by 2002:a05:6a21:a95:b0:398:9662:110e with SMTP id
 adf61e73a8af0-3b4975abb0bmr4985439637.8.1780506307774; Wed, 03 Jun 2026
 10:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-3-dmukhin@ford.com>
In-Reply-To: <20260603070743.1268544-3-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:04:43 -0600
X-Gm-Features: AVHnY4J68ZQCyqsDemC-HuFk4D2M1IIrkioZV4rJ6X14tpbXTFkdf7bE3d-WGW8
Message-ID: <CAFLszThbgdpQR=q_AiBH1G_Wj4iLM3DmSHvRg_06xQC9524LYA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] reset: Add explicit cold reset support
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-03T07:07:36, None <dmukhin@ford.com> wrote:
> reset: Add explicit cold reset support
>
> Some prototype boards default to a non-cold reset type, e.g. warm reset.
>
> Add 'reset -c' so users can explicitly request a cold reset when needed.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> cmd/boot.c                         |  3 ++-
>  drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
