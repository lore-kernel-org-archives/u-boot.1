Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF382C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1AC887B8C;
	Fri, 26 Jan 2024 13:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="vRllS2+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OGAQ5eBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7108B87BF2; Fri, 26 Jan 2024 13:19:56 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AEA878AA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
Date: Fri, 26 Jan 2024 13:19:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1706271593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+KB2iZx3SsU0JkPrlJLHUQ89sWJ72RUs5+KTLfC2gw=;
 b=vRllS2+AS8V7UAx8gwTaue9puBtM2ZApQGtAQo2XJa3rpOmSEyJRm059Ryh/K/nMPAllpV
 Ooogv1gFRLCWOdK6xCSJHofB/xYxExiEPN6VFYRil1T2KjhFK38coSKvUpR9Iq19Ww7fOR
 Fq/EHxMcG5mewlZUzXSK4sdgsJXfxHx/hDufryosQFRktGPeL199IUbhhVtxPZCqFpE4cX
 fkxD6JQG213npAmd1H8V1KC/wZARrAOpb6SXHbeU7l6y+s/e0dJO53Mug2BasSLs9220wG
 JOVJS9CGon9RT9gEuDsIteA+zsqJ9lesq++aoXB2GykB6k9gn7XchqwS92Iehw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1706271593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+KB2iZx3SsU0JkPrlJLHUQ89sWJ72RUs5+KTLfC2gw=;
 b=OGAQ5eBkoyDrNVBvAWchg1K6fZqWPmMKXj5k8CpTSJXGrwOb4uE2LnuGVYo39zb6P+ME8+
 rCpRh7jubUj5vAAg==
From: Nam Cao <namcao@linutronix.de>
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: riscv defconfig starfive visionfive2 env is nowhere, missing
 axp15060 regulator, misc vendor hacks for Milk-V Mars CM Lite
Message-ID: <20240126131951.24af4e07@namcao>
In-Reply-To: <CANV2PTO9aVPxkvWp_PY+NwB+bzzNtJ211NxQLHxi_uz_1Gce4w@mail.gmail.com>
References: <CANV2PTO9aVPxkvWp_PY+NwB+bzzNtJ211NxQLHxi_uz_1Gce4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 26 Jan 2024 02:53:45 -0800 E Shattow <lucent@gmail.com> wrote:
> There is missing the AXP15060 power regulation in u-boot needed for SDCard
> and networking. As it is happens to work for some variants and not others,
> and not always. The AXP15060 driver exists in mainline Linux as a variant
> of AXP20x and there are corresponding devicetree entries of the StarFive
> JH7110-based VisionFive2 variants queued up (ref: *1 Patchwork series
> 806238).

I sent a patch to add AXP15060 power regulation device tree node:
https://lists.denx.de/pipermail/u-boot/2024-January/543614.html

However, I sent it because it is needed by OpenSBI to reboot/shutdown. I
was not aware that U-Boot also needs this.

Best regards,
Nam

