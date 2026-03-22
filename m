Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4968CFC72C4
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 13:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E8B8408D;
	Sun, 22 Mar 2026 14:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VYwuWP9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D8F84090; Sun, 22 Mar 2026 14:25:15 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F8F8407F
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 14:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a27b5ad832so3180102e87.2
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 06:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774185913; cv=none;
 d=google.com; s=arc-20240605;
 b=YyeW5ufKeXq5sOX4cjxBacyBehdPSQj/QbDJGbV8rGM1IoSHR3VYvyZ35dWsMfYiJE
 chAqxTVrP4s9uaIriDlYMH/TlfgPbiF4CQWYXRa21agNjFQQ9axVf4B2O5cm9DDHtAK6
 5otOXirMIGDyMPImiaVw18djQRHbmggwfEAgwR+lPW4yhrRdRn+NQAUE/SPpiPVZwiLq
 i0LHyctihGcoErgqzZgh08vdH/ydDpPL2AdosE5Ek/nxh2mHmxOY5aredjwEfzBPlTG6
 pJkpfgix+XqK3kkOTQqMsVGY3cPcmpmozkiUPrGvrw3DLSPUq6bR30GYSiWLl8Uej/2f
 NU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wsq5gV7HT8O98rYFaEJm5qNAlomKT5lJFrbWDW98qp0=;
 fh=q64gDuM5plIOoZttOFG0ElF1l56yps9EYhoN1w0zEWQ=;
 b=VdCpcx7bwfSACt8mqD8qgRk5QtzvhQKnKevopwf807yASNdztB+ngaq5D6ePhuFx3m
 MQIta8xjJvPjApL7V30miztoCQuhFZbPHEtwJXRjW+DRI3pRWroftniauOq3q5ltS+JU
 pPQ3fm8Fv5C9qM654LKgRVMUCLan3UgE1qjhxys1pmlU1dj5UDPrBa/Hdh+MMxSC14Ja
 gcs40FNffevciAQdQ0fBDc24Qae2hzbdZp5Ju2wfmcrYuWAAb1Lzz+ePSXuJ85jXZog0
 95HZ2c2ghkVM8fj1Rbl33Sw3/6kLLJUkF84TrPBRYl+M/x0d/SdGKRBleRmGC5ICMYl1
 /emQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774185913; x=1774790713; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsq5gV7HT8O98rYFaEJm5qNAlomKT5lJFrbWDW98qp0=;
 b=VYwuWP9+ZKc4cCL4iZ8Lp9NJpXFfkzNRhsG70MWllvQBdD0AFUV2fRYtPDWeonVVDb
 F+k6mwxNtUEkGrpVTnPjF2sHPX1Hz0fO8t/kRl/yHUiiWtH/L5Kr/I6/kQ1vXP4z1YqD
 YnvrFZpErKMNedQ31XTdCG2ZErKc7wz6lZj2VgqIIBKaIFGXMA4+QIPWfqwsdT4xtpvj
 Vs3FUYnSZJLmC2BT7LA/X4kFuRVy+bw+dkHzm76WfyJLdl4ABG9DoTggPEbcHZINYkps
 TqiU7/fh4QxsfnsDk75wSXIBd30GEk6WNckusR9Vu9Z+d0+wzs2ccvSTBo4KL/eHjVrK
 4LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774185913; x=1774790713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsq5gV7HT8O98rYFaEJm5qNAlomKT5lJFrbWDW98qp0=;
 b=HOUJ6+3wzEjGJGiP4KapORXwRBBTVY1p7ChcOHj6m/3GPb1o976ZSZAPUv233ABHtr
 kdkrvy6oHNttMfroHJH8pgseX0ZK+v7+yb9WHbSLBgq7MX0M4faa408pa7R/uwXS0gdO
 XQ+09sX5YZIupqW6457x7+CzmTy7qLDNKHJk6Xr7Q/43RTOfMCzs7QlICfjezBhAxWyA
 9N6/Hq4kzpQ7Yzi/c8big0HrLh23nugnL4Mq0gr+9H03KVx+5NJvrY38cCbOui+1f3U8
 APVhY+qwfK1MHcAmtiyH31LAY4YuilDcSIbwUSyClS5nEArtnhMNKpx2hWeu12Dkztw5
 R4Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvMWgS5FyRsonpKH72szHNjpZldNa9mnv/An5ZZsVLfU6oWIXDR2EQ6TD23X0uZRNt0fUKgaM=@lists.denx.de
X-Gm-Message-State: AOJu0YxB52XCRywqMjyFZwmqu3Y4zObPMY4xW9GXXIkCJ9cgtbpkJTHA
 96QKnUqATWLXGZX4LucV6hJbxmP4vnb/PWR7Wp3zjBFbAoefc5JYTc0l8uCLptdyVNU+VGGlIan
 msgrGuGjuhzGDQ/0OsmT98Iob1j8aIR8=
X-Gm-Gg: ATEYQzz6bWzY93fcYYENSt4cydZg/zlb9v56wpDl38v1u6XP4cgx1Vdt8G/aznP93Mq
 66rjLigE9Zn5pjHjIStd3ipITQDoVB2lN8tRdxFTfEtN6Vi2dXP5v3ihvJt6a59z5Hlq9FZVAor
 C0yShxct46bYcYkdU6jIXsWqRHgqK9G55juLjuq4ZwXzi6oD6/5nA89LusYO+ucx37itJu5c4qb
 Wz2GWKVE6zd7jl+vQ1LMPX0FaCQThlNNNbxbqRPbGy2GEHM46VejorNxQ9dfsZeVYLSADf4tHfm
 IV2tox8s+IwNGOtR95MFF9yipJ6aFPcOAXw0bsjcTL3poDqdN8TodZrZCIsLkw/PYAkPN6xWb7p
 7PJp0vQ==
X-Received: by 2002:a05:6512:220f:b0:5a2:843f:5807 with SMTP id
 2adb3069b0e04-5a285ae2fdfmr2794621e87.7.1774185912498; Sun, 22 Mar 2026
 06:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
 <20260312095711.3219756-5-Max.Merchel@ew.tq-group.com>
In-Reply-To: <20260312095711.3219756-5-Max.Merchel@ew.tq-group.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Mar 2026 10:25:00 -0300
X-Gm-Features: AaiRm53u9ILXR9xhBvRmRYST-iyTh8Cm89uzgG3q3EEyGSfq1MfCaslMQ-C79Do
Message-ID: <CAOMZO5D9B_oEoNE11sC+yHoh+s8m=5x08TkCbVUYpg9GcPXFug@mail.gmail.com>
Subject: Re: [PATCH 04/13] [cleanup]configs: tqma6.h: remove unused define for
 PHYS_SDRAM_SIZE
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

No need for adding [cleanup] in the Subject line.

On Thu, Mar 12, 2026 at 6:58=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-grou=
p.com> wrote:
>
> The definition of PHYS_SDRAM_SIZE is not used and will therefore be
> removed.

Same here. No future tense. Use imperative mood.

" Remove the definition of PHYS_SDRAM_SIZE as it is not used."
