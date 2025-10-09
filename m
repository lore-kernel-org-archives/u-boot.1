Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B88CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 21:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9DC5841F5;
	Thu,  9 Oct 2025 23:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VwGd8OF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 842C8841F2; Thu,  9 Oct 2025 23:29:21 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B018841EE
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 23:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-63a1f3c0820so487198eaf.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760045358; x=1760650158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HculKbwO7aQi/W/2HZ53Xd/OvnMoRDRCTmhHtA6HLP4=;
 b=VwGd8OF/KsmlkIyyyy3qcRMSm1wF9bN/fnAqKDSXbJLuejv6iAbqHXpfrAGzXQhuUH
 CSfQgmKtEZ4BiBT8qkTmX6KMJH0oN8ryfKDs551kkpew6iLePP6X686//VjoUPQKc/BR
 hlGRWq7OEUHsh7mxIXo11NNv3SwncqQ6LiXkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760045358; x=1760650158;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HculKbwO7aQi/W/2HZ53Xd/OvnMoRDRCTmhHtA6HLP4=;
 b=VxHMf3CVNrC3FcrUIJqSbCl7LsL/tZd5rOv6eMsREKVSDO+Vs+56nyliJu68TphDfL
 fVS6znojD0UZD0BWI8oE+ZNX3ziBS/p1pBBtjcEjO7QhXSMGTASWJDBARcWGcW5qKURA
 bdLGU5uQxOgt49M2V/2ORwDYuoFBwvUpY7m1LXayl3UJa3ceiFxcbXriOi3hdYwT09gm
 ZU3P57z0emfiPMn1U4Eq4quKvAw7+Xaih3QQX/umi71NXYX9axmGRikwfDUCpJRvhOj3
 SGD5Hz3dl49FBDaovLDs2iMdNo6VM+1qAa80HaMERBzOK3rRwDGVuTcz8TOUzNE84ZJz
 ftZw==
X-Gm-Message-State: AOJu0YyjUFL17mXLaBPzAtaJkbeSy7C8RfFMWeFG+SkUnOSAKFqmENHl
 2dn9a9+EGqnjjmA9XoqdVMlGfLPtXSO0nIzqvfE2g68Nb2/2pzEhV5te7r/UDW+oPHoWEGjsin/
 tojtewN0=
X-Gm-Gg: ASbGncucqBsJX7z6HXDEEGtrHV4Gxr0uIhuqeZJItxKS2qZpgsA/gr4qtMblvWxySxl
 MtI2aQanRrSkPeQj7TndMcWNx6fVQ3PeHILuvYJh+B9odxEqPGvn2GmdMC4nobjklQl/JUTZD0C
 45YguBjOSlyLoLTJqd0zK4YnQcIeZXVsLfJbS92E/xWQW8MZq1LMriVqleOUMVD41HlRfUUmuQk
 /Kf9MHoEktOgpS28xdboTo3xX858Rd72ldwoDniU+5elTivsAvs2ynilvlDFUhXGUyHPb1KR/Ha
 tOuabbVtwuyiFiNE8FTVAEMeEAypw1T8wA5C+nKKRW7H9Uzj+n9rakJ0K/v/DVDeRQUcoiiuC1G
 9DCMA3DhvWMK/yZ/oYLdwbotdnBjXD6VvU4RQsJrvSZBpSVxElvcXLLygJDPrRCmym77LFhY5W5
 8oG3pNqA/nX01mR06ThyY=
X-Google-Smtp-Source: AGHT+IGn9ePvQj5Dds7Ru80kNc0c9TR8e2rIp97OMTWdYxUTeIOFGQnmUnk7KKc/Xo6gQcMdnXV9Eg==
X-Received: by 2002:a05:6870:d368:b0:349:de3c:bfc5 with SMTP id
 586e51a60fabf-3c0f5a23d78mr4281949fac.7.1760045358019; 
 Thu, 09 Oct 2025 14:29:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8cc4d3f55sm76479fac.3.2025.10.09.14.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 14:29:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251009193452.285267-1-festevam@gmail.com>
References: <20251009193452.285267-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20251009
Message-Id: <176004535690.1002224.18260213249086914705.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 15:29:16 -0600
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

On Thu, 09 Oct 2025 16:34:52 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 0eaa4b337336dbbe93395d1f2ccc18937eaafea2:
> 
>   Merge branch 'next' (2025-10-06 13:20:24 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


