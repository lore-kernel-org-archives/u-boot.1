Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B57ECA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 443D080F18;
	Tue, 29 Sep 2026 15:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7lUCPh6x8q6; Tue, 29 Sep 2026 15:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 061F580EB5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790696791;
	b=qma8JY1GCBAIP3dhvz3ZZO+YqHBJ+ADw2NEV5vzc9nuK1dilpRzIb9pC0ZvpDlQWyJFs
	 52TxJt/VBPbGAhbKeTDXpqW9NpssZkxX7LSZvcAvZgXzsqYJT5PYEE78iDsXX/25YBFHQ
	 KpUK1snqI/oogSFnPm8xUMIN6yaIGDJByNXYQ7UL3R4RxZldz3f4WP1GFn34NxbHfufiL
	 u1O9rb8V6WfurkFnlKYZOvhho0DqgHawh949yqlvFsFZbnz2CSUv3eS0TdbqAWeOhss0k
	 4WhD50BKl/5ZVKYw9Y6a4SlZ+vMeyx2iupaJczjKNk027stWFaXkizjs1W9ZnE3Luiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790696791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sJ4VXdtVaJw1N5i1zdbnzOU/+IM+FWGSJTvixoIZFnE=;
	b=Col7GQazS6lv+aoGEcwwepWezW/Vpo1eowZOrrBYeXcY9X3fOrgaKA57M95jBppuIpg8
	 H9+WlzYE+D6K4saOprhefya1o3OP/vIWtzFnWP4SGcTM3rsic+jJyA76EI5Mm2P25E4TV
	 9AEhcFNJQubb8G7pQk0IgNks83X6n2jAsarPySwhVFMpcPH50fuGSq8NUya3E6NvA+Qjf
	 FGsqvb31VcLoKykRGJV3QNYB3Q9tfjYvJ9qGJtNoBpA0qeZY/tAOM0RyjbsD9EVme6pMg
	 Fhqr2QaZHeLoC5sfI80B9RmOdAqs9wkYLZVtu3fKYxlJolszWXJxYdvi1w/3T90CO3g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790696791;
	bh=sJ4VXdtVaJw1N5i1zdbnzOU/+IM+FWGSJTvixoIZFnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNgjQivv16DXftXAKwpn8hQ3gHR5kuWXhK54xMiYbBjX4Jpz+joNStTeRCqdeZQhv
	 ErVhrkxxaF7Y6S7UUdl7+ENkWuAR2Gb+tK+dFsMEPqG2ufJtNotpLGpKqMmTS7RBqQ
	 /jDi6sN9FzZcCikZQieISBmLaDZwK8TYfppv84SNHsEZZJnZwbkOm/iloRFfCDVSA/
	 G9FIBCPbY4mkfzpH5DQhbSv0wfJ6u4O2xbdnYLzWE+LLkOy24ac+L4C/KmLpDjD0ZL
	 hMYrWje2O1zUrL0OdYxxgSD8I5HSkbu8ZhMsrnVXn6SsDQ1ToFId4ZzX816mKZABsZ
	 MmWQZcyYuTovw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 061F580EB5;
	Tue, 29 Sep 2026 15:46:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2854572
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C3C040792
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id knzlhqHKKmeK for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:46:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6365D40791
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790696787;
 b=WE3tPwOvq9Jt02cwICcDXmSFxNruyepMtdKYZG2qIb2Ig3XsVnaCCwmWtk3B/n5/2N9s
 K/4CUPkE5vsgzLqi+OibP8BIbOhlrI06Opklh0R8ywjRgSRAGm15GZ/jclqfsOQA+pnZz
 xacgWIKW8/TxNiLxN1qs1oqDEcBtnvPtKXBHVw664uDzIACua+yJo1G+F6HdPTaauTmc8
 k3tth57gDZXV1YldUtXA7rdMkHkIOZuZXIaFhGXekKxBeBmbrdHt205xZE956YJuxIyMf
 00DT1ZC5jCl7/Jj4KBktlo1IZdIDSet3m2i5I2JerSAgOAUKBEqASC538jMnx9VCwLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790696787;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=sJ4VXdtVaJw1N5i1zdbnzOU/+IM+FWGSJTvixoIZFnE=;
 b=W98FgMLNrNtP6M3/C5tPROgEJjMDFDx+oabX6pBpK9WlVDStxHFMYrmwy4E2Q3JfDQCq
 b05jQ2k8tcA7kGSKUnyngBKUDSYLx4DHqLTRMLDVsEljIc+XASLaN9OV4KmXLFfdCOZIO
 JyZNEqf7E1cRUimJZ/5oXWQ6KR3IkhvIkp+MOcuJxlTHckTU8PsGjywxdm7cJBNq+yR7i
 Dy7UJDW5vZJdCSmJPl1+P/NZOttAV1T6en9Fo1oaUqDwsJgrqRiWhDanY9WCRoGe8J/wv
 2dxAjJWUYau4M++fA3LBg7a3OWT/lUE6qQZX97ryin6ZJStRUtfEu0n77YrvC2IoHCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=07SGqjgL; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=07SGqjgL
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6365D40791
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:46:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A639A1A1064;
 Tue, 29 Sep 2026 15:46:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 67B0E601BD;
 Tue, 29 Sep 2026 15:46:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BEC8A103297BE; 
 Tue, 29 Sep 2026 17:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790696780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sJ4VXdtVaJw1N5i1zdbnzOU/+IM+FWGSJTvixoIZFnE=;
 b=07SGqjgLpwUfIiITy64+dLJ8ar57IqaqHaJgGaxuFxa3BGc6aQ0KbgeYqLRz0gzw7NA/l1
 4uMO8LgmILg6BmpZTUJVBrfR/9kWogVPVuLztMLb9YfvYC1pgm9H3tCM5bqv7kSvYvIGYs
 Yo/zqz3hCkJ8/i96eU23+meZyVSZ6u6AhmCAbngaRRkv0RUXObBmfWxSxdKjzOMKgF9Uo9
 Rh+/TqleZiAdcxRAerLC8ha2bbbsAKk96cr/n9K0q2bDARBQLby0KYA+VmdJgfjsnqiHjH
 +lbncopp+lBAT7wAxZsHTLunJCOBnyRJqakrwbKYWsGK2kJ1NSSvNhVmPJrypQ==
Message-ID: <b6042a42-0500-454f-9f03-54b3601743be@bootlin.com>
Date: Tue, 29 Sep 2026 17:46:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] doc: imx: ahab: add AHAB introduction
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, =?UTF-8?Q?Miqu=C3=A8l_Raynal?=
 <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christophe Guerreiro <christophe.guerreiro@non.se.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
References: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
 <20260911-imx93-secureboot-v3-5-542a99793af0@bootlin.com>
 <CAFLszTgti1cTpdeeayM1gS8JhZDribGV3Amz=jL6puhAxetRjA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVz?=
 <jeremie.dautheribes@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAFLszTgti1cTpdeeayM1gS8JhZDribGV3Amz=jL6puhAxetRjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Simon,

On 9/29/26 18:31, Simon Glass wrote:
> Hi Jérémie,
> 
> On 2026-09-11T16:35:05, Jérémie Dautheribes (Schneider Electric)
> <jeremie.dautheribes@bootlin.com> wrote:
>> doc: imx: ahab: add AHAB introduction
>>
>> Add an introductory document describing the AHAB (Advanced High
>> Assurance Boot) secure and encrypted boot flow, covering the
>> following topics:
>> - AHAB architecture overview (SCU, SECO, PKI tree)
>> - AHAB secure boot and encrypted boot flow
>> - PKI tree generation (ahab_pki_tree)
>> - SRK Table and SRK Hash generation (srktool)
>> - SRK Hash fuse programming and sanity check notes
>> - i.MX 8ULP/93 secure boot support
>>
>> This is based on doc/imx/ahab/introduction_ahab.txt from uboot-imx
>> (lf_v2026.04). Originally written by Breno Lima, with contributions
>> from Ye Li, Vanessa Maegima, and Utkarsh Gupta upstream in
>> uboot-imx.
>>
>> Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
>>
>> doc/board/nxp/index.rst            |   2 +
>>   doc/imx/ahab/introduction_ahab.rst | 459 +++++++++++++++++++++++++++++++++++++
>>   doc/imx/index.rst                  |  13 ++
>>   3 files changed, 474 insertions(+)
> 
>> diff --git a/doc/imx/ahab/introduction_ahab.rst b/doc/imx/ahab/introduction_ahab.rst
>> @@ -0,0 +1,459 @@
>> +       ┌┬─────┴─────┬┐   │          │          ││        |
>> +       ││Load ELE FW││─────────────>│          ││        │
>> +       └┴─────┬─────┴┘   |          |          |│        │
> 
> Can you check that this actually renders correctly with 'make
> htmldocs'? I am still seeing a mixture of | and box character.


On my end it was correctly rendered so I didn't notice, but indeed I'm 
mixing ASCII and Unicode box char, I'll address this in v4.

Thanks for your review!

Jérémie
-- 
Jérémie Dautheribes, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

