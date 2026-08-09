Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A9BC5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 605B1405B0;
	Sun,  9 Aug 2026 00:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhxadcSuOvSg; Sun,  9 Aug 2026 00:35:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F20240594
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235700;
	bh=sRyh5VWPF7mpqNkuIvAsN2LkF/Z9sAlCf6Un5IQgw0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WdfLi1CoRO66UfohhNAZBGaMvA9NxS4CcmMsM9J+hCRvL2P1ioHDjVpWVVjSxSX1Y
	 tJE93KqFlv+j+MRnZL55Cgxbw2421B8Y/hMr/mgvwkCCZa6KhgumuPywizMGRIL40H
	 O6gbSX95dmGxR5/O6dNUXTkI5OFscCsUZa5CPy8kPVURDMMioMWMRuBFtSIibDVTCn
	 cnp1nVeo98aBbqJsT6U9dc+21bgymf1+hG0PO67+5/6aoAz7rL7xlk3nz28ebXmeiv
	 L6lah9CF2Ed3TPjIHyA6mSqgK4k+oge6ZOyfJHV/g1MTvKdE/4wDJuY2u/VIF049Lq
	 DovA4llW1ppag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F20240594;
	Sun,  9 Aug 2026 00:35:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 27A61282
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DBBE80D88
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fq8p1MVl51ns for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:34:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2185C80D77
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2185C80D77
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2185C80D77
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:57 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so1115432a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235696; cv=none;
 d=google.com; s=arc-20260327;
 b=lfsH103RhIpqAxGtyiSdiBseON0PzmWteJ4t66Ja6/0WCPphugvro2mLdrxhSTsH/+
 DZZOpJ0w3RRvNSnKwDXlTdmZXgVctluF62Q+M8Q5k87jsjkWMkXzui7LMJANHg2rVqd6
 KgMJP82v4cGSi/H2eWnmtuCgQhV9Muyuh8YfOS+5Vt2qf24zPU/SOjKRSDo1STk1JZSa
 p+GrUF6PNeeJO5d5jbp1yOanuXZRkJEGYh7jjrkoh2ON1SatHHJ+4F6Fli+uto9tIIGO
 eu9awM6xmRTEhC0LhivNaSFJBWC5LgL0niEpMbRsntEluf4mfnf3/hZYKtBog2vc+/uR
 oWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sRyh5VWPF7mpqNkuIvAsN2LkF/Z9sAlCf6Un5IQgw0E=;
 fh=nyIPN+mnu87Af3HsWosnPKutMPv9WVG90q6lU9KV8MY=;
 b=grQAj4NigScrb+QxU3ocOPjK9ffPdq3G63g5FaXq+kw5FzfbpTgdMHRpOLvqp5hIso
 ESQ9YZQfMGdENeNmS6YgWFkY/yDmDkPeEknqxhDArxUJbb/i8DXvbXTmRGIANafu6srh
 ivOq5cy3CKftDDC8nWD86ORAoOJJbIVv82rIw4AX0dwbQFa6Sd/5CbUpN3yXum1hOAhI
 au8mMZ0tq805bZCV6Rww0DPG3Or0LHyZMxQpTwlJtP0qk8ZZIudulLFkuIHSCmjz6iYe
 WzbsfQdxv38fJes8v1pa7fcW+GQTCvIxRR2BcETpL9FTVfPou3dj3QvMT0Ixx63ROuaO
 0BjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235696; x=1786840496;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sRyh5VWPF7mpqNkuIvAsN2LkF/Z9sAlCf6Un5IQgw0E=;
 b=TdHfwH1FyHiQRVlrnHHcx1VwDKXLmUeQE5K6C4lhAPleuudEPOgu3q2uCwaj/E/8kQ
 U6nrlaSfA178Azaxmi8Fj+djaPB+n4D+503VucLNoE7ulBSNopjphueNEcbRBiDrp+Zs
 A9HFbCIqwhUKY5rgCbaK06+ZM8D9ne9JqtPQOXkhBdCIzX+bFTho+lsCE9abY9rvL7hl
 vJL5iBWE47IhrT/QtOIFme+w7LcswR/n6TprnfuOwovdir3OVAX8p0EKyIFDFomDFd1I
 IywQBXIWWl9YfaCJOi/XBkHtVd29K9q5PQY4ohXY6tlqEg0dmDWLOod6lR8XsIK2OUKN
 ouUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDVuFUoA3Ra13EnfWZnWOueI5KZUM/s5jXKFOB1Xdpz7Hab4bJuk5zKE/micMLRFSTvrun5Ps=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxQUxP00NKs/Qf0denRnb+AijnQlnkf/O5qFzuASvc8KVDu6ZzN
 gpeuBeIVFlt+REmeu6TVz923S6xSqRZct8CvrE2+b0SUlFgFsDaAUebFSx/FliA4FBOL8IbmflI
 yD6SQ+YqpgwlJf8iNvP6hQ8zhO3zWx+Aav5Vg+Izn
X-Gm-Gg: AR+sD10cHFL3VLhORaJeVR3bLxQkOyKyM73i9lZ8aRJV9vOg5basCdM8XOGkkAVmjdG
 WyepoaRWBzEVbE3IlmtMT6fUFChjZfOdEsOajfcjNhXUlJ6zIx9+FdEr2EbvYbsXuKc55b+9U0F
 543WK66gRReEnvyU6AgwttACZ6aeccHLn1fmSrIl7r5mXTph6uF7YuxSMMqOeWJI9lcy/uZLQZg
 tAXzzZ6/EhcOnetGGEoPX4aAnHZcic4YW6RqDPjqNQxIG2ouiCiO/eFN8xSZaa9IwCYUdTwQiSM
 wYThiqiOxCfnGYubaG1xzVIvZ8LttrZPzsicSBAHdbQ=
X-Received: by 2002:a17:906:4fd2:b0:c1f:b883:ed3b with SMTP id
 a640c23a62f3a-c2039cc5d1dmr1555971666b.4.1786235696042; Sat, 08 Aug 2026
 17:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-4-jonas@kwiboo.se>
In-Reply-To: <20260804002643.2308515-4-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:34:42 -0600
X-Gm-Features: AUfX_mxg1KSZ7OViY00dQFyH984KD8LOwagPmjcXQChMMLGg000R3GgtqVISJAs
Message-ID: <CAFLszTh5dcyyNgODjDwAY+mmrB6cPH4-q-E8LSdt42LewzZc6g@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk: rockchip: rk3576: Always init clocks in SPL build
To: jonas@kwiboo.se
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235696; x=1786840496;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sRyh5VWPF7mpqNkuIvAsN2LkF/Z9sAlCf6Un5IQgw0E=;
 b=kiANaXjFt6PBy44VdVnAoa7XtdVYt6oF8AkNKSXNC0pialCu9UbgzK3C3RLk7wV6L8
 LGEmNodq6GwytesLxf8o/FK/FgPAZE2b4f+ul1pjBsqArP3M1k98y2s+uujbx0pj851S
 e/Ojii3GtJ846C9RJ9Pr0VRpabqKFUbm6xXpI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=kiANaXjF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 2026-08-04T00:26:39, Jonas Karlman <jonas@kwiboo.se> wrote:
> clk: rockchip: rk3576: Always init clocks in SPL build

>
> The ore PLLs are only initialized in SPL on RK3576.

Typo =E2=80=94 ore should be core.

>
> The ore PLLs are only initialized in SPL on RK3576.
>
> Ensure clock driver is always probed after bind for SPL builds to
> initialize core PLLs and clocks in SPL phase on RK3576.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/clk/rockchip/clk_rk3576.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
