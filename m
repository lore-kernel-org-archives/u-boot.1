Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9886AC47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211D687955;
	Mon,  8 Jan 2024 01:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jA10C0Qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6699B87987; Mon,  8 Jan 2024 01:16:12 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79D587A21
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-680a06cc763so14526716d6.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672967; x=1705277767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ddUpOk2usaLGLkE43W9/jzm7lLQnc4E090z3310xteg=;
 b=jA10C0Qgc7D3uZYdH9NyNI4DRoiE6XtXo5FDn2Vna7m8t6fwrVzSTgErmVV0qmlEKz
 4IXFGXhX1xJUEoawTeaOZwajpSYyB2W2WC6e4o4LOSFWCTrGER/LdeF6dIFhbL2Yw+Xw
 5YfMuYaOsBs1/eZUIwhsx/PsEH9ZquFk1cik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672967; x=1705277767;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ddUpOk2usaLGLkE43W9/jzm7lLQnc4E090z3310xteg=;
 b=Ozaeq91FrtNBx9uDeq99TebnLKzeUB2hc96H9XiscD7F2BmSH3/NMuMoxl53DDhD3i
 oFTRAEEYURGVE2SaZCqQd2VYQ2+J+0Fj4450/C0AvNB+SgiR5Y2OqGIvBmuz3Pbh1eNI
 3mRP+XebQvlr5lC58GWaEEHv2P+ZtCYWK9KxwFmWskM6f+MyAoyifiOJCKRiI7Ldlswn
 mp7PFznQBkhEGffXB9kAHE6ib7RqaP5Ba7kN8E0kjrTokqchhHgd/plu8rWMEvXgXoR0
 TDqFNB8h2wh7u5W+ePtryn4HgTKUh2+WRXL8EHxV5+Guwytj9zZHNX7Eoa9blFup0hbL
 CBuQ==
X-Gm-Message-State: AOJu0Yz9tUpHf6TV1u3h+ukyi7P7wOXlVPUXa4i96yJ3QVVCjG49uJP7
 HR3kcXvJTJhLQny+hrUC1zrXKyhWTrutgFyScW/vrcMnDXAX
X-Google-Smtp-Source: AGHT+IGYCCRIyrEOZV0lEOHFFPjiGCz+nopmbPIZcGWrj0aTiiCTrxDq8W3b3YwSjwyrWTLGpsQ4kchSO0TdWQBEKYc=
X-Received: by 2002:a05:6214:e67:b0:681:9d1:532f with SMTP id
 jz7-20020a0562140e6700b0068109d1532fmr205710qvb.94.1704672967786; Sun, 07 Jan
 2024 16:16:07 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:07 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <1E62ECDE-F9C4-4035-A51B-53A083D61C62@gmx.de>
References: <1E62ECDE-F9C4-4035-A51B-53A083D61C62@gmx.de>
 <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-11-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:07 -0600
X-Google-Sender-Auth: -MoO-LxP6mXPyu5IBBFLO0d_OjE
Message-ID: <CAFLszTjxyyt8xjGVN2zF4YOg-C3EHogkaMpbfnoHTc+TaWtnUQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] acpi: Rename test
 dm_test_setup_ctx_and_base_tables()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Am 31. Dezember 2023 16:25:53 MEZ schrieb Simon Glass <sjg@chromium.org>:
>Use the word 'acpi' in this test so that it runs along with all the
>other ACPI tests.
>
>Signed-off-by: Simon Glass <sjg@chromium.org>


Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>---
>
>Changes in v5:
>- Add new patch to rename test dm_test_setup_ctx_and_base_tables()
>
> test/dm/acpi.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
Applied to u-boot-dm/next, thanks!
