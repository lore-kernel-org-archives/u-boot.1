Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004A1D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 18:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 766F783AC5;
	Mon,  8 Dec 2025 19:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YGIO0aD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D8AD83AC5; Mon,  8 Dec 2025 19:54:56 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB65F838FA
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 19:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c75387bb27so2081937a34.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 10:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765220092; x=1765824892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoNEORruWlvP+vWRMkVq0z7E4+zgmewMnprjCWDpptU=;
 b=YGIO0aD+rj4sfPbVzgcPuVa8ZYgioZPe2zSG/wy/QYCLxF5JhRpzkTCqHcuB07j7lY
 3Iz+xCqzxOLcXYP9JHgqA0jmKHrQ/zz4lFu7Unj9uzxkyv3TmyuT1kLs5Wft25KmBz8O
 WTMfojAWIv+pYNT8uSDqxnWSypZptucJqRG4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765220092; x=1765824892;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZoNEORruWlvP+vWRMkVq0z7E4+zgmewMnprjCWDpptU=;
 b=ZhmahTlJrOXvf9QabDC3tiGCa3UeIt8d1HGNxCqQ/hIZEbpTkNcEDpKoXIXYeKgtgz
 tbF/CBz9GayD9bpIuBMaKcX0H/J3Bm6aTHbxRid9yD9Va5bddPMleVl43hWs4Tc/PZC2
 0KhUBdXRgWPWubjq1fzKlcQU0166LyLNlJW1efIizP+AydDVsnqayM18tw/pG8NadC1G
 ZzkG0nQWuTSKgC8ZISZEBnlMnVD/ZgTYFJ7N3Y1dgRdKZ8uIJuthIQdia458AI+2h8MP
 5f3YJUAn1NxkiNEl0nwfvqedpxhFxIWlfVfWFziXwUY8IT7UsW3TE1JcCN606PbEZplb
 bBpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ9csdv3pBecQ54UBIX/5CZI4Qg5j+9xz9IHgOv3YQXJBWT9gxIftLU4RZ6wfpQUzx0Rtt82I=@lists.denx.de
X-Gm-Message-State: AOJu0YyEuqfSN1Jjbk6lWlGf1YnEKuHX2XoT8eT49QjTwv0H4jvKmruf
 0ZFwOcTUAnNZqtYgSE+bvTfkd0ROzOsxpGp4Udy3wkoAR7Hmwo2d8AH3qbfWafgJz7L7a+Sx7W2
 6aA29mnI=
X-Gm-Gg: ASbGncuVXAGtlK6ni5UAmCEmbhbbLq1obV5qiCQfkyhqHDug4xuttjAg5uTuc+T4yDY
 UYFSqI5veS7EzDGz2iMwVU3w/lHO3O3G45YZl4Cdn1ZEbPXEldkQcWLg4cany5JLwN5WvCCAT9l
 T9R5Azc7g+W/YSdJ/iXkLYHUkcLJfmmgm/RTj0pRNwcqmbBXGbOOf4D6u/775Kf5Awh8/NFW+X4
 gD5UEn3SiIF0WNHiryfQxIO0l9WfZv46tJ3CFT+zITGXw3xG0oqlzoaoW+Ds6ppg/xYNuQQzc+T
 Ns8PcCpZM0KGE1m1Hx0XsltMFwlhKY27DPPDcp/dNnfSsBM9uB+61gg+UMRWhdTOlihvhwAes1t
 geNOvwZ6BjlF01G+0aCajAwkwhKkIp04KLeMLnfC0Rj6jOZKgzqQKrF22ZQQQQCx2HpsuKrq/H1
 +4Jq1Nkgz8jvCUKMdQ7jpTXC77QoiEYtU2MUTDrcGbFCgSAL5t
X-Google-Smtp-Source: AGHT+IFH8h8HkF1bV8nCX2EQ0Qdd6nce5m5WOoo8rCut3wkDEGQn4/Xm8jmY6o22ZGx0JxSD3XDXiQ==
X-Received: by 2002:a05:6830:264a:b0:7c7:68d8:f711 with SMTP id
 46e09a7af769-7c97081192emr4427692a34.18.1765220092637; 
 Mon, 08 Dec 2025 10:54:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a91eecbsm10890864a34.11.2025.12.08.10.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 10:54:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>, Dominik Haller <d.haller@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
In-Reply-To: <20251120212619.41062-1-d.haller@phytec.de>
References: <20251120212619.41062-1-d.haller@phytec.de>
Subject: Re: [PATCH] configs: phycore_am64x_a53_defconfig: Drop eMMC HS400 mode
Message-Id: <176522009188.376851.9119461173030493364.b4-ty@konsulko.com>
Date: Mon, 08 Dec 2025 12:54:51 -0600
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

On Thu, 20 Nov 2025 13:26:17 -0800, Dominik Haller wrote:

> Remove the unsupported MMC_HS400 mode and select MMC_HS200 instead to avoid
> confusion.
> 
> 

Applied to u-boot/master, thanks!

[1/1] configs: phycore_am64x_a53_defconfig: Drop eMMC HS400 mode
      commit: d3291d35b605552e1ad0117a2c396fe90011358e
-- 
Tom


