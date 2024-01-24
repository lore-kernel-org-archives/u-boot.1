Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0343BC47258
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 00:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F6E8777D;
	Wed, 24 Jan 2024 01:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I8vvW3Rh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4488786C; Wed, 24 Jan 2024 01:44:34 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC18876F3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 01:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso432636a12.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 16:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706057069; x=1706661869; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H760wwDalZzbVklcuYLvb/W8chCeEkLjXDG1mbJ+n6A=;
 b=I8vvW3Rh/dPNnFeCArMtcvJPVpOhIVZnlS51hXDLef7uVBu0VsLm9WskVb+zZyT/vV
 eU4X7eJ3Dg1vFYyEojtuTdMMInB7sSfZfRA/T3sFTT/BQUePzUjo5HvHT351snsQ3FGC
 8sH3JOMhzifnB6Wvw5tpg02oSUj/rVzjvYE5UKxVIIz22CMWKWVgk7EqOPwMvVMe9/64
 IJDOn6HQqJCA0UHsZaBJtMQ+c8wf141Z8FU//O4dQSzqj6x0r4m+h93uAGFoFvQF63yl
 roMn/PdRlA/9FtkJt/QhQiEt6uMzh4+rtPAVDoPTcdBgM+reZKwC4STx+05VC7NwBQz3
 inSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706057069; x=1706661869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H760wwDalZzbVklcuYLvb/W8chCeEkLjXDG1mbJ+n6A=;
 b=DsAr0fkydsFwAu8ga/cmTwIHKSzhdb9X360a7Ux8VEwzdiNPrm36jmFTrVUcxSS68t
 0l2OO/TKfJzManoBmePhE2hzOXt3YQ5hWI9n+obBurLTYkvccTNKra10w84Eu+ibfSCq
 b5yZMfLegSfR95NHk8lwFKS8Sv6/p1cRaR5SogfVgzqmxUEsBqxuLq6UJuu5n3IENkyk
 xZohFne2OG1PzBGPufbE8m2gkma23z09+PtwTIopxcCQin6bls4nAE1D8drOsUINVVvx
 qi/BBT569IhfS2ZF82oIl98BRa2WTKOwQiWzRCzfND7m0kFh4DJObOWUPul1GVx69Owc
 aIHg==
X-Gm-Message-State: AOJu0YxeZ4KG/xCsEe9NpTPWhuPr3rB4AC+IJNqFDxX0owJGMnDhRsHA
 UtOSDj9OTWXWJsvYo1ujkYNqh8Fi7obK2vlzW//DblX/XQ1cS7DkAvwLeRSJi/K4lGJQLQD5yMU
 IowKy5c/Pu508ReT8mT7J1w4JnbBAMXPt
X-Google-Smtp-Source: AGHT+IEVsLjtdEJfVBfY9LZskCzHxjJ5Mz/vulBgif2wiHwogU2I0gYDlZkZGJyN2KcK8dXekBQC8d+DlLv+fj6Bh7g=
X-Received: by 2002:a05:6a20:d90d:b0:19a:40f3:e460 with SMTP id
 jd13-20020a056a20d90d00b0019a40f3e460mr782586pzb.2.1706057069579; Tue, 23 Jan
 2024 16:44:29 -0800 (PST)
MIME-Version: 1.0
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
 <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
 <0934648988c9444aaf85f2e3163c0f4b@supermicro.com>
 <CAOMZO5Cy8as7b_cup6J+PYbN-stkj4Vz2wsLB_1=NN3vx5SVWQ@mail.gmail.com>
 <728CCDD9-CEA4-4ED1-9143-189C3F257097@supermicro.com>
 <9c2e7790f0c94b0ebf0e840100eae2c0@supermicro.com>
 <be10a49d2381407fb955958fbc87ecd4@supermicro.com>
 <CAOMZO5D5g6izBC=aCumX_H1tbo5uXTfuhQekSuH_XDqUAN91Kg@mail.gmail.com>
 <8ACC66AF-9761-44E2-A36E-62C8EAADA09C@supermicro.com>
 <509c10723aed4965aceabbd28d36b847@supermicro.com>
 <CAOMZO5DUrxpRAt6Fn7xofHGH7B3ngrkdPm9c0YUd4r-19CB+ng@mail.gmail.com>
 <169de53f8b31460db561e775657492a3@supermicro.com>
In-Reply-To: <169de53f8b31460db561e775657492a3@supermicro.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Jan 2024 21:44:17 -0300
Message-ID: <CAOMZO5AmtqSE9OiYnAvSBP6D5HH8aG2K8HZ=c-LBTR=uvpN=Wg@mail.gmail.com>
Subject: Re: Could you please help me in resolving the "
 /reset.c:42:(.text.do_reset+0x20):
 undefined reference to `reset_cpu'?"
To: Liu Wang <liuw@supermicro.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, Jan 23, 2024 at 4:20=E2=80=AFPM Liu Wang <liuw@supermicro.com> wrot=
e:
>
> Hi Fabio,
>
> Thank you for your help.
>
> Attached is the 'git status' and 'git log' in my porting u-boot to my cse=
_ptjob_cb3_r102 control board by following README in u-boot and being block=
ed with the hurdle of  "undefined reference to `reset_cpu'" in hope you spo=
t something familiar and shed a light in my building effort.

I don't have any insight into the problem, unfortunately.

Also, v2020.10 is too old.

You should use mainline U-Boot and upstream your board (or hire
someone to do it for you).
