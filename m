Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C7DCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 17:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863C282E34;
	Thu, 21 Aug 2025 19:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cQsuxjFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F397B82103; Thu, 21 Aug 2025 19:16:38 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFCBA80B9B
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 19:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30cce86052cso726280fac.1
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755796595; x=1756401395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GbjOCPJuXGNN/mxHzC8EuSZ0N7hp0KfU1bGs5kslkGM=;
 b=cQsuxjFaByWSL56b72eDtUW/tnI5KUjW+27H73N8HMbb7SkTFHe4Tw5aRtvE/U1fhe
 adacva7RbHfUdzcH2x9FF66Tk91Uuir97YlngzrHMj9whjf9MKdtk6W0cm/so9xrD9BC
 uPhtZBF4/X7MnbWlCADf1WV8FQ5ZDjO9pV5CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755796595; x=1756401395;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbjOCPJuXGNN/mxHzC8EuSZ0N7hp0KfU1bGs5kslkGM=;
 b=KlRIAhSV1I5kBRW270On4oMXSJBBnzwbnMNHhm1OmEa5lLxWolmXZ+pqXyN0MsFWf4
 jMjQD0HcRErWbE6gs3VeiGdlQkK/dcGGWA2L3dpXTzQBjbEy1gMZ4xwone5CwLef8wkT
 jfSETB9qGmXCnF5RYP6kDfHVBt90a3xla4tsXl5YLHa0PGZ2l3iybnRm2VOx77iM8lVb
 pXn8kQRJKSA0wc8JVtSSkr1cW0uBk4cYElEjTVpRp5Wnf+iYMu5DxKfarv0yGtpXrCNk
 gDlZwvzDSc/ScDEt14iHqJuIW4d5WN6wFVzZO8lvXgEP7Bm8MVTc7f9R8sDT1pR0fN+R
 ZSXQ==
X-Gm-Message-State: AOJu0Yy/IdUzaLPsnAk+0B4fdcdoqZLfCZ7EbbeJPzcgcPnMApLBttKp
 ozK1dy+CWG1bqYalJ9TpQHNmPusGgF5mGM87D/bdpUWNjx2aF1l/OZvgFonkdhKmmVqiw+yJIAa
 jg1YtMKA=
X-Gm-Gg: ASbGncsdRRbgXnwNvsXUyjJxYMBjVku9fmrH+hjlR6loXQf8hspe3yMsHHKyek2X/8G
 3UrO1TuUtqSAMrdBlnlSYO79IyOlGwed+g66QxY+vZizeQN3ittrpbQHYym0UWr0I2Qadu7y8PY
 JYzuNTESHS/8jSn15U/LxVCNMpN+OrQQzbbmX8Bx1eqC3LJRmVx1ssmtNNa8xRKs2BeCXbrm4g3
 XLMaBpGPs6AcQ++U8JT5its9bSlsCMpXc1oh+zt8OkjtArWCa/CkHcrdFt3Nec1MO0OFvYAOBJz
 Lta/fnKYlVDyW7kvOMVzHMLAfAj470Ctm3GZz2HCv9wIIbyPuWwCbzLaIaxfx0cfcH/KgBies1N
 02xqty5fFZ3hYmzELEaywEJ9NtSSbVRIHd1TynKUajEKffppso77FBVk=
X-Google-Smtp-Source: AGHT+IGKyKFUwmAL7grkkA9EsYdWl1VRjshAjqtXMgO64aSeJUuKissbo8hnNkML29lh2H4Hk7OTYA==
X-Received: by 2002:a05:6870:2b0f:b0:30b:ac14:2b3e with SMTP id
 586e51a60fabf-314dcdcc95amr4540fac.37.1755796595421; 
 Thu, 21 Aug 2025 10:16:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab952d79sm4999909fac.15.2025.08.21.10.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 10:16:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leo Yu-Chi Liang <ycliang@andestech.com>
In-Reply-To: <20250813061635.3908363-1-ycliang@andestech.com>
References: <20250813061635.3908363-1-ycliang@andestech.com>
Subject: Re: [PATCH 1/1] common: spl: fix compilation warning
Message-Id: <175579659460.3655101.18342809283733971644.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 11:16:34 -0600
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

On Wed, 13 Aug 2025 14:16:35 +0800, Leo Yu-Chi Liang wrote:

> Explicitly specify the type by replacing macro with variable
> to fix the possible compilation warning.
> 
> 

Applied to u-boot/next, thanks!

[1/1] common: spl: fix compilation warning
      commit: 18d0cee4e065a01fb3649cc6e1502254e68d50c6
-- 
Tom


