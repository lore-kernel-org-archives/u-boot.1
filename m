Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6EFCEF174
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCACF88ECE;
	Tue,  8 Oct 2024 15:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zxv6tNvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB91488E90; Tue,  8 Oct 2024 15:44:33 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5F1088EC4
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a99e8d5df1so570509785a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728395071; x=1728999871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BKReeI52DTDWhRHCWd1bpFHCCW8krhKTqmY4ayDDYZ8=;
 b=Zxv6tNvmY4UOO1CLwKlgmUa+4QKWzxoqMh0odlXq5vRcZiJLldKr3MzqtfH/f3xuVX
 PO0sBqOKJog/8a0AV0EpZRIl3lXulvlno781N3bK1a5g2iMRTxxii7gwV+ckA6O4p3Oh
 3lwV4rPQ1rSLDJYrq6QoJ7Yjyazyt7CRgKSvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395071; x=1728999871;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKReeI52DTDWhRHCWd1bpFHCCW8krhKTqmY4ayDDYZ8=;
 b=aQ0xZLdHtW+yd7N3kBMm3ZxYQogzTMtg4cvEZRRrzWzIBatdoRWGiT5+nhxJHHoDFl
 O+qBFhsQiR3587u7fGxTu3ffZP2oPMZYJbYVOEhpa68DmRJvA9lH4s/5fGyoVyJEtEXq
 yTGdBLvLnjqdybRq3L98svcYRqgZMaeACU5HZ1xFOaLFe9RrdcdA5optAeob+fvGYG3L
 z8tqhbHZxE3JTRYCyp7smBilVEON8Y0RIKxv6RP1TGjxHocDMBWdzYWs41GpbHfdGwv3
 gW7DVmH5cfdVmdvboFicENZAsWA7pau5Ef93ktBLmJ7gt0FuFGXUnmacykIs448xqJ0w
 bcCw==
X-Gm-Message-State: AOJu0Yzlg5bl58Kq/Oeu3idfNQPs6Sck7D6wV2/9/fIB89W/Q4iqylVd
 X9RZNhiuUSADDPhX/Q4pg24+HHYfBee8CfrfzKAi1B/4D5iRMhVx/NycXqarncfLnMtCk6dGrjU
 AwAM=
X-Google-Smtp-Source: AGHT+IHvZaBb0M4Tr533GvFWahUyLN9UobLflxeqbFYXUGXFH7hx4iNMCAStPbZ7yOhJ77QfitfRYg==
X-Received: by 2002:a05:620a:284b:b0:7a9:d171:62db with SMTP id
 af79cd13be357-7ae6f42222amr2566878585a.11.1728395070707; 
 Tue, 08 Oct 2024 06:44:30 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7562cbf9sm354028685a.41.2024.10.08.06.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:44:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Daniel Palmer <daniel@0x0f.com>
In-Reply-To: <20240929092739.2513768-1-daniel@0x0f.com>
References: <20240929092739.2513768-1-daniel@0x0f.com>
Subject: Re: [PATCH] cmd: Make bootvx independent of bootelf
Message-Id: <172839506989.112860.11166419458122902632.b4-ty@konsulko.com>
Date: Tue, 08 Oct 2024 07:44:29 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sun, 29 Sep 2024 18:27:39 +0900, Daniel Palmer wrote:

> There are lots of usecases for running baremetal ELF
> binaries via bootelf but if you enable bootelf you
> get bootvx as well and you probably don't want or need
> it.
> 
> Hide bootvx behind it's own configuration option.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


