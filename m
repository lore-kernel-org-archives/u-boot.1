Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE78EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E23B805C5;
	Wed, 23 Aug 2023 13:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FhvFRCf4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422A4864B9; Wed, 23 Aug 2023 13:30:52 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732A6805C1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so13377588a12.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692790250; x=1693395050;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JLaKpFwV/C1aTo+nAKlxj3gzc/TSkHsbxML5nE548l0=;
 b=FhvFRCf4bJczgxZjXbiUSwDnTp/zBRUekxAMNjXY0uFyHcON625CzoeE5azSoEwPgI
 W5UF9+w0TmAZqJ62ITLy9SlE8zTsktqkKDbu9xkuic5z+lVBwhDvM4hN7XZuYf5QSSWa
 YYpStnAUPALPB/JQfaMePwoh//K7bgD+C15EhYhL3lPk+e+Dcb4lSBCfp/O28e06cw9r
 JKUptCSSisk8bZkYXRYOIV7+DXrqMb3CY9IrJe+CNUfMOQbaW1o1HQZ2NtoBAlUruLbm
 fh59f+aks1RlIVtM2RHDrQJvBlXs+4zKIbnuLzVrUQx6GuPjCqucO6BW0OLByRLFr7zE
 oDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692790250; x=1693395050;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JLaKpFwV/C1aTo+nAKlxj3gzc/TSkHsbxML5nE548l0=;
 b=KM9F3jXwJ7WjxYjICDjreqaePs39GS3zuC6OT5GYqsJZ6DbfQ2/5MtA8WEV9+4mZaj
 cu3O5W52Zq0djS+OpgFUllUAvusm7STTRrI1XoMSxMAzkSgj4II3hXgr/XxxToFeinDt
 zK+GIr5BTuj3aRHPchawrCRCnjeFke6adne/U4JNaPg0l1fBN0nFbpHgk3MkzW0UOW4q
 muFIWnY+M8if/uTCdd1MFNwUocsZSs9Dvh2N1lyfsC1BdW1Ut9af8pINMTKMIkIOBhAe
 kZk4Kf/OB2MzoQUi2CmceI/5Yaj7DJimVhan+YwzQZFi6MA/dT6lrCi37o42EkA3TDBX
 MZlg==
X-Gm-Message-State: AOJu0Yyiq/gTnvW3M0KnxaAMeKovPmqbN6XzPZuoGQ5+lkIgotBnhMOc
 SacquTkpQh09RyX/bQ/UbIw=
X-Google-Smtp-Source: AGHT+IEN7PeQ2lJB9rYCPKTCz8gM2HaoZBOPhHcB3mwBrJbru1aXtZWXv1w3XfktHwDxG4Muw1NMFg==
X-Received: by 2002:a05:6402:350e:b0:51e:5206:d69e with SMTP id
 b14-20020a056402350e00b0051e5206d69emr14442947edd.10.1692790249807; 
 Wed, 23 Aug 2023 04:30:49 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.10.167]) by smtp.gmail.com with ESMTPSA id
 z8-20020aa7c648000000b0052544bca116sm9102344edr.13.2023.08.23.04.30.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 04:30:49 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:30:48 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] tegra_mmc: get tap and trim from dts
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOXlJmZicgBUINlb@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <ZOXlJmZicgBUINlb@orome>
Message-ID: <10578B16-04A2-4CE3-83B8-2BF7FBDB7711@gmail.com>
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 13:53:26 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Sat, Aug 19, 2023 at 06:35:00PM +0300, Svyatoslav Ryhel wrote:
>> Default-tap and default-trim values are used for eMMC setup
>> mostly on T114+ devices=2E As for now, those values are hardcoded
>> for T210 and ignored for all other Tegra generations=2E Fix this
>> by passing tap and trim values from dts=2E
>>=20
>> This commit will cause regression on T210 (emmc may not work),
>> fix is applied in tegra210=2Edtsi and will be sent next week=2E
>
>Heh=2E=2E=2E I don't think so=2E If you already know that this will cause=
 a
>regression on Tegra210 you need to rework this=2E Adding regressions
>accidentally is already bad enough, but doing so knowingly is a big
>no-no=2E

DTS change for t210 was sent in "General tegra and board improvements" pat=
chset=2E This is why this pathset contains only 1 (one) patch and a warning=
=2E It has a dependency=2E

>Thierry
