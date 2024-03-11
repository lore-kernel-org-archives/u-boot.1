Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74502C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9297687CF2;
	Mon, 11 Mar 2024 15:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsY4TcnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301CC879A0; Mon, 11 Mar 2024 15:06:14 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 960B187E1E
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:06:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5cdbc42f5efso1139328a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 07:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710165969; x=1710770769; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGfOVQtt1HHdZlgGms0wrzI+JCvjw8ejsn89yoOytf4=;
 b=KsY4TcnKwz79A2RGmVel16LaR6SyFIy+tt+kB/cFcF2eCotmn9keJ66uurf7Rl3gMo
 V9kepRbOEiHPiyA/7ysa4J7HXu1uFvjJzO2+jZEQx5zSmrd30tIFElgOvSCh/WkwBXL8
 bD0jfJ74sOL1WFVBUSpDLQC4fD0jfv5SdwEcKgQnSIWgRWUAWvOhWVLELJF8SPkot2ce
 YXnVA/RLWuN39iw1apvi5Ml91qo7wN/UWFFubmox732AkO1axKtu7PqxWwxFac7BX2oh
 zAplnCf+hC02n7jtKvDPGd8w9SJJ0NoIDz5f2C3+tWtdKsUqAeSSajSzUbmWowejh88a
 2Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710165969; x=1710770769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGfOVQtt1HHdZlgGms0wrzI+JCvjw8ejsn89yoOytf4=;
 b=uknDi0M6zP3RF36vjN7ghgeJEArqEcqinGVLAWqX/QsU19al5QvZIdAFpL+C6nlkmX
 oriRA3BqYJ5OLc/v70QABK4boOd1HeY2d0JAr8wapT08rv+z+NFz3SD2UFzUuyX6GEjZ
 1E+iFlwm0Ds3Ta6/Loa9hOcPyoVTZsvuiiw9QXutfdqK74/zl5C/UGOpgtb0Irvt8SZx
 I5SKsj5BXDJBgJzj7vdZuL4IS2EwZFVgfecWX/uuTKoCbT3kexAuiCnIl017ORLKCJNV
 N2ZPSpPMF6YSl2/Ck+MN9p1Z27YtkmCexHhIkjvNaXi3/8DlpHrSjVnVjSyJJIVTt2UQ
 OMsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtvdHR9l6NFgYFFA8sT1u+QaMPnZhCbn4ZoBLYSKzUdkHnGZrIwkEc+0JybcHIACyUaqRNjua1TinkfbdCPdc7dmgi6g==
X-Gm-Message-State: AOJu0YynB70bkw02i/aoaDJSZSUXICWZizhoVNm/Etojm/1mypeRR1V4
 qn8dHXNpyWDrwnB/CG65xO+euAR/KrEBLtcJketDKAogpuljNLmDtllTLZPDo1cGK/xQXeEa5dC
 x9Scark4m5HOhsW2hVKAl6G+nnf8=
X-Google-Smtp-Source: AGHT+IGuyKo7WPExxNQMfslk2J2w6TA918VOACSfORtfICmSEXqEY00sDZfsztuyxScpjyuv6Nf77m+scfJHewaViyw=
X-Received: by 2002:a17:90b:3ec3:b0:29b:780c:c671 with SMTP id
 rm3-20020a17090b3ec300b0029b780cc671mr5198499pjb.0.1710165968831; Mon, 11 Mar
 2024 07:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
 <20240311130400.4023780-4-l.anderweit@phytec.de>
In-Reply-To: <20240311130400.4023780-4-l.anderweit@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 11:05:56 -0300
Message-ID: <CAOMZO5Cm08dpaEdRSZkj8khP3T1HySP1fqKM12cOF4XSr7kJfQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
To: Leonard Anderweit <l.anderweit@phytec.de>
Cc: trini@konsulko.com, t.remmet@phytec.de, u-boot@lists.denx.de, 
 upstream@lists.phytec.de
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

Hi Leonard,

On Mon, Mar 11, 2024 at 10:04=E2=80=AFAM Leonard Anderweit
<l.anderweit@phytec.de> wrote:
>
> Add support for the redundant environment.
>
> Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>

Please rebase this series against U-Boot next branch and resend.

There is an error while applying this patch against next.

Thanks
