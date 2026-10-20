Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392B606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y5FX8/kj;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=mr2xoxBz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7077607F2;
	Tue, 20 Oct 2026 19:07:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHo-oGj0Iv90; Tue, 20 Oct 2026 19:07:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F3BB66079A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792523228;
	b=TOcsPz8uKHI1OgOXMq8NKtRQQaKJRCc4Izm4E+1bAP4rvzrWRi3oi+qB7FEUHxsHOwZx
	 0fsGwIfB1+Pg13FvMD2zS9dmVYRWme23Obttvf5PjGm6TEiz0GWcIAqwlfNeEaa1JhpHK
	 4Qd+m1209JMZES1iUhYjTX+7PIFgXMvT2AS2QJXNtyGLbkFDeVBamHCWwZjy15KI19H4V
	 TbwNsZQSqheFNYwW1fWHAFww46W5GYl+FMkaamS/SHjz//TUymtZKXT3H3/ZAyRgLEh+B
	 4CIJDsjWXBgnStUoAk95CpnZ6bu1+jwMr/cfswJwsNuZojf+X9j2dkFBnFEdGXpae0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792523228;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gST0QjpI04GYsCFbZtCh0XJod37QhjzA5ljgeUJok7U=;
	b=SQCeLkWbJhrxvGZ4dCWgU7f0BZvnIq6DLLgPLOPeHyHOKguaMJRLQt14lzaXnODrTd41
	 ZE3kideAWsEqtT/Axnrk6qwa6Wt379fdgikqJsKr50oRsaEy/hxf3HM92oqNZUa6VqUGw
	 zKfwCfZYl03ra+XykuodC8lwRDeVVFVEkN/101sVFV+9ihu4DVXdOc1zlx1tdNVNns3QO
	 +ORwH0oAMPEBwwurssccr0fqc+DkBmRhrjhU40RwKbqm80J3SwY0MuD6UROyeOJ0qRKd9
	 sKgQjECw74yxOFe1hsQXWuvCZ/88K0mHBv9010AY6NvttDhHbD5Mt3Y3/J5bF71wUKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792523228;
	bh=gST0QjpI04GYsCFbZtCh0XJod37QhjzA5ljgeUJok7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y5FX8/kjIsufDHSsHUTc8oYXaHiM7wfVNoPz/5dJBs+Zl+ubDm4NcaKTCB8z+z4tM
	 wxHxbaueiCQvNnjP2YuNq2qA9jyCdU/jaiBKCDQgAVkty0Ez84sjZ/lGOwaQd0u3Dn
	 Fg0H8oR4v55V/Q+zUPPbgRZNYOx2ljLouPq19U+uQm4zbqvFxlTTMAn9KbfO6zo3Qm
	 76Y36bOIx9rg9tPOlMxcs0hps6yjw5lvN/aA9aww0TNtnVbZxmGI0mULLGCp+j2aAI
	 9d/ts/juBPFa+rebd29GiOMkXrTOe0jAVwQ5wN2dOgp2ACQSE7dEftu6alPU8TXk6S
	 YYXSsWLsCHtUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3BB66079A;
	Tue, 20 Oct 2026 19:07:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C1B111AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B29638104F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfjrER9kpluB for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 19:07:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 869F580F77
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792523226;
 b=QFYqWe1vuDxxFZBNTh/n+910nhU7a4TcRJOqHJW6SMZ5VZmnIAvsHAWcv05GvvpWYPJ9
 SFnzbGCaOqw5KZ1EldCp4gjzitUbbZ8mjrSyl7mXublbUj3hmZXA8iepVLWJ/B69NsZ29
 QO3h2O1HNzJkFZLdCB1wVMUJTRG4pu/7z+vs9zqyp9uMuQzkI+90j1dLRZTHWIiuUpZDu
 OJMaoQyByK4rK0rHzaKUtWXu771URBvjhtoApptiv2m0m7OtPxDTy0OFwx8wtISN5Aeg1
 uWhQAiALkZ8BWXB/RYyaeQc5m4kziw2XmhhgfoZUhyTmoTymy4E5SmwUOd22i8LabDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792523226;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=gST0QjpI04GYsCFbZtCh0XJod37QhjzA5ljgeUJok7U=;
 b=RpaKQ4qzxmgaDoFV0rSgfXY4qg8rYnK0ZGGD4O5H40yib9B5OB86iv5Bn2ri5WyQUhAc
 nqZBCjtFcHAUjuVcKKglQvxa+lC0nROtHCFfa8BHhpaGXbhXspvJNish1ZJSITF5iMzrS
 WmrBMAJhWTX+eE1dygUokXH+rRrjteFXsNJBtA3GjHe1tskL+JFfW7xAc5sU6lG7osH91
 NAOqTpewPbft6N3eXHD9F//XSzNovsk00yap7BmL/HsT6EEIXQBZjKvt8MW1iqBHJGYAo
 lY1We07DslYvu2mB5Pd0Tyr4t/8Rw/3KuiRt1EhmGRa98zsHBRpSwlq/2iVS4+hWgmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=mr2xoxBz; 
 arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=mr2xoxBz
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 869F580F77
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792523216; x=1793128016; i=fiona.klute@gmx.de;
 bh=gST0QjpI04GYsCFbZtCh0XJod37QhjzA5ljgeUJok7U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=mr2xoxBziQ8+cb0w4A4A8es+u/zaVxJ3vU77oLiynwQLkMomPJZpZjA5UQaCrW/F
 c42/ofpDiyyUF1Zc1wk9Djjt6AtlIeEGXHeNGNTwR4F/J5AfarJAW7M+qq+zb33/0
 mjtj/5VhvmMcBUHV513OXcEGT1ix8iJ3lgaf/mJWuQtN1ewKFJY2q0PpFXrAaXyDU
 UJuZVddYM9vAfIYw0ezxqGkA1VjSNg8RgCg+FWFHbO0FcGmTuKBtpDS1ZGOXFE2jr
 x7eLcOUQrfmWBxHwvsvXm/6PaK+AuKvVsdIgU4LMEd912N9kB3PUbTSMr6Mhe10Nf
 NZlrnFUeF7e9UDA/Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMuR-1wx1Jx2sy1-00WGS1; Tue, 20
 Oct 2026 21:06:56 +0200
Message-ID: <af131469-2a4f-4672-9359-742a169e36d4@gmx.de>
Date: Tue, 20 Oct 2026 21:06:55 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Marek Vasut <marex@nabladev.com>, upstream+uboot@sigma-star.at
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
 <CAC928Haem8N=Ab68A80Dy6Re3obLFfgCO04667GONkKF=Pv0-g@mail.gmail.com>
 <CCZZi50ESNOykhy4pWjDCA@sigma-star.at>
 <CAC928HZismKfrr8+Jjaw5f=+QW2rOpqqgT+khgpKP3LmSeG0tw@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <CAC928HZismKfrr8+Jjaw5f=+QW2rOpqqgT+khgpKP3LmSeG0tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7D1C5+HVtkMlxOB0d/lrh+US4mIhIGpP4EKzjfEzbtKqOUZp2R9
 RbJ+bAXRVyNMZl++Cn4YtsLJI2lS5zryo0Io1c1TXaD8hQpDKMq8hFQnQza3wFb3HnxLD0b
 YOIGAMCjJTf3nZR1jwCz4muc1Oq+wtOo1wr/J+NtfrfVyXQt/TriRf6Ud9zuGA3YPkCmqu5
 Rd4iNCp47v1CTke3HyCxA==
UI-OutboundReport: notjunk:1;M01:P0:0hfU39tU/5s=;0LP14o8+lr6ee8Sf75+7IrNDTax
 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
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 20.10.26 um 20:38 schrieb Massimo Pegorer:
> Il giorno mar 20 ott 2026 alle ore 19:21 Richard Weinberger ha scritto:
>>
>> On Dienstag, 20. Oktober 2026 19:04 Massimo Pegorer wrote:
>>> Hi Richard,
>>>
>>> Il giorno mar 20 ott 2026 alle ore 14:30 Richard Weinberger ha scritto=
:
>>>>
>>>> Well, I have a different use case in mind.
>>>>
>>>> What if you have something like this in your bootcmd: "env import -t =
${loadaddr} ${filesize}"
>>>> to import variables form a file like /boot/extraEnv.txt?
>>>> I like this a lot because it allows applications to set various u-boo=
t variables.
>>>> And to make sure to allow only a trusted set of variables, CONFIG_ENV=
_WRITEABLE_LIST
>>>> is configured to that set.
>>>
>>> How would the detail clarified by the documentation fix break your use=
 case?
>>
>> Yes. I always (wrongly) assumed that importing an env is protected by C=
ONFIG_ENV_WRITEABLE_LIST.
>> And I'm very sure I'm not the only one...
>=20
> Probably I am missing something, but in my understanding importing =3D=
=3D loading,
> therefore I do not see any breakage in your use case: importing variable=
s from
> file will load in the U-Boot environment just CONFIG_ENV_WRITEABLE_LIST =
ones.
No, I tested that. "env import" overwrites variables without writable=20
flag, too. "env load" is a separate command, and also what U-Boot does=20
by default (if configured to use a stored env).

Best regards,
Fiona

