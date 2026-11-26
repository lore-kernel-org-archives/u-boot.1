Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F849606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SHfCXocW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMl96wog
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B4A7810F7;
	Thu, 26 Nov 2026 13:21:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fIxkUtXxfcFt; Thu, 26 Nov 2026 13:21:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7285D810F9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795699294;
	b=hO75yORv2G0OYD90QGl6nYRtH/A0tlk1G9vrAgI20uCkhrsWRWVdro2PBYltBnz7wWyj
	 nR7VHAFvNzTUdwBi7TtqFD3CTRZWuULSPDqTUZHxyWWRLtQgjkE9SnwuGoY++zUI8JKaj
	 jrVedQT8TwGiZIYGq9qCMGnjfTU0fVuqIZ2FojNAfEMZSxX5+eHn5zA8anHFCzQzXGLNb
	 +e+XAZ/IFQiB6JhdpxSSWom6rCsImIGBuzu9XFGqaj2cSJSByqKBMGGT5Gxx9LAkMjP2k
	 8jVx3icGlV8xsOlJl6IJ/I+RhtMa2nNukkTCBYl6hVMA5CFswk87ziHOWgKxif43kHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795699294;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6uqWiGK6qYsKT4OvKJnRCXNWzU76Zm4sbCMk/mh2C5U=;
	b=DyK+d/k0kK43zlSbTModNFz6mhxOu14SrVHkQf9sNaAo6CGccGDbeQUyTwKlh6j/3jxH
	 HIK7YSqTDLWNBDAVGIFJfu+SYBW7oAmQsub6TLYdynJWDmNNNpS6pavDN+wk8T60NNvjz
	 zxCrDxXgSLUDENe7SMVcvOmNBuaEQZq0UEKLRTKcfXJ8d1e72pzzXhFdJ2PmFlcCtXvNH
	 ERoTUIyNB/oMTV3sIajYHwbKn+JXtMBjvxRO0Yf8/Xjh1NOfjAy407+rrbnI0Yq1jMeKX
	 d2BihOT2HU+AY2jHwg5yC+qA4GyW9KPVeV/hPWJ0xrv3XIN5Ff58Nt6Ig3I8xX27MFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795699294;
	bh=6uqWiGK6qYsKT4OvKJnRCXNWzU76Zm4sbCMk/mh2C5U=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHfCXocWGajRaur+QvU1l4406SmBsyOVYsWxe1mC8/TNQ2E3Hlm79gV0lvCrwSNPw
	 iToHi1FE+kwVjBEUnw0nBM+5nyJSHbpe9YDc/dFGnuEv9wMKCwxljcBMTEIuWLjPp6
	 2jwuEYZz8PkFNfGgn4rr0pvASLki/Z73z5/TKXAvgCfBmVQpDPdKw/kl/DjPtaASzw
	 Ef/iXiyhSGwhEbYl49ni3bCr9MgHDH7G/omnPf31AygxFb17JYmuocUTxwEz9W4t0D
	 Sc4lc+Ot5+1Qfc+6VKbr9dp2ESiDz4qumCNuLhMISXVH0PQAFGRm59cUcL7RebJFV5
	 JLlTeGWCfnWHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7285D810F9;
	Thu, 26 Nov 2026 13:21:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C96C32DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:21:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBCAD409C4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:21:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2m3OlJIJHzh for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C1DBB409AD
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IMl96wog
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1DBB409AD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:21:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9125861189;
 Thu, 26 Nov 2026 13:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510691F000D2;
 Thu, 26 Nov 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795699290;
 bh=6uqWiGK6qYsKT4OvKJnRCXNWzU76Zm4sbCMk/mh2C5U=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=IMl96wog5uzuSJF9aCmv1YNP/mHYT6iwu7VLtkQBH2/0R6mCsdS20MjO9ufFlABZ7
 CA0tTGOycWdWoHlnDKr+tv9L5fJmTLaJUjrOCx3UbrMj+szXGSVYvk9/FXbH8PpMIq
 C8FsTXpdJ7OjhNHR/1wjNCZyUwPIXYQQ/bFCvBeU2T9BKBhjED5GpC4PgGBKB3yTaD
 3w8RW2F5sZ2oTngrWbiU4GFYJMfXXxwX8roMyAM2Wvc+lBolBKMWdjL3u8I9gN6xsR
 rElP8gaRD/Nv0IkWHvN1X5xDpJMEfEKaQY3gaCo/voO8A64JDogOBhgHn29o/LG+zH
 YKWruxFARwjdQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] qcom: add support for the Arduino VENTUNO Q
 (QCS8275)
From: Sumit Garg <sumit.garg@kernel.org>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:51:23 +0530
Message-Id: <179569928382.130558.500231708732441851.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-09-28 14:06 -0400, Tyler Baker wrote:
> Add support for the Arduino VENTUNO Q (QCS8275), running U-Boot as BL33
> after TF-A [1] and OP-TEE [2], both under review.
> 
> Depends on the QCS8300 clock and pinctrl series [0].
> 
> Tested on the Arduino VENTUNO Q, booting Linux from eMMC.
> 
> [0] https://patchwork.ozlabs.org/project/uboot/list/?series=525523

Please rebase on tip of mainline as the dependency is already there now.

-Sumit

> [1] https://review.trustedfirmware.org/q/topic:qti-monaco
> [2] https://github.com/OP-TEE/optee_os/pull/8053
> 
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on [0] and dropped the SDCC1 clock, QUPv3 clock and TLMM
>   patches it supersedes.
> - Reworded the commit messages and retitled the boot CPU and board
>   patches.
> - mach-snapdragon: depend on ENABLE_ARM_SOC_BOOT0_HOOK and keep x0 in
>   x19 across the PSCI calls.
> - Link to v1: https://patch.msgid.link/20260924-monaco-ventuno-q-v1-0-290b6a4d10c0@oss.qualcomm.com
> 
> ---
> Tyler Baker (4):
>       board: qualcomm: tfa-optee: enable the OP-TEE library
>       mach-snapdragon: allow selecting the boot CPU
>       board: qualcomm: add Arduino VENTUNO Q support
>       doc: board: qualcomm: document Arduino VENTUNO Q
> 
>  arch/arm/dts/monaco-arduino-monza-u-boot.dtsi      | 26 ++++++++++++
>  arch/arm/mach-snapdragon/Kconfig                   | 18 ++++++++
>  arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 +
>  .../mach-snapdragon/include/mach/boot_cpu_boot0.h  | 30 ++++++++++++++
>  board/qualcomm/MAINTAINERS                         |  7 ++++
>  board/qualcomm/arduino-ventuno-q.config            |  5 +++
>  board/qualcomm/tfa-optee.config                    |  2 +
>  doc/board/qualcomm/index.rst                       |  1 +
>  doc/board/qualcomm/ventuno-q.rst                   | 48 ++++++++++++++++++++++
>  9 files changed, 139 insertions(+)
> ---
> base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
> change-id: 20260924-monaco-ventuno-q-63004d5589db
> prerequisite-patch-id: c0fef6bb02a82b4f5b61501e49cad1e7708daef7
> prerequisite-patch-id: 06388f0977fc92b03e70c487e8034329b387b91a
> prerequisite-patch-id: 091a7963c8a71ae7cb102acba6804e07e8aee469
> prerequisite-patch-id: c016bba5ae2cd43dfcf4d7c221c621ddbd042934
> prerequisite-patch-id: 011832f8e6a00a4be544c1364c57de5627968df3
> prerequisite-patch-id: 54ead588cee6911c64149ddaaea6298697e536c7
> prerequisite-patch-id: e8b558b8a84bc2fb2c4c4f6c383bcd68179d2195
> 
> Best regards,
> --  
> Tyler Baker <tyler.baker@oss.qualcomm.com>
> 
> 


