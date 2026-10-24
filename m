Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bk+w94i8;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hTNpPZG1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFEC4815DF;
	Sat, 24 Oct 2026 13:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ulwxr5YZ0XCA; Sat, 24 Oct 2026 13:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09B0F8156E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847006;
	b=S8SxV65pRtA09M4yhtJ87Gi0/ornB24v81jcN274U17O4ejzSjwBnomVqisW1SSAgOtq
	 nPg/k6ZQ49jv0vW/VkCvTJBPIRZKP1pokq+CU71uhY9IiOn7+UCGm25vjWBxxOpiwE/Yf
	 4KnkdtGwgxvz8n1HcODCSdQ6N5pU7OqtuBAWLk10QSSwFGgFGv+apqjtXKFWLDWDYSfSV
	 r/jq+uJoCqmMU5Tqt3PInITRGERNQUh+nBf2aXmQzDDO4j+VEDq00nZbL6+VhNtdMb5nk
	 FJnVbvX8UZVyg+JDsuaCO0UjqX7qv/bL2M1Vcp3PNGZL7lUEbv1Hne1a4wJLfkuBKYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bAX/awPQGR7EiezoovBTR2SxfEFFOfpMR9XA5C3UmrE=;
	b=VUg8Bc6Lich1fDMTENKyV+UXD12+hXfiyqhDXAOYyonSwZFYgtRoM9JEuwNMxVCqJjZ8
	 xGcN870v2ucxFCDXD2qLXoe3gtuKoS6cbSjN6XDBOFuzqMbDLC+fQoBTSTpDj3L/feOvD
	 6dL/Z48qmXxrbjXm/r8iKSsJUlllVkK8h8cEvxi6ONmD/m5ko9xsw8KHK2MVQSoxHRsk3
	 xiXPEhr4zypyrEv09bO2RVGmVsoiKBpzo/gjCM6Mi1qZn+Mon+ScPRE+vPEEeI3DGrPKS
	 9AT/eiuyMFrQ/DexDcTNV4eBaNDiATlnRV6I3YdKYamNgnzL0rK2VBGSi7h/nOBin5Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847006;
	bh=bAX/awPQGR7EiezoovBTR2SxfEFFOfpMR9XA5C3UmrE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bk+w94i88WMXQeJd4mq2S1duhEGQ68wzDg4rfb7yU1IIUO6fJ7FfM1alau5KxyWK4
	 1jayIBncnmbjWVyK8KUlNuVXhQZaKz3XGjCMf8Ku8ZAbG3fvHu3myvK8oW77URUGeg
	 e/Lna1OVUxPfsaUkzZ22+o0a921m4CincrE4F49ccNTjPeSNPodt4K4YtTHlMCRc5O
	 NrNRBSZZi08dcxv5zjCXAxR+hicxRPRkKG1uWW4yEK35IRFCvLabDUoPmQEfPbeopY
	 r4KuL/JZqcopnfulYxBKm6kr4pYit8CzCV5LGArR1f0Fkp/OQHyDceKPrbubwC8uzZ
	 0ssIucx/e3/mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09B0F8156E;
	Sat, 24 Oct 2026 13:03:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DADC94D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C061960A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZMZZWJM1oUxX for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:59:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08F6560A4B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825193;
 b=hc5RpED1wJjalUBSyjZZIV/nhLJ5fyiGIh3mrJLpIQ2m6AWjYzm49e9nIaSMFajU9X7h
 7qViGaXpGIVRxSSMED5dmEMctGoF08jpn6Cgvpa70GUp25qPG8BCaGyOTD3Azdxm+xzdT
 itei0bHsT8iyH+5JbaTad+HgtuRKDwtEMg4655FfO3kasHNdXOJesy6RWYNavK722YQmu
 yUZuypome9S3cPVRFR6JZYKzlvixKjCCdlmn/pSMvWqk37Ak9bsqH3+ym9epDcvjDt0dg
 WeMjFrEQHTrGyyrJpQQ4b9cxfbb+ICfNLbELcaJeK25BKWDJUZvSP9ko8FRqJsFg+wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825193;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=bAX/awPQGR7EiezoovBTR2SxfEFFOfpMR9XA5C3UmrE=;
 b=N7vhNe2bw7xAVHKufjRN4vEH3hzB/HUAh0abdnHninL/Vb2ChJy+25BGsM4OmBM5+2bL
 sLhQFgLLg09BNdnutxWkTT+kwTkMbfgX/0lLt1XGeBCl6DsVxUQOc1DuXSgl7sUZ5SOUj
 1QCb/g4c2i89vexs2Lzs+IG7cVvCzq3eNShFVGhsFbxKERe5hqJ7Wiswqe9XaX/S1LeL6
 mhSB4tg3MXkPK7xcNLHHkT5tWWxybF02EeXhvUPF1FFvYwb7ljEVYBoJNpiI7KEKdPYO+
 J9bg9QIFW5jMPYHEsF40kUH5PL+mr7DmKg8SQ1JoZcx5o1C1UVBgrzYiYuk1rfLZuKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hTNpPZG1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hTNpPZG1
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08F6560A4B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:59:52 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ac677668a9so1894644a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825192; cv=none;
 d=google.com; s=arc-20260327;
 b=G4iE50CjDsMX4SueIRqtqnEyzMxnO+cU7oUor68ffLleVBHv/2MKMWO0M0tNxloieT
 M/I+FNEGZ7hPFKrKyUbKpfak8ErUDyPUTSx9O1aix3nfjKHrXsu+V/hk1cSbn2HUAWX9
 oeE9M0p+Xb8e3S/4jOU7O60AfzFhjiioMzBE6uDjTvlY1QpG4detV82NTKcrFtjxSeKv
 vKYMonMwig5RO28DYIrYuMA+tHrwX+yQ9PSc2ehW6ElaBWsN7Lf0ULqYSIXeyEgA5ER+
 er7H7r5WzPEu/0AFqLvL3G4Q/lSK4MET1HgJh36H7Tbt9RL5TgcqH7CSkvPBB7+Vo35F
 twig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=bAX/awPQGR7EiezoovBTR2SxfEFFOfpMR9XA5C3UmrE=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=FF2tPaFRUfE+3BAJgJrJktuiohpWg65qUEmXbiTRb4sqi3Db8nKPr8QSkQQQDikQ/3
 dGN3nE3wZD9qRfqA5Xq99TipcgNW8Q8nfiqizcnR9dunjwVjbts0X6JCVdFcX87BON1K
 mSOMkkxuk20eUhnohp+DlczUeKBjSbo2xCdLSYZiVSK4HcZb8JwAJEvcAU/o/5mZ+wD5
 ae8k60LB+9r3P7pgX51XCwv1cQxBsXhLC3wzFnA63sF/2UCzJzWPjOaWQ5DIelmFFJN9
 67PNouqjn2aueqYDY0mhDUzNX3SvcjLeGdAdOI10aRrRbFWLQdOk7aEwmoXSB8sfRHFi
 EVEA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825192; x=1793429992;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bAX/awPQGR7EiezoovBTR2SxfEFFOfpMR9XA5C3UmrE=;
 b=hTNpPZG1WKL+024uiDVunVSSlcjREMtjMjmwpL+q8bsO4xJN/asytXGfi5NBlOpQjM
 mFVCmhnWEg2uKqOdljhp+WgYngoAJxnOKGhzO58gV85yLE4ejXZQ/GI/kcHfH3x9TLE3
 mkhWxchKaTyhKEzRWlip6QQEA1dJMMBMbCBWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825192; x=1793429992;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bAX/awPQGR7EiezoovBTR2SxfEFFOfpMR9XA5C3UmrE=;
 b=YE5DGjdIrkzkx9/UFcUDb5hQY6Cm2uFrBFLkroySd2JENaEMWkbPUmB8goVb1tpyQm
 Aiv1OtAINRz0Jc+DYuMzgUOMYODO7gmxX9E8R5AApiDEU+CM9HbxCg7LZRG+gPbFndaN
 WmiWpwcLTffTk5bIIlHGETMFWxrwcvWVQjMmzdLi3m3GTlB5URr/d/UxSa/6ctOIkZsc
 kkdieAJ1LLawk9XTKJs4JhG6SS0szUH+g9GtVRbfVwcIawWph3DSJ0ArKq+mou3bCyVf
 jxX9Gk5IQrxvR7FNXzhyANm1E6kyBLX5pT2uaoETuGyk1IbEzP2BnOtLgg/wNFjLv58T
 h20A==
X-Gm-Message-State: AFq9FYL71MVpdPbKPkwFvUMPKnZLJ0QioCGOLb/eTzLZaHJCn5y78JpH
 szvRNxIpHwLtgFvOpbukl+URa5SWan1YF3x/oSizXJYBjOM8M+G98DogVlxm94cdvioIDlJ9j7+
 k+rSV8PrtAKf6qbYb6izD/ExBALJTzpNyyF1bpw2P
X-Gm-Gg: AYBFou0GOP954dO0M2sGt7Ofe7LR/itP6QdhAdWrBIaFPPvCALz6ndO2slw/q3tb3TQ
 SZXoWdfPryOj4B+F71ry9Mb1S09Mv6+XaJ96twfKQ+uC6R5FOpBDtQ5tV8Mbe8e2jomx3WA8ed2
 AZsrJfTnCcoXaL2Hp/KgWlyTiYMtmtUVT4VqQWe+sLYrm+esO5yt7rQQLuJCVlJwZLiFhIJ5YUN
 QYnEvV3/Y3BGLLaKzU5KhDuSQVoB7MpflKtuRX03M27jRV8wcZ0fObcVHKJrSvgHJen5dj4sLmw
 7KYPey879cXtYK1DAHkdCTIJfcZmD4jdWhX2z1QZabRPRbFl9Hwkyu/vch2IelQBaVXQ4CBzW8b
 RInoNjEqlWsrzG/PLJM/tjpsAkAlMoTElGd4=
X-Received: by 2002:a17:90b:2789:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3adea9d6152mr1255491a91.12.1792825191995; Fri, 23 Oct 2026
 23:59:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:59:49 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:53:52 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-1-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-1-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:59:49 -0700
X-Gm-Features: AclHuK_i0IO7hdtwAbhjB--rl15ghaeJxuCYCXHCzZp2AnrRhieaFhFbK8JCiKA
Message-ID: <CAFLszTgW+aNzqyvDHWAWUFeMT54=xV-11Tg18rZ7EtA7rTgq-g@mail.gmail.com>
Subject: Re: [PATCH v3 01/23] boot: image: Keep the image-type table out of xPL
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> boot: image: Keep the image-type table out of xPL
>
> print_decomp_msg() names the image it is about to unpack, which drags
> uimage_type[] into any phase that links image_decomp(). That is 650 bytes
> in an arm32 SPL and 1266 in an arm64 one, spent on one line of progress
> output in a phase built for size.

With SPL_LOAD_FIT_FULL, fit_image_load() still calls
fit_image_get_type(), so the table stays linked and on those boards
this patch removes the name without saving anything. Please can you
say that the saving applies to the simple FIT path, rather than to
'any phase'?

BTW the v3 change log mentions 'a helper shared with
load_simple_fit()', but I don't see the helper in the series? - please
update that entry to describe what you did.

>
> Name it "image" there instead. U-Boot proper is unchanged.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  boot/image.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Regards,
Simon
