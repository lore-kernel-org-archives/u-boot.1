Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BF9C61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 07:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D237382C30;
	Fri, 13 Jun 2025 09:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JVHkC7eL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BDE82C44; Fri, 13 Jun 2025 09:30:39 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B1B82C2F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-30c416cdcc0so15218071fa.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749799836; x=1750404636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tPo9luRCyQfBoCl411dvCyvpqHJQvMG0DqljkfNt1d8=;
 b=JVHkC7eLwHpKrhvZ3UFLYUJBm3FmcOs4hea7eiyQOxmn/uDqx3Sw3MZl4StNd2UzEk
 3q2T2I0d14l5iJ75rCiiVwsiCm/1kLOGl+i2cmL6Zve+/zChaCFNuAB38mzWnnmBHcZo
 Mgb2xS0ypI6J9oo/qP6lX5u3lofajR+esf8sXT5DAkafopxI0TOK8z6R19m/jHFdSfvH
 mI6gjU3eUjdivx8rAXBemFUUhuOKpl/pay5br6efGdaf9xSREhHpoR7XvzhJELthnvFZ
 oVZ/yHgOwYQ5s6wG81h/T6K7cnghYnF1b3HaW28n4UCcTtEDC+JlmOK+YtqZdwQVRVd8
 slcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749799836; x=1750404636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tPo9luRCyQfBoCl411dvCyvpqHJQvMG0DqljkfNt1d8=;
 b=wieSgvkainKBXo68zSIydxroEl/pD6KCx2J5cphzulgqtDLZOzqNA/dllc5bdMgNQU
 LtqhcjWZP0xANPT8Vw7suFWpKmvBOjJXtoagMdgJT7r7y0tAavjCrynUhn8/GFaSImEy
 Xv5NMJcKAo8rK08p9OM4ZxWPUtMtiMs9WBJi1gubKI2s2xZhZqk14/9C+PHoFN7ksxeD
 hylzKK+FEa8YWfR9UJqG6uxsPHalgxNgtlKdHq3/b3qGksFxsegmx4AMFvdZXpH0fPNg
 WQDRqyr6ACyYEkkxdh473+irF31m/N05vSIMtCvjELA5hCcIZBxZ/ITuRM4O5k0UTDx5
 vFrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ms5DyxoYRS6cH1zytmHmWd6XZ2ZjSDps7X1DFgYS3fzM4FgXXIALVLmz8Hlwj9WNazIU21k=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf8KZNmYZGGoU9uwlq5HotgCs+JdKLcOFezV6SIzQ0KPzexA1U
 H/oPQkVKZnjisunUTZc4wnsdAzKW8sXlpMkOPCILNDdrY/uafBdInHGSls0hzYMYtWT+iTCYpzO
 nWkjSAATozwVL6lHwtqrC1tvl6bYB1r4=
X-Gm-Gg: ASbGnctnqHvoZG7yvWWPJF88AcPlLFJYf6U70jjw8K/afvliWu82GqBLzEWWPX/dcj6
 wV5MjDx+ULgxMVRdEDxireUsk9NT9xIT7qnAGMeZBEiPXMjbfoCoNIH3y2QbtIlv6FME6pyXrFF
 hROPdTWtTlc9gbfOdYDQGcyO8KdEWAzE4mnXvPasZuw069
X-Google-Smtp-Source: AGHT+IEnXa14KacImbiDJAqpMZpYoI6+oqpxHi5a0Y7lEPI42Gf8yD9Sa5VFZvkrXaGozvmU6IRAASKEkGaEkc0AbeY=
X-Received: by 2002:a2e:b8c8:0:b0:32a:7d76:262e with SMTP id
 38308e7fff4ca-32b3ea0ff5cmr4599301fa.3.1749799835947; Fri, 13 Jun 2025
 00:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250521072149.21007-1-ghidoliemanuele@gmail.com>
 <174976652212.365589.11863773954985914311.b4-ty@konsulko.com>
In-Reply-To: <174976652212.365589.11863773954985914311.b4-ty@konsulko.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Fri, 13 Jun 2025 09:30:23 +0200
X-Gm-Features: AX0GCFtYD_rMMmnK6Tqmf1QiLY8aq__7-1cmk24PPoKAnD75JA1VHqjZPRbnUo4
Message-ID: <CAEyMn7bH3DYUgYMkpC9HSg7HDtpWa7hvb0w6T1+1vUBjbCPBgg@mail.gmail.com>
Subject: Re: [PATCH v1] arm: mach-k3: j784s4: Call do_board_detect() before
 DDR probing
To: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: Apurva Nandan <a-nandan@ti.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom, Hi Bryan,

Am Fr., 13. Juni 2025 um 00:49 Uhr schrieb Tom Rini <trini@konsulko.com>:

> On Wed, 21 May 2025 09:21:43 +0200, Emanuele Ghidoli wrote:
>
> > Call do_board_detect() hook before the K3 DDRSS driver gets probed.
> > It will allow boards to adjust DDR timings in do_board_detect().
> >


I think the comment from Tom is also valid like the one in [1] about not
doing things over and over again.

[1] https://lore.kernel.org/u-boot/20250612143808.GM1382132@bill-the-cat/

--
Heiko



>
> >
>
> Applied to u-boot/next, thanks!
>
> [1/1] arm: mach-k3: j784s4: Call do_board_detect() before DDR probing
>       commit: 79ae5510a211d788b01cc5cb7f4ad15e9f5f528f
> --
> Tom
>
>
>
