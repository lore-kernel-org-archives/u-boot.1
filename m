Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3393CA5FED
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79C5340F6E;
	Sat,  3 Oct 2026 15:20:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oaTXXhj8j2Cm; Sat,  3 Oct 2026 15:20:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2D7A640F2E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791040821;
	b=WuNUpxDQ7mHWruEfPM7PN0qVzKVuCOJzEG4H3EQaokio1noTKt+ron5ph1FCm1OlmFv3
	 EbfOZX2rcEYIQk19eRv167gsLguBC2+zJc90dY9BnFee5sw1P2GbdnIUvnE6IZtsZdzho
	 WatRWWNkw+K5MnjmJCo70805OWuqHUXh82f9gmMhu1vckG7jLMgYH+nIkcYi/nv+KbGeF
	 bV2kB2I3a+IwLfeFl2WSjuK8ncSmmVnCKyqrWVI1b+JikQA1TPaLidYLsqi42fIM1uteu
	 fj+SOMQk/qWbiiczAlXG58WMt2jQknbbO/zYhOK5fUFpbzOQU2TfWsJ1FFhOXOns/QA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791040821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EENE72ueq0dwHIeCCe9FEdSc2kvxlSlQsHz7HCoE2Z4=;
	b=phlive7n3IkGY8FlqSCStDrFc3Fv3tLPPrfq5/NlNkonKv7d3+UmByWwrakksCa8O2fo
	 MlHP4eU6WNN8wi2QMzpR76KaJ6hnxsn1Lhi/vpFlBLUIQjODdUhYcrgYO6JbnKyfO1W83
	 ePu2qD6lJuLd2xAQdgfZsjH/WdtVE/psGeTkahf8gajmV4+kD91CP4aXlZrVwBmBgEP4R
	 cmgP3syMSoefHYokJe0iFoiafA8WsUHQD/OY22zwUFrCmhhP9mLlpYsM2mUiiuDtfxtYN
	 ZF/JzV+NfGxixJZRHhhPjqQLBMcUYDcfFgxZzDV0O1gDpyloT8LebMEY0hP0iyqvH9w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791040821;
	bh=EENE72ueq0dwHIeCCe9FEdSc2kvxlSlQsHz7HCoE2Z4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q6GhEsVe8OJMYu8Iulwsl8VKAfkVj9xeKnEqaavK0wG2SeBy8dH8R7C4ISFs2gAyh
	 OylPL3lo7ysivFw9KJPy6vIUA6hbbFKMPSz+YLIR862veLAOHHJVhe68gi00uSFfgk
	 S/ryphmQKs/7WxwlfsGvwNOCMAUy7WBqmWql77yyGVOu7e0IQbXZ9v8LYcnOv2NVJg
	 RLEK2HkkL9fQttk91St0S9iFk7RLWCmNRLQwGlvdzahZ3+pWdRsToz+AhzGtY/c4X/
	 PKiduru8KIULV7K3GVn6PrETFrlsyWXY6i/z7MwCshuGtCu/AFBUatwBLP+ceIFcoU
	 Jh8mzyGKzRMSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D7A640F2E;
	Sat,  3 Oct 2026 15:20:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6302C2E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48F0640063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:25:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KopLM_TeDQ9V for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:25:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E13DD40024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791033931;
 b=dYfOVSBPh12YwMA4JT5X4ko5RraCb/SlcqyzDrAFKGH8xAdvd3S1yjj60Dvocv2SNEcG
 iN8N4XxrUXNSCnAh5CKAdcDx+LodC/mRv5JHExUn3o/95D707J34j+yhctORYV8HR9gqg
 TCB0lA3qpGAwQA3QJg9H8OVJWHrtsjefkhqIsmmH7QBv08idTfbDbxoSZ2z1PVkzNHw4n
 0Kl3rqaN9owMyBg70cwN1DVs2rg71mvut05J/P2SpQ/JiJch0esWirZ4iHEUmzrRzmm7m
 ANXp0bZnEehfw11lhzkX2NLTLzFscUk3Ru8GUPrH4lLBVnzLcN8xjr3nN5P3Dt3OaWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791033931;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EENE72ueq0dwHIeCCe9FEdSc2kvxlSlQsHz7HCoE2Z4=;
 b=C3GDgszGoFDbqE4KEu4RXqafuLVMZf9m07185ooXLUDsiKaZCjX4pKVb1P0zJbesfX06
 2fA5sOlnaBOTqUaJZeWXHASPAHeTka0XDehL6clZxm4U8jHD1eQ54KEu5cCO8rpMwqwmp
 Q3nyVgNEIqaBN0MrUZ5/8UE2UF5mtfenz758K/smFXpiwV7UD2p4bSJKmpdbtQ5scX9KN
 spg5w8Etpk6q3Yyib6v+lYp5cFdr/HrZ6r3diVBiWgAnl87OunGCqbVYFqR/Ge/kt8cu8
 eiB5wA2f3LIB6wVEDsHzKF914Nd+Ixa6PQyIWz4yxB+Lah3fdwUF+ooMPHWYbe0HchQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nIMRYAzt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nIMRYAzt
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E13DD40024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:25:30 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so726442a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791033928; cv=none;
 d=google.com; s=arc-20260327;
 b=Fu5t8k5EHVJ69iasNFe877gpv7KBCXplS52BXyJK6PL+geJzySrKf9AZef3JgMCh+w
 ad/K51pE0NSE24JlaMXN4max4uBAqPcis5eYFzdOjEZdq5VkwxQCnHaB/5W2OfTQOEva
 c+lygUujYN6sMnXumv4QpG9AUKWeSWrcoRBh49Eh2k4IFa0tvhKQPue8eI33n+ibP0ad
 f3vABLnStzB6VpjiaKO19iaVi1urrhenqOc0N7pcL3edWm6/vbgmN2LTtj7sIVEooPcK
 u1R0uWE1ttyB7XqGRzZwQSVC660Y32QVVWPwmppGyWeckXjTPNx14Gdwtmj7i1IxFJfP
 MebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EENE72ueq0dwHIeCCe9FEdSc2kvxlSlQsHz7HCoE2Z4=;
 fh=hY3jHN9qWsT0kQPuw5d6oLjud1kaxWuAxOCYedBNIb8=;
 b=OWYjesQjGC8WcKeSISeon39vhZDnClT2C7yI5uahErQf5reVMhlIsStc1919SCfr1B
 RDORWQncVX6T13mPJDn+xY+5Iw320ty3hnxX2d+IqE5ue+U6KUVO9RNKMtzOjkRhuYH/
 kdFLG3/LS0rjFGqaHlR1yhFlx59JH9Dy1MDA+nSZTTxKgBbriBFEPhFCcQEDnH99JlMU
 ujroyQoIn98eeM4ja+hr9nE7L5NA+3YBOqrKHvjfguEVES0NE8B0E4D3vvhQAOFl0L31
 p1FE0arJtFBnRtyvjhLuB0e79NW1AfQdkS1BaSbNyzaPJ6OwXJPCV5XYmXgjI7Lf1gv5
 C2kw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791033928; x=1791638728;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EENE72ueq0dwHIeCCe9FEdSc2kvxlSlQsHz7HCoE2Z4=;
 b=nIMRYAztuTLg4DUh/l9BP2XwOPp0fcE3l9yN6S9RTSvx/estPdsMn+RsVH3key5MXo
 i1uKYAAubfgky4EcoRMrblc5QXuVjc3bbXSj3p4fLlANL+AIuEobPJ40cJFQEMLiKpnl
 +7IfUa3BVUTYndRBSy/t5wwo8Ug/igLjrs7mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791033928; x=1791638728;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EENE72ueq0dwHIeCCe9FEdSc2kvxlSlQsHz7HCoE2Z4=;
 b=dqcARWLfKPiCyjGN96R3Z49UC88CRTqEVifanfiIIZztqMstp8fOs5hUmS0bgrfbEn
 T+cIaGBNouveEkrGcaay/7uLqfSxqSSoxm+XTikMp1uQIcX7XursS18Jj64ccim6vjUn
 L5KpfQmoK677fma+fZnEcffbd+7XoeZxhvOp55HmVvaoQtHyR/OC8ahyiiI13HVHt7Z1
 zczHJzsfHxBKJtwcIRY5Jv14G3CUzENFuEXNeUZv7gZFTZdk6wDsozsXeNn0e6cQJlxj
 ZVGnGdmH3nPBs/k95Y4zOZMz4x6FDlx33+DyMbjNUj9RMZFIxVAale1MBPqhVI7xybjG
 F+wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx53A96taz9JgHizg9ZUvped9UuPjQe3CCesGPROFWZY0EoqkYuY6rLmBxgi5zWnl64O0w+nOo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIWHobAlzB7Jdrc2nlpNL5KzRE5ifdU+pMk3WsguJcpiJUihnvl
 9UN6woqz6VsrpeCC5uXBUoyrfh1joQ6k/XwhCbBYtzkp98Ck8XW4Lg0iUJld6NZZxsgXZGGIyUl
 vJBpe/N+VTF+yJAsR6AaB9gMJhQ75Mp9aAhrqabcn
X-Gm-Gg: AYBFou35B25ohbWjcXZyFtmwYQH2PRHsoSswDmygC30dqRZ2/t4k9ApdAXdWP7evEBT
 1/Rgy+tKUuTzycLIdSvOr/12Ge8Wteh36eern4wjuKmopsy2ikXAf0LVvGBWxttcHCgcWv/vAAn
 1FAlMi851nwrzFO8or1LLqdUsVPF2kkFtUdo2Dpxkg1BArZoH046s+9p/tWLaiwW6kyVEAlCiA5
 jppBZ4CiJUKWsBwYQ7nRnjFlNPXSrzu1XrdeADpflvytaeDk6CrG3A2oa/bX2nb391NSETexg8W
 gQ1Au5lwM+4glN2a+f20qtNOvoR90K7VpWBrjipoyujxih/tcbvVDTL2tzkmgoUoBw==
X-Received: by 2002:a05:6402:354e:b0:6ac:94ae:76aa with SMTP id
 4fb4d7f45d1cf-6afad732986mr2238927a12.1.1791033928421; Sat, 03 Oct 2026
 06:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
 <da1e4a57-a511-4e6e-9f53-8e781b9a334b@ti.com>
 <d5fce5c1-0661-4449-aefb-dc0eb960a71b@cherry.de>
In-Reply-To: <d5fce5c1-0661-4449-aefb-dc0eb960a71b@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:25:14 +0100
X-Gm-Features: AclHuK-80yf88DAxo3F9LRzFv9CRhKUeWmUWlGdorB5H7d3mSKkn-fl4G85eJhc
Message-ID: <CAFLszTh2QLa8BpTy6QAkC3cux=RS8GFNA5BKOg_AhPhiqsjE+A@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Andrew Davis <afd@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
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
X-Mailman-Approved-At: Sat, 03 Oct 2026 15:20:19 +0000
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

Hi,

On Tue, Sep 29, 2026, 11:18 Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Andrew,
>
> On 9/28/26 6:33 PM, Andrew Davis wrote:
> > On 9/28/26 10:14 AM, Quentin Schulz wrote:
> >> Hi Alexey,
> >>
> >> On 7/31/26 7:10 PM, Alexey Charkov wrote:
> [...]
> >> Honestly, all those concerns could be alleviated if we had binman as
> >> an external (to U-Boot) tool, then I wouldn't need to care about what
> >> you do with it. There was some discussions about which tools to move
> >> out of U-Boot's scope and we started with patman but binman was also
> >> on the table. Neha Malcom Francis suggested it could be useful to
> >> other projects, c.f. https://lore.kernel.org/u-boot/
> >> f697d6c6-3cf9-41eb-a833-880a892643c1@ti.com/
> >>
> >
> > Just to provide some more info on the need for binman as an external
> > tool. We (TI)
> > had all the boot image packaging, signing, blob fetching, etc. as an
> > external tool
> > originally[0]. We moved all this into binman with the hope that someday
> > it could be
> > factored out into a standalone tool for use by other projects. Like was
> > done with
> > the tools in `u-boot-tools` package. And like that project this doesn't
> > require the
> > source itself to live externally to the U-Boot repo either, just that
> > binman can be
> > used outside of a U-Boot context (not so strongly coupled to the U-Boot
> > build and DTS
> > files).
> >
> > One such use would be in Zephyr where we are trying to build standalone
> > bootable
> > images. Without pulling all of U-Boot in as a Zephyr module, this is
> > currently
> > requiring us to duplicate all this binman logic/scripting into the
> > Zephyr repo[1].
> >
> > Not sure what the next steps would be in making this happen, but it
> > would have ours
> > (and probably many others) full support.
> >
>
> I would recommend to either answer to
> https://lore.kernel.org/u-boot/CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com/
> or start a new thread specifically targeting binman. While we could
> easily remove patman from U-Boot source code as there are other tools
> that can replace most of what it does (e.g. b4) and have it live in
> another location, binman is a required part of the build for many
> architectures in U-Boot so it needs a bit more thinking and preparing.
> Being able to keep it in U-Boot sources would make this easier (and
> could be a transition phase if in the future we want to have it a
> separate project for some reason).
>
> One issue I see is that we technically have only one maintainer for
> binman at the moment, with Simon and the situation is (was?) complicated
> at the moment. I'm not trying to restart a discussion on that topic, I
> just want to highlight the reality of it. Alper hasn't been seen active
> for years as far as I could tell.
>
> So I think we need some sort of list of issues you've identified that
> made using binman outside of U-boot difficult. We need to have more
> people/companies willing to invest time into binman maintainership
> (sending patches is nice but we also need reviewers). If we keep binman
> in-tree, we also need a way to make sure we don't tightly couple it to
> U-Boot again once we have fixed the current issues.
> I'm suspecting someone who needs binman outside of U-Boot will need to
> put in the work as we are in the situation where binman works for us so
> there isn't pressure adapting it, but hopefully it piques someone else's
> interest and you can share the work load :)

It hasn't been that difficult to move patman out and so far I like the
new structure.

I am thinking of doing the same with binman, but we would need to
figure out how to handle this in U-Boot. Mirror the source code in
U-Boot and do a sync each release? Accept patches in both places? Or
just require people to do 'pip install binary-manager' if something
doesn't work?

Regards,
Simon
