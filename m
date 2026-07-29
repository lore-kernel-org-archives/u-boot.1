Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6D0C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 11:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B77B40949;
	Wed, 29 Jul 2026 11:49:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhdoHNHkcn6X; Wed, 29 Jul 2026 11:49:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7FCC84095A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785325763;
	bh=VRTQX+nh47BVr7gpQeiAPir9X8gtD+4zNLCz58n+BJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFWuF2MgDENWYsPkkhWISah11ky2WPTaTU3H0XNxk56WzGn7KkdM2qy4Fh1fm9JGD
	 mYePwNb9GOLr8X8c/nymkhn/1F88YH1+ZtXKLOgwG7Osmmj47D0fgwjtKiwHmKxtvf
	 0ueXHX8A/WUaihFPFSQQMd24qCVeSr+2zRd/y6x20ac+JLM8g8bRuUsPBV216zxh0O
	 RXE7JQhO+odeRUA83KMJROMMm3AAiM4zg7BcK/6BEQMbPeZ+j1qQ4NStqIhHVT9TN8
	 X/jum3zIk8uU6Wc4OFnPijw1/XUMPeum5L8l9ywi8HwV2tHP9OtqJbIX8vzMr1wcNO
	 igcDPq5WNZPhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FCC84095A;
	Wed, 29 Jul 2026 11:49:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 601E069
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E3DD606C6
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XnLnRaEwBm1S for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 11:49:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A652C606C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A652C606C2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A652C606C2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:49:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364208493F; Wed, 29 Jul 2026 13:49:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CB382991
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 13:49:12 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07E6C41422;
 Wed, 29 Jul 2026 11:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3461F000E9;
 Wed, 29 Jul 2026 11:49:10 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Anders Roxell <anders.roxell@linaro.org>, Jerome
 Forissier <jerome.forissier@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 66/75] usb: gadget: udc: make udc-core build in u-boot
In-Reply-To: <20260716134305.614278-67-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-67-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 13:49:08 +0200
Message-ID: <87jyqexbgr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785325750;
 bh=VRTQX+nh47BVr7gpQeiAPir9X8gtD+4zNLCz58n+BJg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=RJaazrjhEVnbCl+/b03wqMxnn/6jXawDJG61Z/AHXUwlCWr2IH9NdCW0iEruHc7CB
 GKsTF6P5DnhCSE3s7eV5x5qB4pwczsKwSAqMyxMtM7XQziuzfyzcSk8Xk69lXC8ksj
 8OUCBupB4AoTIXaml23hMOIEcxTvF5EHuGcGfj13YKVmTXvcm2CYoXU49KHBcPRHQ7
 caiEV6dds2vdI5DCxtx923za1DcAVg1G1o5b9PGqmplM82t4w/b6eTGCUflUL8+9bs
 xmhxmc/KhqTvUN8eHlp5bAOmXfe7G0G95SVFW7OFVuUIsMbueJJGdK3zWv8reHC338
 Y0OCjWcix0qBg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RJaazrjh
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RJaazrjh"; 
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

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> The resynced udc-core is kernel code. Drop what u-boot does not need and
> hook it into the build.
>
> Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Please run checkpatch.pl on this. There are lots of errors/warnings
here:

total: 74 errors, 66 warnings, 6 checks, 1369 lines checked

A lot of them are whitespace related, such as

WARNING: please, no spaces at the start of a line
ERROR: code indent should use tabs where possible

Because of the spaces versus tabs mixup, the diff is un-necessarily big
and difficult to review.

Therefore, I won't do a thorough review on this for now.

Please fix this for v6.

Thanks
Mattijs

