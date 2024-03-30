Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B88CD1288
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE21882B1;
	Sat, 30 Mar 2024 20:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E60FxuHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03892882C1; Sat, 30 Mar 2024 20:50:33 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E323287073
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29df844539bso950363a91.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711828229; x=1712433029; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPE0Y+xVZIEnJl1sqqyMF8x0O1fGI4ohdc+ZNRGL/0o=;
 b=E60FxuHnIPR9oTRcgA5I0e8K9FqOLCXg3ivObs70uNqSOgntoR2Ga47ADe8OenWdXk
 6Q4eGANo3uPI0mavQ5xi3qt1e4aW64WdEneUYHM5mRWUjg7+b0Pduz17V6/eb0TNvC1i
 6jFSdzwpxm2E1JfSh4m7doa0ZD/ZdMLvlBJ/PuO39Jo00T47SBejoFAjbmH9xjgyl9Re
 vKKWqCtHxioXUB1vwTzyuhdTOh8ogIVrqXnMDJnGh+BONVdvQMzZjFHmLxlEx3f+r1RF
 CbeFHruPgwlU2/1YXkJ3JWfewFqClacAxByWsyUDuFUoI/V3PyzgNQaWB9ClVPJZ632o
 Oahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711828229; x=1712433029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPE0Y+xVZIEnJl1sqqyMF8x0O1fGI4ohdc+ZNRGL/0o=;
 b=MU6J6VvT5BrGu39hA18qVMRNIqEDkx4uqUvwio/3zK/a/IFQ4WBLZqBJgDDCxr05ht
 41wlTZDdMDToGulOIaiIxs6FdFxmctOnliY1iLScdf/UxDNeaOCYIH3f9/pMAyYSQb+R
 m39axYKsEdPxfCqiiq+9cOZcuOD16ovklRUYbD7NoGh1Z7B+DIYFIPvw6CSgOPyZir8j
 /Q+JgGlv4MqzpivxMBmdnZpfUWRQiykCusU2qlSmjvPoCvwP9jGKz6G01NUx+ue30qHK
 zeooOV6x/uV4MjmMDmlO/+omI1lRga9oATWVzE9hRQymyqhuBsqKyWTGV87DcaPWh+kW
 97ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh+WFwG52c5Nz7n48HFYNwbYv50aDQ42YHjpY3yZfo4kCDVaHSgdRLvD9ie+xma2ZgHOiNxzRlBT4LR7I4qt1rPLyaIg==
X-Gm-Message-State: AOJu0YwUk5CYvQuZTttLm2DyxoTHS9WQnVXgl5cYJDlO1va5DVeyYHLI
 KkPZrfGptSZztFf5CiSZW9APWip6X1hJx3VZym7qtfsu8JMLcV3WUsnCEEC7KQl661km8vUDMZi
 WTCfEFQJeBDxaB45IQC4WvXnMx4x4/HawnVk=
X-Google-Smtp-Source: AGHT+IH2GggTOWmtiIQTp9cxwYZOuMxRf+8k1ss8OaF6kYdgBASsU3V+59ZZXPEyNzWgg/BXHuz4AIzTadCaFRzC0PU=
X-Received: by 2002:a17:90b:3783:b0:2a2:2d11:c637 with SMTP id
 mz3-20020a17090b378300b002a22d11c637mr1453735pjb.0.1711828229483; Sat, 30 Mar
 2024 12:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <1711622999-62247-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1711622999-62247-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 16:50:19 -0300
Message-ID: <CAOMZO5CL01iZWNX-Zb4cKz+O6wZUZp_1d0S8JwFSCWXWAGfhJQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: imx_tmu: Fix TMU error on iMX8MQ
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 ye.li@oss.nxp.com
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

On Thu, Mar 28, 2024 at 7:50=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> imx_tmu_arch_init does not implement for iMX8MQ, error is returned
>
> Signed-off-by: Ye Li <ye.li@nxp.com>

Applied to u-boot-imx/next, thanks.
