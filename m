Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CF5C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 20:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01FDD87CB1;
	Mon, 18 Mar 2024 21:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SG01qWad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A5888001; Mon, 18 Mar 2024 21:09:56 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13CE587BC9
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 21:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29f8403166aso729433a91.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710792592; x=1711397392; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXCdC6FMIOvoQS6NLZUOEIyzXNlGihzcDWh07A25f04=;
 b=SG01qWadw0NGf0KE+pGzGkXftWsSjaxUb7aWoT0FuRMHjJmn7wgYkmFn0DmQJ1OTXA
 IfTLZw+iEjr506rYezTOptPMqjOHNibCM60U/yGoDdcaVoLr+nUvsYA+ufoL19e2Gu6d
 oeuud2XjAYHzO0xrEivrmLcZfdHO35NRU6a624YcOmV4mmxWh1gaCT3Qntp+BmDDBT++
 QwgiP+2TuXBxr/PPRzYnA8XkCxhBZJojzV39dz1BFed+1o5k7HVatWMhnQzNsuMzES5M
 LqX1aif0hDqdJUnM72m7l42ybDy5t40wuFVYawrS0IoneyTfOePybHX17YEUnDK1hQSX
 3NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710792592; x=1711397392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXCdC6FMIOvoQS6NLZUOEIyzXNlGihzcDWh07A25f04=;
 b=OzQ8Xza/oztUK4WzKYOMVCCsLCrlwJUlmvR1nSrkkoSfO2jSexAN8pnJJjqTq17IqK
 Hkyb9qvt1uQ1bHCk0z+beLMMmEGUxxLRUpvf8MqnRrg/91Z1CkakNHi46E388yztv4yp
 i1R445qXJtBZ7Iz4qH4zJ9iI+YZ/Zur6P/n9j5FDxqNn1vnkDOB8B3of2GgHRE4yWi+V
 2JJ6qGv5Ta25JGFJC8joIlx8Yzg1dKBWyojuwAR1SSV13UlgYZNYFam/QOr/YXY7cKCF
 h6l93yfveb5yXlwXqWCgJXBE4hiHaj0mWPQKoSIAh7jN5U3pw1QcOjNHZl+z4GtCpGG0
 SYEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6J+2SPnFfSJNkI3Jy6kbGAsbFxJkgw6axSyKCrniPVdyiNXpmjAZiImQQ085/xY4DM6gfk4oRPdMMvfaEplFzCu3YPg==
X-Gm-Message-State: AOJu0Yzz2+wpRJtKUYvCPEFNCc4kJMec59zRZM16EeV3Fku3Na/DAoyP
 etz+H6TaE4jKepSO/Eswy5Bm4cBcRV57N5G+DTmbTLmL4tCsSev/8m14RZ4lDt0xKg+7gragMgo
 pcp0UJkusI9krO8m2pL0PeGnZuoQ=
X-Google-Smtp-Source: AGHT+IGq5LLxPYHdyhDciijdO/gdXzrQSyVMtmRvrzqBU+cVtJBGCT+baqO/v48vG5tggzv4zgODhYG1xBpipyDNBq4=
X-Received: by 2002:a17:90a:bb8d:b0:29b:ef73:44ff with SMTP id
 v13-20020a17090abb8d00b0029bef7344ffmr250280pjr.1.1710792592586; Mon, 18 Mar
 2024 13:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230214133814.4173549-1-paul.liu@linaro.org>
 <20230214133814.4173549-2-paul.liu@linaro.org>
 <CAOMZO5B=EYPSNXkr=FM+iRvRYiv9fysB8DfhntuhQ_jhkKz38Q@mail.gmail.com>
 <875xxvratg.wl-maz@kernel.org>
 <CAOMZO5DBzEcga0-QGBBP3twT6imLuCv0cD6EYLOTwGN47wTxsA@mail.gmail.com>
 <87zfv7pojq.wl-maz@kernel.org>
 <CAOMZO5AMi_5XqYUodPcfiFtbn9A7P1HVn__F-BLavLqnwMeNkg@mail.gmail.com>
 <CAOMZO5CqH1OuVQDNH7+CuzPbBt9M8F7OOhDgCZZ0ad7rBfT52w@mail.gmail.com>
 <vozturnswioy4b46tp5j45tq4kv7gnfkklwnw2bipn3mi3q2zi@4f4q2bwf7qun>
 <CAOMZO5D0TeJ8BDCZ73Txq_OvxcNN8KAASOgyzAU3EYtR7igAsw@mail.gmail.com>
 <gjz5nphb23536caq63gyqavrm2kwr2oxwzolrbjlvxks5fomx5@4c6zmshqowdz>
In-Reply-To: <gjz5nphb23536caq63gyqavrm2kwr2oxwzolrbjlvxks5fomx5@4c6zmshqowdz>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Mar 2024 17:09:40 -0300
Message-ID: <CAOMZO5BBXnR4m1H-+e8dFjtrw5p2Z9nTyVRRaAiDwbH0k-HjxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Reduce add_map() complexity
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: Marc Zyngier <maz@kernel.org>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
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

Hi Pierre,

On Mon, Mar 18, 2024 at 4:59=E2=80=AFPM Pierre-Cl=C3=A9ment Tosi <ptosi@goo=
gle.com> wrote:

> I notice that the mem_map in these logs have overlapping ranges, which re=
sults
> in unnecessary work when creating the PTs. For this reason, it would make=
 sense
> to prune it in arch/arm/mach-imx/imx8/cpu.c before calling dcache_enable(=
), IMO.
> On this point, you also have contiguous ranges with identical attributes
> (mem_map[0] and mem_map[6]), which could be merged into a single entry. T=
his
> could result in more efficient MMU mappings if the mem_map entries can sh=
are a
> block mapping. Also note that mem_map[4].size=3D0 so could be dropped.
>
> In any case, if we assume that overlapping mem_map entries are a valid in=
put to
> the arch code (maybe not as it leads to potentially ambiguous behavior?),=
 then
> 41e2787f5ec4 had removed support for splitting existing block mappings.
>
> In your case, my assumption is that the function was then treating block
> mappings in the range 0x1c000000-0x80000000 (which get mapped, at least
> partially, by mem_map[0], mem_map[1], then mem_map[2]) as table mappings =
and was
> issuing read/write instructions in that range (accessing them as PTEs). A=
s those
> seem to be device memory (I see they get mapped as MT_DEVICE_NGNRNE), the=
se
> accesses might explain the SError you were experiencing.
>
> Would you mind testing [1] and giving it "Tested-by:" if it addresses the=
 issue?

Your patch fixed the boot regression. Thanks for your fix, appreciated it!

I have replied with my Tested-by tag.

Cheers,

Fabio Estevam
