Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0ABCC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 22:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD3F8457D;
	Fri,  8 Aug 2025 00:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WbkIWzCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC1CB83C93; Fri,  8 Aug 2025 00:34:25 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F0583C65
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 00:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-61b50eddbc8so693200eaf.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754606059; x=1755210859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uh7sAcvRUa2T0i/ROX/oF1NQS8Ub9w4X2vl1VNZkWB4=;
 b=WbkIWzCHlTfs05e8/WZtSc6xkpX0/kp+nTuk62I/kNUdaeh0GrpELZttK0nPQeJ8YT
 OrhK66QYzpzMKf4T/HQUPH5wcjS8hvS7TJmqYPAxJuBgM2tZMoQA/PwB0ahRFh5cP+it
 bSzwawWDWXgm7Q2y6kazXMsgdQ471u3U1JY8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754606059; x=1755210859;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uh7sAcvRUa2T0i/ROX/oF1NQS8Ub9w4X2vl1VNZkWB4=;
 b=QAyC3092qjnXKXzbPXC6wEBllWkTIf419JPs9nFY4Ra7cWJJG45FgJW2ngFhIRTQ9F
 1uHnwndFdsi0F0zkksnMSxSKoCt1KlK8WIyJH9SOzc5VjU/PiHo1Bxjsw6M5wpPbhjH1
 83HDSAW9hdHBcHouTxPAr1WTu0qdCI8iNAjzbVG+Ufk5JvymbD7mz+p2Up/v27HNO1pK
 0hy+qDnuf4g7YgS0wMbdMQ9eR8pOEYBEKaCPZRai9NguQ6GADbjzbFY+1FEoPnHDAXYA
 uPVt0tOW+ny162GcNNgZhksAqHrGarR0CjqpX3hrgMijbV9z7xgWC4EoBBFNdPknOznp
 hTGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwK3V7e0BsabOTp9MWcPSCPMK+VblVZNlVvoHk8fDZamj+mLrO4ayG7AiQnZES2W9rPa/Kdow=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0sHvUqL2dQ2DLJUSrjmT6PTxPoayOw3IsVM4Z57cDKkmyoxYa
 O5JmM1VvgPieG8Zk4IyZR1QmmjLT2f36EPS8raa5zpP+JVphcdNdNN7KRGhVQ2uC9As=
X-Gm-Gg: ASbGncvc724hAh4+6lTleerP1FbBHVkD1GcCYGLulS58nvCk/J44mwAtRjOULol/seu
 9aapqgkYT+oEk8sifDKNryv5uFSlF0zAM9SEgMiZ1XnT++1ZAWvG0YVnxjzEkPHA7mLGiiGo5hw
 Cm+r3EOuAjwnhRIfYcr70elwGS47d+Uyi2v0eoS6g33aBbb+AFnZpAVDgzHfvxya/+ja2tPJbmx
 lDx3xw3XSQgbNdkwOwLF/506nevbK/j4VUPSx5SbmWf1s4egcsTCx6nTm7mF0KPPfoZ1ZGKX+nx
 nljfkJsC5DNjOtrnIbco7BAAHeOPTnrNCi4dxdTx/Nwcap3/QE5tZ89di03Jc5aBcN15FwdTvd8
 NNMCsFxh1yrqDNFSWUdFAgBcl7yGKE9GPc5ZlGZAbq9Tab7vEQDE/gao=
X-Google-Smtp-Source: AGHT+IHSTCj+MCdweDK5ZI/7F/cne2l9k0I5oYwSQv015DFXDLRHS9nUWmVzLmTOxxoDEYLsO/VvFw==
X-Received: by 2002:a05:6820:61c:b0:611:a921:bfef with SMTP id
 006d021491bc7-61b7c42d4cdmr350912eaf.8.1754606058981; 
 Thu, 07 Aug 2025 15:34:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7c6eaf6csm73309eaf.0.2025.08.07.15.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 15:34:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: neil.armstrong@linaro.org, quic_varada@quicinc.com, 
 casey.connolly@linaro.org, andrew.goodbody@linaro.org, lehmanju@devpi.de, 
 u-boot@lists.denx.de, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20250728162105.63429-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250728162105.63429-1-balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v1] drivers: scsi: fix inaccurate block count reporting
 in scsi operations
Message-Id: <175460605799.3039738.6383535634603230168.b4-ty@konsulko.com>
Date: Thu, 07 Aug 2025 16:34:17 -0600
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

On Mon, 28 Jul 2025 21:51:05 +0530, Balaji Selvanathan wrote:

> The 'blks' variable in scsi_read/write/erase functions is updated
> regardless of pass/fail of the scsi operation . If the scsi operation
> fails, 'blkcnt' is updated using an incorrect value of 'blks'. This
> wrong 'blkcnt' is returned to the caller and it assumes all blocks were
> processed correctly.
> 
> Fix this by updating the 'blks' variable only if the scsi operation
> succeeds.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] drivers: scsi: fix inaccurate block count reporting in scsi operations
      commit: b32dda34506b4f486bc803d0c7251f987edd2455
-- 
Tom


