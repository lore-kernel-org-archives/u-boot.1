Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05D2C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 18:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78CB8792D;
	Fri, 12 Jan 2024 19:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CpPiwXbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81CD87561; Fri, 12 Jan 2024 19:00:56 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3AE38797B
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 19:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d3fe03b6b7so13950595ad.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705082452; x=1705687252; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJbO1S4hvAhgBp4DvcvkU8L6yZKagDoYC3gCT8cIoh8=;
 b=CpPiwXbqD1AxUocStUcEQhrCWYsdhYvfpKVLJHU4KVyKydXdeHQ4oC7EBSX1GKl6yy
 ptcSMbtaJfVqHg3vcpG0GZPVwLyapDcXZpO9F5DxWZ7MWLnO6bJWH/TWGWtPxbRMI8I1
 YREykS5gmIdQuLqZV6LDTKKZIO71WfXoXiNxaAXGDX96Zd681DVcTnkBpFZk3gYAjCzz
 JugfTasQMtmuhDR3agLYNeQeNzTtZ2utAwxvlvaG5BFAVa2C2X/dT7NM+g2JekQrwZy4
 SYN8Vw1wQusG+Aufrbu8YM/EQkCMZeF96TnSYU02dp76O/5IgzNCeLKJssEZIfIrBbSH
 +RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705082452; x=1705687252;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kJbO1S4hvAhgBp4DvcvkU8L6yZKagDoYC3gCT8cIoh8=;
 b=MDjCXoP11rdugDIBxRihZhMWoMgxTonTwGidIwtnvv7t609uToJnTPxM8IRahHo50H
 TP83FT21Qdss8rjxG2jezQQHSZT4m0quVTi4ah82pTmEPmdIPPAf6xuzDO2vTVE9XC1G
 hoQvuB2pfOLy7BwKPNXiYuMUypk7QbXeClygcEl9LJPo9Q5EQndax+AyOnnjB/Mbz2Ka
 y8Tsuacnagdbqrh7/nIPiicpYqrBqMYugjvBfLOeF4JE9H6+yA2eSE2QhIwbin6IZTma
 YVNJJuwJmsSMHRdiMsiEWK4+jl6fZ0NO6RcrWlJE513Z/WcaQo8t9x2sQFMy8HSRtQN7
 u2DA==
X-Gm-Message-State: AOJu0YxsORIvohzzmLROtPW1jXhoE2ckI2AlJL5frshh52htQiIS82Ko
 jBt4ZBkrSh0mVgMt9qPsrzCv5dpdFd6LuPowsCk=
X-Google-Smtp-Source: AGHT+IFpJUgKybaNfCnP9tXB6hT1m44PxzBHZn5/7UZIfOXDO9EN+A7SLoO3n85UmsYoR1KvUzdr1b6QDhUHaA9sBUI=
X-Received: by 2002:a17:90b:4c42:b0:28e:fa5:7afd with SMTP id
 np2-20020a17090b4c4200b0028e0fa57afdmr1825088pjb.4.1705082452076; Fri, 12 Jan
 2024 10:00:52 -0800 (PST)
MIME-Version: 1.0
References: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
In-Reply-To: <1705043234-39185-1-git-send-email-ye.li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 12 Jan 2024 15:00:41 -0300
Message-ID: <CAOMZO5BpA7Mx4Pogz4vMJaBy2GeoroKAELRg7wftUNdxuePtyg@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx8m: Enable the SError exception
To: Ye Li <ye.li@nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com, 
 thomas.schaefer@kontron.com
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

Hi Ye Li,

On Fri, Jan 12, 2024 at 4:07=E2=80=AFAM Ye Li <ye.li@nxp.com> wrote:
>
> To work with commit 2f3c920(imx8m: workaround ROM serror),
> we need to enable the SError exception and install vector in SPL.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

This causes an image increase that makes SPL to not fit into the
internal SRAM on some boards:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/769422
