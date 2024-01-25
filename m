Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA3C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 20:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CDB87527;
	Thu, 25 Jan 2024 21:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BU1qoVYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8085A87447; Thu, 25 Jan 2024 21:35:27 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAA187527
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 21:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2906bcae4feso2848967a91.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706214923; x=1706819723; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dsuKO57qcKYbcrHGBoB5C1n/yB5Vi8/rqGbf1rA2Q/4=;
 b=BU1qoVYSxtBeGz99Y/P5CVvGKTueygmwUrypM5F5ryNbSCmhYExD0fP2KnpTIG6qOD
 +47ye+ia8KEDbnWXbn2BkZP2yeOJsOuSPbNza0FDJaEF3QfFe6cH874eAhnQbm3lHbpD
 gefssB0wEFMDqyem+GsDTeG9PVobPglOU9keehZxksUKfte1e9c7wCVSkcs4MAyNisKw
 lsPE9CClRB/ypgGWcDeul2/j8CXd4V5IqAVsGEoumOKFaIGzCz6O1pdvEi5JqXvb7Gv7
 +gnNnaTZb3Crs8WjR4qWqVIgu0IQeaE95CKBv1vYFH1JfEcktJV9CoYCL+Rj/m/WAJaI
 geXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706214923; x=1706819723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsuKO57qcKYbcrHGBoB5C1n/yB5Vi8/rqGbf1rA2Q/4=;
 b=Cze3iDxcZiwTg+q1A409DmhE5aqc6x21Fw4r/1XWeftuh4pfTDnXr4WYqDTFP6cC7/
 c9hMeXBB4qrUDoSMpuFsEXKEIMjv3wPEtIMP2C/xuwneBJetmkju+AvwaJGvpEnFvSA6
 /ex8uuTMKyUHdkNjTeoP5tEgXf47i2GcNFF6nxPdQSdpZXPNVwCQEj2w5g2Kv76f34sP
 PvKfx1JeSr/ccHYG3WWWg6sUJwNSYwe5/wdpmE1Mes7YyNJ/3auJAjDS8UbjSjvH5e7i
 iFBXnWjeBUEwSEBUwlw3hgVFVo7EuSJYyFErHppPumm+yzAuVufaCjRyRioX00FX4rWB
 W0hg==
X-Gm-Message-State: AOJu0YxT/bXj8PAW4/2sqdNIeOYLjBka6xwbMfySc3kzTbDAlNVBfso3
 CUvXpINB8h45ccglFA3vDEnX+ZlB3uXPkVdUEhK8l3BUfp4A9N/bXNWoQIn4esc97oQmQ2DpP8a
 122B1ybk4GoctsH+LIPaDNyRNmho=
X-Google-Smtp-Source: AGHT+IHfu5q8B4XtdUkp3jT3uvwRksGK1Bkj9Hv3xDbFtnXBIh+onHY5M2o0cW6w/9HhURnkQlBAVtLrLFYOWCI/Ybk=
X-Received: by 2002:a17:90a:ba92:b0:290:1f0e:ed44 with SMTP id
 t18-20020a17090aba9200b002901f0eed44mr173939pjr.12.1706214922971; Thu, 25 Jan
 2024 12:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20240124021516.280026-1-Mr.Bossman075@gmail.com>
 <CAOMZO5DLFfx35pcseW5Ojqbj6QcqXtMBDhDgYsj-Kya7c9EB=w@mail.gmail.com>
In-Reply-To: <CAOMZO5DLFfx35pcseW5Ojqbj6QcqXtMBDhDgYsj-Kya7c9EB=w@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 25 Jan 2024 14:35:11 -0600
Message-ID: <CAHCN7xL7umTbjXn56Y5nUtkDB_8VwtYGVnmZba58OpHXUEoGgA@mail.gmail.com>
Subject: Re: [PATCH v1] tools: mkimage: Add support for i.MXRT FlexSPI Header
To: Fabio Estevam <festevam@gmail.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
 Fabio Estevam <festevam@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jassi Brar <jaswinder.singh@linaro.org>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Alexander Dahl <ada@thorsis.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>, 
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>
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

On Thu, Jan 25, 2024 at 2:10=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Adam,
>
> On Tue, Jan 23, 2024 at 11:15=E2=80=AFPM Jesse Taube <mr.bossman075@gmail=
.com> wrote:
> >
> > Modify imx8m Flex SPI Configuration Block to work with imxrt.
> > Add more Flex SPI configuration options to Kconfig.
> >
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>
> Could you please test it on imx8mn_beacon_fspi_defconfig ?

Yes.  I was planning on doing it this weekend.  I'll try to get it
done sooner and report back the results.

adam
