Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB99C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 21:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE2E8783F;
	Wed, 20 Dec 2023 22:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="dc2Mp3Xj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900248783A; Wed, 20 Dec 2023 22:08:26 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 539C287846
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 22:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=naresh.solanki@9elements.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28beccb626aso58970a91.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1703106503; x=1703711303; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G5F1Oi8m8ZfL1E9biwLNb2v1oPTnGTzQVPor0NI2CRg=;
 b=dc2Mp3XjL0rcUJ2VXLMuJ/tHZrtU2b4j2gyDa4+lWLsG3VyUoNHe4w41fUybfZiEUB
 kRqc9svgzxCUASD2P0b3C8uXxyRdFzUuPjL+be57aLmO+N1g29EjJIbxxOHPaLMFST0a
 aFAD6HOnkSnaIqtigh1E1s4JTcsaOaF287Wf/PWFQLuzGttNrnhudson7xf8+BnYXijy
 QmKl8tK6J3cQLE4X3yPM00VSqebVdlEPcn6iUMPs7cBfI/ACT1/50crdyV4YBh2AbDOv
 G28IEImUFGIKQNTw06UvqhHPtdTKzE8H/TWz+X/8Wed08mHxUX99QY9YbagBsxzTNL/0
 Xlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703106503; x=1703711303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G5F1Oi8m8ZfL1E9biwLNb2v1oPTnGTzQVPor0NI2CRg=;
 b=KIUvfA3yiSmCUiCA3ZGbzw3Xm8WCNm8qRl8P/LH0mWFsMSSToB55/r5xAQ37iDHEKh
 KOz2n9jj7XTJJADzKObln+DBshYcY/80ZcDn+0fC6dixL8CorgAuBHGA6rD/v89iYLck
 wUpRlh5OgidfnaUH+wZ9X8rf5s8rtNaokvoMPOdXcc9Yq58XvgQyCqsC/sDKR3lo1afX
 XvjXlKrgv853212GnLAt8J6yArhw2Q5j870uzjuORl8omLWDrwauFncQB7fMD7Jma+7h
 k6Yn9CZ55J8rQUanzFNeQJMz2cq0BvIf5FSq21puFrWCkSVbLMHGOfR7O4upBxsQvrA3
 pLog==
X-Gm-Message-State: AOJu0Yy6T/CTSniqg4C+MqpZptJeC0xPPkG8h7u9hnBnn1FjntWaoYYP
 E+dUkBiaLDRzl3RFbR85jDtGaugVR9nPtdIh2+FvK6Cp+Zo2TtOF2iMeHQ==
X-Google-Smtp-Source: AGHT+IEtpMgPI7CO1GnQgahb0mWP90LEEW5hV4Xs93vHEwX4xJrNV/g+gj/8lKBqBKnqkQlvO6juhnlSkSCjMFqfIog=
X-Received: by 2002:a17:90a:fc92:b0:28b:cc2d:7790 with SMTP id
 ci18-20020a17090afc9200b0028bcc2d7790mr1358632pjb.37.1703106502702; Wed, 20
 Dec 2023 13:08:22 -0800 (PST)
MIME-Version: 1.0
References: <20231220091236.1059109-1-naresh.solanki@9elements.com>
 <20231220191211.GO2513409@bill-the-cat>
In-Reply-To: <20231220191211.GO2513409@bill-the-cat>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 21 Dec 2023 02:38:11 +0530
Message-ID: <CABqG17h=HC=Fifze+5G2kQ7x5DTW_THzNrsua8ZM=e1uLDn+Vw@mail.gmail.com>
Subject: Re: [PATCH] sbp1: Add support for IBM SBP1 board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 20 Dec 2023 22:09:27 +0100
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

Hi Tom

On Thu, 21 Dec 2023 at 00:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 20, 2023 at 02:42:24PM +0530, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 SoC.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >
> > Changes:
> > - Update MAINTAINERS
> > ---
> >  arch/arm/dts/Makefile                |   4 +-
> >  arch/arm/dts/ast2600-sbp1.dts        |  96 ++++++++++++++++++++
> >  board/aspeed/evb_ast2600/MAINTAINERS |   1 +
> >  configs/ibm-sbp1_defconfig           | 126 +++++++++++++++++++++++++++
> >  4 files changed, 226 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/dts/ast2600-sbp1.dts
> >  create mode 100644 configs/ibm-sbp1_defconfig
>
> Is this device tree submitted upstream?
This devicetree is meant for uboot.
devicetree for linux kernel is wip.

Regards,
Naresh
>
> --
> Tom
