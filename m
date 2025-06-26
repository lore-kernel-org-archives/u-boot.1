Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B2FC7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 17:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227D282977;
	Thu, 26 Jun 2025 19:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mLvViwVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1D482E35; Thu, 26 Jun 2025 19:56:52 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DE8680E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 19:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735a6faec9eso605895a34.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750960606; x=1751565406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbHaJPMXL0foR++wK6Opm5JJW/vDemASy3XFOA4Ql48=;
 b=mLvViwVTjDKjge0+tqa3qABbG5J5SirrIxfvf02025u+PU5f5S77PYpyILrGWTNCLu
 hQA2FWHvurVbrBmcejWyn2julp8py9DUfP5BDTTGnMvPfEFaH2aEm74dRXcgno6rNKys
 b5waf4m47U+0Xm24N6OybBsbNMiujEpi+9kNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750960606; x=1751565406;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbHaJPMXL0foR++wK6Opm5JJW/vDemASy3XFOA4Ql48=;
 b=qliANqdZL2o5KzB8gfyGfNsbL9JA2hnv1NXPC88y51N2grjGloaYBCPLqvpnt1enBJ
 2thf2y0DWomvwPb/SsBTTO2meClap9ybkJ+FN8BNQLqZ0zwB0yf6mn5NWWTcUWWK7wgv
 yB1z6wedg0VCBb+k9ufWvjfdTT0iJJuK0KuDqfKYdqGnnQE+0rarp03vUjsJEMBDwaM+
 HdPt4r7c9q8r0Uv4zFn/mIKh1zqX1oTlAZqZvtU1tlcs4xj1/ZvOWNud7s5vrEqq6DQV
 Ard8wYhVkTYxsFXOVbiS28PQePXSaY0C+lWNeArfHzjUxVsOxWH4hvkFWmiVQs5tlKS6
 XvkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBgXPVs6XTj9MCGG5TajY5QgN/jKqNA4Egnv+wdhugfOogY84ApIPK8nBYIzDrBiol3Iw96YM=@lists.denx.de
X-Gm-Message-State: AOJu0YyUMQ2tSxqK8tBCdfJnr4qbVBEhtxH17XO8GCTdB2GcNKSzD0r/
 NgEpOdNP+xpVYlF8z4jD6DK+HzHvPIeIsa+fUulM+jvH7xN7L8RaPNQc58fkwqvOTb8=
X-Gm-Gg: ASbGncuvM+JuVXZqoresWc77f0al43d4GYaeRA3aH0FFMx4vetvXhI74v5ZHfSrb0hM
 7nn9Tmq+nsN+vW8SgEHIhtJOma479X/rqlexCZdx3e5rP2cgvGARNbvKWtj2NddB1umpNE+pN95
 xxKRFaCUpSx9VuGuPizE4b1alanJr5hihqb2XBYXevm84cxMM1RStmtv9FbQCP3+wENtj9Ifz/M
 pro74Vb/9JCF1TMoH1DdfaxBCeFHtgJrrecvXLhrIO9Vc/iXaffsyF3XcbMgC+9Tg3Ai64P/VXl
 E/UFrGCQysVbCNLAp1s7Dl337dsA4a/7tk51dFVTPrS9jD4EOGwrGsgjaJWRUnm1Tbsct6xYgOh
 ZJWB5+MKU4qZ6CIJ6UYPV6S6yP7/ju3ji
X-Google-Smtp-Source: AGHT+IFlwgeSLT03yostUgEhlPHolayXx8tYWVGiDRPv+eIUCftdcqI4fsD0XL/rUuH5R3ZHjnkD3A==
X-Received: by 2002:a05:6830:628b:b0:73a:8ac5:a6d5 with SMTP id
 46e09a7af769-73afc56f20cmr43904a34.17.1750960605745; 
 Thu, 26 Jun 2025 10:56:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb008936sm63877a34.24.2025.06.26.10.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 10:56:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
Subject: Re: [PATCH v3 0/6] Fix handling of optional blobs in binman
Message-Id: <175096060477.1879961.6525302263431603846.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 11:56:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 13 Jun 2025 14:02:39 +0200, Yannic Moog wrote:

> This series solves a contradiction regarding ext blobs packaged in
> binman. When they are marked as optional, by default they are faked, two
> messages are emitted. One says the image is not functional the other
> says the image is still functional. Both concern the same binman
> entry/blob.
> 
> Binman is set up to have fake external blobs in case they are missing.
> This is regardless on whether they are optional or not.
> The implementation does not allow different types of entries to override
> the faking decision; at least there wouldn't be much sense in doing so.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] binman: drop "faked" return value from check_fake_fname
      commit: a657d87f08789c4c50423897bd5ee052c6223ee6
[2/6] binman: mark optional missing blobs as absent
      commit: 3ae668b9d2101d111d257ee7d8912c19cfb0e102
[3/6] binman: rework dropping absent entries from packaged image
      commit: 21bc3433a43d3add3430543c9eee2a95d4dee2f6
[4/6] binman: add faked optional entry case in CheckForProblems
      commit: f5817e05efd39dd455c2e6a0f0622d709fe7ea2d
[5/6] binman: ftest: pass allow_fake_blob to _DoReadFileDtb
      commit: e749d64b4622806072c56a839cf9a36a5081b575
[6/6] binman: test: assert optional blobs don't cause non-functionality
      commit: 0dbb0a8d1f2aefb2a7fdd8e627edd955e4fe8d3a
-- 
Tom


