Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B9606A335
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pb2swGxh;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OpKfz1PA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55ACC608CA;
	Wed, 21 Oct 2026 13:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwrY3JBoApu8; Wed, 21 Oct 2026 13:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DC406089D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588091;
	b=s8CuyCqmnatfD5J/nUnMOeG3GCSAIYK2GRXqbuHm0nCib/5toq7hK6iIFRhCDDqhvTrc
	 M6QgMu46KcYrHymGFOGKROrX1iOJS4MXMNZbn8ihrWHQY3+bUhSx1rdeQ/g6lpQ6e5Att
	 IUPtX4zlcrAaZYGwayUSUTHbncpWzHJ0fvNkb7kBvxSCPlvvgsjnGS8p5hktHtCQOwyyo
	 7Xbib7f5t1xYWKMCBaM72K99eWnp0mBFwXXlsUkA+rmPaRer3Da+mhFlaTypI4VAq19ee
	 SC68Wk6UbU0GHyhFw7tK+aTn2R35bkEvXJBZkY91J22ek+XX1O4ptqy4lQCVrifM+tg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qntHBBOEW7KRRmtBEHxxFmmTaTd7hiAYQ6Z7VKtJOqk=;
	b=r0QDtiIJRBXUOhKpmVLtfx7DQCPjEyuNMGBOFhBUJVbMwnVulB6VIDIUXWTwawKTtREW
	 C1goPtNvB2s9PTw0CA58ozSiEs8L5MHHIjcmB3TQPgYP5VgzLBM8K+pnn7AFRx6A//oDD
	 0U2Xs5KwzO9Sz1X0AXs2zwGaA3PrfNhf8wHhFN0KLdk+mezA3kxXKzechu+D8IFFEyMak
	 kKQLUA/KQeCJTZ/wh5StyjCoqvxKVyLS6j+s85HGkvgAAvq1dNZd7EEPpUc6OiNmhm3Bu
	 XOlo/ayLMOyQbLoA9bdG2SKVGlT5G43cRhzReWGQ4Mfooe8IK+RrAJE958zi0ulVVjg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OpKfz1PA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588091;
	bh=qntHBBOEW7KRRmtBEHxxFmmTaTd7hiAYQ6Z7VKtJOqk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pb2swGxhCQuHg1YPgKIC0s7prEHrP3PnSa1KsyUEK6AcZfG1R5TuRXs6HtlcgHzqs
	 H0sVMyDvD825U4uTbZ7lqyrqqf5xjMtr/2wM5I3Hbd579/pDgeYW4JsJy7Go2nqBi1
	 0j73SW+LtAcD7VEN0G/Q4dqEAVlqu/fKDYwqBxXOaFhKMl5yvxX0Z6/Wq/evCZnZ1H
	 3fNLAjWrZXnizkEGhDgTx7nVD/rgp86azg3UFB43SgFB1PPW6AiHLaTn8oyDdPEgQU
	 uMf+hgKS8aGmmb5vMspzxpsNs3AcqBl0xg6gTXkwIjblTdMVejUT2Pp6PrRrsyilDq
	 y+7jXDHQp6bgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DC406089D;
	Wed, 21 Oct 2026 13:08:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 316A13A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17CD86070D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LQ3TVwPIDWmT for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 257A160719
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588087;
 b=gERpHLW5WnBBBHUlluEVNA9yla2KxIFvJArITLduopj8R3OGKkP6cMRv7ggm3V3r66gv
 8XY36TcOZMiyVlbtc3BIFWN+N0Z6dq2RkRq4M+D0oExUCRv2rA4EZuuYT0p5bb9CkFRgl
 tv7OH9rImYu2ElNVnIcGlBEgeGBEmwvkaPTOC7YJlWGZX0NQFCGXOXpIrLUJs72z9qb+P
 4SLsn/mAb9QMRbEuQdlNVGTrDZQ/x9PNd0YgQOlAMJv/ErO8BMz3foy8VE00uDaK7aQrW
 cWkY9S/Sbzz4A9vJXB5dNQMQ/r6Yx2AEpaFvD/jSZBcqt9cKoHNJAdV78DLbsTC7bCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588087;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=qntHBBOEW7KRRmtBEHxxFmmTaTd7hiAYQ6Z7VKtJOqk=;
 b=REPb3FJZ0uTfEmet7x4zOmgAQdpytiI9NLrwWcb7cwdRfqblSphBk2u0x/zFNaN38JU/
 eJOmWky36LbpO9wN1jWZNXLBU8j1stC2H6KvfN+/3QryjFR/2Ue/oYBPDce37HJCwCM0b
 yalaHhJ56l6oJYChCwZjOgopNmHl8CZpFM1otpghZqDC+8+JuLdey2JU0Eo+lYYs05bvQ
 TN+oOUKN3ZXEqxUjaehqr6ERUK5SA+sbO0NwOCY5muo/aUI1H1SlEDwA/3WNQrk5ClZt2
 DaD2XUMKsGGTcj4nQckI5Gc3yaucYDt0ZL6EOJfXK5VO+rSs/R1AwTjv0crHc3uf+2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=OpKfz1PA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OpKfz1PA
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 257A160719
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:08:06 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b203527bceso949478a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588085; cv=none;
 d=google.com; s=arc-20260327;
 b=TJIsU+NybiGqAHI7Rksr/oGzrj9tfVKTdlYvZ7ol1G91RJUekOm/IrMbmfCU5qrdR/
 QabQDE++iD0ja14TxMfSPGIa7QNkao0vwgtp2ztp7MugG8fqX2vn/DgVFzALfINilvyt
 pO+lh8ZZi8g9ah6Mr0OV/gNDmlA/O8oRz2EoOV2FUEYhGjwx2Ih2Qnr7o58oNRsCgd0T
 5iyB5dMXkYkemzVjWMpUiSaPHKrL04MZShVLCnqbyF2FkL7PA29TLhQp7Q2Tj9CN4r3r
 0wSqxkgkROUlF/dyZhsiFDYH3Hxe8UKF7zQVbIqYTeGz1aFZSrCLXbgd1kosGo9v71DO
 3qfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=qntHBBOEW7KRRmtBEHxxFmmTaTd7hiAYQ6Z7VKtJOqk=;
 fh=rDOkmCQJ9cozxuZkgmyNWj5k0ThXnY0U4gnSEgE31/k=;
 b=hTL6g3LsScR+M79FimlNLQpC6bc6mssGib+7mNTu7i6asfxNFuPawYiV1f7omr3KQx
 KvwqM6L9PqBYFQB5XLlbTLilqSPdlAjs5twJ4K+D+6GYNtl+RQGdGNWa5cutqntl5p24
 DWDiz5LTKUKN/5oU243AgwcMuBAe/FHVSkxSVcU3ffaCNBsvPdW4lZiIZb2C090U1oGX
 sQwSgZxSjl+avpDuqiqdlIHMVmzzj99P5iMuLRIWvt/WFRpp8JcEOCqttB8viyYJMS4N
 yoYMPjeZfYPMg722+8KFbW8n8cp8n6uvESrNTc9z5nSaWP9kMe2+u+FQe5yTYcZBOSCS
 Oinw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588085; x=1793192885;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qntHBBOEW7KRRmtBEHxxFmmTaTd7hiAYQ6Z7VKtJOqk=;
 b=OpKfz1PADgjWXmRQq85WKOQR06QKNhYMS3AsPLS3ljcieEj+zwOr9k6/cCX51SwWHl
 iYetv/pMn+RidzK3V2fZ28rkIzAz3M1QLIhT08Xy+PCH+wC0R9tQrRRyGdb2gQ5imQ9a
 mn0F1LuXUKSbd7+yJJHIc2H9bP19hi0zBc3oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588085; x=1793192885;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qntHBBOEW7KRRmtBEHxxFmmTaTd7hiAYQ6Z7VKtJOqk=;
 b=yBnA9gTaBAitC+HOPsuMf1JPzyJiiDEirWv+myNxzbmV4CZF5PWQqoXRbZrB17Ejcr
 Vw1rGVmZhxfJKrxSg7TcgiCEEaL6zCfUZTphw3rEQ7tojsw+f92BnC5DhWHVdbG/CX0A
 PunBUzABPCQoOMGge/3Xbe+ysTuT6oKCPA6M+g5pv5gSPw9MVYBhqqz0BeXqJ8j3mpK4
 gPIfsMU+jbk55LpXZGu5E2ig6KwRHBBBXKFC8uLYDX04+4jYvqtpPFjX7xpMswW13Pov
 LXowaIZvuZjDV15PlYEcj6XTDYQkhDQg7zM0qE9JpbHFUN80Cnk4cTIh+GQn0yWCL4rK
 lvpg==
X-Gm-Message-State: AFq9FYKJqC7faE+owbIQbI/l5mhDOYfJduSen2XQylzRV/BPUImQvArh
 9v23nEXXY8S9m8Gf2H0N6Nz7ukPCWtiyE8NH42BCW4m+MPmsFFTMIyK1n4dAKc3mzAH++LoJ+Ae
 tObKoF8DVGZRj9LCrmTSInW0QG3CO+VVsBLW2nsZr
X-Gm-Gg: AYBFou1QCuEXEErSeKDRhhj1vgbZgkfoJng5st4g6nWEAS8Z8iMmLS7SMNU4cBnacx3
 MzfhJG5NKy2X4DlLlx5UzMO/ep62X/v3RodcIKBeaSkclwPOQ4j3/HMCvFSd08U98cVrZIpaL0m
 pelZYwJQpCTu8uclamHkaXjpp6Rq69tidQ8z4uqQhr7JYxnRsrC6DIgZfmmuL6bRdqm15z2x8xN
 D07g3yDuRA8zqYbQqevK2u9/sj/GabmK0pgJMrTsx48LP3jKM69m1hx281/Hc3ue7m5R8C5QeQO
 no2DBf5DFTMY3SbKCdODtcCbEeZpbSAUKAphemPtU9Gymv7HcbPV1Y2t3PbuI3bWQekyOoJaI6o
 c6DzYaly7zurj9IDu2XehicYZY2VGsf9h7bw=
X-Received: by 2002:a05:6402:e07:b0:6b1:c5c3:9624 with SMTP id
 4fb4d7f45d1cf-6b408eb45cemr1410435a12.22.1792588084720; Wed, 21 Oct 2026
 06:08:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 09:08:02 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:41:47 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013-b4-button-live-monitor-v3-2-3563b4d3ccdf@protonmail.com>
References: <20261013-b4-button-live-monitor-v3-0-3563b4d3ccdf@protonmail.com>
 <20261013-b4-button-live-monitor-v3-2-3563b4d3ccdf@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 09:08:02 -0400
X-Gm-Features: AclHuK-xbZc_ioqubicemnYGYqpYTWpvAKTteYCqu2zQw4eL0qtAXW6APi9IOpA
Message-ID: <CAFLszTgWnNDSgsWBfV3k9-K_xDVv5_xarbGAe5MzLk5B+AESKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] cmd: button: add live monitor subcommand
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, Simon Glass <sjg@chromium.org>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-13T16:33:33, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> cmd: button: add live monitor subcommand
>
> Add a 'monitor' subcommand which redraws the state of all buttons
> every 100ms until Ctrl-C is pressed or a timeout expires (default 5s,
> 0 for none). This allows the buttons to be checked live on a device.
>
> It reuses show_button_status() so both subcommands produce the same
> output.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
>  cmd/button.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
