Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E01CD98C7
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 01:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85EA848B0;
	Fri, 12 Jun 2026 03:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tcxjZJek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1A184717; Fri, 12 Jun 2026 03:59:16 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 452FE8005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-43bfe055ffbso413856fac.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781229553; x=1781834353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AlROyZ1tkEyRGVFI7CodRdibzuAOMDFDqP+LRiToBG0=;
 b=tcxjZJek2BCkaZU3nA808XUm8Uov6uqXhEf//VLpEfcFZ9I1waoqw9WCOxtVo9cmDi
 GuUuqkfuz+1+A22CC7ASo8CFdNQb153P1iehkNKFF2qhCeQ999rQpaplncTtvq9xUw5m
 4Qg22hM0PxDf37hgE7cD7Z8BI/Mo65YM87cGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229553; x=1781834353;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AlROyZ1tkEyRGVFI7CodRdibzuAOMDFDqP+LRiToBG0=;
 b=Sy07Zd6dR8sjF2kInGlXLPMcSTDBZRkEzumKn7NxwmvVQolxdkmmWsRF/RcYSYk5xc
 wY4mstg8AR72vZehYzCRpn1lcQ1nJ/bSxf9w9Jy4bDD9LlVsoSTG585qtz4//KyIyHBv
 BuFtBnaHZSPktEg/iJkhFqBjUQKD0iGkd0uwjfsdr+PkomkFVRn6SEKenz3k3dPVNkRm
 PKN0mr0c93cjzQzmXydT7gkeDPy6txeT3dWhQpOuc2azBrXRS61RIfkqd4r96Z4xyb76
 N4QcILnW7pvJmfq9/VOjRw9mBKHVLGhiQMqyt+AQNffMAsfrxtfSPIzXUgd0CP+MVMSu
 4ccg==
X-Gm-Message-State: AOJu0YwvYOMqJRUC7RsJHuL1r/OFsm3NTFd7w6JVbwesfdtqE8zN8r7T
 scsSCNbqQv8UJPv3YmHv1TDlZkWQNNtj+nPiSzbYXRwVSjf7KZ3b3wUxUUmCn4zrGykcnxU7lEJ
 UbpCMelI=
X-Gm-Gg: Acq92OGK8rBRPSRbFvNhBeE0rjpDtWKHaQ/XUFMT+JUtGa7/TSGE3u1RBAsZT4XWXy+
 UJ5W9xATs4eMd7y/vr3/yWbHl/pzKzy+KpOtCMuXT6mPnDAdQN9RjHNwhRX9sYmtkhNIb8ihUh1
 zjv0iwLnNaMeUJXr55iu13YRybHRyZwYVuRoNlShtDxAIUa/eitprxBMwnc83Ogv37AEFbanxGS
 CMkCEX9BPDMES9DcqsniZGZeGAZfyPBYVxnGHphEhxuz5fGmzw/+l4pnLX/bRHlHvTO7obsUOo3
 MJW9e4JPjLQyGFc7+gx5CJkKhJLffcSsIMdm6r/3sZKNOTqFV8Nk/jTI+956FlzqJQ1xL9ovMLd
 bu6dZ5VDO1gFPnQAnaNPLAjAkW0+wLEOGgI9z3qV1/YdDFE5YEnPmHSbTGZibCOLx7PBAnL2CSQ
 /ooatdPOf8SSqXh/mIfrMOV62yxqNTrnXCvGytwHTn3ZL1keIlrRwJtWKr16qH3MVbz3AxANB07
 gyPAoZp21IVI2EXa9+VmrGJDD8mYxt5dU1yV6LzVq5DKHBeUOd51ZUCAA==
X-Received: by 2002:a05:6871:3861:b0:43b:50fa:1c23 with SMTP id
 586e51a60fabf-4426dd348femr479752fac.13.1781229552973; 
 Thu, 11 Jun 2026 18:59:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426abf184asm534734fac.5.2026.06.11.18.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 18:59:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
In-Reply-To: <BESP194MB280511C6E8C0E257362BD50ADA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB280511C6E8C0E257362BD50ADA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] drivers: gpio: Fix dev_read_addr error check
Message-Id: <178122955215.605671.10586892372077515116.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 19:59:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 21 May 2026 19:50:48 +0200, Francois Berder wrote:

> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
> 
> 

Applied to u-boot/next, thanks!

[1/1] drivers: gpio: Fix dev_read_addr error check
      commit: 9d551d78f74846fc4c4f2b369ca7da420e5e1fd6
-- 
Tom


