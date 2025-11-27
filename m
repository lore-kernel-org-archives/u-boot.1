Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36EBD11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B2E839B1;
	Thu, 27 Nov 2025 08:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQDB49Y3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4111E842DF; Thu, 27 Nov 2025 08:56:50 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2BC839AC
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7aee74dceso179112a34.2
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 23:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764230207; x=1764835007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4luviFWyiliBN039r0lWlBOacgkLCfsNQSmF6qTa4c8=;
 b=cQDB49Y38ELXwGm5LQBXrXpgiYMs5rDrgmWZ7pxUQw27zxW81ebr4meQsRZixR31be
 71TOFWY1aKrlAMGsT4T/ncNVmn6Bcr8uDwg71pKnJdjTBIWVOvR581hGUvqRD/ljR0PK
 Sis7AVqoDJoGfNaZQhWHC/noFPPKfic8tOjtQ5+ZP5Vp9V0CVBChwuz9DfwG5OOoc1AT
 g+y5sBcolI9R/WJ0FhmpAreNEoKnAwICz+IYdMnEI/ht/nJFPZM1rV32pUUuBfNC0Ub+
 y8h7y+jCCJR+wnw4X84kABPWyh8l6CEmYBtB8y3XE97ce0Y6rpHiiugEMevVhIdmp+5K
 DsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764230207; x=1764835007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4luviFWyiliBN039r0lWlBOacgkLCfsNQSmF6qTa4c8=;
 b=FFryEtUq6kKU5PrS/kVk7+v32EqtOrF27PxutBBTZ7KXGT74q8zf+UcLYFGv8YPmIH
 T1ZIYXiN5FLa5XAGfIbZ4zOTXVLUUTKnK/uVyr9WmynbAaCljZIuzwmqHkLXpMhMCihw
 crilfcLHDL/fqlfhOeUnCwMS0M8+I2xL9/Vm1VPeKoBY6UD3KWR2j4vcjzRkqWuqppEH
 fKhxDU68yJfirkxVKKHmkcWfE8QIyvPKus5BooR4jen9BpablnqLGTe/JABA+DCPAHhr
 1xb4jpY0/Xc9Ci3yQqqr4gvoPTmxMWlY4pzNC1XDBnPdbaTvAccT3AevOcrTKuoMl4YR
 7uyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgry+HKBAj+pJcmnk81MOGejKPRJezUUwBJKgnGlQXuhNpHU8w0Zsx6JICSVCH0NJn7asZKv0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr+YqsUWKAsWyZK8XAzcKR2xmO3hvgmUaYjhEp4VpWn2aNf+2T
 bYBEDQVgaT/lHMzJ3OUAAYVAQnluDSTkK34uCj2sly5HHgLSYJAhXYoyKWFpKRQcQ/GDk2lCyQT
 3WpI07pSpI2d3fGmt+xwp2Uv+M0SjzrU=
X-Gm-Gg: ASbGnctBdpPH4pfr/LviaEV3L8XiZFBRy9Ej/ERvqjAk/muiHLITY8UlB+Y5h6hrtdA
 LJeSFCO0GU3pf1ueZUrqnpdtC3mH8HP9PEUx3nU3K+fRVZpWIfHphfAlxR1cqzxd2TV3sIbYgbd
 AccBBF1ltBqsNbYWatAODA47mx3UDu1tyQh4Pno8s2eSiW1ZMuL8Un0qWlND9xam1t0lczedsA6
 Ij4Ub4ywWlcaY1KzWstlhlviTExZJGtU0y9FrwArihVxZowCM7ZptuyzaSPerUC6n27TNk=
X-Google-Smtp-Source: AGHT+IFWJo63KMrmkrBpynE/r3NUQSUCGoiZ8xyeDKaSp5/QpAbe1rc4b8AvU8L6yo2TQHx5cdAs3P4TrUNlgCPFIbY=
X-Received: by 2002:a05:6830:310e:b0:79c:d43:52f5 with SMTP id
 46e09a7af769-7c798f7ff5amr10980744a34.6.1764230206855; Wed, 26 Nov 2025
 23:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
 <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
 <75a890fd-48c0-439e-962d-6fa85fe67953@siemens.com>
 <CAN7C2SCSr3h6dJLEXrUEdvAHQYyEfo3jWtkUkNccSWYTv9M7fg@mail.gmail.com>
 <0c42e18e-60d7-417d-9b83-dea8ffd4a362@siemens.com>
 <CAN7C2SDH6g0PgDUsu8hEnEA4yr6z+YA5afWhK9-D7-7wBbe33A@mail.gmail.com>
 <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
In-Reply-To: <b977adfc-f16e-4436-91eb-8824932379af@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 15:56:34 +0800
X-Gm-Features: AWmQ_bnXpFZw8Sf2Ex_cLe7g25Jzf54IuISzcJK4inVxDNDxW11pg3UlHGX4pQU
Message-ID: <CAN7C2SCiTqJDK2ZVjJ_859NEDg6tD3KWQqzVHqqmbyM8+aBvLQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

> I would recommend studying my raw-mode loading patches without looking
> too closely at your own setup again. You should be able to spot the bugs
> I try to fix there.
>
> Jan

Open minded, point out which one please?
But since 2025 07 I did not encounter any major issue.
On mainstream. Maybe your patch dates before that?

Thanks,
Brian
