Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26789E67819
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1FB8911B;
	Sun,  3 Nov 2024 00:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ftk31eOx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69EE0890D9; Sun,  3 Nov 2024 00:25:22 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE4C88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46097806aaeso23483191cf.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589919; x=1731194719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zpo2vuUejT9pEoQiVc8JSOQBOsDHb9uR/aSb4SdSdHo=;
 b=Ftk31eOx5MUuroxQ772JI1ZRDzySANhMQS21UlfBNPY90fGEdU5NI5VwMBpQV+pZ7a
 8YH9IHt5EOHcSmKmyGEomq3bJTMZh4AQ90UGIqlnTDWhIxHf62XLr69/PFg4qgipnftu
 QtrtHpgRVwxnyyhyt+f2FTeJWEOFeqWS/35bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589919; x=1731194719;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zpo2vuUejT9pEoQiVc8JSOQBOsDHb9uR/aSb4SdSdHo=;
 b=rXQwP8eo5Aa/4K6/FxBXTfcobWm64wTEBNrYHO6JGRCckGkqAJs8zvy61wXm1rb9/o
 7sVpSU54K1CDmsFsCdMTdnZ+ZBCFSEoGzOsdyKtwZNny1pkODxMIGKMYAIEmnWQM5/Q4
 SWmNigCFvakaXgK5SCD4+RD0owhu9f1rKPGsEfiaqFPCMkewSodBgP+jfzj/a5leQreZ
 hZjbfkg3lg52yXuBQBdqjfl7nl986aopkxbvqHNvVje+Mg8egTXRqZa25MRLBiaftBDk
 7mVRy7qydVA6i8S4XYh/+AlnEEO2Xp42sUjY3zKnbOyzG6qptkKyd7VexINy++CT/Wne
 b98g==
X-Gm-Message-State: AOJu0YytgbJy93toeHXEDLkCZ9nRbRKqMA8nBRtvlTseWFxTHKgLV0Y9
 hb9qOKB4LWBaN5eAnWO8/s1sbhRBa6wGPLBH7by8/VCzSvIEEFbiheEV0rwRBXkOypkDRtLC/+l
 9
X-Google-Smtp-Source: AGHT+IF119FR+9d6Yb4fFue+UysNga0Yj6xnNwDxu0Vn0VDirSX7+VLc0X8Y0et4FezExUEWByJrhw==
X-Received: by 2002:ac8:5fd6:0:b0:461:1396:96fd with SMTP id
 d75a77b69052e-462b86a596dmr116726141cf.25.1730589919169; 
 Sat, 02 Nov 2024 16:25:19 -0700 (PDT)
Received: from [127.0.1.1] ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad19b4f5sm32412141cf.83.2024.11.02.16.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:25:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Julius Lehmann <lehmanju@devpi.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de>
References: <20241026-fix-scsi-disksize-v2-1-bc6be9a6043d@devpi.de>
Subject: Re: [PATCH v2] scsi: fix disk capacity too small by one sector
Message-Id: <173058991721.1044919.11636976888031217648.b4-ty@konsulko.com>
Date: Sat, 02 Nov 2024 17:25:17 -0600
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

On Sat, 26 Oct 2024 20:06:44 +0200, Julius Lehmann wrote:

> SCSI READ CAPACITY reports the address of the last block and the block
> size. The total number of blocks is thus last block address plus one.
> 
> This also fixes the corresponding test case.
> 

Applied to local tree/v2-tidy-test-dir, thanks!

-- 
Tom


