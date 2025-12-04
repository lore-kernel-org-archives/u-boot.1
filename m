Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD03D2CDE4
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7DF840F1;
	Fri,  5 Dec 2025 00:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PQWckOz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3745B841BE; Fri,  5 Dec 2025 00:10:42 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EC284172
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c75fd8067fso1064929a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889838; x=1765494638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kv0gNq4QrSLxqJE6Mwx3JixBqpaHh0uLisOPIv6nJCk=;
 b=PQWckOz99xOGUnS/UK4saGyG6Lu4JIySgWq7CSED2RcCCmLRncTZB/so2JVrYbNITk
 shzF16pjBdRYW2G6S0t5FAzRL6yidsjnBnkMjwu1Br5sUjr+iVcLl2T+7EM9IBblSZ/P
 ZMD3ZEMh5Ni7wStaWGPxG0eC1bMrMvf3NCJ6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889838; x=1765494638;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kv0gNq4QrSLxqJE6Mwx3JixBqpaHh0uLisOPIv6nJCk=;
 b=C6ryxVb4gdWR04VPBFV0au+I/4dxGe+qIx50zVCm+qR0p0hlqn6XoAo48EGP+K3iwc
 SL0hh29Qt85JRN1HGOnsoYvL7MHijJ8PRMqawpMHaZt+4Sq86X46kgOsPAykfTvE4Xt/
 2f7cbMr/RsnTbgSTpubWaaSFWLVTXH55wuwzJUiNo4b5q2vluwdFOdvdeYK/ruWAUJid
 jFuFH+EWjdsSkYcanHDqpQkcxtxmxCFnqjQBn2p6MlOJndrnPs0s0YP/re8AoF/KgrL3
 CQq0I69z+ctkD/VA4+LR0VaxFklpz1i+n28zFdxoqgOmABeIzvbSp8jVNbx0buXSHocm
 Ozxw==
X-Gm-Message-State: AOJu0Ywt3Ibjq8CXhvXdeOvAuQ6pg2j2KeJd+mSKRInfSMaCACiiQuyy
 N77Rzphzfza52aqVr6b6F7snMJrUROtBCuVlGVVL7NFno/iGRfJOCyPa/uj2eqjypzRc8VgfwXc
 vVqQTIcU=
X-Gm-Gg: ASbGncumCgkrlzFmjg1EkqL/AZd2e5oT1585mn2xQOmnNDrY79ycnxkE/l2BjIpNSnl
 /IB5dA2b86UaEdTx7M9Kfw3Vq6sogfcUxBU9al2japUfYmXna3XNCJHIMwD8uBzhePhS9nv3BlI
 dgy+YsOz9vB3PRk1BGlIhlhpPR2UtPtm1Sk6IhXFKTZ8ohnvebA1xjKHIAAkyONtp3o+Z5Q2GJE
 9TuKgaF6dIbLnj3NI1mk1BCqmCOby7E6dzMIFNGKStt+JJVw+KuAssbE0ebzxDMyE3NKbgfSxYX
 /1CKPLmKRdDg2dU6w9PmGBiYTVkPVBfndtPNLnsemuXDS2xIRtlb1ZauflHgMnfdT06lJ2UmJui
 vr/LeJWd1WjuxKABEbd4vimDm9f9t1VPE2QT7F6RqiqBJ080fW1mbqdSJpeMbnhguoSmF65joS+
 n/g1uQkU7YYD6eh/nsOXTdAQu8ouE2t2r5IMkxgxsR9VnyQG3f
X-Google-Smtp-Source: AGHT+IH2ECsjutl8EUmCcxQr1Td+15aUWCuZVokvnBMLuANEWIF5eCvkqZAh4bBUpceabCbuTrBnnA==
X-Received: by 2002:a05:6830:2690:b0:7bc:6cc3:a624 with SMTP id
 46e09a7af769-7c958c62c44mr3005077a34.32.1764889838240; 
 Thu, 04 Dec 2025 15:10:38 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>
In-Reply-To: <20251119145533.843361-1-trini@konsulko.com>
References: <20251119145533.843361-1-trini@konsulko.com>
Subject: Re: [PATCH] pcm052: Stop disabling device tree relocation
Message-Id: <176488983739.2091996.12112038745590083637.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:37 -0600
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

On Wed, 19 Nov 2025 08:55:33 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pcm052: Stop disabling device tree relocation
      commit: a1e6508e491c8cdc97f1a76cf479098bbf0d644d
-- 
Tom


