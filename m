Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576D606A321
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JruVg/tL;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GrLjeZAP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8AF640DE4;
	Thu, 12 Nov 2026 20:13:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kTB6sXTM5A7K; Thu, 12 Nov 2026 20:13:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1122640DBF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794514439;
	b=NIg8xuRD8JP/IPOIXjENKmbMKjGssYneW1OnxkPDJ7JezW7RP9fV3zq2eC5lcG0V1YxF
	 r3w9K2cFb9dqS/duVWAag8VnLwqMd7mXVQdmvHyd0iA1zLmCl+pgmVGWNBbrq8fMTKS2l
	 X1Nng40xhbC/fzILKnUMhYVaMezKl9E6g0X1RcNKZZ//6FHRvuZz5ePWfkkm4rE9ixWrm
	 C6ejvHDxEusmgVZyNXIoMBgH3750Fno0Uv5uXNYB7AHqpLCZctweynY68xxUk+umGL77m
	 As3Bpsrn8h0W95Ufm5UfgVGKdnI+n0KcpKPpNEb6a340r9LlX8h4Hmkyyfd+6GuocsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794514439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1QpVqIGs8kJaJcgHxj6bz6dI15rKe2yFnvQV2CBzdWU=;
	b=hOmBUrIKHuwtAoeJfs9Jk5GCbl9HawolSVunruwPUlTZDDFjDreM1mcLliGSkLUx+Qud
	 TmWgVyd4aufpkrmyw9sq+XG76br6RgLxFSA/KXkMiBWI3iPacT4NyRHU8fX5sAEa4ij/Z
	 D1jSRvuYPDUu293X4CgRZvmVD0+jHKzrPG+F9ZjgPmTnwr0zJtuC7NIhbnCxLFMs1elGZ
	 jTMNkzyXT05WJ9hc0EAvo0bF9luOfNnCP/SeDkhuBd15YaO56gWk1V4DqzLs6cE/oNHtV
	 eTAF+XNs8dBeDWFqgWxCXPwBUI6AaMaz8fWl7YAJqdXmgIn9KOXfJh+hQd/le6ufxNA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794514439;
	bh=1QpVqIGs8kJaJcgHxj6bz6dI15rKe2yFnvQV2CBzdWU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JruVg/tLtzjuy9btL/QykhxDzFLLBLZSoNzEpc+9jUQ9EAM+YCvbFP21Ef4me9jUV
	 r6aCDESo6FuPXXwxyuHUAeHJhmv8LJmvQg8ePuK0f+SMEpXwfv4YS8/KnbkVDkcL6B
	 bTte3dTRjOvQsLtV9K6mz+41/7JN34OPtn2GuS34WY5NlpxxWWFnu1iB79+jtz3awY
	 pCQywsKvKa33FuMd3Nq4yDNXCUL50tXBNZcHImNPLE7jCHnNFQjNW4sAvnQqeKR+w1
	 qgc/KSoz+dNAG+aEUEgnU3t0DGrLuuWzBDbC5pR+6qjzllZ7c5awTFXsjPCL9sdIQw
	 nt8ugTgC6eZOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1122640DBF;
	Thu, 12 Nov 2026 20:13:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ACAA2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CA5B606B3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j_Y6oTRSAGMi for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 20:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 702BF606AA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GrLjeZAP
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 702BF606AA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:50 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-84a248254f4so127252a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794514430; x=1795119230;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QpVqIGs8kJaJcgHxj6bz6dI15rKe2yFnvQV2CBzdWU=;
 b=GrLjeZAPuP1PD76NBHrO60mfs4954mwaT3r46AxZ8Ua6vzqAnxE2fXd6HK2vro5nPD
 vkzxEmEA8wf66vQgWN466A6NpI7lJhjI1rgojXfSClUdBJuiOphPQ9PM5Cmc4EIIWAUI
 OTCVv+u+RafrB0iuLuJN0MMZF9I+mC/XawUiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794514430; x=1795119230;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1QpVqIGs8kJaJcgHxj6bz6dI15rKe2yFnvQV2CBzdWU=;
 b=WBfU4/2pCMe5tT9+/tm5kkYk8b/5ZCNuPFYhaz7FxDjPatXYxcx7EgZstZTMKMCuaM
 WxA0nVH0NR4crdiUtIqJh4G6rRk02TpuJPMXT9mMQZ6CCI3rLp4HF8fSBZH6Gpyfu8Up
 KXsW8R3IZ7rcifZFwsEdP5byYrca2vP7GTPreQpUAQA1bVWgeN7MeD1CROW6t9BOtGHA
 cUrRnPy8+0IsZBEQaC3N8R+DC3mIjpkf7uMnPV6HKnmI3WI9QD63GwXhyym/pytnNMyT
 SHJtaSWlmUuCMlhKGjMvpzAnsBZXrvQPXTVvBgP9whUuCtvb5UlLVMGxUimVCdfA3a6M
 LavQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFIvSCdNl2ppN0oUhiatmx9fJgpsnmdFJxcM/4Liz9v8WrxRPm3Q4Hu389L/Zyx9+FeHZLRJ8M=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9Mq6hNZTvGVv31CjSR0nR7UkbEnqQ6lrXUkZsO5AsazFsJB7yz
 LqRcsrR0mp6hhSzUbOVeqzumhnIthm9TSzChEwSOP1lK9grEdbNPeVib+tzIIEfon5Cw00P2XLs
 ldYxOxnbZ5BL+
X-Gm-Gg: AYBFou3y94QjxWAkjYIdKswG91kNRYbXQq6bQyLBaPd3ySa+8OVahUGZBcb8Dy1QcVQ
 TpcfYK5BDn0qq61anTsG19GvoROGilmSRVJZjAOzWVzuTDm7XS5Z22VgFQhRuhX0uSoywtqlG5+
 fN5OG8MHZ999v4f3IHGKESE+7cAtFjXxkFmbd3qJUgDoEqZYgLHIkiBDcTBENcFj+3jXlhG++h1
 fLar9wdiz2ZoGVc+5bBP03n/LjCVjXI81yvylf9REqslFtN/VweUtsncKDNAm6AQcz2TnC0e0+O
 5Bh0Kes8j/drm3iyKyKU3NeCKHTwZTGc5RVL9e+K5jbVaHdFjA1ArGEvhqC8bU0WcpgBsxT3Ufw
 fhqYoVot7mxibExS7tb2iZ79HRY0RWehR32rqcV62DLwqAh3/hF6jNxC+wij45bJc+czNJpnITs
 8m/rvt2PkhUC64r7WGzPyEb1kWGVnDbmhWSmDSY7ShX8jNtWixRF7UIPBrEnNv9UMPm/vjgtz33
 9fX0nL5eLpnf7327Q4AFbaBpNwtVaYmWxFv6O6sQP1/QYctEDyHixHrIpdqvn5Ozg/Q3xiEp5Qh
 wUfK7PUzfBomqJv/LRfmvdt77IeB2TOOSRKW0TMfBI/EQzSLvqBd1Oz39hB9Qfq/rto6xTcYY+V
 HH49wCD1hke6hVlBMVHrazqxSrz1nJom0ZUlApH5Pb5Ttq+vUvxc62FXlotYiFNvtg57bWKrXZl
 eipcQlxv7qES1FsBQv9NER4rDVkCuKvtRakx1c/KamT4p72hnl+mc=
X-Received: by 2002:a05:6830:310d:b0:862:8585:6f44 with SMTP id
 46e09a7af769-86289903295mr284630a34.26.1794514429901; 
 Thu, 12 Nov 2026 12:13:49 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a4e4csm613222a34.8.2026.11.12.12.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:13:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Vignesh R <vigneshr@ti.com>, Yuho Choi <oss.patchbox@gmail.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261102032950.305343-1-oss.patchbox@gmail.com>
References: <20261102032950.305343-1-oss.patchbox@gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Don't let clean_bar() overwrite
 read/write errors
Message-Id: <179451442928.966571.10699188460177025853.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 14:13:49 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 01 Nov 2026 22:29:45 -0500, Yuho Choi wrote:

> With SPI_FLASH_BAR enabled, spi_nor_read() and spi_nor_write() call
> clean_bar() at their common exit label and assign its return value to
> ret. This is also done on the error paths, so an error from
> nor->read(), nor->write() or spi_nor_wait_till_ready() is replaced by
> the result of clean_bar(), which is 0 when the bank register is already
> 0 or was reset successfully. The caller then gets 0 back for a read or
> write that did not complete.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] mtd: spi-nor: Don't let clean_bar() overwrite read/write errors
      commit: a38a1d2736eed7978df10f513a5f6df4075b2277
-- 
Tom


