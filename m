Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8BDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D826687808;
	Wed, 13 Dec 2023 17:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LMKij3Vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888F087808; Wed, 13 Dec 2023 17:24:42 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63FDA874BB
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5c6910e93e3so991855a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484679; x=1703089479; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcg0M/CzLS/D90gTkzwpbSgUGrlUzJseoxqa/nyToQo=;
 b=LMKij3VphAW17YHE5RuW2Nqdr3wl7uccDguRW6sWIXBawSgYYXIQBA2mBb+4BKg/eO
 x++UJc9q75a7ZhTauHlV4a3BRkeN1SDFCGJgstHciGekv74rOEiwpI0WK3nKAYD0aFeT
 TRjYkZX4ZvdZqkrmo6AgcYgJ33DJScGV6jLwKI8fw+8cF3JH+obeFwXr5btqZMWeYjfE
 RmybWXOafVtNBRU7mdPQbayN0/TVRdlQFbhwlWaVHDBBgUpUFW8bUIvr16TcHhEdQEht
 IufTVEdORalbarnZPL61moa+0+wjCzAgMjVk/+OsMzRYdj9l/PfI1BSzhCoI6w7mmvNp
 rQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484679; x=1703089479;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcg0M/CzLS/D90gTkzwpbSgUGrlUzJseoxqa/nyToQo=;
 b=NozehWSRul8b8N7aecXfYkAkRVg4bTlOVbeWQEGBaIaLlsZTqhXMOUeXjhrPB5lxG6
 TRnWrfWiXy+vY8P5tPSBFQjPGpfd10BYrdrEg3jh0racv4LQC9R7lH20wBprXnBdeiMD
 1vi3CQJbq+Gnv9FgLiLqZvGkdNbpJ2hGwxKClxedIvwhvkfGezeqEXewsEkH3F5LHBt0
 /4x8jHOHwCimc+22zi9b2ggmqivdCsQI7N3jzkcv5N98hEG3xbr0Fe4TWFbcgyR9IR4z
 FZyidHxqR81JdwN78JqbIoc7/D4UpAVX7/dH6OHT3sC+f/Mcs+dgt//mw9j3sOvGBY6I
 iPng==
X-Gm-Message-State: AOJu0Yyc3Ya0sZH83zwBkNDVuFgwKPR8MpHi8lZgxnMPGeqiybQOQO9l
 0pOAoEqwXiSP3JYulIVurWRs5sMLzwxPIyVmtH9rJjMdFX0=
X-Google-Smtp-Source: AGHT+IGMNitJ6gSh5SLbKcMSuMzbKYLEixv8XS1w2WPqwOQIAYXooUCPo3W/Xb+cfv1UVW9huzqtOlB0nGT3AD5UK4w=
X-Received: by 2002:a17:90a:d916:b0:28a:d272:f162 with SMTP id
 c22-20020a17090ad91600b0028ad272f162mr3957315pjv.2.1702484678633; Wed, 13 Dec
 2023 08:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
In-Reply-To: <20231017094501.7713-1-sebastien.szymanski@armadeus.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:24:25 -0300
Message-ID: <CAOMZO5AGcJ+xiE-VUoVL8r9K=varPzwsykD5iqH89ePpAoq75Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: dwc_eth_qos: add i.MX93 support
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Tue, Oct 17, 2023 at 6:45=E2=80=AFAM S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
>
> Add support for DWC EQoS MAC on i.MX93.
>
> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.com=
>

Applied all to u-boot-imx next, thanks.
