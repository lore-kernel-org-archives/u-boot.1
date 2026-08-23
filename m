Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB44C5DF97
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F086660748;
	Sun, 23 Aug 2026 14:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpL-8ljMDVTT; Sun, 23 Aug 2026 14:57:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497078;
	bh=yD/LKSu5D1iabZT0/R26/II9dZ7GTNQ6IMvHRHtGVTE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m++A6kl/B9YdzmT803tuwfwa1vl6DgiW7PHXOIGxYQpyKgDJ3agXulHQVivUbp+Lm
	 wGErof8vSS17TslZoISi9pIogu0tKFSvmh84865HWGLt71kTQ9WnYNI+0Cc6u5bBGu
	 OGS1oSSOyaqQhOWq7CGoyX6PKDP3dRnf+8LMxQAwTgiAEc3FHKEnMQHiRQ3eDGAojq
	 ANSvHL6wkc9DWz5UP9hDoUeeZ9WgAZaySXkr1a+Jl7oqI5vxMFia4wSvjmC8P//oNz
	 6ZoMwVuq7NvGcvfE9J7arGY5xHC8A+UhrGUapjXEYreBcgom8mg/DpHKMURMUaEfWt
	 VaXUuTM8cTC3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1568606ED;
	Sun, 23 Aug 2026 14:57:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35E5E336
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 285544052A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7jL9w1obhuW for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=t23dqOEd
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B37240515
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:49 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso2075696a34.3
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497068; x=1788101868;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yD/LKSu5D1iabZT0/R26/II9dZ7GTNQ6IMvHRHtGVTE=;
 b=t23dqOEdp608cdOu3eQO/VUxGeo9PbgYevR+iualukRO2Q0SdF1jGiqqPcC4Jompr5
 X3ERQg/drQHoGckK3fN2gWCpM9VH0XS+N2ilN18raeqmGCYN08ujXwEeGiv52PvHmGXT
 RSC0YfosIObbfIrJSh9aXaMF0kkjXq1xy8BCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497068; x=1788101868;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yD/LKSu5D1iabZT0/R26/II9dZ7GTNQ6IMvHRHtGVTE=;
 b=TXTe/a17QtnID/QbFzrRkEanCAKvPkxpisNDOB/NcxnkiUPeFilstd9UMSf1AV4EKF
 O24OVw/nU9fSdiqAnp0uc/y3y4cKr1HnjFys6pKtBBuy3rcIwClSJWvREccotew9ZBoZ
 SsT+/XJbkCjT5xUNWG8JScnnwxqlsdCL87hJz2ctHzULP36AO49naWfHqJSqSUXQ7anu
 GmazsTcvjMMJdbRb94HDo+xSbw6eCFy0qSA567qxK+e5zZgmdw3DgFBRCitShIROYfzU
 j8yRv1V1PgCIJnZ5NfZF/Q1OOlf4ZWi1P/lMJZtKuumnFL8n8tpvDDAtY+4d2dRrX+8U
 BAeg==
X-Gm-Message-State: AFuF++mhS1NaoL13+nyw06kI7iP7V+zCIDMgef4BYSwRTFBt4m7voLm4
 EbsWwlq5Ty90+ZPYrZfcvabxYZ3Y7iZc+DAMuL01WiwGBb/JZKysd16H11v2JPEKMiULa1WDUgt
 +AaIFLSEAB018
X-Gm-Gg: AR+sD11BcAEwfCL5RIE6v+1EiK3CxRq+8YtTJoroBvsbVas+wWnPq34QSTbAntxzy1E
 TatN1NoEmbyIdePhpkKeP9MfoUbsYoYI57AKSpg6ayh1+saTX1GujjEdf15iNrUmDboYqe+Hted
 38BziC1niw4xYTkTvBl+8s9RV2scXKYLSNeSmH2e2XW9LCfFDIEvDm9yNRxYgTtQDNb0RufSepx
 6f76hCeUgea2RHw3VnfuuT6ox5J9NdwhjpC196jM79AHygz2v4J8waNnw7EQpTYuppa851dYPuC
 CZvxARAzi5fqO1AismkHXqU1SJOnW/PtkD8P8eBXZiE+MaYsFZBPBt41mkRDsJzWfWI4MKTnq8U
 ycIjv7k+lUvsyRUW5LSmedc9Yr/8miZtBjYZ36cZ6pceJanT3k+ycU7t2HtTuUQsEwO6FbjFtvP
 CWM69ua2l6Lei2b2YtushH+W10jy/XVcy+xl11a4ZOiOFviDoqwi1BsONKO6GuK1A4OXMo/ZSOf
 FVx3TfpoqiqVi/g0CwFpXUtpvVY3b8kYEusuRoOstA4Q4qn/ZpIe7CJPsi6oK9YGKysusyWbZpF
 aBkdt7bX
X-Received: by 2002:a05:6830:6a95:b0:7ee:19dc:b00 with SMTP id
 46e09a7af769-7f461420fddmr23958887a34.3.1787497068222; 
 Sun, 23 Aug 2026 07:57:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc89283sm2028583a34.24.2026.08.23.07.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 07:57:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <20260808214559.98133-1-marek.vasut+renesas@mailbox.org>
References: <20260808214559.98133-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] doc: ti: k3: Fix pseudo DTS syntax
Message-Id: <178749706755.206448.12286392889972971183.b4-ty@konsulko.com>
Date: Sun, 23 Aug 2026 08:57:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sat, 08 Aug 2026 23:45:36 +0200, Marek Vasut via U-Boot wrote:

> The code block does not use valid DTS syntax, but rather a pseudo
> DTS syntax. Sphinx complains about this, so fix the syntax.
> 
> "
> doc/board/ti/k3.rst:467: WARNING: Lexing literal_block '/dts-v1/;...};'
> as "dts" resulted in an error at token: 'i'. Retrying in relaxed mode.
> [misc.highlighting_failure]
> "
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] doc: ti: k3: Fix pseudo DTS syntax
      commit: a24415ab6761f3c24566f0ef0e96c0577b00310a
-- 
Tom


