Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E81C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 10:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C311F86F34;
	Tue, 19 Dec 2023 11:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KFYfhIGE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9341C87005; Tue, 19 Dec 2023 11:11:58 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0A686F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A1223CE17B9;
 Tue, 19 Dec 2023 10:11:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2C8C433C7;
 Tue, 19 Dec 2023 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702980713;
 bh=gnWWrEAHeKwAe2hcEWUU558eHqVz2FLqb8W0ZSah5JE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KFYfhIGEO+QWZhyJSW2UNeIRsvidc3f83vhzZvXycwHV031X4hgaj3MpgxCU2rwxF
 6PXuvv7tUbwAcNmSTj7WWhfP5hLGG/+xQny5YD0Rp1cLjZXjFTQL0eH+mqqDSvRwcV
 hMC5SDyJbnycqNA1BA4vmE653OETgn3T//fkUvyXbchMkPmM+awX62Ms1T8eTEFY2d
 5DAX6xX6+AqcU9MYOMzSbYu5A2LfDjK2Kfqv/2tfMQD2CqmAT0TDin/hwP/Hqj8CL9
 3nykB7kemjfLdI6TuBuEnqi3RTVOJElF2V/dq7aa7KM7L9kjJOx1fB0F401H1Krf1Z
 ecylCKHx2fftg==
From: Michael Walle <mwalle@kernel.org>
To: xypron.glpk@gmx.de
Cc: Abdellatif.ElKhlifi@arm.com, Drew.Reed@arm.com,
 ilias.apalodimas@linaro.org, mark.kettenis@xs4all.nl, nd@arm.com,
 sjg@chromium.org, u-boot@lists.denx.de, Michael Walle <mwalle@kernel.org>
Subject: Re: Adding EFI runtime support to the Arm's FF-A bus
Date: Tue, 19 Dec 2023 11:11:24 +0100
Message-Id: <20231219101124.2847425-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
References: <B06FB6F5-416C-440D-BC72-070673DF3177@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Heinrich,

> Any runtime device drivers for variable storage should not be in the
> U-Boot runtime but live in the secure world (e.g. OP-TEE) FF-A is the
> new ARM protocol for talking to the secure world and hence fits into
> the picture.

What if I just want a simple embedded boot stack where I don't
want any secure world and just want to be able to boot a COTS linux
distribution via EFI?

Assuming, that there might be a simple dedicated EEPROM to store the
variables which is not exposed to linux, is that something which would
be rejected by u-boot mainline now?

-michael
