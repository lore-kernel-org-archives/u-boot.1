Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF53C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E207E87FDB;
	Fri, 15 Mar 2024 13:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IqIbDmaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6AE87FCB; Fri, 15 Mar 2024 13:19:15 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8F787FBC
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6e5d1e95481so815303a34.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710505152; x=1711109952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5XAB3jhHR2x3Fy3YknpBTF39eM8INyAzJHLYN2UG/4=;
 b=IqIbDmaXrJO15ADt2ek2NnInv8qE6nZfuX4HiVEDyoZgDnKhlRiPotlBP/+6FMAWXb
 5hhWEsvUj7kNNpVHmEi4Oz+sAFM0aNnWXQflj1hM54atOJiCMokX+IEP6iNPwr5VtzJc
 87YV6+li9pDPurjQmVEX91wqUlt8pBrOvl3gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505152; x=1711109952;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E5XAB3jhHR2x3Fy3YknpBTF39eM8INyAzJHLYN2UG/4=;
 b=NZYlKVP8+TeclMM2AcnG+Nnoz7si35rpjwbR/QuZL/HWOEJHWm4BXLydr9+JSxxAH4
 ksA3eNbf3zhjeJUXKQkhWBJTZIUqoikmu6Pd1vYwDh6ndZLQBFSu5bwFCUDoCgY8H71m
 PmzD3DVKu/8Vq7OOG4ovqqlbdPl0WI9NUWPq+ql3b7/AxVzhXsyAB0chXmKWy1ulKqiA
 hLYiC1HT7dr3ZJ5J3bHiq6kHUFNMhyXB0XMcUSs0qXat+Iw7K7OiwLXqnVIK2VFjBcmd
 IKUHLrxJqIL+O2tPmfoPzRb0QYeRPK4gsSGObWju1RuwYDfVnZTd0JW9s+wfX6pUl6Mz
 CQjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbNmu6+bBwNh2MlU+BPSzQNcSR5izpBhJ0n4YuC7+0keFoj+65a2Jzb/ativnq0dEXPCcSPjiubG5/espYvamYVuDQxw==
X-Gm-Message-State: AOJu0YzgxT+jJzUazjHcEBuLBMfc7k5kaxj91dHwER3DWCjZ1wiscJcN
 X9577ddP1cbFgGr54R3iUXU/HzMid8NNmkkQ89G5jy/t+H6EheY7uzt+XUURK1JJBtxSlUBXNFE
 e
X-Google-Smtp-Source: AGHT+IFtePd/IlktyzR5KdEZiLMjYXvzYkSDVZUd8f7WGeujWgYpRwyfN4WecBZ3BhK6DzdUUw+Osw==
X-Received: by 2002:a9d:734e:0:b0:6e5:23aa:9afc with SMTP id
 l14-20020a9d734e000000b006e523aa9afcmr5009807otk.14.1710505152059; 
 Fri, 15 Mar 2024 05:19:12 -0700 (PDT)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 vu24-20020a05620a561800b0078874565b40sm2009011qkn.30.2024.03.15.05.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 05:19:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20240228072309.476781-1-heinrich.schuchardt@canonical.com>
References: <20240228072309.476781-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] Dockerfile: install xilinx-bootgen package
Message-Id: <171050515103.774434.15121352614963650549.b4-ty@konsulko.com>
Date: Fri, 15 Mar 2024 08:19:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 28 Feb 2024 08:23:09 +0100, Heinrich Schuchardt wrote:

> Bootgen is used in a binman test. The test is skipped without the binary.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


