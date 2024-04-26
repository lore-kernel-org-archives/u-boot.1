Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839E6C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4012885D7;
	Fri, 26 Apr 2024 16:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GlBoPsOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C01788699; Fri, 26 Apr 2024 16:40:03 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC1D0885CB
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1714142394; x=1714747194; i=xypron.glpk@gmx.de;
 bh=2k3AsxCLGChRwDD4XWi9v/BA4CzfzeN0R35uO2imcFU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GlBoPsOgC0AOKAX8k5kLwiWM4NCKQYlzYaNBfwXFAeIlZ62uTva91VoJLwiwh0he
 XSR8jY40MMqRHOveGNF1aDlIzQhMTkbCN1MfZCU+lr8askb95Pqim6xi+FTg3cJvq
 oIiOJ8Sv6Rm8pl0lrKDTbkWwxiq0AZoXNl5vWR0UeNR7ECTdRgYHu4DQ6C3jmvnOi
 qPWfJ9Psqq6AHhkzugWsIazrkmc3kMc57zg6J2BMAibeO7x3hC1LrUh61JR7T4MN4
 pcY152oGxqxQClxumba+WiFbQOuWess0/qmvEtplOCGhfBwwUS4STkK5pcJ13hha9
 finyE+hH8LY8/NKyKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKsj7-1sGeAh2Hnx-00LIGt; Fri, 26
 Apr 2024 16:39:54 +0200
Message-ID: <8d75e195-d644-4436-8007-8476da589032@gmx.de>
Date: Fri, 26 Apr 2024 16:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
 <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:brFMVLDF34snilhTciWLgwhT3GfH2+virmsrEmRYTVXgsujjcro
 4OgcZnnpFlXdVP6a3kZ+g7QZNNXRH/rRhauJh/JHYBd/qii+VpJWGELM7Tsg+YslXsbHJRk
 7ERuI8uQVXY7dcOeK8bkCBbcXEU5qdW9ljHeYi4xhCO/nirntOJaNdh2JcMPv3ZkoQp79rj
 pe0ubu3xRa2gNDij1XGXw==
UI-OutboundReport: notjunk:1;M01:P0:NaIqg2OBKec=;QoTcymI2ktmI9HqMgOQ2HNeR4gq
 CS0NbvNWe8MX7MeiwjkqnH8n0s68yheiBdgX3SrIb6dktqDNwM0SRM12iCmrY1nZRtMfybKzs
 wYJqneLmuUnK+dUEYVEuPBiAPJiWmHL/Tr+/SoaGP80Z09tdXMJsVQaHuGljO5hINDN6w1GhB
 FSHWSicvtxA3ZaU1My5CTwL2KDsen0huxUokQ2C1YqqfHcJw8geWredP80f9kLqgsVLCPYZQO
 PQlyh7EHHtMMqGO4rkat06u9rZsNfnBjkubGy+L9n4KEWdfC4UjMBw+BqwK03KZ0//ezI2nI+
 1VmQhwJYs4Rv9FLagLg5znmM+AHnz4cFcNrbXJaIVZVoqKVtZ2VsY7TuwGZHqiGBdhMczhmTF
 Vcvu0Dcv4fHx6Gf79zNoFUsSPNKOIVhZUvWyOV365smaEE3LMvCvOeCuI0iQN0p+qllVjJ+AH
 bg0g6qLeE69569fwL5MfF2chqj1djrwsJLffZ/c3Quf7co7H2MfWvw3o0UZW88ECm7KdXfzxs
 3iOeO7sZV/qPkt3KYyN49jTyTfMDRB7FxXT3jyDEOYFzGvYci9WWvRXF5dyVbo/Ej43Ok5/xk
 nKRnx8rYPxvM0g4zuDGCAUDzT5V3ZgC88phClknrD1WKAwb17F1nAQhpdjDWdczaAavQQ3wIX
 iGkTZ4J+XdLYznXnGkHtWDl/d1I1oYYM0xTn3VCQCBVr/6mJKwH256XzkLUamMW7G1d+6PmVP
 l5fzl7sOdjjHIW6NalR9UQouUoPXzCkUZ6ot9ugEnP/wGOF6cXNcJjpjzjx9tua2nDmVPGcBS
 wO6q4HSYSijHHHQY4HzcG4K6NE6gTrV0tunAQgBcmM0ec=
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

On 26.04.24 06:03, Marek Vasut wrote:
> On 4/26/24 2:16 AM, Tim Harvey wrote:
>
>>> diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
>>> index 7a2543e16cc..4fbce519a0b 100644
>>> --- a/drivers/crypto/fsl/Makefile
>>> +++ b/drivers/crypto/fsl/Makefile
>>> @@ -6,6 +6,6 @@ obj-y +=3D sec.o
>>> =C2=A0 obj-$(CONFIG_FSL_CAAM) +=3D jr.o fsl_hash.o jobdesc.o error.o
>>> =C2=A0 obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) +=3D fsl_blo=
b.o
>>> =C2=A0 obj-$(CONFIG_RSA_FREESCALE_EXP) +=3D fsl_rsa.o
>>> -obj-$(CONFIG_FSL_CAAM_RNG) +=3D rng.o
>>> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) +=3D rng.o
>>> =C2=A0 obj-$(CONFIG_FSL_DCP_RNG) +=3D dcp_rng.o
>>> =C2=A0 obj-$(CONFIG_FSL_MFGPROT) +=3D fsl_mfgprot.o
>>> --
>>> 2.43.0
>>>
>>
>> Marek,
>
> Hi,
>
>> Thanks - this series does solve the issue I am seeing in the SPL when
>> enabling DM_RNG. Is this going to cause an issue for people who expect
>> it to be currently enabled and now have to manually enable it?
>
> That's a good question. If I do '$ git grep FSL_CAAM_RNG' , there seem
> to be no users, so I don't think we need to worry here, right ?
>
> With SPL_DM_RNG i.e. 1/3 I am a bit more concerned. But, looking at the
> users that enable DM_RNG, I am not seeing any obvious ones that would
> require SPL_DM_RNG too. What do you think ?

Grepping for UCLASS_RNG should find usages.

The only possible SPL usage seems to be in net/net_rand.h. Here a
fallback to the mac address as seed exists.

Best regards

Heinrich

