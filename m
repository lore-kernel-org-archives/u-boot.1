Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAC7E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2B083B49;
	Sun, 28 Dec 2025 16:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I3vOr4k0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740A083B49; Sun, 28 Dec 2025 16:18:42 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9355D8392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so9707492a12.1
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766935120; x=1767539920;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96Pe9XTziKdriL/iViOJmH2mbU3yaBxdPnFiGyXwxD4=;
 b=I3vOr4k0IY4yiJoKXS9XHjdKb1zw8vtLgEC+k2UY7ofzKbrYrc6Yj/NpMzeN/w6q12
 pZzwPjyQm3O0jI3ZhFVgVcbEfOP4tBlLOKDFfyxB2HVVbQTQlj3Of5svLkfolu2xoLo0
 GTlurKALgixLhqltqCRi7aIROxEuYU6QwUsLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766935120; x=1767539920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=96Pe9XTziKdriL/iViOJmH2mbU3yaBxdPnFiGyXwxD4=;
 b=jooPkYEWIroHhXKmfUCMWriWJUK+NTOlzAXdYAE13912z5PdCN42plVtldjLq4HUtz
 gRMdgJvuNFFHAVGFV6oufmvs/OXF7lopRFC2S3/s1VS/bFDFY46WnIi4ArJRR2FE2/m2
 5KQhiApHIqoBCAh74vOslIP5UNXv/S+vEFIoqaovzT/td72boHorqnl3bUJ3ebbTSqct
 7We0n7jHbe0oNYLC1pHNcmkgXdxNR4Ml9bNlbYE0ZOq2rCormloqoxBcHCmhSUvIqbB/
 yirjAiyHGu/rsEpOnedMI2YqUgxk40oheBdwgRqlGuhD+47+h/vd2nX0yLqO5J6cE1Eb
 WxeA==
X-Gm-Message-State: AOJu0YzjUMFBdvk2XUjRVKJuFO2JEXYnbkbLKkJLgZfT22soThDjB6kT
 8h/v6FfEUrXcL3LkDOvbrwx8X44nB/gILeLcNPispZ6+SqDkmUA4OErBhd3T+piLqllVQadG+Dr
 JzUtb
X-Gm-Gg: AY/fxX4wBNWt8O1lNTkYIf6l4bdTr0HrwJJvXxpZaAbySLPpLNpUoC2EY8INfOG+zMi
 gA1GfmjLBw2VUVGiRhScfLrsk0glWWAIkmTNvjT7MD5svBf499JPWABhXr16V8s7ISQZ5n8tbrS
 bZzd8zjPz6KvLNQ9xosZB5DlIuggXbPkL0wD5GAyZVvyvx2vgcCOhv+VtPXJvzLS460v6n8TzxL
 zErhhgdXGSmL1kQWqFw4dwA2PorwZPYIEB3MhQo81uX5IuufSdqLfoYOtjV2KtUhcgEzxV79khr
 Rnnk34UVbwbpDGOCHywQxe5fmRzmZvRaDp66P0AVq52bYL5aDns3JKe2ogClGWrqoVI0r4/2KcF
 NgTzuJwQkWMRfP1gyZTROBo2Opgi+bNxKKEePZlBqedP0FHwplkJezOCry6bsKGMdkWMiXfAt1u
 PIghwGu93DurL8KQJvLS3PFJwgAcQ33ol24THuO4UwOBv459p9kGX6XgDuPAEFj49V9hXYngniB
 o+uvRewBrw62LD1LVspLuHJuLL4I4m0LVW6t4SV+W+E71X8fX3S2CfWyVbLWsNtG4sG3HYgJZws
 3Z/0gjR0Qwk=
X-Google-Smtp-Source: AGHT+IEX2rkmDk/jNyXR+ch2N+CXYggLFJE4xtgqAztFNByXBfsQ5E+kRKCigjWIDqKXr11f7w/A6Q==
X-Received: by 2002:a05:6402:2342:b0:64b:73d5:e2b5 with SMTP id
 4fb4d7f45d1cf-64b8f022663mr26255850a12.34.1766935119813; 
 Sun, 28 Dec 2025 07:18:39 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91494cd7sm28502224a12.16.2025.12.28.07.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:18:38 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] tools: build dumpfwumdata with tools-only_defconfig
Date: Sun, 28 Dec 2025 16:17:55 +0100
Message-ID: <20251228151824.25667-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Always build dumpfwumdata when using tools-only_defconfig.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 configs/tools-only_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index bdc646e29b32..bbcb64879fac 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -41,3 +41,4 @@ CONFIG_VIRTIO_SANDBOX=n
 CONFIG_GENERATE_ACPI_TABLE=n
 CONFIG_TOOLS_MKEFICAPSULE=y
 CONFIG_TOOLS_MKFWUMDATA=y
+CONFIG_TOOLS_DUMPFWUMDATA=y
-- 
2.43.0

