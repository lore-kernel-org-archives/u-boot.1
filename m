Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68744E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3AC80615;
	Fri, 20 Dec 2024 05:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nu2MeaMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C70DE803CB; Fri, 20 Dec 2024 05:06:54 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C08B38036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa670ffe302so284431766b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667612; x=1735272412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G8mcgQa/dCKyqh1py7a8KOV+da0Squ2hMp0aCoSJe0Y=;
 b=Nu2MeaMXGVVK3Flb0YuYj2A/T/pLpSvGSelh8dgwfDvxcJ4PGAmf0Zww8mfUJv/iaR
 euIYvp3DRAdMEeEnwOGtMhv1LpmSpvsvJHxEP2feTpzPqDtObctlDtQ7LuurN+f7T72p
 Pw4TGlWlR/kKEDI+2G8kILKiqpGrlaWIzSesQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667612; x=1735272412;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G8mcgQa/dCKyqh1py7a8KOV+da0Squ2hMp0aCoSJe0Y=;
 b=wKITy8jS9/Jg23OISMzzHlgLba75LVsUg2Qd92Y09w/x5f4B/UZS41tEEOyMDxc3k0
 5tNiF5D4yzWkIdz3zEd7NvZHmPR3fadHrqpVwzR6dxoJ6xTHv+ss6Oa5Ee2b2dm7yCow
 R+lg7L9CKslXmPyhmzPqmntnnUp7LmVHywAxgeBXOVbC3K72yUFU/JdR9QEioMx+gCyY
 lbiTQFD2z8ZAQfNkHPYNsE/SxRar0+vh5sppfY6g+m6fMcz8gqjnkbEzKHamu7bImI7B
 H2q8JcfWti3qWzItBqOYaaO8Rr5TOSVYJ/wQlcrJEEj1hFu/If6Tng4Yycjm1cTRpOvJ
 PDrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3sTfx990mk1JCZWA1tDbGCgpavezSkZUb1XHgESX+1gAVVFSdQMe725Ra0oBs3Vsp6bMDL94=@lists.denx.de
X-Gm-Message-State: AOJu0YwAmwgkFQaXbKkn4pcS8pPoAzds9ToVY4foxeNAashUHY8y7anJ
 +jp5ZKH4PRneBk1dEX8LcXuayq4lLWj0SL8RVb1mV2Cg4wQXX6Y/y84OxoUtmf5/6IwXgJahgeo
 i6Nsqrn2J3eBmmSDvyM8p+IsWBdJhRcwvZxnq
X-Gm-Gg: ASbGncvPFPJYtZiPDwY+F/4d7iDcwbU8VJ78o1WadmlNMSWttwT5bJ8W8dP8mdsTUt4
 6i2okl8Z0+YWxT0iY1iz9vjDzZJWvlvQwuZP6oVQ=
X-Google-Smtp-Source: AGHT+IEvBnBfXFeWHMHOLOMaU9KlF9YJWrMf37HY/cevQiEXI/gPi5RjqanjBC3W/kP249cuo7ZsU+HiEo5UiEL9PQY=
X-Received: by 2002:a17:907:3e14:b0:aa5:2a57:1779 with SMTP id
 a640c23a62f3a-aac33691a90mr99947266b.59.1734667612246; Thu, 19 Dec 2024
 20:06:52 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:51 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-6-sjg@chromium.org>
References: <20241206023626.2456858-6-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:51 -0800
X-Google-Sender-Auth: oZZNAEpULRSO2netkILkKsrQoPI
Message-ID: <CAFLszTg2582sXiVK1nHoR-yrjjTum=EULMZF92OLUo0c_TaObA@mail.gmail.com>
Subject: Re: [PATCH v3 05/46] x86: Rename state to bmi
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
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

Use the common name for the struct, in preparation for passing it around
between functions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h |  2 +-
 arch/x86/lib/zimage.c         | 48 +++++++++++++++++------------------
 cmd/x86/zboot.c               |  4 +--
 3 files changed, 27 insertions(+), 27 deletions(-)

Applied to sjg/master, thanks!
