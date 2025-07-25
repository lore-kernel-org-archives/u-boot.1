Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AC1C87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 16:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6DB6839BE;
	Fri, 25 Jul 2025 18:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CtZJTsEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0DE839CC; Fri, 25 Jul 2025 18:31:35 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA00383977
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 18:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4240b693522so1020314b6e.2
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 09:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753461091; x=1754065891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X7XpRc7n/tiCzBNP3x0BNtEjtBim/a4F2qsT5IW/wmQ=;
 b=CtZJTsEQLL5w/XZYfsJf33o/G6oVPKGLl/bA2W105gmjyFObP98QoMXm5d0+c33qbJ
 URikAQwPvIEGa1oAwZ73CM+I/wsrCkny+BkePgALZAzaEq+hu9mTa6RoaNNa8Bv9CKnS
 aK2VPHElpkCYm0ai98StnooZ0V6J63aOb3ffM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753461091; x=1754065891;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X7XpRc7n/tiCzBNP3x0BNtEjtBim/a4F2qsT5IW/wmQ=;
 b=CJSvzvJArvXuYR/b+y8xPoPa/eKFnPs7Hf3nvDckyIoi7MjXt7p3VEuazPBlquvn3M
 Ef3l/yrdnOuzG3cphodtOSKU5WI0m/mUlo9v9pCbKI9atG3BrwEqjvbPf8VSEHO3wasS
 Ng+rrY+p77TESrGxigzo3GtXlOhrJBZLeiD10fFamOcKKnDtBVbD52aQSOaMgWUqGJ1U
 qctr20ISMHGsS7xIJR6ewd4VGNv52DCD4el6RyrBoRORdkizMuPJXqsyWqx7jotZjiNq
 3Mc2zjaPStzsFac2M9cOoo0ITOEx1ftqnQrAPhZLD+Sj7Vb1ef6PI3L7dgEwIKdWlSdb
 UA4w==
X-Gm-Message-State: AOJu0YyoD/2oN7NVreSG0T/xIzXGq9sEXuqphWPFOvpEi4X5aKEppb3o
 7fHY56+4bCMolrSV+b5Vk3gvhpbNpLgGntz754GgDPVUg/Z4amG/tCfAlmsjo5m3wWHklraT9AE
 AoBP1s9Y=
X-Gm-Gg: ASbGncvYkdsoL1d13fgAO5V/+zQRMnLSTJRQkb0SdlJh/pNcy7jO3kwfxI4cZcTQDFc
 2Jfb7qEQbjOAJ6Q2p9BA8nnlMvJUQFO2vNXA9VTGRj+14gXpK5V36lMlulIzBxJZiOFScaWvtOZ
 m4cmrAAnPcCHiuzmm+3ue0KyQxiB7bzQYSbVddc8mmlGBrG8D4aGwISJ1b/69GORmShR/iMP6Ej
 jg3ds0N7DPpMvWxiLG7vpeRHgzG3WTBHm62oZeKKvPaIQsM9UUe07ZULJ2tRt4UBXzHiil4C/nx
 nFTQUf6C1j7Zu2vtgCfh8ot8OT51DwdzLt7PAmjUONDoCYzG7McT5Yq1cUocssn53Pn/SqY6Yhm
 xGiMOd5x4PGpjva9lWv14MxGBhi3WgWD1rhMqFqT/0sT6L+KJK4J1SvA=
X-Google-Smtp-Source: AGHT+IEAJ4W6dkt+UneRnQLVgtyiU0mAOETXOwbVt/FVvSb/27qRvtSAdXB3/43Qiyt9acpkS/VatQ==
X-Received: by 2002:a05:6808:d47:b0:41e:11e1:a855 with SMTP id
 5614622812f47-42bb9916421mr1511813b6e.19.1753461091381; 
 Fri, 25 Jul 2025 09:31:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-42c7d8ba8dbsm5675b6e.29.2025.07.25.09.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 09:31:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Minkyu Kang <mk7.kang@samsung.com>
In-Reply-To: <0c5201dbfd36$189bda10$49d38e30$@samsung.com>
References: <CGME20250725073112epcas1p364a18714ffddd807ea6c1fd1b8b373bd@epcas1p3.samsung.com>
 <0c5201dbfd36$189bda10$49d38e30$@samsung.com>
Subject: Re: Please pull u-boot-samsung master
Message-Id: <175346109045.2110707.17968158622004895852.b4-ty@konsulko.com>
Date: Fri, 25 Jul 2025 10:31:30 -0600
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

On Fri, 25 Jul 2025 16:31:11 +0900, Minkyu Kang wrote:

> The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:
> 
>   block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-samsung.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


