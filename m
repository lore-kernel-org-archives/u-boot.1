Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49DAC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F9883123;
	Tue, 15 Jul 2025 01:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U09lQ2mA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D4A083020; Tue, 15 Jul 2025 01:12:12 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5011882B07
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so2816843fac.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534729; x=1753139529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHzm1Q/URnIt349h51NfzJzPAt6fG1c2FMW9LZAM30U=;
 b=U09lQ2mAE/a9hentyFKh3jOf8UmzyRgJl2mHgMoaZ3Ucbfu+UzkVxXIU+Ojkxs3LUY
 J5qP6PGF7FYadr5MZF55FDWue8PM3bsDox80T1wa/V/M6Z/nhjzPZ6meEw4fIBZMQwH1
 UcXRrG6qZsaR7AeSA6Rbt4dZ/721TObyuCSmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534729; x=1753139529;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHzm1Q/URnIt349h51NfzJzPAt6fG1c2FMW9LZAM30U=;
 b=hs433vow5I2M+wdu/ArjUHLXQVfjjoZ5+WjaaqXDNrIsF71/nrCU4AqwqlTl+vu24B
 6d42YfaK+4WXubgCkibP2pDTe9io+weBXgEQOTNR0esqnd2OVGZUrQacyxp6IVzy7Yqe
 6XLY5XUQ+Q18Ox/79SpAREMIyL210DZSCSPh3YeLiRFfllQhRC6a/heBTtl6nyLY9Wgh
 byKbl0fKB2ok98p/LiAzUt6S1I5ozJDwALLiu+vib4sb6tGI8edY5/ebN0lC8lsD1kcI
 kxW88ndZyMbDAAUP+KfgjAg5j+i3gjz2i05cZAnlPq0S/qPxHeSsqG2wIiEWwis2bWJj
 zIKA==
X-Gm-Message-State: AOJu0Yw3fjmZDz1ZtL+l4W4o3xtPByenGi+3GFf1PBK398XLBvGvTxYb
 JtZwz+ruU27CeQVY4FreQBaJsav1cB+FRl6WBWQ52B5Sm38LIWtvMG05T4mA58Godyfqg/HQ5OW
 bP3xkOGk=
X-Gm-Gg: ASbGncu/LBC22SV011UxXQuvJb587iGfX/79Db1EqGXJ1K5Hx4KJCQAVL2aY0HoYPtt
 yR6BIQj2DVAbEKVqzhAX8EoGHc+c3Q89479PyBKPkSD+/tdDuRnqBDknQZFN3PEBZBlzgCTpFoI
 LBsWUSLr6Erzno/pLBzssRrrCR86LJh58FJY4hk6y+5SKxsSSuc7hrJgXq6wKs/G0RprKFSq78v
 DHosEW2CxXnDgtOiKAfsmTPlqk38pp/sKSeLT/XY91w8YE1S7PlhSxTE+JgvckjcTIjmzK2Mt8b
 JoFM+Z1ewFvM2j+VFWHA3VOxO9PqRB2L6sUZcw6ep06SI3kNPEyfaGC5nNnqotMzyNL/Lao5GOG
 u7U+5uFtDMYSQxx0wKUUVKSj0xUr2tu2EdwjkPA3PSg1+MfQuab5pP4Y=
X-Google-Smtp-Source: AGHT+IFAnXv2DXnzV9myPx9Qm+adChVhNiyYTferthqb0bThSiwd6iIiuZALZ2WO6gx6sAVGJqf0Nw==
X-Received: by 2002:a05:687c:2c07:b0:2ff:8c8e:c222 with SMTP id
 586e51a60fabf-2ff8c8ede5emr1741115fac.14.1752534728667; 
 Mon, 14 Jul 2025 16:12:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250707-pci_fix-v1-1-42ae0de98a0c@linaro.org>
References: <20250707-pci_fix-v1-1-42ae0de98a0c@linaro.org>
Subject: Re: [PATCH] pci: Assign a default value on reads on error
Message-Id: <175253472769.280771.7550377576665457885.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:07 -0600
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

On Mon, 07 Jul 2025 17:26:53 +0100, Andrew Goodbody wrote:

> Many callers of PCI read functions do not check the return value for
> error before using the variable that should contain the value read were
> there not to be an error. However in the error case this variable is
> never assigned to and so will contain uninitialised data.
> To provide some certainty as to behaviour in the error case assign a
> default value of all bits set.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pci: Assign a default value on reads on error
      commit: 22039ef94a8f6e7f4fc04648dc5a0ee857927be3
-- 
Tom


