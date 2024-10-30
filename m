Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC66D6B6DD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 22:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344D38927F;
	Wed, 30 Oct 2024 23:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SKqFLiP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12A58925C; Wed, 30 Oct 2024 23:59:39 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DB689245
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-460c0f9c13eso3491891cf.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 15:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730329176; x=1730933976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EGAJ4yGMMHawLqsVzDtM20K0+h9vqO+GPiKuqxBoa4=;
 b=SKqFLiP46ayXBnUUCVX2tkkoGL6qsDvIrpenm+N76O/BvWEO24t0LiSp1CheUjuOj6
 hTZ1eF0ky0TmLtkYJplDjU/EyP6dLMDJFsp6HuxppVitN/GDQUhij0Sg4Fha10j1Bt5K
 JY4XDtnrE5YkQBWE0mXkmWkmaADuPBiNOKOY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730329176; x=1730933976;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EGAJ4yGMMHawLqsVzDtM20K0+h9vqO+GPiKuqxBoa4=;
 b=uTrh/BStGjscO6TmsU43zsokzuANhPxcz1EgAJiqOhIUSkJGUIbPQ+J7m58Ck9V8LG
 9Hu+6CXUpdIvscjGqWLK2jLI+Sm3NbZKH5iD2/yHFG/3diAjVFl9Q9aIbs5bR6RjopMe
 So6lZGhKl77L7u1Ye1Ud0dfR7jF3vvTsPZEQ5uRE/coC/FeC1eFlmbAJy2CyToJ4IiBl
 0dQlAzT8NoDtmGD3795/IUVBuA8tMUUjzUOJ6BnQnsmtz46Zs7CDfyli+XrdkapNe2ud
 ZFxdCdSOAKkdYG3Zi3MImLC3eCbxmZgI5Tl7b2ZPqP3B4G0Z7PnUcSNzI7AoSbbkeD5+
 7rRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRTRNoqkHszZzkMZkH3G1gI4robmyGUYgUVNs/paggCNPWtBFpGHljFV8XDL1howXPneHcQdE=@lists.denx.de
X-Gm-Message-State: AOJu0YyfxHuje89bpit6Sg/hruNdzjbD5JQNusi4WalKSRqdnzIN4+sQ
 zLPfuRcCdWboQZ+gEE0TDY3WjKPYLWZNcqwq6TJidqNH5/5Q1b5ZW3ZYUyAnMss=
X-Google-Smtp-Source: AGHT+IFSEvb88BVXjtxX2k/4GtsIG+TMPInl7n1C3F7JNHh6KWoRL6EnqB+DgN3QnWSfisNcewtb7g==
X-Received: by 2002:ac8:7d92:0:b0:44f:fb6d:4b2f with SMTP id
 d75a77b69052e-462ad32d18fmr5167231cf.23.1730329176348; 
 Wed, 30 Oct 2024 15:59:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0896e9sm1257861cf.11.2024.10.30.15.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 15:59:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
References: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: Correctly unmap memory after notifications
Message-Id: <173032917477.2233801.11445545753572055029.b4-ty@konsulko.com>
Date: Wed, 30 Oct 2024 16:59:34 -0600
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

On Thu, 24 Oct 2024 13:46:25 +0300, Ilias Apalodimas wrote:

> We never unmap the memory used to update the EFI memory map after
> notifications
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


