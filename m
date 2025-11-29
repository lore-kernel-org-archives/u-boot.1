Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05D2D116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E3683869;
	Sat, 29 Nov 2025 22:22:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fTympLC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66C78388D; Sat, 29 Nov 2025 22:22:19 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF1BA83759
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5957f617ff0so3327644e87.2
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451337; x=1765056137; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL/+RPIgpubShWeDX5Mv8PmtPRinygvi0r9M/Idniuk=;
 b=fTympLC9Whpg7ykLDqHY2hrekM2c0hEQaWiZ+eVpf2B7UGeLJOAwdv5BqdlfhX6YUT
 ktg/chYlb0AAW+9o5yUBwQowav6J8GcZK6vCeCN0SIQzfjdBdgokxboUlzc+Uw/amphL
 WuEkTz73Fusf0pGfxr+DXbxOZW/W1co1PI495s6a9EXTMurM/5e3ymi2hNdukSdvwaj7
 VUncrlTjgKpfL05Tt2VzdbmVhOz93zq/Ebm/Xd1Rrq9iT8Xs+m04BFCmMbQkCm7Bxy3B
 wO57grdV6JQHXj5zNzny7qBds+xGPFXcPK1to1CNexTjRiEWH6UnIYxzmsd6H3GHvX3N
 NrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451337; x=1765056137;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GL/+RPIgpubShWeDX5Mv8PmtPRinygvi0r9M/Idniuk=;
 b=iDCBAdGixZMJgWPAZOcxKHmpNCHGHu7JxBJgj4C2pfEFGbUc8ApDzPhbumM0QbnMvL
 Cj1pD2X3eN8Aw8KJvDKEgMuw4pxqQ+Sn4+Vb3nXUSBiD3d196DfwA+4V4tUT41TGOOUH
 bT23ny6KV9gw7tqEXNLmEApCf6z3jlp3uFAWCTLiZc41HyMJvYqpIXrbayD8IOUo031E
 5huTqlGKi4eQVQYbL/6zj1DZ77Fm6MyVs4JHZ94r3JeotaZb1MWx1hXmYG4NlTrS+g+u
 ymNHblXc/9CLH6D0tA7JugCvMsYKe4QCp9Xg8iuyaI2G5tnegirRJLrF/MVomvYh0DN1
 Kykg==
X-Gm-Message-State: AOJu0Yw4uU9lu1IvGg4dPEPWEtSWrtDRYKNSFj8r9qwpudxrzPwZZ/ma
 OlWzoaH4NTUIW8fQJAqKHBFDFGm6+bGZhpspcFaOrYkO+UnU/coIyVNz1IdztJszYISSSoTmPRM
 /EWrIKAMtCcqY3xHx9adlQ2WZT5JumYI=
X-Gm-Gg: ASbGncuRcUbx37rHVz/x/GUCxCi0LbsUpnW5entYWnXFeOJG2XUNdDa3YAIZUlltIES
 nb2pPi+Cpo9X2Pew51193IIx1IveQfCg52je+pcC8zs0Wiz74QH6K3rbqbW28++r1Eqk0C7csxP
 ioFtLIOqaeOz+daQfOtA5/wA6iSpdiwC3Rsm9FEHBq7xyoOoc+PiCYlUTwsBbFyhVv0UqdUBMTW
 0MZinvI9NTWcFNwJlFpO7syYGnHXAN70otNtlUOAIUxRiyzHshyNT9J/WHEVH+C8rlAj/MbYBlN
 u+lEA3jonp0pi8NXkfdfZLEGbH0=
X-Google-Smtp-Source: AGHT+IFvVHvRMShRVA0HJAzBnANL4dkKxWEgv7Rjf+NqyzqxuF7hExCS8N+xs9ehr0qatwSvJx8JqrZ5/qNisgajk/I=
X-Received: by 2002:a05:6512:3188:b0:594:2835:e73e with SMTP id
 2adb3069b0e04-596a3edddf5mr11670475e87.37.1764451336867; Sat, 29 Nov 2025
 13:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20251113082145.898431-1-alice.guo@oss.nxp.com>
In-Reply-To: <20251113082145.898431-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:22:05 -0300
X-Gm-Features: AWmQ_bmYRhK1ygAyld6M9RkeZAyrb6ULAr02pJAyvedadDnQi3TXbnmfL13PWuY
Message-ID: <CAOMZO5DSYBSd5XWZDnVtLrAQ4gWA55cCqcLOjn6RvM24v+AJpg@mail.gmail.com>
Subject: Re: [PATCH v1] imx95_evk: Initialize the ELE RNG context
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com, 
 trini@konsulko.com, ye.li@nxp.com, peng.fan@nxp.com, ji.luo@nxp.com, 
 alice.guo@nxp.com
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

On Thu, Nov 13, 2025 at 5:22=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Ji Luo <ji.luo@nxp.com>
>
> OP-TEE requires a trusted RNG. This is provided by ELE on i.MX95. Start
> the initialization of the ELE RNG context before OP-TEE startup to allow
> OP-TEE to derive RNG later.
>
> Signed-off-by: Ji Luo <ji.luo@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Applied to u-boot-imx/next, thanks.
