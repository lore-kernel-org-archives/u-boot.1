Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9894FCF9C5B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 00:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACD7D889E9;
	Tue, 24 Sep 2024 02:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZtdENtnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 944F386E61; Tue, 24 Sep 2024 02:51:10 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E7B88A74
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 02:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2f78b28ddb6so43709391fa.0
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 17:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727139063; x=1727743863; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OhC84GMsfQSkJGffi6aGOXypQaSwlVmr3p1y7YhqXU=;
 b=ZtdENtnvgPkB6W/bZAwC345S3AU1A+2MG2sDZ8cS0+CgfRzBCO8MCxzlBV2UWtj8SI
 mfOR80/uGJT4r/dy2hc1gRWcwJS0av+pppOFcd5C5b7qdpPTWVn2AA+72Z0hJNDKU81m
 A2dChT3qdROVTsEFTWsRHCCRTAUojNnagUUWJXK1g4FM0IxdQaOw93gi61qGmuH3y+cz
 msGWQhuqsuTWuzpUmJwZv8hfwL5e/gggwyUlb1hKHsa9NLtsVWzTfvw5lGHKS1Ju7zhf
 J9GLRJnSZO0jJt6d2KsMBMhTTa0ebudu64Mctpi7N+BYpN3PG8EwFfIqAQcPP5AhkpKc
 6hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727139063; x=1727743863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OhC84GMsfQSkJGffi6aGOXypQaSwlVmr3p1y7YhqXU=;
 b=VRAl6esg1IvcvHWkBvLBAcQ1z7dQSGNo7V3W0kGHu6rrS7+FUpWK4dN0A4E9YXAKDt
 W/n4EAbl9RvSnFjTX1XrROWJb/lFyEds6yCc9wmTpKb8w0/HvWZPmnmT253YNrecLttN
 JWsbhCR8IoBH6Kzggi2XSrjUAu0TRlWYIACjQ5GHfwdL79B0EszD2m916IechQfDJ/IE
 6JZeftacILGXzTwH19dii9T9+7trgM1+meDtSvDUiHwD44JjLAN6K1x64aGg3SkML1CE
 TWIWrEtLlf1Gp0vZ7kB2CDREQJo0og3bZwx0tFy/XS7Xv/y2cWheC+SwUal81eHU2NDG
 r+UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkSzDAiWbFzVfYEHjx6KwLvzL4Ruq34RFuTYgBRxTqKGCMsf1e3s619vZ5jQFIk31Tcf3VBe8=@lists.denx.de
X-Gm-Message-State: AOJu0YwqkSG9dzFmfdbPj4eUaoOVcKdgXK1/jkaX/Fg36xW0SKoOOkvv
 TXjAhSk7P9nxejTfW5MoYtzl2yOkMR6jdocFiCOjwznWdYkZhQXS3AOa0JPBm36KdcuowNQyKYO
 u2YdA73gwkWXqWTpgCEDDOoCIGZw=
X-Google-Smtp-Source: AGHT+IEkHjnAhac8OOYupQ3161QsvtZ0KX8OOxZiMgLDdDcy50FfJc0iODiENdpEQEv2woxKFJA5EZZhahP1ZLvOypo=
X-Received: by 2002:a05:651c:19a2:b0:2f6:4714:57dd with SMTP id
 38308e7fff4ca-2f7cc5de75cmr58590711fa.45.1727139063177; Mon, 23 Sep 2024
 17:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240923131439.28572-1-peng.fan@oss.nxp.com>
 <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
In-Reply-To: <b77e571d-e782-4e7b-a9d2-1ca92df5c512@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Sep 2024 21:50:51 -0300
Message-ID: <CAOMZO5B7HLB8iLdo4YOzf7iVyTNaRA2Zv3U7B6HSvo4GPOST=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sbabic@denx.de,
 joe.hershberger@ni.com, 
 rfried.dev@gmail.com, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
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

Hi Peng,

On Mon, Sep 23, 2024 at 10:11=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.c=
om> wrote:

> Humm, but how did it work so far?
>
> On phyboard-segin-imx93, this change breaks fec ethernet.
>
> I had to revert this already in NXP downstream u-boot.

How does Linux handle this internal 1/2 divider?

Which board did you use to test this?

Since this causes a regression on phyboard-segin-imx93, we cannot apply it.

Please provide more details.
