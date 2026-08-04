Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C72C5518F
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:10:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 851ED60750;
	Tue,  4 Aug 2026 14:10:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ukJaudxzFXq; Tue,  4 Aug 2026 14:10:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14FE060633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785852623;
	bh=ZsiH0QJBSLmFHPGdBo4MryAHHtFMk7vw7tsnUEsKxpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f2yvo04hnRGCHcfOJfS43LuI06O5dtU0k6NUKUHKnPg9KrhFO7kwr6IKVfsDfZKwL
	 Zicnmi4HlEXKtRcs8iuN5v+teXDFqaRWSsTW0YVZL9nW9TxzGe6h9h0FRTqkutwzaz
	 3unsHmiozLHpdlunjTN8hNNrywOOfGE11nMdyglpAVTieXGIbvYouGvBNzZWduUOOE
	 ETLvNN4ql59IZgh/AV4caLJUqPlHoUzXhmX1MvLDCGY5DhdQeoLSQWuzujMQPAlIVZ
	 MStrUNnBOpgm91Esoxpc2XMEbJHXoRltx39z2L3668okbiI5tlLMvwEOnYDZ5jrmIb
	 FnLqeVYhUT8AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14FE060633;
	Tue,  4 Aug 2026 14:10:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B29826C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:10:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E554F400DA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:10:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cney-u4tqn7y for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:10:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F57040071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F57040071
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F57040071
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:10:20 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5b2a3166398so4044352e87.3
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 07:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785852619; cv=none;
 d=google.com; s=arc-20260327;
 b=VClUriY3HobiPL7U2a7mFIrMy7xCC9KUhpiS6wuVlpkgobtqLMdQXLoeYM3qK71GhJ
 ofgSDkkpuNjHLWQF4Z9YEtp2RNyr2IBTp5utETVOohkTMxO1TSf51hpoBL4UvVpiavGY
 an8ok6cx9EGaUqSH+FbxdP9b5tvDH3vuoCP3HHzym3KnzpNAy6wtun5SCuGLW2iN3aCH
 MVj9kIVNS9a/aMLyyFWGCVeHa74E/ZB+ilW1L82ZhCG1vmvhwQvNCVnPNo+xKw+swmCk
 KJrfkxgnpGEaop4t+xsSsiMoh5yyXKEIiwdaCyWUNMC+sVdSHHQDFpM8RoyPgwicTvga
 K0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZsiH0QJBSLmFHPGdBo4MryAHHtFMk7vw7tsnUEsKxpY=;
 fh=iUP0i0gGs+hwrYfLz8BBAqBHm36mnb+N7C08gHCPYDg=;
 b=cTpHM3S96tWaNd7nkwY5oLbNlCVx2JrtslROXutWTiR6slRSyl+ytDDF6K6I/EQZrV
 D+uO8fLZzulrDeT0Ko5ppa+jIOkSvPJAanc3WX6NSQ4FGxLzp35T7CI+dad6yFkbHv7q
 QbQBS20a5vQnly3wOJwRrEMgKYqwtDmebGhI4P9M+6sDsHX5CAkOXtr/HywZSehni5tb
 Tqql3mR/u4vrvd09mi7ZTCWsS+sJ7F4My4vVYrpVogbNjfLt4rdP+zdDgMmJH0KXBTu1
 2Br+0lrlpqb16sM0fYGuJ9kUKytiBUJf7+8ocdYii/Q/MQp7TWV48ksp8fNaQun3tmFp
 Jfvw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785852619; x=1786457419;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZsiH0QJBSLmFHPGdBo4MryAHHtFMk7vw7tsnUEsKxpY=;
 b=jJK4vP2Fi8aZy/ZzJ7WrzaKBxxPq68meHWQSyD7dtoGN33kulQNtpvf9aE/5GN+zIb
 z5B08o4Cu13p73nmJNuZ2dSO+ajf3C57mtz+kwcchY4peUnd6+0vR4PlaAm86uuQ1jwR
 jIcy0WaR1pcGvfbxAcasSVwkqBr1vXhBoCOXp7R/dJsex3Bj8s62+s4azQ3MuzDvTgS6
 wptEd+ssn7g7BBWsCr6VIwZ8V9DFqQ91CFqPlMii6CkNLAR42kYi3zffldUjQN52UzA/
 Fy8TQJaT9OZw5XEVornXbOUYUu+SIcI0Qlzt8mMznmGSvsq95LocI1YNYn4I3whlhCPh
 r16w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjHcZTXvBmcgU+l068DdmAy4OAvwIm2Px6tubkRRxlUc5gcVWv91rjZO3Bw8ep/Y2JWQKoCSo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyVyRxPUapBXZ9s2zN39sIxSfiPb3xIz8mea+6PZgGNgPU7vpQn
 unvZEfFlEOBtehQuye/5Vncdh9lTMsRzrTELi0DT8Nqt9hB7MexispSSHV2pH17SCOeeFbtB5w8
 RrN277SWADswzw9A8qVTzJV4cuOmaF6k=
X-Gm-Gg: AR+sD13/AzoynKh70rzFk5zrTpSJ9bBCXpu3at+VJ3c/f6atKS2v1xj2+8r79lrKzGN
 spMTCjztR9BmQ1N8EH2o+xBwyuchBIdMUmeAp5CLQVfeERfIcArrvXAzCMMkeHtR3fB68bO2G0w
 YwuD7AnZa3vJ4zHqElxPN7eU9KxgbUFn4hzf1LIENLbbSGMAFVbsPJXtFqLnw/7yR6iRtKXAwj0
 wOWFOKRvOJa9dtNoUfLc7vetPTcwQmIHevkUDNuyjHRwc+pOY4z474E4gpcfEn7Re/302am0mqe
 BiwSxxCoMnbvQMhAsj6FxMHkJ38flbWEarVqoOYwOCxttS98KSiEFGPq36rH5NGn6RJ1F91Y7hr
 6DhWTJPA4aStjsSr5QBINmRbTS/HQzrUNahuXMCrowho7
X-Received: by 2002:ac2:5b03:0:b0:5b0:11b4:fd7f with SMTP id
 2adb3069b0e04-5b2e4f1a729mr1985891e87.10.1785852618314; Tue, 04 Aug 2026
 07:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
 <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
 <12a7410e-870f-48a0-8afa-a50e5c226f2c@nxp.com>
 <CAOMZO5CqTuXdG+uXZfiS5WjDD9QoNmreYd=JT2Rb48n19qRKkA@mail.gmail.com>
 <b362330e-c919-46c0-a1ca-b000f9c89be4@nxp.com>
 <CAOMZO5AhOZcsAc6DThNDcXudk5fWrm1gxgzwvETWX3hQ+Pj6=w@mail.gmail.com>
 <4024d372-29c2-4c6d-8185-9b97fe27f91d@nxp.com>
In-Reply-To: <4024d372-29c2-4c6d-8185-9b97fe27f91d@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Aug 2026 11:10:07 -0300
X-Gm-Features: AUfX_mxm7symeC-shJq-p0kqbToopbKVx9RU_wyKgNsH5U2aBg91ZVMexvM_W1Y
Message-ID: <CAOMZO5AuKP+DQfSCWNRxuzPJJpK2vz9DJFHxf5J2FQi0u18=2Q@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3] imx: Add FRDM-IMX95 initial support
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lei Xu <lei.xu@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785852619; x=1786457419;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZsiH0QJBSLmFHPGdBo4MryAHHtFMk7vw7tsnUEsKxpY=;
 b=l8NWOz7f4LEk5qq8jRm+cFmVNOrmVEIcGlRaZ8Uib3rUuYm6qb5A1MJG35FMeZl/0a
 tKEvDLYdfP1RMTX0Efpg85MY3mn8htcIB36+8wQUmR1HPESZ8UZCI29/GSs1Xxaua5DC
 JuKAwmXx6KWr+EZsbv9qezhDHqUCupC253Xq54+s3uiYnObrqX7lxHCgyjssjT0qVX9h
 RkgVYfLKrrx6NsLERucLvUmJtU/HGg+vBN0Rio18JSm0sFiP6WCQDH80V2xAVgkC6AJo
 IJ3xaGhYAxy8VakGJsjHEDXuJzMPQaP8fr3m2NUiAoQY6Ns0ifnKeRgw/6Wk1tjx+dee
 tKaA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=l8NWOz7f
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Joseph,

On Mon, Aug 3, 2026 at 11:42=E2=80=AFPM Joseph Guo <qijian.guo@nxp.com> wro=
te:

> This is difference of general pcie driver in u-boot and kernel. Sorry I c=
an't answer why U-boot didn't use the property.

Please try to make the U-Boot driver understand 'linux,pci-domain =3D
<0>;' as Linux does.
