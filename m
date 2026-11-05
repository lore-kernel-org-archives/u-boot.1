Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C3606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gMSqcaPs;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LqGF8qBT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 216E4408C3;
	Thu,  5 Nov 2026 19:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4JbmLuqmHId; Thu,  5 Nov 2026 19:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 51B84408F2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793905409;
	b=sNzFSIOPYZrtyb6rRIOW/Eb3zGVgjAd8wXPshKTq5Gp/4YLbSgU8ckJ0XjlhrtKT1CdX
	 GJI9DVVog17ZAh+sfPTvMJfQuFf7VZsWlHoklrN3btT8nAAo0JtXA2WKmWkGzKJgOSJC0
	 lnX8puBJ4rtaKR0WqPzDtiyAcPiKurht6Mxc8yiIcx2AA1tux1g9m5Bl+8viKwEAS0mLF
	 mL6JrmfKrHmECW5ZmPYdzrAAqfDcP6Hr3Q2SBR3+9W1u4s3AmhdkTU4tQgww54rOvkiXd
	 3hkX0gAD+zPI2iQv4YxoHMAoDQONHI4cQl+r5qaAspKI8j576BBsNPLvowZST6nYLkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793905409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zJMqI6pDYJdbZLP/EYEXO8g1mgUvVomErZvZU3TvuzA=;
	b=gCjktbeY11/wShxvhYMxQonnrXvfMnfHbm8/fMfYcr/m1AVoeDG9TPG9PJKTibplT0hs
	 RLDPwJYvWjTe30FYhDW3r3yx75G2iw6YBpJnJ7+FGirT+33Dwm4fgJldJc3+PFXEGiQWj
	 9K0PV2ElkN16X50m/lfoHGl0zYOCx4xIRqFUPbz+Ef95+L0dH/FGQFaiB6avUUddjowoT
	 ndrWu+aL74wCVFrGMkPIgGL8uK1pxoB/idhhT6U5a4gZtDxGx6OXJ8/BCYOh8Nvq89GL2
	 y7nHO/p+MbWowNc8J+g9+JRINczy6INA7CJ3M2o6BNhWgKDtfLsa8EH9o7+ZMmy2HpA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LqGF8qBT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793905409;
	bh=zJMqI6pDYJdbZLP/EYEXO8g1mgUvVomErZvZU3TvuzA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMSqcaPs/ZPGm/b/pro3CLkFg5TGHIwmy3TynS6E1k2teZE8E7EpMxADIZRF//uGy
	 RAaTU7VPBBjuuCqqzT3QtM5gTiRVKJvPs87+DpAKh36tlVFExRYNZ64TXNGUgEUqol
	 hvd3KUp0huxsONwqE3cepGM8EL4NOVLbD/2KzVnxFu3v7xnNtJYhdn/Uql8+McMpb3
	 7bMgXLOTsHQyfmVIvCpZCdYfkJ55zXFjWBrmEIPD+gOzfAlikVX41QBO3RJHCODedD
	 OhUDn2/1F3UHZdiMTaiev4mYoa1HDxrRe17Ww7NKn0J/JVpH9m3pk426mmiTiALB8j
	 eXRsV1sUDuPwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51B84408F2;
	Thu,  5 Nov 2026 19:03:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E676931F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0F26408CB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5FKcmCtUCYh for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08BA6408BE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LqGF8qBT
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08BA6408BE
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:03:24 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6aa9606ddadso1517805eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793905403; x=1794510203;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zJMqI6pDYJdbZLP/EYEXO8g1mgUvVomErZvZU3TvuzA=;
 b=LqGF8qBTLLzN8PFVE6uoaZos2w3Fdrx3fnTJ7lM4LZSDictqoxejf4P6F7S/7++2xm
 tlXus6FyiGhQm3fwh5GT4KKn49F8ehSvmUr/uFT7q8FNMoxyFLoUBzTN7WKSC8M5YDBP
 UKNIzlPAjyKx5HHtZKaB73PTRDEHQ9+W9WFn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905403; x=1794510203;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zJMqI6pDYJdbZLP/EYEXO8g1mgUvVomErZvZU3TvuzA=;
 b=oweCITLLjTz7sDFLt8cny64uxLR5FFTKj2BKyd2abVrC0o3TmLd9GnJrrxAufh1tjw
 3PoahLdxvneLgpZ9TkY9EZqcTHSz1oGVpbtQXRYiLo1f0gm3ZB1Nuz0KZv6rA8mLEhZw
 cGnWOi+PuYDz6QlXxMMqdJ5yq74WBNz1UW7ZOXcaq/07VRKMGCbqFXvz/Wd1qSaUhRRW
 +WhJRHANh3nJeuGMCrpj0iraBDSWuqMK9F9MDpH9E2jUv/b0YE/zwVjcU4F63IsYO/dk
 BN0n0W7jL42RZ0Gvig7ZisY1riZhkTx47SHhpkfNR0fSnv6oLGfOfJXSmMJQIjDMSGIL
 BPTQ==
X-Gm-Message-State: APuU4Z/QUlx553fvTJTHqjSi6kHaxxV5skZuchi+vJlc1pSPYSiad+7j
 ORv1bicTdWmT98YQI/PN6722cjvGsEDoVkzAL5eUCaVKgO45Ucz8q+15se+5RHjCXfH0by19LAL
 /qCKFXWZmDHWM
X-Gm-Gg: AYBFou26vzMJ5nojxS0v+Kr2a2okPpmnJI3HSC7RW5N5I/eI+MRCVmOZafGgXS97faJ
 KQu5zFei2bQieljqrBUG7D9QjliHIdwI6HOk4e3Vlj3WmzUpz5NzwT76PqwOp4ZpgKhqDEbHp36
 HyaQNJo26gN+DAFpd2/s3Dv64ztByFEmo/XCDnJBI3qtKAORzjPesB1h+F0Mkf6T5DKGIObP78h
 JLJI3q9srPRiDONMosUG9JPQqpFemKckgmwlSTroUG1EG+8K/7y1Ze3SFFb9N5X2gwPiYS7CHLh
 bCZCZM6ph06yLXQdZZG+NdKmxlnWXBcpHUaYgIXvJoqrFuJd/dsl64OJMJsBJr6bUklGZGpcnH/
 eOdAXqqebuX3XUo2dCChV89hGzBw9j7Zvz7ZOe0A3rSflsp526P4v6XrMC3YA6WkyJXTu3hz+QD
 Q7ZDI/yS4/NQU5f306NCewimNR4zsE9S8vTAnFXKZGeXA/v+KK5xDUrm8tPH4piI5ktS17adfO8
 HkZEnO5zeoa/VkwvGmZRqD2sOd3OJNd5myMLshIdPiyNrqlp/l3eHUq3IbirMNeGju8r3cvmAtJ
 meNlSHiAbMe8osb47WAsEkzAOMuP+FQN3yVl+y5TC0hqMeERqWYJTfyDf0VT0Qq9Yo4YOodxnAe
 vEv53YTA5Os/U8PdtWiPGVUbNfTthNNGVAcHG3AzUICoEqu7R0Lcq6u/vOAg7PwGZV0UF28g8Lb
 Sby5TCQQ0uddFA75PRifepidt8NxcGQQ==
X-Received: by 2002:a05:6820:2205:b0:6f8:2e98:cfcb with SMTP id
 006d021491bc7-716e79ad986mr363672eaf.48.1793905403061; 
 Thu, 05 Nov 2026 11:03:23 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f1dd2bbb3sm93385a34.18.2026.11.05.11.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:03:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 =?utf-8?q?Enrique_Hern=C3=A1ndez_Bello?= <ehbello@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20261028021415.2439865-1-ehbello@gmail.com>
References: <20261028021415.2439865-1-ehbello@gmail.com>
Subject: Re: [PATCH] tools: mkimage: copy the FIT in process instead of
 shelling out to cp
Message-Id: <179390540245.1843724.11576108562850442989.b4-ty@konsulko.com>
Date: Thu, 05 Nov 2026 13:03:22 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 28 Oct 2026 02:14:15 +0000, Enrique Hernández Bello wrote:

> Rebuilding an existing FIT (-F) starts by making a working copy of it,
> and mkimage asks a shell to do that:
> 
> 	snprintf(cmd, sizeof(cmd), "cp \"%s\" \"%s\"",
> 		 params->imagefile, tmpfile);
> 
> so signing a FIT needs /bin/sh and cp on top of mkimage itself. That
> rules the tool out of the minimal images where firmware tends to be
> assembled; in one of them the failure reads
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] tools: mkimage: copy the FIT in process instead of shelling out to cp
      commit: 58eb0801bca518d6aa81a7b49b063aacc6e98bb2
-- 
Tom


