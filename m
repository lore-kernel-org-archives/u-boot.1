Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0474C5472C
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 22:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5C088B16;
	Tue, 27 Aug 2024 00:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ub0Dthpc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1803188B63; Tue, 27 Aug 2024 00:54:28 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4B6882EF
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 00:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d5c8c1006eso3623966eaf.3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 15:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724712864; x=1725317664; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8eYYgsmkka06JXMdoigsifVlBRyVZKL7Qks/S20TJM=;
 b=ub0Dthpcq7I2CX2OQi1ShWLG4QBtFKOupegTJGIlU3XoayGmlbSrTHf/KKokcK4iqd
 TpyGkHaUFshl78tjHg4Ph1ZN8bBHZUGBbOSOePnLKlpjHSuF7fCx5DWYGn/eusS1VGAW
 AwMHVlBhWQ0EIUe5hbWkmffF3ia2/tqp1GQqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724712864; x=1725317664;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8eYYgsmkka06JXMdoigsifVlBRyVZKL7Qks/S20TJM=;
 b=WkyzA7ix1tpf4rShqJEGHoh/aTqG6SPMPCvdXpdNhAfwM7Vwkq7ai+xm/pd8XtYxRO
 9kFYm8BwyXo91cBv0fgF1YDvwMbDzPbI5O4RbLpsQNoVOCW8/wvsqxM/1dNwHpoZMPxN
 UY4KTgA4WGmp2zhfn6M6yCzLCY2fHt0ujOY3ls2IW3vTnS6qnV6kOTQ9gPz0MI3l+FBt
 FDT9iig0v+IzMTkawRi/SOKdYkePEd9mdelO7h6Qhi+ZZryFiln4Rd/US3xbbXWFFyrU
 5xgavburab1D2BIb7dO1U8JW1RMnM41r4Rngz7sxpqvn7FctnbRB5obd3qrNgeyX0opC
 4tew==
X-Gm-Message-State: AOJu0YyNru5+gp+2wp541YiplAPVK1sfeRdsEWie8tY0cdPvxobkDDmB
 sM3ug12HPHOVtoUGKVKMgStcnlP6h9qw/vSiJDFtrLb0AySnUQWY3BgMjqN1Qus=
X-Google-Smtp-Source: AGHT+IHb6wWp6V4GO5Oo50zuwwcXPzRB4H4q/DfsQgdfO20RY3rthd1i/E29cW7HJzVAvGHQ3uY1mQ==
X-Received: by 2002:a05:6358:891:b0:1b5:a060:6c76 with SMTP id
 e5c5f4694b2df-1b5c20c5ec9mr1473468255d.2.1724712864064; 
 Mon, 26 Aug 2024 15:54:24 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f41d415sm497888585a.125.2024.08.26.15.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 15:54:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Albert Aribaud <albert.u.boot@aribaud.net>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20240823202713.430219-1-sjg@chromium.org>
References: <20240823202713.430219-1-sjg@chromium.org>
Subject: Re: [PATCH v3 00/35] global_data: Reduce size of struct
 global_data
Message-Id: <172471286303.2816530.16130724739921537085.b4-ty@konsulko.com>
Date: Mon, 26 Aug 2024 16:54:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 23 Aug 2024 14:26:38 -0600, Simon Glass wrote:

> The global data structure has grown quite a lot over the years, being
> the best place to put an important pointer or something that must be
> accessed before and after relocation.
> 
> This series attempts to reduce the size a little, by moving some things
> out and shrinking and aligning some fields.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


