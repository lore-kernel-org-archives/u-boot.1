Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D490606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nQMEsPNw;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hrllp2sE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B4B060AA5;
	Sat, 24 Oct 2026 13:03:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hrCjeOEkWtPq; Sat, 24 Oct 2026 13:03:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79E8660A98
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847021;
	b=GW/oHqzBIcrDnYIqCou4JYlE9O/L10wRltv6NhLpU4wr94PJuQfAdGFHWPaIHPjCOhIz
	 uJRJOLmnvZ/xEfMXu7YTMKZVCDLpYWDvL4kMkuKgif6woifG3LbV2x3nacgjwXveKXc1L
	 foNE0QZDzt18TujSIKyQZavfb5lXi+Rbq0Thmabj1Km64kxN+rnt66J2mpmrSnJnNECiJ
	 FIGVmwsnvn1rV1uo+1xEvAjczcSsIuyLOPiTFaFMmMI33S2Q2RGzIoMFzfTYTIFdtoWWM
	 1ImKr+KsSVYHnoAHSaI0WXKTm1aTuF8/hijF28YcNZWUR4xhPXv08vyWxAbpVCg5RjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MwRN/afNrotbt8IpNJuEvTx2b6kCxw1+xy1cQgbfe2c=;
	b=SE4mZ1Vi0za6ThiwpSN30TLPAFDH03FP10AZ2ZDbF6XKMZpqf0ldFA35saxM1poccoI3
	 gvZJ3G4oOQBzg8YbQooCsmfqqyn28BTb8jDBeQOPIn6TtpcKb6iMVzDKu73nNKpcWpE6/
	 vIZ2XdD9jwWjkEHgfsCbm1tqYRVoSg4dDMwl911gZLHreluF6Yth2IxLYuJBaYgdLb2me
	 hBJYJQkXZmxl7bNFfsRQxuOdRBJ2vJFWIIsGDaGIBmGTW9fjc+1UxBLorQ5doE/eDCuLz
	 aCazdipq8FD5HEhh5QUizS0sdJ9CAZrcQYHGIc3Y9EtucQTAAxbETToYxTJQz4TT2nw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hrllp2sE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847021;
	bh=MwRN/afNrotbt8IpNJuEvTx2b6kCxw1+xy1cQgbfe2c=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQMEsPNwfq58KMpn9pVhw5pNIgzigUjerUwlf62VqmwqRNaiJRFj9m9IawctGkU3r
	 TLhZaHQQh4opM2wmeahD1NDRwwH6ZpWFWciaVqZHDVCMPyeZkOclhVt9NWpPfBcRLN
	 427mnMV2sRKK8gDR3WFFxLV901TZtp3Iy33zB7zoG7t6KsrD5+jKgrg+hRHzhHXtC/
	 +9t0OgI4XN2H6FjoQpF6FjdjFCBBbml5VSRK8XT1xtmBc2uqpfhJoHhEhv1tSvu0Tc
	 k7dTFCsYe+2p6big1orQmxfsjh6xhOucJa8+Pm0rNDpCifWn30wC3MLCo8mc3515kn
	 +qklANd6w9NYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79E8660A98;
	Sat, 24 Oct 2026 13:03:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C80A2765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADB0E60A59
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id djkQAu9sNLxR for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B929260A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825228;
 b=P3wHnWgzJ3hy5R2riZkLGb4Jp5ja0xEPTNiXqvqhSyNNo3pA3XRKZxDVXj5PN0Kjd2lQ
 1awqEcEQEBktka3lWY0p9LLu1EHnUrFWfR5190quKhCPEAs2ZyLKoVbTfg7eiWLXVMH+Y
 hv0ysCt/ZvYfnu5xsyyEG8JaA17tTVYSlmFRBJK6qPmwy4i0eqDrIm39ceiS/YD5IcHqv
 zPyol+9wcpCvToLALiIr/2/Dlb6rjym5dBxc6lCMqwoxcnTenA3PlCDMBfGuk2GsGpS7V
 R7/lPDNCL7Q+u7lsHw0NWGqaj4rREdX8eHBJVuHrhZ1Gq2Ms5w4L4BhBqqVnpmVSVrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=MwRN/afNrotbt8IpNJuEvTx2b6kCxw1+xy1cQgbfe2c=;
 b=K2yEPNkk6wPVTMVjAtHguCwVEXoU5UnG9zaNyLfjFaJL++26R9vV8WB2oc3SndW94nmM
 Pe0eJdUqJnkeBD2oUxIfRVm1FROIWj4BeaFr8jlELBjElU1qS47OnwRv+/9gpW4EPQ+q/
 wP1KFR+J9UOwaNpGonDN1RGLSwoTuqrO+gJ03G0YUBiCLLV9FgSb9ExGq6vJpcIwnzJrC
 CaF+1YdYJ2+T2SWx7xRq8MXoo2AEQlWUY4B2Bbl1TVeYktPuVpmxPcyxVgtkZMbLY6tbB
 5wp2Np35iJL5TU+b+41tANvsN7wW4pIddSJc1gc627wNNg1u9+7Ps+AOJ4FyJ+C4Jug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Hrllp2sE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Hrllp2sE
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B929260A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:27 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b2232d8ef5so2552018a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825225; cv=none;
 d=google.com; s=arc-20260327;
 b=fnOOdGRDstvkuXKx4OIwS4QF7f5dzuH87u0bK5mnIQLPov/l0MOY0arXD/Opk2o9UM
 6+YZTy28kTxn7hfAjHrjdKi/rRqf/qYqNrSiKlRxdLXpSxnblCT7FepVFrF9bCSCdHXo
 ghrOH2VjEaBfu9C6+Q2PJjC4Qq85a1+4MCUp7t9ufxlpAMND12FmD4bsmcjUQC4xCfyZ
 9o1GE1Y98VCiJt6t3iALJPLiwqBnMsdrlIixMe1xKYHmJyowKoLSs8qAlGOV8Z5BAL8m
 pFKel8uJnS65NTAkNmwpfjFr6jFjO9WcPLbSsQDU2d51wx9HPmmXhSog8oNeQonkKPy6
 GEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=MwRN/afNrotbt8IpNJuEvTx2b6kCxw1+xy1cQgbfe2c=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=jG6ygJ+9biMTRUCzkJHQTwIRFBjb5kyobgfgOQ55TaBcRmEAXNRU0RYkg+IKuHoUUP
 0YJuCtILYA9atahmbKIlGonQSUhzC5gVe5XzaHoYuQcoJnrTUgRUTw2Q3kuY3B5HbwiE
 d5S0SH/D38SD7qztGMdkPaYCa6CxqZN2VEpaFPZTeK3MEAZ5gjqBBWYAMBdqypW1Epm8
 dlwp4D+vzxt/F2ILSbjFe7AEePXv6CG4Dt/wmTL6V2ustLhTYz9FWHyyEUdVVBXFH+qU
 p4xGercCB2XaP3wSNWX6O0VEjxWz7N3szX6N/gK+v/hTBwjjgf7UYf8Gq4s3+Jt+bhb6
 myKA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825225; x=1793430025;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MwRN/afNrotbt8IpNJuEvTx2b6kCxw1+xy1cQgbfe2c=;
 b=Hrllp2sEUgrYoDZ/XvPrsLwVDOLlA+GlaXTRTGMCtg8UmEPgSd8XSSoqz8RU3o+EW+
 2RcZ4sn73BwPTilH0XOKO7rprj1c44cmYNJwz3Hh0v9Ql3NyDAvkeH4KUuhG8o5+xUOk
 zzRyxt5QYu3PCtODktGwfMbYQb8AeiY/dHeGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825225; x=1793430025;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MwRN/afNrotbt8IpNJuEvTx2b6kCxw1+xy1cQgbfe2c=;
 b=ykME8NWhC8NGxMhc6ou22CR9uDMbnRBxipYONazWfDOhgJdX6md/GS/RP5Ie5Q+BDR
 sZtPW1Ocs5RoM3KsqzTSxVnOVy8O6KXBGQmHJaGWl11QvgI8eR8HMGI8pS04aVNIVOlg
 yP+I9jtsBxs6Z8wg+jofrj89wIab31RXoCgdryuMBRHxpnASiiBzVmwbDqKZrJj9LEK3
 Z0JoSk0nUeLYE/snsn9fipjJlp15US9Ejj2+6aVcsHdBaSzTnTs3ns9a+F220BwdKD2z
 lkURMF/uD4fQcbSC7+Cj3EcPbpKl/Z9QsIBTu4XZVreKptoKyrli6MKdgeWcU0FfMnNm
 Namg==
X-Gm-Message-State: AFq9FYI/twrqEmAiDcoIucqQ8qOCkuPvwhCsi4Xw2MxGSIxqV7yyQIef
 6Ohbh9+y3uQzJQLjyTA+pgWWMW51hfBwcXJPwSBexX0c43oAAcgUbY/y40XvB7oOBj2SKMBuwz1
 QnWlJ1H/MbGqNp4C+DT+PWenl0kVZRVb5lpdxd6Tn
X-Gm-Gg: AYBFou0J1P5RTQMW1obJKnQG+WQqg2zYoCEOst9QSRNEbhFxuMo7hoUgHApIadyuEw1
 e6JtXAwMvqXeOW3PRCLKu6L6fqXAh7KWDCGwmB166zYKrsO14Im2PwhV8o5OUmK0/KXaIg54MbT
 RHg0hCx+1YbmTNrX9oNpeqP+2IbTp8nqG4ibxm25TKGo191X53+QrpabZt3/Cc4hobFuloOVJEU
 wlJQQIvogiv/ANxmyDo/IhkWrYOdOi9W4id2Ddi1z1JugPiatqjVHt4aymgQx4ChP7Pxj4cvhBO
 nHfbL+CGQgBQoQrdx6rBNCbD+eqAH+SgQKrttxQkfhTctyU88JP0XijduomvwHJl7X/mX194Am3
 +GKhJx7QOseEqqP8+9c7Lv+qiYPavJfTwKII=
X-Received: by 2002:a05:6402:a195:b0:6af:dc4c:5f23 with SMTP id
 4fb4d7f45d1cf-6b442fcb2aemr1141217a12.13.1792825225118; Sat, 24 Oct 2026
 00:00:25 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:22 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 08:16:31 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-11-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-11-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:22 -0700
X-Gm-Features: AclHuK_d3iLhBPfIT1rZx0yDYBY1p-3mvdVwl26MSwBnBzSJ3Y5avsUW2oUnjWI
Message-ID: <CAFLszTiWN8F-=iSzc-kQ0K3HZamJ-Z_D_fOzu03ofPS-+-v2LQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/23] sandbox: Move SYS_LOAD_ADDR away from the
 bloblist
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> sandbox: Move SYS_LOAD_ADDR away from the bloblist
>
> sandbox_spl and sandbox_vpl load at address 0, while the bloblist sits at
> 0x100. SPL stages compressed external FIT data at SYS_LOAD_ADDR, so even
> the 2.8K canned LZMA payload loaded that way overwrites the bloblist, and
> the next handoff fails with "SPL hand-off write failed (err=-2)".
>
> Use the 0x1000000 that sandbox_noinst already uses, which is clear of
> everything else these builds place in memory. This also moves the default
> loadaddr of U-Boot proper on both.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  configs/sandbox_spl_defconfig | 2 +-
>  configs/sandbox_vpl_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
