Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E792C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931BD8168B;
	Thu, 13 Mar 2025 23:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RGblMFEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E968191C; Thu, 13 Mar 2025 23:44:24 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3015F8197F
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c559b3eb0bso90839185a.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905861; x=1742510661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Kqq6o8yzP21saPSZ65VANeaiIAbt8lE+gzPSr7ij+g=;
 b=RGblMFEcnJtQQ5xdpsBVpv88OjOA6W/jx3zMVgxaFJDrJe+E6DF78q7/kqXoXbFqk0
 E9S6Z3I9bUlEERLb+9tNz4owGQAYd6MMQplsothUMOXS190XVsPeJ8niUQHWZMMYA3PR
 6eRyI0b8j3ZdG5ZOJkwR0XcGsacRywPFaOkVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905861; x=1742510661;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Kqq6o8yzP21saPSZ65VANeaiIAbt8lE+gzPSr7ij+g=;
 b=ZW0xXxEMHZo00TmTSUcTsj2RKEBytSW7nwFet2/TkzhZ5MV5Bd4UAUqylDFrz4cJOm
 j24AufLmSz2jvJIcGOSZj7XHQipLHWK2AisltPx36WIJsh7z/L7rW2ykYtbN+iWOn0M4
 WXtUgm8EtEwNfucL4hZxm9ZCF4YNy6TLzZfZkw0tw1Z/bThA+9+Bxl3bozYrtkdjXIIt
 oWU8nes4UPEiUW4QoMWJl8aXirU1pttlSkUhwrtWRWZs8KLV+oWDpluxRP9mkX5DlBEx
 SjOIx18WKvo720EpW9vPo7Wk7M2C/ezaXnCaAGSQpIkNY4sQAZXMBNd4GyhxKqKcVsNi
 tpkg==
X-Gm-Message-State: AOJu0Yw/P7l+4gKTZt+6dx769cLyMC665OOuEL5KQoajHmJ0nzFmfQPu
 PTyFeN4P9L1ySk4nBUpBNSqV94oOzhi1sts3s9cPYVEUqKU8XhnmmLEpL+q6izEUeZc2ClxXZoT
 w
X-Gm-Gg: ASbGncunYjQEoV4gAK7wLsV4YioqueauAcGYcqjIHuZDBdIKL7CToGfr7d4YznlbmST
 lql7gDg1tPApknECJGfyXyQHVJ4lHN0THgxfH8o3mmSj7bBB3n+PFOJlqhrNz6eXtg7WpbRBq6L
 Az7O9Y67xAZSiJVNQHCL2wRNkBM8u33oPRaizSSdsZC7nfMqnzzat6lQh2J4xWnZHqj57+yo15w
 K4iyOabZvizyPxTB76vVE9F5hGr2N64KVPgYGUI8s4krQ2LOYH7jStpwDhH9C2KmHhPa+OZG4af
 8Te9ZCrsnXXlIlRwOCfW7nKPYQ4lJQHjjpvmKN3i3viPVeavb+c5tfo=
X-Google-Smtp-Source: AGHT+IFKl2c5sVAioS4vsSS5JONxHq5E+2/o49dt+TJE4asLkAtO1kYuRwUwRi/WMhwMabllfKBgnQ==
X-Received: by 2002:a05:620a:601b:b0:7c5:60c7:346 with SMTP id
 af79cd13be357-7c57c73cfffmr19348985a.10.1741905861090; 
 Thu, 13 Mar 2025 15:44:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20250227205048.4127552-1-trini@konsulko.com>
References: <20250227205048.4127552-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Drop last reference to CMD_REISERFS
Message-Id: <174190585903.2150240.12364289686286449857.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:19 -0600
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

On Thu, 27 Feb 2025 14:50:48 -0600, Tom Rini wrote:

> While the code was removed in commit 3766a249a3c0 ("fs: drop reiserfs")
> this reference in the Makefile was missed. Remove it now.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: Drop last reference to CMD_REISERFS
      commit: 6fd111bc4e84e039f1f59592693710703e991848
-- 
Tom


