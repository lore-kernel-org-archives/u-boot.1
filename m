Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B08C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 00:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3128C842D0;
	Thu, 16 Nov 2023 01:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JSYgDNg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD1E87206; Thu, 16 Nov 2023 01:34:54 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7F586F18
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 01:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5a0dc313058so37874a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700094875; x=1700699675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLCmNby7Pd+5AY143a4TrWOPYTkVsgfByZl/M8f1Cp0=;
 b=JSYgDNg/FRcwKezFaUMqP1XZWX3WOJ5hV1Ask2XiKRsdBCM/GKSJ5gsyqEr1TqPJcA
 68dO5bdsKwxKpy5QiUizjgayFg1SLW3/G6T3sKR5ePN3W9kD7oy7yrOIqtqhs61olLkk
 EWiTYquXvIJjzJn+9LmvORwpSwYLp7IeQbO/llQWZIAyIq6c6m16spDGVMV+UH8ASwic
 xhF3md5/e3OuICFPmC7C8NPJA+ktIEc3XH65ita5DsuZjFCgPUReeJQgA/aAU5geuvpM
 cyxPg2UOh5J4BdlfMh/jpMrTBujYRvJy3DusfFzehhlq+KEhPOaGKNEb+ZG95HC1W+Ck
 SYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700094875; x=1700699675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLCmNby7Pd+5AY143a4TrWOPYTkVsgfByZl/M8f1Cp0=;
 b=qn6Up2ERJa406f66zn1sl1reF7TUOFonVh+iuRvuFsw5X5iqCX/9U7EoXFawoFs7lM
 olp/1p0/WgUPO3uZWrzJl4VsTdH02qknaytj7ml2RuL/YzfSRvQJMDvDplLqPl8H4a0W
 xqO2Ll5aoX+Y11Tr16YBLpNyOK55wBmpwjpou2w0Zl9AmzLhaYFCG2dAFXSSxvV1gpWL
 3IhtVd58ZwO7R141JuuF9tt/4darly9yehONS2BhUe2kwoATUTk8Aj63OVyAX6MruCov
 JIALcJt7AI3bkffrtu0jpRHxUIoeY+DjCYl9Sb+1X4uOqsrIwqJNC2pnxrsoY2VbJr+o
 1YNA==
X-Gm-Message-State: AOJu0YwT1adgcYhERLFc3VtgHNWHRjegNHtav5Qs9e67jHsphSWVqXWL
 JefrIS9gy7esaXYmly3+TQl1vRFQIsiuuEiHwto=
X-Google-Smtp-Source: AGHT+IFAVK4vX1HGXy0RXYmbzdHXRq9+EEhPShRdB8IBgEZIL7B2S43WoQyTjYwm6YOB2+s8HvTNdfNpv1UkZB9NA68=
X-Received: by 2002:a05:6a20:4290:b0:187:9486:901e with SMTP id
 o16-20020a056a20429000b001879486901emr1992757pzj.0.1700094874896; Wed, 15 Nov
 2023 16:34:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 15 Nov 2023 21:34:22 -0300
Message-ID: <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Tom Rini <trini@konsulko.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Paul,

On Wed, Nov 8, 2023 at 10:24=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> I was not able to see a failure when using "tftp" to transfer the same
> 420MB file.
>
> The number of bytes transferred and md5sum always match, so this is a wge=
t bug.

There was another user who confirmed the same issue:

https://lore.kernel.org/u-boot/CADQ0-X_cj1ECn67U3sefcZ-Jm4OBSYmZkA+JaZRCa3e=
kq84RaA@mail.gmail.com/

Could you please take a look at this bug?

wget is not reliable at the moment.

Thanks
