Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D6BCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 08:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C715D6083B;
	Fri,  2 Oct 2026 08:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rtmYX-gxR4RR; Fri,  2 Oct 2026 08:14:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0DCAC6080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790928870;
	b=CF+d/1B49MJUfEwD2beiFwzft0VRVO9cpLHda4UXI7WT6b4qd7jDjZUYFeyiJpajxZYZ
	 w1uMRyrkGEydkQSSW8u0yt6VQ7i2Jk1eef5QTRxb2e1N9OdQPHsTWwnIybtI6+uQRpBgK
	 kxO48I8CZuALQ+K99EfSPZRVvPmy9Gbq1q3x7E8e4YpSlUe7yTZwQSi391kNxQsODF5dL
	 XEb//53FdGbRWqOCjoWWnLZ41FHvMEkyi0i5iecpenp6gKR4oUq3piXz1q+DwdWHMe513
	 XSWvaq47FHbGHWKpEJpN14NTXJ/qr4GgbpRBBzJrDOJbzdhzvHv2d+fXbusQe2IQHYg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790928870;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zUfmxCgpCb9s1SqCQCXq79ZTzxlDNGbDcATBgAdXfzs=;
	b=GDJ96G8VvNNLf2D6Q5tpXkYWeqXMh9LNKlPh8om+nwTpPaapq6znkXR/hkrddH3bov1Z
	 c11YZKiRMuR05ST1DXw//59MvaN7RNknLc9XHv7t0Wy6echVmL83ahy2B5a8qSrMa8Ase
	 4XpFb2mbyQp7Q5Cwmdmt1fGQQEw/rFb3sh02Tp6CFJew+wr3JopKNIbqnQs4m4c672CK/
	 a8Vh+DZ+oF4vwBr110kB1qqoJg+fqlcBty56TTB8idRVBlnuOrtmxHNhX//S1QX6VH2HQ
	 IE9fGSgFXukex9anPXJjSI3ihKfJQ9kLwVZ+wm4064/Lc8IpwIGop7bprJD3aQy7lmQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JCOlFk14;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790928870;
	bh=zUfmxCgpCb9s1SqCQCXq79ZTzxlDNGbDcATBgAdXfzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IzkfTbI69RRELHmx+jgl6yCD8DK/wJuUiGslFSh8QI84S875Q6wf2RPHWjfQWtoYy
	 FPiNs6LipnrAezhj+yimz8T6mJMq5dK44h5std9jvqIMwGHq0I3OEpr9lQyle8A8LO
	 NE/KG8iTHM5STW3ykwVz5V7U9+6VYWkSTlIDo+08UV02qBjgtnFW7bbTnpq0xLudMH
	 Wxc3+aFatnsgOdfc3+sKhrvvnTtx2IjbkGsc1V1AP7Ny+LqLWtFUXwlc9rvEiqmCFB
	 +OUNKYC914aRixKpwuNdUvhfY30y37qAyhmUwdQG3bYk+Rp2LrDQtGBV2L8aMO8ARB
	 9ERunxEJhMqCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DCAC6080A;
	Fri,  2 Oct 2026 08:14:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 260BC34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15B0A6080A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:14:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w0TuXAL32chr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 15DF6607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790928867;
 b=dOpjxI2FUSPLhttaKLcjeu+fOeKlJsE7fmoCHH/Uoyjoeqd5O0a5Vd9BOTJXm7noFBzu
 J5WQhaNedNm97wDWYLhc+l8WzBmiEenuloS+IC0C/9NQWRFzE7+BBWG1STaneYjdM22NB
 66JIHKvRh3RXiplDjvphE/QMS9Rf3YG/8LA080cka1iaClPf3S+3lLaamCRF4U9nCCVqE
 fTD2ofoBhvUEvAOsvylpA33hrvbTBymb6IbpihDmitH8eceb4xp4kJCcTyM5QIUeg8vkm
 8LKbQdFxcd57LkDDRIz93DevAgOqHEWHVPuLriW5ULPZDVgk/HAI/W8KSxL8kOiWB8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790928867;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=zUfmxCgpCb9s1SqCQCXq79ZTzxlDNGbDcATBgAdXfzs=;
 b=nrborTy672+3U0SF7k6phTN7UK8LskeXtJd7m4VrUHXJOy0gPR7EDF8JWjhRzyrvTNMv
 65x1PkBSWy5NQqX09/YEu/NcOhLdILpXaUYcsbg+G6tOq1Pp5w1dew5a3O8eXe+V3GU/V
 yGdJY459mzIo8mN26bZh9eRYHN6HfO1Di4249xT1DCWOvLLHuMmzwiP6fIuNrEHV96JF7
 dYU4Rgd1BJ5BgOUznR3Wg3NZp1OSfPqkQ0/1gUeDxMb1ssNLrgU7PWbRlQcJ/4TQvQPEF
 HH76Bw2DRr/VpvtkhLn6hjGAfXzRGd/WTofSEmVk+Eyd6MSAK8mFhSHidcQiwqBFrvw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JCOlFk14; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JCOlFk14
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 15DF6607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:14:26 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aae359e2c0so11445649a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 01:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790928865; cv=none;
 d=google.com; s=arc-20260327;
 b=i/LPRoO8U0H4nCFN9fY5PM3tFixXb3V9GtTO9XeFTLkx330Qq/43FRG3MUAmgMgL1R
 p4Xuj1dwmEbAVqiFOKfDQJ4uP89c2dsL/FJm6g/LJLvqbCpwF0lpiRWvwx0WWa1e/7r6
 T+FL3ViDH+YWyXcBk4I5kS4MH6PdzyOANyEgccdmO5xlWjPZxj9zBbRRoWrKSyRSQPe4
 9E5LMcISlHRfdVMrI4r32evihramkv7/6Ve3yWc/4mw2tXOoi6vHH2mdbFXTeLNhOQ+S
 2ZB183gPcCkbc36UYro1UQyAXs5RONO/Kg8v2gMcJg6AkDV8US9ExpxE568g+d9M8Qo8
 FfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zUfmxCgpCb9s1SqCQCXq79ZTzxlDNGbDcATBgAdXfzs=;
 fh=w32uY2ba7RefKUMnDhF6WZWqbf88SewsQcUKh23/Jdw=;
 b=rHXZLmzCxivXfnwUlsrYlCfW5/eUSM6Udh9nYnmhcAvzdg6+tRMBNhBgJaS5hMoumQ
 vvVOHZj1uzc2M6LCVEL/tbe1ct7A0yTUO3T2ByQNpBQRl48IDMHCc48zscHf/hf+JVFp
 g6oQ7bzzZFSxW4784mmWN0rgCyqujf290V6N39duTELerbUs2KP4IuWSI3EaX1bxpzoy
 uX1i54W7hoyybl/sFEMQ9dNM7EfnVlItQHbf7gu78rRGovnxrUI08yn2sS9akw4mRCMW
 EEjomfHMY2qJOHgKjuTJRZpUXk+poSKPz/TeGggIM7kob7gbAq9glfrYySQzl6gKiNt1
 ipJA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790928865; x=1791533665;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zUfmxCgpCb9s1SqCQCXq79ZTzxlDNGbDcATBgAdXfzs=;
 b=JCOlFk14imQfjHnuPyLnUtFQFL/6aDb6ZwsoR0rCi8YO88TgCG+AJlpmZhTSMlUgSH
 OjAOlXncN4je29Y/YkbiPET6D+xbfm97bI4zA2HfAF0AY6C4SUpd3OusGWcnM6geQSWC
 rcSY1v7wdZknADc1RiTwHAtY6SlqsmDrQBIV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790928865; x=1791533665;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zUfmxCgpCb9s1SqCQCXq79ZTzxlDNGbDcATBgAdXfzs=;
 b=QJQdZmfMR6pq6D1Blef7wYDW+nn0SBVe3BjoCj/Y562A7qU1Dk4YySVo/OlljW+r2j
 iBo9sHp0/wMMCWxx803uEg1U1erjQOWxNvZ3t7BiXYtdZX2uMpbpnHi8AlDG1IgCm3+e
 AJp8KrG1gl6RlqzjlzY6R9x+Q5xmI97qNi3dX/gvlPCVAYR5W4xttT1UhXJPMjdf10Pr
 MQQjhH39JdLkcBTE3Ojm25eoZL27djAW0OWo46NzOw0riW3nEB4VoMxhvZOITTlQWRhA
 mJUJ9KyEuR8+0CqOqGmFJNzqk6JziyJOqXznQQmV6kJ5J2RMW6L/9epOugnTcv+Htjj0
 ePeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqvooK+C1bbhP1W0vqc/L/dhi1N1gYiUA5YM6Jf/Ns2LbpprfAtDftyKCvaQ1b11qSn7Iaz84=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJGK5voCFMuPeANN8cGcI9gIUpuoiiK4SIAydPcEfBveHGwDKgQ
 YRI7ia9vfMJnEiLDpQyz4arXdVEqHdGonfVNoEpvtbOPp5pr94e1KFYikdc08wfZc9cIPXClJgP
 2h4ZoNQuZXN3iMZOz5Ikq9E1bGznG6OZiKgEE7UJ7
X-Gm-Gg: AYBFou0uMUJ1dq+ewYjHacrne0W+HzW8QdSEFp/9hdwkFDoLabDiSl9E0sbuLGMMc+3
 oGGZol38NXbCevhJqbLGTMT3DsWeNi8nzeSeCkHAxDc2IRXgmw5+lg2IfPJdM7D6xSwAaXsjjH/
 fNve9CSbYHWcaUWcCH/0z3u+5jRmSGfOe2xCtS+RJ/um8FaR/h9snXg4KJ/2Q0Xgk0IMWUe7lbX
 w7s+jHKswm9uqgFI3lGJEVVLxYGI/acAn573zg15kw7fWS4vwBwyi8fYlAVYyRm/vh1ZRQuV1QS
 +d7gcCYAL3Fao7ZTfo6YSPwpwwmiQJeHcaSH9ceAyWPP2192Dt1mVMAb
X-Received: by 2002:a05:6402:378c:b0:6a9:b87f:8ea3 with SMTP id
 4fb4d7f45d1cf-6af9e387fcamr1213613a12.45.1790928864864; Fri, 02 Oct 2026
 01:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
 <20261001-imx93-secureboot-v5-9-d97dea41bd1f@bootlin.com>
In-Reply-To: <20261001-imx93-secureboot-v5-9-d97dea41bd1f@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 Oct 2026 09:14:11 +0100
X-Gm-Features: AclHuK8cQv9PKW0id0MLTDd3oVWkX4DDdmZyEe5d7QAgdK-O96AI1niPPuSDobc
Message-ID: <CAFLszTiNgkzobW4_nZyTv5MHkZG=6Dx2AYV0m54PKATX0Z0oYg@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] binman: test: add code coverage for nxp_imx93cst
 etype
To: jeremie.dautheribes@bootlin.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lei Xu <lei.xu@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-10-01T16:26:17, J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric)
<jeremie.dautheribes@bootlin.com> wrote:
> binman: test: add code coverage for nxp_imx93cst etype
>
> Add test methods to cover all code paths of the nxp_imx93cst etype,
> reusing the pattern of the nxp_imx8mcst as done in commit 0cab35362d77
> ("binman: test: Fix code coverage for iMX8 and cst bintool") by Simon
> Glass.
>
> This brings nxp_imx93cst to 100% coverage.
>
> Signed-off-by: J=C3=A9r=C3=A9mie Dautheribes (Schneider Electric) <jeremi=
e.dautheribes@bootlin.com>
>
> tools/binman/ftest.py                      | 97 +++++++++++++++++++++++++=
+++++
>  tools/binman/test/vendor/nxp_imx93_csf.dts | 18 ++++++
>  2 files changed, 115 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
