Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97129C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A59456065A;
	Mon, 27 Jul 2026 08:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQRLe0CQL8Ao; Mon, 27 Jul 2026 08:39:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAF37605B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141588;
	bh=AZcc/5xIA/Qsyn1lyRbuQ2BtJaRAmX3yt7tnrMC9iyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPV//KxmjKLO+im1uNlbWsrHwgWoUxWRnOF/DlGKj5wLfORGQJEDrnqTSNBTMKe81
	 /WhU38/dgLgPhwXYVpKGpF8Z3JKE7C3jmTI64PPxnzgqbWMLXPrTe45oNwx10y2VDj
	 x9u1uFjGVSjtykkmrVwtg2lPWAW3NAhbyHLh3CuBmJqW6Z65O6+Qs9JEQTvi855AAK
	 OOCyAIVynhsnhYVVYFM4fhh7nrIxvMJ3dKW1L5O8iB0PS1X9Br3L83s1X32LH/lIgT
	 ulV3eQsOBdoMzZgANuArAA4PxnbbxnX2fTSyDHBjSy4gbImP4mq8fDUJuTZhWnqRJr
	 ETnbD/itjgUDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AAF37605B7;
	Mon, 27 Jul 2026 08:39:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39C0E42A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FA4A40109
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:39:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jcJSq3kBdXHk for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:39:46 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3E40A400F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E40A400F3
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E40A400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:39:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B1E584671; Mon, 27 Jul 2026 10:39:44 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C2082991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:39:40 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 667FD601ED;
 Mon, 27 Jul 2026 08:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF391F000E9;
 Mon, 27 Jul 2026 08:39:38 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 01/75] usb: dwc3: restore to original v3.19-rc1
 kernel import
In-Reply-To: <20260716134305.614278-2-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-2-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:39:36 +0200
Message-ID: <87cxw87rnb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785141579;
 bh=AZcc/5xIA/Qsyn1lyRbuQ2BtJaRAmX3yt7tnrMC9iyI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Npo0Fp4jTKucdxRvRnicKZx6qnlPDJapmHtZM1CXgtuive0xwlPIP1AEN1mqq4Fb5
 aHYeZcZCJ5aIkWB44bofWnB2qh8xZ8lZX+bYqHkKX+gz3WNfXP8mMVtJji+cFLls3s
 rf9nNXQ3vZjXp5Satm9dIApZBv4U6AUv4+Y5gCT1mrTkDvoo/ciMg/pmFkgFjbZ/Y+
 JRjrgzTBqx/84cUE1aSFCM+GV1C7Z4RCn008nWys1rUOUAWQeOAVT7FwagP4H9LQQr
 Y+nK3H4euk/ZId5kSoKP7vpPrfuULXOi+bsV7Sfowfk2eSbiMu4sCE9do5LgfTIR88
 1kzy+V8QL1Xdw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Npo0Fp4j
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Npo0Fp4j"; 
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Restore the dwc3 source files to the state of the original import in
> commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
> u-boot").
>
> [Anders: rebased on origin/master. dwc3-am62.c conflicted here - this
> commit deletes it but upstream had changed it. Kept the delete, the
> file comes back in a later commit.]
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I see that the Makefile/Kconfig are not modified and still have
USB_DWC3_AM62 in there.

I don't think it's a big deal but I wanted to point it out anyways.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

