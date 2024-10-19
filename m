Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A2ED3E19B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 02:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A0FE88F27;
	Sat, 19 Oct 2024 04:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c153cZzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CED188F23; Sat, 19 Oct 2024 04:21:41 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F5B88E33
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6c5ab2de184so15513556d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729304498; x=1729909298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJuwliEBIGXe4Y5NH04I29ZUdJI9ffpi88CeNOr4n40=;
 b=c153cZzH3bZZYIAkqq+A9oCRSfY9DER4NGSp7emAeYNCT6JYZZvQffvbtojtQ//OLO
 QhuogYuPTyl7ViN1gOXZyggR5DfE8JgOPwAAd/d9QXMqXtZwOkfhhIVwG3acz9ZYmxBk
 0m4lJbThJmMDBYTM0MvoPUEm5V9b4rDxJgOto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729304498; x=1729909298;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJuwliEBIGXe4Y5NH04I29ZUdJI9ffpi88CeNOr4n40=;
 b=Too4SizzCJvtEH8pHgM4fKBLl/w1iZ/q8Z0nKoiwz/cwWMeFxzPquLnliQICd7RSap
 ezzOZKL66XMowlghHtECJWdg1oCAO2XGvkVnJX9IgjE/zrRIGKN6RbPz45afmj8Atm3Z
 CtsISa38hnXJpZU+gv7BA71Bw7rZrHIIpedgsWc6CojJRhZppvN8wpkogj72MmtWO/vA
 GFeEi3F0R6IcBY0tCxSGDUTIZ/L/dLkZDwML4g1jgb98tqSlzY+9IlwHFvzRwscttjj2
 msNypwj4DErm5ZH5jYYgBpMMCigasMvgVmKefhX6zbXgg8HIZ/rmt0fgihGtZonIon1g
 zxQQ==
X-Gm-Message-State: AOJu0YzqIKzDFj5lxZx/jSsSaXeTHPFCV2HubLLPmTtwRVlXKlBYAfc5
 DIwtAVsZ7Jvl1rfCRauKgRt4pgJ9c0Y9sySXrFUUl8K8PQAZUUH7MWCD7ZYSVwFu8quugdNqvXZ
 UzVg=
X-Google-Smtp-Source: AGHT+IFmT6xwLGKAQYju7WqLvEZ6aEjF2824U66eSeJH8InZfrjmSWfs82dfE+bTnO+Dv1a/F2tuLQ==
X-Received: by 2002:a05:6214:5784:b0:6c3:5496:3e06 with SMTP id
 6a1803df08f44-6cde14b89e9mr56742106d6.10.1729304498515; 
 Fri, 18 Oct 2024 19:21:38 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde138fde7sm12521016d6.143.2024.10.18.19.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 19:21:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Hai Pham <hai.pham.ud@renesas.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Johann Neuhauser <jneuhauser@dh-electronics.com>, 
 Simon Glass <sjg@chromium.org>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Vignesh R <vigneshr@ti.com>
In-Reply-To: <20241015201513.21836-1-marex@denx.de>
References: <20241015201513.21836-1-marex@denx.de>
Subject: Re: [PATCH] mtd: spi-nor: Move SR3 WPS bit definition in the
 correct location
Message-Id: <172930449623.2505436.12599041852628693774.b4-ty@konsulko.com>
Date: Fri, 18 Oct 2024 20:21:36 -0600
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

On Tue, 15 Oct 2024 22:14:53 +0200, Marek Vasut wrote:

> Move the SR3 bit definition in the right place. Fix
> what is likely a rebase artifact. No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


