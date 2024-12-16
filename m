Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EBCE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 23:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18B780141;
	Tue, 17 Dec 2024 00:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WFVaRS8w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B275801A0; Tue, 17 Dec 2024 00:39:22 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B57F800D7
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 00:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a8f1c97ef1so14181555ab.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734392357; x=1734997157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RdlxZsXRzcdde86YNA7SLax3dWgmBKG3GZt2XtrmCz4=;
 b=WFVaRS8wN0YjUwhG0Nwl5cr0AU3VwVu/T4/VFe3YWjyi0JoggSFFx0tckeBy+wv+6K
 Y6D8hrXq9Fau0PHCJw8CxtIZqF+gdwxCcazKx6Z1njsYZvouuk7wrZLTUGuMFYbTCZpH
 17iYR34FSB5fYonumjKPCYLYmN0cz2PQu8M2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734392357; x=1734997157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RdlxZsXRzcdde86YNA7SLax3dWgmBKG3GZt2XtrmCz4=;
 b=rT5gnA2rveZECkolOlB0UQpxWhLe4glA7ICt/9JTy4zxRv2btl6dLDddkxmbyBQ1xW
 hp07/jp7S0fLX5u57fRO/kvkM1WKKcsMQd4KsAEQilZqbXUBzITYHPByITO+oNKnMO9/
 FNc1NT+ex1f3d37mVipAqU9g8uMon7QsOlT/WO/Rl6bsciihZWbDUdpgOSYbSs4ZSXwv
 oHx6RB6PdnZC+k9l4YylXA4e1VsUG374OMDzdQZzdoLK7eH0gDIRVvEQHXgF9aE1krB0
 y82r437Cmi/mqvndgjv+hjUD9im/DljSO9XNq8mZ1hJCz5vnYP5L+ukvVOg0CctJa/bj
 4avw==
X-Gm-Message-State: AOJu0YwdWn23TPSFAdZsnLmgdWwgJMKizd2bgTJZlZxWQ5nQwbCogvaY
 /dSyBi0VBcXj+rQP8AXGXVIb/rdMWSBMPqkkMb6mlCfUpJN6CASu+vwGuPUgC9Ms9fTpWJ+/Tsw
 =
X-Gm-Gg: ASbGncuNRSypWvO1nX/midO87gX0/tAUHMaSp1APF4+kMe92apbcaCOBBb7OAacpPOO
 gSx87yMFpGYfU2Wr7BUVmpNlKabLdzUmxY+ZP7Gsa7gY0+o87maqYvffuz9nm90+ub0CfK1vrqq
 QN3zqj4PB9BCwsMOhNDrQbkXrNhMSp2IOYMNZFrxfDXrOhFstaSrk/MFfQqldBKVvjcj+bWQ9HZ
 tEZXwmKa856riUK5Kfpu6mToEvkVEjGWKy4PUTmybc4/0+Ovjmsm8CDaWRFm6gJSJo2/aCnE0JB
 NzVvFu1Mk5hkbgU+ig==
X-Google-Smtp-Source: AGHT+IH7Hqk9MxqrEHI67ik5MmpczRRiUZjw/M0AT5VvccjcthOaFl97gysGFim2Sd2iF54Nlkxr2w==
X-Received: by 2002:a05:6e02:164f:b0:3a7:8208:b847 with SMTP id
 e9e14a558f8ab-3aff8c91872mr129513655ab.22.1734392357333; 
 Mon, 16 Dec 2024 15:39:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5e3781fa2sm1406731173.118.2024.12.16.15.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 15:39:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/1] gitlab: Fixes to get StarFive VisionFive2 into the sjg
 lab
Date: Mon, 16 Dec 2024 16:38:52 -0700
Message-Id: <20241216233853.2125656-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This board fought valiantly against attempts to add it to my lab. After
several hours of debugging, I found problems in the Labgrid integration
(not included here), test.py and buildman

This series fixes these and the board now seems to be reliable enough.

Note that the board fails test_dm_compat

Link: https://github.com/labgrid-project/labgrid/pull/1411

Changes in v2:
- Rename the board to vf2
- Add a comment about what the board is

Simon Glass (1):
  gitlab: Add a StarFive VisionFive2 to the sjg lab

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.34.1

