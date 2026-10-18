Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D50CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 09:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43FF540733;
	Sun, 18 Oct 2026 09:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQeOt1Bt8xMN; Sun, 18 Oct 2026 09:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72BCB40744
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792317590;
	b=NVVtco3Qbi2mkAcuvJX6CrU7HANNDSmt+vkzcf6fOaV3ewjRG3P7fsJtuBJWZmK2xFpo
	 j4EPOtkDUpM4ptjgrT96vMlVXNBdIanCQZ9EV6cWXGsSpFU6G2uH1GE8xEvdU7ItE+0Qa
	 pgPYBuEFo/qZ83tBzk/3tGT51DTdTo8kh9qcFfP98gST++Ub8LHlIYl5652tPRIe2GuHq
	 qmYHnLPI6LbXokq9a6zUnccFp9uyICuRBtkfTEWB0UxlOUI94DAhNfJLkWLsUPDEtrHeO
	 KHFrOH15TlBM58i07DzfFu1ajvy2sawSAjbikpsw2DvEETep2eC4jJQhEr03HnMCVkA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792317590;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PMNEMATXNSL46l8gkfA+WQN8DkY+8aPyBKhyMkqwCcY=;
	b=qgXpxcVnIjd1xNvV3Rbld/XHMw/qFXxch0L5zD+KZw+JZooclvb6g1gEvW/64v8NQz+E
	 b3wSZAdJ/PeE9pTMIzHspliEkiM8efPu4W78NwPypuTrqlYNI+exahC7UeaBquGvIBc1n
	 xKbXhWO4Mf2LYV/VVSuqBvGYhLnjFt67vshEcj2NnN7+EnBxDdA864FQb228/6EfRSCfl
	 8pxzd+WPzIswLjy+53YTLbZvErh7ft77F9Zug8uR7mtMHMEL24Vq79fpUX/7ZKtgENQ9X
	 q932ggq00n17l18bh4S069RM3IPlRd6lQHFn1eotzN+d2qr5dpUfIo+gW5uF8MtVDLw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792317590;
	bh=PMNEMATXNSL46l8gkfA+WQN8DkY+8aPyBKhyMkqwCcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A/9C4nQIbbJlyCtdnbjmfslzCOcXjjl5PDeETYwcDt8MR9VINgPDPJUqcYZdJSn2B
	 kwMD9b2tGFplJEy6IHINLS1A68jhHjQKFSOgRtGPmjyYvQJVLmJ59TMh/X+YO5VG4e
	 JrFbHyDTh/y6skpkGSwck8Vzy4KgAyAHa+/CYRzjpM14dIxmGFJ4J6usiLz+0+VbSN
	 A3P4p5J7Lb2wVedb57mPLq3xZ5nmUgBc/hNnYJsNtF8K0q80I1LL4unJqSGV7Nz3kv
	 1TZ8pw0vU3rVIYy1lo7bYPokCHBxSC8k2KMtzHdZuRPZup5w2hhbhLo/kdA0JmUE37
	 l547SfoeAVW2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72BCB40744;
	Sun, 18 Oct 2026 09:59:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86407263
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C50681029
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:59:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXhuec1vmhGF for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 09:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 602A880FFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792317588;
 b=Lid0Zhf4mxE+0vRIwq1s7SRmWh5siFt/CJ2ATapSb35fFhHu2yqqa25y3FYQZYgw2ClP
 hkAazy1jgMWU7qxdg4Robon9BagvvVxGhC+5CddsiJZR9nxNfQE860hrHL8sOT8//eEKG
 d0rpy0+BPE1yZTbxnXw2336oACLEq2cnXbL+UYuPG/IaCVqeBafeyKhjLCCgSDovWZ+WC
 JOhNv8WyeygiPOfloCGESwjsqSXs3bqHmQvbU8d++Y+ayNa5LAIRf/AxSYICvRoZyumUU
 EjZiZbpHrW11CjFzeXLtFC2A+NA6viQ5LFdRwCycBHEfQt95Yk7al25v3TiSiH2kkXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792317588;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=PMNEMATXNSL46l8gkfA+WQN8DkY+8aPyBKhyMkqwCcY=;
 b=XscIaiawuE+elIDfRM5dvXQh25L3LxEJnKAfybTUjUyuIdhTrNHYqqXpbkpV5XQCZGB2
 Q1aL55Yk1CQ5lTpsRgelfy3E8CpM+atWSllzgjGNwBv52HrQKBjN9UF4b3/Xxj3y22hnb
 cWYmwNrYAXMr65zq2b6pdrT+4p9T7vtGOwxJmQI/XNet5xw2+CU2FhHrdnV8v8BEWebRp
 aXF0cD6p6CqmFAHY7Z86Z1DNP6wRdiKSy/Q5xgAFuQzX73suzSyesnpy5hECPcZjxpCeM
 XZ95F4R4xzWtRh5nr4OdTK/qR9OEpBAAyduSa+TQxSCxUIq515/QtMOx7ry/332t+eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TOlG4r6s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TOlG4r6s
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 602A880FFF
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:59:46 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso136088066b.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 02:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792317584; cv=none;
 d=google.com; s=arc-20260327;
 b=RyUdTZ6yXqIYQOOwDaVJamcBIb8z+C7bvS+87Dv3sdrSfxrq1djcFFJUv4DhYQ2/RJ
 BgCeanptvrG55UAKJV9BkzMa0kKp1UYsSVv24fhCuO/KvxT24fhbqRMnJaVwoskPE/jd
 zp7XnvaA2752tIRSZ5GO6FsM29xB5pRrbSCc5VYJ0+5EnF1EeTa0hN6E0t2mGWNwhWFI
 5fkFjpM0WRkK+r8gaBmMk2FdtXo4LOLgfsAGUDx4zjNbu/QQqP32QjQpsZApDFUUcAK6
 qssvIs7KbgzaqnFUvPQHhccM5VVvWUZTrLJ+U5Rg9DZ2zsgKkk9eKOATjQBJeAXPeUIN
 G3MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PMNEMATXNSL46l8gkfA+WQN8DkY+8aPyBKhyMkqwCcY=;
 fh=oIMmC8iu+RpL9QS0aPIrVHvb7dY/DmDKYgM4/PZle3M=;
 b=Ikq/GhFiC/kfJn8OsV4yPmIxy4LRrL+0QkASElxhuhQGbNyALz2JOGp4ESiLD6x2uo
 Un7K4xhr2e0u/JacAA3Wf/gl4RRzv/25NX5YvPo2Va/fgLwnpYlk1am0gSmPUmIPIO5E
 hgimqA/FFLOOL68pdW41BzYiq0pjD5M9GkIo7KBAcKHUtMWifVvZGOv5/fNp+hbkpcIV
 dqs/wWbX3wlA9YEP8ENLaXDZ1tsZ0yN131/OCtzUTMsjAtEFYYvbnifpJgsTzb6Gf8VN
 hXmLTt8VNApcuIYSBmg/9WZWqBkJI1RoG1iKgHi6GTpRXZ7egTmA2bVcTkEmnq0+VKzy
 iAiQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792317584; x=1792922384;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PMNEMATXNSL46l8gkfA+WQN8DkY+8aPyBKhyMkqwCcY=;
 b=TOlG4r6sFMPNwfsAYgbwXeeDd7LcuzwfofQ5CJSL5QCIHXOaUT15R7eYV/ENvAnSlN
 8Vk/WClPkae0yoe/8f5jZst/481KhbFfFN08/++FT9rJ0NynV8RbKZFE1y8gBIfdIMcl
 llsAYsxkPxCGZJ+matCKBhlb3br/N90fgIw6XPiSHDpkJOIjq3nwQpL0qcY3Qxwy6V30
 cBDA5blwiyUrxBoQGRb2eygZZWXFrOQsFbr6mWnOgW1fKRPQr4wmnC3w8iWfhtudIB9V
 DJvgF8yWJcPHsocwnOIBm4jro1k0xhBhZ8GK4BVKecITnkd4S9tbiIH0TRT/Zb7I070n
 SbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792317584; x=1792922384;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PMNEMATXNSL46l8gkfA+WQN8DkY+8aPyBKhyMkqwCcY=;
 b=dY+gnGOxaw5I5FKqMfjg9CHAFe4zS9XtoJW1wPN7vbUCFQkwMlSD5/CiGqDed94T0M
 yFCO3Tp6s9EfowwhCDdYQPyGRqNnlvpONpm9q1hJmYbY2mh9dbQXwrgPzfk3De2nY69k
 FvsZDKzzPDR7pIlVuGtuuccHj6LhEeDG94RYa2UPuAhV5e4lqV/qdpdGP2J6iWl6OLeY
 3/9y/rMJZuUA81vCaGO3WFBs4Gn5cDmd3MSvB1TyT4DlegFxoqpUYw28cGAhnvCfatah
 ow3IJJjMx3oKgiCxiyBrtev+Tqms/RWdaUNPwXeRa2+MqSt1WCLMgf3t+sK8CdM+TXIr
 UqwQ==
X-Gm-Message-State: AFq9FYJrjDizj3TKI5farmGdjNSTNfp3qqGYRRtm4tgCAr/ssn2C0qyP
 Zx63ebBEU96DEQIq+I/BTlGRAz2o4Gx0h5W4c2HIwutXHtpHBEeFNQvsJQp6IFCkoNV2ngpHR/f
 76d9XKMqeP7kEhdwCbXELBtnpa9B7oxk=
X-Gm-Gg: AYBFou1/5nx71YF3jO0P8XhX/pvBh3e+0r+/m4jcdXgGikFLN9OTNu8IrFzKxrv2xEY
 GWKkbl3BEqfQACSApJUPyqMaMWy4H+fFq4f4dxBLbqauJnRQV/t6iGpySn3BoaeBoq4RNCH22ON
 CQkaBff++ETsd7cdFC4H1meZslTk6/KE4kZwCBzfTKFirNwzOxgZgn1qDtvT4hUAPQyyD+VPWNr
 5cndukAaeVkE9Fit4grJ4qvAEI2kwz9YmfMv3aP2TCmvjntrWtvp63ElmzNBM0+wtR8NDgKFkiH
 vF4BGKQRgn8CIWzVlFnHS2iFwO+d1UuhEB3NsHUqYO84rlKX36r1caM=
X-Received: by 2002:a17:907:94d0:b0:c41:285a:46a9 with SMTP id
 a640c23a62f3a-c41a08d9fc4mr307608266b.46.1792317584049; Sun, 18 Oct 2026
 02:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-qconfigdoc-v2-1-b2338cdd8a35@gmail.com>
 <CAFLszTjZ9-u6mTdw3HN9xv1YLwS2GL7nF57wuK-=dJx0OX2kwQ@mail.gmail.com>
 <CAC928HZjd6Dh0LLtJRjAi1U54BuZOCJuhC-iwQ2qnf0cfDaOLg@mail.gmail.com>
In-Reply-To: <CAC928HZjd6Dh0LLtJRjAi1U54BuZOCJuhC-iwQ2qnf0cfDaOLg@mail.gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 18 Oct 2026 11:59:32 +0200
X-Gm-Features: AclHuK9fb9RGesnfMaK5ga9PPFW1vFTumEc13gpEHvQgW483_xa3f-BZORrurAo
Message-ID: <CAC928HYRpC8Vrn7+__8FOYS7fH4=TOyyEvgEaP5NirOvMZ5KrA@mail.gmail.com>
Subject: Re: [PATCH v2] qconfig: Improve the documentation
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Please, ignore my previous proposal, below. I've just sent a v3 with
fix and (hopefully) improved examples, including whole value matching
details. Thanks.

Regards,
Massimo


Il giorno gio 15 ott 2026 alle ore 18:17 Massimo Pegorer ha scritto:
>
> Hi Simon,
>
> Il giorno ven 9 ott 2026 alle ore 09:20 Simon Glass ha scritto:
> >
> > Hi Massimo,
> >
> > On 2026-10-03T17:00:18, Massimo Pegorer <massimo.pegorer+oss@gmail.com> wrote:
> > > qconfig: Improve the documentation
> > >
> > > Specify where the database is created and under what name. Add text
> > > value lookup examples, including quoting, escaping and regular
> > > expression cases. Update other examples, or just their output, in the
> > > section documenting -f option usage. Trivial fixes.
> > >
> > > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > >
> > > doc/develop/qconfig.rst | 40 +++++++++++++++++++++++++++++++---------
> > >  1 file changed, 31 insertions(+), 9 deletions(-)
> >
> > > diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> > > @@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
> > > -    tools/qconfig.py -f SCSI ~BLK
> > > -    3 matches
> > > -    pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
> > > +    ./tools/qconfig.py -f PCIE1 ~PCIE2
> > > +    10 matches
> > > +    MPC8548CDS_36BIT MPC8548CDS MPC8548CDS_legacy kmcent2
> >
> > The sentence above still says 'to find boards which enabled
> > CONFIG_SCSI but not CONFIG_BLK', which no longer matches the example.
> > Please can you update it to refer to CONFIG_PCIE1 and CONFIG_PCIE2?
>
> Ouch! Sure, I will fix in v3, sorry.
>
> >
> > > diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
> > > @@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
> > > +String values can be searched for, too, including regular expressions, but
> > > +taking care of needed quoting and escaping. The values stored in the database
> > > +are the ones from the Kconfig files, before expansion. Moreover, since they are
> > > +stored with their double quotes, the quotes must be part of the pattern.
> >
> > This is much clearer, thanks. One point I might have missed earlier:
> > the pattern must match the whole value, since defconfig_matches() uses
> > fullmatch(). Otherwise a reader might expect something like '"arch/.*'
> > to work. Please can you add a sentence about this?
>
> I'm not sure I follow your example: '"arch/.*' will catch any configurations
> with CONFIG_TPL_LDSCRIPT values starting with arch/ and therefore, from my
> point of view, it is working as I would expect. The '.*' pattern matches
> anything including starting and ending double quotes. If you would like to
> utline that the pattern must match the whole value and not just a part of it,
> maybe I can reword as follows:
>
> The values stored in the database are the ones from the Kconfig files, before
> expansion. Moreover, since they are stored with their double quotes, and the
> pattern must match the whole value, the quotes must be part of the pattern.
>
> Would it be fine for v3 ? If you prefer anything else, let me know. Thanks.
>
> Regards,
> Massimo
>
> >
> > Regards,
> > Simon
