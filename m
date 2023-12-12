Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A744C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 20:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366AE871F0;
	Tue, 12 Dec 2023 21:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I6XmJH7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A19E6871C3; Tue, 12 Dec 2023 21:21:40 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932D2871F0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 21:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robh+dt@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 23369CE199D
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 20:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59071C433D9
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702412493;
 bh=SY95+F8Z47lGYKMxFn4K62RRzDkr//qur1NPKltTrSY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I6XmJH7mePsqrDlEf2lJ9AcCxJX96PnaAYqEvSMYQnfFIb/OICSmbF+fbomEBytlO
 LELrPuAUsLbsT5nKMKZ7OpRLe1p1yRZE/k/Iqhyn8N/scUwxh0KiOVJc3sqfzcuU7z
 MMBUYUTeMpB93pGx5XTH8BXuzuxcSfQ5DcCPuznpe1rZt6VQVZj1VK0sPSHxf1rF+w
 EBl7crBD8sln2XPuo2/lmd/C4dV5sPxmUnD7DrbLMac/ZXdkZiRYAVUtNfyKkdjs8y
 xpV3lnr5kEIX6xCUV7O0VVa9fW0OJvJ888l4q969ur9QlrPrLYh0eAdWB42Q+sjMIn
 d58j6agQcCFTA==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-50c04ebe1bbso5932446e87.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:21:33 -0800 (PST)
X-Gm-Message-State: AOJu0Yw399A20Auk8zLSF+zSeJ5HcwMPcSOeb9cLujTPAEk+Ujh8zZR2
 Qi/w8Vcd143P5zey86M4qqQ+1DoEVzXLcFaoWQ==
X-Google-Smtp-Source: AGHT+IGet96syJvhZm/YVJD2QMIm1KwsOTbv6yC+6ekymPhAcC9Hziz9Gp5Z70qKJwZ20LzsTDUaHDBXCcsYg+1CCoA=
X-Received: by 2002:a05:6512:3e24:b0:50d:1456:58f9 with SMTP id
 i36-20020a0565123e2400b0050d145658f9mr4637546lfv.3.1702412491540; Tue, 12 Dec
 2023 12:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <20231209220349.GM2513409@bill-the-cat>
 <CAFA6WYPGKhGygBbx+Bag7gXJH_QGC+DqQuj2xAND5qHv79uSPg@mail.gmail.com>
In-Reply-To: <CAFA6WYPGKhGygBbx+Bag7gXJH_QGC+DqQuj2xAND5qHv79uSPg@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 12 Dec 2023 14:21:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLo4nXrJ93dDsfp3UYLs08V02aMnbCCnsDj0MBBomc35w@mail.gmail.com>
Message-ID: <CAL_JsqLo4nXrJ93dDsfp3UYLs08V02aMnbCCnsDj0MBBomc35w@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, conor+dt@kernel.org, 
 Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
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

On Mon, Dec 11, 2023 at 11:47=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> Hi Tom,
>
> On Sun, 10 Dec 2023 at 03:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Dec 04, 2023 at 11:02:57AM +0530, Sumit Garg wrote:
> >
> > [snip]
> > > But currently u-boot doesn't have a proper way to validate those DTS
> > > against DT bindings (maintained in Linux kernel). Although there are
> > > Devicetree schema tools available here [2], there isn't a versioned
> > > release package of DT bindings which one should use to validate DTS
> > > files.
> >
> > I will have more / other things to say but I want to chime in here. Tha=
t
> > U-Boot cannot validate the DTS files is a bug, not a feature. I would
> > very much appreciate if someone(s) with time and skills to do so would
> > re-sync us with the kernel Kbuild again so that we can both stay in syn=
c
> > again and have the validation targets / functionality available here
> > too.
> >
>
> Agree, the Kbuild changes to add dtbs_check was the first thing I
> implemented after importing devicetree-rebasing repo in u-boot (see
> commit [1] for details). Usage with PR [2] included:
>
> While building any u-boot target, just add make target: "dtbs_check"
> and you will see the DT schema checks being performed. Steps:
>
> $ make <target>_defconfig
> $ make -j`nproc` dtbs_check
>
> Currently there are a lot of incompatibility warnings I have seen for
> the platforms I built. This shows how much difficult it has been to
> keep DT in sync with upstream DT bindings.

The versions in the Linux tree generally still have lots of warnings
too. It's a mountain of warnings. The warnings get amplified when
there are N boards for 1 SoC. Some platforms are more active than
others to get rid of them. Newer platforms like Apple are warning free
(or nearly so). If you want an overview of the state of platforms, I
have a CI job[1] doing just that. Look at platform-warnings.log in the
artifacts. It does some deduplicating of the warnings. Linux-next and
Linus' master are built daily.

Fixing the warnings alone will not solve potential incompatibility
issues. The schemas can and do change (and in turn the dts files). We
try to catch that in review, but the rule is that the platform must be
okay with the ABI change (recent mistake, early stages, limited users,
etc.) and the commit message must spell out 'this is an ABI change'.
That's all manual and not easily identifiable. I'm working on a
tool[2] to compare versions of the schema to identify some ABI
changes.  Though it is limited by thinking of what schema changes are
ABI changes and my ability to write python code to parse those cases.
Right now it looks for new required properties, removed properties,
and changed number of entries. I'm interested in any ideas for other
checks.

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs
[2] https://github.com/robherring/dt-schema/tree/abi-check
