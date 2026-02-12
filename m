Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79234EEA847
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 18:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0046983AAB;
	Thu, 12 Feb 2026 19:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fAlSvBca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA67883CBD; Thu, 12 Feb 2026 19:17:25 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF03F83A47
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 19:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-45c889aba0dso1543543b6e.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770920242; x=1771525042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1fk+8LfjzSsI9HE+MDeaF6T24Uo80B6t7Ym0RE2Sts=;
 b=fAlSvBcanMCRcTPYYu0xBRFvNaAQkqBGz4YGiNdLPb84c8WgwleeAx9S7Jcg8VMyHO
 f6WdRCDLa7FcvG1Bewg+Mt4eXh3piJebwNk41fGW627FBV2HeSE0bVMnv7zxVKgLXzhe
 CpBeRkE+BvXYxadSu6BgnClP950uWsuEuhxD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770920242; x=1771525042;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1fk+8LfjzSsI9HE+MDeaF6T24Uo80B6t7Ym0RE2Sts=;
 b=HMSIIDL2VwZ+uVwi3G00F53hac79OZ65ZbUkF5FWDRh5jFTZzYnSoIN7Aa7/fON6KV
 1rv3qsYJUg/ZTfccnHcJd5rlqt1NHanjGD2zvrWnqmq2Hz/d3pd2FDtl1yhmLjmEgE85
 qrBxtirnEcEGD4N0oY0tRRDBBS+LJFiE8+/JwyxznEJS/Va8NhyVxy0N2SEXeSp4Uj0v
 dzntN46S4f/MXtDyAGkJkQQZuLRKu5gCAAfpdZy0q6scY07Edx9jU3j/9XgWjz2h11pO
 NhXoaAczpRyjCs1Q7TArssvAtd+UvJIB38Er8e/V1rRwrZdhW7hjioEe8GuU/UCEDwOO
 P3uA==
X-Gm-Message-State: AOJu0YwlXXjy/m3sUbCAN9vEoWfI46+9PP9ipswLOHwGIX2GXThXg72H
 70hVDU6v4zK6lOQAf4Rnalx6MjR1J9n5LPaPr1icEQp0RTbERH8mV8xPKWaEc1DpQ4bahvXc4h2
 GRHpJqI8=
X-Gm-Gg: AZuq6aJJJqke5HHsGKOAzRORwsASjKMU1/23VvQWC/+SM5SRiClRytLFCAi4Z0ntmza
 MeYjvOCwLzHfM14caG7fP3zIRwu7V1vNAkwYAJoBH4bm1SMJcYB5iFylnS6xiYCMrW4eDm7EAvn
 nfsxOvgjIhqATCTL07XriuAzhvBmxMhuVmbx8wH6mJ7OGsXD0HUs9xmFTos18ljrzEg1ZBkDvAl
 qqBYMPO/yGTnBa6p52gFOcdYEoDqjAb51ByjsGN/QbgJA9VnfimyLIdVCwGdAQW2m0bxSNloRdT
 hA0MUfXXbowN8AFv/s7pcCaCY6rlt1I4em9vE19KcxdgOG1XFbFRgZpv8Z8Sd1Wl+JvsnbaAOcJ
 fhMGdlAcy2/wrYHqsu0c2bR1vCknxUflzvlx3Ql/WioSbTxr2z/LYg/fpJzrj2c4OeecOBRrZ8N
 wgG8gdwb0HJPxUJfcs0btlKHqt4QewQ9MPq+S7jMMlzgLp0E/Qroni/JuAgiI+xREPcE7Gfkzfo
 3gN+rlElVealtarIWQyrNMxLaA12iZFLUnhetc8oflmfxoX5A==
X-Received: by 2002:a05:6808:4f14:b0:45f:c09:dd6d with SMTP id
 5614622812f47-4637daa7ce4mr1702944b6e.8.1770920242418; 
 Thu, 12 Feb 2026 10:17:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a754b162sm4057894a34.12.2026.02.12.10.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 10:17:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Suhaas Joshi <s-joshi@ti.com>
Cc: vigneshr@ti.com, n-francis@ti.com, s-tripathi1@ti.com, 
 k-malarvizhi@ti.com, kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de, 
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com
In-Reply-To: <20260212102847.1560553-1-s-joshi@ti.com>
References: <20260212102847.1560553-1-s-joshi@ti.com>
Subject: Re: [PATCH v2 0/1] Fix regression caused in Verdin boards by
 42b3ee7fa524
Message-Id: <177092024143.2032731.4130520393491981541.b4-ty@konsulko.com>
Date: Thu, 12 Feb 2026 12:17:21 -0600
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

On Thu, 12 Feb 2026 15:58:46 +0530, Suhaas Joshi wrote:

> Recently, I made a patch series [0] that added firewall configurations to protect ATF and OPTEE
> memory regions in K3 boards. This was merged. Francesco reported [1] that this series broke boot in
> Verdin boards. This issue occurs only in Verdin boards, and not in other K3 boards, due to
> `dram_init()` invoking `get_ram_size()` even at the A53 stage.
> 
> This patch fixes this issue.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: toradex: Make A53 get RAM size from DT in K3 boards
      commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
-- 
Tom


