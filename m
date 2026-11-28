Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527C606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PsfuvJb7;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bq8Gnclm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52ED660672;
	Sat, 28 Nov 2026 08:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KcRUoL_MvShx; Sat, 28 Nov 2026 08:09:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 46A4C60657
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795853380;
	b=jAka2nvphl1Gz7nSguuuMONFzDxP+Zj5GwAHUPjrFrzmbQBwyEzGCVzsCd1F1dJrWZ3s
	 79bpt7yY3ZozvC0Zkh8m4CYS4UdDF71og5iYezymcwuh+OKRZOtYCDNI6nbjrXo/sOtfP
	 I5BOTehLZ75LTUYO0SAuehYwrOzRrgXLpG6baH5qXssiw1tuQwrXfowWMGvaszhMf25Zu
	 zTB1PYbG+p2XNApFe39bZoL2v8RUrILE3E9l1zk82NMI+wsyl0+9dzjnML7G9tBustN3V
	 zfnvByswMz+D1uvbHLMFQdhde1Um5Fsfwk0BsH8CPfkkQKs9o0WMi/8REGhuKPHLlJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795853380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rVHieI25wWk+4sxX7I9jOUvvZFvGsYxSrHDwBLpdqX8=;
	b=CBP0HGKUYeUYlbHGgsxTM51bhR3a9lK+3f1QoYhRkEFhfiKc8ORPMphXyvrd2C/pE7mE
	 u5Q9vVOpVNPweVvPsk8Okwrf5/xQ3wJUu9pnT5vrPK4hXV53zUv/0cYsDSbjjSpM4Kf74
	 lBlo6wZwAZ6Q0gROjhe2W/UJHw3odJBsmon9btPqPZ6K/iUuFQHjFBg3jfb9AukoXfk6Z
	 9aAv5lUUiH2ZlrmXCbzGt9wW49R77XsQjDQTt7Jt5+KsvuSagHXFgZVyRzu6h61dcN5PS
	 P95greY44rMnPpQWa9S8klnUrt7BfIDxKNAfKCRZyMrK2ALR4xCg0+Bg3NaZVgpAt0Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bq8Gnclm;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795853380;
	bh=rVHieI25wWk+4sxX7I9jOUvvZFvGsYxSrHDwBLpdqX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PsfuvJb7cJ4ttyFI/wGzdhuhTuJzgQ6LjT5lrD1nSy6U3LWwW1IkHSxpC2HB6amhe
	 idZZiuQHV4u5vNavykXXD2KGIzExHMxs/4Te6l6EuTm73Sb9pAuT3B+/ITrcdFLAR5
	 /2BZslzr5Io+OPxDT9VCjeusWmfvU6I8T3Yxi5xbk8lwMfAwJka4qxFWVeYzuSh+2e
	 BlD3yyvyimuk2nMw7hIZLvGQEWyGetQAjyGiSVasp2VeTZa/JGan2PN3aVO9DI+cOj
	 qfaOqSK45pH2v8rCSESNnnskK/ubpjfh7KLVm5vk9wD9jkuf+MbUAIZRT376CB1faP
	 13ok0XbH37Onw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46A4C60657;
	Sat, 28 Nov 2026 08:09:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F75C49D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5196860657
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQ37c-NIQ_KZ for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 08:09:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 205E960632
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bq8Gnclm
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 205E960632
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:09:37 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6ba380cd8dbso11864758a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 00:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795853376; x=1796458176;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rVHieI25wWk+4sxX7I9jOUvvZFvGsYxSrHDwBLpdqX8=;
 b=bq8GnclmgmGOveMJtTykIEa4l53T06RIzh2qqlpu7IPC//ay8L7/5vGBols/L6kPt0
 7KjRwReeQXP24jCKC42uxaoJw7FWK1GYJDzFSF/uhy+MJVqLbHHFlhf2PcP9a0a+g2cu
 cg9PDAif6jcmNCWspPmRM31EA/pFhrW0ldTENu4p5lcEKseFvbqUahJsdTlVJ7ivmvY3
 X1tbumDsNcDkZJh8SVw25clG4aglCOXujkLEZ4aDhPYD0fkzEXY93MSGCB89C8tMJ75S
 a+0eV44UWvUsOzV7wYAOqTgIXC1ns6GAa3C++AderMIYQuZvFythQOKH8EcNYVejVdfB
 02Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795853376; x=1796458176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rVHieI25wWk+4sxX7I9jOUvvZFvGsYxSrHDwBLpdqX8=;
 b=cq7U5nl/E+YQkQCQyC1RXU8af8IsacG+Nr5+SQp6yFh0iGMSLH2pYx4DAaOowEKtSW
 5H2EtB7mqUp3+1WCpDPz77128HPDSOHrlCG+RD457NOikNcXrsWTqUvr6bmgwsPqmGvw
 AYSZWWOToiZP81ALlEvNbMVaqUp8xpS7A/vumm8zZfdRQdSfB82tXYBBHoiWen/ZGidm
 dRBcNRKjGvdJpwkI8ZPUN+OxsXyINxYZ2evZ1sRHT3hrY0qfhH7C7vAM354OXP49yqYA
 VC9C2yMKQz+nvXkqUGhVZi0rk3LoF1Te4Zhlyrra+Ff5x5FGvJ2g1oPI9wbwFezDpavI
 0YPA==
X-Gm-Message-State: APuU4Z/u0a9Ss0fqkNjlzq25SF7ux9tePed5E0q6Qq1foIThleg318zf
 o9cg6VzDeVTpK+k+mSRbr4tgoKCcIKOXAUDZV+TJYN9stWPsdGtyEyU/jm/tx7p9jq9TTQyUzRM
 JUQvDKowYhfX9PZh+s7YzZ4pwMTyg2W8=
X-Gm-Gg: AZFdTZfAQzEAcZWEYBitWWxy527F7DvUnCe/4GEve1s9SugCo5SPjBR3xs/E6i92q9G
 pAvM8sBJyCpYqOdDZEkasDsB8U+huv1i3HGn9EpHp11fV3Cu9fkjPY5w75wemIjoE26fDY0FKwI
 9bweq9+LXxbzb8CRPuvRH0Gn/fKJWXgtbm0LQ5+PdqoUVIbWweRVU4kPM7SVKKamwPAMLD7Srjf
 cNp5kGnEzNYggozY3Taf38zAq6SF7PcgnpncxBmHwznAnLWnTl14vmLHnXrcdBvD6DFAhBa3OP8
 0/F8V6RJ6JYXP4jaZ8OqpCsDz/7jPn+v+gvOhYxcuEdXv+KW+mmb7CEl+TBtYm8yTMBnaq48E2H
 iE2sUV0sj94GYMaoLl8SIw0JWuchQaTx7hGw=
X-Received: by 2002:aa7:d0d0:0:b0:6ba:56e9:2980 with SMTP id
 4fb4d7f45d1cf-6ba56e92a4amr13037227a12.23.1795853375490; Sat, 28 Nov 2026
 00:09:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261127103030.4647-1-linux.amoon@gmail.com>
 <20261127103030.4647-4-linux.amoon@gmail.com>
 <3c8b9195-6d18-4399-b1bd-e6ac1ad37246@freeshell.de>
In-Reply-To: <3c8b9195-6d18-4399-b1bd-e6ac1ad37246@freeshell.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 28 Nov 2026 13:39:19 +0530
X-Gm-Features: Aa3M54pAjvO_GkKidG8FJ4u4ZtAOaf3JlxaOUR403sPIqISdfDM_ec94NmkTgDk
Message-ID: <CANAwSgQNaQkbaUD0bkPAoN5k20pwhKZrSDeEaCk=70G76JCWtQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] riscv: dts: spacemit: k1: Move common U-Boot
 properties to shared DTSI
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>, 
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, Yixun Lan <dlan@kernel.org>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E Shattow,

On Fri, 27 Nov 2026 at 16:56, E Shattow <e@freeshell.de> wrote:
>
> Hi Anand,
>
> On 11/27/26 02:30, Anand Moon wrote:
> > Move common U-Boot device tree properties from the Banana Pi F3
> > and MusePi Pro board-specific DTSI files into spacemit-k1-u-boot.dtsi.
> >
> > Consolidate early boot properties for UART, clocks, I2C, eMMC and
> > SDHCI controllers to reduce duplication between the boards.
>
> No, this "reduce duplication" increases the duplication of work in
> future and likely broken outcome, also making git bisect confusing to
> compare. If a node sits in k1-bananapi-f3.dts devicetree-rebasing and
> needs a bootph-pre-ram hint then it should get the override in u-boot
> k1-bananapi-f3-u-boot.dtsi; if there is e.g. "k1-common.dtsi" included
> by *some* boards' dts then it is still per-board and not
> spacemit-k1-u-boot.dtsi specific, for u-boot override purposes. What I
> can think of that should be in spacemit-k1-u-boot.dtsi u-boot override
> are k1.dtsi specific nodes.
>
As of now, k1.dtsi does not contain any bootph-pre-ram properties,
so the early boot overrides are still necessary where the corresponding
devices are required in SPL.
> If they are indeed common then upstream would have consolidated this
> firstly. I would accept a link to LKML discussion where such
> "consolidation" has been reviewed and queued for-next in the case where
> you are implementing this here knowing that, for development cycle
> schedule considerations, it is going to be the same as the shape of
> upstream development that has not yet been applied in a merge window for
> the Linux development cycle.
>
Earlier, I had requested adding the missing bootph-pre-ram properties
to the pinctrl nodes and the missing regulator names in the upstream
device trees [1].

Currently, most of the device tree configurations for eMMC, SD cards,
SPI flash and PCIe are already available in the upstream device trees
under dts/upstream/src/riscv/spacemit/. Only a few bootph-pre-ram
properties and other required properties are missing.

The intention behind moving the common properties into
spacemit-k1-u-boot.dtsi was to simplify the U-Boot-specific device tree
overrides for Banana Pi BPI-F3 and MusePi Pro, while retaining the
board-specific i2c8 regulator configurations in their respective DTSI
files.

However, I understand your concern about maintaining consistency with
the upstream device tree hierarchy and avoiding additional maintenance
during future devicetree-rebasing updates.

I will revisit these changes and limit spacemit-k1-u-boot.dtsi to
overrides for nodes defined in k1.dtsi, while retaining board-specific
overrides in their respective U-Boot DTSI files.

Once the changes are accepted and synchronized into U-Boot through
devicetree-rebasing, we can remove the corresponding redundant overrides.

[1] https://lore.kernel.org/all/CANAwSgQ=Djw_o89MgvEsmKVxuNiE3Yuy=e0T5DcLfqCYy6eWMw@mail.gmail.com/#t

Thanks,
-Anand
