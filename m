Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E950BEE01EB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC25890A1;
	Wed, 11 Sep 2024 00:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sssCBoue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932458913B; Wed, 11 Sep 2024 00:38:42 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9E9890FA
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4583083d019so16953371cf.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726007919; x=1726612719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHDeLnU0wkPU0GF0w0Bx2YLp8IrlEdzUX1qMYXMDL4A=;
 b=sssCBouegFnxLGUx75o4phG4aXiYHNWGE6DvEY8b3UDJq/oqP5EliJonHbvaPmxKSH
 LL6kq0NS0iqerAmXqxuI7hrSsiFbCrV4t6ygXGS15mkNwcrEm8kH2ynFCcnFZ+tpziGm
 Rv1BFnhprQHQlN9l+PEw2M0ej5UR0RAoUa8Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726007919; x=1726612719;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gHDeLnU0wkPU0GF0w0Bx2YLp8IrlEdzUX1qMYXMDL4A=;
 b=P7x18CUEEyRIVtpelOgR4R74T7ZLcGK/nBbNIRmLvVROefB2rs3fwdhjXNg7lzQmfE
 ic6ghxEpF2+Gk8QBy5njztpqE61Lbyv8EE3Br+g5US7kdpynhXGxL14IXpbyYgliLwz8
 MRCFzQElDzvia5LnJFvxYlSvw5A1GmsYJ7RgISqHahiD/Dk/7Ruh7W8hmjMb9oXXvyoP
 z8GRelx5hMzazj4yWS+iIs/fd8V1QujCxSiV1sV1QWpCggu1rSNnIlkNZlG6TLKb6Odu
 TZBOEt1+dFwlPu3YGvjWrH/aGOToXzEQ6d5e8O2nFn3MWi26OrKkrVDd19ulI4wJ6uFc
 Y8LQ==
X-Gm-Message-State: AOJu0YyK8z9F2CPFvSNX9qT5yHLAy+/bhxwMcfZE/cHYgP2JCsTxhOLA
 P6qy4bliQhjUhDtvLMeaCDWOtYE6PEXd7As4gST5TdzXgkV9ZhanZIEd2yrzDmg=
X-Google-Smtp-Source: AGHT+IHrIMN/dcprWcdnLo+Zz7AEpDW8D51hSZ9wYWPbddwDIjxunAO60D5KzooyiYDdHU8hQSeWeg==
X-Received: by 2002:a05:622a:1a1f:b0:458:4b53:e0c6 with SMTP id
 d75a77b69052e-4584b63278emr45792361cf.25.1726007919246; 
 Tue, 10 Sep 2024 15:38:39 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63873sm34009611cf.7.2024.09.10.15.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:38:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Harald Kipp <harald.kipp@egnite.de>, 
 Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240907222013.10298-1-trini@konsulko.com>
References: <20240907222013.10298-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: Remove ethernut5 board
Message-Id: <172600791807.367866.7649687340785060397.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 16:38:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 07 Sep 2024 16:20:13 -0600, Tom Rini wrote:

> As per the maintainers at egnite GmbH, they are no longer interested in
> supporting this board. Go and remove the platform here. Furthermore,
> this is the only AT91SAM9XE platform in-tree so remove supporting code
> for that as well.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


