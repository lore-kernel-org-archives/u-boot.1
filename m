Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B747AD6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D949896C7;
	Fri, 15 Nov 2024 05:28:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="leKESENQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D77896BE; Fri, 15 Nov 2024 05:28:06 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935E089353
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4609e784352so9261401cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644883; x=1732249683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNeo6QGd9OTo+Xd7gh9IZjZfOXIxIW0NbNFaurnmSik=;
 b=leKESENQFRtuXCSZgB8Lsf1G5Bnur/xIMwodcL5ZXQpmNSGKqa+WTdltiSHPcqSKaQ
 UrliCHnoMyugy388kIInipYAcKDtZ+SePt4u7JN+7SZRxl2pV+0evArf2/wwWrd4wZ0v
 jsu7WSx0YuuG5dQhRJxaR8sP4btoLvrdGvxec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644883; x=1732249683;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNeo6QGd9OTo+Xd7gh9IZjZfOXIxIW0NbNFaurnmSik=;
 b=JTWaiNZhiEdBhSX+L/QB+EwBOAtnCB8gfEimLE4axQGIv/bWeyYnHkvQoz4gjI3LNx
 CWcnDJ/GGY8BMjk9f39ui0uWaa8EiDIfs5qDYJmdN5gpEdJxoGhGb6tyFfPYYdhU10Kp
 D57+hTZN3fX3LfC5KonXAe/g270AfSW4gloO4OueKfSHdN4Y13ngXaCu2Gs+JilO0DG7
 AGam3iLke+hC7R0zO4silGaRs2qlGtScAWwjX/I8ZAC9hn6+TXMuPOlw+uRpSZR6I/nS
 frjirfrVZTZXVVgGLDlQyPLEHf1DuoqxonvFklWOFnfZNql6Fv8O5gGc/Ht6rWiS52uu
 Cd7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFS/0szhmhDUlTbx7S9SgZX4EaEdzYqtScFvfwxQ7wIP+KeTWbXVm7jLF+uc1O+1lTIajdss=@lists.denx.de
X-Gm-Message-State: AOJu0Yz938iS/5bQAXHmfkRIXrJwcFLjfklDSGV70bZiP91VWINo2oUG
 WhYpVSUXJp4JIVbWtk247jdQdJanx3ukIijmqG1wbl9Vd/QDmpbKjqr81EsJk9k=
X-Google-Smtp-Source: AGHT+IGdPYk6qxeWpvmLexwI1ADb7bXSVOn4Ps8zHVDebhqoMYr5hfKuTeZBW9LXTghzIcep3wp30g==
X-Received: by 2002:a05:622a:4899:b0:460:ff33:9141 with SMTP id
 d75a77b69052e-46363e1127amr15317461cf.15.1731644883525; 
 Thu, 14 Nov 2024 20:28:03 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:28:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20241103224812.195778-1-heinrich.schuchardt@canonical.com>
References: <20241103224812.195778-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: use %zd for size_t in mbr_test_run()
Message-Id: <173164488135.1205089.17557175249897718245.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:28:01 -0600
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

On Sun, 03 Nov 2024 23:48:11 +0100, Heinrich Schuchardt wrote:

> For printing size_t we must use %zd and not %ld to avoid
> a -Wformat error on 32-bit systems.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


