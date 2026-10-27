Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB13606A325
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=d27xppNy;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R0iiVbSa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 596AC80DAE;
	Tue, 27 Oct 2026 14:36:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75PK3UmcJw6U; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A798F80DB1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793111799;
	b=PMgoYwqcEFo29YqL4+Failwo+/+e38s7yvmWzdSLnjcn8Ba1IMFkkwuKKisdYmhb5R9c
	 5ApyuEGh+yU/SooXY36r5+OVN2QtbRGJ2T311O8tR1G8VLxJfdLR5IUgTLwrLlWHuDIbN
	 XSBRyg8zZyTWJ0sXE/MXRhPkqFoV4o8TDcoBVMleNnWe7F/HE5pOAEECYBHKDdr4YJVZq
	 rKUgPExkl6BFBezg8a3AtRfdZ5JCaJMUaN4TDlof7cGMnn4VLwxM2/K/G0R2zFx0YZnsU
	 mwV5lQGZ+i4YgkumM/LA44zgdj4mWgGcR6YFB/ax+aV/rJR1FEUzPwhLIOsCDFQ1WXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793111799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x+S+4otRLJQwNxmqyaTfFNctSfaEuqsS5VbT79RIzw8=;
	b=bekueBs4I/X0kUEYLLbbFMILmdMXtEgGzVmRJXe77CWAFl/y4F3CwNyxlPhol2OUmNJ/
	 /2/2a16OuzhoRz62FK/9iILU0YiXVy7dRhOJ9Sw4nywqMCJziGIJtqglVBlb1cqFSSpPY
	 FhxSZW0KVuNTvHZiC3miaxQRyUd06JcPu7rzflLljaGRZHNtFa08m836mzFiEsnm4gY24
	 57NYijmmuI2W1Hmww3hc+Za6zcTHbUDfNDPxqdk6gV/YiiBjf8E7bZoLaZ7Lrc+5Ys05L
	 A5cX2LbABtvpNnBkZxo3UbbnuzhaBMfuo1MyVw98TFub31kyD1nwihyBd4jn8lT+vow==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793111799;
	bh=x+S+4otRLJQwNxmqyaTfFNctSfaEuqsS5VbT79RIzw8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d27xppNysvf19Ias8vabL9nDRKkL+3RvVl1dRBPGWGJLlqvwaY7qNhR68+h1W99p1
	 iIN+5H8Kld0V6va4iypJRXTGTr3egH3ND93MPoaJDTK3GmA/IykvrRueooCHg2PoRJ
	 eQjWJas9EHso7vSNQjWfsxhaiMFGrWo0WZqxHix63tsiHCdm6YGwx34y9+2ajaexNF
	 v0XBFsj4/OJnkXrsecuoTzro32LaNRD6EOqKgUQhBQzE8Ifwzzesz2ZJrSz7A9Bfo6
	 EnGMfrrI3EcIinxJhCW5W8963b37osMKXsp7kjTBv65N6vCE02ahCIbKolP7J/Kctb
	 l7dHB0fUeFaXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A798F80DB1;
	Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BEDF279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 015F160799
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8H2hGNbT017b for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E142C605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793111798;
 b=Jj2sqw8hmDGMneoqLLeigojobeFIGkscQ/3+iH7VHY/F0YuAqBUuMpjigPX5E1VmkVm3
 cf+yJ4XdMb74x90KoolskqNHPssttpM/mYGCNsEkXEb7UkJfCwgBf5jcdc7JKZZBhtFpv
 9j5jJCapiby2dURXf41vWH3lBQwAaVklhrdAZfzpS4CIzmKsurckmSifLqwXMyzntrKEI
 S4lLCKRCVrVJc4SAx7SAj0ZnUHdtUZHgD4YHpJyZ7wmtXGVY4ddddnpt4BqwRLmqj18Ie
 lRqM5x95MoAw5xvVmNkjhK8vS/11WO/ggQIY+0qE0ny/Vp94MwQbDchR19AHZ1QLtBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793111798;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=x+S+4otRLJQwNxmqyaTfFNctSfaEuqsS5VbT79RIzw8=;
 b=A3iko0CNIBpvaFbUitLdxFHn7bS0EPoH8sv3GSO3377AvA8w7h2au3GbtvF9bgP1flLG
 qRkw70qRD2usJi7OYAZJbGvIN/o3wJFyBmJOkjpuhkrSjgStOyqnCIBZ73bh59cHkIpzn
 BbfGVyengTjBvqv+ENJ8SRuRbnC4ge0R49lQh4svSo+jqIgxJJA7QXm+YMXntyYaQcp9F
 P9gGncWNVpfzdzf4EDW+CewDc7I8jT/UspnIB2lerwEiygOVsAaMSB4MEXtF3Yt1vhPLt
 jr8OSTFfuHMYxerWZRyP0Puj/lqeXEBT9Vq/SDUaSI7rH+cq80fG1y51mhzV1eKq4dw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=R0iiVbSa; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=R0iiVbSa
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E142C605EA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:36:37 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so6500927a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111795; cv=none;
 d=google.com; s=arc-20260327;
 b=cPUg5YOw/Gv/gkFTUJ3VG7xzP68frzeQ0e+XlkqbWzSr+a5dpE7hlCGfs1UqWMZL90
 rPGKh2qiXOxkktNZLXjw0cNR3YGcF0/beOr7si1UAGDxkgYUenDjgtfgzQmybmvf2vDT
 NHNk3KnLZ4SvxJoTnEXcfF/pnpxiDG9asZBJoLk6RIpQmvpCrexiOOpNCUXDfGtaKAmE
 NzTEeDT38GqSrH9EMBB0XpGjrdxiLuXX65QPZ0kBptfRmm5egQyucC58jqMLCHoBdQ+k
 UpMgnuAkvf/zDRlIKrDrRwx8zboai4nqEKagocbFyXcsBbaR7o/cleztmMcPMY/PMKFc
 mBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=x+S+4otRLJQwNxmqyaTfFNctSfaEuqsS5VbT79RIzw8=;
 fh=F/gav7quWbCtQQ6lS340BPp6K/yW2vNvsAiVAVCEkPw=;
 b=Kh7Rc2XcHQ2Lh1ZKITT954RT5+ZA0+n+DaZKba+StcjGozEQ129DWBtNwmRkSvS36y
 ZWkJoowUxbh4qR7rUaPOUyOi/Oy4nJu2BlgsRmI8TKWWvtIuU3N8anV3D5bL9w0ZW9tI
 yGCoA0/5vCMo46kbugAeQgLX5o1szbyLIUiWtA4hdhtPBn+0iS5KqGK1CR6/8j/tvjFI
 tuIH+9nJhGJTk3UUbbdcVNgtRVB7AIThzCWXqlr3xoVjfGBEsdHSfJBcBCIMhbk1DzOG
 7oHDyMNiNlSFZaxljT29W1Kpq8rmoyWCP2tQybCxsv5yzBvr8XX35g548eDsqrfUp7qb
 s3EA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793111795; x=1793716595;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x+S+4otRLJQwNxmqyaTfFNctSfaEuqsS5VbT79RIzw8=;
 b=R0iiVbSawCg5l4MYviEXITibkMvWb/9NxlqJ4eDh7WmnZjJLkZ6UmSBaPojXc/IW36
 lRp0U98v3OXO7jFac2j7R6dK++pPyR6zOah6VpCtTWGzvGaGeXfNz4YaSducFt4SuMDV
 JLZY19YRQK+wH5EZUGMtpylHkTcnD5AMjVUgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111795; x=1793716595;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x+S+4otRLJQwNxmqyaTfFNctSfaEuqsS5VbT79RIzw8=;
 b=sjyjsXl4uFTbmv0NqoKmrihsLbNWvzt+qGfAdu2clhvN8qzZfP/kj0IPFk5Ark+g9r
 NpURVEr/gynmljndGMYHkHO8kpTiiDEWriJLBFfF1CyoVsplkRPH5WqocEbBWR+BapVo
 0BiRggf6wi/oqR2CffRsP0KOTPUbn7PwhwG+ntQcZj/gGp/vLV+BIWgiP0b8d3GfB0sY
 2c0iBF9zP194bsVxDAuOvM4hIT7Ec+BKGDO4e7Cr5QkkVxRhAsa46XWZqtm5qneZlhC4
 lHPRQ7pnISFCUwCzm2/9tksRJ+DgHCNDijqO3H5ndjUQ0DzhdZTBVpPIqCdskxbW3iYl
 0hsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyUyvawyi4u7RPXJgyOEDlqsGRX0jLc3FvcivjA9BADW0w7XimAMDHrbAZMUBJXnNwUBg69P4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLk+2u/Ixr6tKRw2EvNoxo2tmzteEAQCsXOg0gvZ2SfodLBNE62
 /o0oLwxD8OZaOywrDjfadJSWg9CIJF0xGAJxARm5XiwwDVnceTzPbHzwRq9/G4DJpWtGqRsyGZy
 s9jT0ma6S37VV4FYNWwgORz0E8ZUbFoOPXdaZEp8p
X-Gm-Gg: AYBFou3VK5i/vhuL42E4O2zS3m1LPVyCTqbvT3k7GiWcTOSZEh/EuujSnheSRdB3Q6a
 Za3utndg5U6vScYamXdpeC3+8ED3eVpZWCMmw4vQTC5VxbqVJJzarmZDL3Url4qKtBTg8Xv4iyF
 TOEdwmGodwsC4TT/s6cW8bYNT7zWAI1U6HKHZLcL5mF2Vrf39qcnt/JULudyYl1PpOV3UglwtyB
 /iROxiNpVU1F5c3Be3oAC8PQ18ZpZg5xhDIBxnWz1XN25d8PCQh+XikvH/+SGxd7HGk3N44jRls
 O2xUHql4xpO1OdntgPmcbv3pWF8k/YbrzFFnBOgYw24X03bAABG3A7/QhmOgxWc4wRikRffEydi
 K8xa3AWXmc0BY3mq/dG+qbXxf6af3Rf8QyNc=
X-Received: by 2002:aa7:c1c7:0:b0:6b3:d0a0:2781 with SMTP id
 4fb4d7f45d1cf-6b442fe4bb3mr7062994a12.24.1793111795406; Tue, 27 Oct 2026
 07:36:35 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 07:36:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 07:05:12 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 07:36:31 -0700
X-Gm-Features: AclHuK_X92cQ64cTgCm2wkeX__iefQ-FX_oZuZ8C5549i80FVjFis5G5EuHSVVc
Message-ID: <CAFLszThpKsCTmzX_2ec047YsPiG7UQbMdf02SLqbhdCnyKRkUg@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] misc: fs_loader: reorg and split to FS and FW
 loader + FIP loader
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-27T12:38:55, Christian Marangi <ansuelsmth@gmail.com> wrote:

> In such context U-Boot is loaded as BL31 and the PHY firmware

This still says BL31. It should be BL33, since U-Boot runs as the
non-secure payload.

> Then there is the request_firmware_size() new OP to get only
> the size of the firmware.

One thing I'd like to check from last time: patch 2 still only renames
doc/develop/driver-model/firmware_loader.rst and makes no other
changes to it. It is still titled 'File System Firmware Loader',
covers only the filesystem loader and the /chosen lookup, and says
nothing about the FIP loader, request_firmware_size() or
get_fw_loader_from_node(). Please can you add a doc patch so the API
description matches the DT binding? Also, the binding patch still
comes before the FIP driver it describes, so it would be worth moving
it after patch 7.

Regards,
Simon
