Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D8FC982C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 22:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E566E839DF;
	Fri, 16 Jan 2026 23:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YyH0ZUb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 269078394E; Fri, 16 Jan 2026 23:22:39 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E0A6839DF
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 23:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45c7a71ba20so721356b6e.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768602156; x=1769206956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVPHRpII/HjEcdWGTX4gh2idql2Tv/BLW9pXFhT49AA=;
 b=YyH0ZUb5uNGnP+QuGls1NNH+559a/GRJvcPxK6L0hDG0Nk3xoSfFz8gyImok3sicfZ
 PzuBq35ucscVXWyr/TA/B7ALgvlisebpKHDCPT/UGaRkTy3YGmWeI1sz4ewe1+647ZYc
 4/MMWLdXjHFuJp/Gt4C37TkrfmTav1ef/1ySM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768602156; x=1769206956;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hVPHRpII/HjEcdWGTX4gh2idql2Tv/BLW9pXFhT49AA=;
 b=pzMpfREi6l9pGJXb50xb0LxFEpIzdQMOCaDawBAQDtZliatOoMy1dtsBslOeV23V1d
 /MpBdT4ONb+lMuHEo0mV8hdGQgeYnbju44mPA/+Vfd1ZRblGmJnVI84RqJby46JWbgFY
 Svqk7cQ5lK5PtsIsGiklTnLRKmoDFpwpvCDVXuFM8v7d20ThM9w78RLYm3R2icK448Uh
 7hblZYBHnEDKYHYuXPsY8DIn+M0JGNhokZ0x1bQ8r+U+I7cqd4DXBOBUqeFTZDlvfhBC
 93PpIkG6Tigk1xImX+m8CjbmWZOh4A8To4o2+gu8013bn4V7Sel8iCESUftoj33mZLk3
 wVxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3NTrNIaHeal+nlKmAW2nc0yDSraqHtCQTS15emqqtWzmO33b9hSqNG5+A4IZ6Hd2zz8l9Pws=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi+oFcm/GxNxc9VLx4M4AUlj/xMYtaoUXRdmZ5w06rbFMhA+RP
 n6AB8GozxvwDLonFtlsgs9u/ZfmcSQ1bDGySjlszUBIosNa6+Gxuj+vpAXGc9KFRSlU=
X-Gm-Gg: AY/fxX56cakhsUq03Cbp7jwzVs29Ngq3tcMP55a5jAlEUUAmSHRVnzcyoCjJZ0gRXFJ
 tqKScxDvwqVHkShQqrW5u61xnfDn2scSPCVGjAaraN5UTZTywfDZ8T0tFAVJPt8FknxMaFb9Vvx
 LGUYDqWQpAg8UDV6qXjb2pdz+lUaD547J/KWeALxmF07bGJqEV+P4dGY5BayaDYIriFU8WJEqQn
 MkL5Frp/kOK239ZLh6Q5wOBGuABZFmpz0KQKYL6gOuoEtVdrOr4aHImK8ZDeD50vfLUUI6PQuX7
 sQ9RorK2xiE1h3ZE+d94fv36B5ju+iQ05CvF+bRQDqt0xJhlq4JBOIF3x03xZ+BZDmEd+bPFPf3
 8CbOao4pUKoHw7KjNxNB9v/zDfLKVSYTi9yBYlPL4VcyPR6nARVYWnJfbWQQA93H2zNhpkULVAS
 TYpEK7pnS1DuhAL6ch0X6kZxtJ1HwRuQQ0/D018br24q6MfCR1a92/10gwv6VbepeyI4E7Iu8Sr
 UxTsrcmDG1pR81p0hD0ag+Y9cQUxJohDaNfIA==
X-Received: by 2002:a05:6808:350b:b0:44f:6e2a:ace with SMTP id
 5614622812f47-45c9c1beaa5mr1750956b6e.52.1768602155730; 
 Fri, 16 Jan 2026 14:22:35 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e08df1bsm1933917b6e.22.2026.01.16.14.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 14:22:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260107-mtk-mt8365-remove-empty-config-header-v1-1-f1c25b637fdc@baylibre.com>
References: <20260107-mtk-mt8365-remove-empty-config-header-v1-1-f1c25b637fdc@baylibre.com>
Subject: Re: [PATCH] configs: mt8365: remove empty header file
Message-Id: <176860215488.1279379.8223779153791021611.b4-ty@konsulko.com>
Date: Fri, 16 Jan 2026 16:22:34 -0600
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

On Wed, 07 Jan 2026 13:58:58 -0600, David Lechner wrote:

> Remove the empty include/configs/mt8365.h header file as it is not
> needed. The Kconfig entry that referenced it is also removed.
> 
> 

Applied to u-boot/master, thanks!

[1/1] configs: mt8365: remove empty header file
      commit: 8241bd6a82e181bbb3b7f4440a52205a40e2e617
-- 
Tom


