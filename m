Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C8FC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 21:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AC8160AAC;
	Tue, 28 Jul 2026 21:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MIhTJOodR3P; Tue, 28 Jul 2026 21:57:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E252660A8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785275832;
	bh=9CPUiJKdDrzRUgiJK0cr/tqRss8ID6F077suGIF4Gas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGKWb8NBch4l0nnaPLMUzBgoe4cclnGn4Mbxzckw6RcM/upTXlZGdbSPiptEXQOzZ
	 ayaZ3z01VwgwGXASdgmcoRn23A1Gk4U+KFIQmlyq5NnXCn7IJ+FKI1pwiXxUmPB6gV
	 ac+uIHgonzkmHVuyvA8l0iABacTDB0mPD+oWqaFeqVRlktnjKSMpIgqf5GsYWOC+OZ
	 jr2KYCDnp2bBc3zUPo6NXpGIbilvsbX5TcZuplhM6GlaUKDBIo6oIBKcPNsLo6U7R2
	 BK/wL75PKyFAxtHuvobNsvbvBhAEkcTkSkpRWYiUGmVg3w5qTbPu/mjVFTbLZOWGLe
	 MEhHpASiwAClg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E252660A8B;
	Tue, 28 Jul 2026 21:57:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05B12350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC23D408BC
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkRHk3PHEf_C for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 21:56:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C4850408AF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4850408AF
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4850408AF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 21:56:51 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso233933a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 14:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785275811; x=1785880611;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9CPUiJKdDrzRUgiJK0cr/tqRss8ID6F077suGIF4Gas=;
 b=k3e0p0Gf7/PrthjGeGdCKWQDWVCpBdg2u38eKKSVFgFFqR5llRRVYj3pPOY1XJvGXi
 rwVoTIuZIKwmGjJas6QV6Egnmc9c494FgfTJ2n4gAsKiWjzJmUgxbzzXO6vxoYNtKUdm
 7UjPs1TdCGGmqlQdpc/OPgMlPmU4Adwmu5mv3ubJBfTdSIXbGgrYuzMyKVck55rnffP2
 Mj3MjAZHL6uwX1iuaqaw6uhSx/RoI/bywEReinpAfp7b4tOntwiJMSyTskK6X1f1RBI8
 Ynh3nrrO5HRdJmvYaX49kxSL0VW+YSaq0eTRZd8IeqEy/fSp4XYOO2eF4nbpiGcwiaee
 z/Sw==
X-Gm-Message-State: AOJu0YyJeYXZOu79S8pn0T/IAARX3pghyzHwWDJUeRqtI/O1x+B9TRAj
 QwFOo31Xumr6fA3CjjsuZzAjWBPSx5UWmDiRulqKbQMtf3NLT2Ny9OGm4N7pSY9kqAvEUtUgcj8
 /fX+1iG4=
X-Gm-Gg: AR+sD12mX43WTYj+htOKpGSoICavvgnjPhYVwEH/WKe40ZNnqhTpss6OqT0DqleBOpd
 qie96XoV7YooyuvF2Hb4SehdaeTK/buOlCjuaw1CJkd27wL97rLDGyS+G+HC6+1iF7xo1T3iWXi
 UP1TEbBRD46VYPdx6ufIc7hSe4/FgdzsRKJsIbfVUjt51LlMRImoQCWatKxMdBAVebJQz8QZpfa
 RDORtlNUbsHOz4UVjfIp7hR15KlqL82uSBKH4vUJKQFcvbhSqEWwDRiGicKK61l3mp4fnvMF1jB
 fKetWs836Lh88p9qW4TRgBnnCFSy3hyghDlIUZEGDdGW8xajMehHgNb76+jXpz0n7tbDntM4SW6
 JAAjJWBf6AGskzw2B0ogCNUJuAMPue1U6FflPNaGKPnYUY25ngtffdSN6tsG+EKG212QOkkPCqQ
 WqFnDJ8USECl7WjcWI4wgFoYm/X0FizcUXNke5X/jvW4lTvbwPvrnTWV3gG2kcZYgR96f+/BuZp
 Q4OytOQAU8DU5t64ElbNgMiUjoPIeB/TdsUV4oxMLBpCPmktGNTpycWNof5C3lhlsNO8SYcLWe5
 V7zZB0Y3rt8PBZLNqUc=
X-Received: by 2002:a05:6830:91e:b0:7e9:b537:102c with SMTP id
 46e09a7af769-7efff296d0amr2262300a34.25.1785275810844; 
 Tue, 28 Jul 2026 14:56:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d2d8112sm780106a34.0.2026.07.28.14.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:56:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Bin Liu <b-liu@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20260716145437.1686611-1-b-liu@ti.com>
References: <20260716145437.1686611-1-b-liu@ti.com>
Subject: Re: [PATCH] ram: k3-ddrss: fix ecc range checking bug
Message-Id: <178527581017.1742553.6501393253781872677.b4-ty@konsulko.com>
Date: Tue, 28 Jul 2026 15:56:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785275811; x=1785880611;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9CPUiJKdDrzRUgiJK0cr/tqRss8ID6F077suGIF4Gas=;
 b=hVzmiTyIqUawSss7ifHnj03rcmRyt4YGA+xsmSnY/VuS5yPvrq7bmlWZe3IOVxWDGh
 2iarDVxdkuAKllx0UdQYAH5vYT0H6Gl3Gg9vO9hmIZY/NXOrdD/xz+7dPopRNmIBgiee
 Cqdy0fhWiluVolPM+fj3RQODLUW0uHRDzz/lw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=hVzmiTyI
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

On Thu, 16 Jul 2026 09:54:37 -0500, Bin Liu wrote:

> The original checking is wrong, it basically compares memory address
> 
>     end = r->start + r->range;
> 
> with memory size:
> 
>     if (end > (ddr_ram_size - ecc_res))
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] ram: k3-ddrss: fix ecc range checking bug
      commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
-- 
Tom


