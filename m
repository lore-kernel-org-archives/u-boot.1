Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEEFC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 03:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC198193A;
	Thu, 20 Mar 2025 04:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUn2D+7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241AF81A0C; Thu, 20 Mar 2025 04:40:41 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8461481A0E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 04:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1c6ff8so656577a12.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742442033; x=1743046833; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfRfEsXNTaqGnjIgnB0rZRU5w1xYX7uIo53tpYDaHzw=;
 b=MUn2D+7R3fR4Qu0WDnrupd3N7FgrewGy1m9zv60Y+AVY+emzYHjLz1jKfHgOauLrWY
 9P9dRj5czM/jxw8nZOfiz0BDIHvVdZhUwv45SUYagVMZzj66+M7iJYPjt/R7F6TQ7BmD
 nnvHTjbLNlcrivc437aJBfuZRdaBB3wAB9FvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742442033; x=1743046833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfRfEsXNTaqGnjIgnB0rZRU5w1xYX7uIo53tpYDaHzw=;
 b=dTmNnB+dtMxlFnmNywpcfKgL5XdJMCqpiTHrJYTivCdgYjDG01OgCK291HQt9laz2c
 BzmqlpWWvbCTxyeZUu6EBIuaNoe+VSGPkzas3HmmN0xcNxmPMtPt/ym79NjfFJu01ZT3
 R9MWyd4QE8Yy8RUfSLC6Ug+5q5n6mUf0G4nxbZjpTe+ZdPtWm/Gpgzo/SF3xlK5aG30e
 DpaNR5UDnu3MnQDp2m7nPGdYoKEhVLRBZt2Li/Tc0DWtMcClF8laUPAGgd2VEuUiaTCr
 n0JnlyIZnHj9SFgF3AzJdeE3JbZTfISX2db2sOk3WEktt50d9XnT1GWA9xp92lum1oyT
 EZgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5rZMyQrWVAAKs1oij8fw9xpZCSINhiPN6xxwT82vdt7Et6qEA3Ha6epAMrORh8lhisOH9Zxc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4CpQNr7zouoLjVtTpEk7weLYbXprm7s5ajdvEp4hHD4R6XUPm
 sgHTnqIj/YPz8LBVCPcnIfTvKmQuuKnebpSJ/oNY7ypfUiXTNEOSqOQe1h2Q18KmJp+/jihP99G
 Tbm8gqTTArOwtH3coDBJ+3xKGyQK824HSVde4
X-Gm-Gg: ASbGnctYkmKfjjzw+cpWp2BUbQakta59MUTaaGOmjY6FO/GVcBQV2ca7Skqwr/Ffcj7
 gvvtSq0aJRwbta6BkTT+NqvqZnvpQNyGIdwLVOpNiuDWYa7niFRAjDphGewgSUEWJTAUwdltyam
 shycXEPtvEdtDI1mBAhAmBBb2/HRA=
X-Google-Smtp-Source: AGHT+IGjaImjh23dbOWhna/fLg6aDlNytMlWV36/1XMiOOHK8etxc0Lot3u84niIMVJP1aoGt0mdTzSVsPqaIdo74vo=
X-Received: by 2002:a05:6402:13c7:b0:5db:f423:19c5 with SMTP id
 4fb4d7f45d1cf-5eb9f1d47bemr1668260a12.5.1742442032832; Wed, 19 Mar 2025
 20:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
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
In-Reply-To: <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Mar 2025 03:40:20 +0000
X-Gm-Features: AQ5f1Jr2BpYVyTk6kHZ7h-3EFLaj5mMuryipVzbQgjZBGGueFHJs7eV-kX94vX4
Message-ID: <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
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

On Thu, 20 Mar 2025 at 00:54, Marek Vasut <marex@denx.de> wrote:
>
> On 3/12/25 1:41 AM, Fabio Estevam wrote:
> > Hi Marek,
> >
> > On Fri, Mar 7, 2025 at 2:42=E2=80=AFAM Marek Vasut <marex@denx.de> wrot=
e:
> >
> >> So what should we do about this particular patch ?
> >>
> >> Should this be applied ? Rebased ? Updated somehow ?
> >
> > This patch causes a CI error:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151
>
> I think this might be what Simon was pointing out, but I never got any
> suggestion how to solve that.

There was a patch for this...and it looks like Tom has applied it:

19a342f9122 Merge patch series "binman: build_from_git: Add argument
specifying branch"

Regards,
Simon
