Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B900FC4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62C0B406FC;
	Wed, 22 Jul 2026 15:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EBzmvgBTL7p9; Wed, 22 Jul 2026 15:21:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DC8A40763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784733710;
	bh=okPUCkN6oQiMPFlREHrNch75VpZ1M31ryrxPjJr5W4I=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pucmhRJtj8mjbywXXrePp300ZCaXWulzU6zEKyaWonRbQFT0nzX3O6+LA+WtYQ25e
	 2vVu9S0LPuCoT6ICz7op/8lCCkMPFEshwbdXGYXF8loP0WXSajuMKYpQFY97Tg6ZbE
	 yxnS+VHCLsO3BgMQp0VA1vAIMXdAiPtk2mL0I2L4UCDZO1XS1CN0QINeWO0Z6XFEa2
	 cHoDixzkLEomGqjl/srn8ODckMaNu+FT7qZsRo3p4XtA9sHubTjdRwGs+3hNKqB/TB
	 KhrrP9yB3Pmlbc0UWb301R1ogL0JA15ZrdY0Ab10bWqZEiZtdM8YADe5IfsY9UdJ8D
	 MWbEYM4LIT3pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DC8A40763;
	Wed, 22 Jul 2026 15:21:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA2CE788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC4C8607E3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9lAwDd-MablT for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:21:47 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 73149607C1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73149607C1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73149607C1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:21:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D682B8494B; Wed, 22 Jul 2026 17:21:45 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C86848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:21:43 +0200 (CEST)
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-526f963372aso17300521cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733702; cv=none;
 d=google.com; s=arc-20260327;
 b=NxnIsjIALFIWgYMi1S+OtymANTeV9coGdlqVB+iEe9r7aQ0ojY33CVw6zoGSFvoW6r
 AQgmuBQcJ4kf4TlcIE8wQJigtzB6XUqEs/3Vz3ZLm25q7WcQMWk5TIdS555q9M7B7Vmm
 34QAcevUlf1aj7K5tARQji1jhrzBflH05L2RQylwWigz13X1lfGqwZKS9ROjhYGixETs
 t/AecLOm4ugI4B7RlvDGjQEi8lP37d498KYCDHM+qtq6QGjsxxvNirbBrjwi6Nper2iM
 XCQ/O5lIFWGyyHTf/wsQbyWgcdShPNlUt2zw9mEueLvzXNm+U63e0jm+QTdexZza+z9W
 uKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=okPUCkN6oQiMPFlREHrNch75VpZ1M31ryrxPjJr5W4I=;
 fh=95v3zCM98vOFmWKnv+f30z7Sxw1oJ/0RAePok151oZA=;
 b=sHXx//oHLBUv1LXSBYbbjPuCELTzqkd1M46hUyWgNcd/y2j2SJlAFS/A5VOjMNViYT
 s264SJKaTHSNcO7lAmUp0qXIRTR/w5CrDz3Iipy2L+ARY54urKLO3CZLn85Iqnoo9rUh
 B1iWCy+G2ZxFe0x44yg99fMJ9TMfErS76/clJ+3MmRsRd+sSDV4pxP4s6nNZcrV9o42B
 lYtaBbETO/ixfrmrVfy3ULJegzUFt6qnS/HoEdpnGcMOjH8Nycn8ZucgeaObDPxo0sMD
 FDQbuR3i0dBajLR+05Bc2tR/maZxKJ5zzWjIVvOSnTGhzslMuYiDxjMEDIz8DLhOxC9A
 kv6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733702; x=1785338502;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=okPUCkN6oQiMPFlREHrNch75VpZ1M31ryrxPjJr5W4I=;
 b=eAEzD/wuDsNBp01hwCh67nwabACSepuk9l6J245y/SZFYk1obZsObyaphWrr/kuGa6
 M/FvPTltwETiieCAkTagiCqhfAvikj5UHDuM2QbUj3GfjDbV/008dnTj1VIgE3dN6W60
 vEb/3uDrZVF47KxLEKW9n2h2q1gSLMhfNhh0ExYPwdB0roQ3wIIwMthh/Y4oYI3kiRPg
 ZwvQnY7QTqgBdyxha/aA+uJQ9Y4seWHfwq4ITnaRTAJ5fldt8FcC6XdXPsQsvGPK/HsJ
 ZZHYA/Aw6eu+IiQ2DG7nbT01rr7RFpsTvYPbhkQX/ih8sw2qKejqrlBu9MrG5Tavi11L
 DzJA==
X-Gm-Message-State: AOJu0Yyffj45wBC4jnR1Uc2MC6u0DhMafh4wkv1zBddwxkEMg5ZkUmUk
 R9TaSpho+aA40P0bKhCw16F8wdAQPX3N/iWtBsr28bEqQwy7JihVhCZIjf3dyjjfuK7h3yeukiW
 qQow/0GMbD5oA8tCnK31Y9QcQk2wshQg=
X-Gm-Gg: AR+sD13wm1MC3Prt99BMBeIL4ADaggW5kBu2gB58nm8laNWWdTLa67c2QwyMAc3bZFC
 yRhkmsyeAwq4f0S1s79NqcSp39mpeBQhoM3pxs7I/FkdjRlU47qtIzl9zZsEUEmcjJGkk+Tk0vG
 M+shXtrBnccez8paoXgiolCbC75kiqKgRqzCxBiO6tclgZFkAuN0t/JwS9RjV+e6xq7m1NMubK/
 hcC0IQjyXFko0/jQBlf5SPRppeDB23tbRPTkQfnHV47j8/EUkc98SpE5qnwwJku6heM60kj7zBv
 d/+Rz1rwMFa7Eiexy0xfIIywHDRcMmKciBaE6Qi3tUvWJJR1M3F2pjQV/uoMo0I1C901ZSuJIUr
 L/325zLIotY6HCdbhN1NlOhsKvgEqC8ryQaSe6qEXrjPQ9SrWu2dq7Ah0
X-Received: by 2002:a05:622a:1b8d:b0:51c:9193:fd9e with SMTP id
 d75a77b69052e-5213bb21216mr226563491cf.15.1784733701762; Wed, 22 Jul 2026
 08:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdxF8BDNszU-UY9V+_dQq68pZSFu3Z+vUsgkWe8G4rDZMGoZQ@mail.gmail.com>
In-Reply-To: <CAMdxF8BDNszU-UY9V+_dQq68pZSFu3Z+vUsgkWe8G4rDZMGoZQ@mail.gmail.com>
Date: Wed, 22 Jul 2026 16:21:29 +0100
X-Gm-Features: AUfX_mz_QwR0Xdjampy_V3MZy6Q5c6NzGJZLEr-mYVtZUya2tn_Wihan648IMAQ
Message-ID: <CALeDE9MuF-=COmGEa1FfH1M4asrZOzbmGiYvpQn+x7DCNSgPFA@mail.gmail.com>
Subject: Re: Fairphone 5, microSD card support?
To: =?UTF-8?B?SsOpcsOpbXkgQsOpemFpcmll?= <jeremy.bezairie@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784733702; x=1785338502; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=okPUCkN6oQiMPFlREHrNch75VpZ1M31ryrxPjJr5W4I=;
 b=AUCNGkiGYC9KntlqbtzIf1DqTGcFm2ztFfknMfHiSyVpFEGZnJ8F0kDVcwW6lUQvlB
 n/8ua1GV0fTeJlZhXXvWQA616WK2/YTPrqyNkeXPM7eX0BwbVfNncFcBVKKQpf0RM0G+
 Rzyg3r2/gsogtJVPcUDMEEUi6Pv9gXOkFW+M+7sE8DjFuGcFLfSLDpKJ249Or8R1tBsR
 IJLVTNGbnuA5sFA6cD+Iy1omDoVzSdpifW8oVcTJzr8vKgzfnt4FjsR2tp4LAJRQzksJ
 I99WOhKDV3Zw2Ghxh2GVv+KTB7xamZ85DokLR9vi/QYILq8uqaQhnNjA2MQG2rgPmggm
 i/8Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AUCNGkiG
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbrobinson@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AUCNGkiG"; 
 dkim-atps=neutral
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
From: Peter Robinson via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Peter Robinson <pbrobinson@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi J=C3=A9r=C3=A9my,

> https://catacombing.org/builder , selecting Fairphone 5 then Build Image
> brings to
> https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs/1548118/artifacts=
/raw/binaries/u-boot-fairphone-fp5.img
> (it's
> not the latest...).
>
> The latest
> https://gitlab.postmarketos.org/tauchgang/u-boot/-/jobs/1607429/artifacts=
/raw/binaries/u-boot-fairphone-fp5.img
> ,
> according to what is displayed on my Fairphone 5, seems not to support th=
e
> microSD card, no USB mass storage it, no boot it.
>
> So is it possible to add microSD card support for the Fairphone 5, &/or U=
SB
> drive?

As far as I can see the U-Boot support for the FP5 isn't upstream so
this is likely not the best place to ask (and maybe why no one else
replied). The underlying qcm6490 SoC is supported so it's not an
impossible task. But to answer you're question with the current status
quo you'll need to reach out to whoever or what ever project maintains
the fork.

Peter
