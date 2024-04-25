Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4CFC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 16:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1AA8906F;
	Thu, 25 Apr 2024 18:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gqe7+RTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60DFF88F1A; Thu, 25 Apr 2024 16:13:23 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A29C8868B
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 16:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hughsient@gmail.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78d7802176dso16224785a.1
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714054400; x=1714659200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+oQtck/diSK1qjx29Nb0NcKkDmFbXQpeKwMz4JSrmdA=;
 b=gqe7+RTlShyiU0JXUXh41iQHlMucuvIE46Ihf8BTwNGAhIhszG+wgRN9YuD8jVV3QB
 9QcrjKfqkxA/oAivjeJi1Ad23fLg0eapLPEEjH7gZZh9mnrQjSum4+4nlJsaNZ0ZSwUB
 JqQluD3I35tJP+xV2oEliAhP2w2Y4MSRlNrAlnSVxevP3wZbDWi125yv2kfUM1vGx9RA
 FdbcjtGjRQl3xo0n6L7GrfR8svSbiWMWxfVvrCFOR51jq7KkqNeXxj7bQQTdkB93nGlJ
 GejuZ4t/yZ07W+PHIgknI6GwtiGT7cvUNU1y3qPg5WSDJrzPbrlrENS43MD6ZW70dMm7
 ajaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714054400; x=1714659200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+oQtck/diSK1qjx29Nb0NcKkDmFbXQpeKwMz4JSrmdA=;
 b=V1k81sYdkYazLr3eI3211gaoIf71WeZp121GMd3oZ/3mfrDlt52OzCZnJsn35ZQBbO
 rPGzFJfQ9LhA1o4oXaicP2VdqAvYzi8aSjsWmjrTbuWYnqgqD/bgeiQcraaEQnL1e4PZ
 OKWT+lHD1iyqQ/i+Cnh+89nNrqdul2FKLCn4R/vy1gszGhQzw7AVbDvEEDlSk7jHBA44
 qk5RgpZoAAjg4QpgtjaaWVzRIkFPZyfiBFt8uEG3ibUj7Ywwad50Acguh86ko3hUl0jj
 KqwTEtSf0SOH5rSTz/GdAx08KeIPB6NvHxWeToTqrslunERRwdtYAD48pkeZrhF/l3fs
 AmOQ==
X-Gm-Message-State: AOJu0YxXQEgQIoG35TnwyUW9bDmB6b5Mf9cY3ZK1kJRifyJeivoFcxXn
 m63ZyUsaPz/HTGrvzzU9vM/6VLeau7NbGjvgcC2U7KtMRNW8x10LWDUNWxl2dGVKO2Ez7MWr+n3
 vP216twrNJa/btmLYLnInlWshbCNJppQv
X-Google-Smtp-Source: AGHT+IFS8t904r8HE5VnHqzgtvD9F/u4WQdBkfmNmFZT2YHGyl+k2wEZ2LXsOdfqv8Y0fe6mtIZJHnVatny4gT1ICoU=
X-Received: by 2002:a05:6214:f0f:b0:69b:1c78:158a with SMTP id
 gw15-20020a0562140f0f00b0069b1c78158amr6097313qvb.3.1714054400011; Thu, 25
 Apr 2024 07:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com>
 <CAD2FfiGuFaC=r+TGfq9auzWJbyzVNbug8zR9RzSwM2+Uk52d+Q@mail.gmail.com>
 <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
In-Reply-To: <CAC_iWj+BonsVbA5Bw3Kck2k4b8SXru0U_Y2kAmx5=_t6SozotA@mail.gmail.com>
From: Richard Hughes <hughsient@gmail.com>
Date: Thu, 25 Apr 2024 15:13:07 +0100
Message-ID: <CAD2FfiH46mtwPB_wR9H2p6hKCT5eLu5UOyHNDvpdpgFEAdqBuw@mail.gmail.com>
Subject: Re: Capsule GUIDs and LVFS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>,
 chris.obbard@collabora.com, 
 Paul Liu <paul.liu@linaro.org>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Michael Walle <michael@walle.cc>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, 
 Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Apr 2024 18:23:08 +0200
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

On Thu, 25 Apr 2024 at 14:46, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
> TBH those are GUIDs that are used by virtual devices. It wouldn't hurt
> if someone reused those GUIDs but we can display a warning about it?

Right, I've added some of those to the spreadsheet "never" column.
They'll work for testing purposes but they can't be pushed to public
remotes.

> Ok thanks for the info. Is there also a check of "I have duplicate
> GUIDs that aren't in the DMI list'?

Yup, we check that components with duplicate GUIDs don't have
different AppStream IDs or different sets of HWID requirements.

Richard.
