Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A6606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ADh4YWBl;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTOYDD+/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EE8780DF9;
	Mon,  9 Nov 2026 19:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlwN7LbSiQs3; Mon,  9 Nov 2026 19:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6F4C80C93
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794252532;
	b=rmhl3BPW6bQflPgpBwZXTcshxtAVvngfS/6LFSAW2W2HoiHuPROceQyadXiQEFpyn8TQ
	 yYaP6LFjhFgBfiB+ak7l+FExiBFRmMI4oAYdeDFcsTlZRosegBiXckw4f1wZCFdSDG/G8
	 Gg+s2xsX9qNMD7WzEWSDFT8Wm9m0/lLZgreRh4SXdAmDrU8+mEwWQJG8GDY6S/AsxK352
	 EFENDT7o3HUqTPNxSMl2qPHUEbV9k0dlGppZvBubgkPpI2v39zSQCv12ze2E/fG9EjX7d
	 idDHBFI2NA7vxvEPYefaOB2OaS2G+bIdv24Pz+e2bwDxpFUY3IWP7FPwkzosa8F+oxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794252532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8tGMSUvKduX7ynteNROtgvRSX0JNrjkVrUtkwyrmeLA=;
	b=ocOcqnxzRgSedAoaT/Ng73gqr7IQoT22FXWaBZE84JH7q8OstOSTQ2YjyRXV+yHDQB2f
	 +vVJP7Q27QYkFwZwSOKvEBhcU6ouLepqbk8mNwVzqHloyVFMFLPMsQ4Nqa0qJWnCTjh42
	 XPPMpgBT4T222+iKQSyHovOzFXj6pGdmrHHV62M2Bc/uewmut7uuc2vKfw9oPntIeOmFM
	 DgV287cz4KhtNwlOFhzPLBmGDQ1KE0ZOYgj3sll0kg3Ke8W71TenROmLIPh8fedlrbbt9
	 7M6H+3EeXGUn52j7AvXloyuom49lDJ7qTuKcLCFq8wG7CsIXbmlo6tsdVE1gcKznBSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794252531;
	bh=8tGMSUvKduX7ynteNROtgvRSX0JNrjkVrUtkwyrmeLA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADh4YWBl+5iy9EbLe/bC0dcFDnyTwHVlsIFpRrgGF93vHfCkD9PTcwSn+/ZcYfIG0
	 QI6vs2kcytYv5ujiEp0Q7ZwAc+wv3IKDs4QdprQ8d+yOS6I7zXMyQRs+PbdwItUqQ3
	 sh0hb/NZLOQI+at8HZNBf//1qlZqNjq5+YZDPGLm8WVmgNh6CNmjX3/Rw1kZASlJoh
	 nd5q+Es1H1JRW9mQHy/QhXF87lThVHBLqf9dv67adqATlaGKe0imVFcjzvQuF3k+XS
	 J04czjKK/N28ypHUN1qAA3aG01AT7gyA8l24gt6f5gXOvnkg9ahek5ed2BlCyovomA
	 4XehqKilQPMDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6F4C80C93;
	Mon,  9 Nov 2026 19:28:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14ED5388
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EECD060690
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbXPowMYqpUd for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F22F60668
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jTOYDD+/
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F22F60668
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:49 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4f699fe49b3so843644b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794252529; x=1794857329;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8tGMSUvKduX7ynteNROtgvRSX0JNrjkVrUtkwyrmeLA=;
 b=jTOYDD+/ARx8TZKJasQGg7QOxmOaejXjLWhcH2x+o2/Wgt4Mj+xFEJ5JksinfPixbJ
 Vz6qLPdrw2A0gdJU7XZkuLaJJlZykM4/VK5jhMO6ol1khWjF3PBSncPoysf02WLHADYm
 mYnlVmsteWAZQZvk7zUk0PVWQh+e5HxRbVcf3OwW0dbUKpcl3wmUuI72rKKutiILsvUD
 WQ2rzS8FnjNNkZm37HMJjreayz7a+k2Zk7q5gRWuLgM9TWsz9wZkilHmdIAcUHhVTiV1
 W8tmLH91BPzuT3hOY2Y+PXgpwdFULTtB4u0JXMV6Nifaz1lOKLcgdM25PeBVCNDaMPLk
 7x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794252529; x=1794857329;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8tGMSUvKduX7ynteNROtgvRSX0JNrjkVrUtkwyrmeLA=;
 b=LHezhIP0dkGHxaytEZycGsS69sm45UHhFE/iysaFKtX3xWhYMCZSc8WMg/9wJzwUdI
 YLXrLVKj0Q1IHCMi+bhBc/AASakhvlDy/pLuv4aaB0nthIAPFCg2cvlnaYj8D5/s+RdT
 151rCDPFHW75T86IDKCSDfcy5cetIS4oDmfBFvgPg2J2WSKx9eNc9QoQnbC17XlReOck
 ZDUV7R2yvvwaQsoLx/F888wWaAHnNzf/JmfwnKa7+4JEliKKTdRCEXskOWN9oQQzogXv
 Mys+/B7kezFPhDalkTh0nv8spTBK/VzAeL9//uY/UwgEdy73wyzmV08AHGwPOQYmEzZo
 lkPQ==
X-Gm-Message-State: APuU4Z+qYWnzaNibCcacQVuPCdmofBEpWdlC8niow1W7+/jrRenxgy9i
 AMWoN7MU5xek1j7PegVGrILFGaLHzhaKDezAUD1WQBe+6QRXBvYxXJWevfgdeFAv3FsddGHBvSP
 T25eNySt7pdcejUJBojebUwXpwB5rUow=
X-Gm-Gg: AYBFou364xDf0v4HxdH36pFoGDVX+Tz4ZgPygxnlSXLsICpmake2G7picrmXb/JV1JO
 wnwc8SVaHLv1PaMTUmv5KfNsWwoOJBoVIuGR9QVGtksYaVkzj625fDTNiEzcOCbwD7+jOGrFFJc
 lIEq2lZlRvmnjEet6U7TGyk083ll22dYuedtrRaOz0GxYBw/z/EU+DJWKG08tDmsQ13+qvTumhZ
 zdSHXKja7HliegDuYwGEBfrL/QD2KZr5N258Zl9e7YU8wg58nd7MUwjyXYBGDAsJrhg1qNt5ETQ
 46KQCyWJ1CQwEGfryNVtTvHQ4qVvBYAN/rYZHe0fTx9dAW/GDFNpEevOo1fvp02mIhQhqe/ToAz
 Hgg5GhWGGNmwjtwl9qMuxuqk7D0VVBMiUNi1fkgHcy2qXYRdlH06VLDMYGrU=
X-Received: by 2002:a05:6808:124d:b0:53b:87e5:8c95 with SMTP id
 5614622812f47-5683cc86167mr420498b6e.37.1794252528800; Mon, 09 Nov 2026
 11:28:48 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:28:48 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <20261109182108.GS3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <5e2ceb08-8dbd-48e7-acf6-ec30f5ccef0c@gmail.com>
 <20261109182108.GS3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:28:48 -0800
X-Gm-Features: AclHuK-U8BXlwtL7q9YWsTonFwuaQkHTovuVZs9bXvvWGOyvoLHTj72Tde2eLcE
Message-ID: <CAJnxHshjw219nNuA5S6PuC1L=3Wmo+6MyFzcGjvbkjv_K99GRg@mail.gmail.com>
Subject: Re: [PATCH 06/11] video: sunxi: de2: Tell the display the frame
 buffer size
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Mon, 9 Nov 2026 at 18:21, Tom Rini <trini@konsulko.com> wrote:
> Here and elsewhere, fixes isn't appropriate for populating newly added
> fields.

OK, I will drop the Fixes: tags from 5/11 and 6/11 in v2 (7/11 has
none), and from 3/11 as said there. I would keep them on 8/11 to 11/11,
as those change only the driver itself, with no new field: the sunxi
DE1 and Tegra HDMI drivers check their own frame buffer limits, and the
Rockchip eDP and Tegra124 DP drivers limit the lane count to four. Does
that sound right to you?

I will wait a few days for comments on the rest of the series before
sending v2.

Thanks,
Ana
