Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BF5E87840
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 14:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB62583015;
	Wed,  4 Feb 2026 15:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qAJmpl7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8596480086; Wed,  4 Feb 2026 15:01:53 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7299783A3D
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 15:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4043b909ed4so4328685fac.3
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 06:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770213710; x=1770818510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/NgOQV07BU6dke48HAGWojBJ4bE6ObYFSzs2Q0cC5k=;
 b=qAJmpl7kxNT3Jn7iDiQtS3gvY+EzLx87v5zOchHiLR5cckdUt3sAwmD7djE/z0q67O
 l0DDBXm4RGm3NY0TnhMsMSdJ64pP6a8MLGzOH0OT/mG0a5DRNs1pyfWkymZcaQG2ikLf
 c2a6mRHttpqYIIZGSMbmZAiU7zDjVpx9L8JK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770213710; x=1770818510;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a/NgOQV07BU6dke48HAGWojBJ4bE6ObYFSzs2Q0cC5k=;
 b=FyFXdg4wus1XVIGA8y75l9mEk9FYiQIIyeHJm53dY1fFSxz6cf1HTFOdiYkekNTGvK
 AGMG8gna6fp32J388pe5zcfNq7Z0by315nuZaAacud+Z7U5LJYqO+ojfognQx8FpdDUe
 q+x6D73sppyYymD2+KNvplXLuqekccZT9/+SXYGrGVOlN9vTK4QORQ+xMOUgXcaNlhsB
 205Juvfhc0wg/sduOOn0ZQYU99uNvTmZo7NHtMnnI1J+LMrfUD+k8Ez5hjZVLeufZzYg
 FHuI3Kdd1wC3wRvzj6d8I86ShSsqTgnUV7TCOmsjVHKdyfQt5kihO1lnKupxm3yab9rl
 eJFQ==
X-Gm-Message-State: AOJu0YxDqlNtJOTNIHDGidthdXk5TcLOR7xerw2tr6Lif1kWcDIEDiJy
 S/YgnUb06AJhFsliM/Crak1z8XsSONlAUcBajJu9Xmsw1P/7f289YbblkwoIYnFDS6Y=
X-Gm-Gg: AZuq6aKimXk+XtjQTBPLmIhc12EZVcbgoSUyWQjEyDMRZDjkLnDtf7eCxa5wfI6noS5
 YBZhy0urw/Vh8RmYIkhEy/fGUsMBJymT6RbI6STEvwJ6dQG+cHydx+QnTyxTnJaZLiFaa1DvqGy
 B+iv4cPJ2mresGg0e1oaHoJox+LgZd+7/wl1HOlzRHsuPEZwXDsHlu9ZTuMqFVwxWYrP2vt0FNL
 57QLKSmL/f9g0xtXloH7L0Tx7eHSjguoHxsV1okMGtmnWY9TIPLpt40eZQbrrzbAb2mfkiwKpZa
 FTXLBwqEFT122ocNP7Mm1Hy/Y7bCqQm3HWNmxbjKUADQFCz/7KLPY6kPYh3blz7Fj/R/f/n2sPQ
 PM14aylvdgdMGN7NcvkhLFpKUoO8WZ8K4Z75V6jtxvEDV+mdQ3yAwMKuoCFe9BpG1xm+RMudthR
 tW8kCLAAkZh41Yea3Qt0RVYnq8mPOVXJM6qXiayXCUJAzISUS+8r5Jwb+Eu9011u1zJX07Gcxno
 SZwopdaQbM2Gqqy/QFA2+JEFc89lvYCGJeY6A==
X-Received: by 2002:a05:6870:89a9:b0:409:5200:de38 with SMTP id
 586e51a60fabf-40a53c0f8b7mr1692464fac.24.1770213710058; 
 Wed, 04 Feb 2026 06:01:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a590fe5f7sm1369437fac.9.2026.02.04.06.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 06:01:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202-add-genio-700-board-v2-1-06d375b877e7@baylibre.com>
References: <20260202-add-genio-700-board-v2-1-06d375b877e7@baylibre.com>
Subject: Re: [PATCH v2] board: mediatek: add MT8390 EVK board support
Message-Id: <177021370810.1736867.14168114799025037743.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 08:01:48 -0600
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

On Mon, 02 Feb 2026 09:23:42 +0100, Julien Stephan wrote:

> This adds support for the MT8390 EVK board with the following
> features enabled/tested: Boot, UART, Watchdog and MMC.
> 
> MT8390 is based on MT8188.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: mediatek: add MT8390 EVK board support
      commit: ede7198a37019266bfc4a992bdd22292196a97f9
-- 
Tom


