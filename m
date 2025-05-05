Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7955CC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 19:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC9D8294C;
	Mon,  5 May 2025 21:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QauAhKXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151678294C; Mon,  5 May 2025 21:40:44 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C1D82163
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 21:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fbc00143d6so3502656b6e.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746474040; x=1747078840; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38i016iZs9qKatJvyWiU6hMJYucm+Kcp3Da0Uojhg7o=;
 b=QauAhKXLUEQnkZWOAJlznPgNfHNiEPkI1Jki/esnO2l1xySpGR6Yx+LuMmj/51ZVRr
 BWXLx0ewMdwLkMPIugHdfGjxl4JriTbU6vok2/0TaJI7Z9ICCJH7c/XENAMHqR7EHhqk
 NgEZIpQ+E7vLyQXP4c8kjbc+Io4RHdafyw2N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746474040; x=1747078840;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38i016iZs9qKatJvyWiU6hMJYucm+Kcp3Da0Uojhg7o=;
 b=t7w4zseOruTa4dMWxrdkp4Xtwp8ITf7I4BThpCQSKN6kLutnitvaG/S7KYDNZTIFjC
 MR4UB5SILcBTiV9cc9QUd0SSdcgd5eZuSQebk8/LoxDBE3TTNT9KRlwLUOM8gx3bdLZF
 0BTucWPlhc4TPlljjEltIWwVnzYf1+SBDf4SRkFu7eOxXszUCQcRvt6Hq63VECFDPpNU
 uM3t/tYT+P525ttlMaO6tGg+lu88uxp6LLx8dbXjuV81WunGpV8LNo66Vnscv+VhxYhp
 v39A79xqOnAhh4Wsv+rmuuWQcRD4T4/ZYC4xTWt/KTuApvnoBZnaP3V8zJV6aOKf74wV
 fz3A==
X-Gm-Message-State: AOJu0YzEgk9FjZsYueVknGUDn6NSItbPkynDkCWGpe4dRWV2gP1O16pj
 db3K0kDYAd//n/jUOZCxX0IgxunOjbHZtzfrByTZxniEv+HRHo23BZO2mkt6Pnk=
X-Gm-Gg: ASbGncui7vQCACye1Pufa6efJGSOTogjLdCfR2SvvnudTAuE5zJoDyb43P0yYFDNpsS
 pTE05mEn6qvsiPcBrAjXNTNJGDDvjdikCbmWPsDgoCdga8v6ADsVhrUAp71noYJWcWDdu/Ab9NG
 ZNqD7ojWLqYNKX+I3oCjCpr410rDyQp6mA/XSGQ0D40MsdIYWXgA8r8+CFZqN5rdeOq/FJETphx
 y8GavOFeSOeRQAalZc25M70Jg4pF16TRjGPEid49S5kzAZBhwUWR/xewx6/xuIfReRy/zGhAwSA
 o8Iv6eRhCn9icqD7q/UqITlFOrQ5BEHwXY7UwW4KYXI1LOx9jWr5bfmwlXBCu61zKr+/QHJIDWL
 4
X-Google-Smtp-Source: AGHT+IGeTXfSguOAqrLbHQUK9BJRWiWzU7TLkOB5gM9XYNp+TztLp9KpwneiCVYxNumikFyYJ/Md5w==
X-Received: by 2002:a05:6808:320c:b0:403:37dd:e109 with SMTP id
 5614622812f47-4035a5c74b8mr5571312b6e.27.1746474040404; 
 Mon, 05 May 2025 12:40:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d9a519fsm2058128b6e.9.2025.05.05.12.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 12:40:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Pascal Zimmermann <pzimmermann@dh-electronics.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Christophe Roullier <christophe.roullier@st.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <d348e7e7-5969-40d9-93ef-ca7f318ebadd@foss.st.com>
References: <d348e7e7-5969-40d9-93ef-ca7f318ebadd@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2025.07 =
 u-boot-stm32-20250505
Message-Id: <174647403944.47668.1609353437821484984.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 13:40:39 -0600
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

On Mon, 05 May 2025 17:01:23 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2025.07 = u-boot-stm32-20250505
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/26081
> 
> The following changes since commit 9dbe8d889546efd6c1a3470092588b9b6820158f:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-05-04 13:44:01 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


