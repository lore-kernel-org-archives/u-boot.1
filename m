Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E139EC5AE5A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 14:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FA388829;
	Wed, 28 Aug 2024 16:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PobLUPkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B88F5887D1; Wed, 28 Aug 2024 16:22:15 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A846841BC
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 16:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hrsourabh1107@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20202df1c2fso4955555ad.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724854932; x=1725459732; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+qOJKY3VUcEDiWnfr7dc3Gpxh36vcX6LNXEhaYMds+c=;
 b=PobLUPkDRCxLUhTsFDdrN/RtaHpXHuft80IowuY/muUvBULG7eiOui56bTrvrPxS7w
 I7gSSMy20za0bX8xkPL24spfrxHcfPASai8MSH5BKjMsUUHtS30j5DXGlitUoc4pKKtb
 qqYO1fP7rv065+J1n+2LrSLOF+26Tz0QuCp9dNmYI2K2XvgJfKm82K+np+slksN/F/Mw
 qKdqAAKStj+zrQmpEENfZg/hCukmYt5Crl7JQ6E1ivbgttx2sEJOIEcNoQ56/9I65rY0
 vAayCd5ZQUT26qH9iFlSuDCe9M8uWeGWWxtYu8S+x9NBTLC+UPwkghZGZZySy01S7S65
 6VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724854932; x=1725459732;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qOJKY3VUcEDiWnfr7dc3Gpxh36vcX6LNXEhaYMds+c=;
 b=ZeMGDHeiRMdfBjoa5VKViX+Yb0u3f9H6j6WqzX/xpZvKPxQV1usdXMpML67qgTINp/
 oswOMXqIXqVIj0UI9ggcosii99kKVxhdob+o/FKRV4zow/bSpaesewbY0O/CWxH5QVWY
 Iyf7+jVDW/I/SmMqgW5tyYZjYKdvQJnjrqvHFwIAPke7wtoOQYO/NcM5Pl6iREnTh8tB
 gcckWV5pZVfr3KYJlEjcE6Sj+/0HiULMCAOrLBv0tXpGKGGN9TKOubY7RMB7GkWpDry0
 bKL6SR56t7w8h7gLROYTgp4YfdAt1DKy1XjrmTfqiUYlzXf5jj2J7GSonbipI26rkdkg
 4oVQ==
X-Gm-Message-State: AOJu0YyUkA+6KEqG4QUBB5sV5ymCIKP6syWmN1RGdPl8KTImyH3co2X8
 YeWgidttM4GyQaZNjkPzYX7VRHFpxBNpM9/e0ON+9MosFPpPpYPTQIH7TZuSqFYK3p+Yqr9lkrz
 j5SP/NoMQvnMH+lEAr7nvaKvd5OgEUSo5
X-Google-Smtp-Source: AGHT+IGZDvAjrXbBCv0Fkg//P684aG1hYWJXIzMgDXIKSViSK08LIdv0irDGjd7qzqehwXJJtC++qLlSWafmweUXfiE=
X-Received: by 2002:a17:902:ced1:b0:1fb:9cbf:b4e3 with SMTP id
 d9443c01a7336-204f9bf5be0mr33378575ad.22.1724854931290; Wed, 28 Aug 2024
 07:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
In-Reply-To: <CAHseuWCmRF2HsVJ3RbK49aKwB6rbrHwPAOX10caJWQhLtFo1Zw@mail.gmail.com>
From: Sourabh Hegde Ramu <hrsourabh1107@gmail.com>
Date: Wed, 28 Aug 2024 16:22:00 +0200
Message-ID: <CAHseuWBeMu2kgKNQHc4OWa6Au0mAry_j4N5CVy4qWaSr3JUouA@mail.gmail.com>
Subject: Re: How to retrieve cpu info from u-boot fucntion?
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,

Is there any update on the below request? Are there any functions similar
to eth_get_ethaddr() to retrieve device-specific info? I am working with
raspberry pi 0 and there is no network interface card.
So, eth_get_ethaddr() returns null

Thanks in advance

On Wed, Jun 19, 2024 at 9:11=E2=80=AFAM Sourabh Hegde Ramu <hrsourabh1107@g=
mail.com>
wrote:

> Hello,
>
> Currently, I am using the MAC address from eth_get_ethaddr() function to
> calculate a hash value. But, I would like to replace this with a more
> unique device info such as cpuid or other values. But I could not find an=
y
> function that can retrieve cpu info.
>
> Can anyone please point me in the correct direction? Do we have any
> functions for this? Are these things part of the documentation?
>
> Thanks in advance.
>
> Kind regards,
> Sourabh
>
