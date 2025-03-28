Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7C7C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3138082A;
	Fri, 28 Mar 2025 12:42:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jNT1uBBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E6A0810EA; Fri, 28 Mar 2025 12:42:28 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A56F805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3015001f862so2457975a91.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743162144; x=1743766944; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruu4lRwQOo+28vlXNpLRO26zKf/SMLQgG/svadefDPM=;
 b=jNT1uBBhBdG7IZRHJznLK2h0YtlXu0ZSfjEYCDhD/9sX7/CoXcHvYn7/Im9B07Fgu2
 OzuoR/cTy3mf2lrzzG/P84192oU7qk7ipNn4KZfIoIQpE3BlC69ks2HRb0OLTNlbXzbe
 HjYM0DTQ1LerPNklgGsHDLP5ClDB6nMwHKT+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743162144; x=1743766944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruu4lRwQOo+28vlXNpLRO26zKf/SMLQgG/svadefDPM=;
 b=c/85baUcIeQWq70g2++f/uITgo/XCDCnJQ3pB61KQPKOcKGeqehOVK7S4CA7b2SSOz
 QDJioniD5JumZuQvn7smOgo+3UfSGSfVDJ6mvMOuhKlSowkkbfjKoRXS3KLKP0uQ+niz
 1jj4VOEAbka/VR6QJAYMjfiFAqWQs7n4lwXkDmeidmzVn/CidppB3lyMAB578QPhXmPd
 iKsawby77j9w3QcnoYleyGvLaJpyR+RCYJ0eHhiD5t40fxUCJQPj1G/RSt4xufGBw72z
 pizD2jfUcC8V7rmTAaF5T5gZ0HPfGWaP6oZ0764gE5fIek9IMdmEU/SGO1T3HaapGaxO
 VcrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+RbZaW0hBuB5qz1VOn0f2+ZzO7iXhvwrDwUBgxGBEMf4Uxy2EKfQ/RNXn53hDxRQ9/fxvotg=@lists.denx.de
X-Gm-Message-State: AOJu0YxJI7BhaXqR5FDyiHDBb48nJh2EDgFQ030kS4CcnB5GeGMpyhF9
 qisSSJUI3itZ99OfJkydv01t8az8Dfnp0/BFPejzKlgJvg8Q+0Ofu0RIgn8kwtt8pa0AJiO9/3R
 2PJQNNpeHzSiMpFwi9UYjVf/ecAqEmTD6VN/4
X-Gm-Gg: ASbGncuZSDmttgrDcOpp3pRZI8tcsi7VnkUygdJdtSa+6eYOfOM/r+SBDSmlDdb5MZM
 dmwe3Vy57l0e5df0M/Bv3rCFn2CHpLt9Iqy8iB6W+IsNNZUcbd8M1h4ItNbwM6zH5Ixg6jP6eRl
 Mw0Zf1o5nAEAHQy27HMe/nIPGarb1uYOEXpifvSQ==
X-Google-Smtp-Source: AGHT+IGipoAA5IdvNzL0+c4kF2VGaiiMxQFtiiOP9cIcvt7q5ZWl+rHD3DOase+PEVze+YyIds8K18xdWolnq45PNY4=
X-Received: by 2002:a17:90b:1c03:b0:2fe:8902:9ecd with SMTP id
 98e67ed59e1d1-303a7c54aacmr8001033a91.1.1743162143826; Fri, 28 Mar 2025
 04:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
In-Reply-To: <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:42:09 -0600
X-Gm-Features: AQ5f1JrN7Ih_t6vlP91tO5msSlpu2bOnhMBvxDnBV4vn9MaFVw-JIn1ZM9x4dqo
Message-ID: <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>
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

Hi Marek,

On Wed, 19 Mar 2025 at 22:05, Marek Vasut <marex@denx.de> wrote:
>
> On 3/20/25 4:40 AM, Simon Glass wrote:
> > Hi Marek,
> >
> > On Thu, 20 Mar 2025 at 00:54, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 3/12/25 1:41 AM, Fabio Estevam wrote:
> >>> Hi Marek,
> >>>
> >>> On Fri, Mar 7, 2025 at 2:42=E2=80=AFAM Marek Vasut <marex@denx.de> wr=
ote:
> >>>
> >>>> So what should we do about this particular patch ?
> >>>>
> >>>> Should this be applied ? Rebased ? Updated somehow ?
> >>>
> >>> This patch causes a CI error:
> >>>
> >>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151
> >>
> >> I think this might be what Simon was pointing out, but I never got any
> >> suggestion how to solve that.
> >
> > There was a patch for this...and it looks like Tom has applied it:
> >
> > 19a342f9122 Merge patch series "binman: build_from_git: Add argument
> > specifying branch"
> It is in u-boot/next , but it does not seem to help ?

Did you figure it out?

I'm not really sure. It works fine in my tree and I just tested it
now. Perhaps there are some other patches missing from Tom's tree?

Regards,
SImon
