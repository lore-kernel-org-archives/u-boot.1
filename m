Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F95C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCB40409F9;
	Wed,  2 Sep 2026 12:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u73Bx8wOUCh2; Wed,  2 Sep 2026 12:30:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788352202;
	bh=7zd8mGpdfbdZF6cvVUMfkSd7/UPn6DSJ9qXMKZWT0Sg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=szjYjLduFdPkTpbOINcfbI2rFB/9f7Woeo28iDbV8r/Kb2LcU3Hnqb79EhurN9h6z
	 b+NpIfhBzXnsrS9M4OavXTanIe2gSNlRaxj0/CK82Px/ToMdZxxbgv+R0R5lM6V+CI
	 7JvBv8m6Sz1myWYVQIQReD2BpHpx4Uf1IcpWohu1r+ZIVf4wXzD7Dfim5v8uBDeZed
	 ttUELdTdRcNKaoKnjIKINM6vSm0DyBYh7njl4t/SALoDT0+c/FkSwbgj2KgTw7dfwF
	 QsHX3wRNc/Jg+qPOT9ExCrxilKOaMz8b0o2mxix++/4BMp9tKQ7M/kQAvG+r521YMl
	 ts/3z0KhG2L+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74BCD40808;
	Wed,  2 Sep 2026 12:30:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F5A22FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3500360703
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:30:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1pnhjgCHEcH1 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:30:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=MDojpGyR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EC07606E0
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:30:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 208B1600C8;
 Wed,  2 Sep 2026 12:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2799E1F000E9;
 Wed,  2 Sep 2026 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788352197;
 bh=7zd8mGpdfbdZF6cvVUMfkSd7/UPn6DSJ9qXMKZWT0Sg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=MDojpGyRfe21Gy0u7S4vcD3NWuOQ8DtrMLp8ulTdWAbzv09YW3vsAJqsB+U3hYuil
 ywGEoacr8U4jWP7JGJvgZRT5SZXO3q5ZhxzIwlcpEi6AGPapofWVq99zCAbivGbP7W
 lIcxearGVekl2ey/9u3C3dJjARhGqh7qpBseQ8tWwia4jd1WDYVMackpEJdhe2XsCm
 BiQGOQFfKKykW7Tf7IBVKDEtdDa3nqrUbR4xm6P1M+3W89ZBjCXLEcQ5Hv1Y0QYwux
 X8IWMLIMQ5zUTXI8Y/+8pCfYZl97Hmvm6R6Q1xWOHvmKEOJKZmKpD6u9/Td2vJZIcu
 lmQX3g1gC3uHg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>
Subject: Re: [PATCH] dfu: mtd: probe before get_mtd_device_nm()
In-Reply-To: <20260901-rzn1-2026-10-mtd-v1-1-516e2177cd20@linaro.org>
References: <20260901-rzn1-2026-10-mtd-v1-1-516e2177cd20@linaro.org>
Date: Wed, 02 Sep 2026 14:29:55 +0200
Message-ID: <87ik4nn8e4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Ralph,

Thank you for the patch.

On Tue, Sep 01, 2026 at 11:34, Ralph Siemsen <ralph.siemsen@linaro.org> wrote:

> Parsing dfu_alt_info depends on matching MTD device names, so it is
> necessary for all MTD devices to be probed first. Move the existing
> call to mtd_probe_devices() accordingly.
>
> This fixes a failure of the "dfu usb" command that occurs when:
> - dfu_alt_info contains SF devices listed as via MTD
> - there is no persistent environment stored in SF
> - "sf probe" has not been executed prior to "dfu usb"
>
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
