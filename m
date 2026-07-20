Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0696C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A69DB40732;
	Mon, 20 Jul 2026 18:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4DecPIhR8NVd; Mon, 20 Jul 2026 18:17:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CCC7840719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571455;
	bh=/86wRwUWrJv29mXJ6BAQOVTTjoktmT9HapcTAsUAPKk=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=UvFmlYOgGNhY6F0ENfiYeomoU/XVGS6y1dezSsWBSKJjY2b3aZRVWVbgRxIy9D0Wc
	 k/dayNsrYpANgZZ66zPGZKDn7Njzti5W75kqch2J/cCfq5/q/O4aezDuCXQbYmf6ws
	 jY+TWfi50NrQ0bvJE6L18GJv9PZPkk1RuJggvdcRAPSiWWFmCW84Tkq1/d7G1KbBiz
	 WhTkh/Dkk835TS5V33zm5knZtzVIlVRHboi5R1oMQSKVSp0a+tAldNrrenoGggSLNL
	 HRziBePFNZWzvp7TKM95rNkuGMq3mbhdDbsx2OpvyRzpT0biqqAqnXRLRkZIZvSbXy
	 xrgydSC84AJcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCC7840719;
	Mon, 20 Jul 2026 18:17:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D9EB786
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F8B940015
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YpWuAJPCbmgg for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:17:33 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C5CA140081
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5CA140081
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5CA140081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489B7844F6; Mon, 20 Jul 2026 20:17:31 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406D980433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:17:29 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so16767593a12.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571449; cv=none;
 d=google.com; s=arc-20260327;
 b=g4eiVZ2P/XN1be36P0AyCgHbPGlr04Efe98OHXY/WzBJh+RZjA9tdx4UtvIvb/u/Lr
 ZJ3938Pjs/cUGxDqIhwNAOmc2D76KoP2sgtAaqpvC8Vbn5HvobmyiudDbW7DA3f8jR3q
 V19L9Yi61YEgKAnuSCdaAYzBnuxKVkAvqpkPSqi4pXiFIMea8WTr3St3iTyeds6pgPq/
 kXCPUhoHJaVKKkE5apmqFwNytAnImTuXgn/isCGd200Q3dQuSi1G4B6n6W/Y3QSrIaYm
 PM6l/JRpyph4PBh8GWjmrS7X58Xx04ZvtfEqy5wRf5G/YmIIw4ZQNXTB/JU6ly+ZdAkw
 6H1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/86wRwUWrJv29mXJ6BAQOVTTjoktmT9HapcTAsUAPKk=;
 fh=T2JeJNFo+6Nm/X4eDuP9FObcNFatCs2oxjGzZgUUZAM=;
 b=C5qa3j9Se8cnArtIA17GthCPSn2wDc+zoxVvE2whLxzEjLWF6A+K2vHK0NfovuA0JD
 x1Enlo/oxKPaUX3NUgV9YSpqtsjcFGes8xBmetHDFkwpcJuyjGuOEBy9VP2lqG47qH6M
 GureFePO24fQDBsgfrmHfYlkEqWqFy9kKxGwTgKG2/mXx4tLb6Yad7x5cji5fe7bpeZv
 A1IUL1rRLhT4+XvL2J+iZydUXFM+4VGyKxn5DNuDzqWfrvky3pJoa1XR4Bx4cFp8Wzi5
 TN+qi4BVB7yGupCq/BUECw4Tu6+cppPfpY0xwtQTYEEQZEKdg46oPy1fDQvAlyKS4Zcl
 sn5A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571449; x=1785176249;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/86wRwUWrJv29mXJ6BAQOVTTjoktmT9HapcTAsUAPKk=;
 b=Zd9uy3Ju7kQam7ZX8yQn7cuBYswiEaAAMfuTpPKR+CRlCw8wBFrSDSIhLHY8eby0Z6
 5S80PkvrVUgyzpTUZVE3i3K7BVgGOaS//eeExr8Exks+mt6uepuUY8mNt7eC5KhkF9K3
 gaa8RHBWXSbgdrTW38MQjyZNW9pWd6RXPoQodvW5xzoq1giT0s/Q7a9x6SyUmMG6L6Q8
 qqe6xbnWAq6HRSQcrlMTtiW3Y1Ca7ZLML3YNgH3GfAJdQDRHLD5eISvGbC7ud+rVj17H
 UsYO9m0tzPBJK05hw1Qo3yCwcvZA3Q1IXyRVvxzZmlv+neO1Nay+1QRPxmtlbmBzuOE4
 07nw==
X-Gm-Message-State: AOJu0YzL/JCQbZ04hDzl31Ss6pyFY8GP/EKzsbBRzjHWbZSPgAj2Tzwy
 qbjdAaNFJc7Lx5HMBO2FXTrGjXQnozyI76s+/fmz4DcL/DPUyzQinKzZd9jaHSLmMo9nFCEG45n
 iDqXHCvin85jQirLMCfoJueEbAKx0tEHjKrsUoAUhdLlnm+5SGzo=
X-Gm-Gg: AR+sD10n1YbhKYkET7YD2iaZbuILqOuzl1QNZJ1ucd1EwEWbR5IJHpjdrluNZmru97N
 t9bdiMynu/Idmp8QAMWSW50GQ8K+T0wPliCxoik4bargdPvYuRasJL6JnPgtmEDwlm9R1NeFMcA
 bSZt1uC6vMlZX2atWQM2DoA3gXE3pVI77mw3WvRCspki4zOeCPPvz/qLhESuvqEvA1494ZEqhZr
 O8yC5SCBPuYn3hyhG72uQlIMOr3MLDc7FJJGK+0ZhQSsNPJLvUAA0tBMkV7YrqWzVAY8js=
X-Received: by 2002:a05:6402:2425:b0:698:c163:65c with SMTP id
 4fb4d7f45d1cf-69e652230c8mr5385211a12.2.1784571448709; Mon, 20 Jul 2026
 11:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:51 -0600
X-Gm-Features: AUfX_mx_OQS-vAVOZyjz607AXhSBvBg0JECps9nvS0lI6o86TAUzlem5-6LjGa0
Message-ID: <CAFLszTinPhEH9nCMV8u8SwMf9UJ5AG0z68En7+-T3e3RxpB6VA@mail.gmail.com>
Subject: Re: [0/8] Misc Fixes for VGA BIOS Emulation
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571449; x=1785176249; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/86wRwUWrJv29mXJ6BAQOVTTjoktmT9HapcTAsUAPKk=;
 b=UhCZLyrQRW81JDM3QWOGOP37I0pKYi96Ea46peY8zQZ3GMgq3orNarkJvdVj/el+Xk
 BZ1ohG3WN64F1vIO0uLX7jqPrbXTXVg1zSXhl9x9NnL5d76A/G03EN5QEmJ2p09wdY3y
 RpAxxy6qalqn98THBTRN3Le0bQgwNy36V6A/M=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=UhCZLyrQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="UhCZLyrQ";
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:

> Patches 1-5 contain misc fixes to drivers/bios_emulator that are
> suitable for upstream. I would like to get these reviewed and merged in
> if possible.
>
> Patches 6, 7, 8 are an implementation of how I got u-boot to actually
> talk to to the Aspeed VGA card.

Thanks for looking at this. Please can you split this into two
submissions? Patches 1-5 stand on their own; mixing them with the
NOT-FOR-UPSTREAM material makes it awkward to pick up what is ready.
Send the RFC portion as its own series marked [RFC] in the subject.

On the design: I suspect the right shape is a driver-specific hook
rather than open-coding Aspeed knowledge inside drivers/bios_emulator.
The emulator should stay generic and call out to the video driver (or
a small ops table) to translate an I/O port access into whatever the
card needs - MMIO on BAR2 here, real I/O on x86. See comment on patch
7.

> This series contains a bunch of mischallaneous fixes to the BIOSEMU
> codebase

miscellaneous - also I noticed  'to to' and 'There some checkpatch warnings'.

For upstream this will need a doc/ entry (which board, which
defconfig, what to expect) and ideally test coverage. The QEMU RISC-V
enablement in patch 8 is a nice way to make that reproducible - please
consider keeping it so it can run in CI.

Regards,
Simon
