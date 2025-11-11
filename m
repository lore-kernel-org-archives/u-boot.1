Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF3CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0C6839D6;
	Tue, 11 Nov 2025 14:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XmKNmqPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408DF83B4E; Tue, 11 Nov 2025 14:31:05 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A7D8312A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c281c649ccso2467457a34.2
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762867862; x=1763472662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fs8PM7FMtkbhJR/R7XgxX3FsMrKW73jioNlULmsUlOM=;
 b=XmKNmqPsER/Glrm2PxdJB69+dokU96Y0OCVgmnrNzc57Gd8LkteagFiIqkBQUZoYcA
 CvMQq8mu+0/nbm4Y4VFJJA2yBGgCDHiCPZvKmsjZ6CPYtANTNg0U1NWPjVtJ48oYRDIW
 Sx697byW/X5b4RePLDop6fKwEb8U9nLaXZI2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762867862; x=1763472662;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fs8PM7FMtkbhJR/R7XgxX3FsMrKW73jioNlULmsUlOM=;
 b=QmmTYDGtR7y5ubxsajgPDax03NwdcN1TditUgu1aDal5XnQC1wcg4aJ8wpUtOP7LwX
 GVNUUO6+b6WUPAytljixod0VusXC42+/9wAES7SoBsRT0c4alSCp2L+OSTeC1k4O0PXN
 toprdP7JQGsOfM+7sLZPxViZcQBpxiuBLocm0ceHhuzWVAuDU+yolGj1aSMAGwHaOd+I
 WorbqMSULM5fnAsw3p5fyEhr4HWwgLX6oVH9CqSV7N/nxmSBvviVk6Txn3495Nvp8zNh
 ksX3iyirxHZM/d0A09/14j9O2MDz24JGJZY2t8cc3uZp5JdkZpQEHcx73v57lNjW43WN
 ghXg==
X-Gm-Message-State: AOJu0YzRS6tYj0ab/81fM15DoO8oXhhwlCT0YVNgIM1LM7AsX/FcMnFX
 isp8/Wlba70tEue1i1AH/ILQIklmSQWWmtxB2QOP3arO4SaZ+7LxYkyU3QYCMoIsmCU=
X-Gm-Gg: ASbGncskxMzdwEUvrXTtZbkEhghoVzkTcI3ZIifCaQ69XxPTQv+QfzKhwhHdmMS9qiC
 n5h8QB+G2Wi90LyX+NBgjYzKMuAXGtE3pPXy18QWA72zod+y1nFm33NIdMGzqI6KcXg6vTish4g
 UvpBv6qrsZmxCwoPaMudLivIMPqmnSn72NMEN7qCG7ab/+5zQRiqyCfj6CC4/2ixynDx7yGhdUi
 Ms+f9juxjIvEwNuRRF7T7oIWdyef6NyA8FDAAGSlqYq0sIHfKxLGkdeYwp2dycxB6veK+PUHvd1
 fDSEDuwWTj48ERV7yK0p37BUyDThp4ERZZ47UEI8j3DYQs35pOhUgqN09BXRlceZnSix425TFOZ
 mu0X9kjHz5wc6Ofgb29dKJycLnzKeyMpNZOxHJgMGS08SJ7aWAEVU05TIgB4ASicj6SO4C/J9RH
 ZZPPPw2PrQdFdZyDkDK24tpID16kNlS99her2gmntwrVUsi/IrVk0TCRZEsXU=
X-Google-Smtp-Source: AGHT+IFOU6/EmzOOX1Kk1HL/YMAiXh/HLQfUfmUi+HzOrhGnoCym9Ej3LuSHIoQ9Sgl1YrWyOSZYvA==
X-Received: by 2002:a05:6830:4412:b0:7c6:9572:fd96 with SMTP id
 46e09a7af769-7c6fd73989dmr7587195a34.7.1762867861815; 
 Tue, 11 Nov 2025 05:31:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f10f5c0bsm6946869a34.18.2025.11.11.05.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 05:31:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <aRKPvJEo6IbR3d0b@nxa18884-linux>
References: <aRKPvJEo6IbR3d0b@nxa18884-linux>
Subject: Re: [GIT PULL] please pull scmi-master-2025-11-11
Message-Id: <176286786115.3306098.14122428542189179188.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 07:31:01 -0600
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

On Tue, 11 Nov 2025 09:22:04 +0800, Peng Fan wrote:

> Please pull scmi-master-2025-11-11
> 
> -------------------------------------------------------
> - Support scmi v3.2 CONFIG_SET for clock protocol
> - A patchset from Marek to optimize the scmi clk
>   booting time
> - Fix scmi clk set_parent in non-CCF case
> - Drop mmu_set_region_dcache_behaviour in firmware scmi
> -------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


