Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6848CCAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 16:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBD483526;
	Mon, 29 Sep 2025 18:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YDAPVTF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23E283526; Mon, 29 Sep 2025 18:07:31 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A46E8349B
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 18:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7a7c1ecd433so2420473a34.3
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759162048; x=1759766848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bAo1+v5DOO1OEXhjjo6i+1JL8gX7EZYhGDSt9lbvssI=;
 b=YDAPVTF7A8jBZzuCd23Y+6AnSTH7nvqtzvwvsX4V0Mvr3QC0y4OqHDXHEyaYZ2jX7e
 anY2qD8nkdUVD/RR6FYJzcznOnfyXazgzdlnJstERo6qYTePrWn1AMW+TNdS5+KRNAUC
 JYVeNjnIIdQhRb1RYng/0LAze/o9ZoJZ0GVc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162048; x=1759766848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bAo1+v5DOO1OEXhjjo6i+1JL8gX7EZYhGDSt9lbvssI=;
 b=nvbp+mdjhlNfmqiLO/l+mVkx3hAsUIRVlCV6WF6+9KvnXs7MSdDHYgc0JzOjMnpoec
 iogUTVz9Q9q1eLrETUH6kJ8ftmWsQswkwLzobEmpeCdOPacs8Aj43JbENVPY2E+7cTXZ
 +QKxC+jvIilP0HRfJiB+M3xCk4v1DeCcaa2VxRs3so+ckygKOpklCWc7qvAAF/4X8mMs
 lvvXlHqQF6BkYtm1/jUZDQpy1Octdyh2cyvAphJJ9C+NNaEo3RLPtW+9MOiYVN0B0NWS
 BTVfSutFxGURn7SW2VGateA+SvPuz3l5wVmNRkORQ0NAqiAH/W7Q23fu85jGgSaYPG0B
 yCcw==
X-Gm-Message-State: AOJu0YwyBEid1Vg3OAiGqQgsGK0y57h4BvJoMufzDPg1NhzpQ1ao5gd1
 DcST6KxZk/I+T4Xjfr5HgDbgxXIs/XLUyelMZZMFOLiWxHUW3gGqd+/HbcVfMHlvOLywTzXAp0N
 O8pJ9uAY=
X-Gm-Gg: ASbGncthB8CsTJD+9/6F4Wh6kEHmL0hkI8pw0IRpNdb0HvsbD1viRbjibzO+2cCs5jv
 7/+JlkSnJrsek+8LDhE2g6cryFCAxIV3IOoxJ8VI7+7HE/mDBGKMa86Y2G27sGX8m6BH+Rja0el
 ZXPRjPAmPXCqlXmso6vmxw4QamjfKzr/LOJZQeXI6e4Gt6CmhP+c4tdulqnnpBpgOpDG3HRMAuy
 ISIMEOZZcnpQA+7w5vuEvxtRYcMOZSTHmEP34Ur3jZk3jwM6y8iH03TeWg/LZ8RHR+QF4qvk5xz
 BgkBGen7MTmmHN3FnstoPsAapSyqQ/C+KZ8k74jqlfgkWZv4kb8YhKOvK30//V3PwdraQ3JvhWK
 mBUfe6KEBvc5RjtXE5xPwhDsSFcHXLRvAy0NCb9PCr3otbog88JiATDebyhDlg+1Nag==
X-Google-Smtp-Source: AGHT+IHEIMA0uxWgg9zRLausQ7+YWzoOpfs+JCGYCAfDIbKkXPfCCRrl5Dv4IEisBnFlBRjKRyMCqw==
X-Received: by 2002:a05:6830:2585:b0:7ae:dbc5:4705 with SMTP id
 46e09a7af769-7aedbc56212mr5726528a34.27.1759162048229; 
 Mon, 29 Sep 2025 09:07:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23e1682f4sm2689213a34.22.2025.09.29.09.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 09:07:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
References: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
Subject: Re: [PATCH] b4-config: configure `b4` for U-Boot
Message-Id: <175916204764.360535.9670952964716641436.b4-ty@konsulko.com>
Date: Mon, 29 Sep 2025 10:07:27 -0600
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

On Wed, 17 Jul 2024 23:12:59 +0800, Jiaxun Yang wrote:

> `b4` is a commandline tool to make patch-based development easier[1]
> 
> Provide a .b4-config file to match U-Boot's patch preference so it will
> be easier for people to use b4 with U-Boot development.
> 
> 

Applied to u-boot/master, thanks!

[1/1] b4-config: configure `b4` for U-Boot
      commit: 26efc940c865a04d345ac9d39f71746fc2821da6
-- 
Tom


