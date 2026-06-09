Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4E3CD8CB9
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A57E84994;
	Tue,  9 Jun 2026 21:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hj5q13RS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C9D8496E; Tue,  9 Jun 2026 21:17:56 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C838496E
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6fa36a1b6so3982764a34.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781032673; x=1781637473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zgl0Jz5/7SPN4s6ap9ypEIftyf+Tdxv+QAxp6A8k8ko=;
 b=Hj5q13RSsSVNc/7zonaLiPkfHaI+sQpX4gkgaNo9Ugt5Z70UzyA04M/mZPOZjxrMjf
 8iMcPIxysGr18Zlh5++Ia79DsEkhugcPZgQ8O914STfWTZWQCuVTFz16wzxl9BrsUatH
 4QjiAzDZCiDRUnS4FtfZWamy2vE96WMNf5n6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032673; x=1781637473;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zgl0Jz5/7SPN4s6ap9ypEIftyf+Tdxv+QAxp6A8k8ko=;
 b=PH1uK2JGKgfATcPq7aMoasCVOu+s/WQqaRCNoQv+29rwyck6dtY945M3TR0VHuJPfZ
 v1hq18JV3Nl5QHKfwZTqNvHS0ycjR6kJvdHNkF0nQC16qEoCekyX6cMTnHHnV1NU7j0e
 HPpv87Lo3siQ0LGcgL9QHhlJFYs3xTRJzGaHFbnFbWg9ydXt66uG6yYvxvs215fRYiLP
 svOqQXCJeuMMjrhwjxUo5kvgz04LoHMur6S3JUiafCQF9jcb8uBV86hgaERCmffWk3Ez
 dmnrBVhqybyDpdUsVn3rEqYCG0ak/KDFtSjtGCHkE2eIQLWmklqREe8YjChimzXzfRrz
 wZDA==
X-Gm-Message-State: AOJu0YzM0aH1DIa0GuED3JUc9nvx8OL5Y8pB15dCjzozNbz4SvoNemaj
 xD18r5qYOb9u9zf8RrTKEKAO0woFZw/+gLsugLnEdNFGj/xeBt2T4mad6xiC3U4apDE=
X-Gm-Gg: Acq92OH4xIpniRReD8TCROD9D9p2U+p/I+YfBFg2T+LSvdQyv60ULDYEzPtku4EHUhJ
 Owxw3lR4dKKdmMhhKjPmzF//XCNtCN/ZHbAN7MNPcb+XnkJiqOLo5/n9wIrr6wURX9PwDpglLGS
 SZs00MTp+ngG35dF0pbP94Xwi4p2JQVp7r8xLceKRZk4hpGIdKwseOaBHlVQpKCwZj26vNRtA7U
 DFB3JKnkdJt1oli8+8zw6w5caOhiBA+bSStN6MPsCH3B4LZwDmE5l5olbIhJH7whkfY18dNY5D+
 ys5FoJN9IOyJC12vAxyLikNPCtusn0ZIap7WCAcBsuUAOZCBn5UXdf1vYSPg9uQiyJZdaEGvdkI
 CBRNFD2hQV6PEJZ+ZtCswXgTeybM34g2Gzgv46sIq8EhwB8wT+Rl/4cC7Cl4w4YbTEUpkKZxnDL
 Vu24Jm+KiS/sqWeRmUmoQn9cLGWV8eUf3psfJeKyuw6QCRpfoX0dHWbvT1UqtO+fgRMzyhI+6vJ
 IVsir6wMnbhp4e/v/I+y7rILK4kvuFjbrDo2kJjwOlW5HpodxYBlPVdPQ+C
X-Received: by 2002:a05:6820:1389:b0:67d:e505:cf57 with SMTP id
 006d021491bc7-69e68caedc0mr11905986eaf.50.1781032672991; 
 Tue, 09 Jun 2026 12:17:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46405105sm11198449eaf.10.2026.06.09.12.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:17:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Francesco Valla <francesco@valla.it>
In-Reply-To: <d29a93b8-c30e-45c7-a3c3-3875f0081a7c@gmx.de>
References: <d29a93b8-c30e-45c7-a3c3-3875f0081a7c@gmx.de>
Subject: Re: Pull request efi-2026-07-rc5
Message-Id: <178103267199.3800924.12238539005930973002.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 13:17:51 -0600
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

On Tue, 9 Jun 2026 07:52:12 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 75daa277941702bf58c88d65c0cb6ed962899d9e:
> 
>    Merge tag 'u-boot-imx-master-20260604' of
> https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2026-06-04 18:56:57
> -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


