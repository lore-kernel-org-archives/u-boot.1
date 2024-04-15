Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4688AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CA087E75;
	Mon, 15 Apr 2024 16:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Da4tq0yT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58AA0880FC; Mon, 15 Apr 2024 16:06:58 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E00387C82
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2a786f8008aso205766a91.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713190012; x=1713794812; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3L+sHsXzI58C12gbzCROx/xauDnwLWVt9PW+P7+biHI=;
 b=Da4tq0yTgs1FTZ99t7Q9UwjNnQFY+GeTmybgDlcH91sQX89yAA/1KRb1QVJfJS+B5G
 NR5VdawdzwTRcgUQMKBriSmCbVM/5aMndKpwtgLjC0yimpcrBzpdLxfVUE8ByYHBfCfG
 1ICcqSXpaJD2lqzDWNFmMBTODN8wnUsolNTv/WFjqfeuBrx11QjHe38Ey1lUVVriE1GR
 NC/+a2fhk7Tz5An6jkLUBqd85KeNjk33vKuKwpThvT5/9lEah6/JoZPRAyzCgdZjZeWs
 Rh40DLlF1dXoTh2PAeAcGOQ0gxdDHjJdvGnTM3tSRAW728cgbi3xP5tivd7f+wt0t76Y
 fzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713190012; x=1713794812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3L+sHsXzI58C12gbzCROx/xauDnwLWVt9PW+P7+biHI=;
 b=U/tq2Ai6wDdjtkWAc/cHc2Vrb8tD5k2wANXBIXpKtUQ8xJb9cOJkqEnVK7rBz3WHn6
 Pkw+HzqizpvM0t0RYL6xWll1+Em++nQjODNPDlM+RvUzTRW+oo4xHwdmGi4msiBIcuMs
 JEYL4Oew+EvlqBLe6MfoTqR/dpMoKPnYX6Opc8bsf+jVeJGe1eBENf0426eIXjLUdVI1
 MujViug5JL4mAhBXnXXpUjMBnXMCfOQiAitCoAQzrgEbNx1BctZhxnAgyfqQoZjw3oIE
 9klivpFVwoQuQtdcPIYNUELaLL8CI6Z8TziOASN7G/3T2IQiXCjCJ80ME+dS8805VPpc
 6TAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL407bx7SUt8CzCgOP0DkxF/RISCS/Kom3UPDqHNCNIcO6E+6tcV6Gcwz56FyKlFaD43PwCttn/mhdlS7I1hh8rVo8tg==
X-Gm-Message-State: AOJu0Yyz88X95shRivWsmT82bg01b4X7txdsDoqVY6beHi0KscQT4R1U
 ZT2XyQLKAlGL/gwTT1oVFehpOejA/5L683bfhoXEHVul8Ia4mxOhQOiHIFT5pSQe4Xg7m3bOYOp
 z32rnMB1we4yNIKHDfVscnBQFvNg=
X-Google-Smtp-Source: AGHT+IFo+6qBtBIa/f33BOEW/8+22JMxh5BqN4I/I+QFeS1Iiom818yZfd/4g+99lBjHfYjPjrLOZg4DcvFlntuuny4=
X-Received: by 2002:a17:90b:243:b0:2a6:d2eb:860f with SMTP id
 fz3-20020a17090b024300b002a6d2eb860fmr8651473pjb.2.1713190011934; Mon, 15 Apr
 2024 07:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <20240415130013.26721-1-yasuharu.shibata@gmail.com>
 <20240415130013.26721-2-yasuharu.shibata@gmail.com>
In-Reply-To: <20240415130013.26721-2-yasuharu.shibata@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Apr 2024 11:06:40 -0300
Message-ID: <CAOMZO5CJCtpjM3pAk7SaOu1LySUK-6mvWRWzw0Ni=nmxrQMeCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: wget: fix TCP sequence number wrap around issue
To: Yasuharu Shibata <yasuharu.shibata@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
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

Hi Yasuharu,

On Mon, Apr 15, 2024 at 10:01=E2=80=AFAM Yasuharu Shibata
<yasuharu.shibata@gmail.com> wrote:
>
> If tcp_seq_num is wrap around, tcp_seq_num >=3D initial_data_seq_num
> isn't satisfied and store_block() isn't called.
> The condition has a wrap around issue, so it is fixed in this patch.
>
> Signed-off-by: Yasuharu Shibata <yasuharu.shibata@gmail.com>

Great work!

I applied your previous patch:
https://lore.kernel.org/u-boot/20240414104607.5966-1-yasuharu.shibata@gmail=
.com/

and this one against top-of-tree U-Boot and I no longer observe the
wget corruption.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Tested-by: Fabio Estevam <festevam@denx.de>

Thanks a lot for fixing this long-standing wget bug.

Cheers,

Fabio Estevam
