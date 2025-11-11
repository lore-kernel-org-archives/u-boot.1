Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72468CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8563C83B8A;
	Tue, 11 Nov 2025 14:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lmeWLSxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D139383BC4; Tue, 11 Nov 2025 14:48:04 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B9E83A03
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5943b7bdc37so845639e87.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762868882; x=1763473682; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MG51CJ8i53q5LmX9YQRfOgutze2VmPEJTBM9qSwXhw=;
 b=lmeWLSxqXNw/FeBF1kUfEeV4JA0OK+NehExiwZQQdmozouGhGIBP6/8ANWuE9IpNqo
 ZhPiKQ46g7XECiJ2MgVmV/4WXvbXUrYeZPgtDB7HCY10yIQKJyl1LMFMkIyBGlCTqSp+
 0PR9aapDsZrfj/ZRPOgKM/cyQeKddGDwKPwOEQgXnfI5oWxQLrIJtNkkURQxhF7y9Zvp
 ka9GxSj6R43HdwWFUP4j/5FbK7S3ZEvwWzdougnSmO0cRKAZFG9gkWR0u6lYYISiVjDN
 gKnNlitW+Ibtt5U+P4wmxhiOc+ao6N1us5LIMTP8EMwJCEKRailT3fbixlG+9DWkWLHK
 Eyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762868882; x=1763473682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+MG51CJ8i53q5LmX9YQRfOgutze2VmPEJTBM9qSwXhw=;
 b=aHJeZxgX86lDrFj0nKII/Oo3WKBqcMGVpwO3scUK2oAS2hjOJqmJ8c96LmOOotSvAx
 YdCZ0EJXqWVkTTGUgpquTK7dngMJ82E8g2ghQoNEJ/TMm5sBURyzmtVXm9g1da6wJm1g
 /KJmD4tAQ8QdwHASUF+ECKA9nmO069tRAAin/tHV4SUwd4Em7uV66ddgjDOmkxHCxrCH
 eysrOXK6JRDKjCZxkLQIIsMU0Ph/k1lQzzEViJzrM9mGzJkDFJMg5B2wl+1k4xthUr7T
 jJKd1QRtcKeUi37q9TxPmHTlOhclkTNxK/ROJeMQPLtFc0MdmbaCv8AyNfz6hZ+fmwK4
 +aaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4So3VL/UZcPUZMc1o7b/CU1yaH3dvSXVJzt8kpQMK1F+PYpKWwVtoNqBYU9NCIsEv4fwzdVM=@lists.denx.de
X-Gm-Message-State: AOJu0YzsKi1x779JQS94fQC/IavOx/PFzjBQ2S3BCYQkmwQvXgAQ3UfM
 p1Nvk8GdJkeOi/rauFIKxSdJT0BeKx8clcNX/XeTOlHSP2ZJ4MHulVgvOgD/hIBXE5Wkms4p4OF
 Kx4tuKF/WDUdvQCrq7ewvRTZwLDga19c=
X-Gm-Gg: ASbGncv2Npv+13ojEicjFPagPv8GKc1nlQrM8A22gjIdidXKqyllXYA2AB3Q6+n6eXj
 ZzL2LFj9CHCTNO4/qiBkTf7Q47OFr6tMZJMSsKovJaHRYXXGp36c1lGKmpLOzUpp6DCF998wDAy
 tRUdGHrT40RrB+fSt2vgQEjewsSHJHSsxC471ZkGkarz8wjS14h0K0cQMNhUPi18z9Yo0WeDoJd
 24GJMWD0DClSA2kZR0Wsn4CMTKQP0QAcguQEBtI7vQg3Q9Pv6AJqB6Fw3bE/B6B2qrel8zb76Vg
 6wpz1NEoohLG3fWcNgasYsvG5us=
X-Google-Smtp-Source: AGHT+IH44FmNg9W7Uhknoa5fVjZyxuH5nu6lwklm1ZHy7G8ycIr6ZFTubjioG28LXXVGqT8fDWsFJHBp726omsxq0Sg=
X-Received: by 2002:a05:6512:23a8:b0:594:2876:c901 with SMTP id
 2adb3069b0e04-594745ff370mr1059946e87.25.1762868881985; Tue, 11 Nov 2025
 05:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
In-Reply-To: <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Nov 2025 10:47:50 -0300
X-Gm-Features: AWmQ_bmF8dN8b-rO6-akFdPnpIWdYpKlzc5gNxQ1CtIfwYblHIQVK5SY8Zy6KbQ
Message-ID: <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
Cc: uboot-imx@nxp.com, trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de, u-boot@schwermer.no, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
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

Hi Emanuele,

On Thu, Nov 6, 2025 at 7:22=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:

> Hi Fabio, Ye,
>
> At Toradex we have been struggling since quite some time (back to 2018) w=
ith

Does this problem only affect early i.MX6ULL silicon samples?

> the temperature readings and the thermal shutdown behavior on i.MX6ULL. T=
he
> issue we observed is that the thermal shutdown seems to trigger too early=
.
>
> I have investigated the history around this topic and verified some inter=
nal
> notes in our bug tracker. With this revert applied, and on the devices we=
 have
> (all trimmed with value 0), the reported temperature increases by about 1=
0 =C2=B0C
> compared to before the revert. The absolute accuracy of the readout is
> questionable: for example, on a device kept at around 20 =C2=B0C, the tem=
perature
> readout was ~19 =C2=B0C before the revert, and ~31 =C2=B0C after the reve=
rt.
>
> Consider that for devices with fuse value of 6, there is a -10 degrees of=
fset
> after this revert (so, the other way around).
>
> I understand that for Sven this revert improves stability during large XZ
> decompression in userspace for few devices, but for us it means that the
> thermal shutdown happens roughly 10 =C2=B0C earlier, which is a serious i=
ssue in
> our case.
>
> I would kindly ask NXP to double-check how these devices were trimmed. My=
 gut
> feeling is that there might be an inconsistency, either the trimming sche=
me is
> not backward-compatible (e.g. old and new devices behave differently, and=
 the
> code should cope, I don't know how, with this), or this patch must be rev=
erted
> (because introduces a regression).

Peng/Ye Li,

How does NXP suggest we handle this? Were the early i.MX6ULL parts
incorrectly fused?

Can the fuse be read and dynamically adjusted?

Please advise, thanks.
