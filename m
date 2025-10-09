Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2709CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 22:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F341841B1;
	Fri, 10 Oct 2025 00:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Py3SmcXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11987841B8; Fri, 10 Oct 2025 00:42:19 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0BA840F5
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 00:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-57a59124323so1839909e87.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 15:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760049736; x=1760654536; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lc9qZ470x10gnZxZQcnsOLlAr8HEeAve1sEeUzrIc9Y=;
 b=Py3SmcXdfklveKfgTKxYsvLPVj2ygNMSKZFg9Tez9QTh+9SzXALoRd1cScCs2FQnUz
 tZQwuuaHmBWx/aZsMpH8IdxWr03KJgK89IJgnHd4fjitRa9wJTAWPNwOqu3Fm7TpAd+h
 KxwrV1Hku2ynaFsk++7ezCikcYL7vE0Dj4phdec6LhxSstN+vOsFo98A7bUPHA0gkDnK
 RG+J3GL6iIBvZnGyAfWOI5JM/5qbn/b+L2j33HAqO35VxjsqqNvmJ3YI9EZSRIBE9KGY
 sJK//tjHcZWCryQA1oN9sVqkOnh8HRaM3G64EAz4f8LCRhm6CfH6G2fqjLY1jdOAGeKH
 GQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760049736; x=1760654536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lc9qZ470x10gnZxZQcnsOLlAr8HEeAve1sEeUzrIc9Y=;
 b=gzc2zZIlAlaLY1I2eQyqUYw2w6DL7jGJFSOcq5DN/OxePjQWxsI7Q0uSOo3Miuw7io
 KG/WtescHZ54YEQ+AQfoDi9nwBF9mCWxw3AlhtBPx9szUFdnrrWayeZlJzDy1OeiZw4R
 oSEoOfpYS9fz+DPus/myCTKVNQ+4WmlyfrB73X/AP1xvmIJOIsIWbooDOsPOc46QhNSH
 DLZhtaLUnOu/UCSCF9MIXHaIkrxjjSdT08ydjP1cqSFJ1hzcz4s62/xTZbZEPW03P8OT
 I05EobvNWR/gQYbxt2BrrC0dFHr6E0n7bEtAmF7Vv5RAJFOuObzgGg7tRKchXnXnWPKh
 xu1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA8wnyxlhnxk1LzgccOk76djoRzzoI+o/siAdnTnIEmulZpdUKTJLDL0LOK8t1+5tkabOLr7Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yye0R2Ex53q6YHlKqu6ILu0KgnIegLXJr3VNXHsPAP6mrxgxplK
 Ornf+Tt68Kp5c3XQvmlGDlm4us/Hq6l2dctnqoYnAQsJwdzHBZnWSZ0U+0Bnq2r49dnrK5uLYle
 Q2u0AmvUwqeFbg2iHQTzCymfTdUCJMGWBkg==
X-Gm-Gg: ASbGncuYH8wfAbXP1nroqOOnb1niehKjBdwICwrQ7PSZD0yB8MrjpJq228xCU0MhuH/
 WPz+WD/4iCTU58VK1KCb3UqBe+Ce23vpTyeSEEDiXGtmDhrbo/5fg1GzVkm1av8WdcwBVjMHzkN
 8e/Pdl5QtqDqGMN8r8LXZOpjqiSfAEeLTVrj2DEUxnKO4utz+DmhHiTwDZknfC9Xy5nX0KMIaZT
 4MDF23mVTSQR+MY/RNL0ytA1bOEQ4WJu2TtdJDX/TYvbrWRrsFK0QXDXzchtHE=
X-Google-Smtp-Source: AGHT+IFSbWCNazLsIL8/Fpqmv/nIA8D4172o5r4QDK89+N7oLoq/19o7dEWFIbNaG83EgMIQ57zg2lEtKzo1NHCsAj0=
X-Received: by 2002:a05:6512:607:20b0:590:7af0:837a with SMTP id
 2adb3069b0e04-5907af0868emr1326205e87.12.1760049736221; Thu, 09 Oct 2025
 15:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
 <CAOMZO5DArO=XT6NjUheyL5-ec-s0WxW9PxTNEBZ6QXvdGVG=9A@mail.gmail.com>
 <c5f7315f-f5f0-48ab-83f4-9472c1c37fd7@mailbox.org>
In-Reply-To: <c5f7315f-f5f0-48ab-83f4-9472c1c37fd7@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 19:42:04 -0300
X-Gm-Features: AS18NWAQlOhspdtXItSftDtfs8WSt9889UYbHfDWVYyvWNJ-wn2_NvMXJp5VABk
Message-ID: <CAOMZO5CPQNJhRcZVOedcHfRq0j5pxf3T8rkRmAgQGmCddMNJaQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Enable USB and ENETC on i.MX943 EVK
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Frank Li <Frank.Li@nxp.com>, Marek Vasut <marek.vasut@mailbox.org>
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

Hi Alice,

On Tue, Oct 7, 2025 at 8:27=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.org=
> wrote:

> I don't think I ever received the entire series, can Alice please resend
> it and CC me on ALL the patches ?

Please resend the series with Marek on Cc on all the patches.

Thanks
