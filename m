Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE7EE8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D2284198;
	Fri,  3 Apr 2026 21:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ChJap4xT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3891583F9D; Fri,  3 Apr 2026 21:47:21 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ADA48413A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d7d4ebccf7so2023219a34.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245638; x=1775850438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lFQAyBorU1L3mZVjL8M5JFkO0rDxhLGqgC5oQUcvb3c=;
 b=ChJap4xT3H8SQHmC37ZPZjAmP+upug7pmsrE+n3Q3K+7jk4FWNxlSEjGVQ6xFIcG3Q
 wzFe9xQQvgffrgXiNmwzH5zFYxhiz/r7qOqQfMw/e8BtYYz2wj2DkybRiebAGirfzbJO
 VDQvSkfOyOm2OClSIe3WaiqiyCfCQOQ1vk9BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245638; x=1775850438;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lFQAyBorU1L3mZVjL8M5JFkO0rDxhLGqgC5oQUcvb3c=;
 b=hER53OHLPdAie/KwrIGg7Ri67HCzvwICYrHVntvh30s9BkC2vUG1hdKOmRh5fiRjVz
 IuFgEQMK/M7VxdZjOy3VL3GUrIVbbseC88Bh3oVSUJuhi/ALrOErptd0SWaLq1Ynu7kI
 TFzjfV+Vd1KB+aFvxorhjGJv8Mwpa6m6LiZO8BfiZ+fBIAxflCLS4mySAuhRw+r/3W5D
 cJuxIem5eV2mpw91pGR31VNHyu7D73q5a9PyGmhzPJPMWmB8fqVHqIG9RZOryHE12E7s
 j2kM8uEDyp2BusJoI6ayZ5opstZNHXhe61zceDDtFKM8kOCcrUonVqxx2RMMB44eJv2w
 tC+A==
X-Gm-Message-State: AOJu0YxWljboMhH+Vku8Yhpjq6Mq7GGF+Fs1p36Al3W0UmrOKdrq1rwv
 Ju+hVVGqjZ2Cs5u9YFKl6Ye6V1dar3xwA9G0sYB15XRuon9NanLVyBOJ6v2Ygco9tid3o9FbcaI
 qcQ4UVJ8=
X-Gm-Gg: ATEYQzwyn6/gD4Jb0TUXeK2a/GiL+bturwg7LEWzWMRFNUtdYSIaepPd4tP32Vqh4ZG
 u+3rksk/TYhGEzczOGQuxNqFtzIl3cxlfaDHmD7xTJXtQvXqZatIHuSnhVkKW37izMD5DNZkGB9
 8YKB7o0xyq/vkaYl2+4deAJ1oP+fd0oHL8YLbIqP6Gmhoy0BSfZeUCm52rLFZzmY3F3xMdPC9Rf
 WskJ4k3ZvAM9uallJfM4G7fmGdASFimW8N2Gi+KVV6nYvyqjCMWSt3VdbYKt3dwjlDxNHl6j8rT
 Kn+CU9WaCKlKoAIZhB6VgWIIhxvSWPkhHvza+cVeeTKSgmKF7tALCMt2WbYlw0MYCkrD76K1IMK
 Cde5ZTAU8vtb2LbAH8ZnlbBeauCduPGlVQLFdjRCMIjkc+fQrFoeLKYnHWeQRpprFwtKcrj2YkA
 B6JPsYHIPkjiH+0QkIiMzXOsOpTUcqeUNxkWfozcbdhscbp6NZQ+0dRnmkZpmKmLGgsL3bqN4YT
 vR4f66NAhB94FpnmQO3SSNb0f/OM88GORFtqontnEe00fY=
X-Received: by 2002:a05:6830:6ae7:b0:7d7:f59f:3d20 with SMTP id
 46e09a7af769-7dbb72f643cmr2541788a34.1.1775245637886; 
 Fri, 03 Apr 2026 12:47:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205337.3788774-1-trini@konsulko.com>
References: <20260320205337.3788774-1-trini@konsulko.com>
Subject: Re: [PATCH] env: Correct dependency for ENV_IS_IN_NAND
Message-Id: <177524563729.2281750.4251063766502005186.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:17 -0600
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

On Fri, 20 Mar 2026 14:53:37 -0600, Tom Rini wrote:

> In order to have ENV_IS_IN_NAND be valid we must have MTD_RAW_NAND
> enabled as a minumum, express this dependency in Kconfig.
> 
> 

Applied to u-boot/next, thanks!

[1/1] env: Correct dependency for ENV_IS_IN_NAND
      commit: 0a0c3a400180a9d17d50bb9b29921b5c898104c2
-- 
Tom


