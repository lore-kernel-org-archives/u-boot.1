Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8B606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oP+5ZiM9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jtaz1Yx7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A42E760812;
	Tue, 17 Nov 2026 16:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWsZbA3Na5w6; Tue, 17 Nov 2026 16:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CCE246081A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794934731;
	b=kP2ArGmZ1u74T6zlLJG/nSdkHzTKBYM8v+TQcAQmyU413XZf1uzOzI9KLtV8xmOd20bT
	 3TGtVgs23I8qAD6NLmE0P+H94PmoYeEssCRTyL1xqYpC8hh4BQxlahP2Z2pH0mkgazNOV
	 MT4pd2Mw8Y6j/zRWHQO6tT5N6yhoHfyJx/GqBzRmSHmkqRrSsrxzbrWECk81v+orlT9pS
	 VgVM66dt+mTh2AL+chC2GV65vyvLRnCmuCnpVysXRX5JgC9oEdhM4GBuUgqJHT78F76zh
	 Z5a4II0rXgF8un4+4GrU00MylV0lVa3ozsta08lQCyNHtao6nxaUlymGmgEFZBL4UKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794934731;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HJrV/BJxe7iSsVGMbhGhJGQHFOmVr2VSllCLFKTaSfg=;
	b=nuvxx0VVWkcfknQkOzUGwBEVR8Mli74DTEPViS8PFpOivHnpLciHxj4vWli0mCo6mgX0
	 T9D/aHbkR7iy21iBAA4ifI/ipSERqHmFzLxSvAs++mMcx5nYo8S3Yps6AyOB1y829PESu
	 TmpBNpQoWKfjxpqj6DgLMwIi2SYgi0MFW+jxQ5cEpuZ7q92Mm3xpWIdFnZnay1I8oCVr3
	 75+48ifgDVxZ540DEot/CmnK3td4CTYV8cRY3lFEKucuNMAhHE8J3z/E/xRbYJMK6Uq7x
	 MJJIjWyq4NdMq7nsyg0/xSNbWIQbb2/sqD/2FdeCjwpUVI+tFZHcXdQfE9mMg7OeiHg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794934730;
	bh=HJrV/BJxe7iSsVGMbhGhJGQHFOmVr2VSllCLFKTaSfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oP+5ZiM9bD9XXxxLC5ZcGxtZ+WR4Cl7fQPNpakuauoq8j4gXBMkEfUrSweewUrE/2
	 cP+a2EWzDmA0D/j7xnxtE/gNHxnLRxCinzKkKpE/HZm4RN+X8XDetd5Atpur9myHOP
	 161COzcPtKw0qPBI0SczVZiqWYdxI+BmiFpXta+ez5zOtDFN/doGX3frLPOBVApUlR
	 u5h15CoEbtdpkycxqY3/j37Yee5D5dzwrbQMypUj0gRXWnCaeR1S1DjZvig/dgdDHt
	 fZu1JjAdjH7mZAwAS5Hz0v08/bYMYhC2N8ZLiRhySaqcwzp63DAMStWPtZlhBcUpKY
	 XKmtmNCY49O7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCE246081A;
	Tue, 17 Nov 2026 16:58:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F39591A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DCB06811E6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:58:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QfJqBPqUJntQ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:58:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ADCF581134
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Jtaz1Yx7
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADCF581134
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:58:47 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so731395e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794934725; x=1795539525;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HJrV/BJxe7iSsVGMbhGhJGQHFOmVr2VSllCLFKTaSfg=;
 b=Jtaz1Yx7hMCuoj4WPbHNn8LG0XQYKPW64w/UDQKIysqLNcdAVISd8T9FdYxlHTvbe+
 BtOidZ5WWKjaW++WyPD7hhxtkEtK5p/a3AE6qhKVWeWdnH9cCW2XHj40M/CI9kXgnP8H
 Q5WA6WRza6GQwAxyJFkjm8VCJX/FLMVITTSQCxhSaxPvbPv+9EBumcJinHEa2CG1A29V
 4vIrQOOExle8peqAbckUzlqrVuhLigW0kmJi9pdvj/scjQCzpLhNK4sGCXB3O5WBF/OO
 vE+t/8XB6K01oaeOT0UUuSG7iGoZ1M1S50kA3kGUDv3WXqIVWkqQa7KKmYc5rOGXsEfW
 rdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794934725; x=1795539525;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HJrV/BJxe7iSsVGMbhGhJGQHFOmVr2VSllCLFKTaSfg=;
 b=S7KY94j6lTUvz681lNWCPgPZ+904SzLrlDshfP01dSHxe+smr7vss4FMr56GZRTA1x
 YbvVXeJc0mJP9bkZ+6D1SG7cZGC5gEALzIL1Uguh5QXyjMx2GSCwmqn7Gg/l8sjW86ef
 hoQh8mCrkpoNrJIriVaD8qxmpOVged98nLH+w0WnZzSReNj8rUQHXJDC6bLJHDQeJKKo
 n32xhNt79Rjz5Pmjz75NgKHgwuLdnMEEeRUixthA/Tr5JlVQW2o6gZvVkLqwem2zKnAj
 4GnBnLcq30Ft1xJ2dCgmn66skmYnpeNKFvV2/ZPLZt38oG4OKb+hZ5x9FKCGOJYodSfi
 OgCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE7wYAYlo4KlmDdfRiGPS0qIkXtf20SXrPits+aRhiA+UB9QkENErkseHPIG7n5Lrn1efdvN+o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Jz8n6FDzq4dBLJJifQzEIhOILTmBW0+bfRR6pLIO1od+HbVOm
 VdHmMqX6OnEAZBzg1F8vnDpezMyBr69XdY523aYXT5aogek7OPIQQyudEibkypChveu6THZ5qF4
 TtrSG1M5JC2vvM4scfTOsflMGpepK89o=
X-Gm-Gg: AYBFou245uhv6Ug/CyPosPBdzvXIV4vZl5I8pZUXZZwk1OqmtD7spp41lTfcsukuUCK
 DF1g/HgbP5crogyUf4G0bfkM8nxVrWlQylUE0u6OR6roaUL6h7mYy7DIWzaNg/3kSSPg3fEAlrK
 4PIYWVOpi5xraWuXWg3rM7ScVGOPKzsA0trRqlh/M/hzbOIC1iAdY8mRZ0hJJTTiL1poGll8hO2
 0zK9aMI0EmZ7c9d24shKu5uqcgCT+ZykmSBFPXGlboJN5BhChCOode6LQwxsdVaG8tVW9MlYgw8
 /P3c581Ko5MvyQ1IR9R6H/eRmJLddVHWmdodydT/wPG8kQPCPPxlCdTaYQ6H1zsKYedADNf4+Yz
 puPITnJk7yj+4h63uiLPPAi0QOjUPdbVpRT+7GDmPVKEo1fRNP0RRI+C2FAVtqmQU1uT9yOtJn1
 bN
X-Received: by 2002:a05:600c:4e16:b0:4a2:729:f7ce with SMTP id
 5b1f17b1804b1-4bb55a47429mr296572055e9.8.1794934725010; Tue, 17 Nov 2026
 08:58:45 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
 <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
 <f0352e86-58bd-4e6f-aa8f-5253a9c29a55@baylibre.com>
 <4adb08da-1ab4-4849-9001-f0b54065b5d0@cherry.de>
 <273552c3-9bc2-4b60-9a9d-6d6082369fe9@baylibre.com>
 <20261117143531.GQ554944@bill-the-cat>
 <aea66a5f-088e-4e17-8188-4a06357de7d4@baylibre.com>
 <20261117144440.GR554944@bill-the-cat>
In-Reply-To: <20261117144440.GR554944@bill-the-cat>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 18 Nov 2026 00:58:32 +0800
X-Gm-Features: Aa3M54qX8LQJGKdESyxDwTZHM9sc314nOBuuwYQHOWQ8LUbNOtDhVew16xqTAEo
Message-ID: <CAEUhbmWb5-d9PmTDZJZdAGG3egmmwHFEMTnSzQYLXwqMGOXiAw@mail.gmail.com>
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Carlo Caione <ccaione@baylibre.com>,
 Bin Meng <bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Tue, Nov 17, 2026 at 10:53=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Tue, Nov 17, 2026 at 08:39:26AM -0600, David Lechner wrote:
> > On 11/17/26 8:35 AM, Tom Rini wrote:
> > > On Tue, Nov 17, 2026 at 08:31:00AM -0600, David Lechner wrote:
> > >> On 11/17/26 6:52 AM, Quentin Schulz wrote:
> > >>> Hi David,
> > >>>
> > >>> On 11/16/26 9:42 PM, David Lechner wrote:
> > >>>> On 11/16/26 12:45 PM, Quentin Schulz wrote:
> > >>>>> Hi David,
> > >>>>>
> > >>>>> On 11/16/26 6:17 PM, David Lechner wrote:
> > >>>>>> On 11/14/26 3:16 AM, Peter Robinson wrote:
> > >>>>>>> Hi David,
> > >>>>>>>
> > >>>>>>>       > Anyone who has worked on hardware that uses a devicetre=
e for the
> > >>>>>>>       > hardware description should know the mantra "the device=
tree describes
> > >>>>>>>       > the hardware, not the configuration"
> > >>>>>>>
> > >>>>>>>
> > >>>>>>> Thank you for this, I never agreed with describing these in the=
 DT at all.
> > >>>>>
> > >>>>> We probably should do some digging on the mailing list because I =
believe this was brought up back then. I also disagree (mainly because the =
Linux kernel will never agree to this in upstream DT, so this prevents us f=
rom the dream of running pristine DT from upstream). I vaguely recall there=
 are a few things that are binman-specific and available at runtime by pars=
ing some stuff. It's very vague, because I don't remember. But I wouldn't d=
ismiss binman use of the DT as simply being a configuration format, I belie=
ve we use some of its things at runtime too.
> > >>>>
> > >>>> The two users of binman nodes at runtime that I found are lib/binm=
an.c which
> > >>>> is only used by x86 AFAICT and board/BuR/zynq/common/board.c (to l=
ocate the
> > >>>> FPGA bitstream).
> > >>>>
> > >>>
> > >>> Maybe it's worth checking with the board maintainers if we can go f=
or another mechanism so we can sunset binman nodes in U-Boot FDT entirely?
> > >>
> > >> That would be ideal.
> > >>
> > >>>
> > >>>>>
> > >>>>> EDIT: ah I see now reading patch 6/10 that you're aware of that. =
But phew, is it really worth it to do this incomplete split? I fear we'll s=
plit the ecosystem once more.
> > >>>>
> > >>>> Which "split" are you referring to? File format, file location, so=
mething else?
> > >>>>
> > >>>
> > >>> My understanding is that few boards will need binman in the U-Boot =
control FDT, due to needing access to binman nodes at runtime. Most won't, =
but the fact we cannot fully migrate means we need to support both forever,=
 and then we increase complexity for what benefit? For the sake of "correct=
ness"?
> > >>
> > >> The one ARM board should be easy enough to find a solution for. The =
x86 stuff
> > >> will be harder since that was all created/maintained by Simon.
> > >
> > > Which x86 boards are these?
> > >
> >
> > This is what I found so far:
> >
> > x86 (through lib/binman.c):
> > * intel_opregion.c and apollolake/fsp_s.c find the intel-vbt entry.
> > * fsp2/fsp_init.c finds intel-fsp-s.
> > * fsp_silicon_init.c calls binman_set_rom_offset.
> > * acpi_nhlt.c uses binman_section_find_node and binman_entry_map.
>
> OK, I can see there will be less, but not no, boards using this once the
> chromebook devices only Simon supported are dropped. The answer may
> involve looking at how we handled the various firmware files prior to
> binman taking over that job. But it's also probably worth at this point
> saving discussion until it's time to start on it, and seeing if Bin Meng
> has any input on alternatives for handling this problem.
>

From the x86 side, I'd keep the current /binman lookups for boards
that need them and handle their migration separately from the Genio
series.

For a follow-up, I'd start by checking which supported boards still
use the FSP-S, VBT and NHLT lookups. FSP-M already gets its location
and size from binman symbols, so that's one option worth checking for
FSP-S in U-Boot proper. Braswell's use of CONFIG_VBT_ADDR is also a
useful reference for boards with a fixed VBT location.

Regards,
Bin
