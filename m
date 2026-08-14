Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38257C5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C92F540D62;
	Fri, 14 Aug 2026 13:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLQqy8D0HMur; Fri, 14 Aug 2026 13:51:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B637E40DE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715484;
	bh=g5JJRBR5IiW0o1RLL67FAXjKf8SDasg4hhM/cNPvXCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NWLt5Lscg48Yb/TV0+FnJD3s139waFVdbAvtRwmNgPe/97SOW/ZqR78FdWyUW5ezS
	 mSk9pNPE4wDkl4gJLVua/0Hzr/AMtNjWIW9PLFZf+2CeFRV41clha2T7vok/cA9z9w
	 drFPByjXfui63bSXwnRUO/IWfwZumzpt/2cbRj55tojUqXIr5MxEl8jAL39CPbAblL
	 heIlIy5eO+G/GMK0346PiTuZF5vlUXvbCGnkHXSmtd4qIrMc0XaTB/MNrFoQwcpT8U
	 e0yDAEPU0cxC+zV+Qt8EW5v8g4U6gjj8mUOI2i7QaumfEvaN3d0iSQ4tllPtjqusow
	 FJqE7NFsn21Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B637E40DE7;
	Fri, 14 Aug 2026 13:51:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6296633B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54497608BA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOcvujJc5Cqm for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:51:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4DC2660626
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DC2660626
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=tYB2lIYO
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DC2660626
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:51:15 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7f39cfb65cbso789669a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786715474; x=1787320274;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5JJRBR5IiW0o1RLL67FAXjKf8SDasg4hhM/cNPvXCM=;
 b=tYB2lIYOyP4q2UAcM2+eKDKHLxz3nVVi1yoIwhz9JyLsgh9moJ2fOeBlo+7SLGIslo
 tMB40x8pNzZicYlX/Kg2Wi/2D5p5gMrJ1RNGTMPn8LxXfGeFuepoLVv0F/SvWPdkxgN8
 IBnd9U9wHRPPWoeNn5fDlcuoFnG/9GtNZVpvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786715474; x=1787320274;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g5JJRBR5IiW0o1RLL67FAXjKf8SDasg4hhM/cNPvXCM=;
 b=sjd+qmMS4rkf+gwDDDeuh21AuS8BIIMMisx11UggXfnLiYpsP7V5NkQ5oboos2pP6D
 Fi+76E0JleoXenaf6fbRDy+ZDKRrkYbDsdH4fN9lKbU7pecFJX7je31fwPFeTazO/s46
 rA/RWNWJGHSWUILENnx5sd9GqUiwp8AqzjVE4NVXy4q1Cv9jf62n1MeLOIkhBsNC/c1a
 0fxIZA1g7+qtZ2H2f8zEttom7MIi1u5izNsZNZ1+1PWS8dkT6TxWlkZPmlGhxOOxJ3bX
 GRnlwdnR8biaT0ZNJNdIb/nxBIxBNMclJO5EPd8uK/kDuD0U3LCtBcgtTPgnfkR32VSy
 63tQ==
X-Gm-Message-State: AOJu0Yyl0Q8MLy9lL7jyxo8PD91oI5M3fSLDG+myuTHJ+vxx2KvIZ03Q
 TPttJGU/G69wybl/DYpVOS8SaT+9juAe4PWjjvqkn3E7vYfiyIfi0cQSfKZe6NzSYOKFhDPwMDD
 ZDsnZq9Q=
X-Gm-Gg: AR+sD11Zb976ps1Kc4wEYqX9FRwaUWE0PWrYMG+PsVKN6p3qVkgPlK24XU6BnGHvcCg
 W5ZKGbWiZx/OY1/V8SDSlvYXiCgM9ePSinUGQL/iqzLzkPERPgHRxzOYdu5vqLLWekTn1s1vtk8
 o4nBsFieAF8qSB9YFTyV5vn3019QdMWTQDt0A1+5HS0fxHOPUb3dcG1EA5jx5RwA9czrxENzcFu
 +Kwk6vGsmYT8bGHSpHEJcBhz4DtBFpvZkhwKSgrvcfZhZNCojLSRYsvQfZYHUeZ81WVk8CsSHH2
 mjUw+oDkP4BgUvgBPXZYdK2Rf5oh2FnHyvU6JQlnDNv3VqGlSW4qHqXDxTQ0lFolVoTrvG/nqxD
 SP3+0URRLeye4ofSRxIXJZKz60A27uOgGh078thHK6k50tumZe7JawLMmD6SfHjld9oiyRASfGQ
 yl5aiwEogXf3bv0kfYZEboA63WzVloOw8tDnUrHtRlbUQcKAmLPzbWbJCXE6WQvIk3/U7+vfIqV
 YW0ZdRaF6dA8gF7gorPjLOAnH8BhkiuH39r7776+Qsp2lQWQSIi+Ps9XGqevDejNe2ZMmBIDvY8
 43J+H6bd
X-Received: by 2002:a05:6830:441e:b0:7e9:dd7f:7a83 with SMTP id
 46e09a7af769-7f3de1e5583mr5034481a34.0.1786715474041; 
 Fri, 14 Aug 2026 06:51:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86a2271sm977086a34.27.2026.08.14.06.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:51:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: ilias.apalodimas@linaro.org, chiawei_wang@aspeedtech.com, 
 ryan_chen@aspeedtech.com, BMC-SW@aspeedtech.com, joel@jms.id.au
In-Reply-To: <20260805160443.181600-2-prasanth.padarthi10@gmail.com>
References: <20260805160443.181600-1-prasanth.padarthi10@gmail.com>
 <20260805160443.181600-2-prasanth.padarthi10@gmail.com>
Subject: Re: [PATCH v2 1/1] arm: aspeed: Add ASRock Rack B650D4U BMC
 support
Message-Id: <178671547316.3828101.7691547056094343416.b4-ty@konsulko.com>
Date: Fri, 14 Aug 2026 07:51:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 05 Aug 2026 21:34:43 +0530, Prasanth Kumar Padarthi wrote:

> Add U-Boot support for the AST2600 BMC on the ASRock Rack B650D4U.
> 
> Describe the 512 MiB DRAM, UART5 console, watchdog, 64 MiB SPI
> NOR, RTL8211F-connected MAC0 and RMII/NCSI-connected MAC2.
> 
> Use the existing AST2600 EVB target infrastructure and a
> board-specific defconfig.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: aspeed: Add ASRock Rack B650D4U BMC support
      commit: 8eb951f779925a1809a6fd173ed57bbbd6d7db9d
-- 
Tom


