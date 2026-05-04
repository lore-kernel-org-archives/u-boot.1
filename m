Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E49CFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCC584841;
	Mon,  4 May 2026 22:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LVZZTspX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC438484F; Mon,  4 May 2026 22:36:17 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97DF84840
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso2495296a34.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777926974; x=1778531774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6wMeWiY4wiDq00JBMZr18kZFBcQ/Y9Nq+dpGZPDfx4=;
 b=LVZZTspXDfpyeOkS3i4jD6CLrqizuwzyE9yupBSt3nsJdXfhXPlR6+jkvJkHlUKVeW
 hr6iou4OmwLxQksu03VosJ/UGuBKxfFj9j6zC3lKi4HJqdJlc5+XX2XYzMSDpZczQlzt
 e/crkxrnEgsDtGNj4InfzIuzvp7a5FkGyYgVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926974; x=1778531774;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i6wMeWiY4wiDq00JBMZr18kZFBcQ/Y9Nq+dpGZPDfx4=;
 b=H6i12V9A2VuzfPCALMa63HpdLJE6QCd8g8p9+x8iFhT2gvHymW739OUaF7gxAcq+Lz
 5GihQ0W5OBWQJL1N/MckIpZDcnAOid7b5Ge+4LEPQLijaIsYO/8yhazoteGsEqvlxI3r
 g9xC0EG8pVtBoPAndGoUxAF9B+lTG2vg89clyy38BprymTmEtnS2xJeW+BuEtshsHqc1
 k2lVKRGBL1rkavotcdNtrkWzrZ83zD803oxg3ABxVRJ5r9VAAGE2gZ8Hwc7CVtNH4CEA
 QY9WQMYiQwRSeWOxlTIOqDOVgrqK9MG0WvU/HjSHRCyHEcImCt19hKAMMN/32iNFU5fv
 kTFg==
X-Gm-Message-State: AOJu0Yw13dSPQms32zDdiNazyDPZWb8u5r0ceEqgsrEl19hFzbOy3OEn
 Oc/YajMXnn4Ynf7uuzCDc2YMg7+qEKwZ0Xbo7xLSayglaxtwdSntTolhVJ+1i6nnuRo=
X-Gm-Gg: AeBDieuJNpTeI20UOBEol/iVN5T+SJ0s3R5rwK9UqVdajoVcWxAmMwzQCfxxgtoNy9p
 AQJKjC/eA03VaeHH6k4/t3KU/Zk+MXwcTqXehbLH8HOCbVBEIgl4/AMwfMo5xXeD6YqWFEBgEX5
 2UTql98M+sxSXxd1Q0j6qzGnhwmo7qqWWhi2LGqhyVQKv5oaVt8/t6iPkydMbD3eXI2b67XHEGc
 PQf8FIpXtUCtEIgt2faZtq/yWRHoDhHx9FItm15xUb8Drt8C51b1zwvknpphrDl0+cMgHOJ9wkO
 zPGFoYSZRHH6w56eCr68KlM6rcdaNM/bqaUBmZJMER2QVd6+R/L2UWQmjoZJIY2ABi5J3PQkOMq
 IuVrIDg7/gP21mi72ksGNGw+Y5fR48rk1lKzL7410aaBfzXVaPds83KuJtH6GZXESkY0ye1eyZ6
 DnfDjQbg4urptrjnmxqwdTrCBNKDklZdSXZFY/1XhFylTGR72fA+/PI7d4F2+3o0BDf4WIS7Htb
 DV/pABTXuc9/bMxppaqD435a4wHbxonuyQQEDnG0m7KexBfqkWtb0T02fah
X-Received: by 2002:a05:6830:6a86:b0:7dc:e08d:d9f3 with SMTP id
 46e09a7af769-7e17499b995mr275136a34.4.1777926974480; 
 Mon, 04 May 2026 13:36:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26330sm8464401a34.13.2026.05.04.13.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:36:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Michal Simek <michal.simek@amd.com>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
References: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
Subject: Re: [PATCH] fdt: check fdt_pack() return value in
 fdtdec_apply_bloblist_dtos()
Message-Id: <177792697312.2985766.1200278370447712403.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 14:36:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 29 Apr 2026 08:22:08 +0200, Michal Simek wrote:

> The fdt_pack() function can return an error code, but its return value
> was not being checked. Add proper error handling to propagate any
> failure.
> 
> Also fix typo in comment: "Shink" -> "Shrink".
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fdt: check fdt_pack() return value in fdtdec_apply_bloblist_dtos()
      commit: 7dd93524eacfec8512700056fcb54a4ba5c8fd8b
-- 
Tom


