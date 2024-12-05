Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D3EE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAEF89578;
	Thu,  5 Dec 2024 20:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SiwKID08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9BE89530; Thu,  5 Dec 2024 20:56:13 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA4289530
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa1e6ecd353so201835966b.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428571; x=1734033371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dI3/YWF0X0e7oLFtzVB711xg+G2du/o5Hj7PHmE5Jkg=;
 b=SiwKID08f9M6j8P+062H0KG4GgB1E9TEekBOGqNM/uxeaBLEcg4pd40UywlrSliQOD
 bUEXj3ourNy4KqjG9mAeqNaTUYrOnLKw4EQiaJy5Btg08CFlO8yC4rnh2qSBkcKeopuT
 a+R2rRInUS3s3xFcKkQ+NhPphTd5kiICZZtQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428571; x=1734033371;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dI3/YWF0X0e7oLFtzVB711xg+G2du/o5Hj7PHmE5Jkg=;
 b=c4MRffY4pv+YaDyVKZxvAys6jfk0tqfwUB/3myPlyhY3Qw0hR8m6FrjAS65jF3y4Jf
 cY9CnkAs4NODBECaGSb3/osi1NKcAGrbHUmFihT8dx4SU+hWlr+Hz9ueGtylY8Z+BhHI
 ezWY7W78w8YEkaW9fxiopV+MGFpFkB8MX/Wgaybh2fmST3/UOREKMx9DNcTQXyqj1gss
 gig1h0O5MTqhMsTkf7d32imXs5pE8/zFX736nMDHuxkDJifWqjORQCSsleC7xmUq9fyY
 LijFjZmVSGZMjauRkZJ75IAEy1QcOrgvyEKY34xfZDKUjDB/mogQtYNS1ePQfpro6j4Y
 /Lzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV49C3YEhGflwKGhhW2r5ycZxi3OTvxKkSGPFdHtxdTUbLLRJF8mgruqISi8aQ+zEWHtvncoP8=@lists.denx.de
X-Gm-Message-State: AOJu0YwCgP7+ug6+XFy6x4Py/0L1iT8PiOKiP+K260tztEYya7IcVLtF
 IlpMDD0kl83TABf+UglQCoaZSfcKLUCPRZ48c2rdhlOIQkev2SgeUZrKBtq6PLFHtZ89GYwjeIi
 9xroubyqUSEtLqawmZj5uRw1AH/y/xBJ5U9Aq
X-Gm-Gg: ASbGncsY4K9U3VtLhMBEyMc6eRzexy6uVvKDcv0SWE9+Iu1Hdka5MXCx00Fu5IfVTHh
 12L06ORo3zvpdazjFFjLHvEIWXpOy5GyN
X-Google-Smtp-Source: AGHT+IFOCR2ugkfatyHkKDQRRTD5vs+w0TTyGlYs+NuWNZrG/Pccki4aKeNtNcPTtdYsvKuBZG9J9GLg8q8Mgn4QtU8=
X-Received: by 2002:a05:6402:4495:b0:5d0:d3eb:a78f with SMTP id
 4fb4d7f45d1cf-5d3be46606emr958034a12.0.1733428570741; Thu, 05 Dec 2024
 11:56:10 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:56:08 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-4-sjg@chromium.org>
References: <20241115231926.211999-4-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:56:08 -0600
X-Google-Sender-Auth: zhjYQeOULWzNcgXpnz0VGl-nkp4
Message-ID: <CAFLszThvHoKgrLeNp9jQxU3E65v4q-Wn+23DHjs3Ry9tWto+aw@mail.gmail.com>
Subject: Re: [PATCH v4 03/19] bootstd: Add a function to get bootstd only if
 available
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
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

Provide a function which is safe to call in the 'unbind' path, which
returns the bootstd priv data if available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootstd-uclass.c | 11 +++++++++++
 include/bootstd.h     | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

Applied to ci/master, thanks!
