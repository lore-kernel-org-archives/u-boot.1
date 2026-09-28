Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD3CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D458280EBF;
	Mon, 28 Sep 2026 17:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRy1HtORxrN1; Mon, 28 Sep 2026 17:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C783380E55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615092;
	b=HuwNX1l0wav62F6B2QaWhRKu2p5vcJoHwZdRFuddWxnoaRpjFeVyBlhtaKS+J6snihRb
	 L3xhy18E3SqxipNrxfls36suVkxgoO/jTNU56EXBL8i4gZ8Z0pgsOMa8/cTxP88dSDQX5
	 gd8V/3muqLyeMhkYv5+HCWwGfNy201mkrANEq10iXyqeUGNd5uNpsJZfDl3TT1aB1q+OU
	 JW9pQOs5udS0LU6qpiznvN+XyFIm9tSK6JQD13HiUPJ7RlgwZ/lkezGE37HcYFefqQE7x
	 ev3AUhNCqcLYbp7kYEtZ674dOVNoGBPPfyQJh+VqdAygtAemeId/Xg+M7/Ud4Kdjztg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=phcRLTKKgINQ2K6RQK/N9bso5ZgVCItElpRLoxtYgsg=;
	b=WovYLtuw4Dyjznqr3wSChmLyUgGq0SRdcaoP7/6TpdDW7utPlsmmrzQk1FTxQ8hpgMxO
	 GA87FZ0nIv6Wp7bLHboLshEmphsv1tRyP3PEWdoVOMltzPWguip/E4kZIO0looGjILTLM
	 XWTceJzmL4ueFcbMmNHfYfyPjSqBUqKro4P+FQs5RrJaBhC5XE5Ojzty9t0jm9Vq/lvgf
	 EY1CcCgniuLYNkB1twwYEX5/vUk3WKZ9uSZPos2PQvuPvHwcjV00/JdmNUxG22ee3K+oA
	 rNcUR77gtEH13J3BrHAeS6ymKYIR3n9ecmtlox3/Ah22j01hgJ01TDhAO/7ETpQncjQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=MQ49T0z+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615092;
	bh=phcRLTKKgINQ2K6RQK/N9bso5ZgVCItElpRLoxtYgsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=InJfXGz85k7FTpMpY26uzn3EHr2mJ3WwsTvmMfp+kKqSElrU0MjJGCrVM4bXMsUAh
	 X2zC+bYwgzlj4OqreDzx97sf0Xf/Gfgmk6A/Ol+KTQ4moZPu8utukb0u5BISy/pllG
	 9JZFShr7l1ZcBSZ1PlWVPQmt0VoRuiTwAq6RnwsjmelQ7jHfDo+zChY0S8Salx72Ec
	 hZDisq57Hcb+CPHnrjGbEb/cnRjAlnmPWcl6itJKUtlZYaPJ1wCpS8d1ZCUqdrPKjX
	 WvFltsiPxytRmcOzqI7MtwYpRBTA4rSKTJ6XWxD9D9jPWTo4qUakYMLxLP0netpgpS
	 EEwYSMPAz7u7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C783380E55;
	Mon, 28 Sep 2026 17:04:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F9C52B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F61C80998
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wNBN5o8yZ5Fx for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 113838096F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790604250;
 b=TuAR9rc/v/NE8R0rQ+f4Lm+9uYAdT/rGHryF9koDvlHyFT8ScK25o30twrFuRq1GvPcW
 qhQsqqMhvzBegGYfyrYTnCEFjbTDDv9FkLwbfsdM6QZyKjj5WKu0nuIqEJIyLTOpR2qvs
 oYOi565eeJtFtRFuJaCzmSteKP0B+icgLEkJQchZZeaPZybx+FkYGhjs3ngh+Ih5DZgQ3
 3/40WeRUz28pxWGc9VeOW1fNuZ66Y2eAlVzW8UqJD6hWu0bA9dios33uS6YUqaf5ImzQK
 Mh87uEN7G/ZV3BdFrE/FgkbFeL5weCKySUFf9Zd3MkbxshfCcAwRkbPxlkFMjh0qcwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790604250;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=phcRLTKKgINQ2K6RQK/N9bso5ZgVCItElpRLoxtYgsg=;
 b=WR/BnhwhEaG5lYzaTTK/nWoOT6t5q8PqWIp1HMTJOyO6PKztxaPj0xGNKv+pQFFRpJBn
 w7I+ql5NOe/0tuHeGZGugt1lSlagXSzSIXq7ihGE96pkElnczVqCFhchF61+37yMJZE/T
 /v6g8FHzOJU7Exd2vFEn8Jm0Yghj6LIVUP+Dwg41zSFfbx/MWzTVZK4MHUFpSvop+Qcqx
 jhC67YGue0c6f3HpNEPmr1cfROSPZp3USLXs4Kbt39iPpOwhML02TZp6vS4ZPZrUCJY41
 IImNmcviAB6mWmbN61+oHnJCotrpSXnmWeywhy1mQkOjB7yvasUKRyPYSxyNpv/pfFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=MQ49T0z+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::e;
 helo=mail-ej2-x0e.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=MQ49T0z+
Received: from mail-ej2-x0e.google.com (mail-ej2-x0e.google.com
 [IPv6:2a00:1450:4864:34::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 113838096F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:04:09 +0000 (UTC)
Received: by mail-ej2-x0e.google.com with SMTP id
 a640c23a62f3a-c2afd63c3e0so285991566b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790604247; cv=none;
 d=google.com; s=arc-20260327;
 b=dOB8HR9U1FsLsSyu/KLRR46luCdoPuPjKM3OejK2+Nw6BMUhmHYGWFJ5hU3S1/ZaoG
 aZzNXePqS4ncYNSW4n98o6o3Bo5GuN/45coAmeGT8mjA2ss2fq+dafAQKBhpp6K75m08
 4zXiUfVenLsvwKuYw42HrLHHu+fDh+DXZFel7mv2Fl+sHaKlJ8zI/dozpdaA4LNGVvWj
 imuuLJ2/+qJYAL2WrWAidRx67k8gqGO2+zLpIb4HVGYO9BmhRtYFAgK4KlvXNG0QIfmz
 XyRgmupH+VliuioFPIVpkEkU4XdpCXT7RS/De+Utm2dI1W6BNPjH5ZP3IUKZao+2UzP0
 megg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=phcRLTKKgINQ2K6RQK/N9bso5ZgVCItElpRLoxtYgsg=;
 fh=X0PN9lBUC28xruMLlb/E9GWPFyBweSpvg8ZgHdQS2Mc=;
 b=rdFGgD1E8hdk+hD4ejqgUSgdwHfIr+ukZe4vOhWz/naOFF7Cyz0f9DWCPDrtR7Akuu
 8a/BlyuieBL8gJVIeXAY6NzAP6cptBlB+r1/j/AeYa9ujriPr5w9KfmQ95ysfNE2xhfw
 XPR2KihKlkgZtg6AJ7g2DZkJCPDtWgYFId5+e91bFFavrSqU9d6CsD4pVWRvE7KlN3Ul
 3uA/aJtrx9oe4Wvga7GkMSsTRO4R/hNdE/UxfwVSr0dTbRI3Z4/CgHXcjas51m+Z8uue
 zhLl47Y5NBmLM16DfpJsy4k8w1qpJJCNonfRRJZ8RijKhi+Z2WZAimVLBetIetvEoaA2
 v5xw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790604247; x=1791209047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=phcRLTKKgINQ2K6RQK/N9bso5ZgVCItElpRLoxtYgsg=;
 b=MQ49T0z+vqIouWFuU2CVqoQEJhhhW12JLotIw6cWRN3aTiznm8PV1VwSOfzIkdKHI/
 Egd7PfSztyqxpXhe5gIDNDMlLJ0WG8xhnvwLPgc+ADjxiGh1Yiibg+c8mxfqrZ8YBJ9I
 GYQLj+nElWvaYgE3nNtkJt05muIFqArLvRITN4YylGx6WhNRiStlKp/b/Ulaa1YE8tGR
 vO6zsU/SBWoB8eyQ/wruwVDHqgc5UuTYQfGA9cGBc2gW+0nlBFcfTKAakxWS41OElxll
 ypQEub/1ARlxUm5CMek6mhx62sVjBrLSyufK3SIwOvt2UrqHNjp95Bzsl/tcyuRIZpPy
 jg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790604247; x=1791209047;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=phcRLTKKgINQ2K6RQK/N9bso5ZgVCItElpRLoxtYgsg=;
 b=WfkKmzWk+xp01AoTCheuTSkk1MtMfhh9hdxAJGAgE4eYeP0ybM85Bhz9mf7JQ1Bigv
 bRqeOKqY1IHMdtM4ieGTAVAh8NlJ0g0b3m5esEPxx9GYb/Pfck6JZoyEvxcfSxtg1yiR
 6Tnzmh9uKnvq6h1spA7ACWfvvfgefauSJNFxpCB5vki0zX3fb+rpgyr29Y2lY7bHWsd8
 SVbD2Y/iIm0y9Hd9wdSyV5WhVQxHGDJwIZb2mw3/J/8EUJJKgiF5Lt897xlIlEnpt/tj
 FHQt289qgXo3aZSdRznjilTvqPBqeIZDoARyIBVsDmD2gWqV48Blf7uoZONwI0XRoPS8
 w/xg==
X-Gm-Message-State: AFuF++lMBoR8kE9RiFI9Et3vONGNokGSJefNIbwwAzceS7/fA34byIJH
 0GXbo+KvrFapIm0glPb7IfvIXgjEw/fVmYi4DBihXBnfecbK/MuzXr+CubnBz6miRhxUHOFtLJA
 ZTasU5VVpg2MkwQ4COFnsyaeoeGP8/qYNDF592raXBA==
X-Gm-Gg: AYBFou29wQClC/ZpvpZnrFAL7a68L+CKWjZLcAzWbLZpCtNKBjtS4SvHnczZ8GjGTCV
 tctuh8NoLkyPKqSolSS7YK1cMZNO5uCxEdf2W65FuYc7tsuGGyUD4iiyWBK1scQdK8UlGn2vBrU
 pFEk1sqfwj0rv8ukZZkP2WVvXaLJdK8zTnT+juSFUfd2Fk6zY6rCc8hjeyBqSEXiMTMD8o4f3B9
 13fVl9yeCZ6ciy2s9JsFKb4LBp8jbC6Wfm+Gnxw0QH41/V1kF2kZQ4oDiZ9fnxxkHVs8/T5HJNG
 4Uqt+B/L8iuq8IvPtyO7MNHHXro9tDmklo1MdMgiISqcKsvNHvvgauiY20ycW2HenDH0jXiydxq
 B7uUSIGxoPQ9VIelbtekG254=
X-Received: by 2002:a17:907:3e03:b0:c2a:8b29:1b5b with SMTP id
 a640c23a62f3a-c2ac23dc661mr1142710666b.1.1790604247144; Mon, 28 Sep 2026
 07:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-6-acb97c172993@flipper.net>
 <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
In-Reply-To: <00e2291d-7fc5-4ea1-abb2-9b9100a2b680@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 28 Sep 2026 18:03:55 +0400
X-Gm-Features: AclHuK9kH1DFkL5yTM-3mWfoC4Uy8i8X2Te7EqsE9tmN3IhE7uYMTRLvM6A1iHs
Message-ID: <CAKTNdwFMCK2frVyrmYWe67k6WgjA7pmJn-SbU+_9NtceHqHERw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] binman: Add support for pre-patching FDTs in a
 FIT with a /chosen node
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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

Hi Quentin,

On Mon, Sep 28, 2026 at 5:26=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> > When a generated FIT is used to boot Linux directly, bypassing U-Boot
> > proper (Falcon mode), there is no runtime code to discover the kernel
> > command line and (optional) initrd location and include them in a FDT.
> >
> > To facilitate easier preparation of a ready-to-boot FIT, add support fo=
r
> > pre-patching the FDTs in a FIT with a preconfigured /chosen node includ=
ing
> > the bootargs and initrd location.
> >
>
> This sounds wrong to me. Why should we hardcode those at build time? We
> already do DT fixups in U-Boot proper *at runtime*, so we should
> probably do the same in xPL when booting in Falcon mode instead of
> hardcoding stuff. Since you're aware of this, I'm guessing you decided
> against, but you don't tell us why. I'm a bit worried going with the
> suggested implementation means we'll eventually have a binman node
> property for each DT node/property we want to write/override.

The "regular" Falcon way of doing things (i.e. the one not involving
TF-A) has so far been: "capture what U-Boot patches into the args to
be passed to the kernel, package it into a fixed binary, and boot only
that". No runtime fixups. So I more or less followed that pattern, but
tried to make it a bit more accessible by eliminating the "capture
something at runtime and save it somehow somewhere" step, which I find
unnecessarily painful.

Maybe runtime fixups could be brought into xPL, but they are
excruciatingly slow, whereas speed is the main reason for wanting
Falcon mode boot in the first place. Right now with Falcon mode on
RK3576 I'm getting 2.5 seconds from applying power to _userspace_
(i.e. full graphical UI drawn on the screen), whereas the best I could
get with U-Boot is just over 3s to its boot menu, much of that time
spent going over the flat devicetree before relocation in O(n^2)
passes. And those 3s are after stripping the massive pinctrl node with
hundreds of its always-present children from the pre-relocation DT,
which alone saves ~0.4s.

> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   tools/binman/entry.py     |   8 ++++
> >   tools/binman/etype/fit.py | 103 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 111 insertions(+)
> >
> > diff --git a/tools/binman/entry.py b/tools/binman/entry.py
> > index ce7ef28e94b1..e0dea8bf3a49 100644
> > --- a/tools/binman/entry.py
> > +++ b/tools/binman/entry.py
> > @@ -636,6 +636,14 @@ class Entry(object):
> >           self.Detail('GetData: size %s' % to_hex_size(self.data))
> >           return self.data
> >
> > +    def GetNode(self):
> > +        """Get the devicetree node which describes this entry
> > +
> > +        Returns:
> > +            Node: Node for this entry
> > +        """
> > +        return self._node
> > +
> >       def GetPaddedData(self, data=3DNone):
> >           """Get the data for an entry including any padding
> >
> > diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> > index 32caa03a7e16..750ff5b47ed5 100644
> > --- a/tools/binman/etype/fit.py
> > +++ b/tools/binman/etype/fit.py
> > @@ -304,6 +304,40 @@ class Entry_fit(Entry_section):
> >
> >       See :ref:`fdtgrep_filter` for more information.
> >
> > +    Patching /chosen into the generated device trees
> > +    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +    When the OS is booted directly from this FIT (e.g. Falcon mode) U-=
Boot
> > +    proper never runs, so its usual runtime /chosen fixups do not happ=
en. Two
> > +    optional properties on the `@fdt-SEQ` node make binman patch each =
generated
> > +    device tree at build time:
> > +
> > +    fit,bootargs
> > +        A string written to /chosen/bootargs of every generated device=
 tree
> > +        (any existing value is overwritten). Typically set to `CONFIG_=
BOOTARGS`
> > +        via the preprocessed devicetree source.
> > +
> > +    fit,initrd
> > +        The image name of a loadable (e.g. "ramdisk") to use as the in=
itramfs.
> > +        Its `load` address and packed size are written to
> > +        /chosen/linux,initrd-start and /chosen/linux,initrd-end (at th=
e width of
> > +        the device tree's root #address-cells) and reserved in the FDT
> > +        memory-reservation map, mirroring fdt_initrd(). If the referen=
ced image
> > +        is absent or empty (e.g. an optional initramfs that was not su=
pplied)
> > +        the initrd properties are omitted.
> > +
>
> This sounds wrong, why would the FDT image node need to know about which
> ramdisk may be used? Shouldn't we rather have a ramdisk property in a
> configuration node, and then patch the FDT based on that information?

Falcon mode boot where these are useful is for a fixed-configuration
boot flow anyway, where one wouldn't have a way to select among
several ramdisks to go with the kernel image. So putting this
information directly where the user (i.e. the kernel) will find it
cuts out intermediate steps, which in turn improves speed and reduces
complexity.

Best regards,
Alexey
