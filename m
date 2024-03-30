Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108D8C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988F886DBD;
	Sat, 30 Mar 2024 20:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7S1u8R4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A416986DBD; Sat, 30 Mar 2024 20:44:59 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DECE83334
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so953530a91.0
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711827895; x=1712432695; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcfGM5FYAzXrnNeYW5ZIACxJ3K+i4bj35tq8yWcfYxI=;
 b=C7S1u8R4O0KUgtJwktIDTeIvdsz66jf1C5h9z6ld9KGRP0eLonPbPdBCbuFBvZObUE
 o4Tir4dU68vcsk7SrvIG7Pa9fFidEsseFl78aIlJianngub2qAZMiayOpsEdH0Xk9o1I
 g1aa9Eo1GsdWq0hBQNhnOBl66lm4PJeyhSA4sNlaqvCTja8WGHiXZxeWD8Z6TbwwtNsZ
 U57f0zbx10XhOTr8f9Z2+yRWKSdeZZxnzTiwtkNE3HDLkeUQpByIPAWV+Cto5N76ytGM
 s554+EF0r+gusPgHxyh9W0yTe3qI4T2X7I06WFcUUbf2yLoEKsujIAm6cpcTuwW+JtdI
 mEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827895; x=1712432695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcfGM5FYAzXrnNeYW5ZIACxJ3K+i4bj35tq8yWcfYxI=;
 b=Ulh0MxeiHPSXL4k1xXYinMeWjg10wniY8VY2jBUivV4ze7YJzvS+h5KX+h7DDt/+1h
 QUv46hBo05W3jKqDA/I6ylhkRyQx8kjJ/32zK5yECIi4ep2AzmFuAdGp8bTy8ZU1UGj0
 nypLAcM1aj2d0E4UrD0Mxm6DLTm93xp+9knZ78T47fuB5j3+6heRcdFu56VEZCp/EZ3f
 OXyzQmHorEt+fEEg00CexpmNG1Fa6Y7vnD/kgdrsAlLYfG3j6P8O0JmQ6j7hOVIzGzNh
 TvUmgQsDIjjvKRDeuhxgyY9+mFXNDgD5Uh16aVvkOc2FtVop8Lh4DtXx6XfEzO0QeFLV
 +mdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlGgd9qXf04dTRlkZoYOsXXaipXVwIKqcdlq6CHdCl8p/zgcjeZpo3cBm5wp5GmeqhRLnO9QyFhHqI2YlVEYTCUlE1Tg==
X-Gm-Message-State: AOJu0YzUbH1fN4SrkBcyKy4lDOozjgFx4oWaHlV7qjquAyjeA6q/Qmph
 iFWDeh74l5XzJdTWJRIqpFijJ5rcsl6EqtelVPruwPsWI9NpiZfJZWDI6Ed/CEzzDruM7OBv5Bm
 AXmVTJUrDIdjodEkZbdJDsQPQRRA=
X-Google-Smtp-Source: AGHT+IFZH/thU5aFIeWPpSVdXAFNTaEteK9Su9cvAq2T/P/LFRioLqsaTit3H0wSTt7l+Uy97c8AySWXzD70hKe6nKg=
X-Received: by 2002:a17:90a:6ba5:b0:2a2:191a:de72 with SMTP id
 w34-20020a17090a6ba500b002a2191ade72mr4101715pjj.1.1711827895625; Sat, 30 Mar
 2024 12:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240325135230.1777213-1-festevam@gmail.com>
In-Reply-To: <20240325135230.1777213-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:44:45 -0300
Message-ID: <CAOMZO5DV-FX=ZxgCeu2GqzJbU1kun08UupojXjAgZ6p_cwPAeg@mail.gmail.com>
Subject: Re: [PATCH] phycore_pcl063: Drop leading zero from USB vendor number
To: martyn.welch@collabora.com
Cc: parthitce@gmail.com, marex@denx.de, u-boot@lists.denx.de, y.moog@phytec.de,
 w.egorov@phytec.de
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

On Mon, Mar 25, 2024 at 10:52=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> CONFIG_USB_GADGET_VENDOR_NUM is a 16-bit number, so remove
> the leading zero.
>
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied to u-boot-imx/next, thanks.
