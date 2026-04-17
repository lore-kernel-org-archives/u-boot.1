Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458A1F436BF
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 18:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A40084286;
	Fri, 17 Apr 2026 20:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aCUwkFIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E042C839D9; Fri, 17 Apr 2026 20:29:42 +0200 (CEST)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C66058422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 20:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-415e568a7ecso473561fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776450579; x=1777055379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdJcRh4a/LlQUdIqvmidK1zv5fn5cDknr3G6tpk5uc4=;
 b=aCUwkFIHP2Sf8jLHdBku0e61d0a9l9pYfxwA6PcQUvH+IHO9z/f3gtSAI2Z6arH7zk
 QzgWoGXQ3SadS5uw1CjFvYN51a0TyKG+2GM1+yLwglqauDWsSRvBUici8rIW5YwhBXpX
 RwVp+ztgQBdL16vSKo2EKp36gyg3Hrk7I6r80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776450579; x=1777055379;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QdJcRh4a/LlQUdIqvmidK1zv5fn5cDknr3G6tpk5uc4=;
 b=UkkgFuGLLFj8XanvW5v7b2UuyHVf8/cPkhmqtWOSTTf73nz0rwmEk+JGeiSQsGMGVb
 Fa4qHMMiDkTESLxq9XhSb3UYyski3j1wkeAnLQwfhNbL/dt1B1o5savAECTzYLL7GNim
 cjI8DekhvnynLiHLMbsK2jAUf3DCV3Mxyck+3edcGK0uL0aXT/8IWw8N2ptnB8TEoAD3
 u8+xuNRcEcd2GFcKjytR5U7VcXwJfEdddNM7Jl/fSODKriw0f9vJdKHGlIpXXhUn7EBy
 IuoQB/NTDJEwlg5ROh4CAYir0h8bWqm8tp4X8xfCYQLe9HRoyjzI3IK0N8sn4mqNu2GY
 Tcwg==
X-Gm-Message-State: AOJu0Yx80qU0AZpRDlFOYGidFpLpxM/IS0so3Kp6tvG1SVpGTsdIPghy
 tnGf1qBFUFXFToMoifR9tr1iiT9uhXvy55xlUK0/u0vwFGYvMxfASwy5umRqKCxGTeM=
X-Gm-Gg: AeBDieuwL/mYEluuXk3++qhdxu594zhgTjkLZDZ1W/kOCfih1dSn3Tiqf2ASJoRlbJC
 roB1lLruXv6Fw+Tqx9wILL/vMuq9fosa5g5i3MZdRkRvtgCnU7blDYjKRT38UVVXX6A8bwCxUrq
 t5o1j1ie78FSoeKnAPiHCcaAzG7hv2r5ulSxgXWmrLEag+KVMYCtX8t1iHBQV29fdrxNMqWgR4L
 ozchy1IdW9PGhSOj11SZkZFdZ2dabacJCXBrKEz0P9h5QJavJS9b1HQ6sew6cwP2bwM8YpOuGpB
 c5dQRIKuVYKYrRzZ5Mch6Z/PkD/12sgWwigcHrUla0NReHUPKAI4kNPFTa3fctrVJqoWlTJENaA
 hJF/Mm7s2VKQ98gY7prNqbQjJ81kxqdNGTPUmSYKNmiJ3JKoiWdqTxg1jVHhabqbxIztlTTV4bM
 lYt16x78TEiBjJYT5uqX8xLERE/+Hm71BX0l1F1jH672K0W09KDtEe4I+op9RwAcpCNLc+nNOK7
 zaW+F6fxxNNC0krAxiYSKGhvS0eRqvATti6Um5txSKdo/VVTBbWXHn/zpVj
X-Received: by 2002:a05:6870:d185:b0:423:4788:d2ff with SMTP id
 586e51a60fabf-42abf233298mr2305176fac.5.1776450579482; 
 Fri, 17 Apr 2026 11:29:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac6f2a3sm2004954fac.16.2026.04.17.11.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 11:29:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <20260417160831.28486-1-marek.vasut+usb@mailbox.org>
References: <20260417160831.28486-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <177645057881.805241.1002011902096209780.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 12:29:38 -0600
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

On Fri, 17 Apr 2026 18:08:23 +0200, Marek Vasut wrote:

> The following changes since commit 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac:
> 
>   x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288 (2026-04-14 14:21:55 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


