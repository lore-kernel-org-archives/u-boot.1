Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259311061B22
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 23:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16502840CB;
	Tue, 31 Mar 2026 01:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YkE7TjZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B958352B; Tue, 31 Mar 2026 01:00:24 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BD0840B0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4673790ab85so2964874b6e.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774911617; x=1775516417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ae5RgotbYxBOPm8/rPXyU1TJi8JFEpJzwsNTOM2u7oA=;
 b=YkE7TjZDsLVr7iQTiYuh/G6Tu/hE73biVHbaQfGsjslfL6ev0OEl7PYY9gcyKHK+1i
 Q1mwTvzWDD1QUbDSUHl5UZxnGROlyNI0lwNhO9SRvqNWTvX4GacBvcE1HWKvaQETkyvL
 kN2w5UWUUHUsrX1+Pt2lSdwGFuDXl1VDQxjEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774911617; x=1775516417;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ae5RgotbYxBOPm8/rPXyU1TJi8JFEpJzwsNTOM2u7oA=;
 b=XCuvD6WBWBOGpDLhxwZExOWRzuxM1MjrE2KKOlXUjuV9uegD3TUX/o8X+Fu0DUoJ6V
 Uh3wzogbl7nbGDFWL3mJTXN0Tq+w11HNMKiVi/RXOsyWZdExKJ5GfAXTW6Rr/lBFNcsd
 /2ZB4Xwiu6gU36i62Z+k/YodxjNdlHYG5SsLoWT1uqrT7mjH+Tj+/RReyO7v+iDFC3Dt
 8futuNwny4eMCHBu6d2QyVp4xgpSlnnNBehK3LXTRazgH4rB0pLlYzxM94KMVqMmwGwG
 yCukb+IMiS/ESOsH2d+YPjiDMkRzQhLnoKMEtWrqzdgr68f0tWE9EktgBbMtnlKDu9Ln
 BIzw==
X-Gm-Message-State: AOJu0YztzrUIRQCT66FDsI+Ap76jcZN5ljgO1iNnZ3w2Rh26KgoqRmMp
 SX9XLsywAgcFyFDO0kNFcQhqX+yt1t4LyMcVowSb8Eaw3muW1bSGb7b3ISQnfA3Mr6L9DFpH5+I
 Z4efanYc=
X-Gm-Gg: ATEYQzyUrfvqKaxNJbKy3Frq1iyzS68ltwOoc7BOb8cP4nVxj3Io4wQ9B1SLGNOc5AB
 sohOf4h55N3ayR7ITIg/VBB1vLZ4MknxJEGdDNPsZWgTwdhWL3TONAZAk4kWSfaMOarzbVDNkBt
 vs5OjiezZUWdPTiZhllh34EjC49THRUNWv7keF1RuZouqQl8PaQAkOP5WXuxVXeXnhebPBiSGdV
 RKWoVoLFr1TXhUSN+FhR9jAJXOkw6/f8NQV5yaMSiy0si3EaGtk62+7BIrccd74I+MEP52A93BJ
 SnCqCBKlot/AlauRMDOt5REOHGyzZLn8Vn2IYawk23br+bNxiScQFSD3dPc7l2cDJ6HbRhNJ7uX
 m+9F9//KSfbdHSAHqKoWxM/tkBCdde+aXViF/QLVuG/KNQYND0ZYww2zbeJZBgoPWQpMvJCMB8h
 bj0hRMmekgJKZkFKjHKpnMLqtV+803YVDhpuck8o0SREm3vOFLudZOxPbPMMFlTkX+IoenMpPeI
 P7NylaINY/YPeNNl7bU4uhNqLQ/1bpYYJcdKE1rYiI0X9Pv6x0WReDnsw==
X-Received: by 2002:a05:6808:6705:b0:467:1da9:2b14 with SMTP id
 5614622812f47-46a8a69aba6mr6184743b6e.51.1774911617036; 
 Mon, 30 Mar 2026 16:00:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46aa03b1e64sm5644737b6e.15.2026.03.30.16.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 16:00:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260317012454.4162754-1-trini@konsulko.com>
References: <20260317012454.4162754-1-trini@konsulko.com>
Subject: Re: [PATCH] test: Correct dependencies for SPL_UNIT_TEST
Message-Id: <177491161642.1028292.2549735326341883745.b4-ty@konsulko.com>
Date: Mon, 30 Mar 2026 17:00:16 -0600
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

On Mon, 16 Mar 2026 19:24:54 -0600, Tom Rini wrote:

> As exposed by "make randconfig", we have an issue with the dependencies
> for SPL_UNIT_TEST. In order to test SPL_DM_DEVICE_REMOVE we also need to
> have ensured that SPL_DM is enabled, so that that select as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] test: Correct dependencies for SPL_UNIT_TEST
      commit: 2ee6606f3576d017ce2b914b3d4f858de562bebe
-- 
Tom


