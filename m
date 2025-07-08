Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA35C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 18:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 447488331D;
	Tue,  8 Jul 2025 20:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tMwQbzCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D532833BF; Tue,  8 Jul 2025 20:31:40 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BC583303
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 20:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso3546443fac.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751999497; x=1752604297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3vTTvF7tiii0OXrRht8/OGZNDpf3xNW46kHUUSvpCYg=;
 b=tMwQbzCEe86V2GSPtxw1+icR3QirEbCrwaiuMYU3x/JsNbR79Lbry4T/4Q+oSfXH9w
 NxKbBgZWLcrMmesJrySJqzOszt1HBPBlj5/zQrH9IWjtXM8eA9gE4SVeBykikhaXtLKt
 jEXABEi20M+UCtuq8F2YhvLkwuv/tswj1pGl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751999497; x=1752604297;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vTTvF7tiii0OXrRht8/OGZNDpf3xNW46kHUUSvpCYg=;
 b=k/f+zaWFrl6Yj3VciRt3I30+2ckE51HinMlKciKyRfuHTeqG7bt+CGkCgoCj5V79Pv
 HBB7KrBXzH+WtevS45O+9GnH1bXBYXHGPrhL/Dn+Aa+ah9VZ7nnAp1arxoc+sGhJw3Q8
 7w87n/m7Q9ip6XGMAoDw85HTu5t1gB4AjQWR4XHFSA2MlXLBMRY21ZJv9Jxze9GqADXO
 ICjAQnRpbm0rsHdaPc8/prhs5zL3cv0qjN+j1YIU3W/ctxQqS2tFJ7gRSnUHLdZ4NaPo
 Dy5cR0Stfok7ncCdtob3UyzNH5M3tqUEG+jGc3cJjnolMoYx7dP6wcgL7K4aCuLPeKLr
 eQxA==
X-Gm-Message-State: AOJu0YyInx0c5dztykacb4ecGUgDsBCsl47Xi31MPkCZQAu/BTHPJev0
 t8OiQUPRJyvkTlb7TS35eOMDvO3fk13AwpeEms1bm/g+rbdDu/b0xrJaMRvj6FmrUvM5/17U9RF
 sRPp2QJQ=
X-Gm-Gg: ASbGncsg3USh/EJjMls3oWaMQXkcjp7G713lvBStlGT21ySM5tn25rxB+tdPy7YxTpp
 D8MKhQN3SgdOca3r4tS7JU8AYvPnF76WrRlGkjF1UcjuT+IFx65fcOUGk4x/7ysmxxOROBJ0UD2
 zSh/kz4euQhsvLiW+XHma+/5a8mdoJIScEal9ebd3EgpjD4jJDNqXwEuJiS0bLiut4gNI8W2t9G
 70C7VZIi43Bs71YX2bwheVvQhkyhcPcfyxeV5bdfy2tiKRvouCiPpEwIkcS8bHSUIYMEGKox/eq
 cL56UEHxDu2YlbdYixNpyf97iqDTt9lZWJzJtltnI+CP6KN0bR03fJ/fuddugtkfaU5MJ6aesal
 +wf8gq2xA3ZTIoWLO8wE=
X-Google-Smtp-Source: AGHT+IFkMscFi4GHDDuM47mjIvhe3LQHgkCOxOoAVA3azi49MJsYdF8Xm29MYKIXjpM24U2l8sd7iA==
X-Received: by 2002:a05:6871:613:b0:2b8:78c0:2592 with SMTP id
 586e51a60fabf-2fef4c028d8mr18780fac.23.1751999496838; 
 Tue, 08 Jul 2025 11:31:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7902ac03bsm2978971fac.45.2025.07.08.11.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 11:31:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <da51a8dd-0171-4197-bac1-6571f134d6fa@linaro.org>
References: <da51a8dd-0171-4197-bac1-6571f134d6fa@linaro.org>
Subject: Re: Please pull net-next-20250708
Message-Id: <175199949604.1283808.14010013085191963585.b4-ty@konsulko.com>
Date: Tue, 08 Jul 2025 12:31:36 -0600
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

On Tue, 08 Jul 2025 11:36:30 +0200, Jerome Forissier wrote:

> The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:
> 
>   configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20250708
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


