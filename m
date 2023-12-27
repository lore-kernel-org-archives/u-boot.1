Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53A6C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EEB187935;
	Wed, 27 Dec 2023 09:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KN56jIAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1011287944; Wed, 27 Dec 2023 09:31:08 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AABEA87729
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-427e7aa0207so4491311cf.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703665864; x=1704270664; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcWYmVsXOxqKPA0vzcJxc54swf0BRsJILEJvwZ0l/5g=;
 b=KN56jIAEy7Z5dQDRTYmQ9lhNrZWuxfAzqM55FO8gxxEgS38yzP6XjRdQKF/d58seii
 K8R6jrQle8ZaqbqP7d4IeSlKus5tW66A6zOrtmzeIjQ8Qhk4eNOi6cqcJ7z0wqMj969e
 bLbp9e/561+7hxwz/Bjh20VZMDCGMGbmLo3bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665864; x=1704270664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcWYmVsXOxqKPA0vzcJxc54swf0BRsJILEJvwZ0l/5g=;
 b=Q/uXQ4h2vFJnUaC9d1fC4TxL4bxjTWp7hE3rJuSNPYJl4v417m33Tirtc67tiujxZG
 q/g2D9e9fJJZZRAHmVnPEloKlbAm+9oCQFlTpdlO4Skcc2C1PFCcwFqcdOVfr5nyAk/b
 B733hmzfYDf1YW5i6y+YdkmLtCeFivTt7o5WbNAU6kKMr3cIugdk6vULcqS81NcMKfiz
 /ncNOxntuYvehZRND/gRtJW3ub7o8APHIi5ZQiKfljy2XWpztcL3bizc/tLjzvSgMYNd
 ADlBwEDO0ZqPAwJHEUGqWlGNVRtrY0fuZP60mIgDvkDQ9Pn6cQPeUR+dFiJXoJChS1sv
 mB8Q==
X-Gm-Message-State: AOJu0YxB6ALvG7FgdGG/sPEMdXNEHTYgmNS/OnkbkKFMZX7e/A8nmsBP
 IInZmluOborGCo/Q0CK5VfhQpysWS6umZcL04IL+nsu10ZK2
X-Google-Smtp-Source: AGHT+IGqXXeeFnGBNlgnvLqbhpi91fzlSg5bh0vLz8EZAmijkcKMR0pMXExfVDyD+V49r/XDOYG2HWzBzBbmu1b9P1Y=
X-Received: by 2002:a05:6214:262f:b0:67e:aa84:b093 with SMTP id
 gv15-20020a056214262f00b0067eaa84b093mr12968971qvb.22.1703665864525; Wed, 27
 Dec 2023 00:31:04 -0800 (PST)
MIME-Version: 1.0
References: <GV2PR10MB669453D14DC8722F7ACA97FB8BBDA@GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <GV2PR10MB669453D14DC8722F7ACA97FB8BBDA@GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 08:30:54 +0000
Message-ID: <CAFLszTjm4S64z6sSH-auGqDctTXzkh=aGp4vjR8orE0+FTZcZA@mail.gmail.com>
Subject: Re: ACPI on Raspberry Pi
To: Ba Gia Bao PHAN <bagiabao.phan@st.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

+U-Boot Mailing List as the attempt to send did not seem to arrive?

On Mon, Nov 27, 2023 at 4:51=E2=80=AFPM Ba Gia Bao PHAN <bagiabao.phan@st.c=
om> wrote:
>
> Dear Sir,
>
> I am trainee at STMicroelectronics France, and I am doing project "Settin=
g up a boot chain ACPI" for STM32MPU. The objective of my project is to rep=
lace the Device Tree by ACPI in STM32MPU.
>
> As my research on the Internet, specifically this website https://lore.ke=
rnel.org/all/20211201160315.2203099-1-sjg@chromium.org/T/ , it seems that y=
ou have succeeded in configuring ACPI on Raspberry Pi. I don't know exactly=
 whether it worked or not and how it worked. Can you explain me?
>
> Thank you very much if you could take a moment to reply to my email.
>
> Sincerely,
> Phan Ba Gia Bao
>
> ST Restricted
