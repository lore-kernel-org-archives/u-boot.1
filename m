Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BA4606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VtDEE4cx;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=FYuqBI7r
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DD9160D50;
	Wed,  4 Nov 2026 14:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbcSZjRYtuPK; Wed,  4 Nov 2026 14:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3E7B606E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793804031;
	b=q/k7ibI5xGo09vDsHeexXB9gMYQA76cVAcJU+EPM0CtJTq/fOi1OzYg3fcjAjf7ln2o0
	 wkXZZ+kF3wg6vcMeFQwvrHXgbaPcfSaZ4LXiqLfJlOU+ykI39HSAQj9i9wiA94k6ir9Xr
	 PwuL4kuuMU5/9VDxBnFD3BghVJPDJM3x6/6KYb3SJCITq60nrmgxY80e+gDe9uSmZ0p6r
	 +Yw6mLxeTeqYJ2jE3KXtxLTPiCuqCZeapOoto5BhUbDwyNKkHADZzyGOzrFX4GukZTGh+
	 YYLYT1VXLD72juBLbwbFIa1W6135QPQvL47kGb6GWuGeiksDuABOl+FdadZJ05DDIdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793804031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wnbUF+L45F0S3guwX0Ofg4QZVsmBppGp7qeoPB6Yyj4=;
	b=kdLdeoSJ6Bd4eUFljeXSQTZah+ehFxPPux7HBwM1Pv0JEh7XsAz+/VK+QlMYMIaOrIDj
	 UQ1jEvaFN/LBkj+msOKVWrDbwZeT2hqmlk+W8iet2yu0bJpXerwfbQJtcsiJWFBMIVM73
	 Jbi9v8MaGIa+aUt35R1B4P52YTctP0wnOPdH0yCISS650nN65R3K0f2vKKG654sqTJ7cN
	 OvxuENVpfhPexcszXx81M6hdvvPSOGfNnO3/r2UE0zVHVAtwmayIInwQxIGc4iD4Ww2DE
	 NAKEAqsoa1kRxXmF8D7l2m7P8Bo85h+D/VgFdTJIDcavuw8yNaNqIz1NrR2For/S3VQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793804031;
	bh=wnbUF+L45F0S3guwX0Ofg4QZVsmBppGp7qeoPB6Yyj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VtDEE4cxoVXy6V8HYCEa4/JEktiYyx/6TSz+4sOHu/YT0j2fivvGwWibpBBsxPzfY
	 /4osNBXJ48rkJxF+yzNpRvaQkNpcCll3Ir5lwqVl06hlCmEGAue9pSKWxEdLEcUQon
	 oidOaTKpL29N+pyeczYEKT4DqouAaQlvGiE8UVDzkRqzJQMtxkdVQ5s8DZ29ANGU5d
	 S1FEcE2G9v2ptkdQ7qHVocFMWCOwhehm8Oih+By4QjDT09DjMK3F4Yc4dc0uyUHmI9
	 q7kZFolwM0fGE7eIQzO3MKpzS9BaaA78wUFQzmW42qesQy/f/DhI2LH3pCWsuLojaf
	 XBIFVJd1t7DUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3E7B606E8;
	Wed,  4 Nov 2026 14:53:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ED4932A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8B81808C8
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ywerYyWAacxq for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:53:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F05E808A9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793804027;
 b=OWcG9kye3t5UsgqhWtkt5KVy8XpNMpt7vudAubhSf3N23MIpphEAviFf6n1Dov3mPW2T
 YgF4S5gRpZi5x2zvefGcfxCy5yGra+7+htwJpfFXjqeFG6LQkp3lBQnQjnsO4BgL8kHlq
 4fqjCMBJe9W9onfq2KlT+h/rstduEOV4Me9OSMHVBYhAg/6wqB2D73sXquCJLxeJ/AEzY
 FK5/+vwrXEdYgNrzxvQ/EFxz9QZu/3fC4ljH1yeQpYE/CPlpevHPq5N9VYBsLLMpy8az3
 kJrWRazKRPn1PtzEI+dbsFQelBzRQWjP54z5fLK7eLnXKjRFy0r18/TCl7baSxHFwEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793804027;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 User-Agent:MIME-Version:X-Rspamd-Queue-Id;
 bh=wnbUF+L45F0S3guwX0Ofg4QZVsmBppGp7qeoPB6Yyj4=;
 b=fRTqgSVyQz8vtaOWuKWkOOP9MzZtn365nG3OFSZIJS8W7Kc6oDlTMl4d2FHVm5Ml6Jae
 1ikXcjvptyMj+liHXWb3SClqaBSSGRp6WwO1mVRr6ghnCOnjirmUEX3LgXa78Ti6kpOuC
 Ou4WzHewgikEcYDr5g846qeAVnLorg2WfJiitOh5mSCvWBu1dKGI16C5YfbfTNAXdFYX3
 DF9x+Llzg656eNZS6oWMpiJ3W8lXSwRpVCJwmLbIgBBXJQWlD9FnBey+Vl4XsiTgihjdS
 U5u/6xViC7PJY4w8NC6em4nbvyYD0T2kMQ5S7btjZn7mOlhKfINzfCCocOMyR02gHug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=FYuqBI7r; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=FYuqBI7r
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F05E808A9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:53:46 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKT3C1T5rzMlx1;
 Wed, 04 Nov 2026 15:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793804023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wnbUF+L45F0S3guwX0Ofg4QZVsmBppGp7qeoPB6Yyj4=;
 b=FYuqBI7rfmarA1pZ2Z3o+l3c/AKH0GV5zp2PPdYzmQwizp4e0PTvHXykSCbmBF+aE2p1VC
 txoMcfyMKoWWa3q77dpqNQRfeWA77+c/Heq+p9bK5INVWD/LMrxt9FFG4Mh4/tt0Z8ffEO
 KckyFWsgwfUjO7AlYw91afQNOsnnWJQZYBluqc9Z4Ddu0g3j7WsJB5P0OoMFesWUYk64QR
 +idKMqq4BEefbknEHvP+585aV4s4I0HUMgn2n4B990IaonCkbT6smRQwnFAUR4fpUtT0uL
 K398L08SXpNtJVuODDY7Rya64k5yGIQdTPPXXLv44mFoFZX/kRlVs3R58GlDvA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
Message-ID: <8c00021ad99df4e97df9ac75ec0e0705b264f958.camel@dirkwinkel.cc>
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from
 the bloblist
From: Steffen Dirkwinkel <lists@steffen.cc>
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream	
 <GSS_MTK_Uboot_upstream@mediatek.com>, Julien Stephan
 <jstephan@baylibre.com>,  Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 15:53:40 +0100
In-Reply-To: <775e6c08-ff3f-405d-bc5e-6b26ba66e044@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <fa976a04821fac42c0a937305e621c4da20fc04a.camel@dirkwinkel.cc>
 <775e6c08-ff3f-405d-bc5e-6b26ba66e044@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jKT3C1T5rzMlx1
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 08:10 -0600, David Lechner wrote:
> On 11/4/26 3:06 AM, Steffen Dirkwinkel wrote:
> > Hi David,
> >=20
> > On Fri, 2026-10-23 at 17:32 -0500, David Lechner wrote:
> > > On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
> > > reserved for the DRAM controller depend on the DRAM fitted to the boa=
rd.
> > > The devicetree built into U-Boot can't describe them, but the boot st=
age
> > > which initializes the DRAM has this information.
> >=20
> > I also looked into this a while ago and found some code in coreboot rea=
ding
> > EMI_CONA/EMI_CONH on mediatek socs [1]. I adapted it to mt8188 and test=
ed with
> > some memory sizes (at least 2GB, 4GB and 8GB work).
> >=20
> > If you're not set on passing it from TF-A I would send a patch for this=
 (only
> > tested on mt8188 so far, see rough patch below).
>=20
> I was hoping we could avoid this since the earlier stages have already
> figured this out and there is a standard way to pass info from the earlie=
r
> stages. In the case MT8189, there could also be reserved regions that I'm
> not sure we could get this way, so I'm not sure this would be a universal
> solution for other chips. And would prefer to use the same solution to ge=
t
> the info on all genio series chips.

Okay, makes sense. If you have some version of TF-A / DDR loader with suppo=
rt
for this I'd be happy to test that / potentially switch to it. I'll carry m=
y
patch downstream for now.

> >=20
> > [1]https://github.com/coreboot/coreboot/blob/main/src/vendorcode/mediat=
ek/mt8195/dramc/emi.c#L670
> >=20
> > +#define MT8188_EMI_BASE                        0x10219000
> > +#define MT8188_SUB_EMI_BASE            0x1021d000
> > +
> > +#define EMI_CONA                       0x000
> > +#define EMI_CONA_CHANNELS              GENMASK(9, 8)
> > +#define EMI_CONA_DUAL_RANK             GENMASK(17, 16)
> > +#define EMI_CONH                       0x038
> > +#define EMI_CONH_RANK_SIZE_SHIFT(ch, rank)     (16 + (ch) * 8 + (rank)=
 * 4)
> > +#define EMI_CONH_RANK_SIZE_MASK                GENMASK(3, 0)
> > +#define EMI_RANK_SIZE_UNIT             SZ_256M
> > +
> > +static phys_size_t mt8188_emi_dram_size(void)
> > +{
> > +       u32 cona =3D readl(MT8188_EMI_BASE + EMI_CONA);
> > +       u32 conh =3D readl(MT8188_EMI_BASE + EMI_CONH);
> > +       int channels =3D 1 << FIELD_GET(EMI_CONA_CHANNELS, cona);
> > +       int ranks =3D (cona & EMI_CONA_DUAL_RANK) ? 2 : 1;
> > +       int quad_ch_ratio;
> > +       phys_size_t size =3D 0;
> > +       int ch, rank;
> > +
> > +       if (readl(MT8188_SUB_EMI_BASE + EMI_CONA))
> > +               channels *=3D 2;
> > +       quad_ch_ratio =3D channels =3D=3D 4 ? 2 : 1;
> > +
> > +       for (ch =3D 0; ch < min(channels, 2); ch++) {
> > +               for (rank =3D 0; rank < ranks; rank++) {
> > +                       u32 nibble =3D conh >> EMI_CONH_RANK_SIZE_SHIFT=
(ch, rank);
> > +
> > +                       size +=3D (phys_size_t)(nibble & EMI_CONH_RANK_=
SIZE_MASK)
> > *
> > +                               quad_ch_ratio * EMI_RANK_SIZE_UNIT;
> > +               }
> > +       }
> > +
> > +       log_debug("DRAM: EMI_CONA %08x EMI_CONH %08x: %d channels, %d r=
anks,
> > %llu MiB\n",
> > +                 cona, conh, channels, ranks, (u64)size >> 20);
> > +
> > +       return size;
> > +}
> >=20
> >=20
> > Best regards,
> > Steffen Dirkwinkel
> >=20
> >=20
