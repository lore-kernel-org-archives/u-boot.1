Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265EFC5516F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 19:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E43C86069A;
	Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uv6E5ATMSVvs; Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1390B6067D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785526849;
	bh=X28zJElKvjRhkKMSZS+GjlK1H6ulppKBqjGcNYn06Vo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vkTw9npYI3wImRCMsEobC99rG6NWzuTavclUjsS1X2dKjQ1nCOb0cdjLAwrLAkV3b
	 0yA8MGW5Gc7lzPI2phP26RtiffP9g6T7K9weiGHM1wIE+4M30intquk/llzjf0AAWy
	 WZMNYeNtwWk48sFJj2u9PXVi8LMsJCU2W5Ja1PlTPcaWI06JyU04Jaoc4Ie14NhGsg
	 r8TA6dqQz+WO3DJNx+l7Hple5kbjnW2nfSYC43JXwH0MCCjeAVU4keXSOpOWngGahe
	 zfmrXiDqez/C5j7XfrgEw39oNAwgpzenHlCJeGyXsOFSCcwvfo4EsDm4ZQQrC6Ozuo
	 79Y5gKksy71Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1390B6067D;
	Fri, 31 Jul 2026 19:40:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DF6636E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3FF596067D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3HMwu54Xpmk for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 19:40:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2A0626065E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A0626065E
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A0626065E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 19:40:47 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7f0167e59a3so747957a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785526846; x=1786131646;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X28zJElKvjRhkKMSZS+GjlK1H6ulppKBqjGcNYn06Vo=;
 b=V5W+w5hlZjuH05PFuk1dpkqURfiYDdug0HGY/wRmgpFtHhbcY9rxINGZfnO7kOsxiJ
 KvQ4ux5LPOIK+3uNojuv3gPIQBVz8+Ve7Dff5DtQpe1G7GXpAeEoi/t0bKNLYz0E/gnU
 rwg5BDz2atquLYHYrC2zewvX1bw+FlBAteecT/Qhxhs7HOA5+i3jz21X6Pb1uxD0x7N5
 j2AfApWymdEEYrmhmU/X5BrHGCNTvxJiamnbaUQlz1eP5Ew66eQWpmY6RsPeATlnOkQa
 ozAlFYnZYIjbJXzkXSV6AXxi4pHeIMr4Rydbu+f2zFCeupFP+YjdG4bpa7373/aD+1T5
 uE8A==
X-Gm-Message-State: AOJu0Yx01CrEcvQ1dwgVbyEsKEwGQu1XKZHJ62Hi+eYcX3zv93fNO+1B
 2Pa3gvUeFKWNXkg0R5c5pvtFcuQk0gnX9x2JdCW8Se73on7i8Gkiqc06PSV4Qu901I5a683qmcl
 ZXmb1atg=
X-Gm-Gg: AR+sD10GR9xZOy9J3aYMIEMZCP4iV+Zj2iknzwv7cTGXokZht8OH0HZsnMDRf2+Hef9
 f+rFXJ66Nvl2po8X6VkzLmNdBGQhew+PUsOqnFrGSlB2XvIFqWiU3uMnwOlH5D5geEL8IDoTtF0
 pGWH7y09gaRRix6SlzcoYNEW6ayw3V0Z6BaUp74LkZhH4rG3VH/FF87xLlqfjkwFe7Y5rNcTdEo
 QpbW3icEsngvLTp964vAUSRizLemB3s7tuYXUsMjiEP93UqUkZWI3qw6lyV0UpCjM8qcnnW8NrU
 XRdqKqsVWM9NsompZMe/rXIQEnQ/J1chhB2b0zeiu2i4VQZD74KrUxg10e5qYKvKWYTEG0YlOGD
 FaDNfiRpnRtz10T+fK0xKhCUh7d3btdGh7h2MF93IEwMwJTJvghAfPgeENNoYTvfiJJZrQsG++5
 CLZn+KTKpIS+UwOHQxsTS7rVKijxOjhI6jlLw0P3kgVm+2EIy//FxeV9XF1H3igHKyymOC/2lBs
 Y9WJBAjMkwzlaVSl3Yi/DLkvNTrXWqyRukH8ghXxsDgxb+mQkcEmDFhfIBRf7DOdysFJCGsPWzh
 SCzEnRd/
X-Received: by 2002:a05:6830:398d:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7f19691e7ebmr2511473a34.0.1785526846151; 
 Fri, 31 Jul 2026 12:40:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18eda635bsm1465662a34.12.2026.07.31.12.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 12:40:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260731063548.1915557-1-stefan.roese@mailbox.org>
References: <20260731063548.1915557-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-marvell/main
Message-Id: <178552684543.2534773.17197296551442917937.b4-ty@konsulko.com>
Date: Fri, 31 Jul 2026 13:40:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785526846; x=1786131646;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X28zJElKvjRhkKMSZS+GjlK1H6ulppKBqjGcNYn06Vo=;
 b=ZtVfFNdkoE/zE5NKrnHCmQZWVR7o4RQGHiII5V9jmDHtzkzK7EJ6yg4jjyp1diBuQM
 MCCHXYSA5ucAIsDc//aRwKD/C3Q1j7SThdggBrKFaPVZ0eeTLR/8w1IN6KiHu0g6YU9k
 vfE+RfCEnY5HZCr4hCqa7nqb4VeHo6mrZkOmk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZtVfFNdk
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

On Fri, 31 Jul 2026 08:35:44 +0200, Stefan Roese wrote:

> please pull the following marvell changes for the main branch:
> 
> - arm64: a37xx: pinctrl: fix info->dev used but never set (Quentin)
> - arm: mach-mvebu: Add more AC3 & PC3 variants (Chris)
> - arm: mvebu: Update docs for Allied Telesis x220 (Chris)
> - arm: mvebu: Add Allied Telesis x960 board (Chris)
> 
> CI (GitLab world build) is passing:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/834
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


