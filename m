Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3A0E9D82F
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 02:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 408B583936;
	Mon,  6 Apr 2026 04:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ex7stbZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDD4483A41; Mon,  6 Apr 2026 04:22:25 +0200 (CEST)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com
 [IPv6:2607:f8b0:4864:20::1236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFD78352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 04:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-12c080efc1eso604022c88.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 19:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775442142; cv=none;
 d=google.com; s=arc-20240605;
 b=NMrQTpJ36/eHLaR/loGtp9k7CURppxlDUDYbbcUk2xNf9kIWmilGLDAVkztjZSJGMT
 bGKQi3hUlRkOFTQr6h3FjEgE8SpQGztbBXJRBQh+nz2Mmv3lGgOGH/S9nnfTjYEeB2U7
 11wKEL1jxybA5+WKqD5AwX9CRyOjCBYD5DN45QCLY77rXkW1ScerAVeAEmUZyuHGIs3a
 5iRTjGJX12I69MCmUNA1WyyCw3vHa03NqwJyAQj0+a5fLnzSrphNm2YwXJHHazedUO1K
 1IDoIDNuZZgGXT183L1Yp5rZQIewJii50ZYcNvrje2npyVT8b5B3Vr6NBRUTVF4X6TYS
 4cpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DsLwJM1tsaP16B0wZaAkW+gRi6aoioLgx8QXeTuvGrw=;
 fh=4/zuTJ/tLCFSiFgmUN/nq4Rb1ot+rcH080oYWoIZV4o=;
 b=VNbwlnudYF+3K66+XynG6qfIyGWrXkX7OUkltu6j+c+6Ff3RKZT+EeSylc0s/IzZnG
 tWsCshdmf0/Ive6U377/5sgn4Tn83ap57qBn9OhBudL95NBu5n6c9UIwEGq1pJthTute
 uFFeb/Tn93c91kTZFQv6NUbszLMi5qA3aj7OSDISy4Kvy8vDn3H/aDnx5TrBaIqCmn96
 c8a7yypifa/GzndZXG6gj1jMevnVc9VxKFwUFgFY1aahY0tPQpfypdAZfa0KQO/N7cMn
 iydE3L69QBUa2wlAEzZFjszzD6UFqPCCkOv03+ircL50ggC9PAqDYEDJv9ZkjUq9736G
 7Paw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775442142; x=1776046942; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsLwJM1tsaP16B0wZaAkW+gRi6aoioLgx8QXeTuvGrw=;
 b=ex7stbZnTeJNjKTMAx/bZB+J+aYlI8iV2wn3Vd8qE+cYZVWQwOP8vFR2Lotuj8HtZp
 FSRdOCTh7NLsICJXymgaGfYlGhc57mQeLrC58Da/jhW0IEdBdVpCaaiAaJih0NeJ4mbC
 rAiQIK3Tl/panJMFD9qHE7tDWwlEA6kDgI/PIeAexChukYe7nW06uJlqb6v2WU/ocHjQ
 UZmc19ObeTB70rGO6huVc33km1MbW6IqmoW+oeFOfzpNdDcoI3lWx1yO97GyxEMwAhmM
 PHoxP645hJ4OZTSHafcknNI62oxEeLnjOEPxs88Gkmki1GvhrEhPwyeOu9XTMKDuLccn
 pZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775442142; x=1776046942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DsLwJM1tsaP16B0wZaAkW+gRi6aoioLgx8QXeTuvGrw=;
 b=hzYzOqxW6/RAb3zvF6QGt6xeVgTIiYRxkDbdJ0zV8fhjf8x9cGEEEecK5pHo2GMpnJ
 6V5Rg1RsqEnI3pe5TeMo8al6In5fXoXlg/cLGN23ZvlWCqlTra5ZOADHUf8jScSvdXyf
 qeKffMekeqzePoQxvlRPbL2OZZ7Js5d9rG93ih/GWkIhAPoRnNAkOvxRyw3xLXJBFcx3
 TlVm9I7ceUjr1Pwz/a56xhIWEIkQRHIEaQhv2itkt8opD4FiQcSIwjGjfb2FdEwmutJQ
 3voo4dhdDWHFPVCmVjnnFkSXhuOfyboYA3bwIfbw+o2W1zGhNneDuVxqU0KF1v4q6SHv
 1gmw==
X-Gm-Message-State: AOJu0YxJjgN5qCW1bu4EwDBIOsgcfLBBopSGZCYcF11suYmLnVxL69qV
 HZhuvv11ZZ0cvy+KbAT4AxHnR7Bg5sspcqR2gqDwdIWx+MJhWQjH5h0cZKjI8d1NvQ2jsY9ADKx
 IC2f7d/XYjx6VIYky1V7vzUh5jz6i6g==
X-Gm-Gg: AeBDieuVlywVWyBEDqXd0pPfSX3RB7qbqYlEelNGLrv39Ccpr+j0oCwGue4Pf6u2Hh4
 19jZ5kHjdPVj8yJXGDMzZaLw5i9YVQWwBJt/fRNgkuw4xv8JFBl0WiXjoCM7gUALO+Z0zi3X0vN
 SmHpr9q9BqjQki6R7LM4TI2ejY98RpXCyN4FRHP8cf0JU2RfHdXXnbm0IP7pa4Wzpwl/Q8rzDfb
 7KndZNXEzd2pNfIuax2gqY7ooVs0SbJXuVQAEXbDs7jr3p55hYIboi84yFQkC9GLc0x+53IIlTF
 NrUTMhs=
X-Received: by 2002:a05:7022:1e0f:b0:128:d076:e7c3 with SMTP id
 a92af1059eb24-12bf08c083emr5056213c88.25.1775442141999; Sun, 05 Apr 2026
 19:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775143241.git.jcethrid@gmail.com>
 <fd5c3fa01abc2601af1ac11a168ba685526b80b1.1775143241.git.jcethrid@gmail.com>
In-Reply-To: <fd5c3fa01abc2601af1ac11a168ba685526b80b1.1775143241.git.jcethrid@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Sun, 5 Apr 2026 22:22:10 -0400
X-Gm-Features: AQROBzAp1-uwWinyT1hFdJAtPb0M05Sn_q8Dy1l3hsEmthiZKt84vLJJU6E8XD4
Message-ID: <CABdDSeVpWbu+hadgWJVWaeU7=4xKuvpitbRU+ScP2Za=3dbP5A@mail.gmail.com>
Subject: Re: [RESEND v2 12/13] arm: sc5xx: remove LOADADDR and use
 kernel_addr_r
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux@analog.com, 
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>, 
 Ozan Durgut <ozan.durgut@analog.com>
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

Hi Caleb,

Sorry for the delay on this response.

On Thu, Apr 2, 2026 at 11:29=E2=80=AFAM Caleb Ethridge <jcethrid@gmail.com>=
 wrote:
>
> From: Caleb Ethridge <caleb.ethridge@analog.com>
>
> Remove the SC5XX_LOADADDR Kconfig option, replace its users with
> CONFIG_SYS_LOAD_ADDR, and update the ADI boot environment to use
> `kernel_addr_r`.
>
> SC5XX_LOADADDR and the corresponding `loadaddr` usage were ADI-specific
> duplicates of standard U-Boot load address handling. U-Boot already uses
> CONFIG_SYS_LOAD_ADDR for the default load address and `kernel_addr_r`
> for boot commands, so keeping separate SC5XX-specific names is
> redundant.

I agree with dropping SC5XX_LOADADDRR and replacing with
CONFIG_SYS_LOAD_ADDR . But should we really replace ${loadaddr} with
${kernel_addr_r}? We're loading/booting a fit image not a raw kernel.
bootm defaults to CONFIG_SYS_LOAD_ADDR which is exported as loadaddr
in include/env_default.h.

Thanks,
Greg
