Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D4CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 12:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D8B0C80E9C;
	Tue, 29 Sep 2026 12:44:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7Dhjr4TzUqx; Tue, 29 Sep 2026 12:44:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0F5C080EC1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685879;
	b=pBuT8hMeXUVY4tGkchSUgHFyTDXPOzObrA92Gte5pB+fLpuG/4gn5mfVHMKKrfEDedlr
	 H4HQh+DEKl0DkDjweRjEeYOvUrF96inVcyajp1eWswpmmCIeXZFwi3et0JkJxwb/m5Fvr
	 wWXAKDV1FTq3cNQCxWuSNNREVJ6GS0LppD/nvWKVemZpyexaF/ihZ67dEXxLQx/fgFaLS
	 k2c1OfxvNjmvknsrN4LwV1mjbfUdWmY/6AlKjcEJ/WkLJCbyMRCbgOUtAmO4xLg3Kjsff
	 thPNW7P+kZE9yEaGp01oGN78pq/vqaTVt4DHEBRPD+ktwHP2CgOwOcEbcqphfjooIng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790685879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1RG0PiWBVWeztpNsM0JI2cjibSlsjisPV2D3mmVcQL8=;
	b=Ezo17xlfmx08obfPA32bxB90AkJ1MMzUkkGDogbldzkKTOP2iu9FNpTYMewaC5OY4nO+
	 27FeS16KL06SauUtcmT3vT94AEWehU+tNGK7Ajp4nEJ7zIAk+JK5+1dNqQkVoiK4vMHuE
	 DH4i+Vt91DAR//8z6qfc2iu7jDh5LEemW/9FHjY+MDYQPHHv7D37SvKxAB2S09vnD4uOv
	 DK3Ihn1uCOG8OnQYxXdRkubxZcgmCJZKtGVk/Al64zj0Fpo/bYGytj89zH4yV1kcQrhb8
	 fKLHmL8UXL7qQwh/XeMslykjFz/H7Aj1ZOWl8p1rlgD3vJGTwnVWuysSK8CvfZ0J2MQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790685879;
	bh=1RG0PiWBVWeztpNsM0JI2cjibSlsjisPV2D3mmVcQL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hr5Pw16V4EEZV6QTMUnWo1zyZ8dsNNGA0EuK4KMDNPiaufgJ5X4geH9TZa+dTsOZs
	 hkeWaN8G9DdsKZ6NTv5ioZn7jCTGJZR8lNm7bc9J/2JmbwPMm3NON+7zOCsH7pSexE
	 wyvVWmJcJEJNj0KkAApOP5C27RtrGXC4MlFnuQOt66oZrmJ5TJNB+En5ESJSOAwqP8
	 q34dnHxjUomdkoLuHrm30ue3RlVxUiIuuPxKYZ6ErbNaRjzgkONjgQA/q3a4gxq/qs
	 PqUwZd1uHVWvceKSZ9hbjD3NSASrUXWZNZ8Cl/wZ2p+VQt127C0QrduyOEOfvGPwS5
	 PT9afdttqm3Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F5C080EC1;
	Tue, 29 Sep 2026 12:44:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F070335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34A1B40304
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lx6Ig3jEB7SM for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 12:44:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D4D7640082
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790685876;
 b=Ey9N0qOEnMJT7s4OMa3G80LwUMdHOs3HAA5mHZW76FrO36pkgJM7Zfj8HeXz2VZVOkEt
 ywrwv2NGBGfClaY5uhqgFinBQeVXl/Q2jEQUdFwmWFoRiVlEhE89iHjFna5nwwj6Pq0ub
 Wbs1O37hzaxR54MPjsI+8BdaQ2gHHxLn+LvV5575vRv7mIQbRkIqR7tOuswRy3UslCz9C
 8yp0v1p1Nt+gL54buVwfA/YksvjuZIS5yp/fOALyGjBzkTzQ/SzhCOge1MHaTZT1RjHn/
 VThnpZL/CVh1Peo+aPSboIw34EW+p1j78zdeJDeKSSUkM5req8c1MVK4VOG5/8ZQAAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790685876;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=1RG0PiWBVWeztpNsM0JI2cjibSlsjisPV2D3mmVcQL8=;
 b=I8UZy1016HEMv0/mbChe+9raswb7K3NZ0qQosTYsAyxtfLK2q3yC1OkamBSyf4HQtNQG
 jnn5F8gvMWeDGArS+To8boASnM0k/uaZfqMtVe8uByYi1Txkgw5pn5DL44PsRNqwcMkmu
 jiZcY+WmQIqIcnYl/5a+7mH9quN0NMeB8tI6ssdte6iVOVebmnT1pSY5i5u6kSnEDP4dM
 5G102XE5RaaH0zB9qefxbdTGQG6hr0vzaL5qKI0TAvIVyWnleUVVnVz+w5XdCmYsIB3hl
 NrDxuROsOKrjG4ONrVyV6EMCUS/QCrO+uzm2XX93ZciYlHQr2TYLTg0rwI0qB1JCyaA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=iaRhUEen; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=iaRhUEen
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4D7640082
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 12:44:34 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2940ef15d3so520849766b.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 05:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790685873; cv=none;
 d=google.com; s=arc-20260327;
 b=cX850Hl/oKxwPnTC5sQEAGGQwj9ljSsPK2mYxml4Evy/8/E6Kg1hdej8kxh2TQg7V6
 P4lIJGiP6DUL82Ov5AtOHiRn9vVbBs9O1BWVZwE1++fIkDgsKNDejMhd0LrXtIxmvr/U
 X6sBsGe14+dDqTaI8o0K07YAF0r+TUB+AcwwWbp/tn3YuJcF4GITsntCMcAm+menurCA
 VWWNIcgEVIjvYhxEQIDhJkpMWrKIZCI+VFyu8AxUJjjTcj4yTK2AFq70YdwuUIRLA6+q
 QfUWBNO+3ygARTcbhwa67kSArdylTISicjI8PLChIDG9hNM46BfwN2xmg7+ooS2B0IFR
 qL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1RG0PiWBVWeztpNsM0JI2cjibSlsjisPV2D3mmVcQL8=;
 fh=rdU5DuQu6+OzdeGWZ9v3GIVQfOIma9eLz+fkto5J3FM=;
 b=gTj9LXqXiEedQOTKbedBaa62n1dBD0EA89ef6eehCYzI11O7wNJ0EK3n7uOa++n7ey
 LYqNiwjhE4DdpyBxNCx2AARLVShBCV92YERUTa2bK6UtrhveLYFuu2HXyHF3KkLQaaSO
 6SbCSaRhrGspiTsoiOBn8OqAuNOhF23la7678GQvkWlZK8Mj7eUvukHrIyB5d8g8MPOu
 1saZRE9RVzBLQiwRwwDnTlGliSNGw+60sM6rjHlfXvzN/hOmpS641xbpqdW+p9WaJLJy
 Qjfh4jfnqvUCYax98QQEBsnBnjQ+ylPBneKa9S2+muHlFyuknVA2wNJhnk0ggw97yoZS
 gskw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790685873; x=1791290673;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1RG0PiWBVWeztpNsM0JI2cjibSlsjisPV2D3mmVcQL8=;
 b=iaRhUEenz0lQ1tbySOMYhwDIrDZd04lSuRjwqhMscteuca3rCQzOi7vj20tVBceRpN
 V9djiGg6Rzy5g00RzYhVKdk70YSCXQ2BsYC+jPSiedRCpLIkIILuLPPVo830sxlRjza+
 fMXapK97Tp9RhZMCbFikbFL3xVuwk2cEC/4IiDtuMbtRx0ai2lRYdwL0LVahLkWG2tz7
 NfAAdi2Xlweye17Vc9xo7g70FzRuH/A5wug2v+tSzryCfCzeKnMxxCsOZjqxybVHq7pJ
 2WUfWDS1QFh0vQ/LsPVRsonvDTl9GRGlEZIPscYN1VRJ0zwYH9xtR+tDAkYLnWug0M/U
 MoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790685873; x=1791290673;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1RG0PiWBVWeztpNsM0JI2cjibSlsjisPV2D3mmVcQL8=;
 b=ZzpRCg9h7ZPMHRqMylQ5MHfaDFJd6P4MW0Lu5HSwl680HxM0uWabQsATER4UJ0iPse
 cUTn2koc1BeNEyY2rieCa5X50aa+ru2vHKFRENmHLB7LiCn1dxDJDQNMKLlx+qt1/Yer
 FhxnkVpvMpp3hdB2KKb7/OlmW3UnYZs5O7nxIvyc4E7mPzr6wfP0x7D9lCKcv5ChgJzi
 pO7dnC1S7s4E4juRrMEqQTvi/D7V4NKARqPkQqSuQQlfEMRRyMJqwh7JecM8uhUDfljD
 gVzEvNM5bcpIFSd4h2aYs/nsMCNYbHbwuijyv8/BSDi9O2rJwd7Leg1vdBNU1GHI/exb
 4Atg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVsNlrpg+AC8TMBnouKtarYMaJ8ZS+1pvII9RrD1fnP52mSLCrWod6HgvqYuDaCjli//jwlY4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kD8I4kCdHjQE8i/PHctl0ftb8KcF/5UY5FutlNT9zsR60WtSh3
 Qsfn3YJY8QGTSiu3Ac0xOm46eMW0C0wXUBP1BzlxLI2G+QSlVyBHHubQsCR9xXuwrKzeSuAg6AD
 KbJ0wleSgGwJbZSoIXm+RjED6flKtq0rkiVmHc2KFMg==
X-Gm-Gg: AYBFou1YNEhkcVExOxq/VhY9lymOlskaPPY7F1eOxaZngYhBwHw5TNip4v17YXHqLu0
 fAxbwxMoXvRKlKI4wJME4NeIQ74IN/ILNH5SOAJVGxJhWBDYznBYEfo8ddkAqVTmps48Ih0udkK
 pNevVQmOb1pdNmpLWeOAERF11qwZLXzIJM/l8Dab/SImVXQh72FZyXRFLQlDh1/fd9H6fHPHGV1
 f1RPOMjDt9fKLxj5r3oWIr8W7PnzUwK4m4u21sUMcSGRGIv6ZSNQjOqLeqZrS+0uSsHRkK87khQ
 o2ZrO50a/atQBGXq5s5y1+bfENtY/+qJimb0STwWt9Kd+YAPX6OMcmetc2HVbXrJcTgWjRWnpu/
 zLkI3ESKDknFSYIvValcDjFzyEvaVn1SrsYcHnWX13gdcpqJ9NZK5ZrkITe6SeQ7rFTjcqPmnn6
 I=
X-Received: by 2002:a17:907:3c8f:b0:c29:f5d5:5a92 with SMTP id
 a640c23a62f3a-c2ac23ec44fmr1379398666b.28.1790685872667; Tue, 29 Sep 2026
 05:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-clk-mediatek-cleanups-v1-0-4dccf8ed98fc@baylibre.com>
 <20260917-clk-mediatek-cleanups-v1-2-4dccf8ed98fc@baylibre.com>
 <9cfe24d0-cfca-4d15-9aed-d1d9e0e2b9c1@baylibre.com>
In-Reply-To: <9cfe24d0-cfca-4d15-9aed-d1d9e0e2b9c1@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 29 Sep 2026 14:46:35 +0200
X-Gm-Features: AclHuK_SuLsshwnUMAXUPJBWAI4WvF6sT7B41KF5tr5zwOZR6RzfsdWI1aebPdw
Message-ID: <CAEHHSvZJ3VoJYxZkoOLsx_Nc83UwV5hr=079EDqr+=zzKg0Eaw@mail.gmail.com>
Subject: Re: [PATCH 02/11] clk: mediatek: add a helper to declare gate-only
 clock trees
To: David Lechner <dlechner@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Chris Chen <chris-qj.chen@mediatek.com>,
 "irving.ch.lin" <irving-ch.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le mer. 23 sept. 2026 =C3=A0 22:33, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> On 9/17/26 7:51 AM, Julien Stephan wrote:
> > Subsystem clock blocks only provide gates, and every one of them
> > declares the very same struct mtk_clk_tree boilerplate. clk-mt8189.c
> > already hides it behind a local GATE_CLK_TREE() macro.
> >
> > Move that macro to clk-mtk.h as MTK_GATE_CLK_TREE() so that the other
> > MediaTek clock drivers can use it too. The tree name and the array of
> > external clock rates are now passed explicitly, as their names differ
> > from one driver to another.
>
> I thought I had cleaned all of these up so this is no longer true. Howeve=
r

Hi David,

Agreed for external clock rates but the tree name can't be derived
from the gate array name everywhere.
For example, mt8365 has mt8365_infracfg_tree for ifr_clks.

I forgot to rephrase it in v2, maybe you can do it when applying if
nothing else comes up.

Thank you
Julien

> I still would keep the argument explicit just for the sake of better grep
> results now that the macro definition will be in a different file.
>
> >
> > No functional change.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  drivers/clk/mediatek/clk-mt8189.c | 23 +++++++----------------
> >  drivers/clk/mediatek/clk-mtk.h    | 22 ++++++++++++++++++++++
> >  2 files changed, 29 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/clk-mt8189.c b/drivers/clk/mediatek/c=
lk-mt8189.c
> > index 3724dffcc3a..8df09f4a129 100644
> > --- a/drivers/clk/mediatek/clk-mt8189.c
> > +++ b/drivers/clk/mediatek/clk-mt8189.c
> > @@ -1994,22 +1994,13 @@ static const struct udevice_id mt8189_vlpckgen[=
] =3D {
> >       { }
> >  };
> >
> > -#define GATE_CLK_TREE(_name) \
> > -static const struct mtk_clk_tree _name##_tree =3D { \
> > -     .ext_clk_rates =3D ext_clock_rates, \
> > -     .num_ext_clks =3D ARRAY_SIZE(ext_clock_rates), \
> > -     .gates =3D _name, \
> > -     .num_gates =3D ARRAY_SIZE(_name), \
> > -     .gates_offs =3D _name[0].id, \
> > -}
> > -
> > -GATE_CLK_TREE(perao_clks);
> > -GATE_CLK_TREE(imp_clks);
> > -GATE_CLK_TREE(mm_clks);
> > -GATE_CLK_TREE(mminfra_config_clks);
> > -GATE_CLK_TREE(ufs_config_ao_clks);
> > -GATE_CLK_TREE(ufs_config_pdn_clks);
> > -GATE_CLK_TREE(vlpcfg_ao_clks);
> > +MTK_GATE_CLK_TREE(perao_clks_tree, perao_clks, ext_clock_rates);
> > +MTK_GATE_CLK_TREE(imp_clks_tree, imp_clks, ext_clock_rates);
> > +MTK_GATE_CLK_TREE(mm_clks_tree, mm_clks, ext_clock_rates);
> > +MTK_GATE_CLK_TREE(mminfra_config_clks_tree, mminfra_config_clks, ext_c=
lock_rates);
> > +MTK_GATE_CLK_TREE(ufs_config_ao_clks_tree, ufs_config_ao_clks, ext_clo=
ck_rates);
> > +MTK_GATE_CLK_TREE(ufs_config_pdn_clks_tree, ufs_config_pdn_clks, ext_c=
lock_rates);
> > +MTK_GATE_CLK_TREE(vlpcfg_ao_clks_tree, vlpcfg_ao_clks, ext_clock_rates=
);
> >
> >  static const struct udevice_id of_match_mt8189_clk_gate[] =3D {
> >       { .compatible =3D "mediatek,mt8189-peri-ao", .data =3D (ulong)&pe=
rao_clks_tree },
> > diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-=
mtk.h
> > index 9244542a2a5..e3a7ff75734 100644
> > --- a/drivers/clk/mediatek/clk-mtk.h
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> > @@ -8,6 +8,7 @@
> >  #define __DRV_CLK_MTK_H
> >
> >  #include <linux/bitops.h>
> > +#include <linux/kernel.h>
> >
> >  #define MHZ                          (1000 * 1000)
> >
> > @@ -274,6 +275,27 @@ struct mtk_clk_tree {
> >       enum mtk_clk_tree_type type;
> >  };
> >
> > +/**
> > + * MTK_GATE_CLK_TREE() - declare a clock tree made of gates only
> > + * @_tree: name of the struct mtk_clk_tree to declare
> > + * @_gates: struct mtk_gate array backing the tree
> > + * @_ext_rates: array holding the rates of the external clocks
> > + *
> > + * Most subsystem clock blocks only provide gates, whose IDs are
> > + * contiguous and start at the ID of the first entry of @_gates.
> > + *
> > + * @_tree is declared static, so this must be used from the file
> > + * defining @_gates.
> > + */
> > +#define MTK_GATE_CLK_TREE(_tree, _gates, _ext_rates)         \
>
> I would be tempted to put _ext_rates first so that they line up nicely wh=
en
> the macro is used. It will make the lines look less noisy.
>
> > +     static const struct mtk_clk_tree _tree =3D {              \
> > +             .ext_clk_rates =3D _ext_rates,                    \
> > +             .num_ext_clks =3D ARRAY_SIZE(_ext_rates),         \
> > +             .gates =3D _gates,                                \
> > +             .num_gates =3D ARRAY_SIZE(_gates),                \
> > +             .gates_offs =3D _gates[0].id,                     \
> > +     }
> > +
> >  struct mtk_clk_priv {
> >       void __iomem *base;
> >       const struct mtk_clk_tree *tree;
> >
>
