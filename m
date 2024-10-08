Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA8BCEF174
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAF688EB6;
	Tue,  8 Oct 2024 15:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lhrls0HA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAC288E90; Tue,  8 Oct 2024 15:44:30 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AA888CC8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9b3cd75e5so569492585a.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728395067; x=1728999867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bplWfCPeqQ2e+n4qDpoCw4tHKcLxBXX3zSixkCV7BO8=;
 b=Lhrls0HAnb4mMWvwfTbxHHCr8/Xj5HyNjOMX+O2YSFoupnuX1JOiRpslcHXgw65qHQ
 Eeh3uuc9YXsjGt4zb59XM25cUzOXtng+eIRX9pisFyZQIlY2XnhEWqsnoQC8+NA6Ne0t
 BJJDryK8miC6a8Bh1HzFAQPYi668LJ3YPY3OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395067; x=1728999867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bplWfCPeqQ2e+n4qDpoCw4tHKcLxBXX3zSixkCV7BO8=;
 b=QpVgUqOiPwe/mijm5PcyVQODgvDbImiUQuogCRH+sZfYspi9iYj99kNnvx5I7myhhn
 jSv8FrnCzgsJmlyX66SpudCYC21Y+wXVNVfs8m5R5pA4ywaCKMUuCIT/92ScA+x4cEws
 H7zXYPapiE5llwRNrTVzaEujPoG8CbGAf7limiK5VVoSfQR5M8GV9eW6gaw9bcxZnzAv
 ULWU9lBBELeIiMRzb8C/DYHi7o0N8aNQhz2/9tPKUhTi5j9dd0vBG6BKMeI/DNI+r67i
 1ng5nwNObJTS03VxZXzbWMtOkypVfmdqi25enWKI2ezkyh+/Qcm3/vTHjM+ZjOMOvULm
 6hVQ==
X-Gm-Message-State: AOJu0YxlOwZtk2AUCFWsLuRKwR7V4I7n4uXZyGOnzkXrsmTADC+8Cjqb
 KsevfGiFoRqp44982h6ojnfMXBfzvq2UCT7yiFNIVkjbQvGu+Y6oSmfBPv9szTwmnlOu9+EaU7v
 NUy8=
X-Google-Smtp-Source: AGHT+IGq6bw+XhCJ01roRVMKHB63eVDdmvFQzpiXPxlkVJfyZa5+13m0BaCwwbhn9e/ek8gZj3pNlg==
X-Received: by 2002:a05:620a:4452:b0:7a9:bd68:462e with SMTP id
 af79cd13be357-7ae6f4412b4mr2056411085a.20.1728395067489; 
 Tue, 08 Oct 2024 06:44:27 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cbf9sm354028685a.41.2024.10.08.06.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:44:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
Cc: upstream@lists.phytec.de, vigneshr@ti.com
In-Reply-To: <20240816132328.928651-1-w.egorov@phytec.de>
References: <20240816132328.928651-1-w.egorov@phytec.de>
Subject: Re: [PATCH] configs: am64x*_r5_defconfig: Drop BOOTCOMMAND
Message-Id: <172839506662.112860.4995173060129577550.b4-ty@konsulko.com>
Date: Tue, 08 Oct 2024 07:44:26 -0600
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

On Fri, 16 Aug 2024 15:23:28 +0200, Wadim Egorov wrote:

> There is no need to define a default for bootcmd in R5 u-boot because
> the R5 is directly booting into the next stage A53 bootloader.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


