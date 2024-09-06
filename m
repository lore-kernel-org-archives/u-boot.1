Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289A0E6FE2F
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 16:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7134888CD8;
	Fri,  6 Sep 2024 18:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m0Q8dThE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12DD88D0C; Fri,  6 Sep 2024 18:34:16 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60C2B88CD1
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 18:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7a99e8ad977so36051285a.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725640453; x=1726245253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjVHQkLKCuKNDjyLheR+sW9hQmlu3n7YbvCiTjNOyGk=;
 b=m0Q8dThEJuk2jbpdApsOQil0i+0G+xjK5rpaofZkfzPepIwN47/NdjyNbm/90JPS6R
 MncnO4cBjkwABO79qsa1FiVI9AkIOFss7rYnXb8Gwid/Ge6F32BA6+d7hnU8i4saJfQL
 1a8XVkjwoStNmxqtqDBtiVYApyr2MhmFwEUfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725640453; x=1726245253;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjVHQkLKCuKNDjyLheR+sW9hQmlu3n7YbvCiTjNOyGk=;
 b=DBFNngAk6czi5nRcyxCzLv1qn2TVSGpI7uvmxaicNG8qswQbrQ+AKwdZhTKRUo1z3B
 B/Ab29G+Sv88KG5hE+sFEyo3XNH6rqixQ7chZdFDR7jADl5RkdZ5JXgfLNpucYJ9u6jB
 RWPvOOQhbZcfVDgFWOub7HeW4E1V5FNZaJtF7LHZDqZBk8/Kc08CoE/x0FL/DlEWabsM
 RGuadXK+hur/KvdM9F239TmjKIs02SvOJneHTZCTm6OdugHJIHP4LXBGMxk0D/cBeDe2
 YwRCQqW8mWO6FNpZjjOSNvSelnqxGvESUCucz/FmxZvWJycNR2aZflP5Y4erhrJd7hRF
 QJBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUytOHM3d6NUMzQY5oIL/SSBgXdWcZTvw1G+ri51nvS24WyE/dfIVFLpTASq5BcZXuhBopQegM=@lists.denx.de
X-Gm-Message-State: AOJu0YzHzvRMdUxMhV/ttaqCMqWGEVCgD/XRGN612pfbEeQt9ndNC5Y0
 oq5PoLQvbcVQzLSCoI0IjyimpRJk92ToXNfQXnRPE5tilRxTvs8DRn4VsS0uAQ0=
X-Google-Smtp-Source: AGHT+IEN0oDvDGcucILPCc0WSQTSv+EDJ6O3i/Ekam9dCKCZ9Y9982b3Wf26xGMcJDp5XFrH0cYWiA==
X-Received: by 2002:a05:6214:3902:b0:6c3:7026:203 with SMTP id
 6a1803df08f44-6c370260427mr154396256d6.11.1725640453202; 
 Fri, 06 Sep 2024 09:34:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5204181b7sm17851046d6.112.2024.09.06.09.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 09:34:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: jh80.chung@samsung.com, sjg@chromium.org, Keerthy <j-keerthy@ti.com>
Cc: n-francis@ti.com, u-kumar1@ti.com, praneeth@ti.com, u-boot@lists.denx.de
In-Reply-To: <20240531055041.32636-1-j-keerthy@ti.com>
References: <20240531055041.32636-1-j-keerthy@ti.com>
Subject: Re: [PATCH] power: regulator: tps6287x: Add driver for TPS6287x
 step down convertors
Message-Id: <172564045178.3888706.1009452068720619652.b4-ty@konsulko.com>
Date: Fri, 06 Sep 2024 10:34:11 -0600
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

On Fri, 31 May 2024 11:20:41 +0530, Keerthy wrote:

> Add driver for TPS6287x step down convertors
> 
> Data sheet: https://www.ti.com/lit/ds/slvsgc5a/slvsgc5a.pdf
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


