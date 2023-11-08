Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E68C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 12:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87098876D1;
	Wed,  8 Nov 2023 13:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hRxjGnK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEAF874DC; Wed,  8 Nov 2023 13:57:41 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4675874DC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 13:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7dd65052aso84265347b3.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699448257; x=1700053057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EW2mTrekLtR/eyrMV7OsH4mTyMg+G99mGgNmn1e3X0=;
 b=hRxjGnK1fEIJZ4rUBBjcJXD0PtMUFU2AUavqNmjj8GN7buhIbE1MhVvlNPp1C5XT0g
 9WdRTlxAfARi/WQFeh4KvVOYTtOJ4gVSOyhjOnTfUlqfMDaumB0/hcpuYIzjRckHhim9
 IQhFI4IHVPqAJPFj7sqEI7be5u977JUrXV4UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699448257; x=1700053057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EW2mTrekLtR/eyrMV7OsH4mTyMg+G99mGgNmn1e3X0=;
 b=LhfyiIBS3IcGOZLX/YrNOpGS4d2S5JZyv4T1jZICfZvnQdA5LeufWE/K901xLkJuU3
 9l9/Tj8FQkdkCplzffh5AcAhjpR5t+uW/Q2lt+9YqEIeK258S9iSDBrka9S1L3URIvEo
 MUVDZa0ss2K/5GeT/yqo4X2QFvrmrhASn3jSayj3XnNDu9kTzhniQung/SK9rnrS1D5J
 kpdFy4qlrIyMrSg1XM2oMHFcoK/21vhw99AEaZeFwHcq0oPe2oAOPgbHU8H/rn+H7jR+
 I8hToFni84e12O0V/mnP4AOROYyTUkORyW4df4ym7Rqv6RJoAUfhdwSjKZ9IzeSmof52
 TBSg==
X-Gm-Message-State: AOJu0YwjxLuoWWwd/ZRJvxfcPF+dPxQk8lPbmIILhJq1gYWvheW4ahWY
 XN1prX2tIUBUQoQo9SJl7V+m7INmCnS6PVArObqNbA==
X-Google-Smtp-Source: AGHT+IGGe6kK+rXl4Bfzvy4xskToZc8CjeCO/SxZt+t2LMRBTwUgeq1/0eoK2uKqYXBAUtGX+/9mkw==
X-Received: by 2002:a0d:e604:0:b0:570:2568:15e with SMTP id
 p4-20020a0de604000000b005702568015emr1702824ywe.43.1699448257066; 
 Wed, 08 Nov 2023 04:57:37 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a814005000000b005777a2c356asm6640089ywn.65.2023.11.08.04.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 04:57:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Mario Six <mario.six@gdsys.cc>, Andre Przywara <andre.przywara@arm.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>
Subject: Re: [PATCH] scsi: Forceably finish migration to DM_SCSI
Date: Wed,  8 Nov 2023 07:57:35 -0500
Message-Id: <169944823775.782101.8542715076845833430.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028005951.1187616-1-trini@konsulko.com>
References: <20231028005951.1187616-1-trini@konsulko.com>
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

On Fri, 27 Oct 2023 20:59:51 -0400, Tom Rini wrote:

> The migration deadline for moving to DM_SCSI was v2023.04. A further
> reminder was sent out in August 2023 to the remaining platforms that had
> not migrated already, and that a few more over the line (or configs
> deleted).
> 
> With this commit we:
> - Rename CONFIG_DM_SCSI to CONFIG_SCSI.
> - Remove all of the non-DM SCSI code. This includes removing other
>   legacy symbols and code and removes some legacy non-DM AHCI code.
> - Some platforms that had previously been DM_SCSI=y && SCSI=n are now
>   fully migrated to DM_SCSI as a few corner cases in the code assumed
>   DM_SCSI=y meant SCSI=y.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom

