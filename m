Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22187C83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 05:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F11482998;
	Sat, 12 Jul 2025 07:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mzh1iYT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D10A8277D; Sat, 12 Jul 2025 02:13:45 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5900E803DF
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 02:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=davidzangcs@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2349f096605so34152725ad.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752279222; x=1752884022; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Grd3qLmpj4XEgvOrbOmQC5TU17F+IXH/PQtnCK0WnAw=;
 b=mzh1iYT1xJDr6iX4lyVzFMzmQJ7KiMCsozbPyI2JLa8kMsRLsCIR6faU8GADY2me68
 ZkgI4UDHtKMnJ9wi1pjoEn6QN+c+4KyCuXzku67KwC2TY/Bk5fnsyLh/VBkPeZgeDo1J
 Wu3hGBURFS61FOIgNjXYdhuy9PfljLL3LMUbN1J00lmshUkMyQ9PCjwwNE7q+JbfAnqN
 BnrAg3WVNTuilwe2ZTDG9PUeyOPL7XiN3+A+oeYIJr5PNZqQszsR9Zd/8dxvpigtBsyA
 di9EF+b5CqvXrsqa6yNNqduv4+cH++Ufho2gobXpUcWJvIxnipDvn87t0UZZSMUF2S5M
 K8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752279222; x=1752884022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Grd3qLmpj4XEgvOrbOmQC5TU17F+IXH/PQtnCK0WnAw=;
 b=FzMy6IZWbNp4xVCsHkeH9LG/amX2pcjnPNDjQHY09HiLefB/AISvDSq1tbbWSe5AWs
 P+WQztWeskrgyTzDmcCmP0taFgxr3Tp7Jjm51YMRMlYHa1fxg3dyIQDl9ga8483qywUT
 6olkM35zBsJuIaOF7kOUWW1TwPojbYqW/HbnSwVcIVgiXw11M1uCSOYhRt0e7pOwiNyK
 qV0rem+bqc9YH+9Mni6vs8pomuEXYiAjCVEanIYYREpwgHwuWxxvNqTG6Rm1YnHF3poB
 +YZbTRG9fqHOgMQWnWom2DwejDCICBHN3ZuYZVMfMzE6r4fNqQhGci9rFelMj+udcYSd
 xyrw==
X-Gm-Message-State: AOJu0Yytg4CHa+jeePC8YlrEhfkL6K25aBeO4R13ILbrIE4Jf/P/QfFF
 GLQzCCeKXh5Dci1Fm/eDD+JhydR9UwLyVdi9+dYTKUEFcA7QeF4QDljDZ6yuutN6A1XRzh8ARUS
 7ZA0j4EXl0sAIiq+pu3PLu5+C87KuRu0=
X-Gm-Gg: ASbGncuoI+O5eq0ykgh5YMn/jySix7RebuwI30WcELihyfNWHvInGCxK1H2D7WfFsxH
 DKpVi52UEPB/mbEHWnQb9JM05iZ1uczJ5AmnHmxuP7jrue2S5iXIGn7x4X91O8ZN3XS92w0Kyy1
 WXCBLggxDk3t5ji/ji7x9BO2qSXD5oNOSzUuKN+OTcSRMv9iVGN6iCRxIcEL+ULA7RewYho8gwy
 7bpCaWI5YPsBK8=
X-Google-Smtp-Source: AGHT+IEz7CCuVuULnTYsVECtcAwDOw+T6NCXxnvi/2wrbQ1dYaGqVGZoLbQvsQQSsrKUnLNhGB/xp95FkZmLGmV8LaU=
X-Received: by 2002:a17:902:fc8e:b0:234:b422:7120 with SMTP id
 d9443c01a7336-23dee17a4b6mr58053415ad.9.1752279221769; Fri, 11 Jul 2025
 17:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250709234918.140919-1-davidzangcs@gmail.com>
 <CAOMZO5D1d=Y9i9E+Pcm0sbyKE+M=zUj_9Rs_QHbaE5DPvWFA=w@mail.gmail.com>
 <CACwB3C-KKZS_5JOfFvF5hWsXr4AXUU+OTR1+rBSd5NpkH4r+rg@mail.gmail.com>
 <CAOMZO5AXxp3x+mErrWFMX_3SUt58jGDZCAXOo+De=0b-ORA2GA@mail.gmail.com>
In-Reply-To: <CAOMZO5AXxp3x+mErrWFMX_3SUt58jGDZCAXOo+De=0b-ORA2GA@mail.gmail.com>
From: David Zang <davidzangcs@gmail.com>
Date: Fri, 11 Jul 2025 19:13:30 -0500
X-Gm-Features: Ac12FXzkurAkv-siwQP5HALCkiMDTqExQkdVacXTvE5Ff8mGhjZz0AR-ixr79Nw
Message-ID: <CACwB3C9cvxRx2+RFhqnoL56D+WWU+qhYJcQvCxhcAzF_Un1MaA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8ulp: Add celsius unit for temperature
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
X-Mailman-Approved-At: Sat, 12 Jul 2025 07:42:59 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 11, 2025 at 12:24=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:

> On Fri, Jul 11, 2025 at 2:22=E2=80=AFPM David Zang <davidzangcs@gmail.com=
> wrote:
>
> > Since it is a simple fix, do I really need a commit log?
>
> Yes, even a single line is better than nothing.
>
I sent out the v2.

David
