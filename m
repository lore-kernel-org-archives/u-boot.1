Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25589C531C9
	for <u-boot@archiver.kernel.org>; Sun, 26 Jul 2026 18:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE03640613;
	Sun, 26 Jul 2026 18:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fg6ZSDbbFd5h; Sun, 26 Jul 2026 18:57:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9F9340607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785092266;
	bh=r/VCPURdvbKrOCpm5mSqiiPl5sflKUistqVZyaxrMyk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tj2QeScUFYX/2oVX7undLnGdu+kfF/68lyV8W5ewztsWij10JiG5cKAKZbnwpmWnY
	 kzehe+eU6m+jWkJdlpqcL15jEHQvg8E5UBZBa93aImdKhyJiRJCQOCk73dnd6V7HCU
	 Nz1B4IiyF9bXL0Zd/9OQV83LLbsDYI1oYIfEm0pWwXDH7UjpRMs4ILC7DpvH4D2xgk
	 JRY02r7RQdkFdPeLGd2sUP0WFQjHoId2w1mTfNzqw6dP7Alhb+SctJEzL8LfAqMn1S
	 qTNOzXC6rsJaSo0ZO0Z0bCLQZH4bNRMfcjf8pTr+5Lq4RJ6rBdiN2MX5ej3ieGmPlw
	 yczS213YMvyCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9F9340607;
	Sun, 26 Jul 2026 18:57:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A10E04C4
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 18:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E63F80CBD
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 18:57:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuErBar_z96F for <u-boot@lists.u-boot-project.org>;
 Sun, 26 Jul 2026 18:57:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E024980CBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E024980CBC
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E024980CBC
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 18:57:42 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6ab08d289d1so428344eaf.3
 for <u-boot@lists.u-boot-project.org>; Sun, 26 Jul 2026 11:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785092262; x=1785697062;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r/VCPURdvbKrOCpm5mSqiiPl5sflKUistqVZyaxrMyk=;
 b=mvGhoUd1/IQBCojChYh6N/gkws6T0ORmIa2FzvMOo38mO6iWZ1mCqIkMECq8JvzOME
 qYolAvc45XbcGPGohuGcvKwPMYYhoO7R5OF52kwEZZf0vjzTiBGNDGmhuldQ/n4X2aDm
 20KHi3dW1RYuLySHzv8iPJg6tBrEJ7D4Y3ZChqG6lOzUK4RT6hGOs5TKsKv/WQSiKV3v
 /267v+FqCGLs0znqMl0mB85+6a90ntwSP9xx8aUnwevWxkEFcQD6Lo3K8o0ngX21fLPv
 0TObWSjxs7S5f9fruIZd+/kk8RWV8J0lALMm8NqSxzBNt98zMHHLYbG62DSHFiOt115t
 /FCQ==
X-Gm-Message-State: AOJu0Yz7hYmqHT8V57KtgAotMnSAbONFzwrM2jfur1ijByFyf95avSfi
 msNbvZJyHVUrQ+CRa7ZnBgIPsYpauixHc66bxZFa7WfylTtK2aUc/Hr46cYtB7630Dc=
X-Gm-Gg: AR+sD11zG3hko01Nvk4r/qpOtOF+lDVIh3kTD4W2zvQvgi/GQigPkI4YwDaNPmcYkss
 Like35Os1v4TZ+c3qNxwg94wD7+rkxPZMDCXLvi3M5Ew4BvKW1HFDnVLB0SVdew11rzvfU2XgjG
 qNL9yudLeviXn7dqqOasPmJ2Cn5YDTGakKmrhyL8jBJ8EQq4XsfgANg8G3ujsrZTgR1GEXdjvQr
 1fFj4ourc/juqGRuJ34S6z6sKC8QR01EiciuXfncWQoZdILs5PNVctdWtTmPBH1QB9xdKgQeN/+
 qziDmarOF4SDy87g1cH+8GKUIVESaTX5IWCFK1t6DbQVi24878f6BI9cNpcbCqcrcAwR6KgvfWz
 dnn2xXJNHoypgpWYUkT5k48wSx+HZ0MkYZSDoGB5qvWZE6aZ86KE8su9AweqdrVcI6AtlQr4U0F
 IZq0JcTIBQ8xexYoILJErIkJK3y8ZDYkUY0FMa2Cozk0wSC3SLnuwLRrK19FVa1wa1CMKzrgfuR
 dGmPPiIh30wfZHdORbYFM5DMA==
X-Received: by 2002:a05:6820:178b:b0:6a3:7895:7f30 with SMTP id
 006d021491bc7-6aaff88cfe2mr4819000eaf.29.1785092261624; 
 Sun, 26 Jul 2026 11:57:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4579d805c95sm10603029fac.0.2026.07.26.11.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 11:57:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Allan ELKAIM <allan.elkaim@gmail.com>
Cc: Joao Marcos Costa <jmcosta944@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>
In-Reply-To: <20260713142420.2618339-1-allan.elkaim@gmail.com>
References: <20260713142420.2618339-1-allan.elkaim@gmail.com>
Subject: Re: [PATCH v3 0/3] fs/squashfs: fix symlink load failure on large
 images
Message-Id: <178509226080.3930745.987116401697810720.b4-ty@konsulko.com>
Date: Sun, 26 Jul 2026 12:57:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785092262; x=1785697062;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r/VCPURdvbKrOCpm5mSqiiPl5sflKUistqVZyaxrMyk=;
 b=b2thP4rywF/C7C+DMxAai9TapHVEbz7NFPj1soS3tvzgrsLDFbRijqR5dOitCzQZRT
 n0q2H2Z0Fim+D+j1j+FYjVRgr7JLf4oPxCTD9XQLb/Kls3p7LxM8gDoQORofV6YR0+ku
 qBjodBjaPEhISsr1l9wiKvllM1nk1ejMpWP04=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=b2thP4ry
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

On Mon, 13 Jul 2026 16:22:41 +0200, Allan ELKAIM wrote:

> sqfsload fails to load a file through a symlink when the squashfs
> image contains a large number of inodes (e.g. a rootfs that includes
> the tzdata timezone database).
> 
> Root cause: sqfs_read_nest() resolves the symlink by calling itself
> recursively without first freeing the parent directory's inode and
> directory table buffers. This causes a temporary double allocation
> that can exhaust the U-Boot heap. When malloc() subsequently fails
> inside sqfs_read_directory_table(), the error goes undetected and
> sqfs_search_dir() is called with a NULL pos_list pointer, leading to:
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] fs/squashfs: fix heap exhaustion during symlink resolution
      commit: 9a9d46cb5e1a8f600c52f3ddaeaca8d4f28f66ee
[2/3] fs/squashfs: add sqfs_dir_offset() error checks
      commit: 57e0bb7bf00dadd7537f93609afb955108ce22c7
[3/3] fs/squashfs: fix dirs->entry leaks on sqfs_search_dir() error paths
      commit: 171b604888537dd7112ffddaa13abb16932eabd0
-- 
Tom


