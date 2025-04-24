Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B0EC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559288056A;
	Thu, 24 Apr 2025 18:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z9XsvgTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6E681F54; Thu, 24 Apr 2025 18:43:50 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C94082064
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72ec58e45baso859099a34.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513027; x=1746117827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efna+W+6eszR0tpEd4gPE13EBkor96sEnU85Ay83awg=;
 b=Z9XsvgThSFOpFUh3al+28bGMSoPDvhDw8Ndj9hAUCOTscW7Q6HeGJ95oxkL6PdkPnb
 26RuQ4pN0ImHBcSNjbxB81cb/ELmD0D8F9xwl3Gf5PAzHtDZwDlzgmiKv9mfuRK/Aw9n
 OShdeG8tLAQ/qatuQ+l8wyDJxbr25uyT+6/dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513027; x=1746117827;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efna+W+6eszR0tpEd4gPE13EBkor96sEnU85Ay83awg=;
 b=rnRdmU5ktEvYD21EhSxvn070RBstLlhjUgR9nZYD4zAAN+eRUHduftkXPgObZFlhKn
 lIhtyvj6XXk0t1xJtQmcxDz58kSSy4YcUN0NUcXg5JXYJyORUVVY/2lMEquljCFkdxG6
 CpwsWJ7vbkLhf+cK3n2dxC4fyICoHf+UtS2R+ypPj4AyWf0JeEM0AGOTMv8Dvc+zKVYN
 toben1X0bDYSLuNzsg4S/d3oVrdtsegq4SXrcnXjE0poCfhcg4toaTRwZg4nR7v1TOw4
 xuL5qf3/Z0DcbbVWmEZu3LJSaaNApUXZu5iR8EZCapFzbhEpa7D4Exa+Qu79JTRRUNw3
 6GFg==
X-Gm-Message-State: AOJu0YynN4ijP3phuvJvppdi7Hd1iyqw9GC9HiWywF5Uaxu/6K10xmIR
 hMnLUb0zIahdMhFKUhOtfZpi2Pp61y+ZVhdTe3gec1ZUaB1TjLh4RhD4EgRjEdfea9ogcFFY/vc
 4
X-Gm-Gg: ASbGncum8d/jgRnQ/79JggQbd4kZZUnZRXX3tMRjhT09pYf476FVes83+CFM4BJKJXE
 fc07cwiBBX0pcmog0oyaFitVTGKYNTTG0x7Dr0J1BJ1LkaLEW2KkeyOVWi4kDcYhKs800vZI/8E
 hgPbyo7aGOhXK0NFoMsXAKCJ8OsYkrpr9pHnww9LrYQSEGCJAt3EAB9mP+EzaPxmkcSk/WifqbH
 n0vr3YnCAMxLJzJIS2dYsJTVSZUc3AsPKGiGQ3h+Negydi0h6SRx4ZuDMUbHzxAkuyXKaevT1Hh
 peIysYVXA2qxSTOLIRV1PtS0jjj/wFeFl/6B8CnLTvIZQzOAt6jl6Byu3FAcdmuN+2RhY3CgbXK
 He/s68xhnZ2g=
X-Google-Smtp-Source: AGHT+IHJx4pPMV7nqSTU4wrvQygUYmF+wLbhAM/l/DiadwVmsSOOAK5pTSV9ekVoumnDdUjhjg3vlQ==
X-Received: by 2002:a05:6830:6304:b0:72b:8326:f0c7 with SMTP id
 46e09a7af769-73059dcdd45mr333130a34.28.1745513026857; 
 Thu, 24 Apr 2025 09:43:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, n-francis@ti.com, vigneshr@ti.com, m-shah@ti.com, 
 Bhavya Kapoor <b-kapoor@ti.com>, KEERTHY <j-keerthy@ti.com>
In-Reply-To: <20250415173651.88646-1-u-kumar1@ti.com>
References: <20250415173651.88646-1-u-kumar1@ti.com>
Subject: Re: [PATCH] arm: mach-k3: r5: j7200: Add clk dev data for WKUP
 UART
Message-Id: <174551302557.4069373.2900068236515817511.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:45 -0600
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

On Tue, 15 Apr 2025 23:06:51 +0530, Udit Kumar wrote:

> Add clk and dev data for wakeup uart to enable wakeup
> UART as console.
> 
> 

Applied to u-boot/master, thanks!

[1/1] arm: mach-k3: r5: j7200: Add clk dev data for WKUP UART
      commit: 40184015ef8348f0a5b9a61a6188f678a10c3a2a
-- 
Tom


