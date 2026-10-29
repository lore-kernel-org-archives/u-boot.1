Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BA606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rAKt28An;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=XxuBRy4R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 913F340840;
	Thu, 29 Oct 2026 00:16:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NiR_FMO1vQsd; Thu, 29 Oct 2026 00:16:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DA804050D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793232999;
	b=je0/ECSSyn8W9B3w+26uZnyram14KuZIEGcx5R/BcOBaG/TzdqFIDICjRGHDN3UjMnRl
	 dYHW91oawPAu7ige6jx31zxoTh4xtkSKiwn3Xt3H+VyHOZTmmpbXpWIFsM1pxWYsno/V2
	 9n8jukYycy+GjuLZ+fvmBkl4OJdX18Qf2EPN5LadSFZ7UxUSda2slxRee6NPwWpE6mlTR
	 ZaDVkWVveSe3v+/N+7QKuBs2ri6hOg/Q0PfbYBrISnT4MFZNaOVvYj/LZ0r+kmEDDhWf8
	 Erglu3iKt8oLqGg6HiBYIep46PnqSABtxZfdtFvoTsoZ9MwqpkVR+wR9c+BctPSqPiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793232999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9409gz5pKD9Z8Sux3P5MoSjCSXsbaGzenar5mvquNEs=;
	b=aw4CqyfCHREKiY3IYyXh2zxWmgc7oVitqoCXCdf6nKX5FKn0FLkEN7hY3iEf80dqO5WR
	 jnm1VbwZo2JYYfeknkgWh34FdJxR9EVHIJNGedM041g7qBwEOJe+j/ETTKY23u4fn9SyZ
	 zJvyZYdxBUVUR3RwGAWM4rxTRNr0NuCBCj7n9vjZZ9snU/xYgDtyIDcRmprdynr1LdAN3
	 Bl16frg+sLxrK0ZLq82Wci7pHbjuQacsGfCC0lZW5RL8GpYlKKyNOky1eLlGS1AeaWcxV
	 TmeRmrhUp1sgrY3bbgp/tq7ik3F10qTcLDnofbnVvx6iVYlWIevkvcETddYhGIK97rA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793232999;
	bh=9409gz5pKD9Z8Sux3P5MoSjCSXsbaGzenar5mvquNEs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rAKt28Anve45a3+cqcIvp97lwxVyGWAYJo3etaXZ86j2iywPh33VEEM7HlPKtwTA8
	 M2/M/QXCSSH2Z/PfvC0JuiROsy7OEC5C5OjH/qo631RqAPIera1S791FHMqydg+Ibr
	 IPZhgr43MFjoDZdmMM3jUVfM0qVsGqO5E0UWPrvpepVWsr5tpIMYe1C7+YpzZrE+KQ
	 uptEbOvr5+evtAXMoFoQjJZmt2zFbgJAcQzMDrDj7YJhAoiNwNuWuUWAGBc5PpzZVp
	 Nn2LK5PI95yCwEUDl7oQ78bhr4VTgWWds2yy9Hyu0Xx7lM62PqdDlnM+mht7QIeOnm
	 KvJwS/DBdw0dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DA804050D;
	Thu, 29 Oct 2026 00:16:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 577262E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48EDF402F1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hl15sci5Hse2 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 00:16:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AE6A8401FD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793232996;
 b=asCkefBQpuDZ+cHESo0HYQl9hxxjD6GWa6rK4rIvIyX9uGgUD8hv3nCjt1JpvgoNgbtN
 SpPB2IyjjEBGIhwUMNTxHnQtPhWjCHS8kDpsFpIycGuQ27OK+Rw7fN/MEFrYexCstlvUg
 tAp3oPlMDYGFigOwdNtm840Pt/+MwrzfRXhBUYpdDvUDdnSXf6UTdvQBtALPpXv4qhRhR
 m67gf/fIw7HSWimKIn6awHvwLSfHKTQ5deMRmtCqfnNh5dkXBSkwqM0+XqjrGPmgUcypD
 tf2D0t5w6Mu2gGeMcu3WCv4BNVf83O0r2VkU9q+bQcvzLuHURurYLCG5uwr7Q1XQFxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793232996;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9409gz5pKD9Z8Sux3P5MoSjCSXsbaGzenar5mvquNEs=;
 b=kyzDYl0LZD6G1Psa0ABD7vXEFVR3AbsJgqFqvu0OefhgMKL3gGw24ri0qO/HZm2uUrL8
 kyN8bFMqxAbFoatRC/NwmrCsFy+bjhrBLpEa31KyM+oLIBdEjjKii4qOse/2H9GpktbdL
 fW3vWBHV01lnWfHzp84mMEjL5XzsOO+MAVJRZNvUrMWpUtuTsdIyZ/fNjCJ8n/KmB6ISi
 m0Ly8wkZLwDDy7vZ4uDsGQ46hcEjbNkRtUHT2lz+FPIY1c302/sr1Wc+lcHA4NB9yVwty
 2uxkWBXEKEONVet8j1nfZc/hzFwTcMIDNZC23hX46cOqa9tc2sYVBTjHfkOKPxGcuFw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=XxuBRy4R; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=XxuBRy4R
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE6A8401FD
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 00:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793232989;
 bh=9409gz5pKD9Z8Sux3P5MoSjCSXsbaGzenar5mvquNEs=;
 h=From:To:Cc:Subject:Date:From;
 b=XxuBRy4R4JIkZ56xHtDSpKe2XrOb61GV2sEn8aXcOcoTXj7FQ3ByDNRCYA00Wwybf
 7IlgRAdKkxkmR7ShecpJaIBTOqXgrD1oJZzb5j/lGQ2+RDLwi0CaAZh1gJ+NFQ9ZG8
 7VExX2iXgVvhcM4o2vqvyf3/enQ59qpznDCOYnDDUyoMosGtzvEEDSTo1swruY75s6
 m+LdpxANn7VrUciIkQqEm8SobcE+FT0KKfvX/8UhibwfjMynaV6wix0T7nZjwA+fZX
 VhWk7K+/vr2yXTMHaPha0VYyQ51dz7ucQzsfQcfEjabALWaKg9wjZ448qnOobf2HO2
 N7BDJj2M3texA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 64678B220251;
 Thu, 29 Oct 2026 01:16:28 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org
Cc: E Shattow <e@freeshell.de>
Subject: [DNM v1 0/7] Guide to build reduced SpacemiT K3 vendor BSP
Date: Wed, 28 Oct 2026 17:15:48 -0700
Message-ID: <20261029001555.1890775-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do Not Merge

Informational purpose only, to aid mainline development of SpacemiT K3
support.

As of 2026 October there is initial SpacemiT K3 mainline U-Boot
support merged for U-Boot main app in the v2027.01 development cycle;
the vendor Board Support Package is used as an SPL to read DDR model
from EEPROM and then configure DDR before loading U-Boot main app.

Patches in reply to this cover letter are in support of the vendored
fork of U-Boot 2022.10 that we currently rely on for building the SPL.

Guidance how to build this to be continued in reply to this message...

E Shattow (7):
  reduced SpacemiT K3 vendor BSP: use MKIMAGE build env
  reduced SpacemiT K3 vendor BSP: add guards around config optioned k3.c
    code
  reduced SpacemiT K3 vendor BSP: add fallback fastboot buf addr and
    size def
  reduced SpacemiT K3 vendor BSP: force UART boot when YMODEM_SUPPORT
    enabled
  reduced SpacemiT K3 vendor BSP: add UART SPI defconfig
  reduced SpacemiT K3 vendor BSP: add UART (no SPI) defconfig
  reduced SpacemiT K3 vendor BSP: set uart compatible for mainline
    OpenSBI

 arch/riscv/dts/k3.dtsi                   |  2 +-
 board/spacemit/k3/config.mk              | 12 ++---
 board/spacemit/k3/k3.c                   | 28 +++++++++++
 board/spacemit/k3/spl.c                  |  8 ++++
 configs/spacemit_k3_uart_nospi_defconfig | 44 +++++++++++++++++
 configs/spacemit_k3_uart_spi_defconfig   | 61 ++++++++++++++++++++++++
 include/configs/k3.h                     |  8 ++++
 7 files changed, 153 insertions(+), 10 deletions(-)
 create mode 100644 configs/spacemit_k3_uart_nospi_defconfig
 create mode 100644 configs/spacemit_k3_uart_spi_defconfig


base-commit: 289dc2b7bd25bf9d88ce9e7e263e95234868ca14
-- 
2.53.0

