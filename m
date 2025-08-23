Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CDCCA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 11:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF6C8304A;
	Sat, 23 Aug 2025 13:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tv/CIP3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99AD8307F; Sat, 23 Aug 2025 13:41:19 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47B682E37
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 13:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55ce52b01caso3058489e87.3
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 04:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755949277; x=1756554077; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fg6Q5Cfo1nr/coh8EEICayWTZY0fEquYqeK0/gn0uhU=;
 b=Tv/CIP3DmXWD1hQjXJTmhyjrfZhmbyvsxrG/cFTWX2jr2qA96Y3PLszxTP48Le8tJj
 0MzAKhEg9GyjErYAfukXHcfOiPWW+kjG9qzQkc8zcHfynEd/78uzCAzdcO/6kz4aNHzL
 EEmaFgL+aa9gtNq0PAlaPsr4uvjYSUq/vFwmXrBTtBE1dK8ejb3CxiDCCldWAk586oYu
 YTwqC5fAV7x7z9gWBLkiGjQO8wxq15fvSUAwhmenwSDOFbbtUxWQbGYmRzs/viwISQqx
 2hbMtBJvtJf5jicWETv0yDq8vz3bwHlpWSKi2vdO55vCaMrown1BiPA47Iri10r6R3kU
 FPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755949277; x=1756554077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fg6Q5Cfo1nr/coh8EEICayWTZY0fEquYqeK0/gn0uhU=;
 b=a8IcmgjrPOKU5+gIbwMyqLTl0bKgz0KlTYlPEGF3dKOyQhoD3cKhKrlEEK10abAagu
 1Ar2oA11lnnPnfyidqCwZYl60blk0oI548GErDZVXkb7WDLXF+Rt3vwlc7lviomIZtyc
 D1AZg+QxZF5jtxXbcnf3s0ZD1uNs9b+2Pbgn9F27U38jf8kWT4uHoAm/sqNjHqjKYzpB
 5I9IwAhDwtBOs8yGx1wt/rkcTmWvzGTJKEy5aCLnqyNHzzl86Rn10iRCz0LVh2KVc55t
 cExnYefJV6ajzNtKXX2+79koDwiVkWxJZlNLZfixkzuS0n87IVsnFVEiWolI0kDP+M4m
 fOJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjggkiyCax9rYtmP7f9v52EtiCawA4S8wHp2hU1Xqwyr0tsQV2lJ+gKrUCt6m7vLxiokoRovU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4b7MgGQrmvKL0paLfzX/vaet1J352e5WJj4/JmcHOcKgkn5Ji
 OSChlNXYEkgfPd7ww9KSeTrfbiaCaqYFPMShXAUKDmXGsReigWlZuUgKxGndZALlDy8AOTeMGq0
 xHSkc5yFsZIGqy4piN+UeQEClBe9Cu2U=
X-Gm-Gg: ASbGncthc9RcpluspePRPfiMojhK0zi2DZXOkXIfGh3ghlnluhcxdWxlZCTQw+oYHvI
 A6vKvlIk+fCvgKu6YFhhaV1ENzq0UsP53TGnxPzA019NmtoEYV7gSAK32BtZK7AZHulYVrtHakA
 LQCyDZTs84lKE5ur6yhl5fddQji0azRfS1Uw/ffMF8ON8CZ9XdPhc5YdOQ3WSu8dZYxSifHaeJa
 qcFouEWSzNBYj9QyEZRlPdOt9yk19iP7ANw7jg=
X-Google-Smtp-Source: AGHT+IG4akTOme+BnQ6JnMw3mfrkqqzctJ0toZWp7AkoC7nrjBMdEn8NWhXkpXPvVsGDO0VUJAzYj0ZdGlnw2X5HXiA=
X-Received: by 2002:a05:6512:6207:b0:55c:c9d5:d347 with SMTP id
 2adb3069b0e04-55f0d370bd2mr2132586e87.35.1755949276558; Sat, 23 Aug 2025
 04:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
 <20250811-imx95-v1-1-569d8014172f@oss.nxp.com>
In-Reply-To: <20250811-imx95-v1-1-569d8014172f@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Aug 2025 08:41:05 -0300
X-Gm-Features: Ac12FXwMnkY0jiP7oiH1_cbgOJiMQRlFAHSUBsof9I_8LVsQhhHKam9PQPliLlo
Message-ID: <CAOMZO5A1toQLpNHZKZBeVT55yxB+j7snKVJ8muWKXW_fQQqE-A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>,
 u-boot@lists.denx.de
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

Hi Alice,

On Wed, Aug 20, 2025 at 8:05=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> To support passing specific commands defined in enum imx8image_cmd to
> the imx8image_copy_image() function, this patch introduces a new entry
> type nxp-imx9image. This entry generates a plain text data file
> containing the relevant commands, enabling flexible configuration during
> image creation.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

This series fails the binman tests through CI:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1228744

Please fix it and make sure v4 passes successfully in CI.
