Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBACE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 17:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F45580243;
	Tue, 17 Dec 2024 18:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EkEJgYYQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189AF80241; Tue, 17 Dec 2024 18:18:16 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6768021A
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 18:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e4d38185so431205185a.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734455893; x=1735060693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lm21hFo1WRl1hvyq7fEg+n7cYbKOOsv6HAVvl0iHHXM=;
 b=EkEJgYYQSuzA19KuoPB6qzEkZsxgRZWhfuFnVo1UDWI7jNd894Vl3L8GVXw4yp8ijJ
 wU7ITqspr0CUSh5eVs7tVxXnQo/4E3TloKWzo6JT9QP8kohLT4+JlI+cVdCSbTkA5S/F
 E3mZGZPOcTTEr8rWyd73gNMeDSgzvLMdhIodI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455893; x=1735060693;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lm21hFo1WRl1hvyq7fEg+n7cYbKOOsv6HAVvl0iHHXM=;
 b=byqhaCA2Nsy2XUhi5N9EsUGU9tutDgPDLPCqRf5MEn7/JRTFMBu0UG0Zrhk6OWjgA/
 WfAXi3ecbuhGFY4rYt0mnJI1OO/b0rAaaw75AA/S8lgaNR3oBa0hUSeUX7FxYxhAQS29
 hWkPUp2sK3GSAaD2WAaPK90hP57Vh603dpIGNvyJoYfN8NvZhHVZy1z7hejAyFY/4Bpr
 Uo31YrnAkUxA3jugy7bxMB56Yy/OhQyx1jiTcMkF+64u9KOXqjEUS882TbExsR1atmlA
 k4YoJLuEc4NGDzOZMzmafyLzSruPWLIEimFStYKWSW1YNBKe5bAZLyhrvU0RzsR4gQPh
 rblQ==
X-Gm-Message-State: AOJu0Yx7kJsStArcziR7CYCHb7HArPs59zWbABkzEWb66RXlXAdiKL2Y
 On1TaVoYTQPTrtI5kr2woSiRwrokE6u4yedXKmT95VTDwiVQEB8OQ/xqhUymqmQ=
X-Gm-Gg: ASbGncutNwRRWZcOIeNkAgbz12I8nzK+xKth+OV1XQUFp1TlymWnb9DP21VnRgLQtMM
 L6Lkmfe18T/g6mIcg8h9jdkTcoiqt1vFVD/ia+3PZO8DaCcQfAq4FZ+0vEohMIZHGOasrb2l8VG
 QBMbJgGtzMPWIPS5CjaCcF9M10ueRMavs6aVSjKvJFw8LwnvzUdanz+WFLCIY5xM1FMYMs3popw
 TWpL3NmGB5DBo1XmmgI3hFxsAHBSI+/OkjVO53/AFCmvwk5BYKnhgY=
X-Google-Smtp-Source: AGHT+IFG/cewJpTsF9lfgIJlcGl+tO/xmKDPNsXIhMbcjQaIOgTb43BFOTRG2IfSc22Oh6kak4V6xw==
X-Received: by 2002:a05:620a:7186:b0:7b8:627c:5fc3 with SMTP id
 af79cd13be357-7b8627c67c4mr33328285a.5.1734455892837; 
 Tue, 17 Dec 2024 09:18:12 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bbe9asm336450385a.94.2024.12.17.09.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:18:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
In-Reply-To: <20241207145227.1024491-1-sjg@chromium.org>
References: <20241207145227.1024491-1-sjg@chromium.org>
Subject: Re: [PATCH] boot: Use correct PHASE_ variable for expo
Message-Id: <173445589095.4187054.5817915905875014543.b4-ty@konsulko.com>
Date: Tue, 17 Dec 2024 11:18:10 -0600
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

On Sat, 07 Dec 2024 07:52:27 -0700, Simon Glass wrote:

> This patch was written before the XPL change-over. Update the Makefile
> condition to the new way.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


