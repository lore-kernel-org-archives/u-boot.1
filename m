Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E20C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 03:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAE08056B;
	Fri, 21 Feb 2025 04:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QWLdx21i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C382801DE; Fri, 21 Feb 2025 04:28:33 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BB48004F
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fbffe0254fso3362562a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740108509; x=1740713309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEspWA4LJPDSCHoFrFJUnq2chC45lssTk/u8/5wsnEw=;
 b=QWLdx21isxBR4JvAbt+muCNFqHlQVcCL0W4RD5NluqGUtKU9J2dSC+VbhD1oM2Ec2x
 DOen9eQQa5eqpAgGjC1DthZ2Qb0M6/ZKnFc6zmH6CkWkCp8NBJFJjzMucnB8b26ReYyR
 UE301RBXF22aWWJxtSANaXIXBGDQGJhBG0nBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740108509; x=1740713309;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEspWA4LJPDSCHoFrFJUnq2chC45lssTk/u8/5wsnEw=;
 b=j35W0kDkCc8OQ1P8NclUYzYBz4lFbvMAyPsJ04OLrfUoR4whpIDArXXlJMzTAHX6gW
 Yg9YOa65ISKWPQ0zflAKQsI/LIMyKFnrlbNXdlrEWHPuUXSCqSCAOYt0rb9w3BMv/jYp
 T6gol+oGRRsLuQ50CVEHcb8sw8VQxm8oJnvYaeWfvku6pa+UnYu2+haYb+lLPcPTB4mS
 odizH1lQkSx7yRQdutyfXf3fMYC6Zncz64HPsnHgt++fK+6aSlZL7P5QNakabpVUdEG/
 MTj9gcUrsLl2AO/n51HTs6CfF/1hkLD5HewxplLuuf8ZrC4ZMeNHgGF8MskjSt1s0369
 LM0g==
X-Gm-Message-State: AOJu0YzlNiPxGqTdv0i/bp9QRs1fL8MvQjorHLiUOBXz9GxhLSGLl7qO
 Bw6yKjVTrEJmgHb4wnPxc6yJJax/zfEqww6fZGJkIpuhni8lkbwmp9KDsOPjHT8=
X-Gm-Gg: ASbGncuBaGMwynTnqf3z/NzplYKCtOlTElDw0+8E61mQAipOv00cDywXRQUUDJC96t4
 BaQ+WURsgrug06HjyTlnJn0rxYfwS1TEVip6HkGj4eZGH26+nyprAeLdLOPpG62t+d9mLZxx5n+
 vLAWQbcXCIBW9Pcl/eBDLsTvq4qlN9/nselSTgol+kYl42vt3HBLZF0WjAUL97w2Gu3bFvqDbZT
 WSKftDys8juKJfiKd+1ybPTetriM0+3FhbBzyEDjohtItzPTVI7AV1Xao6UU8TX5aWHxuFrt2To
 uqFA/F0YY+w/iuDA84vEyf4=
X-Google-Smtp-Source: AGHT+IFkxd5j3y8LD9P75zOq0TCm+DvxsjLvdxFJb1otqZ9blm0/S7DOIM5tvbRr67bXoU/2nNyEag==
X-Received: by 2002:a17:90b:4b01:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2fce77a01b4mr2586222a91.6.1740108509336; 
 Thu, 20 Feb 2025 19:28:29 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb06539csm197351a91.28.2025.02.20.19.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 19:28:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, vaishnav.a@ti.com, j-choudhary@ti.com, 
 mkorpershoek@baylibre.com, rogerq@kernel.org, hnagalla@ti.com, 
 glaroque@baylibre.com, nm@ti.com, n-francis@ti.com, m-chawdhry@ti.com, 
 jm@ti.com, devarsht@ti.com, sjg@chromium.org, afd@ti.com, 
 j-humphreys@ti.com, quentin.schulz@cherry.de, sjoerd@collabora.com, 
 martyn.welch@collabora.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250210112239.2639009-1-s-vadapalli@ti.com>
References: <20250210112239.2639009-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v4 0/7] AM62,AM62-LP,AM62A,AM62P,J722S: USB DFU and UMS
Message-Id: <174010850633.2983272.5209262089489826462.b4-ty@konsulko.com>
Date: Thu, 20 Feb 2025 21:28:26 -0600
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

On Mon, 10 Feb 2025 16:52:23 +0530, Siddharth Vadapalli wrote:

> This series enables USB DFU and USB Mass Storage functionality for
> AM62, AM62-LP, AM62A, AM62P and J722S SoCs.
> 
> Series is based on commit
> d6da3dbaef Merge patch series "cmd: Add support for optee commands."
> of the next branch of U-Boot.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


