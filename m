Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738ABCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 18:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6A7830B5;
	Mon, 25 Aug 2025 20:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wb0wTAjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E45830B4; Mon, 25 Aug 2025 20:34:45 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5873B82C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 20:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30cce5cb708so3214399fac.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756146882; x=1756751682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lfb5Q5rpGrPBPJ8XggogQ+i4PU5Ufj50pzAac+fI0lU=;
 b=Wb0wTAjb5WHY2FeX+FI4SsrpZLthRJEqIrI/CybNWny6NO8bzm8xo5fxpqCVFGsjol
 yg/FDHPSfcxjY4gj+Wr6Q0N/y6py5xlMpfw3EIyB0pqkJilxGNyCNmbTNPb/3B4p9tkE
 4yoZC9OrOCO+EeUUHlk2K/Dv9pbM5/KO+3qSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756146882; x=1756751682;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lfb5Q5rpGrPBPJ8XggogQ+i4PU5Ufj50pzAac+fI0lU=;
 b=wt2DtZ4hEVpfD+CQZli093ehKRCfgnCzIW7Uph0dnvEUbZY5d9/6FKIPkYnWrEd6EU
 ck9ZWPwPfYJmTRtSwD8KJpc7MRGPT2Z84Qz4RZPTgbbxYUwpxIp40hKc8bhP/nr0l60i
 ndYmhqNADV/NTJrL+8kYP/Z9K6eCAn/lRN31kYSAG/OhQc3FbRu9yCVs46SXd6/WzArY
 +AgpXVfzNcE9MPsXeTqdfju6FAtYEhf1CwKpF6FpoZZfxqI7FSBzMmGuwsUVWZjYyQdI
 VNyqeQmimne27BtPzcjRNZdENxj9Jdgw/o7DLjTfrqdappTRNfo/6ahTdi8PikfA9JYz
 5ORA==
X-Gm-Message-State: AOJu0YzTzIIQOYEgapWnAeAGByPW6E3ru5f3mycCQ+AMTor7WghlLVYm
 KS/5/NJkmL+hvY5MgyHDJ2x2ofqARTLhUU57uRbHOoNn2Yyhi28Xka0HQXBA4l6aRqw=
X-Gm-Gg: ASbGncuDOj7S7Ja3+yMlAu46SFRmOk1tOu5SFQlSSsFMkiyl40VQJCly93Jff0Sa425
 naWG+6U6uh3NynhNXhih7BbIRwzwMBb0+CZzrgm2UX44AWRBtT7Nm9onB0myZc2p3edaJuz7RUO
 +S8lI4xY8fbDs611KGGwqURRolLJDahSfrUoVQm7Uj1+ShKzXBsR3tqWuQVxVcPd8JACv23exme
 OvOM+vi6X1BvBBu/adQocYTzuuXqCmj/GcoFz2YwLvFBQaYTg9er3Rb4g9MuznlYpy50R9BAmCz
 QE8TquN/3UgOcDVBsLWqGVYHLExxWhLwBQ4pO7KhvgXuTN8mwLWckuDnRJ/oS/czfvPpcr4onLH
 t6MPPdjpqcjErMv6dQ4CQM0EorMjzMVruuLUd2v5i5A3WtYnAuDyd+cE=
X-Google-Smtp-Source: AGHT+IF8ezO+TECdqDW07Qh4+DalfadRG/jR+FMxnz3+oPUWX4QSBQFxjHMoJ/GOyk0vvS/H7dfzVA==
X-Received: by 2002:a05:6870:8990:b0:30b:7d90:1061 with SMTP id
 586e51a60fabf-314dcb54640mr7482901fac.4.1756146881872; 
 Mon, 25 Aug 2025 11:34:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f79bbcfdsm1931051fac.7.2025.08.25.11.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 11:34:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <5fc42e68-9fb1-40d0-8765-afe3f5c8f652@monstr.eu>
References: <5fc42e68-9fb1-40d0-8765-afe3f5c8f652@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2025-10-rc3
Message-Id: <175614688037.2891795.10009288784077655091.b4-ty@konsulko.com>
Date: Mon, 25 Aug 2025 12:34:40 -0600
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

On Mon, 25 Aug 2025 18:00:36 +0200, Michal Simek wrote:

> I have collected couple of patches for current release which are fixing issues
> and would be good to get them to current release. It include issues reported by
> Coverity and Smatch and also fixing small issues.
> 
> Gitlab CI is not reporting any issue.
> 
> Thanks,
> Michal
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


