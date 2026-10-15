Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F03FCC6B39
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48AE640847;
	Thu, 15 Oct 2026 08:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6HLUJaLeaiO; Thu, 15 Oct 2026 08:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62F6040840
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052882;
	b=FiKCirfxDG7N/puu0gw2l+23XWinX0Kanx2IxksggYnQDot2IuLYSR8yte0Pkr2bvzof
	 3u0vE/onwrpaLYScx5rqHhddwdY1W8af6noCUGWR1aelL9biKjA6iPBNPC4R/hiGjKmfJ
	 cPt1/GNsbcnZvFgd9wUYRU+EYqxswzUqZOvEI97xfLafXDcV8OgE/9/LAUoJ5976kOk1I
	 YS0j4u3ruaQnsrjjUfoVoYCNZsq7wnKvp/0X95vwogXyWpNVNyf3cOFh+xjZQT6ga+zFK
	 LvY+OgLG3hNpNwoRJ9nEfoC/AAQwRydtX3CEQWTUJRzMMNGdiiRunBz3PpeNAKrCPbw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052882;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UTwxiX1p4fd2h5OoPJ2Y2OWecUpcVG7/MOpaaRNyCWc=;
	b=sHNPzTLRO2en66gmkRlO08rFVUMCo86B8olbkJYdqX4ZpNK66C9GWxFnmO0c4LAMEgWS
	 syV2rb4732gN8qKbobTISSwl+oEl/GdMGSxl6Jf6Wmlh6GYolElNKDijzJkQVS8yK/uUp
	 pxb2BK3p9vBRX0D9t2lhfOgaEwUNOYlpaWaJAokAhTzFYGRvPLp5B8c9863GF2Q3zzScZ
	 lXaB4vgtdGsixDJYIRx6hMjSng/L6YANm/oXdc8RLkklFYPLltK9QBe0pMNJqflTTIFlB
	 nBbTgfP9a/LQOlaNCiKzOvHBZf1nred7XtiD7bsu32zHz32j/tHlGc6bHwv92rqcuWw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052882;
	bh=UTwxiX1p4fd2h5OoPJ2Y2OWecUpcVG7/MOpaaRNyCWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFuQk1EXrW/P2IyIgRI5twwmlYCcPNV4EU5CAyn+D+vJonB2pUBv5It+EGTsOO4B1
	 KS4pOId8nT4fX4KC1vsYs5t50CK2EwDUV5XFamjzbgHGTiUQIznCLut7nUKxTRvdYk
	 UEyM3N4/yI4phYXL/la+AIuHzzsbEGBY5ot9Qa6LMGX2Z8WvdWguv/fH2NNtXltJiv
	 B6YPB0Q1V4xSvd3J2pG7xblOc6JRkWfXPAAvY1SV+NROgGGH+Bm5xPjX14dUvRgbJN
	 ibP1/mTY1HS7+8+/DJ655aKiF1ZivlaTtratYHJyWJ0ruzir1RFiGLsf4xJk8j++5H
	 IiGftbjAtZmxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62F6040840;
	Thu, 15 Oct 2026 08:28:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8529AA58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 06:37:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76C5B607DB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 06:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5TZRvtSJoX5 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 06:37:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBE24607CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.125.188.122
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792046259;
 b=KIGLlfzkj7LrAEJ4I3CIm53D9tKNAUPJ5fksnrc9KQOjvlzDhbntKsf+RkDQlyBSDRM6
 28OTzJ/EsBl29FpOMOH/jNVdawj8Ux30M7Hn9FXyQVVNvRZpi/P89MjhLgXeswhNiJ4e9
 dePLfPLX7V5SZKnlH/y66GBkyIkPLafovJzXXlIqFiWk+79yqNh1twprM4q3CMTvd9zuR
 A7cegizRzHFxP8KnhFNfQm3rwFvutWo/iPrl4nJ4NFLAmYN0QMbaQ7MMGTwf4QuvY3IQQ
 0LwH9WeQCHRdkGqKzDGacixkZ7ZJf55l20A5ajurNXWFd1HvLrNt1YpPK5Q4wfRbSKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792046259;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=UTwxiX1p4fd2h5OoPJ2Y2OWecUpcVG7/MOpaaRNyCWc=;
 b=DEYbqcTf5lpdKEKy+lAEERAZD6VpmP+KzU70i6J/i6mI7CYHDzKFvVSUzFkYRoY39PSb
 JIvkVP2diD09am2Ue8xj1Q93gZsNN9nv+UuoC85pn1ytmv9iGI2LCSDC1kS1x4FRad8po
 626/M8RmYrW2oP6WMihklMj7KUp50vVrYmwit9nIhVjX/Mgq1UaS91obj20qEjPxVLW/q
 SwnDJ8kXbbRjPsaL4wMhq6RpF3euDeKh4hHu/MafcKicGUXbJCSo5xep88YWMS0LZSfzs
 J/EkZ59N7eMcUmyeryv1e4HxfMOea5LzXiLGatJSgXykC1UyDAaueonxo8jIdmddWfg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=WhQw+kYr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=WhQw+kYr
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBE24607CB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 06:37:37 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DA0EE4025B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792046254;
 bh=UTwxiX1p4fd2h5OoPJ2Y2OWecUpcVG7/MOpaaRNyCWc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=WhQw+kYrNymyR2sebpnOQqqBVIL70wbK8euzm/EsSNiVPIrC5vJd0GtFJvEYOQ+xZ
 IfmtCGb/Alb24+tSNtZ1X710FFOs8O2vXBMnlnZ7XnxknCH62R7PhKNg45tq4VEzIb
 yLJDfOHL+99vUpPSh7KPCoS0bRYbdpPfwaYWwoYLs1Z/SMG64rCFS4ezmDj/lLKE49
 5TP77b0v4dfsujnrRdKhOXtpO3FscgFHCnI/77C2c2iecW1cM6jJ1MznREo4a0C1fx
 6oP0kt1UCUfgK2Xb0dMz5m3bRsjeO4o8OGl7QWBJcPUGq2aWcZgeJHmGFDMkoyurZC
 L0RP4EB5MGvmKsFws6QzjUjvDl5ozKOvh+2SKGSPztWCDOBv3pvlcjZcaMqiJba/YE
 Hlx/cH4dZwpInmTrUW8TPlODhnOZi4ps7kTwV1hVtiS71ULsWru5WhFUFdDLD4iPc9
 8KCU5WIIKLLKJZZBC8yWFHzy0kxV8TY+cJdyozr8IdMszmGrzZeabloJhcZfypZ2Ov
 6oH5Bi+b5flO++44AZYNCFvNUWAAYNDF6vNEJXAR0k6eFA2J62FN2PKtlhZeLK19IA
 S2Vslhwxix8dWwzuyYrtNmw4D8Czae7lpcZ5WL2mSulgHpM7rhPHQHHWUGrUfjrqWB
 XW9BEfjDA2q0P+x6SIQzdmKk=
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c3d9daffbc3so114684666b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 23:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792046254; cv=none;
 d=google.com; s=arc-20260327;
 b=dSWkZHoCyI/oUJIFlMtTW0lvpe6jufYgNQQQQ2gt29pKtPUUWk70z78lBv+cxXKvt3
 vzoaa2d/ukrUuaIBzMDmkkyA6XpeY47PP39/UYV9Ow+zt/wdPO24XWCw9LDd1a/UGJjX
 vfQ0Dc5aiMGfM9hFN49ZnybhhC4IZM35kNtZj/mBrq3ucId0zDoikHgPnkyPAMBDN6U6
 u2OkL31qYFaIZelmQOHbojVeksaOs3NekFYkxztcoQe4BSE86aYcXnCR4VHqWv834rTd
 SfxeTp7KMqIRn5L93dr6DAiy+NxzWIuKtzqTV9WFQzWkpv/Emed2jeJJXAstFqvp5uS7
 pNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=UTwxiX1p4fd2h5OoPJ2Y2OWecUpcVG7/MOpaaRNyCWc=;
 fh=GCRJ8EwgW0JvUQ5SpthAq6W7J451bknUpNgdUDz5Y4I=;
 b=dHqN15AVltYXRoOUnBepoYJqSt/QyCROs5MKyH7Qhf8yodNPRPakdKjd60Tywj5QNQ
 zszCyXPXQSnF/l2o0DD8286w4S0S90vLI0dGvhts6hLSmoUpZb44IPS5um20TxBiNSQQ
 C2/rSG9zf+YCyoWk6Fsc3OeCLWQvNHak1yopu1ZqaSvMns5mjXbcu7YooO81U8f8d9tE
 0U4z0P+J36wX446KkU1LnqZBRToZxs1kmnHPTfEOGHU67XYPR9GSICDXKsVXfVabr39A
 hfViHvcfq6L1m6ZwtTnu+/rHx4ThxhjuUwxtXsE33ato0korK5BPLUGqnEdF4B37QqVc
 D10Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792046254; x=1792651054;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UTwxiX1p4fd2h5OoPJ2Y2OWecUpcVG7/MOpaaRNyCWc=;
 b=opA5ZhuHBfD+2le1LhEDWWhR0a8sLVSEn5lU1T3+81McFRpGXZJ6hIFXjs36Rm8RG/
 rhBcLosCegViPvgOb+IDRLZbZmEuD0hCZUWyvJIOzmVHbjhFv93shsl8ruyW76HhuzXI
 rB5r6rlhaC6BD5HxJAJuBCdtyXT9c2nr2dFI++VqGJ9etWnHIUKl81YcuL7T+XV/5cn0
 14RB0GJzKATVdBZCsX3p8ZT2Y6rFEYBoSMOBGh9aKJ8+XqIdkjUd+7TRqPw0fzyj6dcX
 XbzLctRsrkYG5kBuSO57EHSKccJaHC7pIZBplrFFg+gEH0wuNzQMxx4fmTMLAa9+JyAS
 /xYA==
X-Gm-Message-State: AFq9FYKsTbKmfFhjKuNSYKBmV735Ilvqs2WKqnJjKuSmyNEoWq/08hEh
 1WRI07Rr6ToGYJ0EUfEsHN4rMIY2QR+HcIzWI4iHJuMTFyBxRagDsTTEakHFddsAi/F1ErEzk3Q
 KOCxWTOb8Uo0WV28+8UyENB8LB543GzwScraBVLzdEZYj+RGRtMQQYUZOSFBeNNJ+Y2pZ+iBTOH
 nyGOBChBgF0Ijzt/oV2058A7gm1rleqRz2Hntrfbf2OWQw4GzmtY0WGpmIAjgG
X-Gm-Gg: AYBFou1WFfL+DxMuOX4mqx1OkyCNcfuKImmSb3sBDw0VYJIGR4UDCtNaxIJLlGcZRm4
 70bbcU0/TwlO8Lwanbv0oKsUXpAG7XAZN9ymilF112gebsSQuVdaQtYKEZzNofjZGJXHy7hxP2l
 jn9BHrC5AA5zIZxNFYsJFZFW9PJP007EOuYOfE0NTPL26cFZrQ/LJ6bzU+AA==
X-Received: by 2002:a05:6402:510f:b0:6ac:8dba:e36e with SMTP id
 4fb4d7f45d1cf-6b17c296b7dmr14601745a12.40.1792046253911; 
 Wed, 14 Oct 2026 23:37:33 -0700 (PDT)
X-Received: by 2002:a05:6402:510f:b0:6ac:8dba:e36e with SMTP id
 4fb4d7f45d1cf-6b17c296b7dmr14601718a12.40.1792046253174; Wed, 14 Oct 2026
 23:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-3-aristo.chen@canonical.com>
 <CAFLszTipcALnr0MWK94fYhHZAxr-Dha=J0MeK_OxyKoRBVuPsQ@mail.gmail.com>
In-Reply-To: <CAFLszTipcALnr0MWK94fYhHZAxr-Dha=J0MeK_OxyKoRBVuPsQ@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Thu, 15 Oct 2026 14:37:21 +0800
X-Gm-Features: AclHuK9_9AxrCkFsZ5MrhDb_U1IX4V3ekhqhYfo5mr9VS-hCd6S6RegAsn98Gf4
Message-ID: <CAA=k7==1fNZea3EdmpSnntUjkR6+7jidPOw7ASrNGzBq2cTREg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] image-fit: check the length of the external data
 properties
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, anton@binarly.io, 
 pranavkasthuri@gmail.com, Daniel Golle <daniel@makrotopia.org>, 
 Igor Grinberg <grinberg@compulab.co.il>, 
 "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:27:54 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Simon,

On Mon, Oct 12, 2026 at 10:10=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Aristo,
>
> On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> > image-fit: check the length of the external data properties
> >
> > fit_image_get_data_offset(), fit_image_get_data_position() and
> > fit_image_get_data_size() pass NULL as fdt_getprop()'s length argument,
> > so they accept a property of any size and then dereference the first
> > four bytes of it. A property shorter than that is read past its end, an=
d
> > the bytes that follow it in the FIT are returned to the caller. An empt=
y
> > data-size, for example, is read as the structure tag that follows it, a
> > small number such as 2 or 3, and selects a few bytes of the external
> > data instead of failing.
> >
> > Ask for the length and require it to be exactly one fdt32_t, as
> > commit c2b8eefd4e10 ("image-fit: check the length of the
> > data-size-unciphered property") does for data-size-unciphered. Every
> > caller already checks the return value and handles a failure like a
> > missing property.
> >
> > Fixes: db1b79b886f0 ("splash: add support for loading splash from a FIT=
 image")
> > Fixes: a1be94b65410 ("SPL: Add FIT data-position property support")
> > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> >
> > boot/image-fit.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
>
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > @@ -1012,15 +1022,20 @@ int fit_image_get_data_position(const void *fit=
, int noffset,
> >  int fit_image_get_data_size(const void *fit, int noffset, u32 *data_si=
ze)
> >  {
> >       const fdt32_t *val;
> > +     int len;
> >
> > -     val =3D fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, NULL);
> > +     val =3D fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, &len);
> >       if (!val)
> >               return -ENOENT;
> >
> > +     if (len !=3D sizeof(*val))
> > +             return -EINVAL;
> > +
>
> Counting fit_image_get_data_size_unciphered(), this leaves four copies
> of the same body. Please can you add a small static helper, e.g.
> fit_get_u32_prop(fit, noffset, name, &val), and call it from each
> accessor? That would also win back some of the 60 bytes this adds to
> SPL. A follow-up patch is fine if you prefer to keep this one focused
> on the fix.

I will send the helper as a follow-up.

>
> I checked the callers in image-fit.c, spl_fit.c, splash_source.c,
> socfpga_arria10.c and (after patch 4) fit_image.c. All of them treat a
> non-zero return as 'not present' or bail out, so -EINVAL is safe.
> There is one change in behaviour: if data-offset is also present, a
> malformed data-position now falls through to it rather than winning.
> That seems fine, since having both is already invalid.

Thanks for checking all the callers, and agreed on the data-position
case.

>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Best regards,
Aristo
