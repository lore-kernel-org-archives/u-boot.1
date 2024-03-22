Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC7DC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 13:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3641A87FA3;
	Fri, 22 Mar 2024 14:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWpjz6Cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A952388113; Fri, 22 Mar 2024 14:59:17 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D945879A2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 14:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5a46b30857bso281842eaf.1
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711115954; x=1711720754; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2skYvSv9jrhAuH3wKhK6Rm0FclsxnGgCDyactj3d0VI=;
 b=FWpjz6CuKnpvo4CnMrM6jtRWMsssBBJnnN8IIfYpnsR3+4BEeK7rO6Gg1JgNWScURy
 l6Rm/zjtcpLj5Zwgpv16gJX0YLyeEcAH3fLg5NELB75CHZz9ChNX3EvDyhAK+PHV38G9
 JpxM6GTbKrbVRxmoAZD1QZNIqsg1hpA1XuV+ZhYA8x8pBTq79mYpjbjG4qtHVBwJjn1g
 +135g5/RC4FKJv0tR6d7DlvXx+ychMRN4krlUPssoQbIutzG+GbcmoJkHXfYzLbaGCJ0
 gdJ54A/xESZxt7MopsZDxlYziaFRemcCl7MqV/9Chpp3rNLq5LA1koUtVTPzUk+HlvaM
 /Fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711115954; x=1711720754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2skYvSv9jrhAuH3wKhK6Rm0FclsxnGgCDyactj3d0VI=;
 b=OUk6EGx4QCG2nePfJgZgntcUfZsUdc1ZztZQk4zbRAkQMfhE6P8ivT7yN+a+/yMUdM
 +sLqNeEOm5Ffvapl4uU6GsH4MTsGLXQjD4YxI0s0s7PemwpWOVNggx9IASGm0KUHcYso
 IIqwloOBoOOMcStz+VuyucRp2iNsNv8VDtqC4ZCWWyDqNIWMtjacd2qy3+VP/To67H37
 p92CFxmxu1HtuDHaIIDQqictyTDtmPn+04Hm7MSrwDAoXIYtAf4MHUrINnN9JfmZro/c
 MBDxcyGQMb9RCd4opP+iQmJcXJsQHuk26Zy/N/7WmuIxpq3aDo9FgtAwrq+vr8gMbLCv
 jSSQ==
X-Gm-Message-State: AOJu0YzLfhd8Rj50RgtfETn6xl43YqvimANtmk2JN4bLoLXFo3RRwJ9f
 fDnBDn8X7mfpccuBTJaqkvRoKwcvNlPyBvrDxNlDwAcavDHZ5TgcGoK/WPSGHfKk8JTGXUZkCis
 FArUQ9THlK4toSuOLvsrmfrvmI0RxYGks
X-Google-Smtp-Source: AGHT+IEEbGOkmqNOvQ2TdQt/u9+xstyWHqTFoUantQ4QQ01e/c/8pz6BqU92LKbenO0LAA6HRRgd2ZiYadnj4j8TPYI=
X-Received: by 2002:a05:6a20:da8a:b0:1a3:5e76:e4ec with SMTP id
 iy10-20020a056a20da8a00b001a35e76e4ecmr2890660pzb.4.1711115511449; Fri, 22
 Mar 2024 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240321145507.619448-1-sumit.garg@linaro.org>
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 22 Mar 2024 10:51:39 -0300
Message-ID: <CAOMZO5DjJRRRi8ujbMu0ypCwXWbymt_RTtdviUhNAcknQN3-Vw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] imx8mp: Enable PCIe/NVMe support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org, pbrobinson@gmail.com
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

Hi Sumit,

On Thu, Mar 21, 2024 at 11:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:

> Changes in v4:
> - Incorporated misc comments from Marek and added his review tag.
> - Dropped patch #4 (imx8mp: power-domain: Don't power off pd_bus)
>   since power domain off path is never excercised for DT based devices.
> - Added patch#8 as suggested by Peter to describe older pcie_imx.c
>   driver as legacy one.

v4 looks good, thanks.

I'll wait a few days and will queue it to next.
