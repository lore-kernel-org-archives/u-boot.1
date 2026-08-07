Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC7EC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5F9040A3D;
	Fri,  7 Aug 2026 15:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yxcmkh3YaB43; Fri,  7 Aug 2026 15:12:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17BA640A40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786115559;
	bh=lTzazjx3LPv+tQLEzyjvrMyrtR3d/SOFsr5dVVqL2pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MQF6ETZgfXbZM8FZ0aEfR1+I0Bdg24zq7a5OH7cSmEwa/RA5gui6LdkkouHqcsyiH
	 H8V+tIAwcsl3TVQfrVLUwrEEYxazm1p52McFFBzf9Gi8v6EzrmRNFJ2lodu3UcA3S/
	 sXtA+csl7Yf1lMnr3qR955/tYfWJjI7wn2RF3kDhPCaFhgPheaxHU3mTUUwkautyjf
	 4mEamP4MUGO3r6a8bgJb1EVf6hI5FcZPR1Ds6eBwxBYUWbGdTYDQgoN6Lm7k+wYdQs
	 /pdf52PyBYE6qJxI1KAtLWy7S2zeglTXIA1wq8TicwzomQ/SqgRd4nT4oOrUagpglZ
	 T4iO5i8nUhCaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17BA640A40;
	Fri,  7 Aug 2026 15:12:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8514DD3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B567605CF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Ob_iIJQHQJY for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:12:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4E13260A7D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E13260A7D
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E13260A7D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:12:37 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a063d211ebso4543476a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786115555; cv=none;
 d=google.com; s=arc-20260327;
 b=CGjAJxNufHCvEq6WGQbXxbJp/TnSAoSyRicc/7u5UkX444eH0azIog8ykFY3zYdnAD
 LM15jdwVelaZmNmbELe6JV9LclxsiK9R4QrdoWKda4i0LI0WQ3NjfsKJaBBjEK9kLvfq
 FXwqxD/koktEI2ytWtEQALMXoVRMc/wsyfgaRlUH30rbYDoz3MKO3/04F1gyKjOLQp5Y
 13hpBTMWgxKnBRrNnCBoiJ2KCfK2eJfXUoCReOttrwPoPVvSWsWSrrgb4+fNHIMdeqQ2
 BWSPD+gpRs+GRwOMpjkJc2fwpZQvnZxO09DA9zfW2G552NXzwfL9OgUavPFRKNByUles
 3JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lTzazjx3LPv+tQLEzyjvrMyrtR3d/SOFsr5dVVqL2pw=;
 fh=Ve5Rf33lTpAQZl0FmIOUMp9/uPnwy1xsgvzmn825Zcc=;
 b=LUd+/fvxg8Rt4bgDxiN2teCMiZp5LvxF2GCpwyPG2E9ryuujDfMshfxbZXJDmKjPK3
 m2ojkPKrbzhno+HtXZ/5O67zegb76fZIeN3nZgbbPUW+cKETDIMJpk/1z0c1QfYXTswW
 jOHDNJyrfHLUBEzr5QNZnTSMImC52a4M3iJZWdqQ8051Giegsb0BAQ7+Kq6wClR1eDhX
 qKIjN+/PzzD+ow63StLWg4LttX/4vX4TEqnU/PJ+bNwKwj5TFyOOtTbKzUlYf5Jr/HGB
 1M66f4daS6zp0xzp4vK6HVXXa3wHhuj8QhICNMxlQyCnO7tn+vqJJrlVShGjEJ9m/75a
 of5g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786115555; x=1786720355;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lTzazjx3LPv+tQLEzyjvrMyrtR3d/SOFsr5dVVqL2pw=;
 b=o3nF/jyuaQQD2MCsSrywLaC+inchqphGJr8Zs+bYCwUqTD2kGj99kcBDCT46OXmiVI
 3TDRIjhVhsq0RJV37NS34yO70fTZNIIaShG6NBRi1yJTyHr9hYSf1ucaoAzLtzK3abIQ
 BdKDlSfcRMWEXtPzMoVBdgRe7tnjl28G++3G3Vua699/XROy3BTaLrIRCoKoEP6FBXWg
 FOUdES6iWiGbwTAAqdoWk5gw+pqOlNJz147eUd52pbyGK/vsOmZyZ4ZN5u5v4RIFQKsU
 ktffGKO4LgX1VA+a8K+56q0LZAqmf4l3O448vCBCrZ+u9g2gEdaZyE9I06t6lwd+7ThY
 Ix/w==
X-Gm-Message-State: AOJu0YyyPKoLxhc/wxZv1fHmdDCn/v2vxxi0vxumPjHAtmfD4/+AAvFv
 3YLKhz+O7O6srIOmxJ4zI/O/l/C6LE04iPlZontzqjYJoQRUKrdfssWZ7Q0hH9I4vnOnPQ+Mrnj
 2TELoF9VleKcRonywpSFqsT3A/Jh7fhRo0fke7WZh
X-Gm-Gg: AR+sD1092cbAVMa6LO3PWyiZ1JDmh1b3DAP2fskaKCbIeOEUNugXASqxzjeJ2J8RWsk
 eNlz0MzM+bOwegLqq/khTBAk1guIm6oL8XjTXxRYgX3iNHDso0zkf/I/LWKFN+0DMYeLsu10zfx
 pZUVY86ekz9icIDq2d+bmv3dx6n1K9q99NoXAivcBKEJS1gobSUevFt89Bmbu9aF9HpR4T3yc8T
 HO8p1ACz/zc+v+U0fFl2f7EkDhgVtu4lzmQmMBXfM06kgHMqadiMo68TAFqn8cngEV+2/wU55Ab
 PyENgintFZdXB0MTc6m4VHsBN7DSW+rbgbhvCseApZY=
X-Received: by 2002:a05:6402:2344:b0:697:de29:c802 with SMTP id
 4fb4d7f45d1cf-6a14f256f83mr11870169a12.18.1786115555281; Fri, 07 Aug 2026
 08:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-9-01746157643d@ti.com>
 <CAFLszThV9-uA_z_Lbpduov9tmxVD6m1dZbQQqiRfHo-aSayYGA@mail.gmail.com>
 <20260807130400.5jcf6vmv4wyblrws@bryanbrattlof.com>
In-Reply-To: <20260807130400.5jcf6vmv4wyblrws@bryanbrattlof.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 09:12:17 -0600
X-Gm-Features: AUfX_mxzQ3KXID12x4qgNyPwTtssQAv-gXkGbTkNXhSz3dMvwohjwpAXh7UjU0o
Message-ID: <CAFLszTiwQMwOTdwNFTHrqgih+v+eMGCc3F1jt=wMd0AJCcn9VA@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] doc: ti: k3: fix pygments warning parsing
 device-tree
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786115555; x=1786720355;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lTzazjx3LPv+tQLEzyjvrMyrtR3d/SOFsr5dVVqL2pw=;
 b=fA0wDHiTNFVQXMrIzo+9am1QgerjvMHHmoLMh26hj2hpAA8cw5uHTuaje2WdA/DQLN
 WkkbECMWkj8r/iXzEK7hVw/obacuoKK8G3Vzz1lSADpSlVJp/w3P2lVBpkcL9nsV2iZ7
 I8Wzl4Vk80rkF2DrbAVuH3xu/KGelI5LNL/Y0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fA0wDHiT
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

Hi Bryan,

On Fri, 7 Aug 2026 at 07:04, Bryan Brattlof <bb@ti.com> wrote:
>
> On August  6, 2026 thus sayeth Simon Glass:
> > Hi Bryan,
> >
> > On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> > > doc: ti: k3: fix pygments warning parsing device-tree
> > >
> > > A warning is emitted when generating the FIT image examples because of
> > > white-space and invalid node names. Fix them
> >
> > Please mention what the fix actually is (converting the placeholder
> > brackets into valid DTS node syntax).
>
> Sure
>
> >
> > >
> > > Tested-by: Anshul Dalal <anshuld@ti.com>
> > > Reviewed-by: Anshul Dalal <anshuld@ti.com>
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > >
> > > doc/board/ti/k3.rst | 42 +++++++++++++++++++++++-------------------
> > >  1 file changed, 23 insertions(+), 19 deletions(-)
> >
> > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > > @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> > > +       configurations {
> > > +           default = <conf-1>
> > > +           conf-1 {
> >
> > This line is still not valid DTS - it is missing the trailing
> > semicolon, and for FIT the 'default' property is a string, so it
> > should be:
> >
> >     default = 'conf-1';
>
> Sure. My aim was to suppress the warnings emitted by the lexer. I don't
> think this snippet, even if completely syntactically correct, would
> produce anything meaningful other than being an illustration.
>
> >
> > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > > @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> > > +           conf-2 {
> > > +                image = "image-2";
> > > +                fdt = "fdt-1";
> > > +           };
> >
> > The two properties inside conf-2 are indented one extra space compared
> > with those in conf-1 above. Please make them consistent.
>
> Sure
>
> >
> > > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > > @@ -466,25 +466,29 @@ choose any configuration at runtime to boot from.
> > > -    /dts-v1/;
> > > -
> > > -    / {
> >
> > Any reason to drop the /dts-v1/; header? The block is tagged '..
> > code-block:: dts' so keeping it makes the snippet a complete, valid
> > DTS fragment. While you are here, the surrounding examples use 4-space
> > indentation; changing this one to 3 spaces is a bit jarring.
> >
>
> The best I can tell the DT lexer in pygments doesn't support /dts-v1/;
>
>     https://github.com/pygments/pygments/blob/master/pygments/lexers/devicetree.py

Ah OK, that explains it, thanks.

Regards,
Simon

> ~Bryan
