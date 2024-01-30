Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39535C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89C7687CFF;
	Tue, 30 Jan 2024 05:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXCgf4XT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D769C87BEE; Tue, 30 Jan 2024 05:37:41 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B59487CD5
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42a029c8e62so29974821cf.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 20:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706589456; x=1707194256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ar8kR5SO/0kXwZQtvPixYLe9x6fmjeJll/Eei3aw42k=;
 b=QXCgf4XT7Vu62P2vybunEHnbJrRs5SxPZhN/rlZsrMdXuxTtZW8cl1/oKFZwkKpTi8
 fMdezld9GUUT16nSrNaPRwYVeQ0m2HaOtyGUpn3CIhRhugDiWZ5I9Gp7OlAXGMvYOq2Z
 a2LRx8braf6aqxZhkhFOwfd8Mv+QegaFzbCuvYskqs+bKRm3g15E6D+zSpD2KN+XglS/
 cert5hleT4GdvHfWLoiGGM9ldu6Szj9IXLKVWlyl4baGNravy9edKH7nHZQj0m/UAwUA
 EM9o5XXh+WutG0CznlCfLoKhENKd+TiBL2SC0LA05+014uC1elChJDrl5C8bbTv0Fbbl
 fnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706589457; x=1707194257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ar8kR5SO/0kXwZQtvPixYLe9x6fmjeJll/Eei3aw42k=;
 b=g0lgdOnIJvD54ltCVSuP8J/tjSXCOLwrLuReO0Ah5852UCdpKvbfC+lrM1a38zwW/r
 s1fmG4xxGMPaOLIXMYVBv2aRjZtKUk9aC4heYc2UgaCsI2NjoGDR9IjFAGLmp+38O/pR
 j2VWrR6QFdz5eU6vl7+AH6OymUmfb5apFqundLQ0npwFMykR19ZSZpkL2FN72FabI/Nc
 5Httwj5k54co6f2zyZVQlGVGmayeAlfYlaZnTLIKnUxt6R7evDUJoHuSIaRZXPa0SLRA
 cGqyj/f86TvWAvFr6NcU3t5L2nagHZFVyzjDwKsm8H9RaBrONTYLzuVXorDB43Bje/0R
 D3Ow==
X-Gm-Message-State: AOJu0YwJ3K70s2zP+J9IKadH26hDZM0dZq3nVJ7OnWqFidxspeeyFSIE
 mNmHrYZqlgAfaQvXZSrV7TjI9f0bb+bC3PJ/KcOqEH+qHoIoP1szAF1Ro28ucjg=
X-Google-Smtp-Source: AGHT+IG5RZfkYnhwP2tEYOXDGogExOZCKU7wHCTT4D4F1DSwmMUzFH8S6CpZufUx3yixhNAPNVCEpQ==
X-Received: by 2002:ac8:5716:0:b0:42a:db63:2b9f with SMTP id
 22-20020ac85716000000b0042adb632b9fmr224973qtw.19.1706589456757; 
 Mon, 29 Jan 2024 20:37:36 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 ay24-20020a05622a229800b0042ab68d7c59sm218557qtb.68.2024.01.29.20.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 20:37:36 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	jmasson@baylibre.com
Cc: Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 mkorpershoek@baylibre.com
Subject: Re: [PATCH v2] clk: fix clk_get_rate() always return ulong
Date: Mon, 29 Jan 2024 23:37:31 -0500
Message-Id: <170658777076.694990.13643543563798019814.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <87o7erv9p4.fsf@baylibre.com>
References: <87o7erv9p4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Fri, 15 Dec 2023 15:09:43 +0100, Julien Masson wrote:
> When we call clk_get_rate(), we expect to get clock rate value as
> ulong.
> In that case we should not use log_ret() macro since it use internally
> an int.
> Otherwise we may return an invalid/truncated clock rate value.
> 
> 
> [...]

Applied, thanks!

[1/1] clk: fix clk_get_rate() always return ulong
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/b500447ad6ae

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
