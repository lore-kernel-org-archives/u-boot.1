Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB4606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xlURQx36;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FuJTUPdT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55A60810F8;
	Thu, 19 Nov 2026 09:31:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cTqSj8HlNkfW; Thu, 19 Nov 2026 09:31:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D9F980F92
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795080694;
	b=iJRsl2MmX6ZWig6yQIp+WR8vkIFxFME9p7wzT1bSvmqAmC8yoHxha/7HcIwn3khwMjS0
	 1Wphxbc5qoOH2rvjrgMcG0HzOEKYxacJOaegxnWW0BUa4eKLAxM1s/s9vVAiELlR5Y1Lq
	 +oyX1T98hiaRrx6XNvEIEOaRdlE25pKU5Yf8wBVsCrH/X9Wd+1TDyl5UwNjZLIMxphHnG
	 ehln867mTWCMkDyyPJI32u/hb+EIhYcSJZaW8mFgfq8XF24gQJe7p8VKAvqGa6aNfUXYT
	 crsa5SMjh33XIZgd8X6a+7kTlf6b3r2rf9pje7CqYAA/Do3fN5GNY+pXH+G72tWpupA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795080694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DzxBYvZHg+vKg5AKzYv1HnOWKLg25giGCy4+e0XuIvI=;
	b=fjgvZUuHvEMhZknxeGv29780PABtGLYmLRiojoCFNIetkEUN+UM3gNWmnMdZ03G4OZRp
	 Jj18fjey4d8d0qDYrDGBLyQIl+ZYYqLuMfylfASSeCAmt3MmBqkcS3+HRxya+L/eu2G7E
	 cPwoU2JpBhX+yj6N2nOfSmUrt8cnuPuJWzSSrW1Songz3C9s84PVlJ3wShODZRDAaFGMN
	 Kgbs6BSp2IP3T5pKFO6qQc1tCE4rASJ1HakWC8/L08d63+H/NxW1jQGwgI+KaLy5Bmlvm
	 MPLXl0gVXc5vhLH5uwoRIv415UpT26+r70C7ktgpx/O2LtzsT3G6LWlqfyXTkPC7CNA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795080694;
	bh=DzxBYvZHg+vKg5AKzYv1HnOWKLg25giGCy4+e0XuIvI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xlURQx36JZgEMqoSJG1O/PhDyoymF7WpY/4ovLMx/A5oTvv8aBlDigN8b2mmymi8g
	 GANaz909gIngksiRXu4NBgcfO9UFCVmIMb1N93Ek9X/+NDhHoV22O/6Y7kMo98s5Mp
	 DMVFL0+menxF+1zLfe+waWV5T/koUtcBovoCl7PMdQlhgvhb3SlKhMF3pm9/CIpbt1
	 P7NRKTKwlydpjCpxHGzGqrLZMWkPkbQ3HX5t1hKGl8RBddOn78VZOiFql6Y2bjmN+4
	 H/gZgf4Dvn+m9QfpOq8GB5e1XWt3yCB8hQmCA0LtYLCdkEGz+hYZH76npUDt68O57q
	 jhz3bNMd6mpRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D9F980F92;
	Thu, 19 Nov 2026 09:31:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8787B1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7935760A94
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfguOqTAhq1M for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 09:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5902660622
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FuJTUPdT
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5902660622
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 09:31:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE3E961FC3;
 Thu, 19 Nov 2026 09:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A4B1F000C5;
 Thu, 19 Nov 2026 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795080684;
 bh=DzxBYvZHg+vKg5AKzYv1HnOWKLg25giGCy4+e0XuIvI=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=FuJTUPdTi4P+wlrlZyjcxU6WYTHV1GWPII1cF9ChrWQ81M5NS/Tjbc+WQG6goTQ4K
 Q4sGY489y2ly6NojeeDKAinYQs3K8naqy8pTx1UnOhrHIIDEpVpuHRT3rTD9FMyaLr
 +Zw41yr5R8co+f/s3vQ4qUwma5Tq537MlrnhOlrCB8iiSugFyBHh4+8LGWRthTfUqn
 wJ7FH8UYMDGFiArDZlNZ3LXwiYEyC9aaOYnsaIMnJeNyAcBdGP3omyL4xRFOYL1s0W
 zYEksQuXJVQVfMnLg7UhIfeK/lMXT5RkngWkXJqmhMd1J6CVnHOfN2Zu2e9LjmEpO9
 5+Malc31CqdAA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] bootstd: android: act on the misc memtag and
 kcmdline messages
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-3-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
 <20261111-upstream-android_rollback_misc_b4-v1-3-47d17e8a5d92@gmail.com>
Date: Thu, 19 Nov 2026 10:31:14 +0100
Message-Id: <179508067427.516692.10706482951116120374.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=vuNeUvQmK/GHnQm6N4LmKPxAlSinX4JieHJ8FhNKWyA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/sHlfyr/ye7ZDqK4fI0NtOYZTE6sgaQfNMFPJ
 8tarwUxq7qJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav7B5QAKCRAZDR20Zk4Z
 NTfRCACsM4mDLgIRjCB8NbxYjwT7XJuABivoPG49GENhynFtSiZEvtmnWX7gNv3PMcAEtQInNe/
 JBTz6MOdep+UgImTP7dHTpq3ToeM5iG8Yjna1xmQBd6W1dh8rwyHgWV5gq2cCMnfMmt26fg9lwb
 YuJjS4dLArBD4jQhUEZ5rBvy3fGUchyoTxpsLhf2ME3CmWjLdcFq71mNYHJT/n/epDvHVybnFVi
 84t5Pf199OYxh+avvtJD/okF8dw76XjLc2kNIO+LP6HX4W8cqORt5fTIHhb5gaEPdiLA7QO4wl/
 AtTyEb6y8Z5MBRv7oFP1yT6rOdXDDrmMkZpI5AvzpSih7tNV
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

> Android changes some kernel command line options through messages in
> the misc system space, which only the bootloader can act on:
> 
>   - mtectrl writes misc_memtag_message to turn Arm MTE on or off. The
>     bootloader passes arm64.nomte and kasan=on/off accordingly and
>     clears the one-shot bits [1].
>   - kcmdlinectrl writes misc_kcmdline_message to force the Rust or the
>     C binder driver, passed as binder.impl= [2].
> 
> Read both messages and apply them to the bootflow command line.
> BOOTMETH_ANDROID_MEMTAG_DEFAULT sets the MTE default when nothing was
> requested. A missing message is normal on a device that never used
> these features.
> 
> [1] https://source.android.com/docs/security/test/memory-safety/bootloader-support
> [2] https://android.googlesource.com/platform/system/extras/+/refs/tags/android-17.0.0_r1/kcmdlinectrl/kcmdlinectrl.cc
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>  MAINTAINERS             |   2 +
>  boot/Kconfig            |  11 ++++
>  boot/Makefile           |   2 +-
>  boot/android_misc.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++++++

We already have something that reads the misc partition (cmd/bcb.c)

bcb is also very useful for debugging. Why can't we extend the bcb
command to also handle the new regions (such as misc_memtag_message and
misc_kcmdline_message) ?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
