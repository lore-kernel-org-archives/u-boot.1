Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B3AC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 20:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20F0877C8;
	Thu,  4 Jan 2024 21:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xynd724n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420B2876D3; Thu,  4 Jan 2024 21:46:14 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FAC876D3
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 21:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d98e7baad4so51502b3a.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 12:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704401170; x=1705005970; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7PSyeBavkAjLeakyZkc9vFxE46PcoI2hHiQvfcgyQQ=;
 b=Xynd724nE5l5gXD/CHpT3WAhuGng2kXzYJ047Zd+sCGNq7L+mba5ZViryQIXJTwk8E
 rcSA50Y9B/8tSFfeSSjd2bUFyDgBOpPrkZ2nkna/zTSosnKn9gGg3uT5JWvof+jr6nX5
 Gkc1DYBwWRLXax54RyGBA3cSAZGmffYpCWhzsjWhm4lYic748iXmktpBovg2gV+fv4Mr
 qhwcZ1gLER8S86XQXgWlubJNMGfHS2DNFf2wz9JC2kB5iz3bIDKJVXTzrpI3V7wiOAHL
 92GZ6xqEcy8rZTtGlvMh74o+MIe/qamiYoFyHVppfwuUe3wUqvADfVSUHkSGa1JAhr9d
 86kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704401170; x=1705005970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7PSyeBavkAjLeakyZkc9vFxE46PcoI2hHiQvfcgyQQ=;
 b=rs1jN5EPUjZdRYwgq8gIJ/v8oF6gv8LWwxOP3nJnku1+73/SfcuU4P14pj1+WGAJgr
 dyL7WXrMDT1sXhO76HonrjN2oKbfaoMCkJfB1GXofLvhZJjYjRl7fgnjhLtw+1Kti9zD
 3XAYUeiLnEFT+n07yTVV1xnsIS53r5K9j0S4cUxzvUNkXmksz9LgN8yWA0fkfpt8l8xJ
 cZGmCMSsLea8jw+EWwHjTd2voq8YxWTz25uQT+MAhQd5m6mT7LUysBCcrgiP7P8i5v7S
 Jwa5JDNAJe2TSVjZdHYq4v91Rkgnyz2MWDzoz2X20lMTcOppYLJfg2oaJXwbnO1iMsSn
 jZ4w==
X-Gm-Message-State: AOJu0Yy9TsLYaCwRQH6O7O3iB/WfIOa601vQs8n4XyCFvnteBAbQBxmj
 NEwviqM4mm+B1mj9v26C+toryXOI+a0oxRc7m+g=
X-Google-Smtp-Source: AGHT+IENaB2qG64IaQuWHCE7+DhFjkdJCvhWvcNJg4IEJCX3Go+NZQa+Mq4UdUHqrN6W8fZxS6UDr+PFu9zMFCwU9VA=
X-Received: by 2002:a05:6a20:8b28:b0:199:3699:60f4 with SMTP id
 l40-20020a056a208b2800b00199369960f4mr7115pzh.0.1704401170220; Thu, 04 Jan
 2024 12:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231219-49026ec51e53dffb0c4d4e20@thorsis.com>
 <CAD8XO3buXi_0dJQzh2HSirym3VD1C-rugCsmbrsE-nuN-VVS7Q@mail.gmail.com>
 <CAOMZO5BWibgnQKTreqCfTOioaUYnEZPoUVs4290OSs3k82x8bQ@mail.gmail.com>
 <CAD8XO3aXShwQGKzqqYO9GAoAV2SbQFx0Fys3G_ZonTQCWQCAJg@mail.gmail.com>
In-Reply-To: <CAD8XO3aXShwQGKzqqYO9GAoAV2SbQFx0Fys3G_ZonTQCWQCAJg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Jan 2024 17:45:58 -0300
Message-ID: <CAOMZO5DiJtMAePwZd-adxscDTZ5dSGoZiwLK-vH-7Yz8nyPfog@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 12:02=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:

> CI tests this in all qemu emulated boards. I tested it locally on Raspber=
ry Pi - works well. This version did not
> yet tested on imx8, but the previous version worked on eth0, did not work=
 on eth1.  So I plan to continue testing
> these patches on different boards. But in general it's the upper layer th=
en drivers and theoretically has to work on any
> board. But in fact different boards work in different ways and behaviour =
is different with their qemu model. So I'm a little bit confused
> how to test and debug these patches on board which I don't have physical =
access...

Can you try to get access to any i.MX board via Linaro?

> that is really strange, after reboot you should get the initial stage.
> You can type 'lwip list' and 'net list' to check if there is an IP addres=
s for
> active device set.

Nothing strange there:

u-boot=3D> lwip list
1:  eth0 UP IP: 192.168.0.122/255.255.255.0, GW: 192.168.0.1, 00:04:9f:06:3=
3:d3
done.
u-boot=3D> net list
eth0 : ethernet@30be0000 00:04:9f:06:12:98 active
