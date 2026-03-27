Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A2510F2873
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 23:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8191483C5E;
	Sat, 28 Mar 2026 00:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jwd5t6b1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F5C383DBF; Sat, 28 Mar 2026 00:06:27 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AF38394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-41c0aae84e5so1897364fac.3
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774652784; x=1775257584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+g1DR484I+L3KJHjOsJ9Ihygo+N8VIZEqcy/o2yzNY=;
 b=Jwd5t6b1Ha0qM9quivYl+V3vl32HFnNHh1D1OZCpDNojfNaKbT4HrTHooRycooliqa
 ElLn3eAo3Jvx0vz6EKBgnKMgMsHSMcbp1GV6LJIrOwg1M2bPXaXjTSkoTzlVLSPlAvAO
 0eXS+NymslqVbIv7MCoXAvM9tI9HpIDVyhSJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652784; x=1775257584;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s+g1DR484I+L3KJHjOsJ9Ihygo+N8VIZEqcy/o2yzNY=;
 b=IgnJcjjanKR9iDpQEnQtWwKzsnhoySxBUFT2MW3iMsxLS2yVzsWOtLUBcD/hudo7cA
 ST6/ML2motnq7DVB1725+u8bdUaJWPGPXejaTqOprXtUqHdFdEWaYeWPFGqYcvh3GgG+
 D8Gl1RZ6gqOeAEj7jwmjsAazUi7Pd/R00Rvtl/nDO1ZKdnWyVoqXzeOSHtJ0H+AnC7Di
 iEcFhkWuJH/B7cNa4XoJmfT/WR+HN40FR41nE77KZdpUgrMDuga1BZdzJlBIkW2YwTTW
 NELkYjOLvDgqce+2gNFbv6NVhB+ZIhb3k5ojskUtmshQruWyDFjsh4uWs0gnbXfzzhZ1
 BNfA==
X-Gm-Message-State: AOJu0YxuTfCfBnN/v2Mno+ihq1XfmSuoQqOiwx3nhb+l+jdbDchVDuAr
 LBdChijQyJNaZkPKBAu8qZx3u4qnIsDOKTSjgVpf41pCHfy2RRnqvXxyhdzhF4nEA+2vjeGvKjR
 ai1uB
X-Gm-Gg: ATEYQzzp/XqcbpRZ9YE+20RQzpqyBWKRb/S1jeT2NE2Jotx2oMjTCQinnw/L/VPe4A0
 sdTLJRQsacvllqbT7r7zZmuhWZdreWMeEW86sVdrFY3pEaWTMdn/x2ca0IHiYyN4buFBq0HRe9z
 nFPRr/Z8lmtJE524wv43SjBQxEnpuoEpoefE8VRZUR9dxQ70sFf4HXAdOfngUzLH0uOV8iy7kf6
 JkQagy5ftxPepSGQKgFWiQUyUpnTCk00Zl4mF20pVlXs3MicXk9SVET/jp3LEx2/0lQL4X5k+Wt
 hR8bxgebM6niNUYgrKjWnfpSL1y6C4WCMKb8lDNmqMaoIEhHtfOMtWIsFrOHrl+I68ca2ByOnQF
 uJ1bgjmxufRc20gvmjMTHYtPY5kw3JSADdlN0SiDXXoelbAd6mNdfgOI/PrF4co65Mp7JtIO5nz
 SEgmncYjSXwWdfuKuByFaZUB37r0gcVAjqx93gyDs6Gsigc0qRDkLEGWM9GIGZLeayb53qULquW
 WAjezaVI4jFTAbS0ihtVnR6KQ33GN6CrXoX5Ri/Z7KcAPY=
X-Received: by 2002:a05:6870:a411:b0:3f5:694f:9366 with SMTP id
 586e51a60fabf-41cec2bece3mr2476684fac.30.1774652783630; 
 Fri, 27 Mar 2026 16:06:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04cf9e03sm421650fac.14.2026.03.27.16.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 16:06:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Daniel Golle <daniel@makrotopia.org>, 
 Simon Glass <simon.glass@canonical.com>
In-Reply-To: <20260310155841.126525-1-ludwig.nussel@siemens.com>
References: <20260310155841.126525-1-ludwig.nussel@siemens.com>
Subject: Re: [PATCH 1/2] Add back debug output of hashed nodes
Message-Id: <177465278256.41705.11580327883742269840.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 17:06:22 -0600
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

On Tue, 10 Mar 2026 16:58:26 +0100, Ludwig Nussel wrote:

> Commit 2092322b31cc ("boot: Add fit_config_get_hash_list() to build
> signed node list") removed printing the list of hashed nodes during
> verification. Add it back to have a chance to compare the list when
> debugging.
> 
> 

Applied to u-boot/next, thanks!

[1/2] Add back debug output of hashed nodes
      commit: 40269a6e01e55275b0146ebb4db14f801cb05cde
[2/2] Remove confusing NULL from error message
      commit: ce98d46395b748ecaf9ca1398d3b7e78e123bfd7
-- 
Tom


