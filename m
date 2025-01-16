Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9657C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C89A80737;
	Fri, 17 Jan 2025 00:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CUk59Ahp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A618073D; Fri, 17 Jan 2025 00:13:26 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B2380717
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-305d843d925so12885791fa.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737069203; x=1737674003; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vERNWPR9VlThEUEtJQpnltjdUW9zUboQwyobeCCSPRY=;
 b=CUk59AhpeFZ3q7yayJAcMtQVRi9Vkg6gpsqaIhJEs7BN3qqk5jq/Fj0qZ8R2DqQPMA
 3O2NszN2Dxsa4q9FJhohSEVbJsMsMtDgTlOBd/6NFlLYAw7WGynS2ipPZm19PdCby/Cu
 GZCLP+Mirl//6BWB8GBTrOvuPtWwpsFD4leXbHEa3db/LxzkTQRFeJjdII5gK5zPrKXf
 s2a/ErgEUnJuPEIZDPaSMjg+whfW5cC1pfUcm+VJzNQvPb26X7MUksfRoPbaAEVyUn2v
 h6pSgTHOUxfOK3lWzRzYGjF+19OWKDDZomCWn8az176s+18Nu4nt/m4Sf9diX/b+hzv5
 7fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737069203; x=1737674003;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vERNWPR9VlThEUEtJQpnltjdUW9zUboQwyobeCCSPRY=;
 b=XSTq4BiFyXbCLep+uAAMf8MYzOCaaKC7ZoKO/gEJSPaBMlLmSqC0EoVbw4MxiQI7l1
 X1dnYabx+rDXz9Q8562mOpyoRSDxAYPGYuUp/TFR8l46pgakrbCP+OosYej1+fYIZ+Fp
 h7Y01FyUXFmmyTL/9MPR+Njw+J6k0BCPHqR0spEAm5iPDFDTieHlk98JonmtyWfG+QUQ
 v7n9BTLe/40fl0rppXfAOgygtyL3Hn5JuD5y+eTSPiZLap1lW+5iecIZvkJwI496wIBd
 8y/FarwG7K0oA43GL6B0MOwKJj3KTnERbfFSmCL2KfK32Iq9n42ApiIqnP2OnIo7tDAf
 rGkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsOXyDErE5B/5Aa4KhRmviWJkczlu34eswj9cgxF3UO+JFHE8fwl27d5jMDUJT9mpIDhC9ANs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9CyJIyJ/W8edIAtMAhEifnro0HGkUxABAuSSPLOWS0gYKFOI5
 XeOICLCKyYlHKgwkChe/dMfb2PPZ/hUnd/C54Ysv/7Z88iUBmzRTsKK6qgZ0boD0rFApXloTiRp
 ZFKSqJ4Ykw/jGutUdDlN9C7cKKlI0TA==
X-Gm-Gg: ASbGncv6WfDROcbUeDK4Ze8H3Io1EeJ13Vy5BRKkWkSO2cKTL5Us12paZX6YywbC7mu
 wbX4me3esjdA28k0doWt9hO9igTo/+UEdFLiF5mvCN9q+b/580NJEloPNfLPClCEPTHGllA==
X-Google-Smtp-Source: AGHT+IHWorvxxq8iipX9ITx5IAZDtzcCpSgT0jLIXI/LrYlHO8yVJhfDFFUaAxAFOfhwDi5niUwpLmFnYQDhRFjkjdA=
X-Received: by 2002:a2e:a54a:0:b0:300:3a15:8f19 with SMTP id
 38308e7fff4ca-3072cb3c7a9mr1539451fa.32.1737069203261; Thu, 16 Jan 2025
 15:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
 <20250110-phytec_imx8m_optee-v3-1-6c39dab15592@phytec.de>
 <CAJ+vNU24PA3S3aEu5CjyECaF0aKKvbs7svHVuGUyHFA08NObOw@mail.gmail.com>
 <CAOMZO5DPBJAXm99DTwBjfgOUpUqWzCiZH=vM-Mq_cDde3QzynQ@mail.gmail.com>
 <CAJ+vNU3x51yG8i4N1DgCrg0DsaeGRurh2ZmK6td1jz22riiSYQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3x51yG8i4N1DgCrg0DsaeGRurh2ZmK6td1jz22riiSYQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 16 Jan 2025 20:13:12 -0300
X-Gm-Features: AbW1kvbwd-IpvlPn-ABG_mMZRoKLDHfldIBV3aBEU02F8dtzcLjNnVJJSC9VK5w
Message-ID: <CAOMZO5AnqBTqPpniQawFpqm3wBHOB80u0BqBSOEpk_--TM-+iQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] arm: imx8m: add OP-TEE node
To: Tim Harvey <tharvey@gateworks.com>
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

On Thu, Jan 16, 2025 at 8:11=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> I'm not sure I agree that they should be considered nasty warnings and
> removed. What if you intended tee.bin to be included but forgot to
> copy it here and you end up with this?

If tee is not used, we should not get warnings about missing tee.bin .

I sent a patch. Please give it a try.
