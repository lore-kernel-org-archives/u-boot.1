Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02741C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA5C87CD5;
	Tue, 30 Jan 2024 13:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ff9sljsn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 202AF87D67; Tue, 30 Jan 2024 13:39:12 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF32F87CD5
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:39:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29593a27fcaso371216a91.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706618348; x=1707223148; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gp25CEDiYPT9zb46CEmrnvHoMGfIkDVYM7Kovc9PixU=;
 b=Ff9sljsnxS36xs/MHPbhivUJ0lCca0lLpQ7nxNMxF7AiLq65ukd0hfoZSbq2T8JEvI
 j9kLP1JHyFNaQ/Zu4korFn6cbhZyrLe1rnNmt2Cu5Yy3HbxsIQrXT3YW6eYiNp1EaUNT
 hnmjI7h/X5hVB90qIOdmGwxayosLTm/TEkRtda3K1pvKSMhg67fvnOV/GFbn6GQvTRCg
 vpXtzH9xuOeq0wapgfDrtlJfNiyKoBSqYsUXsd5RZIN4MtKPH7Sjs02sjkBFULlELr0a
 pJiKhoP+TubYDwS7ay6T6DMBnLRPMVw0Y5xu+1AGhD48ARIgmDMrKvjyWHtuLnWelqvA
 H3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618348; x=1707223148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gp25CEDiYPT9zb46CEmrnvHoMGfIkDVYM7Kovc9PixU=;
 b=kxS6l1yWq5y87vpjqB34lQZBuGmZh9RrC5Xd1xVlnCdVwau3SOVVVW06fnvCslMa+V
 TKZ40gh6niOFIxQyFVqIyVLegyIdrhyRSYR846bQVmPaM1lMQI+Tk32NO1Ynb7Pfw/Uy
 LY7Pyp6gVvMsLyrbN1j2nPMNHEnNigfZKF7L7XlJgwwjKHdBvmnignHc4r2ZiVu7kHeL
 OrnD2kfzXQ+O095gIuVHHaz4jN3SMOM4tl9pFcoz4CPke+qEkbDGh1w9aJmjS186AJ94
 gfr8ARw2XFOcbpGbM8KNQ8hIaQqifWDU7QZQP5WjFefRIClNcEAheOLJlPwXB9RkRhhn
 gKuw==
X-Forwarded-Encrypted: i=0;
 AJvYcCVHM+AN2yoABiJCiq62LMamxEaC4R6v2D3txlVCl6qdk/216djGM2y4tSC0bRfhojZfwZpl/NPw1RBIlsuLNUM8ZYM1jQ==
X-Gm-Message-State: AOJu0YzM3zM9ue85OYyDypYVxitmQl5qk4Ur7UFJxIg8snrG4tBNOes0
 joJRaBIUpEkMMzbdeGMPqg64PVLOcEj6NH8Rzuuya/6GMSNo2FDZO10ggsv1piDMg3IAJ3TjchL
 44y2j45sB+UUwtOKygYKPSupVdC8=
X-Google-Smtp-Source: AGHT+IHMYnIVx2LPPT5zZpNC+mR58pbGTR4d0O0al5KVa0KlCCMAjKgjBbtsasSp1LBk+amiaglxtGdAEgbWuwIGH94=
X-Received: by 2002:a17:90a:8cc:b0:290:8cb7:fa28 with SMTP id
 12-20020a17090a08cc00b002908cb7fa28mr9375321pjn.1.1706618348278; Tue, 30 Jan
 2024 04:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20240129-usb_support-v1-0-8bd2fe84005b@phytec.de>
 <20240129-usb_support-v1-2-8bd2fe84005b@phytec.de>
In-Reply-To: <20240129-usb_support-v1-2-8bd2fe84005b@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 30 Jan 2024 09:38:58 -0300
Message-ID: <CAOMZO5BJamx5H8VZQW4TsKnYWfxJB7hHyZWv_n52jW09HwYs=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] phycore-imx8mp: add USB mass storage support
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Mon, Jan 29, 2024 at 4:56=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:

> +&usb3_0 {
> +       status =3D "okay";
> +       dr_mode =3D "peripheral";
> +};

Same comment as patch 1/3. Please sync the dts with Linux.
