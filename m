Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA06C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B1F8477A;
	Thu, 24 Aug 2023 15:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gXaWNrUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBD185F9F; Thu, 24 Aug 2023 15:44:02 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE20846EE
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so1882645a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692884639; x=1693489439;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=khC6UdxxIJJtwSSrNXcIYrDuSZeZLlhidvp9qAsMnuU=;
 b=gXaWNrUjuoHjegPpdGllTF7sPo+7A9QEpFeBx8tSrirO1oYrjpmT2PsTpwe4bu3lDC
 lN/LnJhh7dvGriiZPPKZXwlbSUomdHxVyqYH7u69NfGS8I4N59nSt/NADKN0AlqPfS1Y
 2b0KA0axVEn6yUW68l20SiCFAlCWByQTxpOTCgnu2K7bitZVkCE1LKqfuEIoaTYQDPHr
 0iNTY4PERqZXjq46/bf55WZ/KCtIpXPcLMRIj5i0mADawY1CUXrxaIOHn1NDTCWTG3+1
 yWhjRto1/uTUcjLZbzc6Y4hjewMOYnFNSTWiLeu2c5YyDXknJrBCu1Vcwo9Bgy8QOgMD
 BJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692884639; x=1693489439;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=khC6UdxxIJJtwSSrNXcIYrDuSZeZLlhidvp9qAsMnuU=;
 b=M6PYvB+HfAU5G0El2kkMb16gIDWVI3kdijUts0KFNIYkUO/5i1FP89tD++UpBsexU+
 nVcKSk1TvoMEed1K0J7ilbRCwshK2xpjtj/+b/6C0kfbP0GXvzLvsCcIuHzYtrj1Bx8W
 u9GcElzqY1yA0WjbLLQKc1GalOW9vNdfh1fU0iZkznwEIT+QyzfebgPastcyLPuvSmWI
 mtGage2ei1L5SK+fS79AZxYRnoMMgGbJiCgTYv4x64WGxJ1NKlW2bndiXmFrwrO4VQF2
 Hv+pJJrc8I+gR+rW184b88dvyle57bj9PWU05U1FdVrsh5EWg5RpxrnPwLkCr6F/FcqY
 Gf7g==
X-Gm-Message-State: AOJu0YwtWkA3nDxj606t9Wn8nwj2mqUKJXqGmgZ3EWnNBVoGhBNvHNDJ
 D9g0Pk+9phUlr7wwIXIbjxQ=
X-Google-Smtp-Source: AGHT+IF7zJdV1AVoobIAq557ZfwpaUP44n9SimYV+AtCoOvD380zt4PVtQtWzmVacmuxJfYRHmu/gQ==
X-Received: by 2002:a05:6402:440f:b0:525:4696:336d with SMTP id
 y15-20020a056402440f00b005254696336dmr19115071eda.8.1692884639007; 
 Thu, 24 Aug 2023 06:43:59 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.238.14]) by smtp.gmail.com with ESMTPSA id
 d5-20020aa7d5c5000000b00521953ce6e0sm10531736eds.93.2023.08.24.06.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 06:43:58 -0700 (PDT)
Date: Thu, 24 Aug 2023 16:43:57 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_17/19=5D_ARM=3A_tegra=3A_dt-set?=
 =?US-ASCII?Q?up=3A_convert_TrustZone_remove_into_config?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOdcPHTsyKxN9OzS@orome>
References: <20230822112217.4646-1-clamor95@gmail.com>
 <20230822112217.4646-18-clamor95@gmail.com> <ZOXq0SrF9h0Z9uHw@orome>
 <86A72122-840F-46B1-9C25-0B6F5AFB82A1@gmail.com> <ZOdcPHTsyKxN9OzS@orome>
Message-ID: <91C94CCB-A214-4D97-B835-34969DCADB1B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



24 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:33:48 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Aug 23, 2023 at 02:47:11PM +0300, Svyatoslav Ryhel wrote:
>>=20
>>=20
>> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 14:17:37 GMT+03:=
00, Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Tue, Aug 22, 2023 at 02:22:15PM +0300, Svyatoslav Ryhel wrote:
>> >> Remove of TrustZone nodes is required by many product devices
>> >> which require repetable calls of same function from device board=2E
>> >> To simplify this, TZ remove is converted into Kconfig option=2E
>> >>=20
>> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> >> ---
>> >>  arch/arm/mach-tegra/Kconfig    | 14 ++++++++++++++
>> >>  arch/arm/mach-tegra/dt-setup=2Ec |  7 +++++++
>> >>  2 files changed, 21 insertions(+)
>> >
>> >I kind of preferred the original because it's very explicit=2E There's
>> >also no big advantage in consolidating this because the code is unlike=
ly
>> >to ever require changing (the libfdt API is quite stable and these nod=
es
>> >are all hard-coded anyway)=2E This new variant put non-generic code (i=
t
>> >requires a Kconfig option after all) into a generic place, so it seems=
 a
>> >bit backwards=2E
>>=20
>> So you say that I have to add same function to boards over and over
>> for all devices I plan to mainline? Unneeded code duplication in
>> action=2E
>
>There's a balance to be struck between duplication and readability=2E If
>you insert this board-specific code into a generic code path, that
>generic code path becomes difficult to read given the extra #ifdef
>guards etc=2E If you're really worried about duplicating code you can mov=
e
>the two libfdt calls into a separate function and call that function
>from each of the boards that need it=2E

I propose for now to drop this patches and when time comes to Simon Glass =
suggestion about events just create a call for this or handle it in some wa=
y=2E

>Thierry
