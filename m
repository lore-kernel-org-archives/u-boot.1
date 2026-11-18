Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49375606A336
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MhwqTz33;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZJzX/aH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B196840A1D;
	Wed, 18 Nov 2026 15:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fu61kaYBUGqh; Wed, 18 Nov 2026 15:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06F4C40A11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016624;
	b=DRJNO1W+iWZFSqbJFLbTIvKcw8Imd2v821MALNV0CQqf3/4XXFtjPEk6hc0JZwEOTGgv
	 Bb0I3fjhUXgyIDIgLFaXIGUODxHYI3oW/hPrZvxHfWM+QMKEo+C6ROJCOxOOZApuEgv8J
	 Po805HEMuTBZG02IyCdRU5yxDGD7L89ioXFk+FqbNPHS+lcGiuHrML9KbkB4iOtqQDn4S
	 24Ro0VrwL7jiTGuwOIZ+wyejB74SG8u81n7CKzmHqvyWydsqQNkCA5eXpcNGeJQd1ME6J
	 7/kSLvuKX4mgmM3PDy7/NpGnLcvt+XACwdqPfsQlST7kN7B+jFU1nlLLjIz+UKUkDIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=F0lOhhKdoD4VQ438yUAULbE0tPB67OQ3BxrEFCnZLio=;
	b=dVdeCrqfJ+HMatvXqiBdU0wIrBtQn4cb40azzrlpl2kt1ItEDr/2A51D4MGXZckJeID7
	 6P99YVqwirBVvtsudWafidVtSjGSTJtm/BsdA9El37GfmLzW7OjDVB1jLsUApgYTGAWo9
	 tLna3fSYdXzfRtuYfo14E6gShybjWQiOo+ANUrXUnUIkVW9l6RrZ2W3IWHK3ef8ZLD6Wt
	 5hQF2mKu/6VayjCaQyCUzNEasAMDJJ6E0oLKNLUxgIqLDDpYrpRC3UARR5gGpuL664u1r
	 INFPcKZMDysDUEDrhbqWcdHVTVLrih2TCRrQw+6csdbpJTEAMKk3GX4PLDgF3gf974A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016624;
	bh=F0lOhhKdoD4VQ438yUAULbE0tPB67OQ3BxrEFCnZLio=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MhwqTz33u6l2IwsdWkM/KaHuC51mB6LQ24Bgm42DfUJt3RA6UhrbuL+FfLHaPZc0D
	 nliLUthCI0lR4Xi7f809Dp0jPmIysWMt47QekM5NwXrV/04qqfHcBh9X0mT8oSfWhh
	 4CJcZJXjBDgu+zrRhJmGXFoof1pCghAdoA+32KtpP8R3xFgKqjcG3NWRm583Eia861
	 +pKj5VYBp2z4mshObpZNmG/A6CyQvuqC0Q5extb/6nZ2hGagdMY69CclyzMj3m4v86
	 W6GPurG6A1GNFpMzPFKCY3kbozI0Xep6Nr4PvLD2SAd0qYgx6YSdLf40FkwN6Y0fLh
	 t+BVUTPuWvmWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06F4C40A11;
	Wed, 18 Nov 2026 15:43:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5880E9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E91960A67
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyLnG2JmbhTY for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 78B1F60A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CZJzX/aH
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78B1F60A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 981C8624AB;
 Wed, 18 Nov 2026 15:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A311F000C8;
 Wed, 18 Nov 2026 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016618;
 bh=F0lOhhKdoD4VQ438yUAULbE0tPB67OQ3BxrEFCnZLio=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=CZJzX/aH9aYl/frait2E5b9r+ZSREi8ObBS4htIifG6Vx3pyrmgabxbkJSsm1dKmc
 3B6ZD82LzwDt5RbY4ZcMiZPKwoJo/CwFXAKVdE0jLzbkvJoHk/mOq2hgXGOJNJ2cBe
 PIKSsKHfmT30M42SbPrdNQrHPxT34w+sd3R00dadDdqHxrIRHESihZmMX/6ov6VOaY
 knw1Q6zIRyztspJV+mze9F7Ep0iG22DuBMwdowyRERmJdi7aOGSHgtVI042jwZ2G4s
 EXDthxgIQUBLWi8JxvBaG8eZplvU3UymidFkhOvDrIqh9n6ggpatmR2SnX7Riee9yb
 +ExPFHfUHy00g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] tee: sandbox: keep zero bytes in persistent values
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-1-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-1-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:43:33 +0100
Message-Id: <179501661321.306911.17120967959562497081.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=7FH1f62XQ75X/zyY2PEqS68tuhPfmej1H85bbCqu3mM=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/cenVqbz/VGG5zlMDZedscLfUUlrD6/7i4AVK
 WvCEJyqPqeJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav3HpwAKCRAZDR20Zk4Z
 NS2IB/4544zk++xj4wgFk5ZQ/WSV37MUn7utG60+ulB/6gB6svoULAER4aRzL2xclJO77BGRx/J
 cJaNCeKSj2yWh9A7ESvbfBbaNzQDyXyA8T5T9VQAUrTWdp6jIpg/Fr79PsjTpiDxrIXtusJFBFm
 RjyFn8ikJnXwmsbz6OI/1quS7OLZtlt3WkTPwQSNPc5DOiZk6bT3eqsAD3QatdQ5wU7xBNkHCOX
 rV/zfGIRF5x+sHPP3Sd12EAugBI61HTbsC0phtjnQDbvex1VSlIxr+vEXlWfPWGkZ3V3hcFkaov
 376bCflXk9M0Lv2+21Ll/Jq8cBXb8u8OSQW4w6HPoKBhJ5BH
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

Thank you for the patch.

> The emulated AVB TA keeps persistent values in a table of strings, so a
> value is cut short at its first zero byte, unlike with the real TA.
> Binary values, such as the digest of a user-provisioned root key, then
> cannot be tested on sandbox. Store the values hex-encoded.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/tee/sandbox.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index 16e5d95616ce..92e74add3e3c 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -4,6 +4,8 @@
>   */
>  
>  #include <dm.h>
> +#include <hexdump.h>
> +#include <malloc.h>
>  #include <sandboxtee.h>
>  #include <tee.h>
>  #include <tee/optee_ta_avb.h>
> @@ -268,7 +270,8 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
>  		if (!ep)
>  			return TEE_ERROR_ITEM_NOT_FOUND;
>  
> -		tmp_sz = strlen(ep->data) + 1;
> +		/* values are stored hex-encoded, see the write below */
> +		tmp_sz = strlen(ep->data) / 2;
>  		if (value_sz < tmp_sz) {
>  			/*
>  			 * For TA_AVB_CMD_READ_PERSIST_VALUE2, reject
> @@ -287,7 +290,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
>  			tmp_sz = value_sz;

tmp_sz gets overriden here again. Is that not a problem?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
