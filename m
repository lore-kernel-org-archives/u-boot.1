Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD0CC5AD4E
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 09:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71C374058A;
	Mon, 10 Aug 2026 09:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6JUMom5IYxBR; Mon, 10 Aug 2026 09:43:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 26DFC40568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786355010;
	bh=SVDSkwjYW4BT7DjeLvlo/w/2WAp/hKhxBtDZRfQmYjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tCVB9U7LSIEDRqSDEeO/zt/bF/sn2SADooKvyWrhTt34zVMOWPJvH+KnfIHrDlZJa
	 XvQMDKnbfjfU07M4p9q0SMIn4vdj/+6w28E3NvrmJ4xVwFePwpenxxCf0vfZMm3SXA
	 Wh+vU8B5OCsMxG1RYn5qGU6e3CeKzcdTHctB1vvha36sCefDF8NPAPu4L/Ch30GpNV
	 rIm6qQDWBwl6S9/7fYLP2koreSo3dSikkjtxhsBdR5Ufglf06JAKFtevg2gVTZvUib
	 FVNh4DRwdj2aw9ZGMVVr3H/PQoecq50uS0QjlVYSf0NvEECQ/YgOK4xhkLgOEN4X2D
	 J6hYi6p50TW2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26DFC40568;
	Mon, 10 Aug 2026 09:43:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3592B24E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BB2680C27
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzugLorbUNp4 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 09:43:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6AB1880C04
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AB1880C04
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AB1880C04
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 09:43:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7733600AB;
 Mon, 10 Aug 2026 09:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ED01F000E9;
 Mon, 10 Aug 2026 09:43:25 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, Igor
 Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH 2/4] avb: add OP-TEE root key digest provider
In-Reply-To: <20260727-avb-root-key-pluggable-v1-2-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
 <20260727-avb-root-key-pluggable-v1-2-7e27b2b92cc0@gmail.com>
Date: Mon, 10 Aug 2026 11:43:23 +0200
Message-ID: <87ik5i2tvo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786355006;
 bh=SVDSkwjYW4BT7DjeLvlo/w/2WAp/hKhxBtDZRfQmYjM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=R9wvd24fyqJJAhPFqQh8t4/twXX+rcneZjANOjufwhcy+WZCKfJMdh4FF6GTusrIj
 6TrFwH7APJRWUIApLncQDQC9iKu75mdDNtIL+SuieCoh5PCUF1hNM/T117OGLsLP6r
 EAWP0oZ4Un4cYqZPk2jjhmtUwY5XMbI3LyjrActjHZw5Q6KFucwK6+iLHkVJeHGF7T
 VweyapsurTs1eXRMfUNhieOiLza+zYRoHyFQvd4rbokxPHupNc1uWSJcM8mCU8vn/s
 +RVxibSsjpXCr+Q/iyceqgQj6DaLyFm5zhsKW3fUPm6a39jhtug+jdFsbct+wtzab2
 eaBOc9emRlc6w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=R9wvd24f
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

> When a device already runs OP-TEE, its root-of-trust key should live in the
> same secure, RPMB-backed storage that already holds the AVB rollback
> indexes and lock state, so it is provisioned per device and protected by
> the secure world -- not shipped inside the bootloader image.
>
> Let AVB fetch the trusted digest from the OP-TEE AVB TA. It reuses the
> existing persistent-value interface, so no change to the TA is required,
> and a missing value fails closed.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
