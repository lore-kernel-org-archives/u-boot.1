Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A795EFC72C2
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF76B8407F;
	Sun, 22 Mar 2026 14:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ga4CFi6W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B63284082; Sun, 22 Mar 2026 14:23:15 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7641683FED
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a278b4c1a5so2815812e87.3
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774185793; cv=none;
 d=google.com; s=arc-20240605;
 b=eIFfh74XY1E86VsnHSdb0BkJoAuxVVgm3nEpRqdhBFFE+cJWNbIp5j1uzRXFaMmCiX
 nLVz+/PbxSK/31qirFyOHhTCGNUOBp1R89edglNS6LEL2Iy7bSsN7ytPGkkioUFe1RcR
 mKEx2qvLXW9Au+YmW5M+JEEddiIuJHOyHEsv5/dscvnpMFQKBwYTIxtq/lf62OjlD4Ka
 PaYLlhDLcxZabLRL712l3JxTXlRjOJMm/EpVzQhgUucZtGvfTipx+7KyMraQNcz/3K9z
 QasFrGvRov2Bk9G3S4j4qiPjVCu04bVkgqrlMvOczkDFEdy+uNeaGUbuQ5Ypzv4nyeFw
 FHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BxCzY7yL35jnufbvQFpUKsroaLonghtp/u4yg/J39So=;
 fh=MHGoOtFwcXbgWQrQYPvvi6rdIv6RiJxRhAKjO8Asl7o=;
 b=XLCIv2EO6+52e4zHQU41iwJ9CuZdItmhIE3S/EYvKPimkwjJeEc33pawV345aaK+oR
 Nf4quYbrC62/DxYI1SnocaSPlJbsCxJax79XW/hgjF/mR9nECxfGw7qkUuRaDU+vzpqn
 +6TS4F7w6EojoAIMbNgx0/I2sBsiTjVOB8vR3lCDkYX1SIFO/WJ0Kg/BZuIk17VeN3vp
 WLJ0O7xFQkKNiTYHPMa6Dgfi78iSdblxkqKNrG8Q1Bhjz/p1JpkS8Jh+y9z3fvT4Cppd
 zSCjZgNDLjgvC9LT5MIo3DIy2MNTaiP0z8RDIyPGt81qOQ2R5ITHSfywmr6Ha2RyzB8o
 oXEA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774185793; x=1774790593; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxCzY7yL35jnufbvQFpUKsroaLonghtp/u4yg/J39So=;
 b=ga4CFi6WWVHszDYKeYbrQsq9aVIca5EBcd5QZcVaI8MAmjV1CjWLPBeuOzVhXFjbWm
 HYKFlA0v4rLMyntBcd/snyXN+NcZVZC1HIrTI39KHGJOtyD5YL1aZU2RYZFhNdpmQkcv
 YZqf608CC3hNSFbSvGuYSOxJ8kKUDpFl3pCZXAtsTzf+2TSHQHp2MfNZkNj/NtVye9Cs
 KMAT5HZdVGgiQe0Y/cj54s7sTem+6y2Nq2WlUUCDZGqCK7VYiFkRpuJhFykUNJAi2Etg
 i7Ww2OnMg0UoqbGrwNMKkKb3C+O2Ryg6X/8OGVx/whEAoXim+/jtfTPY7kjDi4oNxVhY
 nLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774185793; x=1774790593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BxCzY7yL35jnufbvQFpUKsroaLonghtp/u4yg/J39So=;
 b=py0ECxhzlgXttCB8aDAX3bs7XfpvRRYgUIfVtXaNodi6nvCCIR7A9Pr/3KcDArBRD+
 5limX1vBFCZ/kbLTxyK9oA67uGDfceXxJHK7Wh4jCKAEZgk5NbsY1CPdfZRuO15+Fgzp
 1SHp0cvSzVUpgj2ZdjHiFCjQL5q4geukDEnRxOkGKe4yZEVqQJYyTE41p6asEfDhhtm0
 JtaMP5UxtR8TDY5LnNLJSYC6VQ7ycffIa5IgFN/R84p/Ep2lL3sCkBOyRk17f45ZRvK5
 I8sl4CnWYRHjXykGlVouvIqoV3PWUJ9zhDpGsZngjLdqcpPLnnBrI/s46QXOYnXx5sSV
 Gl2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlZoahDFhP5l50DmuNyXfKQkkqyEDYkFBhBnRWO0QJo1MOeOefAj3ndL3JpSqgTL9bgixoVCU=@lists.denx.de
X-Gm-Message-State: AOJu0YwPQo+3aiCjzwPNqLViQWSUVgwTrICI/zAUorMP/gZxLH4vcBb5
 zD1P+//paOD2QMXjQsmdW9fzNtBT/XrkvCPD/r/PFoZUm2lbCt8kk2L4y43UbEB7WF0UFI0cKEj
 ATs2jCJdSoteKfU51o7iwGIwKOaRNRHU=
X-Gm-Gg: ATEYQzyiXaePzgny1ncDybHVVqualQSeGBKg6UndJBzdfXsKwsgi65wmdiR2K3Y09lS
 KQSQuB8wJIbg7JTJFc8IoHc+D03VGweZRZHIFhy3xd8kZIWDVllmQSPNiRG5VJeHZ7eZPHUlp/b
 rSQ94wU960mX8nPbdPsRqfPZ3i0Cjl5TnnQGoH6EW1hi87UeCL/mdw5xl8hZ8cAD+pudxO13mSl
 1JHXTYYLVBvaC6mdHMle7USlKY4lRhpWx14kMYKyrZwaogRC6XK7UxLIIiPhaVPj8XlmHS1qz1D
 Vr3dJhxIkCJSW1Smu5ZvFDMUjEee0LWbbkcP90GxPxyfoyhSTmTx5ExL6uasi+f0kext4Qg=
X-Received: by 2002:a05:6512:3c87:b0:5a1:1d29:e749 with SMTP id
 2adb3069b0e04-5a285af3af2mr2775197e87.12.1774185792587; Sun, 22 Mar 2026
 06:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-4-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-4-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:23:01 -0300
X-Gm-Features: AaiRm52RTW_Hh8KXNqZpEnxsJhOivjy7xXChtbjUxtZiivWGGpukz-_y9MZBT3c
Message-ID: <CAOMZO5ByMPbsdUOAaNAPxz61U2wO+M3bZB-XmkmAjQbTEhkWfA@mail.gmail.com>
Subject: Re: [PATCH 03/13] env: tq: add shareable environment settings
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
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

On Thu, Mar 12, 2026 at 6:58=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>
> Prepares moving boiler plate code out of board confguration header and
> prepare to share a lot of things between boards.

Always use the imperative mood in the commit log, so "Prepare" instead
of "Prepares".
