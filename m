Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD24606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x8E+hmx9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eGEHbu7L
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3682C407E8;
	Thu, 22 Oct 2026 08:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RdahIwJnpRZJ; Thu, 22 Oct 2026 08:26:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74EFC407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657584;
	b=UYsbgKIgZS9bdcg2Jvnz0SnnKglHGvZCmdx/6KspfYDYSOiAMk+3n89+KmAJEDMw5Ere
	 IvNZifY2mC8XJJEfB818VOy4xAprT0qAM5GR45XamSYAp0MLZOr+8KT2Hr5x8UYdt6RyL
	 OFXnkJ4B0B/43yoFoaFu4a3DX9Qu1oHnIZUUOH/jq7rFkZO+IfKfJiTm6rVvktX/1fYud
	 voyLekh8wNcQFGDPXPLEAVEftl4/toQXQAz3lopfLdBzYEI7xHypae+j+qGCh0zzpvEI9
	 BmJGGgk1rDQH1x7VbEFbt6tYCRZzyYfk7ljanUEGnR8oroZ82/QUOZJw7lr5c/6mimg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WdgJzS6phijA1AcOPklVl1RJowss9wrvJh77BZ+lLjk=;
	b=NI04ax9FXx1dtFYLXUqWxBQIf9cq+zyYdZ17/nXGG7eZbRv7vVj2ICJHIc5fEh2iPzrN
	 u2VxKnyEL79rTXbFFxLnekKpSpoaPUjJkLv//1yH1RaQSb1m/uvVVLxNwUbAEvo7uwBhU
	 G7X8ZiKbRNZpuLTv0kDJ+KxBp/Jm6WYwQtW8p+TXF+b6VU+xRhhUTpTOZt1AupU0Qmx+B
	 zajdTxjsIq2wGfOcZwSNwSyFedfq6pukRO19e9VYxbdeQu+VSz992rn/wfwhlz3Gwy714
	 JImVmQdGYINwHGGftWSHqVS9l2yj1YdGCb9FyLNocwuEwYzlAbaegRh8aqF9BcnU9Qg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657584;
	bh=WdgJzS6phijA1AcOPklVl1RJowss9wrvJh77BZ+lLjk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x8E+hmx9t3uINokRJgPpfs23rq+NVSnj0UyyS4hM/qarB+ZJI6aoEVQs8sx5ADg0z
	 x9FJIDPjmI+DCOJy/UWd1IPnobDI9LQYQQsaE6tD5Rlz4ONryljYF9tpSv+g9Sb2YD
	 tk/C+DIty8Qs/2NfiDkfIwhZzlsJQVhvAFKxRw2X0n8XNk4i8WFpNaHLrQx40ocIL6
	 8+0bJMshziUNKylzxQjMks4GMugL5LPh+Y9tgkeAtVcFBwWWMrjzZQ2kWhpcJN3S1r
	 Shf883DdXHYsfcSElg4Ho2Pm++hW76tZLiW3JMvNkZvvVgxdYB1swdKLEYM8+yWRoa
	 QZrxI/S2w37aA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74EFC407A3;
	Thu, 22 Oct 2026 08:26:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FC4A235
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4102960823
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qAmxH-_wWBJ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:26:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A15776081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657582;
 b=Skmh679viJfsLY7q7Hn2A7bTEYHE40OliEmadY8XRhqDEq2sephjDPS0+PlDWTLYp2sw
 PWl8LAi1EjKJ4DDRuHVBxeuN7aPH4PAWNMyG6RCJf3uHbvl3C7tGOXM0uGAOMa8URToQ2
 qYN6ENLh/jjiGFG4NmpmdY9KLFjXA6Otvda2EcMkZFPPVqYMmcMSbOlw4j0fQNhTzzUQ+
 vRR+IdLInsyEb6DNRMvkvpYdhMYdrLByHcfWH/aZQ5KVl5HUt9oUs5BjHSfpdCvxWLfxN
 RQ68Lj8sGNEmqmZR5hbvlOgZWAruaBJzO8l2U8mQHrd7fSSkYibswS7IsqNYsQ31TIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657582;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=WdgJzS6phijA1AcOPklVl1RJowss9wrvJh77BZ+lLjk=;
 b=S1y+Qm/Ed8hoSSOc6e/swCJ059GKlV4OB+/iI4VOnl82kj/4liiVYMDyU1miNXwB+ZaM
 SIN/VijAo+9OkGGqaDKruLHxdVh3EWAUWK2LZSsMNW59IT6gMLCumi2gHhD85/CfX2vWB
 1CA1/kR7eJf/0EjycYUoJDVJhJd5cOrY/3Rl6xvVW/f7iW9OzJ5r7bIUo7jqsMWTjvN2E
 UwFYD/T1VDwvSk2kFdTirv4aUqAiOoIE9lwc00yTcGRLR7mMTZPD/+XuIOwA5fJTDXKqt
 EYLGJXQqNqBcHMf+LgjgQzzwt+pMlYBhvcb7YoxOFOdCRY8w/WfB+/ZjSuP3v2GuLig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eGEHbu7L; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=eGEHbu7L
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A15776081D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:22 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e985106c0cso12679745ad.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657581; cv=none;
 d=google.com; s=arc-20260327;
 b=N+nPkwAiUYo5b837ulRXWEy6BmTNamOESPy+0x9GvJdDlSj0J+0XFnYd4ingve9KXH
 GNsMDfjGC94EWw0St/I1jVf/HyUTHk5exGXCQEpnvMMX6Extmy7jB/1TU2aUHmE/NAar
 K7oNMjoSQVHkvYB64eaT8/D4uqismPCTwYIhekyvH3Wx/xOoEAO5O2NIA4JFDsdgAmt6
 5bOPboL/mylXSWfbzENiHCH9YeiCsLUDObqqQo4AU97zI3UnKagsaY6UOg11NUWHOQom
 HRfNjnxUU5EpEiV03i8V92857KGI/B3bIyBPq8TtA8tTy6qqVkwsA8eFqnoD+Uaos8iM
 y10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=WdgJzS6phijA1AcOPklVl1RJowss9wrvJh77BZ+lLjk=;
 fh=sTT9yvk3nVYKMURWYdZHx/nsQrhYL6cdvDujdPOrUIw=;
 b=OEezCUlACkVNXwZ46xiie5AOgEXyeMsPJhO0E8aFopCdWVWS9ijqRYayDFuI0Tc4/U
 bgwvPIun5r+OrSh7l4Xorezr90Ag7bSaBkoJBUHh4QpfaXUsp7ogiNZyouBSPqYIw8A+
 vt/xpzsncM0JBaZM/umdOB8ZWQvj8o3scxMnuq1sqbhczbPXcGojavtawRc8zt6lQsXC
 Lh+qCWGocsKzw6a1h5PFKaaqFZLZJeEVaHa366T8GhZawtOtg0bQu9sp0NXqBPYi3tWR
 PW2E5+zgtEGAi9jvxRvXQdk/JvNLuiw8b97hSDBGoHBaKhI47ej10pJzbWkr+HzddSGs
 mbqw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657581; x=1793262381;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WdgJzS6phijA1AcOPklVl1RJowss9wrvJh77BZ+lLjk=;
 b=eGEHbu7LdH1JHM3Bise8OhlQ95KkmXavGCz8fI6Y9cra6pzqBQWpRKbo378oGEQ0Jb
 NRDav8dEBKjaBdoPq9Jd5ZkbGDCuaH5nLfp1Nd97P83gDrkyHD6eLg9tZEqVu3uxlaYQ
 dUk/07wbCfm2WHJ/K0w4wpbfatqQ9r7q+80FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657581; x=1793262381;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WdgJzS6phijA1AcOPklVl1RJowss9wrvJh77BZ+lLjk=;
 b=vVEsB7C1vKJ4s0PdsCmTt3ghRnfAhlgTgO32+F2Yz2MthPzrJNKKstGBnkJQ1jJ0UY
 QRuJ04juNpogqcZY3fjQKUNmwSsDf/LO9bxlOaVZrU4mTfPxtZ/U0KLOBK3acGBuIqqu
 iAXCvbS6jM6RfkeF/XHyxpZwPGGG2+wFiJgjSuiSlkgD589lbsDM7STO/EokRxXkQkw6
 pEmElLYcX6JduwNuQE6547pb89o8imuGg3dWfITebqcQNbbWH0g3K/zduaTyZtBmgwCd
 lWcoNGN6ZeceHSB6ka3B5z1LSatS5Czo8vSnRHgbu+XIDXrpIQhz/A3skG7vJvjjH1bw
 rjYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBys/fMrkGzL07s6wnt61STZ/HXX8+VrAwRpSPpJXCvdqIYB3sPvYX7FsCbhJFmjvlhMyJxf/h0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJIK6uTQUvhYTUi2sZyDkgtsdS2+K0pEZYKhvQQ9qAVpIeZTjDV
 S2Z+MYgBTMPiA/WbJLbg3Pm4L2PbN9DljAbXasSlEr6wNyhjNG+omNnVu6d/lpRbJ3mnkl8rlDT
 TmFZ1zOZf54WGRMHYH/olTzOYkb2d5CzfMFUO0tqk
X-Gm-Gg: AYBFou39bjANiD5xyy5swIfMmWGF2Yuo3keS641KtiVvvkNfsQaUC+VPlh97STGASyV
 RyjQ288NISQog6jJXojZUCrNfHV6Oi2zVr7uVfk2C9hHM6ZlhKO2pzXCQgucvhaR8802w+hCBg+
 7heFXkPoj09D7PyqJXCBnpH8Gxtp9uTFAYEUfKzcBmTLtOoAgll63vO23MQr0HUIzUS4HyJVGT7
 Xa3V+5rRYAsl5kBKfbD0gF5pPg/+niJFefuDS5OZ9cHMbHdpnezmS8iXBv5HLdpuL1+0r5p0hPY
 dEBVl6jCYZr7JRCz6q9P5wLTqTeFyQEzW7EOBCs3WviiVJadwb25k+poEZgW0TpQH2PsSpkjkNC
 kGG/DeiNhUNfm5bg3DpBDO5at8PaCWQ4JhtDF0+ssGSnFp+0VaE+JAE2+
X-Received: by 2002:a17:90b:4a4c:b0:3ac:8ee9:c8ed with SMTP id
 98e67ed59e1d1-3ad86ee2d57mr4182930a91.13.1792657581515; Thu, 22 Oct 2026
 01:26:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:26:19 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 14:09:09 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-8-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-8-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:26:19 -0700
X-Gm-Features: AclHuK_XZbt0ULhcN4grQbouQzuC-Nnd2tnHGKCR-J5zU4gbP7XejYnd523lZ38
Message-ID: <CAFLszTiU7hrDM+iqvp0WOVFdnVh=DW-sWb_9ytWOqGBqmjbAaA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] test/py: avb: Move mmc device number to a pytest
 fixture
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: avb: Move mmc device number to a pytest fixture
>
> The AVB tests hardcode mmc device 1, which is usually correct on real
> hardware. On sandbox, this is not the case because mmc1.img contains a
> fedora image.
>
> Replace the module-level mmc_dev constant with an avb_device_id
> fixture so that a subsequent commit can override the device number
> for sandbox.
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  test/py/tests/test_android/test_avb.py | 38 ++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
