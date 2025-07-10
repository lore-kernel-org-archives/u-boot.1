Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993C6C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA0083738;
	Fri, 11 Jul 2025 00:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tl8vtCQT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A78E0836D3; Fri, 11 Jul 2025 00:42:09 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F538362C
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73afbe1497bso631236a34.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187324; x=1752792124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V8kMkZ0tQiIozf4LlmZH40ph20gQtUckMZmXQvkNzps=;
 b=tl8vtCQT5+YrfaDLnYg2p00Mhvyi/ztxyIrxMtbUt/GyZtzMWY80vt49k5e/lJk7SJ
 fdahq0tAdiIaHvvMos8dlE/uOHog/L4TWeasn/12W7NfTUj9Kq4HOX65HE0jg0L45RPY
 74Lmn2TTI6YGKz2bMqceyISZnFdDupmKq+EXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187324; x=1752792124;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8kMkZ0tQiIozf4LlmZH40ph20gQtUckMZmXQvkNzps=;
 b=xAjuKmOXiFs0fzOfVTHc3aYnRCFbu+YvVoWOtrucLDxEtth8HsQXosE/mr44TONVzC
 dGDblCH9hW0WrahU2kaRGPxoIQWSAyp4WUsNV/Oc+FA1kAzXKA7MGe74zUXXF+7dxuSE
 m4b/7vPqy4ywlcwlWXDpdzD67zwMRv1HGmq8IH57W9QHG+/JrMsYA8Bf/xvY1zcnS4lT
 eWfomn9fklvpMa35BEhGl3/W5XOW6M7geS3e88/QJX8Gzh/J32sl4zlGK5ms52syzGHZ
 gxvL7rtGEvrBErxjtst31QLAzmbtmfX+a/+oti1ahC3gAU/Bna4b22u4lQKvna4FlLTU
 uL5A==
X-Gm-Message-State: AOJu0Ywo3CVN7vz4GimpyHb2ef+2zPQ2R6t3F0BB+Ry22WnwqOBIfE2E
 Sd3cHVRR6OVp1+/BDZbUYynCp7KCra7L3hKajgNKIo8sEC9GKCFOV7ijMuZhuz/tNhc8H9s749C
 Yz2AhuUQ=
X-Gm-Gg: ASbGnctBe48Tqo7VXt6yZ30HdwqmSyurCLDm8hTUVT5ZU76MBIkWcv4/EsiB2yeqad0
 +AY7bLk9jLiSA5Ltseu9pqSYDq3rsucZRQXLjNCRk9LdLCM72e0b50DUGmFdRgwak1+PPh5iIPP
 GXCl+RUaBqdoXaWYioapScvl81b2sb4x1YpLrWtccMfGxpaummUocuA6c0OOyRJre6+LUEQo/uS
 oQsx57M+ZSpiLzD8UA1Z+HcHtLf2DfWvRchVBaWxveR+t/SpJgJTby+ktjkpLx7YBtTsEFOn7kS
 nHibmwGH1f7IaZq8FRS0I0MTGTZr1nRNVCGzWaH3aWypuvUfsjXkNmy7TtZ3pEsTx0suXcHuldq
 RZ0ykdZPH2IZpf9qD03x/DMTmmK/0b6UDVZTz5ES5E7IURW5H2oYTxU8=
X-Google-Smtp-Source: AGHT+IEMc6TNnSCDy+pDqIm6hpcGbe2+QGTuKHTbywWhuvev+B+rJYMikz1Xjq//N/mkYCso8vmf6Q==
X-Received: by 2002:a05:6830:3e8a:b0:73a:9158:fb7e with SMTP id
 46e09a7af769-73cf9f391a5mr628584a34.25.1752187324493; 
 Thu, 10 Jul 2025 15:42:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010508.19124-1-trini@konsulko.com>
References: <20250702010508.19124-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_SEAMA
Message-Id: <175218732374.2073260.7759851844195781385.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:03 -0600
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

On Tue, 01 Jul 2025 19:05:08 -0600, Tom Rini wrote:

> In order to build this command we need to have configured some other
> board specific features. Express that requirement in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd/Kconfig: Tighten dependencies on CMD_SEAMA
      commit: 1645f9f979e58b032a1e2f35b7d885fa9d91980a
-- 
Tom


