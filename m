Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083BE606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Os6nnFQh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opGvpfRV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C727B40815;
	Tue, 17 Nov 2026 13:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Ys1MHB-fGbS; Tue, 17 Nov 2026 13:31:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 016374081C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794922313;
	b=Ri7pI0DMz33KDM2PBFbcmvCoTEwRB8uq1Paai8IeoIXwA4+iiYqhH+yoTMm3AStk4X1f
	 /GPNVBdZ59+8kQuLjume0ZMrb40cj2eySZpApUsF2A6Q3hYJ6vcwpyJFdHbBodRydaF3D
	 ZI/y/02FXqD3lMA/kDRM2+lq4ksWKSi0FYcmNRckmmLnS5i4B2SiXjoUry2p8KVjWVR1K
	 5mqltNyIMdWeWhHfQPs5zRGnnq/XKmTeM25hq+9lFYrjoy1C5kFzDjesPRzZGDuMyGVLV
	 Kaf2OhDpmyqA5okECK75AZ0AIx3+7waSiJI2oQX7tFmjcBxIgG5IElWg+zr+3cGxlSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794922313;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JLPOcr6hSgEQF6mRGdI53feeLUxOQeWLmf8JqSHmsvE=;
	b=jV3/rPpy1f+KS32mftmKtjPfJfr/hbgZmQV1RYM0wT8DtLZTVrTInlldfh/LW9CmvSJu
	 zhUG46kDGNgRhum+76HbDee/i16Gsh91jeaprFXZLXzwD9d33Ojyit0tKCqXqzNV2pQ2j
	 kb59UWaX3+7ifkp2rmhr+qh5Dyrnqm+ozja6mvLH1YXXgwB3cE+vay1JqNUuH5lZsRpBt
	 Q/XE/E0In8RbqVyaojVwXG7n154tolTOhitH2yBz+5GOB6es4DA8Eq5/cfpGs8e63Lxpy
	 +5qSsRk1jN/7cQXS50nGLBy1+ZiUg8LojRqLnGWdAsPwlVL1erkknIluWNgn+cJav0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794922313;
	bh=JLPOcr6hSgEQF6mRGdI53feeLUxOQeWLmf8JqSHmsvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Os6nnFQh1WlTp8lOOw2Glc+mmlfcoA8XeUcgGzvWtrHy7L4v/dJVCEVgrL3MetDMB
	 FNk14PS6h6MTc2+IYAXjiyV3cwMhkMH69o/Yxdc66GQzVVwIvGzAWXpJR6tHQkoQvo
	 2t6U6XtgqDGphjNcnXQ+QbFM8YSGUrTV++I/thA7C7ViwsWMfH7kuHMQhp55mymiXU
	 efirb90/zHxai5cT1HwZD2p7wVq5LuFfu0x6Y57yWpuDMqb3UcGz2dTY38lT8evoJS
	 HXFtpyEjDhO1t8kbd7PQwc+5fyr8y9PJZ9BOWk6BctYGA+bDSeHDAn4LlH7RMCL/EY
	 twlqNC1zF9S+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 016374081C;
	Tue, 17 Nov 2026 13:31:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F58B1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5614480D02
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJ80jW9QRpgO for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:31:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 42FA7809DD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=opGvpfRV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42FA7809DD
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:31:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CD75628CA;
 Tue, 17 Nov 2026 13:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CC51F000C6;
 Tue, 17 Nov 2026 13:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794922307;
 bh=JLPOcr6hSgEQF6mRGdI53feeLUxOQeWLmf8JqSHmsvE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=opGvpfRViy6fKkIhgSSkl6tE5nFWDq2bydD0FPW+BliYyVjUoDboC529k1zA+i4KM
 hCJRsPHX2fkx3DFaQxiBkGfSPoPpitY7S8IKSpenNayv3yIjVd2NmWgmi5t2ZsdIM0
 DWBhVLS11S52JKT99XgtTVMFvxM7G6gXi7urAs0ttOAfI6UVbvi8ykzR/AJakYwPib
 A59QfR5Oynz3vMAC07xvY/9lPm57J5ydkmUpbBLXt8beZucDT335xxYx8qsIYB8PUy
 XZDHtUkpgJk/t1P9WQdPuwxB/aX4ec9aQVX2HV8p6Jh6oQ5nNO9hnsqDSjCgY0smkN
 EgaQTjEsRK9cA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
Subject: Re: [PATCH 0/6] Support fastboot boot in SPL
Message-Id: <179492230542.246593.14014203987510433850.b4-ty@b4>
Date: Tue, 17 Nov 2026 14:31:45 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, 14 Oct 2026 14:24:28 +0200, Carlo Caione wrote:
> Test farms need to run successive U-Boot builds without rewriting boot
> storage. Add optional fastboot boot support to SPL so an already-running
> SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
> then load the operating system using its usual boot methods.
> 
> The standard host command, fastboot boot u-boot.itb, accepts a FIT built
> for the target, including any firmware required by its SPL handoff.
> Uncompressed legacy U-Boot images and raw binaries are also supported
> when enabled by the board. Raw binaries use the board's configured load
> and entry addresses. Legacy and raw downloads are rejected when SPL FIT
> signature verification is enabled.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/6] spl: fit: reject failures loading an explicitly requested FDT
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/088e6f84ba52e62b96b018d48fc0a9d5deb57307
[2/6] fastboot: invalidate stale and incomplete downloads
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c99169ecd5aacd748dd2a84837ae80b346fd8e07
[3/6] spl: ram: allow loading FIT images from a supplied buffer
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/0160e29255b32b0f0158da4cae69bf360aa9e6d2
[4/6] spl: support booting FIT images downloaded with fastboot
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/93ba4e8d4d3d5c75470e9e4a805997260182d9d5
[5/6] spl: fastboot: support legacy U-Boot images
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/a8ed070e54f83cb16149db910b2c46297e7e7828
[6/6] spl: fastboot: support raw U-Boot images
      https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c52cc53f454a3f7e039357a839a2b92f56432bc6

--
Mattijs
