Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CE7CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 19:25:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB7E7833EB;
	Thu, 11 Sep 2025 21:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mjtz3a4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C5A683322; Thu, 11 Sep 2025 21:25:45 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1A33833AD
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 21:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3f660084016so6023245ab.3
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757618741; x=1758223541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfajKnyBTDQ+XVItoENq6HzYjw3TD6s+H0/jKb427js=;
 b=Mjtz3a4qxUgFRdOeVtG88w7JE+1g8gnfazSL5MqGioBJqd7R33e4UY+CZ82MVusBw+
 CrQvOxLPu4SJ5t7p4RoqDOb19bj2wARNZQabWxFeQEYkLqvOH1mJNcpGKWQ6XyPBFlr5
 MsAWqFKf/Ka3EbR8bAxtQf16gnmS7L+f+s/Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618741; x=1758223541;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfajKnyBTDQ+XVItoENq6HzYjw3TD6s+H0/jKb427js=;
 b=ajUwHx7t11jv+Yb0GAk45jzwjjSlpseWChbIboYs0ySgKGbACWWvMdYiA/G1fFtPav
 tjjbUSIvAsmRrzeyGqbbwNpyi7lzTmHIoHKn2lxKe+eIbVATf33AZFLHXMkcVTzNgp68
 ATds6uZwR4Ozrf7TL2q6GtZB8394/Ladg/7Z/2/FPZPccA0Xzr1lih/2fFXa1KMwSPM1
 RdEGr5iLohqUS1nr2ZhC0bgJdRetwh60KJDYlqfakl1lKtnGy45ZLsQX7qnuySelX7CC
 lh+3q/kIYhYhlKCqw0Tj4i7ry99iMDDyXKRrVbVxetsdwlYOFvUOjkqzr+bKEzavhVHd
 Luaw==
X-Gm-Message-State: AOJu0YwK29YzCFemj3swEwdBseIOSuQuk9vMi3Kzxw2304v3+57HHl/T
 vZfapDLyFNht9hkP+65FQYrJTdvwnoKNwtHtw9I/rgG/Jr5dEnT9SGJ/KfaX4XD5zG8oZMGPKdj
 fok/tB9w=
X-Gm-Gg: ASbGncsowptawDJQzSegDkUSZDEDH3qDucITnHrPts/RhU56Mq9/8kCYKMXlgbQ3HvU
 +ZFuBvggc2twsTNaUn2+X4AIQ9FAqBi3v0mOg2tpHB3uBg9npgdFERXjJ0GbC9U0vyPPBMSdjvu
 HN44YKMX0zwObUHejgiNhghzxk+xD1Zo2aXlxgAGMQE3qiK7XD9bdq5+v0wInTbk3qtY9xZjthd
 t0p4RzfmsG+rWWIUKxMAo2yiJo2n1jjZuHys/503S0Z6g5cYgq2mt779dcbO+yIfoEUssOISQZI
 9sDiy2JzhxVx/BYBPjtkmVQxvbb4UI03AjoosE15UpJTzcWbhjRKi8tGVOnPKqY4h6eQaBOHoGi
 g8D8/i56t/t4nq9HQ3ObRxpYjrI2oAuiPG5SPy7VVFBzLX5AN+OkXV2HhMqX+fc+ZCg==
X-Google-Smtp-Source: AGHT+IHPKmkVoCYwzHsLL2jcVPTzXYl/whVO9DGYSEDrAQzJ6/PZtkTqKoCJ/bG8mABiLrDLnnG4Nw==
X-Received: by 2002:a05:6e02:2281:b0:3f6:6ad8:6fbe with SMTP id
 e9e14a558f8ab-420a53af3c1mr10931055ab.27.1757618741352; 
 Thu, 11 Sep 2025 12:25:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f2f391a3sm854305173.25.2025.09.11.12.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 12:25:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, n-francis@ti.com, vigneshr@ti.com, 
 Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <20250823080615.1899597-1-u-kumar1@ti.com>
References: <20250823080615.1899597-1-u-kumar1@ti.com>
Subject: Re: [PATCH] arm: mach-k3: increase max resasg_entries
Message-Id: <175761874034.3939245.6691114162633122201.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 13:25:40 -0600
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

On Sat, 23 Aug 2025 13:36:15 +0530, Udit Kumar wrote:

> Increase max resasg_entries to accommodate max size of
> largest device J784S4[0].
> 
> [0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j784s4/resasg_types.html
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: mach-k3: increase max resasg_entries
      commit: e3e7d0d29aa1cb151650e4531c04dda613c374ac
-- 
Tom


