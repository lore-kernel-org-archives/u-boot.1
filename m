Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0585CC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 11:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F4A86E82;
	Mon,  8 Jan 2024 12:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ODxWQQDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401E38788F; Mon,  8 Jan 2024 12:39:34 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252FC86D37
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 12:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-28b93b04446so471136a91.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 03:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704713970; x=1705318770; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze2eobMhNRjSPTrthl/He9E67+YEcooCWR/WEWwoMdY=;
 b=ODxWQQDbCXZpjWF0A6cld5AqmS+GLT+j5z3CdXpPXp8ajPOc2QCfjL0C0mG2SAWk/4
 GK4ky4tXrO/Yp/em3TCJXrPwa2EIsWYnZOjj6JmzRAq9LGOI1MjmSy87TovyRK3bXgt1
 gkyF7RKKPTqoRfyMcc74okUqoCRtlh3q40/ebPhmZU431C40khPSeeldRasK8x2nHSUx
 bo4U6l/Y1DS/b9kUi9YdFg4MhAAXL91BKRw8BgPsGT1wGBzAln00JJWjpH980r1d3awU
 6P9FbkqvUBnXkW3s6e8jakc2100gnp3hxm2qHchqZauzX+QRB+1WI2m25KsKdm5wyhq1
 J4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704713970; x=1705318770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ze2eobMhNRjSPTrthl/He9E67+YEcooCWR/WEWwoMdY=;
 b=DWOTKQZ3OB+rN/eBY7rRtmbrEOtV7NBnJW+twlqP+b7UXM3gkpwn4iGe+YUAnWat8J
 cRyDgodGhBE5q3ORAt0qSKFUzeg198ItrdktAeTxYVjj7aPDxbEoMzDbUy4zINl4gJ8m
 iRuVjglnSB2uNKT0lmXq4qhv0GQ+2wkf6e1LInDmb6KeR9s2uO3hPsjhpiLxG0dYtRoG
 9/BXHD6yOCd5sGgZRCWpIpW6tv6PzO4QDkL661e5jLBX2UKp8zMdppeecjh8dFn8m4g5
 7qkCNcu8WcptPXXodiVpcBwmWv9tOLKqKSHjdQucaQf9MmWr7bLOK7kwF1kLWy86N/og
 Jujg==
X-Gm-Message-State: AOJu0Yw/gGjUqHPMe7bdLnRQnd496ddFGJFsLyF4wew13eqj4FY1Vnxt
 I5HRam2nHsgRb02F1JosSUUoOkkx+I2jgmFO61k=
X-Google-Smtp-Source: AGHT+IFiyTqV9GeYUrySb3C9RXhI+pbXGPjXQkIZ7FVpIzloY3mZA+ivgeNeWf2x0QYcHJvr+WXcObMZnetVBwInNWk=
X-Received: by 2002:a17:90a:ea13:b0:28d:2804:5499 with SMTP id
 w19-20020a17090aea1300b0028d28045499mr4941768pjy.0.1704713970246; Mon, 08 Jan
 2024 03:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231219-49026ec51e53dffb0c4d4e20@thorsis.com>
 <CAD8XO3buXi_0dJQzh2HSirym3VD1C-rugCsmbrsE-nuN-VVS7Q@mail.gmail.com>
 <CAOMZO5BWibgnQKTreqCfTOioaUYnEZPoUVs4290OSs3k82x8bQ@mail.gmail.com>
 <CAD8XO3aXShwQGKzqqYO9GAoAV2SbQFx0Fys3G_ZonTQCWQCAJg@mail.gmail.com>
 <CAOMZO5DiJtMAePwZd-adxscDTZ5dSGoZiwLK-vH-7Yz8nyPfog@mail.gmail.com>
 <CAD8XO3aeQDqfbzCTFVuP6VY5S1RXQaLxoayM4-NBaLi_2JktNA@mail.gmail.com>
In-Reply-To: <CAD8XO3aeQDqfbzCTFVuP6VY5S1RXQaLxoayM4-NBaLi_2JktNA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 8 Jan 2024 08:39:18 -0300
Message-ID: <CAOMZO5CY3eW0C+tZGKtxaEJh3D565PCAF4HYfWJWdNwnzySTxA@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

On Mon, Jan 8, 2024 at 5:43=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro.or=
g> wrote:

> I will try, but for some reason there is no i.MX board in the lab.

Yes, please. Try to get it.

> MAC address is different in two commands, it has to be the same.

They are the same actually:

u-boot=3D> net list
eth0 : ethernet@30be0000 00:04:9f:06:33:d3 active
u-boot=3D> lwip list
1:  eth0 UP IP: 192.168.0.122/255.255.255.0, GW: 0.0.0.0, 00:04:9f:06:33:d3
done.
u-boot=3D>
