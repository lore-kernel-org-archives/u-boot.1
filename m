Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C7BC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B438779C;
	Wed, 29 Nov 2023 19:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EfvHx5lQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4151B87550; Wed, 29 Nov 2023 19:21:20 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6FF877AB
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-280cd4e6f47so9527a91.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701282076; x=1701886876; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9Y8FnDD6vcnA+HUQboNthpkgTFwKbuOchcS9q2zfV8=;
 b=EfvHx5lQ/m2rSUym17bSXzMPwxO9EDOOG90eIilojNQ8Q+c8SySWTSXeAcWa1qoVdh
 /VNfFXZlaidWZWKt4wwgtqBkowzFMY/ZcQ8R8UBwHIhQvVEMV/7l3nBjCy8BWftuhoY0
 bK9hPUCuw8tRBKaCa1FckliWL8EH5DOZOgGK6o3EFYezkhVEuTlhk2iHzbUi0TYzvpoW
 HLRMgDoMg1OZNgcJ5cH3+ebhyM/kagINepWjM5HJraerfQBJBhpWj9iddiYER+uDlrVU
 WavCocZkhZwF/O7iYYLr0DKOjFUa7fdou5pebWJtP9KqgIG+RUpUaZ5PkUMFHhhqe2q7
 laOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282076; x=1701886876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z9Y8FnDD6vcnA+HUQboNthpkgTFwKbuOchcS9q2zfV8=;
 b=MysfnCXitGU8HeS0ZXg3lmdIHu+grIzgmDuDrw3r2JO+9jwgjQ1fGw83KcAY9y+a4/
 R7ai5rYOTn/XHQfMRxcBsmIQyTDjcSCk2rBoIgJ1O70JhaW25ERpkIRmHjPw77NeF4D0
 orr0Wmy/B83K7Ov5KLEp02S+mCvuYeHKYeiUOi821+NmjsIZ3FSTJpaG8c2ePoq28kR7
 60JnvHXRUafaLbXs2HmC+2VQcaI1K1e0xZoqRcJ9amzMVcrjCnyIU0ew/oxqNFpODcNg
 FvBI9RqBz82lVnC41xb2U45oXABmV4UEqHwDDDOG6v2SBXp5gXiFdDKCQMe9b1bpS31U
 diAQ==
X-Gm-Message-State: AOJu0YyLxia53NXpQesG5ut7GVHDHIbBTmfE2y9eJ+9JAU396qY/Tsqa
 mmi0rEvKl2p+aJkkSxcsIJ5TTIP7RRODSIVU9sQ=
X-Google-Smtp-Source: AGHT+IEVSmhmyiHenLnC+ejxkl6zR5WDtDo0NCccV8mO9xnUxYKtQMzZ6GAYbKGnrvkBMM3yVIDSu0A0M7eQaIGAoNg=
X-Received: by 2002:a17:90a:e516:b0:283:2fc3:b8ad with SMTP id
 t22-20020a17090ae51600b002832fc3b8admr19923352pjy.2.1701282075687; Wed, 29
 Nov 2023 10:21:15 -0800 (PST)
MIME-Version: 1.0
References: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
In-Reply-To: <20231117150044.1792080-1-miquel.raynal@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:21:05 -0300
Message-ID: <CAOMZO5C9GH3rqrxpf_jMZO6QxGS+Led5RRb+ejSR9Gox7BTz4Q@mail.gmail.com>
Subject: Re: [PATCH] tqma6: Fix DDR configuration
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Markus Niebel <Markus.Niebel@tq-group.com>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
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

On Fri, Nov 17, 2023 at 1:50=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Initially investigating a Linux network issue causing a lot of drop and
> poor network performances on a custom system based on a TQMA6A module
> (based on an iMX6Q), [1st link below].
>
> I eventually correlated my observations with a contention at the NIC
> level when in concurrency with the graphics pipeline. Troubleshooting
> this in the kernel lead to disabling DMA bursts accesses made by the IPU
> in order to avoid triggering the QoS at the interconnect level, reducing
> from 50 to 10% the drop rate on eth0, [2nd link below]. The solution
> worked on my setup but not on others, which still suffered from
> abnormally high drop rates even with this "fix".
>
> After looking a while into TQ Systems BSP I figured out a number of
> differences in recent U-Boot out-of-tree patches they had in their
> repository [3rd link]. Parsing the differences one after the other lead
> me to this final solution.
>
> The reset pad of the DDR controller was apparently misconfigured, Bit
> 18-19 picturing the "DDR select field". The current value b11 is
> reserved. The only defined value as of version 6 of the iMX6Q manual was
> b00 "DDR3 and LPDDR2 mode". In practice no register difference has been
> spotted after changing this configuration but all issues tracked thus
> far just vanished. All previous fixes have been proven irrelevant. Just
> clearing this field solved all our network issues and the drop rate as
> measured by iperf3 felt back to 0%.
>
> Link: https://lore.kernel.org/netdev/20231012193410.3d1812cf@xps-13/
> Link: https://lists.freedesktop.org/archives/dri-devel/2023-October/42825=
1.html
> Link: https://github.com/tq-systems/u-boot-tqmaxx/commit/15eb6abbefbf6916=
c28467b85485911dad3da6bc
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Yes, better not to write to reserved fields:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
