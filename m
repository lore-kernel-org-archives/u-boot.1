Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A842FC3601A
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 19:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6089E82BE3;
	Sun,  6 Apr 2025 21:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G+FeZjA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B00982BE3; Sun,  6 Apr 2025 21:50:54 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D26182B63
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 21:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c2bb447e5eso2052393fac.0
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743969051; x=1744573851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeRzzwYRrcMuUZ9x0bAx8aaWiIcMOU8COXWWFzM6NGI=;
 b=G+FeZjA0n/OVicTDYOVCmnEYxHb6w8b3rrVR/gSuzKqaAhGS/USuXKw4CUu+JSbie5
 yQJRSg7JJXLBehmpE1IBfwQJZwzE+D3aWATliGQ1HYQQCOpsb6cBFnT/+YeFlpF21QnG
 sfSuMtTXqhE5YIm3my/Bj1qeUdsk4NV1cp/oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743969051; x=1744573851;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeRzzwYRrcMuUZ9x0bAx8aaWiIcMOU8COXWWFzM6NGI=;
 b=n04WVPeX1erPguSIXlssrBGsHjTCeVb6Eg2j7HuRzD2FkcWDXlZWUleAw/d4ZIuNG/
 KJkaTp3aosDV5XFQHhVSOAPixSprpXbVfi5CDVyz5IJweG/KohgVIDynEFLd6+RoUSuy
 2AMNXRD8mzGZGwgFgl0nHu7dLnc3JbMgfAdCK3IuZ1fDoho3JFUfv5XCx4mh6YB35XAg
 kS+F7RJp4d9nOe8wPFzIxFN2Al/qYpfGI7jgaRFy3WEEBCr+LYEZhvDn7QBntmlsEuxU
 39yCpEqIUZJDD9uvsRYoyosUMytB7F+EAe9IK+QOk4H3LIP/vDE0iDY88LEBxPHrzjyk
 ZnBg==
X-Gm-Message-State: AOJu0YziVkXq4JBRuJlGnU7Duv43yfk1QfWkgdn86mygLwxeHgKHHUYr
 rrAP+2gL4ef1lwQ7InJR7Wcaz3GEqzgir4LvaB8rZUTTR5COMFU+IHW+/MsUulM=
X-Gm-Gg: ASbGncuFIyeBO8v8ubvsbL2OknIdRWyWDTi4GhLPLUMzHnATPsXhJCCSwWktzQE9icW
 eDBfoT1HMdTmGU3fGtjyvPavt1Z0V3gtmXOA/STieLVFSjBhYXbt8KnRfTwnZJZPMasfi8140V1
 OgWz6hnwwSC5Kl22HzwsxzQQ0D+Rizni3SSMgOuE0FoZA2nbXgwP76JpIkSGmRS2pSvn9RcdQlA
 2tGTTbiA5sLLny3v34yOrjkIdxFbXbv32yDeXcjDuY7AhRTOk6Zh7pds17eyKDLyQG8Jbndq0i/
 BxnWVbMxv3csOf/x2ZseJaDzK1y8lN736xeoX5PbHBNIj0liHBP03IgnmlL9HzZcv5rHVO0sHTC
 5ub/H
X-Google-Smtp-Source: AGHT+IER0fc2GdzofH5g45lj/hu5pSFmUxSro6vsw/rcOGwZmULDGXCqSOZ/llMEUVykv65NAsuvmQ==
X-Received: by 2002:a05:6871:7427:b0:29e:617f:c96 with SMTP id
 586e51a60fabf-2cd32e1b74fmr3934301fac.6.1743969050964; 
 Sun, 06 Apr 2025 12:50:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845cc500sm1703175fac.18.2025.04.06.12.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 12:50:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20250404140530.2874921-1-raymond.mao@linaro.org>
References: <20250404140530.2874921-1-raymond.mao@linaro.org>
Subject: Re: [PATCH] mbedtls: remove incorrect attribute type checker
Message-Id: <174396904855.1127672.5822086196155254544.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 13:50:48 -0600
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

On Fri, 04 Apr 2025 07:05:25 -0700, Raymond Mao wrote:

> S/MIME Capabilities (OID: 1.2.840.113549.1.9.15) attributes are
> expected to be algorithms but neither data nor MS Inderect Data,
> thus the checker for data type is incorrect.
> 
> This patch fixes a capsule authentication failure with PKCS#7
> message that contains S/MIME capabilities, which formed by the EDK2
> GenerateCapsule tool.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mbedtls: remove incorrect attribute type checker
      commit: 0708d54a5697e30ea5ecb03f97360e4fcff89719
-- 
Tom


