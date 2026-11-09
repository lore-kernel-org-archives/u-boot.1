Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA079606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Rp2uKiIK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHVgF9Bz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 801AD80DB9;
	Mon,  9 Nov 2026 21:44:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyau2vspNITk; Mon,  9 Nov 2026 21:44:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B281C80F82
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794260685;
	b=pFei6rOAbQjcp9YU6AUm4lTRwejYNt4k6KjQJeCz+pUC0IgxWXc1qK2EF2szUln/RruQ
	 gDukjj8EsvdusI4KxiNJsRmgNHDrB9nCIg451uYD2wsID1DKcvhhUtDkXsQiNy6B54yP6
	 JTll373mwyqYfY6VcUx+uBrLyc+SUcMG7kyQHa32/KlohGL5utLfrZr1JqjKRMkrfwaLc
	 vb6W/3KgD2ELQlff4vyKe2uQkUh5txViqrhfLTPvkbebbBaoyDXzvaqWqB1zAiKPTyLwP
	 cmY/kP19S83N7s2KTxRAQmY9U98zxgv0a7Glg6oTKfhLXmc4PnIh1Zqa0fJy+q9BLBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794260685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wbPwC4HgFsIpm1Fn5YPpFlj+bqui4nJw9b7mRGaH030=;
	b=rB+agmkjzxhgKBgwJ0UNQc8lzFbZoPd7NA0uPY3MgtPI4Zp8FLTq8409wBUPBTrewJVa
	 VFw/7Zp49amDFVj0kHVaRhatbFZ4z24eRFUDz0nI2bB+ALP5BL9UWs8htGjyBoM70tu2L
	 ziTEKUq9YDKwsfGXFNLbsUKF/lMPen9TVnLsVv+MsjRE+C2QzfAXVxeVvZQ+4StEyllHy
	 e/1j8kc0C0MxHyoG+Nci8eXuxe4i6FPu1XKarkeGjQM8p+Tual5LBC+Pa/d+pmqc0PNYp
	 XAi60D7hS5RWLWtD+2rIZ2g6zwgh0uVJN0HeO31F1lvGrviNtoRc8C945h7ceiBHd2Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794260685;
	bh=wbPwC4HgFsIpm1Fn5YPpFlj+bqui4nJw9b7mRGaH030=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rp2uKiIKdddSOUlswPqTuqrA4pblMW50jLDKaXI9fwqtlCcY7Eyjh6wc1DNgo59qD
	 etH/d7daOsQKg4Ir0h6TZkCrLuKFxMeHZDwpc6oe4XYYYeKW0FYrBTsyRdl+bxXoU1
	 ssfun1xlE8vhEs1Rg6nWWFpo70O3W16wyh4/Wkvx+/32qdnvc76Eb81WZTelVgwrvr
	 qDIhCjBitomZipagLnCmNcmec+sk4yMNmvyQqqQFJ1vw2sp1sCb3FySth26kjN/GHE
	 LN63ZwI5NE2usbCw4OYJVGasYZcxKfayMuiLHb7uy3oBye7Hd9rshpjiru/AnkedV9
	 MgAMAT3gKVZwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B281C80F82;
	Mon,  9 Nov 2026 21:44:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E15E2CC4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6A00402F4
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrBLqFgLRA0Y for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 21:44:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ACEF7402EE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=uHVgF9Bz
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACEF7402EE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 21:44:42 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5be3ed646a5so1369513e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 13:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794260680; x=1794865480;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wbPwC4HgFsIpm1Fn5YPpFlj+bqui4nJw9b7mRGaH030=;
 b=uHVgF9BzGadacYFAnKkGaf69yvZ0ihPZczgyyTEZ6W0zkI9wOkm/FvlquJNZYcXtc7
 YMztqO2vTUcBTn7rq5I3I4DoI1v6kR6OmREvB5v9DVIlGod/Cc+4KAmR6FwKCE77renF
 bzI+WLTc1EGJzMVL9mDeKoKbdqhDsyQR6qRDk5+WaKvqHQo1ntQEdYTDum+5Xf62K5vf
 w7nN4wNU4SsiPcCrG9R4a77eCKqoAB+BY4YGrvPekJsDt4KNjZASowOeyxarnpK/mmQ3
 xAuD7vby/I/Q1dQDOhLhLgFjx2vDNEHHQ50S4xma/vaq93DunuJJxFyfbsRoEdH9NXJQ
 cXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794260680; x=1794865480;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wbPwC4HgFsIpm1Fn5YPpFlj+bqui4nJw9b7mRGaH030=;
 b=ly+BXyfCq29PUpqxSNHdfV44qhpMKvpBcmHyfnQZST/LuR5wgH3BXMvnxWLsTm0MUn
 FVbo29vQg+0f6jmUHhVWPzawVIGEL/V/bfjrbLGTGQv0CabDUo0Tc7JMVRtX+WQfSWbd
 0qUxCdFv6QqDP1HF6cUKaUwxYtxo5OZkNv/qcNX8ApBmQBL8tpI6L5mgurbd2+qGMmIC
 CO71xWjc06dNmzLYlbuJArw4Sl6vCBxd5udz9LdzqmP8Zo5cQZRTgZXlKQ9YT1A24/xJ
 2vOMSBos7DDHeeXf8OgpPrFthiHpTJfcywgdoVZT+HCvYgYsVWcj42oSmBV4TxLKY8eK
 zaEw==
X-Forwarded-Encrypted: i=1;
 AL+hErEp3fndsyShiYoX8oy0+0rXzWmtWDmmhoQlog1qR3S/LO2m2b1KZcs8Frx3A4pInKcgW9LP298=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8OrIw5dkwzzHtu80k2+pXPIm0U7A6EVEGR0z10GU1KwaN2c5Gl
 omVUT2MxPtbAGhvpfitkrBpYlbaIioWiK1joAngfikh27Tb1KDXvILEA
X-Gm-Gg: AYBFou33RRStLGCQpalTP/7aHG1xt55lDOf7CAcvoMo0WchJz26+NV+Xgp8b4gQqRuT
 GU0KcWvu5JbBbC80XrirKVEMpOQ/Ua45xJ2GIZOm5vRvDnxero0wk51C0U4iE9iVabPqPkSHar5
 NS84aWBftqssst+aL3hSCFOvxIGEf5uM1osoBFhMijbSlDiuN9jdIsEipydeBHx7KO7Dwb0kG5m
 lhLHaWTMscUT663Nl7oOi2pFgxQGiawp+r2ybbqEVBfjOlKoAti2U6qFRKJA5W+NSebjvZQx6Or
 NkLJ/UzBfdZXRYA48lKfi6vDwSK+oXALZCVNV2aLdVgzvHecdT8abIgbFCBOC0fWp4xN+wHwRrO
 7xrp/IRm7o/W7q7SsScEl08lFY9nCipEY++0/NCn72AVT6HKsNeG1Xc7hbRdBokfU26/vYvoiIP
 RczdVqlIOBJ8J5TgtfZ2ZGXlqZseuG4kbn9WaqHqbVS1/EHgjWACURrZoLNYfWOkroPFhDCBupe
 r0dTdjHMAEzxRyKWsjBn+4A0lBvfddUlAO9DYX2D+Hjm9ZEd2uw0HAEkVdWUA17f2Z6BF9osihK
 E8xfovcDXsuzr3iDyXUN778S0CIdHv/zgjWnT5cLNpizRi895zHqqIhqwsPUEj5SqBE=
X-Received: by 2002:ac2:568f:0:b0:5c1:50f6:9b84 with SMTP id
 2adb3069b0e04-5c156edc99dmr176502e87.58.1794260679532; 
 Mon, 09 Nov 2026 13:44:39 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-5c157baf68fsm70348e87.54.2026.11.09.13.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:44:38 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Indrek Kruusa <indrek.kruusa@gmail.com>, u-boot@lists.u-boot-project.org,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 00/10] riscv: sun20i: add support for the Allwinner
 D1/D1s(F133) SoCs and boards
Date: Mon,  9 Nov 2026 23:44:24 +0200
Message-ID: <20261109214427.536546-1-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107001735.66ef37d6@ryzen.lan>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
 <20261107001735.66ef37d6@ryzen.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andre,

thanks for looking at this.

On Sat, 7 Nov 2026 00:17:35 +0100
Andre Przywara <andre.przywara@arm.com> wrote:

> On Sun,  1 Nov 2026 23:04:39 +0200
> Indrek Kruusa <indrek.kruusa@gmail.com> wrote:
>
> Hi Indrek,
>
> thanks for sending this out.
> This looks surprisingly simple on a first glance.
> I haven't had a detailed look, but wanted to reply with some general
> thoughts.
>
> > Building upon the work of Samuel Holland [1], this series introduces support
>
> I guess you took quite some patches from Samuel? I don't see him being
> the author of any patch, that doesn't sound likely. Please try to
> attribute his work, by keeping this authorship.

This is the trickiest part of the series. None of the patches are direct
copies of Samuel's original commits. For patches 1, 3, 5-7 and 9 I can
easily add a "Based on a patch by" note, with links to the corresponding
commits from which I inherited the ideas. Would that be an acceptable way
to acknowledge his contribution?

> > for the Allwinner D1/D1s(F133) RISC-V SoCs and two development boards:
> >
> > - Sipeed Lichee RV Dock (D1 SoC)
> > - MangoPi MQ (RISC-V version with D1s/F133-A SoC)
> >
> > The main difference from Samuel's work is how the boards are wired into the
>
> I think Samuel also used DM_SPL (which I heavily oppose), looks like
> this is gone as well? I like that, but it seems to be a major
> difference worth mentioning.

No, I've kept DM in SPL as it was. I looked at it again and actually
nothing in the port requires DM in SPL. Should I switch to non-DM?

> > tree. The original design aimed at one cross-architecture configuration which
> > covers ARM sun8i and RISC-V sun20i parts from Allwinner. This series does not
> > do that. The D1/D1s get their own configuration instead:
> >
> >   - arch/riscv/cpu/sun20i/ and board/sun20i/ hold the RISC-V side
> >   - SUN20I is a SoC-family symbol, TARGET_SUN20I the board target
> >   - the shared sunxi drivers accept SUN20I next to ARCH_SUNXI, so they are
> >     shared as before -- only the Kconfig condition changes
> >
> > Keeping the two sides apart has a cost: a few things exist twice.
>
> Mmmh, I need to have a closer look, but am wondering if we can avoid
> those double definitions and integrate both architectures better.
> arch/arm vs. arm/riscv should separate itself naturally, and the
> drivers shouldn't care about the architecture.

I'd be interested to hear your thoughts on how to approach that!

> That's just a hunch, though, I will have a closer look in the next
> weeks, as I am busy with other things.
> Thanks,
> Andre

Thanks,
Indrek
