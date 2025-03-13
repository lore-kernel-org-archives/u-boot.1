Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22412C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 11:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5B581335;
	Thu, 13 Mar 2025 12:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NWlQVFTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B59728007D; Thu, 13 Mar 2025 12:19:15 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDBA80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so5031855e9.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741864750; x=1742469550; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9pQ1f4IrEpn/CQaYFZTZpOHXpaw8DWAwEP7ftlnBjY=;
 b=NWlQVFTxyEKoIGYUeC9i80LAGzZJLJWRy8E1tCBlHyQDHKrgV1hkHchvx4N3qzKFKZ
 wQilWD7Kohh1Ev7cqxPjvRrTFpHWxqhtT5PkdgepPguLCS9qdNF6Vfgn0+95258kGuHY
 B2AO49S3tvTxShL2ioRh1NiiSUc3pKxZj7i2pmfydPvTuqB0Huj7TDJ3+v9zwUQBrhsU
 1msesSbUb40hCC8DSgh/vKneWjbsa5EfDIFmaVd0/ckU0F7MC/7Y0isarS+2dws5wUVH
 zL9tp5VkOTzdrvX2BNoYWUc1EgDuz3Z8OFME+SNQTjX3s4QOTu125oUA/1ETrkVguNoh
 m7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741864750; x=1742469550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9pQ1f4IrEpn/CQaYFZTZpOHXpaw8DWAwEP7ftlnBjY=;
 b=WSPa2kAPZisgKT3WF0o7601ea0g3EsWPVXX56mCbsdiTfb35/XEVcxu478Kx0W5c8B
 nfqPFBeAUAautKh+BYvDDmtrc5aDufvalbau/Gv6gdwlYUz/JJyH8M0tgLPZe6Ypm2Dl
 qAVXVB+zOCdUtCy6rXGIJvAr8NlmSozC+sAjKgO66coVX+tnb86NKYb/TYiZlgaUbuiY
 EV6xOZ179gTcuX7WYzc4jlmsaX5DhzT00ntpZnyl8xvwPYt6YZ2R+G78QwosZmbwYsfr
 b05r4J4qV3/wO3RKIEG20X8RKoWxa1VKWulhO3Nd/OS3ol4vBc6/wipUIXsup/grMjnM
 65hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPH7tpfew+U8VCcgJFVZPbNQKGvR1BdHnkB2rnalXbxEssGefhiT0KE0SJrxvnMphg+VEyRe0=@lists.denx.de
X-Gm-Message-State: AOJu0YyWfwqa8Czu2nAcVsy5GHWhba35MUOmvckK7CVAuE88ExzqnCOB
 dRXysOSrx+lqXWi8Mudh4SNLHLND+9XkNcJQ0uYGbuecOnqtYHfApyxP1mgWEPPotBQXS1VtUcX
 6GiurUmE74Sxz7hJqossrWsF4E00=
X-Gm-Gg: ASbGnctwxmediKTeSJ9KYJmaL0ekFOXQvVfhCum081+TNiFU/RbNiQG0EfCgSJAQwMB
 yTwyaljA8Z8CIN2lOA+KFmtvz7CZ5Jbub8Uw+QEZaloLARP8Wd5LTvPolgeqk7mfjPmqtJLW1Fb
 C92YpwUf6ZAqKypw4+R+GkRvAFAtA=
X-Google-Smtp-Source: AGHT+IEHm6TWRPLaIlOEIXxCin0R2LWhCBKga3kE5EkduNYPfugTixX6ZPc0G/gw/70bs0LpFUN95qdrYj0zctBcSh4=
X-Received: by 2002:a05:600c:1c9d:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-43c601d19cbmr215410335e9.30.1741864750012; Thu, 13 Mar 2025
 04:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250311073438.13428-1-clamor95@gmail.com>
 <20250311073438.13428-2-clamor95@gmail.com>
 <4a07ae63-4f94-4caf-aef5-68db27d0967e@cherry.de>
In-Reply-To: <4a07ae63-4f94-4caf-aef5-68db27d0967e@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Mar 2025 13:18:58 +0200
X-Gm-Features: AQ5f1Jp9sDCm32rEcqfjUtYLw3g0jpskz9hFF0tFUFmWwoMnzFEgomFkhj9tcxE
Message-ID: <CAPVz0n2NWaudKBR_xa_mzDSLS=Q3BGzz5Gc41BceBBcgEzOazQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] common: edid: update timing selection logic
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 u-boot@lists.denx.de
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

=D1=87=D1=82, 13 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:37 Quen=
tin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 3/11/25 8:34 AM, Svyatoslav Ryhel wrote:
> > From: Jonas Schw=C3=B6bel <jonasschwoebel@yahoo.de>
> >
> > Older EDID timing algorithms relied solely on detailed timings, typical=
ly
> > optimized for a display's native resolution. This caused issues with ne=
wer
> > 4K panels on older hardware, which couldn't handle those high resolutio=
ns.
> > To address this, the algorithm now also considers standard timings, off=
ering
>
> Just a drive-by question here, "standard" as part of "from a standard"?
>  From which standard? Like where did you get this piece of information
> so we could verify, fix or update it later on?
>
> Can you add that as a comment around the array in the code?
>

About Standard Timings:
https://glenwing.github.io/docs/VESA-EEDID-A2.pdf#page=3D30

Standard Timings are described here:
https://glenwing.github.io/docs/VESA-DMT-1.13.pdf

> Cheers,
> Quentin
