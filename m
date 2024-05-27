Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48BCC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D0C88306;
	Mon, 27 May 2024 14:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TWoNszyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BDD88315; Mon, 27 May 2024 14:03:17 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD5187EDC
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 14:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2bf5797973fso2766639a91.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716811394; x=1717416194; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ETm1Ji1e0oW5i1UmdNFFBIas2eccGIoGr8A0+vo7Jwk=;
 b=TWoNszykxMI/lPmXcXmNvZpkFpiWKW3Tw4FBZTg8F617WqB5dkVuP56ZKe9oedzoiJ
 pFrwSZgS9bfMUxMAh3CIjYoLGSTWrxP+dWM5RIK86NenkHI9NbnqxPVpthqWmweahcsE
 GAD5vJnIx39TFx46ZfZBgIVa+HmUenNW4qz2SMGp6H8aX0KUYCOAfAFYsP+s9Z0+iIOz
 QeNtm7Vn5xjmzxC7ohXytRhWzGPSPPiqXskW/Eh4XawXt8ZVTAjBhDvpYCsfuTfDg5Fq
 hCLrA9SnswAVMm1VY84/WPvEsXPhr9oJEO+2V53uCWlNFUivgaKLMEvIgdjdPiSrEjTI
 C4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716811394; x=1717416194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ETm1Ji1e0oW5i1UmdNFFBIas2eccGIoGr8A0+vo7Jwk=;
 b=MWHSfioZps3BV8nB06kndlWBh9bVuu6GUC+pKoiUlwtqQXFoUIfvDeI5JlTYH+pMre
 tE4hGRKt4MrrH46Vtq+j+jiAkLgQa/0CBTDHUwXNRf9g5cB2geqRS4FpjeUTqY0uakr8
 9iSKJPdHByWmrpnXW5VUZN5kZQ0tjdFVa9RUGMG/3lpnafE76x7W+1ZbL4Hc6IMUiUnM
 B7JQLT9UW9dW4M0b0aVlQ0y8KF8Rh6Kqmr0p9u2uT9XQs3ut4GQaCPNZdSTzIhQlHE9t
 CmppWlxqnOTqAvvArrrCMFAItIdspG4f7MmpYlgwnQix12zb29dE5hlWodLaUP81XMg6
 b6qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSbXj+E7mMqT7piq5JGRQ1ZYAiCGUwlwOt7shSijwDDbvgtkfMxWRZ+7uHk2GbH8cxG/n4ZhVCAxxBG4pr2HE/G14rnQ==
X-Gm-Message-State: AOJu0YyuCUa77ruSYipPy2e9ALkvc9UjCQJ3/Kjxp0HH275hcZv0K8rN
 C7jmEP1RVM04U6z9rfggOLRcHGbQz7SNSx3eyr2l5qvZ2EtDGOrCR/MbhtE6Y2iXL5Yuo2aDiva
 sYsHwhe7Ck1lwD9ZFjlcwsbSUUxN8TXTSlu66ow==
X-Google-Smtp-Source: AGHT+IHbvVaAUIAys5dtXSGOuTzXw7QlprxzCV5kkgG9a1CoDoaCek24TNl1ghXH3nEYVQMNC/x2HsV46oEtCi5d+fc=
X-Received: by 2002:a17:90a:5e48:b0:2bd:92d9:65f3 with SMTP id
 98e67ed59e1d1-2bf5f51b1d8mr9356551a91.33.1716811393933; Mon, 27 May 2024
 05:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240525200049.3904124-1-tharvey@gateworks.com>
 <20240525200049.3904124-2-tharvey@gateworks.com>
 <20240527105910.3bb425d1@xps-13>
 <CAC_iWjKGijjMXoop2i97Rpc+ZzSWWb6Vbd9XxW9WKqvcRwJwhQ@mail.gmail.com>
 <20240527134804.1bf788a8@xps-13>
In-Reply-To: <20240527134804.1bf788a8@xps-13>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 27 May 2024 15:02:35 +0300
Message-ID: <CAC_iWjKZ3PAKiBbLJWhGS1EDNeNf6hTBdChrmLZYX=EoLA0iMg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] tpm-v2: allow algorithm name to be configured for
 pcr_read and pcr_extend
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Mon, 27 May 2024 at 14:48, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hi Ilias,
>
> ilias.apalodimas@linaro.org wrote on Mon, 27 May 2024 12:44:11 +0300:
>
> > Hi Miquel
> >
> > On Mon, 27 May 2024 at 11:59, Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> > >
> > > Hi Tim,
> > >
> > > tharvey@gateworks.com wrote on Sat, 25 May 2024 13:00:49 -0700:
> > >
> > > > For pcr_read and pcr_extend commands allow the digest algorithm to =
be
> > > > specified by an additional argument. If not specified it will defau=
lt to
> > > > SHA256 for backwards compatibility.
> > > >
> > > > Additionally update test_tpm2.py for the changes in output in pcr_r=
ead
> > > > which now shows the algo and algo length in the output.
> > > >
> > > > A follow-on to this could be to extend all PCR banks with the detec=
ted
> > > > algo when the <digest_algo> argument is 'auto'.
> > > >
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >
> > > LGTM,
> > >
> > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Thanks for taking the time, unfortunately I've already queued these
> > for Tom and your r-b is missing
>
> Maybe it's not a big deal to force push your branch?

I've replied to that PR, hopefully Tom will see it before merging

> Otherwise please
> consider letting a bit more time to the reviewers next time. 2 days
> over the weekend is definitely not enough if you refuse to update your
> branch.

I usually do, but the patch is on v5 and had no comments apart from
mine for > ~1 month

Thanks
/Ilias

>
> Thanks,
> Miqu=C3=A8l
