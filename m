Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4D8C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABA984058C;
	Wed, 19 Aug 2026 08:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mark4V3Athav; Wed, 19 Aug 2026 08:53:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129636;
	bh=aHQWZv5bo1LFPaxWf/ZPdcIi4VT8g3Y+pKJsI/ptfFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZggX/eXzOGuWJNwI3XE/R/X60gbvoctnKFXO/6ycB6hyLVzai+HbE6fCW5KfwEWKU
	 3MHkc97NBJ1S29dlqk1Cg2Vd/cp6Ax5AUQpQzcNFh0s0HqAvJf2iHS5bKu7qcYxXK8
	 8fWf9XVX0VGatSLlDbYgh0VwaFg0UWTZMwS56oA6A/KJNQ1Je52UuW8YxeaeWnIg66
	 1nIdh7oTyQT6TnV3fQnYAVnlXxDwp4HG1PU8N+jSA+H0iLEgapcl0yIqnQqTqmvcD8
	 Gw+1EqT7E4LHNZYWK5JdDzPkEwsIv+kY4+30DLTNzm90cvzE/JZm5zSVbSd8AYKsg3
	 +V4xjezgLEelg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 253E440633;
	Wed, 19 Aug 2026 08:53:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 02FF32FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8A4580CBF
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:53:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrwESSztzf6p for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:53:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Dn0UN71T
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BE1780C6C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:53:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A92C4372B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8671F00A3E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129633;
 bh=aHQWZv5bo1LFPaxWf/ZPdcIi4VT8g3Y+pKJsI/ptfFM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Dn0UN71Tr88EWexIgrNjEvFwU8wykZ2NUq/ZZ+sp1nkwlUxnRt/AkjBY2of/duGuA
 a1uqngZ2+NNf970mgpE7mZmdqlY6zX4b2LFuYGCn1QanVLhsmILjDR//2BsO4SIBtc
 w8cvmIT+0pGk8R7lfoI2PQ4Ls1DsglspZOUf8zujgD78Pr3ary5nWHJhUmzY7si+is
 mQZJ+xOL5NZUJFEmwlcgVqV/Jfi2+0wbjp6jGKZtKemKnanYWOf1G79nNPLeXCtgiJ
 LJI1cuqJL9WU4s2sitmdrSXifLGueNkpmUmc3o03rTyEzhIJifMSuylU7qAqpw3rqx
 3qD7dbyVwX6BA==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b015b2d792so904541e87.3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 01:53:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz++p645DFcxOSld/0KYx7mQ38Nqn3cYPG8W+8fk5o0P12obUiX
 QopwBhg2U4BbV24+qKLh+OMBfDguPBOVhD4v8jOkVoDAVINN93vDYB+J2GfjMR615U7iigJmqH2
 kQUImamUPzIcWcEvzg+SPZYUHmqtN9Nw=
X-Received: by 2002:a05:6512:3191:b0:5b0:1e16:e60c with SMTP id
 2adb3069b0e04-5b478d3018cmr861945e87.25.1787129631954; Wed, 19 Aug 2026
 01:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
 <aoM6qJ32H35aumPL@linaro.org>
 <CAD++jLnTaaN9ektt9h5S_jYZ27sezSfuymmjTGiL1_j8NSw6bw@mail.gmail.com>
 <aoQ2VMH_unoQaQxO@linaro.org>
In-Reply-To: <aoQ2VMH_unoQaQxO@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:53:39 +0200
X-Gmail-Original-Message-ID: <CAD++jLn4VB9FK9pkw9d+fdJuDGGTr2=94qyF9JYWhxp3D3JiPQ@mail.gmail.com>
X-Gm-Features: AcwNN1Urgp4hamOJ-l_y7mTclb4zJPq6r8Wrri3VfP__WopN5hfdNxx1rtwph0c
Message-ID: <CAD++jLn4VB9FK9pkw9d+fdJuDGGTr2=94qyF9JYWhxp3D3JiPQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm: u8500: Switch Stemmy to upstream Janice
 device tree
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>
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

On Tue, Aug 18, 2026 at 12:39=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:

> I wasn't suggesting to use the same DT for all devices. What I suggested
> is to bundle all the upstream DTBs for the individual devices into a
> single U-Boot binary (CONFIG_MULTI_DTB_FIT) and pick the correct one at
> runtime. :)
>
> That should be equivalent to your setup, just more convenient for the
> user.

Hey it works!

The bootloader crosses over the 512KB limit but we have space enough
for an entire kernel so it's no big deal.

> The only open question for me is if we can reliably detect codina-tmo
> based on the mach-type ID, I can't find that in the kernel sources I
> have.

I brought out and booted the device. It is re-using the Codina
machine ID.

However we have unique board IDs in another parameter which is
enough to discern the Codina-TMOs from the Codinas.

Sending a v4 patch series which should contain all you asked
for. It also works.

Yours,
Linus Walleij
