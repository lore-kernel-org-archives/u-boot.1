Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C46C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C34806FB;
	Fri, 17 Jan 2025 00:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="FQgXJqYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E028073D; Fri, 17 Jan 2025 00:11:05 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1044F8022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:11:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso2523237276.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1737069061; x=1737673861; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCqKcaXNb9ybBmshcj17QS3lj7K+Nlc3pvtpvBijT5U=;
 b=FQgXJqYqQeBUldZO9+n+MD8zUl8jMCqM7s/M/Talo0Th68iXQTL46neesM6dhAV/NV
 Iyxb2ZdY+Y94SGq/Yf+gk8zHCz/K9FktB4mYlqPym9WvcgobyiXqPcS48hRagPyn0Rdv
 mZ9xM4FNBvFP+Y/l+vhcJ4K6Q1qnJtBMbYaNXxQjpQQKCutYPaIc4C9BYOtpvhpUhDdO
 Qk54pzTE8rTOlJG++4pbOl39bTdjCco5ZJABl8E8p3ty0g8TiIxOn8Y9RqVdkoTFW/LI
 uQ/v7XRTM9yq2LDCpwFffTkpAwBcKPT/vzz+dTjxyMOEQn6ILcNNdHEDiTSi5jzzP7AT
 jd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737069061; x=1737673861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JCqKcaXNb9ybBmshcj17QS3lj7K+Nlc3pvtpvBijT5U=;
 b=sRrrhfy2Zi1f9qCj7Rk6zCwH8KkkPDiTHi5tLEUVlQ0832gNh9Q9qCvwN9klV+Da3Y
 +eV6sLdTD3P7YJCO33+kx4XhBcM88Rc0Zx6sdyNAWxhPtHPUY2VH52HOBiNVn5F8QZLW
 A4dDtSeZ87Gt1qtYa3iuGqvY7J9Yz083X0BCEuhcpxMe+YPPXqnaXlPbJoebYNevaKjm
 7YLtNcBChYd7auNRjH2+ybVlhYZwnPm/qhIM9XIRgtIlqbAqd+VTJjLg1ntUIiGO1rtv
 Bbtgldz0+B8NZq/66s9LZ7aGuWVix5qPtS0jTIY79SwHq7Fbjk7fPjdLuxyMmRZDqjbe
 8Z7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZWr8S6sTJedSM6JpobYpcX8eOEkWB9vRtf4+a8SAfrFfQjcgHNQwRuZApIeRPbeX/NOfsswY=@lists.denx.de
X-Gm-Message-State: AOJu0YyV0sM9RIaGpQodiWPF4/IS8LiFnvoxTPiuW741k626xaBzr18H
 v0IZ5WjHC/uSrk2OiKkDjA0IIyEgKpmwEqc3ePxFE17aQCqEqBAW0Ya/1sOsW78l5Jl0UYCqG8n
 Xyu/3XptTJ82A/yzmoEfzHxeuQ+4hJz06ayuGFQ==
X-Gm-Gg: ASbGnctVOmRk4r32pMboIAbxD7N/wHVpkHW9NFQBhnKXwwaSLivwiaQJtLnzmSCFT4s
 p7/FJoAlfpgU7WVNVSek37L3VHHUWCPYrDAV4mQ==
X-Google-Smtp-Source: AGHT+IGZzJQW7UsI0CjGnHrVwZ+ZmfI8ZLFUDPydrDCu5cuptQfImhfwb2pSy0TuSNKFIwOcrwW70uxSxnG32wVtoD4=
X-Received: by 2002:a05:6902:2587:b0:e38:b85c:31a4 with SMTP id
 3f1490d57ef6-e57b106171fmr274391276.14.1737069061310; Thu, 16 Jan 2025
 15:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
 <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
 <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
 <CAOMZO5DPBJAXm99DTwBjfgOUpUqWzCiZH=vM-Mq_cDde3QzynQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DPBJAXm99DTwBjfgOUpUqWzCiZH=vM-Mq_cDde3QzynQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 15:10:50 -0800
X-Gm-Features: AbW1kvZEhv1KGA2eaNmyUPbERXmvM5X1XIbKpKH13InFLiYdpWMxnZ-bpw6z1r0
Message-ID: <CAJ+vNU3x51yG8i4N1DgCrg0DsaeGRurh2ZmK6td1jz22riiSYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
To: Fabio Estevam <festevam@gmail.com>
Cc: Yannic Moog <y.moog@phytec.de>, Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Manuel Traut <manut@mecka.net>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Thu, Jan 16, 2025 at 2:57=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Thu, Jan 16, 2025 at 7:45=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > Hi Yannic,
> >
> > As I mentioned before, I still don't see how this builds when tee.bin
> > is missing because someone isn't using tee?
> >
> > It looks like Fabio has merged this already to imx/master which now
> > fails to build for imx8m*_venice boards because of it.
>
> make mrproper
> make imx8mp_venice_defconfig
> make
>
> flash.bin is still generated despite this nasty warning:
>
>   CFGS    spl/u-boot-spl.cfgout
>   BINMAN  .binman_stamp
> Image 'image' has faked external blobs and is non-functional: tee.bin
>
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Some images are invalid
> make: *** [Makefile:1135: .binman_stamp] Error 103
>
> CI also did not complain.

I must admit I don't know much about how CI works but the make process
returns an error status, but you are correct flash.bin exists.

>
> Yes, I would welcome a patch that removes these tee messages by default.

I'm not sure I agree that they should be considered nasty warnings and
removed. What if you intended tee.bin to be included but forgot to
copy it here and you end up with this?

Best Regards,

Tim
