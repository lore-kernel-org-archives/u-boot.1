Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1001FCAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 00:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D7683443;
	Wed, 24 Sep 2025 02:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mOHcr7tA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17F580107; Wed, 24 Sep 2025 02:28:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E9E680107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 02:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-793ef18e8a3so361208a34.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 17:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758673706; x=1759278506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcLrhgeogzcfwE5L1Gc70wu4sgLQnj7DxjC16fIVI2k=;
 b=mOHcr7tAKHF6DbMLMHXve0WVh8T0Fm3mnRI1dUonG0744KSHDBBZEev112276BE+P4
 lMAyrD2hLWuFO3LHFL2os4QY7t5bsWMUXhu97x7FiRwrdI61ZYryfA3wN0cYvh8Sl+/l
 RnziZsqRQotlIoh59gRzDRM/xC33qPwIe3lQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758673706; x=1759278506;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcLrhgeogzcfwE5L1Gc70wu4sgLQnj7DxjC16fIVI2k=;
 b=IyVFGeAU2wKXmD9azRPKO6wez89Ody3Sa7glnCsN+O3ZRZp2W59z/e6o7+DTWRW83V
 hYJTecT2cJIE2pM0jf0ZzR/xyktBWRa7OaOCc98Ikbl7kBhmVtYvFM46GfGzsrEKoiTO
 wP8+tzMQ9K/96NdQiiaj3UtO85avyq2ZADC7L1dlSPTzSL5fdmS8CoyVl7QnQv1e6ZfL
 QVPJOADtaY7gIOhirzfDtegZqKVz5LMZh+99i874HKi0D1t545AIxyPFltv1R2niyhVD
 9YqKKVLgm5jWNdKFJtLkUvdgrzr7ykdvhGjV9miUEVJuEn2b4hfgIN+ZLZsuqBkIGTBS
 L5Hw==
X-Gm-Message-State: AOJu0YzhimZ5d8F7/bpIPOvEdl2B+UpdxtRVNMgmmvXPfFKbY41BB+BU
 nWx4zciT/dDApPIAC9+Cou8n8bhuksGU8ijkVXqG7hWRwrL5tgUl8lFT/RGCm8l9tX0=
X-Gm-Gg: ASbGncuHWXs3iVSYGEZEBo+A7OrHY2Y9PmYLgTk1679JWSouN21/4BvNv/EZqSAz5t3
 ORqY95h5uhRzrvYqN5t6ouedAbZ4zDa9H5nk0ph/0I+GF1FiLnEDtFhkj7aa4AGx5adh5paBTtu
 RT3ZKbvQB177RRGQdZ+jmt6sVGua9JUS80Xq/ltGDe8hjLaTJ2mKatIj80yM3E/bEIFB/Q4R5pN
 g2rovQJWzIYhiMutMNKVjnzHW2+PsXJtK9sDTfo9D0q/19hTW/xYROFc7WB6+qcLUmDTHlcFJri
 FBx4d/kM81wz7Fwm6AFcugwXcp6vaXoXcD8r0NmyvF2bwQaG25OdN4kGim53lZ4jwXruT4UE6OV
 3qBOpaVw/88bx/G4lwSso1IF5DduAZ89AdBca4X9E3Dy9ZH0ks7pAe2U=
X-Google-Smtp-Source: AGHT+IHDTMfyS2pbareCWnnJgzfK+n++FjZ5mMC6C8o4o4Mzxb6M4KxAa9ynJZMoFCPbs2THHYltKg==
X-Received: by 2002:a05:6830:61cc:b0:745:5748:b328 with SMTP id
 46e09a7af769-79a5f4caccfmr431099a34.2.1758673706365; 
 Tue, 23 Sep 2025 17:28:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7940065a943sm856439a34.40.2025.09.23.17.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 17:28:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Luka Perkov <luka.perkov@sartura.hr>
In-Reply-To: <20250915210109.459864-1-trini@konsulko.com>
References: <20250915210109.459864-1-trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Update Luka Perkov's roles
Message-Id: <175867370553.246334.3108807184099394302.b4-ty@konsulko.com>
Date: Tue, 23 Sep 2025 18:28:25 -0600
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

On Mon, 15 Sep 2025 15:01:09 -0600, Tom Rini wrote:

> Per a private email, drop Luka Perkov from MAINTAINERS entries.
> 
> 

Applied to u-boot/master, thanks!

[1/1] MAINTAINERS: Update Luka Perkov's roles
      commit: a6caca94fc77dbe1db9484915241f77909aa43e3
-- 
Tom


