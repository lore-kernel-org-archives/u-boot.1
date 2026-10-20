Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EC606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UJpPw0Mj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OLZe3Z6v
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74D74407F5;
	Tue, 20 Oct 2026 18:38:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7l_Svi34HXYp; Tue, 20 Oct 2026 18:38:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B1B8A407D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792521510;
	b=RbeQB4SAYanpm93pLYFa5cRawn9zfQCrQMumvpP+O6EmCSpd/VZmPCkshaSIa6v/2xIS
	 oPvZ/F/FDTzPE1VUlzjxTO6riATIyp/qFS01YqLlzjQwwGLr4gtk4KKQBlpWBGczV1aRU
	 4kqaP91rrAmKIbsV7zcfQ7TifpJkENy0r8P7jUOX2P05sQwAKLtyAY6VDzZHM5by09GuA
	 XdzqqlLq8t+Ow00hZqs1c4Ibm+OhiZG/kxWS5jSoWEbQwu3tKgMbeePm0KwLjCht3KAwH
	 R63hmYPEF27kZCqOWVWDZD+SbJ3A96o3h2ClF91cgzpRClKbrtGSHeOJbxhLuwvdHuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792521510;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UTA0yqHMA9SZA8ypYMRgRAc6IkU7Ml+BOtQAeJhwSSc=;
	b=L/MEMTmVg8+1Nyj2TZDcmHRc8ZeYSqwlmDBeHh+PO5NE6XkaHYaPsgfLB/T8u3wmtnlr
	 tpRuRtex52gKe1F/PzTPpH5uAR0qxzpfEd/upkh/3jYMz7UhCOAEg8I2eTwZgIpfx/6gG
	 JhVuqaK1Csq+qDiWJlGmibq9JxQoUmm8lPd0cNuwumMZ0OG2Mc+tmdZAXVA+Qhe45zWuN
	 KYaCuZoxtIBbmp3JZYknVfquJum0SpTI4mXMYuCA60XyyNoRLKPHigXWnyXdR7788nR9f
	 08CFCkwkXDLthHC9aIg85th3/QmfaPbpEXGrq+g+nZipz3OTRY9QIj14o9PKWyyHeVw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792521510;
	bh=UTA0yqHMA9SZA8ypYMRgRAc6IkU7Ml+BOtQAeJhwSSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UJpPw0MjgW/Mvfe0AyvGwHg90xSFZdnwectBqnWqDkcMkMEuNVZMuoaMYhMbZuJ8u
	 fyymHt38Xw93EDn+esM0P3G/8EG1LIJf4IImBEtcmX6TavT3SQo8o6OTw1Pqelmnut
	 /kkhjTIwYB2FfkqbkGv++aGPn6ARIc0iIjxt4z3o+H3id29ws0AYYNbb/vR6TvB2jz
	 LExKcAUHf+1oxsLpmKz3V+6EQ1lGtposS6oMRJe+UyHdmH8b4/6oOCcWZEK30fvxoZ
	 CBq5FcPODypLqdpFTMglCAVA0BUQc+hEFcgqktA0DuhqwmHG3wvWtEXywWKD9ELAEY
	 Bzr63YDXn3QLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1B8A407D0;
	Tue, 20 Oct 2026 18:38:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72072255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6238960773
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:38:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AN_4TPuxnj2K for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 18:38:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69D906075F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::635"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792521508;
 b=fnCjDdXILfOW18w0t40xqaMF6r8y2+Xx0b6SvOxrzvHegHPKmoRiwdzZNbj6xyhGwcA1
 i8RDzAf4xbX89xqSNF2W0cMoYLMRR1dI9TzjPyaKhlJfleMNfn3Kk4E6sF5Xfa26KDhR7
 T2kCMEszmSrFXI1ITvbnHGF/x52ts0YNrM4wIf01LS/ef3tx5Sxoh6llGV95eHESIUy8v
 DYg3ilIg0cDWrF9k08zoizbSI4uxmmM55YV6TccTtkRbAKDSU1IvPfODbs259Wb9RQQQS
 t53k5hu+8lQmTbIJMgJStcccUrwtBkwhcpKqjjBL0QrmhVI0ftWOL4smXCwCUXPv8Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792521508;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=UTA0yqHMA9SZA8ypYMRgRAc6IkU7Ml+BOtQAeJhwSSc=;
 b=cQho3fUzATK49ahMhWhgdT/o80iguyWleSUP+gQvwI7baNI038KE9sc0wdbCQdlHecvF
 GtApC0r0QBj5YD85Otgfs7rLCHfwjjlUsVgJSKQnmwRcthzsGSDfF3GMktCtB7wsXnRjo
 c2vRNR4CJYv7bHFBIZccHwuTqQzWdksEkF3jzbfGyWTjPmNi6fm6QLGyS6quIv/dLUF35
 GIZXhL3A8e9oa5Yf5c6NucYasDxaRSa6QV+NSK5bUq9WphPAyh+0LH2G874IG/LLW+cqg
 tdUpc0YdjakyRxLUlG7KvNblRrFE2+e9C3D9fS0qg/iYqXaLN+7QEGWj9w82ZCfYKiA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OLZe3Z6v; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OLZe3Z6v
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69D906075F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:38:27 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso425773566b.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521506; cv=none;
 d=google.com; s=arc-20260327;
 b=BNVcSY5PgJBJkAwnnhVS9N1b0J2FPAhDf4Bsn4cyj3CMbuZ7xvypRtgr+hC7kpJ7K6
 gUPh2kP30PPRSOltF/uHnYeluIilLa0RYIKjg+2T3HTK4O4hypYXx1YEzjhtOpD02XJN
 3YN7MwdzqeG39Eo37MidpKH4UBq7IwZGRNeHMK6tgLXl85XI5VYeYDuZEObcLWu9qmni
 f3w48Uht7Flyj3yKXGdC+mZpXqXjGlh8I5YA/ntCrcrWKtYhs7tWINEL7FUJE6XjF6hi
 0dOgbKYzQN/GHv/Oma6WHAra27jrajzIL8We0X48EOerBReFZ8+yuBNSexk6gmqOA6N9
 tx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UTA0yqHMA9SZA8ypYMRgRAc6IkU7Ml+BOtQAeJhwSSc=;
 fh=nAr1B1U0gb7MeryP284gIMX8LbI8VAHJ2z7eUa1J+ps=;
 b=bo0KrMT3oWefGYXp9g9hekQrxq1sFx0DM2yR3dBP6j5PcqOiTJdfnhpkMsR4aS80VT
 OI/pjmkHD20HIeJ1jefQOubdsh1s8kuvE5Iwsn54dXT3gN67VHZbmFYTie+MhSfXA85J
 oEnpRz3TPd2YafrdfB01j9yFFsr3FIGvXBC+Zxw0EmxzTfhYcxfgzpf/hkEiyWS4gca6
 v6/56h8GBRKZCoiz7eUAV9dWbSR1nhVubML63LoCcjLePQgyN6n9KcOqbogy8PNl3Df6
 4cpl/6PvS5pwTN0zmULRsJnO66/x+dFZ1fVfxZhEbjQafvCm28jIkPkM8F8wwQk8WCHX
 PNcQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792521506; x=1793126306;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UTA0yqHMA9SZA8ypYMRgRAc6IkU7Ml+BOtQAeJhwSSc=;
 b=OLZe3Z6vPz818VQTC4VKpd1HIrm4cJElG2LHhyLSWwcBkviVrZcpFJdnJOyXH7y9kG
 54a/XztVNwJltnX+wLR3lDuTG67vEogq5gISb8U9aBNTtJHxRaObyVIBmMsOXj3F+Swc
 eMb6tKGn6HRBM4Z/I1oqWEDsr6e8Odrk4CnB49Th+KhORC4gak3kPttJxso7O1qFb2Ph
 oLybC6CzRDcWAw6NZTJutTNhBVzC7f0YI3EcwhmE0ccreY7cqdEC6QNFMgXXPVNjrveB
 5oruz3zJ7pp4I27zBiDcHGL7+CEsO+FYVrBd3MgvUtIa52pszHSeyyc+u/ALO5FadOWx
 ZfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792521506; x=1793126306;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UTA0yqHMA9SZA8ypYMRgRAc6IkU7Ml+BOtQAeJhwSSc=;
 b=i2Mu8Dh7RU9Xu4qoB97LTiVe3MxZjnyCWqDOcWhXL0+50Gv3+P3I8MpNN8XWyA2Qgm
 9QWrnDJNiDHwauraTQquDSKfLOc77CBMRcKNdVzsqkXTs/RI0cO3a1gGjih6BVeR3JYx
 MmJJGc8WyQOli5qCoXYLdWf1ZdJUyrQe1DEog/IE9VBQyCs1ik1JMI1OA53KuVMDJpe7
 2F41fZIrYpRdIVWNzuwkkBi/3GMnUfRqP6+TaUlUEm5YeKisqmYbtS+vDLtTdLzfoT7G
 n1cx0FyMNv8rkvYDGcIdaXGej6of5r2PpzCo1MHIzkDrcK6WdxLlWstDlpFVDQaRNnyl
 Aptg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9+yzS38EvfPFcXaTlC1xTXdR6w2Iji5QsJRQ2de5C4/0fB6ZOz9eSMmTmCwhqcN4yzdcLbWk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLf7ML/CxCPbG7qC9Q2zz1lIqUtFBloBFD9uAZjcOTGzbsmKdeD
 wHQvOZcaiQgKcfBCwpVcwzgux1doUi19Bot97dqdpcWKoKDOPFjuY2Cs/5RKQdyGaztOgAhdKN7
 3igPWtFRNKAJpVKadm30vR/uMc3RLCAVaUzfvj2k=
X-Gm-Gg: AYBFou0z/v11XIvotLi+8xGP0A2mC/EROnemqfW4G6nSk57fPUrk4AF4mpwr+EWDUYf
 FUf4fsYeDttvALY6/arzCM6L2N6bZCHfrCDK6nb+l1S+40FajOC67Nj0KkCNh3soIBfDnZTWft4
 K3wKkKzOeR34V3jqcXQH4E4yLFVJZlviWCfS34J/4nYzwJ5AhCufXLh2gLacgDDxKlG1GrER+9M
 1v9P3+jX6Uft1o4M5oh0pE0RVd7ito6vfJTKdAZhj+r+4op6H1QZBaVZTvBNoaiKED5zx8nEs3E
 ymBKCn3YQghb9u/IJCYDXW4OAxwwU4wOj1uebilAWB/8C/yq9AjuULLa
X-Received: by 2002:a17:907:3f12:b0:c40:38b5:d784 with SMTP id
 a640c23a62f3a-c467965b8ecmr4354066b.22.1792521505668; Tue, 20 Oct 2026
 11:38:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
 <CAC928Haem8N=Ab68A80Dy6Re3obLFfgCO04667GONkKF=Pv0-g@mail.gmail.com>
 <CCZZi50ESNOykhy4pWjDCA@sigma-star.at>
In-Reply-To: <CCZZi50ESNOykhy4pWjDCA@sigma-star.at>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 20 Oct 2026 20:38:14 +0200
X-Gm-Features: AclHuK9dt6eOaHumCYW4muavFQoSZvZMWQfoyGSWsqx26K2fDnGL6ywHPlMP6jA
Message-ID: <CAC928HZismKfrr8+Jjaw5f=+QW2rOpqqgT+khgpKP3LmSeG0tw@mail.gmail.com>
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Marek Vasut <marex@nabladev.com>, Fiona Klute <fiona.klute@gmx.de>,
 upstream+uboot@sigma-star.at
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Il giorno mar 20 ott 2026 alle ore 19:21 Richard Weinberger ha scritto:
>
> On Dienstag, 20. Oktober 2026 19:04 Massimo Pegorer wrote:
> > Hi Richard,
> >
> > Il giorno mar 20 ott 2026 alle ore 14:30 Richard Weinberger ha scritto:
> > >
> > > Well, I have a different use case in mind.
> > >
> > > What if you have something like this in your bootcmd: "env import -t ${loadaddr} ${filesize}"
> > > to import variables form a file like /boot/extraEnv.txt?
> > > I like this a lot because it allows applications to set various u-boot variables.
> > > And to make sure to allow only a trusted set of variables, CONFIG_ENV_WRITEABLE_LIST
> > > is configured to that set.
> >
> > How would the detail clarified by the documentation fix break your use case?
>
> Yes. I always (wrongly) assumed that importing an env is protected by CONFIG_ENV_WRITEABLE_LIST.
> And I'm very sure I'm not the only one...

Probably I am missing something, but in my understanding importing == loading,
therefore I do not see any breakage in your use case: importing variables from
file will load in the U-Boot environment just CONFIG_ENV_WRITEABLE_LIST ones.

Regards,
Massimo
