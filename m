Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD66DC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 18:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066E981DE3;
	Mon, 31 Mar 2025 20:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LD7sRtDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE45A81E5B; Mon, 31 Mar 2025 20:18:26 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5218129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 20:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54996d30bfbso4178551e87.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743445104; x=1744049904; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2VyTRGeweTf66uiUaDEF3Uk/WbEI4jZHj8byxDvI4c=;
 b=LD7sRtDKp1ZTqA7+oVWDwagm285ODriuyWSo0IlGm88ZS8pIw4/LShvdcj+ZtKAf3E
 ApIYjQvT8EPH/apHxt9Vo43TfPDtT89HZhEbM1bmhPjHpT/EhWXwK9fhMLkfff4VPA+D
 U9kGGCWTjqmi6bGttulNmTb4lDQDkdJ09Xrd/7u6/MlJc9VSjdyV3MktV3MoxGL6L/zB
 obHSjhSuEYo2tj8hon+lozOXqnzRm1Z6TyXX76rYUAujwTWLUHFZxXummgXfv9tmf+4h
 q3HgeBYLIlPvMbVC3mw9h0JNrTtgDE48dKeAi7zQ24j0W0/2UCIGVrQNhbJi5doJSdQw
 a7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743445104; x=1744049904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2VyTRGeweTf66uiUaDEF3Uk/WbEI4jZHj8byxDvI4c=;
 b=sInAguvU5gI1EgmCIfRMXzFMaJsVTQ1RrqfwM5wIeLpWLdL4SQN8ow7zeFXI8734oN
 cjySJ1A4P/+a8l+sEtRE9OPLx3WLEHc0YJ8LKd7eu3MHx/Y5s9BHpAgOvCMi2c81LcGd
 gOiC4PX9QMoCs/EiCDNwDRq7GJ30uk9F8cydIsw/xrxZ9gUXbPN0SD9S5hmKk/66r/B0
 UnkRCfLUEWd06TuYRaM2485CtoRHn1EBhYaMTEyIytmXzHS9rfu1jbYh2ieFjbPNvtrS
 N3LmHGGUWh+03xakUTCYZ754jNVkSBaaNcYFTpomOOPM+YfiPPya1I2RzLcNiutRup+r
 QJKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhH28WnL+pvdPX+EM2XKwYyLwiRc1N2edCq9nY92lYMH0bjtlkx1F1eCuNpSl8/v+953xtVE8=@lists.denx.de
X-Gm-Message-State: AOJu0YwFu5G2xuWMmljZTNFNKtRNp5dF8sRMBBntHeMmqniG0Uwiitkj
 iMG+8XjAkMB95/zkBlDSw4+V5Q3BnDTgGo/I//YUbFvfnmnYtLCtFO93eiHMl3A+g+atOappHtx
 aoIoeLbeUT5G0ACc3zu+X+5KTP9c=
X-Gm-Gg: ASbGncso/uTF/hcCePmRY5ZYKdOGKAe2uZv2RaJTiYccU39hicDs9pH0WNN2SvF4trI
 gqutcp6DdsrTu12tz/3SQQTqsWzX8Js0Z0TEtRdK9OpJ8qbUisQaswN6t73rxWQm193riIENml2
 MF9EYQhnXiEDD4J5dhL0c/fmfY+Lk3yBKz3Z4sTcRXofmkU9ydP9W3+IB/OA==
X-Google-Smtp-Source: AGHT+IExfKeIfZyiR64nYrrnBI0UOtbJALC2mxWRooEGSuvzUEdsOMbKEveqxvkZLidIsYisOWpPA6RJJCtTqqNPA2g=
X-Received: by 2002:a05:6512:3d19:b0:549:b0f3:439c with SMTP id
 2adb3069b0e04-54b10dc7ef0mr2942374e87.21.1743445103841; Mon, 31 Mar 2025
 11:18:23 -0700 (PDT)
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
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
 <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
 <0261fb66f34d30c6fc3ea1995bf23d4a055dfb6b.camel@phytec.de>
In-Reply-To: <0261fb66f34d30c6fc3ea1995bf23d4a055dfb6b.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 31 Mar 2025 15:18:12 -0300
X-Gm-Features: AQ5f1JqBovZLw-qiunQR9GHyoOvjGkL17mL_cQF8drGO7jcvty6a4p791fH_S2c
Message-ID: <CAOMZO5BtELcioQPygHGx6rsRmFvxeStn-PFf3B22BeXkgUbepw@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Leonard Anderweit <L.Anderweit@phytec.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>, 
 "brian.ruley@gehealthcare.com" <brian.ruley@gehealthcare.com>,
 "marex@denx.de" <marex@denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, "ravi@prevas.dk" <ravi@prevas.dk>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "paul.henrys_ext@softathome.com" <paul.henrys_ext@softathome.com>, 
 "tharvey@gateworks.com" <tharvey@gateworks.com>
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

Hi Leonard,

On Mon, Mar 31, 2025 at 11:43=E2=80=AFAM Leonard Anderweit
<L.Anderweit@phytec.de> wrote:

> The error looks like binman is never building the missing tools.
> Run something like:
> ./tools/binman/binman tool -f missing
> before the binman tests.
>
> This test setup uses .gitlab-ci.yml, right?

Yes, I think so.

Care to submit a patch that fixes this CI problem?

Thanks
