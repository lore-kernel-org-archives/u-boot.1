Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE81C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9145B82F63;
	Thu, 22 May 2025 01:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mCC7o9CK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0E582F70; Thu, 22 May 2025 01:01:27 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA51E82E31
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6060200710bso3887932eaf.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868483; x=1748473283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fWrLbVK226634K9zlT1p/YEZ9eQbMS+LpOgS21sV+ao=;
 b=mCC7o9CKDOPUQwiAo07+NHiE4MdCjNfnX3SXAH192oV2hgNFT97NGe+iwCDCmnvqkv
 EW/5rVyZhF+jBlE7kLkL0BN41dMJlQzmkaJOvhxN4S6nz8vo+tb4V8+1EbZLZrFLJnXa
 st1fZi4nr2NAOjUUjNAONJ5pv9xn/yN160vrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868483; x=1748473283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fWrLbVK226634K9zlT1p/YEZ9eQbMS+LpOgS21sV+ao=;
 b=CKeVAXs9vsQApzWVewPnAIdT+IHbQqn2ZfvoYktBoSq5rWCoOEKjgYHtbx/HPskDV3
 a8VNO7m0kJceRCrEuKq1xiQpKcr+Gy9MPqI0lo920ifkMlGy0toqfjeRZ4VuqFbxT0j2
 hjKfYaliDeFs4IiMpGICXcLEWw+Yk4SvMo9Y3aUiG5qnEhvyCqDVSz7xgJON4Sq1DYnk
 5tNfM4Igdud50Tf34HZqWo6SY9bMG7i4rza43ADDbA4puOaOUUYJYx83w+FIr9Jsgs/+
 Jmz3Ca+J40lfAyVkwiIG6s0SdQNc0ye16PL6/emoaz1CISXWhp3hgNTvXAZLqjm/dpCN
 HUQg==
X-Gm-Message-State: AOJu0YyfJ2sNtPQOXW+VsznMUVlhz1X4Q/WxUM1plhGaKs5Cf6eVDSx7
 4WyvzvEBuUn5M4WnnP8UJmwJ7kL7gF1RYynR7nHL1k19JT01LKyPUhAqSIsWMQiVpMY9c0eodPX
 8bsQ/1HE=
X-Gm-Gg: ASbGnct/l1AP1SsKLLqKHTG5rPw4P3R2LPdaewrWzEYJZDaJAMoaUcQ27nHFQqt1667
 0/VCHBQKWPI0hSKuebKxwblKnMpiLqEl5JM0zul/eZUNdhvSal4vTl021VRXSQ/PBrDTf6yGwB6
 /typb57zwCRpq7If6oP4hRD7DwHnpH+g3MihJ6a7UFdPGNF4pPWAC54xUYSIkbufOOKRYkFzfX7
 CD2u0PpN4Dc/quDePpOQPMsIkNKKqwxF0oQsejJhpwnJHjMqH2O/jc2TLDAKZxxy1SxhGvlk0kN
 CmjBLr53Rq9rOrfAxZx3Nxpv18rfNmoywTBO7e0RjzXZ3z5gWlP8Dp8DpKnzu59ghPXnntYnUJq
 Ix3O5CdUYPq67FEk=
X-Google-Smtp-Source: AGHT+IGBPyUWGjOddGeHU04CBrQ/BpaTRbF5adh9lqxEN+HI03RX4LIWxDmT7w2fi9pJa0MQc5uXAQ==
X-Received: by 2002:a05:6820:440b:b0:609:f8f1:ce71 with SMTP id
 006d021491bc7-609f8f1d116mr9235023eaf.1.1747868483529; 
 Wed, 21 May 2025 16:01:23 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 00/17] Audit include list for include/[a-m]*.h
Date: Wed, 21 May 2025 16:51:05 -0600
Message-ID: <20250521230119.2084088-1-trini@konsulko.com>
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

Hey all,

Related to my other series I've posted recently on cleaning up some
headers, this series here is the result of at least lightly auditing the
#includes used in include/[a-m]*.h. This ignores subdirectories, as at
least in part I think the top-level includes we've constructed are the
most likely places to have some extra transitive include paths. I'm sure
there's exceptions and I'll likely audit deeper once this first pass is
done. This only gets as far as "include/m*.h" because I didn't want this
to get too big. This also sets aside <miiphy.h> and <phy.h>. While
miiphy.h does not directly need <phy.h> there are *so* many users and I
think I had half of the tree just about not building when I first tried.
It might be worth further investigation, but it might just be OK as-is.

-- 
Tom

