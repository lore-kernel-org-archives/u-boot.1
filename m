Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A09EC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 05:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ADB387732;
	Tue, 12 Dec 2023 06:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jsQTsMM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DC2877C4; Tue, 12 Dec 2023 06:47:24 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2201F87682
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 06:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7c5ed425e8bso1325387241.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 21:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702360041; x=1702964841; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X616UBeaEQnjIkav6eqD0Z+iDoQc8rxfIsO2gjGpiF4=;
 b=jsQTsMM9IwhzK8WGNvdFo+YqMaIJ3DHLGV1e8l3TEbAfi3x88G/RB1nAc/ZZfg2lri
 Quz0ccAfZXnwAiCqTxG93PG0BLzGjHN8dOqWzdDFu56yh30uNvZpeW7tFRXfiTqo79Zu
 Errr7pbMh+jWHGZPDrMUUq9p7ovpp4ll7S4gKfETxIlz27chGhq+P7DZz3+ila19Aces
 CMd+DYTZztcL1ANgdw0uTnwnl4RZREhGR3OEIORhix6VgGtl41lRZ/Tn97HqxcN2bmwR
 dKpgzCp++CDUAzPq/gMaFLneNMHaGsWF/ZToTEowCMj0cJbbN6WLG/PUF2YPgILu9otB
 H5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702360041; x=1702964841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X616UBeaEQnjIkav6eqD0Z+iDoQc8rxfIsO2gjGpiF4=;
 b=bRBm8dlWRORcx9TjHbvE3JA4dYw+J7FX5pCxo5u4uXmys72MF4/vdjwJ+QIUNNkA4+
 9GrNYOlehux7u+1Pmud77eBzHwb978qslFnzILCOkGzRQCyzEWdNchJCLK1+J1clT793
 mHtGDyG1w5yXLjZ0sZ9jAayaEadxBSTZL/0KOvIWWSnAqxtwz4VzaU3+2Lx8NGapbFOY
 TTPQLBo2He/3wtr9GdpDhfRfRFc+1O5mRhzgf7OfXCW2iTGUuwD/519TOdeUta4kSTGx
 vvOUxsV9wYWMtURqQWyWeOoK3u21GMGGlgOnLDxsvVMfPBjF6WMuot37onVL6XMT6AWB
 ySxw==
X-Gm-Message-State: AOJu0Yw8MzSFQzJp61FwmfayMEfUMQvcigz63tbiapeZtakI3c6sSevf
 Qd2dCv+HPKoai+1wHNi5YKzYE11DEol2PXWqfhPtkA==
X-Google-Smtp-Source: AGHT+IH0Y9Th9pdUzw/LNw/BfXTWmj/Aq2w7F/vnCZ4GGCuMUPrPcN3Qfjfe5xQ5dxsz4rPLWURBJP2HbgUbSDNZbxA=
X-Received: by 2002:a05:6122:1791:b0:4b2:c554:dfc5 with SMTP id
 o17-20020a056122179100b004b2c554dfc5mr5449338vkf.20.1702360040788; Mon, 11
 Dec 2023 21:47:20 -0800 (PST)
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
In-Reply-To: <20231209220349.GM2513409@bill-the-cat>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Dec 2023 11:17:09 +0530
Message-ID: <CAFA6WYPGKhGygBbx+Bag7gXJH_QGC+DqQuj2xAND5qHv79uSPg@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
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

Hi Tom,

On Sun, 10 Dec 2023 at 03:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 04, 2023 at 11:02:57AM +0530, Sumit Garg wrote:
>
> [snip]
> > But currently u-boot doesn't have a proper way to validate those DTS
> > against DT bindings (maintained in Linux kernel). Although there are
> > Devicetree schema tools available here [2], there isn't a versioned
> > release package of DT bindings which one should use to validate DTS
> > files.
>
> I will have more / other things to say but I want to chime in here. That
> U-Boot cannot validate the DTS files is a bug, not a feature. I would
> very much appreciate if someone(s) with time and skills to do so would
> re-sync us with the kernel Kbuild again so that we can both stay in sync
> again and have the validation targets / functionality available here
> too.
>

Agree, the Kbuild changes to add dtbs_check was the first thing I
implemented after importing devicetree-rebasing repo in u-boot (see
commit [1] for details). Usage with PR [2] included:

While building any u-boot target, just add make target: "dtbs_check"
and you will see the DT schema checks being performed. Steps:

$ make <target>_defconfig
$ make -j`nproc` dtbs_check

Currently there are a lot of incompatibility warnings I have seen for
the platforms I built. This shows how much difficult it has been to
keep DT in sync with upstream DT bindings.

TBH, this was the only motivation for me to get into discussion with
DT bindings maintainers for a separate repo. But since with
devicetree-rebasing, we get devictree files bundled along and then I
got into reusing them for building DTBs in u-boot. This has the other
benefit of reducing maintainer's pain to keep DT in sync with Linux
kernel major releases (see amlogic platforms to be the first migrator
[3]).

[1] https://github.com/u-boot/u-boot/pull/451/commits/7ea2dc2477992a603fa881d0da563246ee2f02d9
[2] https://github.com/u-boot/u-boot/pull/451
[3] https://github.com/u-boot/u-boot/pull/451/commits/38c2ac62e9134604d1a56179d57baa1877712b3e

-Sumit

> --
> Tom
