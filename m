Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889A3CCD183
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 09:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED44083C2B;
	Sat, 11 Oct 2025 11:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="INKV4OZh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0631683CF5; Sat, 11 Oct 2025 11:10:47 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE7283C16
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so5019519a12.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 02:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760173844; x=1760778644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EXvP+SDMVur+HbhhYCNfq1/SoIMjIkyz6JraI3cBg+o=;
 b=INKV4OZhdosaZTJG3UMiojowYQ25OV5cHjGiUatQrqwleLVZleQ3I1gAehm0om5IHQ
 Qt5JZ62HyxKQWSwIkVGp3DuX98m0QzUJSpcUU0mqJ9dG30T2D8DkK9H5CEsgeMn8hFrk
 3q/RM9qEtlETaFhuSo8vO+2QNU+uyOGNtKR3gl0Nn0SglRTnn2vZpu5r3HxoD2LPvGDd
 BV9i6Q84HdvtbYftFuMLFNLVEc0m/wUXVeB9nu9K9LPK8sY31nDUqrPfNyCFMVZTtqdn
 3//FyE+PZ7/n1hP1+dkeFevB0nucCD0Uuv/I4azx398dOi+pn+w9ntrYNeqBiQPkSTtx
 el6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760173844; x=1760778644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EXvP+SDMVur+HbhhYCNfq1/SoIMjIkyz6JraI3cBg+o=;
 b=sSNWmIUX3JpDTaZLftsVkQfuyl5v0SqGp87/0X4r0t1eVJGDPqzw6BAHUIWtRI0xC2
 N09mdgxgeVk0hJm4F/oCnTaoDtOUhpSgPMEz7JBYxZx3ycB0D87KR6J78ifeU2QzzdXx
 5fcGEX0r+UT5h8OlkJppIiIuibwE/+yVWO6y1TMYX0n441bOMZUaMos+S4dcCph4i6Rr
 d3BFC+l6OJVOVSvE54N7JFBhYPoudmqn3bFvDa0kaWYzx5qr1882DJcdIqXPEkO8T6Fw
 ugF931tTX63Ese+wo7t7eXYvVGNRjUDPjgBn5AhEja6rtBEFVwwYkzlBgrfk/72Jsn9N
 yhBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDsPjdsFGrvfOb+lbYlLD54/DEJYcsDmiZtkAqN0aGr3DxkBjSp7C0Jn3haKSgC8q6oooVuQU=@lists.denx.de
X-Gm-Message-State: AOJu0YypnRYJN94hxopIk+ejw3VOdlPY0X9UOa6fBYOmiVQhEHFuQYFi
 q0+fDxjEA2KAUretph3wFuKWlkXeLMXDdk2mBZnKP7htwniXh+xqMQQSmZ+iaLiWbkw08NMf8HU
 5NT81Tk+++wcyHCsWDeL2rLCba1w3Fyo=
X-Gm-Gg: ASbGnctRlt76spi0ZOGxDWfp4NhEFuHSUebf1dmxFA9WNnK3wSJ2YnvlB/mTP42APQM
 KdyHmtgyEcyVhy9k23U7J7Rx1SY+Cl/aEKEG8JOtaZZgcJbCnV1vQZ9RdlxeaZiR0Se/wUdkT9M
 G0ZOyWwO9gPRwULxnG8nj2W8k2s3a0gu27NJZcRKTFlq58xzMu+76hc0OKJA6Y+uUYOMyvfphMY
 dWGEPScLDpT3FEhBY4GwnCUV4gviI9ZaYUuhmkdA5mzskyoFyYymmLEkxqTr5CJ93dO
X-Google-Smtp-Source: AGHT+IH5Iob8ays0uW/8nt/mx9JwjAkrdvn4+Zb/2cQhAzeYNgbhLrC9kKEwTF6dfLzTj2UJoWIa3TbX+Ck5NgFNPUo=
X-Received: by 2002:a05:6402:2707:b0:638:df2f:b8fb with SMTP id
 4fb4d7f45d1cf-639d5c2dbaemr13279512a12.19.1760173844278; Sat, 11 Oct 2025
 02:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251006170748.GH6303@bill-the-cat>
In-Reply-To: <20251006170748.GH6303@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Sat, 11 Oct 2025 10:10:32 +0100
X-Gm-Features: AS18NWCG0n-IGzl-FQreKYHJ-m4CoQbXoguPpgMVdjBn_4q2LHiMJA0S1z8ThY8
Message-ID: <CACAHuLAXPE19ZwmGbP=i4tg0VFB=76Ew5bs9BWOiDog+FjWvrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] doc: make pdfdocs: Address issues with the make
 pdfdocs target
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Apurva Nandan <a-nandan@ti.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Garrett Giordano <ggiordano@phytec.com>,
 Vitor Soares <vitor.soares@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 open list <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 6 Oct 2025 at 18:07, Tom Rini <trini@konsulko.com> wrote:
> [...]
> Can you please follow-up (or in v3 if there's real comments) with adding
> adding make pdfdocs to the CI targets that already do htmldocs/infodocs
> ? Thanks again for working on all this!
>
> --
> Tom

Sure. I'll wait a bit to see if there are any comments.

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
