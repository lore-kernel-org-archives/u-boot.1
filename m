Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8B2CAC597
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 00:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 086E9832AD;
	Fri, 19 Sep 2025 02:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t1+o2mS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0338329B; Fri, 19 Sep 2025 02:12:30 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8C38329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 02:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-751415c488cso1484537a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758240746; x=1758845546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQsIwjVGyCgGh3gCz+2chnkwXu8CyUum9auvz7loEuc=;
 b=t1+o2mS+ubwU3nicwhghM08uhiNGVsjF3/4jjOr+BolOZdyA+2FJZz7hmFrAgNz0Cj
 WO4PmG+EdJS9THEtXDw+rutEqxEvvuIrbYORjotZxLgb2xZJ/aCFrTF1q2oGQ1tNfDw5
 DzM2cWyp7dGGO2ZdMv5ZvjBZykMwJVQBZQmqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758240746; x=1758845546;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQsIwjVGyCgGh3gCz+2chnkwXu8CyUum9auvz7loEuc=;
 b=IeQU3ipG/0FG7mlIsbf3fXIe3pRXFJ0OBGwBn++En5VwRGkyDvAGcwYf2HgYUGBppb
 xC9kPQaQllMDpx+IXmrNTNZ1rnTINvO4G7aQGWRwukXESorjy7TxRGDQ4t6iGKqKv4Ua
 s6VGzIH9rcQsfvw5LaM3RCCe2TjEr1D5XD+SFRArmRQb3JFhnoQDVVj5jiXGIlFZSaGn
 pdms0NwkrQh6WDRRrWSSJpN1VH8DlQ5Kzcks6nTunbuCVlwLF5zuebBXARP0OaA+v7sl
 3sMEqbylvNQKMaLlpnQS2UjxnWurJNdK3BStF+g6XNqIjuRqo4C8n7xmSQtGOJ3zm9CQ
 Sftg==
X-Gm-Message-State: AOJu0Yy9xxtN9y+d3wedHXsZGsJbFpUe2IYdmmJiYeByGhUK0x6hdBkf
 K5ZtuYhWd5QdMI7WZuW2I5hWtdRz3hdouc95TwcqaZCkheb2H/nlV/7j5ybhLu5L5wI=
X-Gm-Gg: ASbGncsoJaM96g6cJNWs39vMnneAB7hePVzN25wOiXEgWHetT6/yDWp2nFxXOxSShX0
 qa4wIe4D3qzzHRe4MnBFH1lt4y/9SstpW05eplhJRPDFKlOPwma1tX5OoDJFfLj35B1oLdVPuIc
 zaCo3gOA2rOEteNMiCWZirb9KOqM76YuhenbmfsVcgQdMhaPkLfcGaL2Y5jXroLYAS2tKyJh9pV
 g7ihULLMdyChuOGoLNaMx+LdIV4xc19GL6Sq3vQVzD4UDg2HYbb3xDUUybVIh1oJIVoVprYjkU8
 WJBZD8yHVpBSUxfyZXIUXRuQgKx8aRZvZmsSyWb21Ilgu54ZU0XqEk+lTragFmuC+KVIJ3zNT1c
 WyTg3RCmDTuY/1EMBwlZugzk7fKR1IlgucvIM5e1PuW9+NwjezeBEPlxPjVt+te6VJzwl0Z9ztQ
 ==
X-Google-Smtp-Source: AGHT+IG4wEwS+fuYydi7XdSXxzJNUqtvQn4xi522Yw5ChApl+oWjAWc9M9PaXDPTvx71uKGq3uhyyA==
X-Received: by 2002:a05:6830:3913:b0:757:7d79:bd9c with SMTP id
 46e09a7af769-76f79079584mr989100a34.25.1758240746576; 
 Thu, 18 Sep 2025 17:12:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7691b0244d7sm1694728a34.15.2025.09.18.17.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 17:12:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <cover.1757315849.git.weijie.gao@mediatek.com>
References: <cover.1757315849.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH v4 0/5] Add support for MediaTek MT7987/MT7988 built-in
 2.5Gb ethernet PHY (v4)
Message-Id: <175824074567.975344.2778312909667402144.b4-ty@konsulko.com>
Date: Thu, 18 Sep 2025 18:12:25 -0600
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

On Mon, 08 Sep 2025 16:33:57 +0800, Weijie Gao wrote:

> This patch adds PHY driver for MediaTek MT7987/MT7988 built-in 2.5Gb
> ethernet PHY.
> 
> Changes in v4:
> Remove unneeded const from argv[0] used for cmd_process()
> 
> Changes in v3:
> 1. Removed all optional code configured by dt properties
> 2. Make use of request_firmware_into_buf_via_script() for firmware loading
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] misc: fs_loader: allow returning actual firmware data size in request_firmware_into_buf_via_script()
      commit: 63585689686fee83b382edacad249a4ec35d7c3d
[2/5] misc: fs_loader: allow using long script name in request_firmware_into_buf_via_script()
      commit: 5b1d3d83d68a713c492bfad991338d47069f337e
[3/5] net: mediatek: associate PHY device with dts node specified by phy-handle
      commit: 465d76a0381dae83942f81329400b1fa2487185a
[4/5] net: phy: Add MediaTek built-in 2.5Gb ethernet PHY driver
      commit: b4b266fc139ad0a8856db6a7495f7e9a2cc27a6f
[5/5] MAINTAINERS: update ethernet-related file list for MediaTek ARM platform
      commit: 32b4c88ff2712ffafec875e22d866537d2f33dac
-- 
Tom


