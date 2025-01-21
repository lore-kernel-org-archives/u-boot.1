Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB44EC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 20:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35BA801FB;
	Tue, 21 Jan 2025 21:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tYSOfSVm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1867A80214; Tue, 21 Jan 2025 21:31:54 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0482801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso582847985a.1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737491511; x=1738096311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9EJrnZv0LO1XhiS3uV1LvjuqLzOt5GH3cqGwHyrIXcw=;
 b=tYSOfSVmexlcNyY57aBYwzrBX9XigxT+U6HNnfGqKB3mrvkGLX8nTe4aj4mALlc6ss
 q25MezYlbJzk9iDC5cpAM8X4bQxMevyKJXl5aoj3IvKta7ldMQgKY81B8pXjYasobtPR
 8AkOJDfSlcdKTQL9HCO/w92BcL3JljpG8G7+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737491511; x=1738096311;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9EJrnZv0LO1XhiS3uV1LvjuqLzOt5GH3cqGwHyrIXcw=;
 b=l8KdVVCbISjGF66FZx/Ck3AOhj71gDTLXzqzT6UI+lNXy2GKrWspNoUz3IRYThzUuy
 eTmFKdFAb9M9fugqul60edyi9DqSQF7Hax+XQLLBYexjezjmYfAO8dr7FM9Wxj/joyn7
 kqJ0c8pk+/74v3nZM79xq3lESiSCczfSUov6ioqmmaK+0nb1/MQ+WMd760LGSFmo1GYQ
 4THzc+GS/351InP+3Uz88Lmg3HPz+aTu2scgcUG38ghAG/bLX/u/M+oWRDM/sg/tvqnH
 B3tW95brgxEcibHLlm7m5PORu4mkAmbJMqV1R7to1sNKMNKL5kMzBz7iYbhqeaKraW4a
 VEXw==
X-Gm-Message-State: AOJu0Yxmf7+oFQlbIPmtpz1urfnTLKq4YINaVC1xW3SetxbZP05TDy/5
 xFBADRyF1qdlkaHBBC8QJpPROJ6qFbn49/ZO7N4oIuI6hqgitbf2wOva5LCOjUyYbg+xue1GX4s
 AYjq1+Q==
X-Gm-Gg: ASbGnctHVVdS4ORWVbwuNA0WYfqEL9tlVOC32jk1krpXPwKX5nP0I2DS0FobVShWLgB
 XwHL3FoGqCCsPzUrX3Fv+27ZqomxNHMEj/E02tfmCFIb5aS2agGHKyNlBykzMvvG5A98bfhTWER
 vBZAILKH6s6K+rz7c7SqzS51fXoI4amck2Q0d7iwkNk0384WLWAxOvQQ2DVEM9TTrzpCY1mbOxx
 wj+GE00Vdg/xvoCGdRN+LbGaON5Q7tDdvzohLpxokfa1lAAEDmKLQsvAxm/29OSpiW6iuPJOJEE
 +b5j+AKpt/e6vw==
X-Google-Smtp-Source: AGHT+IHd13/Mi+/FcRN2M4dGTYDp0xi1uorwTGoqrfIOy74dvhsx0xpyl1xfyCJornwMpFEY/1+TTg==
X-Received: by 2002:a05:620a:2408:b0:7b7:106a:19b7 with SMTP id
 af79cd13be357-7be6323b53emr3057191585a.18.1737491510738; 
 Tue, 21 Jan 2025 12:31:50 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.16.9])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61473cf8sm589027385a.15.2025.01.21.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 12:31:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io, u-boot-qcom@groups.io, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] Squashed 'dts/upstream/' changes from
 9b6ba2666d63..8531b4b4988c
Date: Tue, 21 Jan 2025 14:31:37 -0600
Message-ID: <20250121203147.4133618-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

8531b4b4988c Merge tag 'v6.13-rc7-dts-raw'
[snip]
git-subtree-dir: dts/upstream
git-subtree-split: 8531b4b4988c2c9bddc90ea74f2d3e2dca9d5056
---
This will bring us to the v6.13-dts tag of the devicetree-rebasing tree
and so match v6.13 release. Changes and changelog omitted due to size,
and everyone who is listed as a maintainer of a platform with
OF_UPSTREAM enabled has been bcc'd, while other lists were cc'd to avoid
being marked as spam, hopefully.

-- 
Tom
