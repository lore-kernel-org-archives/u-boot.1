Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D82E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 11:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEB48022B;
	Thu, 19 Dec 2024 12:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RjCgY/ZJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B270580291; Thu, 19 Dec 2024 12:52:43 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A49538021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 12:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aab9e281bc0so122987366b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734609161; x=1735213961; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RydL1HXwlzpaoTrAy9lZ2HOut5IpxDHg2m8u2c0XG2M=;
 b=RjCgY/ZJh+GainVktpuX3uYjeG8wavrClw5/Dl7ChzH7WIA1CsgHANv6J1mNweIw0w
 cDNdt7eSo4PIdR1CB1JDJxfdcwWHbve5BkJzPn6C57GAwWVjo7Xp0lyLg4MLgwF0nUd1
 QDsEgs8rvYmUfHVCZTDuR1XCEASRIX70Q4LsBS+zxkOV8Bp0lRJx65hcghgp9t2QkczV
 xROv+f46z0tnMpDrHyhob7gb9XvJwIc3uxXVYubZ1bmomee+qh2/RR3cAyjCylumRLUA
 ldqBCc0KqdKwpkmXVX8SBsicmygVxo5f+5v0LZ75cee84yYfFZHVMuRqE+FCz0JinQqT
 L31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734609161; x=1735213961;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RydL1HXwlzpaoTrAy9lZ2HOut5IpxDHg2m8u2c0XG2M=;
 b=BEK9KTDx7kTR7jF5RdRqHtuGWv3u3LbNZLeQ0mQlx6dKla88HR0J3RcfAP6jteDUyb
 lluFMkBN+S7cacsLV8j+Nd2lcjFzKnTIN0TLfv5T30CHIsKstkuMsEGivVdv52AeLOYZ
 L0JYu04RPs+Ug5YzKduTGU8dt79CBH1W67CI3YAZhCOWcPY0Vxrg4xz6h5juboH+96g8
 2YFPiK6mDt+eQRSfqBeoZ1pIw4/6CBmATLw5nJ5fJwrV9gPgDbgd7i68l1oDkBmDlwAd
 oIumlINl27NYOWwmVK2RbB1Qn77sde00HGGpDushIyPX2DEssC8EvbFD1BV308T4x9Rp
 Lm7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZTu9Vzvk1VnGD4UA62BdhImC36n9g+RJXXuTxPDptKxt1WReA0h75cf3eXrWxfcjBxY5fGI=@lists.denx.de
X-Gm-Message-State: AOJu0YwolAYtdC+TaBRSRFBLM6Cu8idNO26c/3jiktP4bwV4m8k5c5md
 H8NKgHmSYFRSZPEV2szzMwjfbg/qVh/ejLskYlNjBqP+MZ/NcGsfUo8RnJOpK25Z84WB+2twb8F
 7/oiXSgb34IIRj7PIAwJZww6vBI0=
X-Gm-Gg: ASbGncudCaYR4JV7efsNTXtOiYCJPfy5uPxF2KGUbzTNefAf3kcSMmZbxFMds7M1SME
 Df/di9+p5WJ/OvJI6dGiPfhx9bgEBDrxvSHN2Mg==
X-Google-Smtp-Source: AGHT+IHzpuvtP2LO1bTcSdJQCimkReFI5svntt7uOwLaEvPIyDUb+EUC20VELow5D/n21Fj+5fZV8RWA4pTxnJlVJOI=
X-Received: by 2002:a17:906:6a1c:b0:aa6:a844:8791 with SMTP id
 a640c23a62f3a-aac07b037ffmr246279966b.45.1734609160824; Thu, 19 Dec 2024
 03:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
 <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
 <20241217202900.GT1505244@bill-the-cat>
 <CAFLszTiaWSAVc4_zDvPfLO2srSMqko9BzauxHAs5x3MPvY6Rjw@mail.gmail.com>
In-Reply-To: <CAFLszTiaWSAVc4_zDvPfLO2srSMqko9BzauxHAs5x3MPvY6Rjw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 19 Dec 2024 11:52:29 +0000
Message-ID: <CALeDE9PU4emhs0VNLSyhen9KF80UD9R_AoChRAtGs+GzAmbezw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 17 Dec 2024 at 23:44, Simon Glass <sjg@chromium.org> wrote:

> Hi Tom,
>
> [snip]
>
> I'm very happy with your leadership. The project is extremely lucky to
> have you doing what you do and we all know it.
>
> In my own way I will be able to contribute to the project more
> effectively than I have done for the last year or two. So let's focus
> on working together within the constraints that we each have. I'm
> pretty sure that in a year you will be happy with the result.
>
> No, I have not been paid for U-Boot work for more than 10 years and I
> doubt that will change anytime soon. A little empathy on your part
> could go a long way.
>

Simon, I have never been paid by my employers to work on U-Boot or a lot of
other open source projects I contribute to. I do it in my own time for my
own enjoyment. There are many contributors to this project, some are paid
to do it, some are volunteers, all people have the same standing as
contributors, just like I don't care if someone likes to wear plain
t-shirts or Hawaiian shirts they have the same standings.

The expectation that you get special treatment in this or any other
community because of the reasons you contribute is not the way Open Source
works, or in fact just about any community I am aware of. you are judged on
your patches, your non code contributions and your behavior.
