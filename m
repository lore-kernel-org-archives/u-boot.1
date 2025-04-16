Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2684C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3098882F4E;
	Wed, 16 Apr 2025 16:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XJyuyQG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C336382F4B; Wed, 16 Apr 2025 16:11:00 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C91081E18
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c7e5f7f0e3so1969332fac.3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744812657; x=1745417457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUWo38jpgOzzbL/d/32J9yYZVOGfnjQpIIEj88z5bEI=;
 b=XJyuyQG7g98egjutPIsXhL6STrw+cWtkCny1x8q+rsywd/Sem1v0x3jqP9DD1G/DNU
 amj1R8skAhgoK9adUjEYYSdz2sub2xSwSUtG4+G8JFdYl9YG4Da3nOl+9dy95S6rnDCV
 rLZo99Dzsq7FlIWszB6ALgMLbdd28p9GvsM6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744812657; x=1745417457;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUWo38jpgOzzbL/d/32J9yYZVOGfnjQpIIEj88z5bEI=;
 b=REErKkYLQzT3VtZ+t3jpiiP0UGGi4JdPys+g3g2IaAXPouALVeMrUFeG4h71wjWFN1
 BtliTcV1qIY/Rd9kAvn8YaICmWvBL6sOE7SCTEUdlkfdt2Lx/MVLBJzr+BUsy3NX7PdL
 AgJNURjNkDcwLtVWawHcizgUWcE6xb/FuD95QmJ+3yK6a5eHUa9XHdOkUGPCbyEblOsH
 qECszCsKcMsf9TcC9qgI1HlHPJwnoEMeDUz6KGdJZaf69DAyFELcdalrxkHlQva9xAx2
 E0I7Lr27gwawlQpLzDhBpN9mgpSGUQwwnOThPyO0fU3D3XA16l5uhue4PUwZqjfHcmSv
 VFCA==
X-Gm-Message-State: AOJu0YzxLZr6sp/cyT34ZI8AP1v7OJ5XHY4EGmXZa/WAYMSkPsllPSso
 AzdYWKeQbwuIdWuT/KVR/DtK5jduML49157Z0DLhUidkHiEkFqAkVH9v9WrVV7k=
X-Gm-Gg: ASbGncs2X43Z5Qicw+ptNk30h+UilO5MudvDFghV9qGUUgO/Yq61m9LFvAkcltki3X1
 RnxhU0Vd7fwhFK+SOPzjN/YidPU8m7kgYvMMZQ/Li13QdOT2xEJsd9bPGV1HFTLgFXREu4QBoAE
 ufJmyPcNZXAzNccbK9Ladaq9JU5m6WaMPtF8ko3DkURP1Bj1JxC3XXpz/m93KaHAvbkvFSAMpiK
 zLKwPbU+AUfViaQWRVUEof6rDJuMlCpPVbaTz6iNnjHzaniEMJpLxuFe0n+k3vscwZIdEb7N70b
 RTC0NI3UibWRX7lo47zR3iGr11KfPUn4eXrl30tfhJ1iQVtGjm4VzfEcy8+j1yZBaJe2H361VUN
 X
X-Google-Smtp-Source: AGHT+IGRojut7oGZqaBkqCSbI4u2glJwggbaCThqYo+BgqWQ42I9ex7C1CE8L2RF5ddP5prgMF9JNQ==
X-Received: by 2002:a05:6871:d423:b0:29e:7a13:1341 with SMTP id
 586e51a60fabf-2d4d29d6befmr1156180fac.8.1744812657332; 
 Wed, 16 Apr 2025 07:10:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d09695a14csm3314722fac.15.2025.04.16.07.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:10:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: marex@denx.de, festevam@gmail.com, 
 "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250409075352.535194-1-alice.guo@oss.nxp.com>
References: <20250409075352.535194-1-alice.guo@oss.nxp.com>
Subject: Re: [PATCH RESEND] firmware: scmi: support to manage SCMI protocol
 drivers with a linker-genetated array
Message-Id: <174481265661.2150978.4093686244723426987.b4-ty@konsulko.com>
Date: Wed, 16 Apr 2025 08:10:56 -0600
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

On Wed, 09 Apr 2025 15:53:51 +0800, Alice Guo (OSS) wrote:

> U_BOOT_SCMI_PROTO_DRIVER macro is used to add a SCMI protocol driver to
> scmi_proto_driver list. scmi_proto_driver_get() function can be used to
> match a SCMI protocol id and its driver.
> 
> 

Applied to u-boot/master, thanks!

[1/1] firmware: scmi: support to manage SCMI protocol drivers with a linker-genetated array
      (no commit info)
-- 
Tom


