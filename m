Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5395CD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 17:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C51687EA9;
	Sat, 30 Mar 2024 18:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izTSKpUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DF2C87EA9; Sat, 30 Mar 2024 18:38:08 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB37287E4D
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-29f66c9ffa5so703529a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711820279; x=1712425079; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CW+ZOZq4kmeppxN1iVYS0aDkBh6Sgk8G/c4IAsegdok=;
 b=izTSKpUiNAZs1jCtlvqt1LcFgPg+FHXKrXMTxVrWgAHu6QCkqsiIbzi9fpPm87EuJR
 6BS4hGK++4iiasnWiYBMzpMJlLI+yYUwlwci2ggrKy1UVqki49RT3trpTEPpigGPFkU5
 2lFvyaL1juSXXOJpPN8GqGX8SoHWNErx2+QQmNoSA5M1Z9NqRCYsKNijz9TbQy6V22gT
 YhSE3nEWxl6Z4Bon1kwL9Kq300nfphexk1zgiaouvOi54mYDiqYfBNV9/FpHfZbwIXsn
 n1WDs40OzO2l1N8esH6P8ppgllXs8rM1uM6ZKcLTRRzxWq1X1oo8t+QZ8dCHhszUfZpR
 m1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711820279; x=1712425079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CW+ZOZq4kmeppxN1iVYS0aDkBh6Sgk8G/c4IAsegdok=;
 b=A4BuKzXFea9IXrwwggyAbi4/Umu8dDGlxbsR9nogZplsExrAC6wvcOTJbzu8LDFDMC
 OAX8cArncffY+a20mm8WXmuitJ5mKwyGIV5IislSzEOQEp8dHyzBQDYlW5kKExpYFHyk
 llBxJMlA668H9GvjzyiDhfIHjHrJCwKRWQYoJpbwhTxU/6yTwF/X5bEwAKEJs+8bceVZ
 HZrO3SxAUddWgruWfUWGUtlAAeSuYRO5egV5UROnOEGOsiXr2pwaKYCALukiWSfLqzR0
 GiP1pKDwfFnZnTCnvmjEpfSPpdTCu1W/cZyGhTFi9BJVjFlzq7uIUMX0v3sFW8ncdqy8
 CvhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkAHY4rEg/RpYHP+f93VqlZNlsecsUfHMULmZYRrFPsnLX+FvKoQGQ2k8fzNtjmH5R5TdB3cqrglzYGDvU+HabPvMU7w==
X-Gm-Message-State: AOJu0Yzqch9+ub7gep3Sk313tqRFI2A4qO53nBgb4itkE36EnVPiX0xQ
 JSmxtZTrdYX0lkxQ92T7RwExt0r0974sF53o+fiqg2me6bImW2+igf3jTGxyLNmlfluNo2THhsA
 K5l9ZdfwKF+1X/GMQ06oUATnX1lI=
X-Google-Smtp-Source: AGHT+IG2pGroV4jfIGVtq7Q9oICaJdcBIIFY7/YmfRVyO3JmE+gIgLWuKQPCHVO8Z92Ov/ifJBT68yNf0N1Y67x6Vlo=
X-Received: by 2002:a17:90b:3d2:b0:2a2:308e:ff1f with SMTP id
 go18-20020a17090b03d200b002a2308eff1fmr637870pjb.1.1711820279474; Sat, 30 Mar
 2024 10:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240327141849.2126157-1-festevam@gmail.com>
In-Reply-To: <20240327141849.2126157-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 14:37:49 -0300
Message-ID: <CAOMZO5CvwYDotFWhV5ATuyS8ar5NsxGogBL_=QrvbVsOo71Ggg@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: Convert to watchdog driver model
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com, 
 u-boot@lists.denx.de, cgmeiner@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 27, 2024 at 11:19=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
