Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECD2C4707B
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 12:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE7087A77;
	Mon,  8 Jan 2024 13:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZqEv/w4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02196877DE; Mon,  8 Jan 2024 10:27:01 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1CD787955
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 10:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.othacehe@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5b89e2bfso18059935e9.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 01:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704706017; x=1705310817; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=960xFUV4MbGBzm9tFuzGsvcGO0dYRhyYXFk7+epCe/Y=;
 b=ZqEv/w4UM7A05dt75v0o07xRiz5X4eWw9tsLbt7FRsHWYturEJ9w9yoQhQl9+WH79m
 hUuGl0VdXsYJGLEjUz1JHOe7dkEh8nA/qWlDzMke1KzFcuDrYwEc7+un0JNwgGM5cXvJ
 Ewyv28ARjxG9+msvWFruKqkQHBdtB/6BqQo7XS85slgKxLv41J6ksMNDUqJs2viv7Ha8
 y12s4P9z2K7EFBKe7xUPeNEgjbfVHrTy5gNZ5QWTendVDwObOJTdWpAr7hERuvlIRc9j
 8DB3pHWdF5HpHB17AzVBb4E0NZOIIBhnoN/3oYfinJYPCuIPvdlyIGz4OTt320yo+cKZ
 GSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704706017; x=1705310817;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=960xFUV4MbGBzm9tFuzGsvcGO0dYRhyYXFk7+epCe/Y=;
 b=F1Z2pV8mTBFFM4bDSvQBFxcbqrTGqnZOe81wRrzrg3aMeiqDzxWseYw5A0yK4J8tUH
 0yNNDOV0WtxzzSTQXG9qvJjQ+He+msm6b/u6YHfahKKOdDHzNVM6pIw/83kO/wya9spB
 AVF9DB+dUL2jYVfLnkxI3zM9c4PlMqCCQe9i9aOrDvBJEgQWLWTTXUftkmKAu/HTr3xQ
 5zMHRbClBreO/mrZHF26C/ztoWy/gCcu0REo9kv/o0WYcmwJRT2lJ1MdrzQ8AYvWQ37U
 gyqpkuRyPPxwdJxzGq2CcXPFYzm8M6bY/QWXCHo/7WRLYPmp+jIuOp68zvrbtgU5cuDs
 jsrA==
X-Gm-Message-State: AOJu0YzgHjMyjiPjLsRiaTtdH4KSG38oiLRF9BVhXT5hXrYph3+KCMFF
 xUbUCJ2QF3hwHSPs1LeQBAR96TrguGY=
X-Google-Smtp-Source: AGHT+IEaHgCYTrXcqc/MdEm202s++QY5jG+Kr/XzR+N3PvnLgoAANhR2i0PIKj8UDehpM/TCMr9XDA==
X-Received: by 2002:a05:600c:3592:b0:40e:3772:cb56 with SMTP id
 p18-20020a05600c359200b0040e3772cb56mr1755088wmq.8.1704706017010; 
 Mon, 08 Jan 2024 01:26:57 -0800 (PST)
Received: from meije ([2a01:e0a:ab1:5c70:ddd3:fad7:e5a6:7e01])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a05600c155400b0040d376ac369sm10316335wmg.40.2024.01.08.01.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 01:26:56 -0800 (PST)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>,  Tom Rini <trini@konsulko.com>,  Stefano
 Babic <sbabic@denx.de>,  "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 0/3] Add imx93-var-som support
In-Reply-To: <CAOMZO5Cw3WE5j02GmFpGB7z4-LBA7Tne7X2TG=riTxpYvJZRuA@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 4 Jan 2024 14:49:48 -0300")
References: <20240104155357.21865-1-othacehe@gnu.org>
 <CAOMZO5Cw3WE5j02GmFpGB7z4-LBA7Tne7X2TG=riTxpYvJZRuA@mail.gmail.com>
Date: Mon, 08 Jan 2024 10:26:55 +0100
Message-ID: <87v88489b4.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 08 Jan 2024 13:10:24 +0100
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


Hello,

> Please run a CI job for your series at https://github.com/u-boot/u-boot/pulls
>
> After it passes, then please submit a v6.

This issue was that we are expecting binman to keep working on the CI
even though the binary blobs are not present. I fixed that, had a green
Github build and submitted a v6.

Thanks,

Mathieu
