Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CE6C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D342740A96;
	Fri, 24 Jul 2026 12:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOHGiy8V2t6o; Fri, 24 Jul 2026 12:34:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0966840AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784896461;
	bh=cyY2unD2DYqa4t+LN2U0XZreyXZ58qNKl6oAuAI0Hog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gBGI8XnYO99++u3W+JX3HFDHWBG8GMnWEO4/dfi35GTAWRidyI0ktzl/PmIqKtz1V
	 Sauhe02sPcrqgEv0YKAdNje3lC294s9BBUwWxkFda6TSzhrTUp0BCpJxeRhoT/TAzo
	 DlGithczCuo+2bXVzmkTdBmZawFMtmgCO8yGRJ0BZ8xCZjgGf0VWtOxrIUmTjgdBbR
	 I2N0xTgyASNMx3+5OmLJ60cVvem531ojkG5GcUeKzFly+wJOIu7meNdb+EI2Kk2IRK
	 ij7c7q+WYoonQmFEFrtLl+nAzrVe/CnyvZX+81DdJC9dwaej7qvxovKXo+HUhvBLJN
	 Chr0pNFOl5Ocw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0966840AD1;
	Fri, 24 Jul 2026 12:34:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA086429
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B04CD40AD1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VFPmcsPeZSJ for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:34:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A120640A96
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A120640A96
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A120640A96
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:34:18 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b2a8e4c77eso353610e87.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 05:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784896456; cv=none;
 d=google.com; s=arc-20260327;
 b=TglarYpdJTPDm7KJ7K42r+bRpefCcl27YGj/Cu2TwJ6OmO8p/KvsnAm5SFcdMZrAzt
 knRRE+I7HyEBFAeWVmuogNmwgi8YiwW0Ri61/LT3pGKv2ZZzeUeHY7cHiec1ne70UnS1
 NB3aWESXJUd5bunRKgu6rFTfxf9vVh/MWdFKDavFLeC7h50/mQaJHRcahDVd4PgZhQ4E
 WOnWbS7uB5S+nR8fbA1OXNYFPsuPwtN0ureQqqxyLPmAbqjcjL40GyD43QnS/e6wYPAF
 uMhYGZM+ME5ZK+SJ1mTCyWAReTdqm/pFv5YD8YjOmaXxEI9+jghnifAtwlVRFHmcfmvZ
 EXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cyY2unD2DYqa4t+LN2U0XZreyXZ58qNKl6oAuAI0Hog=;
 fh=wS3dsWetpy8mXQVDBBiByd84rIkQ7fcUym8YwGjFPTk=;
 b=kVX7m1AKwCjlvdXFCCpRUv3ez+wZJZL6JdJc3L+ErkOH1Lu98KIWMrPKWHZho8W0Ub
 cJPr6ZnP8F9e2mz3BEO4+pKVMXT1zo7iybh9n7DaDYRThDoI5yIO/wrQBiiAiYckIQEN
 lfb5BVmEbZmztjmolAMf9OlxRcpBBwcdSW9jEUtjvkM7067puOzwqehUuAuerdEgzzqJ
 zqEhcbt2kXbQ65dUfSRek07OhyySuQillDiuEqUj+Gbiv6IvGxJxDSqUAoujkaIZzwDS
 yFiimiUFvidWsV0TwnWKGwAy2KgOhZM7bR+wKQo9LKXVLcXuniLctcdPtqClTdZaMVc2
 eBzQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784896456; x=1785501256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cyY2unD2DYqa4t+LN2U0XZreyXZ58qNKl6oAuAI0Hog=;
 b=am3fRNTISiBIpPcYUheOqAuEMjEigDdTPUn31BQFL4WpSLZJ9JiRuoqibr9vzGeVUI
 yDFarCFHtXlvaXAlimKEvmIK8nwNV9nvPh/gHIux45Fj4qcNtQdOvjMDVOYyhA1k395m
 oWk6YiogLATPEkP9VQa8FkKyo61luVhtNrV2bLTdwPdG0yX1J6ZqW7DB1LHNF+XaO0Or
 +kgCmWc0kFa0ewRPk5tczLoalwk2aBL4w3HQY/UVle5yWWXo5W2QhokEvMVARmNwRTPE
 t2owIMmhdUwM3Wsru9HBOpiR97Kw+FaoqHv7/I8c9rR9gcD0y4L++uGGkZhTNIigp/Ad
 F9yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqt86+6zIXKntKGF/W4Ygb39eVRE5WX3SUX7JC26lpmFO1WJxCsbZki2tJiMyUZhGYsMko0+kI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzwD7eIzYrAeT0G2+HQ2YGGl+n9qxyM4VHMVaYmyzbPsTvPCXJX
 t20I5qa3WIKdxds/aOPHwfrGjGRkzJe6JwhywkjuP5r+8zeyt6My26NlBeWZO5O55+w4sLgVfaV
 O1ECF6vliyNyK5P24xIGMMM3W+i3Q1Dc=
X-Gm-Gg: AR+sD11+5GeoL9uH6kGyQhQOcMt9WV9Ctz5cQEzaiedI6jE1DPQa3J6+T/XiDV/LGLM
 xdeubTjcnjp5ooEHOhSQz4lVO0iSyv/mE27kfyHMWTixTi9Zq4ifw1nUXcrcsPromSt1Tun2a2s
 FQseAielNOYOEnmuWLbm8fVX5mzhNtp09Swi59k89c1eB+qlaWtldlwmHw8hBP5BC8HprWElLkg
 6al5Wg8Cj+23OBUp4Yu/FTOB0Fo1F0T+DFzfsM/5vfGq+4S7pJM74ltMmW+qC5k1lsOSKhchgKS
 luTE8PCV8j6LvjsqLGv6NnIU1YuJFMF8VFP7H0/HjnRA1sqDv0E=
X-Received: by 2002:ac2:5dd0:0:b0:5b2:8ce9:10f8 with SMTP id
 2adb3069b0e04-5b2b2f4e210mr1240825e87.20.1784896455381; Fri, 24 Jul 2026
 05:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260716-imx95_frdm-v3-1-bb53481157fc@nxp.com>
 <CAOMZO5AX2VZJEKw4dyg+d4S=uRNBcOhe4k8ZED9+Q0mv=_a9Lw@mail.gmail.com>
 <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
In-Reply-To: <MRWPR04MB121170AD9EADBB588BED27ECF94CF2@MRWPR04MB12117.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 24 Jul 2026 09:34:04 -0300
X-Gm-Features: AUfX_myk5CR3gfEObcgaCd8i9sbcF0mSlWD2hrJGtNFUFqoWcxyWX4jgiBlw8hQ
Message-ID: <CAOMZO5Asxi5JFdfXpsJuN1shOg=Q1eGiDvc0Ywak4mm4Odaeuw@mail.gmail.com>
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
 d=gmail.com; s=20251104; t=1784896456; x=1785501256;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cyY2unD2DYqa4t+LN2U0XZreyXZ58qNKl6oAuAI0Hog=;
 b=gTxNNfwMw0uoCXva6MNQRbpYrChAlbuo37bux/4hPDvbOVx+wNHiVsV6do+V56q+Gr
 aXCMxJwOFDfFSAGxaNyuj8q4ZqsKC7HG28YKRBF8SN0dusUpWEyGDjk4pWkB0/izrKiL
 fpS4CfIFO1YzQP8spPrxJtbGIRLA03YwgZL1wGJH1GfBwt8lEn9oLo3k60oI7nZY5vXw
 BCeY3L14iTK0szLJAUkwBIsBcTsZcYV7zKFM381nkvVrkIJrNypM/FoT0z9qm/DUeWbP
 IpoRfEopl+mA256NkGy08FcfcVefo2xIS3JYEZrhOECtderXJDLIezs2YINhLMeqc/fh
 k5LA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gTxNNfwM
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

On Fri, Jul 24, 2026 at 3:50=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wro=
te:

> > Please help upstream the alias and bootph-pre-ram properties in the ker=
nel.
> >
>
> The alias only works on u-boot stage. Can you explain why this should be =
upstream to kernel? Thanks.

This is not a blocker, and I can accept this u-boot.dtsi for now, but
we try to keep u-boot.dtsi as minimal as possible.

The bootph- properties are accepted upstream. Take a look at this
commit, for example:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?h=3Dnext-20260723&id=3D06d40112780e79631537496f37958087ce2704f7

If you can help to upstream these bootph- properties, that would be great.
