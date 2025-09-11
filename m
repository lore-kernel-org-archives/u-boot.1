Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A80CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 03:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0868319C;
	Thu, 11 Sep 2025 05:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ieKcDQCu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="e1BU4s4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA8E831C2; Thu, 11 Sep 2025 05:29:00 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5B58003E
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 05:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cMjhT0swKz9tTK;
 Thu, 11 Sep 2025 05:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757561337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKRqRx1Qjo7f98HhSagw0DYWTx14ORBxoHHgU056n6U=;
 b=ieKcDQCuFiW/7AvUK6G1f1x9h1IlQ/T6LnxEEnqACMyH+BuKKgcaatcqL2P4Jza/YwLGt5
 E5Kkh9UrEYEEcSsCJvNkSYBhNuKm9a+SLm0vy/hYGAmJHoHFA4OZ0AAohAtjgVZZTFQvmB
 NKWzVFoBoNyqPLIUVt5NTeZrZBr+VvxhIV64jY8xSHo5/nx/3K7E3kchWiAPqruSpivAxA
 x7z8L3VxCBXW6yw2dAvaFE+a3FT14vnEXTAQMt06wbPflIhvQ/s1SAe1Cj8NVPN5tzhJKF
 7eHFUl2zQxPHembXdXsYR8pGUcNSLK1AJehcpVDx4YYuew7oS6jFlEpFtkFArA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=e1BU4s4X;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757561335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKRqRx1Qjo7f98HhSagw0DYWTx14ORBxoHHgU056n6U=;
 b=e1BU4s4X4Vo6oO40+0KBUkxupaV732LGJaRS3PDjB8HoSz+07LocWKvXnyDUwEz1W/uR5t
 rzBSyyf5TIhTb3qOz+L06DmogBFc6WjKHkS8JpmOokWOPxGktWSFV+fBGR1yYfXk1VaI3F
 +abtkdTmenluu4xr6297in1F91yTRuaZYwIjvDmaz/Yevz5vFFRJ/xd+b2ZUvBtXWQgxoL
 IOTvla7CTZvn+ZiC4nrrA+ickZQL0DSJl3ghiHNTdqi+x1LQr1ZEGporJ3TroNM42DzkSf
 fFwtU2HrGah4DuTWEEGHrYduxOn/pzJHs5HgTXKCAT0u0fG2f+vZKpAGCijEHw==
Date: Thu, 11 Sep 2025 05:28:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 62b01b5c48e59bb5c27
X-MBO-RS-META: xdq5fqemsebroe471hgugs6ek893q84m
X-Rspamd-Queue-Id: 4cMjhT0swKz9tTK
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

On 9/10/25 9:26 AM, Michal Simek wrote:
> In case of ENV_INVALID (uninitialized variables) the first env location
> should be used for storing variables.
> That's why change the logic how env_valid is setup to be aligned with
> offset calculation.
> This will also fix the print about Valid environment is showing proper
> location where variables are saved for the first time.
> And also fixes behavior where the first two writes were going to the
> first location instead of the first to the first location and second to
> second location.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Simplify commit message
> 
> Origin commit message with more technical details.
> 
> When both location for variables are not valid (or empty) gd->env_valid is
> 0 (ENV_INVALID) which is setup by
> env_sf_load()/env_import_redund()/env_check_redund() calls.
> 
> When saveenv is called in case of SPI env_sf_save() is called which
> contains logic which describes new/old variable locations.
> 
> if (gd->env_valid == ENV_VALID) {
>          env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>          env_offset = CONFIG_ENV_OFFSET;
> } else {
>          env_new_offset = CONFIG_ENV_OFFSET;
>          env_offset = CONFIG_ENV_OFFSET_REDUND;
> }
> 
> In case of ENV_INVALID option the first location is used (else part)
> and variables are saved with ENV_REDUND_ACTIVE flag.
> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
> 
> And
> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
> but that's not correct because the first location has been written and not
> the second one.
> That is confirmed by
> printf("Valid environment: %d\n", (int)gd->env_valid);
> which is showing number 2 (ENV_REDUND).
> 
> That's why change the logic how env_valid is setup to be aligned with
> offset calculation which also cover the case where initial state is
> ENV_INVALID.
> Then print about Valid environment is showing proper location where
> variables are saved for the first time.
> But also it is fixing behavior where the first two writes are going to the
> first location instead of the first to the first location and second to
> second location. Alternation is happening after it.
> 
> v1: https://lore.kernel.org/r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
Sorry for not being clear, the original commit message structure and 
technical details were fine, it only needed slight rephrasing, in the 
original form it was very hard to understand. Can you please reinstate 
the original commit message and only clean it up slightly ?
