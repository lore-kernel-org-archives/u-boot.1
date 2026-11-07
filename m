Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287F606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u9uJbm/w;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=sJDybQ75
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA4CF60608;
	Sat,  7 Nov 2026 23:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SvbtYAS2Ht5; Sat,  7 Nov 2026 23:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA9BF60609
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794095479;
	b=GQ1sGHDrMuSJgOztjZbtTYsr4DEDYJEevDjUavTBxoUzXXY9Qr272hf+GaNZu+xH+ud+
	 hv3NNTQjOkD7U2F1eHDuzjghe//gKLs34nBlVHCUzpCWRNEO/TSoKwmBsGw7wHT1SXAlq
	 4PIEsLoqKrSmSF5YSBcKdpOZPK2Jy7s5xIrL6ocsPPy+cqDu4t2nPfV8TOcb+YhdRb4fc
	 EeFwuR69yXzn/9mvSQm997ntyMHGU0/CWN3//awUuMUwp8d2LR2n4bMJZy70+R86byO6n
	 zg0BOBs1AD5RmxAWeHRwq/3CJ+BNkyDBttDjHk4RcaQQKTo4jwJlRGDn03iD4bM2PdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794095479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=iOircpBK/2STrHyB6YFhHntSm+panJkltXHKd7EtRHg=;
	b=f6VX+hf75RrxjkGNp91Sbf0UpULepSvivrLFFO939WnvaSfqXHWBqal53wCxVGLVKx8h
	 FjJXMKupq7zOa6jj8RPhf4a0tOHlpl//dx3S3r9Dn7SnTmynxFYTS35yoMFOD8ZcQjlQP
	 XHxFPPkoYIs1RuDdly9obOvbplsyuz3nO6itPLClwvvt4oKW73gXHB9UAWCrFrMVFeCXi
	 p8AmvAMA2bVgNjM40lX9gxxEl5c7AkFNxAmS8StwkWT5dq5hM26jrhG3s8Pv+67Eu0uRJ
	 cqjOku9q4ffKsRiWs8aUSc1vgCB4jVoZsU5Cs/jnh8dQVtL4x3nJ3A0p0gJmzFGcoNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794095479;
	bh=iOircpBK/2STrHyB6YFhHntSm+panJkltXHKd7EtRHg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u9uJbm/wJXMQUu9QcjfoywXv+owWV5h1lfY3N+UGM5dRjUTiS5xkco6CNMjORULbH
	 Gmxq2vdWEanttJu+Q9DmmbSsJegDPVsegsfndRyv4tsRONJwjhgGk8DId48zxOEMew
	 fvM+sLnUX3igc0glbuSyOvlMUIt9vD0+WtsaV/7FUWzCpu5Bf/diRJLm7idoIq2KBC
	 2je28QNmXtIufW1pJJHoDv6dhkssm3zFM1LUZ8tC0Lq+6Ej2ulGcEVTVqWTOEcu7hb
	 OeA+4Lk3ONcwkKZHNOPv/bBqtyMHdmxUVsi+9NSCWrAzCP4IsecpFZypD0vD6paBxC
	 Ywy39MdkusOww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA9BF60609;
	Sat,  7 Nov 2026 23:51:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 34120422
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 253B94064E
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2EsvIJ-U4pgo for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 23:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D311405E3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=sJDybQ75
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D311405E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 23:51:14 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-545a4fb8d5dso74802b6e.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 15:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794095473; x=1794700273;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iOircpBK/2STrHyB6YFhHntSm+panJkltXHKd7EtRHg=;
 b=sJDybQ75kzI+Y/FpOsMNF2jLMboz9dNejIayzeWORDxE7MADgYlXB/9bSaSd5UnR2I
 THhVJCDrjkkA5J2/qgcuk8FD3A+VIYlHI0Q1P0ZIVz8qyD+PitZ17nYEJIUGcxS2n2N7
 oqM1Ea/9pr5uEgOswbMxUE1/cBDD11X1Ahvjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794095473; x=1794700273;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iOircpBK/2STrHyB6YFhHntSm+panJkltXHKd7EtRHg=;
 b=d1mPiSqcG9gGqCnGWoo6+dFLTtJ6NIB/bVggukc5F+3TjfNT37h+Ch6JBE5xf5Fiy8
 vq1C8SgOL8whZuS+QpzBV2sBJF+HGBMTJbg8GoyHHpRPe9R5X2Eb7MsfwyL2Lk1A1UKd
 YZaJ1ebZfL+kOJfup8LvkpIdYgC9hQOsODGG2Btp8891gHlUZAQMI6HidHwVS0CHz9r4
 sfMVULYbsesREZiKoPWPRj+TpKVND4M1c6+zcCRwMSKTYoxZ/kcj88V+W4eWujsdShLY
 57Gl0DwJNnqjxgT0UHiFLdk1Mrvo49Z6iGv1wt9MHIyzOAW3+RW7YelrxO7qxDmhlJoj
 so6Q==
X-Gm-Message-State: APuU4Z9yzoTPz2WyLJgz2QIc0WCxvnwWmlUfAqfFiDWZCg/gxVa2x876
 sFe6Ulrt25BoJUnkxu38yphucjtaqOxp1QXdKTi0rk0u9GHI+iUeT742F5E9SIM10/U=
X-Gm-Gg: AYBFou3YicxetV6jxkj7YVVUck7CIOn9bxtBV/3rx37DXi/1iU66+mB2gvnrLOScREV
 Gt+EGCUcCESiSkeaXInvFSqCh6RB4TCM6D3c2qGSzZnEtiBgFV34WmhSipNWSQ+kdwqr0kBArJI
 6s5xuXJA2uxe4XxUtJHH6mlyWE7cdPE7xM+diWmzPW+hSJcPzYieJ3uRX1qXlOi5qI/TdyND3cZ
 EbvQjtSLnZdoT+v1j6/jEuk6mL+l5chpW697BGT+tfiwF5A9uklGIHfKhyBLWhFTVictKJrJMct
 TVjBu0VsU7wpxxYqK6i5UueJZBDySuUNsi/HAP1g42taXFgZSrYE9nAxrmY2H8XzFfOZToPmvuo
 /H9J+9Wn9dw77E0JSr0M891hVKRuH1mb9cvNGqrESqIodrZbDFyY98Xf0R3V7TX6Qf9rCgyKIWZ
 RwJ9XM1J5dvVilYUN5uYa+mhBCK5s6RXSre4Y884fsRUv28PwW3MXpOPHTQVw+llhJmucvKuk0L
 /cmbAN6xl1UqdXOdpms5+7tJqCGeA+FE+sh7iuXJVSR8GUPGl6CAe0QWcnziRNawDEEYG52M06z
 BCH+p9LN+hVb4nN45Ky+c1zL/e1PUvH11NKjKkTHMfmUlGgjXSdFL93RDdL0VcW0PUWoDeZdb5C
 0bNHsBsquDlAG4Bvrgk9gXz2p69XRkvnLej5uJkl/mup8Xc2xhmVR2lyW877ei8bSIEhxdXdvBK
 GEu0o//ID2V5m0bn/VABiDH6Ms5as3v6ljRglw18Ro/dfhzdmxB00=
X-Received: by 2002:a05:6808:c2fa:b0:4f7:8bdd:b74 with SMTP id
 5614622812f47-56814764775mr116674b6e.51.1794095473568; 
 Sat, 07 Nov 2026 15:51:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56813c71b08sm357018b6e.3.2026.11.07.15.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 15:51:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, atul.akella@gmail.com, 
 ddrake@baylibre.com, dario.binacchi@amarulasolutions.com, 
 francesco.dolcini@toradex.com, jeremie.dautheribes@bootlin.com, 
 primoz.fiser@norik.com, quentin.schulz@cherry.de, tomaspaukrt@email.cz
In-Reply-To: <20261107175452.9295-1-festevam@gmail.com>
References: <20261107175452.9295-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20261107
Message-Id: <179409547145.4185375.8527554179552809895.b4-ty@konsulko.com>
Date: Sat, 07 Nov 2026 17:51:11 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 7 Nov 2026 14:54:51 -0300, Fabio Estevam wrote:

> The following changes since commit feb8913982e4462c01fd914271f92254a25dc101:
> 
>   Merge tag 'xilinx-for-v2027.01-rc2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-11-06 09:59:06 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20261107
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


