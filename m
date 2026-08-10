Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85726C5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48C1040598;
	Mon, 10 Aug 2026 09:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CeutsYSIrvOP; Mon, 10 Aug 2026 09:45:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75EED40599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786355105;
	bh=Mis5gDXFJ+vx2JjYlX7vWRxjK1K1lfn13FfIbZ7Rl+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q+V9NRwl/qgGnAJymHMMbO1+YWagxjQgGgAz5rjyYxGV1t9k4jOPmwzVzp49U66/O
	 P/hJfRFvk9Iib+gALQNi3fqYYgXj+iH8rrjcpxwy0zb3pVXiMACD2+AkraULKNcD5e
	 7QiAGBR2SVvtiUwPZTVds3eVrsYgWsXbrLGXxf9Bu3NI5xSWHnl6GxVLdH30bpODt8
	 bnvqx6XhNiFQalIcm1bOQ/Ng4rW6ASFF298pGE6mY+U35dTKLEemCQXtbcXVAsmnIC
	 Bt2mt7a6cvaqE00UuzwtYy1Qc3IVS4SpgW66Sd/HXleLAX+0DpmLFvDA7qLZXvzioD
	 zoDmZlnC61f2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75EED40599;
	Mon, 10 Aug 2026 09:45:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DD56198
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 307486065A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:45:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rkwAudA9B50 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:45:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 906DB6063A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 906DB6063A
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 906DB6063A
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:45:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 941A660052;
 Mon, 10 Aug 2026 09:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CA31F000E9;
 Mon, 10 Aug 2026 09:45:01 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, Igor
 Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 3/4] avb: add board-specific root key provider
In-Reply-To: <20260727-avb-root-key-pluggable-v1-3-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
 <20260727-avb-root-key-pluggable-v1-3-7e27b2b92cc0@gmail.com>
Date: Mon, 10 Aug 2026 11:44:59 +0200
Message-ID: <87fr0m2tt0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786355102;
 bh=Mis5gDXFJ+vx2JjYlX7vWRxjK1K1lfn13FfIbZ7Rl+o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZOK0CinTcOTAuZJMn3P645pZn+QOIjCfl1cTQoA3lzSt5c0HNbyWoCiJz/CmMPRui
 b1j/Xpf0YBfPJ2hrBRDCxQ3wFRzaS6zVimXYBZiWPRSdm5bXbBXo/dlMEs9olxY9ad
 QU2CqiGiuroaHo4U+g36xPqpnlTGR24pyVVHkDG8flcsvusGyJvVPGh90luNNlY9Z6
 FOmbV/x90qD9LX6A8+fPQSvd15w29GWoF4y5RB5ZxC8VcnlCDce9wT25DIX9m668cB
 kMEdDLw4raSA+M/0rvreBFojoudA50oOf46zECZrMFqt/7XB0dAJIXTHS8xPaJlNhc
 3o2hS/QrCskBg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZOK0CinT
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

Hi Igor,

Thank you for the patch.

On Mon, Jul 27, 2026 at 19:14, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> The strongest anchor for the root of trust is a key hash burned into
> hardware (OTP/eFuse), which is inherently SoC-specific and cannot live in
> common code. Give boards a hook to supply it from wherever their hardware
> keeps it.
>
> The default is deliberately fail-closed: a board that has not wired up a
> provider refuses verification rather than silently trusting whatever key it
> is handed. A misconfiguration should stop the boot, not quietly weaken it.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
