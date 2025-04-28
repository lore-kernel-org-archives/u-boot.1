Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8F9C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53048210A;
	Mon, 28 Apr 2025 21:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZHMZJhK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4664880AE1; Mon, 28 Apr 2025 21:03:04 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2574B80FDA
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72c14235af3so3379560a34.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745866981; x=1746471781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HCtEVWJcmXFoOGzyVfgKGsZOhxofyUpfNpKsOvnito=;
 b=ZHMZJhK1dTM+ssnWJ/iGx9hEcTxf4lWrdbFzsysJaWv3wfVbmK+/26Azy2gdzn2sQO
 oylK5fq3c3dacAqvAcqS5/eIj7HWtAkOHRAmY20nqJLiD6j7btDalHTijInSxypCUBWa
 2hFbLVBJq5mlWvuUpUgOheMJ0GNz+NhHn+Lak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745866981; x=1746471781;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HCtEVWJcmXFoOGzyVfgKGsZOhxofyUpfNpKsOvnito=;
 b=uiVYsltOWIrdNKRzhTAxfA/Z6lBZjus6+gqXRPdvfVAGzVGOuydO7kJCqCSr94VhZ0
 zH6zqDkhvsY5iRvwnQopxTjkNcugo3uG7u4ExQtD66YvpCvGzHxGowUofsqpshPJiipb
 3yHZMso21wkb+pMjudxmEVE44GToCOKroVktMuXa/7H+v+SS6m/cza11ETvwLMBWDlBn
 e2RmV2/C4QnrXfJddazNzN3xk0nIIqyRxUaFW3B/hR7xvPFVgVitqeFMq0b8ccqINiB2
 g0UB2u6Ccxugeb/uhKzjaECSU926cEJEVhSGntV0/BDFifJRGnujDABRaF08ZapdYZ8S
 Lr9g==
X-Gm-Message-State: AOJu0Yw8wtVulOgKypfnaLDDh2cghQYCzCMzO5StuYVNaGU7rGuFCSN9
 mBJf/jb54yD4xJSgOLNYlHKKuUxg5FbaM+9qm9QAYY/Xa9R9m8zni8FId5O5VXbP6XtcBs81o8w
 N
X-Gm-Gg: ASbGnctzEXL7podjUk3vqUWh796YE/5gCx2TV8cE0BI7xma/wu/hQ+jXjKYRVG3sD2K
 sg4hO8KVLDVnO7zN2csUB+r7R0DDzE0As/6DHHbPtGG3lQDjSLWfNU0VPA12OkE6ZDds01RqYON
 3PRzQd8vUr8TnT7XlNwyTAcsmOhWH7UE9ExZeceOhV6AHNN7V5Il5Ct2YgGg/Pyu+8Rd5JauHkl
 8a1cs865aJXvDxGTEv/WN8/bkIDN4HhutNSBtUVOg2e6vB5o+lPcWawz6dlPZ4x+oY0ZSvWa+nw
 2pAU5GujgB+bbVWHD0udKMVP3hxDXYnPCMOEcUe0s/9EdqIBHSLnJE+8agx2oMvlqa9OmyA89fE
 4O78O+vhSzic=
X-Google-Smtp-Source: AGHT+IEJteTCXWkYQZyrfEskPP1+L9+Q0iyopE6eLkQ+oYMQSNUnecezSpIL/y/sAmOaoqlzaKvwdQ==
X-Received: by 2002:a05:6830:71a4:b0:72c:3289:d983 with SMTP id
 46e09a7af769-7306519ad13mr6779407a34.10.1745866980946; 
 Mon, 28 Apr 2025 12:03:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f39b78esm1886623a34.68.2025.04.28.12.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:03:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250428160652.2592846-1-festevam@gmail.com>
References: <20250428160652.2592846-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250428
Message-Id: <174586698015.1102146.11753494488222570037.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 13:03:00 -0600
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

On Mon, 28 Apr 2025 13:06:52 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 10f48365112b164bee6564033ab682747efcb483:
> 
>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


