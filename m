Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E80CD484C
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 18:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECAFC86B6B;
	Fri, 22 Sep 2023 20:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ObSUCGst";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3213586B09; Fri, 22 Sep 2023 20:29:05 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C120986B38
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 20:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d852b28ec3bso2880015276.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695407341; x=1696012141; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NBXs4zrlxtVv5JNSN8CJBiADDgPBolnGt3wSstPSEj0=;
 b=ObSUCGstXvUQsF+WA6Cad+NR2JupFXEx2Fb4Us676q5DnHEaTwFgfE6+j5snZhxn1e
 5CP8rBmMtCSVtsfy3ndAELr63kqWbpRN9wMjNpi2W5EYrPF7442PQlXU0hEbSHYWgia6
 C98/ES8eawRKpfiqwYI92PSKvBeMymi0Xo3xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695407341; x=1696012141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NBXs4zrlxtVv5JNSN8CJBiADDgPBolnGt3wSstPSEj0=;
 b=taNr2epozN6dw/X2Pnw8f25KoooIq7H8WPVzEB896h4aT8jvyOknutTsiE+/FNt5lx
 iYDspyBcgj/bbyxngameYAXzel86p33BOj4d2RnXVC3qFbNp0vdi+FIDKWIWWfXAncgi
 RqjzU9Z7aRNmVhaEvlWmF40nGyN81DBnDaie1lCONWJx4HAKCzFdmPK9rOw4m0pqtEgu
 UZbwFHIiKTFHxRZ3Qs3MrMFFnGnZfzWixS1ZJFxSv5qBooUXXslkRXV1UR8Qv+dsFySz
 IWa4eR5Gu58vgIEeuQDZYuLtI3AM5r8abv72iZb+xUTGH64LPkeukYKrAvo426Pp5b1v
 PGNw==
X-Gm-Message-State: AOJu0Yw4yblu0NvvaDKIzT4VM1NErWpco6+ZwTWwcI0c9CI+Inqi/WnJ
 lh1uWLr7bSyB7opzD+e55nXFznOqC8cNl2gBovW78A==
X-Google-Smtp-Source: AGHT+IFaU7/YeirssPx2UMsWAD6NerDQOgxmQE5gaxE6MDBqJMdRC9pUmoaptYR2pb/p3NXbX3efgyKnkTz1dkoHHoE=
X-Received: by 2002:a25:8305:0:b0:d78:47a:d76e with SMTP id
 s5-20020a258305000000b00d78047ad76emr84497ybk.49.1695407341316; Fri, 22 Sep
 2023 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 12:27:28 -0600
Message-ID: <CAPnjgZ1-pZyKLat0Cimqc-9AKt9hEEOk9p2SbQJzKJyXo21-mA@mail.gmail.com>
Subject: Re: [PATCH 1/9] cmd: bdinfo: Optionally use getopt and implement
 bdinfo -a
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 20 Sept 2023 at 16:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Add optional support for getopt() and in case this is enabled via
> GETOPT configuration option, implement support for 'bdinfo -a'.
> The 'bdinfo -a' behaves exactly like bdinfo and prints 'all' the
> bdinfo information. This is implemented in preparation for other
> more fine-grained options.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Nikhil M Jain <n-jain1@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  cmd/bdinfo.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
