Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8687C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E433F87045;
	Thu,  9 Nov 2023 02:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NDzJBo6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 943A1870F4; Thu,  9 Nov 2023 02:25:08 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FCF86FED
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6c48fad2f6dso64502b3a.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699493103; x=1700097903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npztabn1fHtl4fboQCoEPsOOM39u4PbTahWFee7vblY=;
 b=NDzJBo6m/7CarVQdU6hzejPPhSsfEP8Ju2hGwBjPZ5OJH3x5YDRYe8fvza3qh9GihT
 hVYMCd0s4u8mENACLFQLr9C0QjA8LkCMzG1IIf5XTEis3EjXDEJcAnnEuOvsylmdkpCw
 PytRhy/f+u1c0awgM/+qONRMdtGvC3ztqK8zrmtfNH5I5ETgY019Wpxj4LmpSL7jAkqA
 qWv6DYshIZb/R3qwvUmyOsv4yAcj3m5QqEiHcfd0J/JRsfsIMz42M6TOzEwBfJ30b0RO
 dOeDgTJ1qG9fOVkTpxPh0fujiBqsUgvtsa1dXHAwZUFjU+B0Yq/6DPHa/+8FlGB+RLeh
 eQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699493103; x=1700097903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npztabn1fHtl4fboQCoEPsOOM39u4PbTahWFee7vblY=;
 b=Vutzy6m2tiYDQRm2XC0V8rf/qcpi3AGJvrA/pocnqOTltl/Ke3KFTmpnML2N9RZDVx
 DO1HE7DDrIE7r4Kuv5AO1bUAVpWJ+mz3cxrLybdCA6QQefMqHOIEqXu+kesxw5EdUBkn
 ZZ5eLLmsDDqtHzVYw9UxwZjR8hWtxNWwIZ653r1sNDe4DY4boznHOg5YrAHmRYdOHIKm
 0fEoSxibOw7g+XKaVNTcMNZY8g+XwlzCGn8pXGGsLWt4fJ5EWMZkiogXqmyl/n72abTO
 BnOXG1or36pKuCi1MLqUYwblbaBsmaX3eajvgiKtR9Im+cRLbSwDFUejkiIqrQQykF9y
 kXeg==
X-Gm-Message-State: AOJu0YzjnA6ecP1HjrXFK45LXKI3nXX4S2XfJpu7trtVLvl7RDKYjakH
 PIFLt24BI18UcxSrpeQsw4zU3kFSEV0oA0+Y9xQ=
X-Google-Smtp-Source: AGHT+IEBwEn4i+UE4VI1adfezGaDJeoDw3xVpHvACb567orHVoJ0umdUjrX52cxhho0QRgyD2ZBfUAPTElGAvzdVfV4=
X-Received: by 2002:a05:6a20:549a:b0:14e:2c56:7b02 with SMTP id
 i26-20020a056a20549a00b0014e2c567b02mr3908022pzk.0.1699493103528; Wed, 08 Nov
 2023 17:25:03 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
In-Reply-To: <20231109001746.GX6601@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Nov 2023 22:24:50 -0300
Message-ID: <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Tom Rini <trini@konsulko.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, Duncan Hare <DuncanCHare@yahoo.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi Tom,

On Wed, Nov 8, 2023 at 9:17=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> Interesting.  What if you take wget out of the equation and use "tftp"
> to grab a large file with a known checksum, repeatedly (note that "rhash
> -C" will give a crc32 in Linux so you can confirm the correct value and
> loop a get, crc32, compare, repeat loop with a little work) ? I ask
> because I was reminded today that for me at least, the RPi ethernet
> isn't reliable in U-Boot for me if you stress it too hard. So I'd like
> to try see if this is "wget bug" or "network driver/related bug".

I was not able to see a failure when using "tftp" to transfer the same
420MB file.

The number of bytes transferred and md5sum always match, so this is a wget =
bug.
