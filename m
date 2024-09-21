Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B38CF9C69
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 02:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F27880D8;
	Sat, 21 Sep 2024 04:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5qOdrn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8B788279; Sat, 21 Sep 2024 04:52:03 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0FD880A7
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 04:52:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53568ffc525so3339094e87.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726887120; x=1727491920; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0Q5FobwQ0kjq1zUdJ+ACY1Dpccmcl9ddlYqknBdN7s=;
 b=P5qOdrn1lDzSiToJCZHfJ3sODBALCTcpOSM3fISuK9U/t/xY7mlDNFHDc+GsqHlTlm
 geh6GvYazgxtyyo5IGnU74ZLzikkEm/CNlutigR4DdNogeMGmiTr3WlJID/tiGQFq+8V
 fbYWw5TzntUcxFjJDqa/AOX4oatXhQP/vhUf2uvExcaW+bAPczZoD5PdIOLwgbEKGzhK
 RJy9u9UYkIv2aDfqm5VThFhM66VkhgYz5F4S9nt3WQpa1uknRoLFJMcXzFf1jo+/5MLE
 m+zCqoLjK1VXl8KgBSFekapzp50ULcZ9DtT5qktdPGfukL9qno86Wk4QKURjBEcr20FE
 NLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726887120; x=1727491920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0Q5FobwQ0kjq1zUdJ+ACY1Dpccmcl9ddlYqknBdN7s=;
 b=DHbTozOc65NCBJLMnhLPPDkmUcs2Cww9Mrt2+/8fAG/p2NiVAb6DFhmYU9y3OmhLb/
 /YstmAxllyM9644/xC0JseG9Dq6uaJALCIGmoJDptxIc5fpd2p6JE9oiOauoLPatBMxu
 cuhvpAi6Rl+/gnnggOjBFcSwRaZ6iF0r6+LeeqZGsL9gojyyfmy2jbLmKjsaGFaIAFne
 PPy1VxBOqSLbCVWnnnpDh9iDOAPNubQbZNN8rttHCgopgU4PWcl8OMHgdP+hKki8a1iz
 HUIUf2VHXCn5qV2nE0ptGfrlQ9n34YSaRbRWwpKBQURVGha3KqHj8H9D6cJp6+WQjiM1
 rECA==
X-Gm-Message-State: AOJu0YyD2KbboC3/BsTl0uNcXLNFVH/89/MMSNHhGe9yb2R5LqFDP29D
 zl91wFeH36Vu+7D/nQAa2fxtwn88Zd//+IT45onZdLbpqtGpu/DQWJd3rvqf7z1gjkHE4mv4WDf
 w1HuQi0GG2sc/bJbJoWn763jfGxNhs+Ho
X-Google-Smtp-Source: AGHT+IG5STlyjtXARCc4tJLgtLHTSy0hoPuPiok2KDZuAvcw97+GojPkwkfhUji73/humRwe+4Fpox605ARcbsbXod8=
X-Received: by 2002:a05:6512:1192:b0:535:6cf6:92f7 with SMTP id
 2adb3069b0e04-536ac338d1fmr2833132e87.59.1726887119718; Fri, 20 Sep 2024
 19:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR0402MB3764F30FA2A2A99A9E44D6DFEC6D2@AM0PR0402MB3764.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR0402MB3764F30FA2A2A99A9E44D6DFEC6D2@AM0PR0402MB3764.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 20 Sep 2024 23:51:48 -0300
Message-ID: <CAOMZO5C2FP1t6t63-ocor6xvG89BgDRH8VE3NtKvz=Ux3iE4SQ@mail.gmail.com>
Subject: Re: Serial console via USB on U-boot error
To: Chema Casillas Mora <carlos.mora@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Luis Valdez <luis.valdez@nxp.com>
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

Hi Carlos,

On Fri, Sep 20, 2024 at 11:39=E2=80=AFPM Chema Casillas Mora
<carlos.mora@nxp.com> wrote:

> Is there are additional specific requirements to request integrating this
> patch into U-Boot code?

Please follow the guidelines below and submit a formal patch:

https://docs.u-boot.org/en/latest/develop/sending_patches.html
