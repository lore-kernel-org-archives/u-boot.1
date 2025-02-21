Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B013C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD90280EC0;
	Fri, 21 Feb 2025 18:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jYvthD0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6E52806FE; Fri, 21 Feb 2025 18:38:12 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FB09806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-221206dbd7eso50630795ad.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159489; x=1740764289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myr35M7CIOJ8WoIOLTA4nGSEPqCGibgxBvp30ZPjk/M=;
 b=jYvthD0Px+Tsh+TZ0pVJL5lTCaybcNVAUgrLfYcfrCoHkyz2fXo7CuLgh/VocmWn2T
 /fi02ktH7sihYMGeJ3/CCFq8OWy6eKHz5Yu7XPfCIgr3vVLnGlxWEYAWh6YrlPl+t+VI
 0nxc1pkKYMMEXrObL7a0TeiElqwgATJjhgCKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159489; x=1740764289;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myr35M7CIOJ8WoIOLTA4nGSEPqCGibgxBvp30ZPjk/M=;
 b=Cu5r3DLySGPdBAno5LHVgzz5QuFRdCPKffupytlyeMIzUJCk01O+kVfxLqP7uXBBz0
 E/VEwN7wIufgFZFhl3bxsLMJBK/Awiy9tZBcomuwRI9u+BfvUsqBf2SBFD+rJaeHJrUC
 iBf4sPvq1ZOj4sXTahfxdJgFweqRlLf1EMKjjm45xb9AS598pnvhXQiQ8kntpbpzhVWs
 BvHxImzgN7TdL/4K1cg2t3uYTfMOSXL2/J7iWbjq7FwnX3klLlYZGZ4WLl8oHC11LabC
 D8XPyuvjeklATt+P1OP3Yd7E4e08T1u+UYzL6aOCFgjeaX9E/I1u1kTmP5NeJbbx3T2o
 qIaw==
X-Gm-Message-State: AOJu0YzHkRxKSN34fXTvundm+sN3x7IJddKPjBCb3WIRGVMPAmQ9PtqZ
 5KBHw3xRa4Zi/kupZRLm8R4M6L04yRYYX/5mux5W6Ds316cZIqNOT77Wg3nTs4g=
X-Gm-Gg: ASbGncsA9TXxKpfO6h261/Cy/IlffpIzIuUjjYa9afQwPxlE+wGQOR0q09ihJ5ENrld
 nzr/wNBlgksduXBetrkGB/xySPJIsYEP6lxJL4u4u3Yscms0jJxtd3XSkWdLJLYERm3U1/MUOpb
 dxKo8hMh44qeVygRyCQ6rUacpKY8mbV+DPm8Qo/t27rr2pZHqOWIR69NKUD8BZpJWipmqjs4KIM
 3Vg0FJ9EGSdUDj6bPxAUDp0rRI3mU8euuyMbjbqb3CumjFkLTb4y/rjxSgOO5nQh8fy5eXy6Z5U
 T80fx1eAld9Afo9HQk4R4Fc=
X-Google-Smtp-Source: AGHT+IEv7UZyQWYu4V3cnKZbhQtIx9h27PGLgEhMlvJGgji1EEGU848qmsD90mIbK+h3ONNEyjQS4g==
X-Received: by 2002:a05:6a20:6a1a:b0:1ee:68e2:8d7c with SMTP id
 adf61e73a8af0-1eef3cb3859mr6518497637.25.1740159489017; 
 Fri, 21 Feb 2025 09:38:09 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250212222407.684579-1-trini@konsulko.com>
References: <20250212222407.684579-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py: Rework test_spi.py to assert we found output
Message-Id: <174015948790.3526942.18375699442963115293.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:07 -0600
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

On Wed, 12 Feb 2025 16:24:07 -0600, Tom Rini wrote:

> When running a newer version of pylint it will complain that page_size
> may be used before being assignment. Looking deeper what is going on is
> that we could run in to the case where the regex we run for any of the
> flash information fails but since we don't have a result, we don't check
> it either. In the case of the rest of the numerical values we then have
> some assignment (multiplying by some value) and so pylint doesn't
> complain. Rework things to assert that each regex has a result and so
> failure will stop the test and we won't have any use before assignment.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


