Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DC4CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 10:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4232D849CE;
	Tue, 23 Jun 2026 12:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByRCN6ki";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C83BB849D2; Tue, 23 Jun 2026 12:33:34 +0200 (CEST)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394B0849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 12:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-30c55adcf66so740872eec.0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782210809; cv=none;
 d=google.com; s=arc-20240605;
 b=kLT3A+FZALJk6IUIJ1cww+upiBmGb65cU2D8QqDQeaIyeNby31eSM0xIaCVkct4Zgh
 OhdZkATsK+Ua12GJ4vzJtYKcLbsM5zrAJKHi3Q/sx9ngmPY3zySt4sfra1bSgLm/TtBj
 LWdlzs/5hZHUKl7SoaHXsAVoJuOt1r9v3LDX523NZfkK4T0/+BqV9DyX5bH/HbCsLRVz
 QGRaT9rkhzryWozJV3vLBKNGzGCeO9ZZ4W3X/G8WOHpEggSx50ynIIgDYLG75CCOAo5a
 ZxLJoZPEcYkgGwhsOz64S2DRqYIquaWhiexb+4Y4iZU9a0MyqyuZV9+F/RIEJcPufUvu
 a1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RgDpas7cxeIy+ip0Czx2L03TPhbhJqvNCW3dgCDZiSo=;
 fh=yhzy5YT8XMI8z2O5Icaj7D0Wz9zv6LlAkU2kKa5KxXk=;
 b=P3+fIniTjPqEej3JaUlcF01ZKX9isLok1s0rxKJbfoR/wD9Me133stPtoBzDRkfHQE
 oIYpje/13Xw/vsDfXBOt00dtS3Ya6qcoINFq8U4QlMJdAw7F9/wGrOOK2Nqi5huPRkr/
 tPEUBkKB/i3nc/eCA0Lz9wkMnrVKJSr5fDrV7aEmJFAT+wsTlSCx5szSTdeXsyxlhrkp
 84rGwiQ8eDOg/PvC5haZFC2FljO6o/XRWye4gUeqecG2kjWxd9XwxSr/VbNmLOfkbX4G
 UX05OV9e6wLXG3bvkE6nOKZ5lIpEVPMSXCMrQigYpDU6Bm+RZyQXVma4fqO2YeoSlDPv
 NxvQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782210809; x=1782815609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RgDpas7cxeIy+ip0Czx2L03TPhbhJqvNCW3dgCDZiSo=;
 b=ByRCN6kiyh+WqXjasdoigIxpglooH80H9vu+k329HynlCzD8507BqOjOfy1YBVpqi3
 yz9K0QwbR1DBjDWtx7wjuCwhW0UchEXiaUJ4bSoKgqYO9AKiQvcxkhwhDVjEp0qjY+ey
 DZ9wWG8T4hPGCUleuKDXurXRo6M4NU0eY6lY+wm3xhi5GJ54kT2wtcLlaMBfh5bucY+d
 5a76kZVp9vqnhxb/wB4Q0sGSWMBCHMLk9LBu3U/WqhjWtoIcw8XAatXqKOOiA9UtGJRG
 AH74rrZ4hyi4larrSDLgUZR/cmZPBUhHAn7NZvYPauG/UKQV+UcNNTvFWZDbYIr516cA
 P2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782210809; x=1782815609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgDpas7cxeIy+ip0Czx2L03TPhbhJqvNCW3dgCDZiSo=;
 b=jOK6oIAFUls8FxUVpdP6qRd3YKd6gaQMfPSmEiWInfLBa+592Dxq2Zan6sglldTloi
 X5JJRPk/THGos09AiRBetVRNUFIbxQwRQVhnFEeMcOhhayhTn/CwBmGf8g059Moheo8Q
 u6gImhGjnH2neMoujnvARG7VMwbBIedCB3wgTOMrmpnDfLtlBgxKX841+OMuwKHM44Ic
 Jmp4RsCVFBvDaw9MYkT1F2J06EE92y3phU9NP4bHe7YmzrUtmKRizrIR+6LRQe5I+onB
 DNnp4x3uddVg8cUVp/x1JkE96DuqSJVny8njOairCITmhGdVkTlaGEvrBhuTqxnfVEIS
 lUMA==
X-Gm-Message-State: AOJu0Ywv5+BH0SG8aa8hcWNN4cIkBcfiIuABD4GI0QuFuZ0m4BiQuCDK
 e833yD+SzK2S7i31wJUDbXVw0F0G5OrXoW0XRbsCWrQjuyn2HfQsAYzHzRZeHbzCpgp9BjgtXtN
 czdCF/R6ITjasSPKVp2rlevG5TgDavBM=
X-Gm-Gg: AfdE7cmj8/cueD4EEZ1hS6jT2zP+vAvW2c67PinX/o4JOPFNemI+aSBCo2IEAppS6/6
 4XZ6cFkYsvWpjfdgQyvPQ/0YubtnYWMsvcqUhP08/XYuYxkJH7DGbPhT5PEnJHtb3FgabRRDNgP
 1XkjJdETRH1yVqN/sbNSD/KTAvvBzhVJyFsfsfDr//3Z+STuqdMZ4ClYQdtQcivyeeo6e19WsdF
 g1hbANZNxfWGewVIx45Va2fM+hK0ltV04o0R6rCre1pcTmkIxUr4x1H0cF8gUi6HIy1V8P+
X-Received: by 2002:a05:7300:3081:b0:30c:553d:81af with SMTP id
 5a478bee46e88-30c553d823cmr2992955eec.27.1782210809444; Tue, 23 Jun 2026
 03:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
 <c81e9331-b847-4716-a100-5aa5cd570c45@cherry.de>
In-Reply-To: <c81e9331-b847-4716-a100-5aa5cd570c45@cherry.de>
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Date: Tue, 23 Jun 2026 12:33:18 +0200
X-Gm-Features: AVVi8Ce3KtSR2dDaWMHenV5UGaY3XGSrjzogq7qOA0qJ8Vh6nGheALgz_tTmM4k
Message-ID: <CADU25KKBf8LKqY4eiwzf=nYxk_UQLBrR2zmbarw08L2T2kLQ2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rockchip: rk3568: make the WDT trigger a first global
 reset
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

Am Di., 23. Juni 2026 um 11:25 Uhr schrieb Quentin Schulz
<quentin.schulz@cherry.de>:
>
> Hi Andreas,
>
> On 6/20/26 12:08 AM, Andreas Zdziarstek wrote:

> You should be able to use:
>
> #define CRU_BASE               0xfdd20000
>
> int arch_cpu_init(void)
> {
>      static struct rk3568_cru * const cru = (void *)CRU_BASE;
> [...]
>      setbits_le32(&cru->glb_rst_con, WDT_GLB_SRST_CTRL);
> }
>
> and it would match how we did it for PX30.

Ok, makes sense. ty

>
> I think we should probably enable the second global reset for TSADC as
> well, like we did on PX30. While we don't have a driver for it in
> U-Boot, we do in the Linux kernel and we don't configure the global
> reset level there I think? So a thermal shutdown would properly also
> reset the whole SoC (or as much as allowed by Rockchip :) ).
>
> What do you think?

I'll have a look at the Kernel. Could be a good thing to add in general. I am
a little unsure though if it belongs more into the Kernel if U-boot does not
use it?

For now, I'll make a v2 series using the struct schema. I will also add a
commit for the TSADC reset. Then we can decide if we keep it in or defer.

Cheers,
Andreas
