Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24BFC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 13:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D2F8716E;
	Thu, 30 Nov 2023 14:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKi09UkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174EB8716E; Thu, 30 Nov 2023 14:01:01 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E47DD8708B
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 14:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-285e54f32d3so181736a91.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 05:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701349256; x=1701954056; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPbYisWfWzosrZclfRb/75COfl7Z0YgNjlXSHq/hqo4=;
 b=EKi09UkRdo99RKFZL36+5uHRFR0jActobjIEAm0Fvz8701BfdUIKaZyEWrm+UTEzVR
 xLtm/1H0YCG407dfj1C74VELGB8Lxccit3TlCl2EB5yLmEzJUHJAFM7uUfmPSvWiwbt/
 siP6y4iV/FJalq5On565vP7DqRIj1sC7l0bmAgm9wJL7QHptuIFysTvsGYaXNVA8RCNA
 o82/2/I0X9Eu30UOd9eXRQKmuwczYyK89E8jDZLwSo8NmpKzm33Oz6MFws+sLhM28aLl
 Z691fcW8Xsb2+HLsIoa3qAaKVbbBZyLEmQxbOQT5c53NmPqynnDqmdmohAaV8HtWIaTz
 i/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701349256; x=1701954056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPbYisWfWzosrZclfRb/75COfl7Z0YgNjlXSHq/hqo4=;
 b=DEYBTEct6cPpL45z6jZ1TKuRuNhTD5bmX2UNwOj+H2eQqqeLuDWHfxIPY2rq3P/jct
 q+0fDbGwQnIrsE+5CZuxLvCUJ0GNHxzv389Q3vbwOGPQgIN7bcN4vORvlPFVNqJEL9gD
 g8Jc/uPo5z20BKh/SUeQoJLnZ251dV+fLbhkvGtX4qPLcAaqPVod1VEWUyl8qfDgr5/p
 Rk5SVN+DgtA2/OuCtf8rra4UxnyV5cK3j3EVpI5fExCIfHplMsHT5cZQ0OOweCDF2Z9J
 Qp777DJ28yfU9FrgsjxsngaNDF5PQypc/VBC+r/rIroZOQZoaxxEUlwM6W9dp7Qj0OQN
 pcuA==
X-Gm-Message-State: AOJu0YweBXd3O20laL6AzUklfgY0jIHU78vFbiImWe/3qkPVvMJskB/k
 Q6o1YZNof2NA1jUgg9rfYuPOcWzPHgRbmtLzdyA=
X-Google-Smtp-Source: AGHT+IHU5hVeNgJyYVM5KgauNroTLOHq1gGuTKQ5c2s+aBwTNW3qT9b4goBoW0DVG/FAOL5JCZFv1YYtg1iInU6M18E=
X-Received: by 2002:a17:90b:3643:b0:283:a179:963f with SMTP id
 nh3-20020a17090b364300b00283a179963fmr21926784pjb.2.1701349256083; Thu, 30
 Nov 2023 05:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
 <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
 <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
 <CAOMZO5ACEd9q4QPmdeSsKWdsN5Gu9smH-VAowpSRhBaxA3pT-g@mail.gmail.com>
 <CAD8XO3Z4JLJfG7ceZS6_fOFY0fyQ_7GMQLdLioVp7xxcvDSgUQ@mail.gmail.com>
In-Reply-To: <CAD8XO3Z4JLJfG7ceZS6_fOFY0fyQ_7GMQLdLioVp7xxcvDSgUQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Nov 2023 10:00:44 -0300
Message-ID: <CAOMZO5Bbg-3HyOtjofw0+gR6htx02_cDV3qbdPCb0aZQvW6pqA@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, goldsimon@gmx.de
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

Hi Maxim,

On Thu, Nov 30, 2023 at 5:39=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:

> If networking for some reason doesn't work on that board (I tested only v=
irtual board). Please try to compile with:

Could you also try on a real board?

Tom tested on a Raspberry Pi3 and it failed too:

https://lore.kernel.org/u-boot/20231127185953.GW2513409@bill-the-cat/

> CONFIG_LWIP_LIB_DEBUG=3Dy
> #CONFIG_LWIP_LIB_NOASSERT is not set
>
> It should make network activity more verbose. In many cases I saw issues =
that physically MAC address do not match to lwip initialized value,
> and lwip drops such packets.

The ping response with:

CONFIG_LWIP_LIB_DEBUG=3Dy
 #CONFIG_LWIP_LIB_NOASSERT is not set

u-boot=3D> ping 192.168.0.16
init already done for eth1
Using eth1 device
pinging addr: 192.168.0.16
ping: send 192.168.0.16
ip4_output_if: 0IP header:
+-------------------------------+
| 4 | 5 |  0x00 |        60     | (v, hl, tos, len)
+-------------------------------+
|       40      |000|       0   | (id, flags, offset)
+-------------------------------+
|  255  |    1  |    0x3994     | (ttl, proto, chksum)
+-------------------------------+
|  192  |  168  |    0  |  164  | (src)
+-------------------------------+
|  192  |  168  |    0  |   16  | (dest)
+-------------------------------+
ip4_output_if: call netif->output()
etharp_find_entry: found matching entry 0
etharp_query: queued packet 00000000bdf03e70 on ARP entry 0
ping_tmo: ping failed; host 192.168.0.16 is not alive
u-boot=3D>
