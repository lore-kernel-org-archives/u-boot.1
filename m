Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A963C55838
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 02:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1ACD60703;
	Tue,  4 Aug 2026 02:15:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dw1Qab11Wp50; Tue,  4 Aug 2026 02:15:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 422AC606E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785809709;
	bh=3wDD3+E8jWw6ueT6QBZIYRhKh/yvJxelp5TueJaoY5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOQpRK1wHJSfB8ksLvd4r1XpCET3WEzxy3FuLAJth/VFSeAtqdOJQRfpWRDbjoij4
	 81XXxisnqHxuoCOkC8DsvnZeXCit0F/Jk2eTURZFqVbI0tYZhyzyQ1JlZ9boc8nwTk
	 r1APsYDHN2knzDbYZLyutv9G+Z2+QtcXVwr9LJVNB3tTSeTRftb5nB59cFLF+/lAmZ
	 /tv/jWyB+fOcpmgK0y2JHW5BWwOQhZKeO+zz8c0TddKZyUgnSFOLwuw1raJFuTaG5b
	 wqSQ/JawHHyv+TSnl3i7uMdlhitxeibCR2OgCzPxWhZNTOQf1wM29iGJxxQ3E7sxZo
	 Xa6CHEsKtGtVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 422AC606E8;
	Tue,  4 Aug 2026 02:15:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD0A42DE
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF0D1400B4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id smdKy3fp2Jps for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:28:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=162.0.218.230;
 helo=h7.fbrelay.privateemail.com; envelope-from=elliotjb+anduril@elliotjb.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1E42C400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E42C400A5
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com
 [162.0.218.230])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E42C400A5
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:28:33 +0000 (UTC)
Received: from MTA-11-3.privateemail.com (mta-11.privateemail.com
 [198.54.118.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id 4hDZCL2y8Sz2xHW
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:28:30 -0400 (EDT)
Received: from mail.privateemail.com (K8S-PROD-WORKER-01 [104.30.160.130])
 by mta-11.privateemail.com (Postfix) with ESMTPA id 4hDZCF1hVkz3hhTR;
 Mon,  3 Aug 2026 20:28:25 -0400 (EDT)
Date: Mon, 3 Aug 2026 17:28:24 -0700
From: Elliot Berman <elliotjb+anduril@elliotjb.com>
To: Simon Glass <sjg@chromium.org>
Cc: elliotjb@elliotjb.com, u-boot@lists.u-boot-project.org
Subject: Re: [0/3] qemu-x86: Wire up EFI capsule updates on pflash
Message-ID: <anEx8UTLwbRIxYGD@eberman-5690-nixos.corp.anduril.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <CAFLszTiOZGWLcwMs0Zddk0g5Tjx8fu4xxJk08a1JZ43ZbbcKig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTiOZGWLcwMs0Zddk0g5Tjx8fu4xxJk08a1JZ43ZbbcKig@mail.gmail.com>
X-Mailman-Approved-At: Tue, 04 Aug 2026 02:14:59 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785803307;
 bh=LiNh+uvhYxrUG1713emLJrGlS/x3rnqBxa8/UpYbUIE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yAatuukKrhc4NRciapLI6wODSPPa4Ml+dACaR0/LGLt811tr0LfQiN+ZB8qqFVZqL
 rMcHgIH7eoTTu6GClE3qOoK8tAl2DeGSauqJe7fccj8nL2f4fhV16ymauZZkE7c1yh
 9rwq9DgzlzcOXjYX2ZIpdUTxjHADjqKJFOYGmGpRMGPGAQy2OyzEUl7DyEXahomQP0
 8mHO3nrzdsNBL6+hF7AcPXurNkNQlI+WZDjYJkSusiQ5/iouqOzJdWLoiBiAIvY7bV
 Jz5Ybqdy5073TcncvIobKyymNUTs8/7dH+RrEhtC/7vUTlqFejgro3tVrBRib5/l2M
 Hqw1T3ggqSTBw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=elliotjb.com header.i=@elliotjb.com
 header.a=rsa-sha256 header.s=default header.b=yAatuukK
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

On Mon, Aug 03, 2026 at 01:25:43PM -0600, Simon Glass wrote:
> Hi Elliot,
> 
> On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> 
> > QEMU's x86 machines map a CFI NOR pflash device, mirroring the mechanism
> > qemu-arm64 already uses for capsule updates.
> 
> Please add a short section to doc/board/emulation/qemu-x86.rst
> covering how to invoke QEMU with -pflash and how to drive a capsule
> update. doc/board/emulation/qemu-riscv.rst already does this (see the
> pflash and capsule-update paragraphs around lines 45 and 186).

Will do this and all the other feedback I didn't directly reply to.
Thanks for the review!

- Elliot
