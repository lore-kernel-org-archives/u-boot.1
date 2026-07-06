Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091D3C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 22:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BB1884844;
	Tue,  7 Jul 2026 00:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A9+YvNGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1676784852; Tue,  7 Jul 2026 00:16:48 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D233D846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 00:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e9ed64d490so1099776a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783376204; x=1783981004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMLSKQ2r+NWH9PuF74w5hcedZ++LUKcy3xr+SXMk/RQ=;
 b=A9+YvNGTOBgbGJQRpHPVU2kQ9dlVOnSR4n5Qo91wV5JpkOskHL17zTZkAH6iRRF2nW
 o/tKdWQDn1Qo7X8Q5n5ARiTOPCzz+rf2tzIv95cnk9LZsRhMjyZi9yDgaBLglN0LwPcp
 VZjGWR7z5QhccgFWJC7v9ZnO8xm1dQqgvEBGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783376204; x=1783981004;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bMLSKQ2r+NWH9PuF74w5hcedZ++LUKcy3xr+SXMk/RQ=;
 b=cQud8wWiZzrEZ5idXWxIKrXf/XEruHX5jV0p4iqKHgYC3hC7K3eRLN0DNErQW4CjDD
 LHjGnlK5qFsmEb+gOSdhQ+HsB1KfTnoStjS4R5/m2A7GgTMXZ4FB5ZQnOi9Nfl11AYWU
 0wW8bjLLWxK5hXgJNI3eos2v9oNeqHghNJVVFoLlpCdjEKHFsLX4CMKhT51VA7IlCpG8
 A6yFMbewPYdKowJqT1p+ZwkmSCzV2zUbZUJVK5QATyXui0PkMNzba6Lzd0dEpatu2i7w
 oIzxkgnWusWNk72jzcZTu/4t1SUq0gydVwOV9CKj6L73t1dfRkYDqAtZlcAicwp44Yp8
 E6wA==
X-Gm-Message-State: AOJu0YypQc3Z2231qS8Roi0Ctb2Z6Nifz+nGPLPUBmUY1ssQoVKGyiXF
 9pJo5XyE0aDNJpEpPHzj5uCl9puOA5bJgBpWNp49O9LHVK4Cnzqxo0OAoP/g9uR7Cy2wZvEOStH
 xHKPq0N0=
X-Gm-Gg: AfdE7cnFUGMg+BwcppaGiry4OTfYlnG0vvd3XLZARNMWFCknmWMG8NZmco39mYaV/uR
 2uIDvOHLJEnTyuvtOT2eKvat69VWiTpzcrX1YJkWOHOBsbqWJCMUe/8M2zj0SkIXQqHO/rxdM51
 lldW35xhq42N989dKzEpuRvJZz5/WTLtvk7IvCF7h+3tGTARzEgaggi9jOJwg9i6PdOtiFNGoYl
 D3q7AB4seBLdxkb1LA47YsrMQmyxHPsrx9ViaRH2Bo4OhXrj6ntIGp5RU5ai3AzCQBeyRiHg/Tf
 zULfAbno++IPb2pizuaO1Ful12SBj1Ag7zadxZdztoU9Gy9FYTg+toqB3OzQ8lGJ311jNJzrhEY
 0sOcoRfg2uOIXXiLpxjPDX55I0PysxjA0H6PgmhpYVflz4trm8oGEbEX56yRZD2fFfvUqI+iADz
 m1Pen7G2eSc/HQzwb16/TOKWAuGAo6m/eyydcc8ZJs+E5oxShYK75WgHlVBd0aOcHSA9ahqoQ+S
 mvJ3VuLA/z3AEGu4ieVE8xyJH/nobhEutVI
X-Received: by 2002:a05:6830:2b1e:b0:7dc:e336:c828 with SMTP id
 46e09a7af769-7ebb22240d1mr1608942a34.10.1783376204556; 
 Mon, 06 Jul 2026 15:16:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb542936e6sm12484682a34.5.2026.07.06.15.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:16:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, ye.li@nxp.com, marek.vasut+renesas@mailbox.org, 
 vjardin@free.fr, aristo.chen@canonical.com
In-Reply-To: <aktk340Ug5-TVQY-@nxa18884-linux-1.ap.freescale.net>
References: <aktk340Ug5-TVQY-@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] please fsl-qoriq-next-2026-07-06 for next
Message-Id: <178337620329.1228797.5214526046028239114.b4-ty@konsulko.com>
Date: Mon, 06 Jul 2026 16:16:43 -0600
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

On Mon, 6 Jul 2026 16:18:39 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-next-2026-07-06
> 
> --------------------------------------------------------------------
> ls1028ardb: Move environment variables from header to .env file
> crypto: fsl: Hide CAAM_64BIT symbol behind FSL_CAAM dependency
> gpio: mpc8xxx: Add set_flags/get_flags ops
> power: domain: scmi: Allow failure in getting power domain attribute
> --------------------------------------------------------------------
> 
> [...]

Merged into u-boot/WIP/06Jul2026-next-ubp, thanks!

-- 
Tom


