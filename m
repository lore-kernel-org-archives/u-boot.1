Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0E1C5AC67
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 19:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F205B60882;
	Tue, 11 Aug 2026 19:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lke7tZyKwn8Q; Tue, 11 Aug 2026 19:04:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 625AA60883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786475049;
	bh=CQlyCn3mEn3DTrPULYLvXsbEDWT4/OrC821Eu33RBFE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iji9pzLHaavGQXqfatSA4GND9WtqU9e6rjaCoCfV3cDtqQE73mw4wpI3PWB5hBXey
	 TetVratzgPFLE5dNRIvmgOxnVMUB1AzWEO+TPC8LztJaj6J/9nH/is8uKPEW/iUExo
	 oxbxE+xqjCGTLkAnuBoJHlbSJ1xmwBURBqD+Cx5qwpoXIkrTeYqNMPK7EYv+XtERhx
	 cQQwgMmKAkC+vfjkadsP9iO+EvHvJ9pACVNsNx1lCn+9wMJlVCV1VDMZ9idCztUbkT
	 1CoqBv6svy1eQQ2DRB0J27DR5tHt21imEa17JoV0rLqC2/B86Oqgd1dN5PBT1nWbM7
	 vcgtpaqNjJHog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 625AA60883;
	Tue, 11 Aug 2026 19:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DB091F41
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16D9F80E47
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4wY6JiOTWr8T for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 18:54:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4AEF780E0A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AEF780E0A
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AEF780E0A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 18:54:23 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8234e9ea616so4435737b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 11:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786474462; x=1787079262;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CQlyCn3mEn3DTrPULYLvXsbEDWT4/OrC821Eu33RBFE=;
 b=N8KOK+6k7MFZ+KQoNUu0qr2eElqmPviKN7VMti1/Z1NmZDtxPA5CgljFCepLH8Hrm7
 ZPnKVKcnxSbvVwltkqx4uFM/vehm/9r9IeoiKydK3W6c7Qu2gyJDSO2dY9WYCe7n/lFp
 aYycDTwozAySrKyG3CoxLn6+hArcgWi2HTnI6qCxZcTJHq5DXp3/F45MkA3sBrT7CdaC
 hGaj0UoR4pdmcaqQf9ByedQNiZR7Pf9EC1lr0nUKkdhprioqL1MGld/Knhc7MH0E+47L
 mHvIWqepF/+Zak7yr5HmjUC4myb4cJSdyoEpPpyIT86Pk3FUDea3YlhQAJ7gRDTZwzcf
 KW7w==
X-Gm-Message-State: AOJu0Yws5UowmQMTLiq2jqrxcmhzudNfRCZiHA2dXvUMwAafplMwT4Kn
 DVwTBOSTpQFoPbohYVaZVVByDfdxIEnA7YKsThC4O0uS0oVRft+QFW8TuLGiNSDz2+wpwC2s6Ea
 pn7qbnkg=
X-Gm-Gg: AR+sD12VELWKnxxFfHHgd6vvpaH2A6VNqmHvR8GjXOhe7mwciw0qXfGu/ifSiWIbHrA
 +ju7uBTlwQbS+q9mxmcQAna2n0PQaxP6V0ErU/3eGZkZTEBjal2fmiseEniH4IYkVzQwHelRl4e
 z50l/5OI645biA3ytggrX2IGUbFUcDlX/FeKSnKmdiLMnyya2GpHyQyEqiRFvpJ2ykbppU7QWXE
 dKh6gvQrjcExzgrGsaT2playyU1pIwZAKt/m9A5hrhit/9EPQURik+DkgMxleMiXJdM6jPz6VBz
 7XoXr8zrzN/1p6izvI1Zu2CFc7hdBC/Ya4j652pAQKch38Hzo0vUiOOty83xLBI9rvHQ0ibt0dq
 gkJa1k39KssuyNX1mcFm4fs+YkL6IFkdFhFy4SV3xzIaL8lRR5L6A3sWhca7IIlsgY+fdGAawn8
 i2YJwivoQAlxdNTqR8hCXi9b/B45RTHQL7rIbnS5QIkubTAUXDbGy8P45Ox8Mdf6Eqk/46qh1Hx
 mGOwE9jJFM8UaQkWOJ/5gyA3FBmUY8rzj94do1lQwIeeSittsxoIf3xMNE6qNQI02ygqmY3HP7l
 KLuk7RIT
X-Received: by 2002:a05:6820:160d:b0:6ae:875e:3958 with SMTP id
 006d021491bc7-6b0ac5e4e0fmr1176235eaf.14.1786472643201; 
 Tue, 11 Aug 2026 11:24:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b0ad6d3895sm376777eaf.14.2026.08.11.11.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:24:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Hongyang Zhao <hongyang.zhao@thundersoft.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Vitalii Skorkin <nikroks@mainlining.org>
In-Reply-To: <20260811122549.2586034-2-casey.connolly@linaro.org>
References: <20260811122549.2586034-2-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-next
Message-Id: <178647264147.3076834.3877760013550717609.b4-ty@konsulko.com>
Date: Tue, 11 Aug 2026 12:24:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786474462; x=1787079262;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CQlyCn3mEn3DTrPULYLvXsbEDWT4/OrC821Eu33RBFE=;
 b=CqySK1ks7tUnvaJO7w6W1bpGCOlnKtXSMJj3GsIfWshk+f673WRZKbvkl+IITkl2aP
 uuQW0xczusRMwNlMysVy/lCG039vvPZ+ncLsNMuF5dhpTEx0FA6f9CioPc2EAibqgQQ6
 +KxxN9iYfzFA+un7q3qIMmAnggBNh6PLQ+AOw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CqySK1ks
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

On Tue, 11 Aug 2026 14:18:48 +0200, Casey Connolly wrote:

> These changes for 2026.10.
> 
> * Support for building mbn files during the build with the new mkmbn
>   tool
> * Remove UCLASS_SMEM and the old smem driver (Qualcomm was the only
>   user of both), replace it with a port of the Linux SMEM driver.
> * Refactor memory map parsing and support reading the memory layout from the SMEM database
> * Set the serial# from SMEM
> * Introduce initial support for SPL in mach-snapdragon
> * Add a defconfig for sm8650 with U-Boot as the primary bootloader
> * Workaround an MMC issue by limiting the transfer size
> * Add support for SM7125/SC7180 (clock/pinctrl drivers and UFS phy)
> * Add support for the QCS6490 powered Rubik Pi 3 board and document it
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


