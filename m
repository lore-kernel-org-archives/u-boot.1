Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306D1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CEF884857;
	Thu,  2 Jul 2026 22:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SxA4viav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AEE8498C; Thu,  2 Jul 2026 22:01:41 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D07684409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3811e59df58so62645a91.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:01:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022497; cv=none;
 d=google.com; s=arc-20260327;
 b=hJ0NFhG3oj2YMIZAW4gDla2vPk4Ddf6b2YL+pr/BmonP+W01Lx23Fj4RTNRXfsU+Wk
 +k8m6h9CfhZsp9u4w4hnyfsakajl2weArkSlDGilTVvvklMs7iBG+NNHINoh+oWIbV7A
 0t+/SgtboI2b4tToV8RXQS4+sjZjWWli8gbNPm6aKGtAOXl4q3wQQauGah8ohpxMjck7
 NmDVyrmcFG+VuA3jSluTck9RerrCcAMagpHs6C9U3rfty/JpzNEt4C4AOkj3uV4rhkg1
 zW47yD50LFykpM/5QNjxOS2AyqnIr7mDsb0HHK5xYxNN52M70hi1vIR8dowPazJeaxYp
 MWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=12vq7N5+1VPvaXk8Wf2dG+H9IspTMNoymbS4htMXN1k=;
 fh=VY66Tvf4ACm43ZqcQ2X2wTKBy43Bm3TECXTfG9gFp4s=;
 b=Ff24+Ibt+Kx2w3fo0RbGmZs4uvnc8Txz1rB1SeuXIRkCtVF/jr7yG3wFr+qI6WhcU2
 1xO28oDE2Jm2/5ji93BdqChaBddGZPukpqVWv/8gyFeukX+fYd/TbSuMTxg6fiif+qlL
 6WoLjwRq1+kgpHS/ecL6T67OOt0zn4tGjHLeiClpxGAwh7HLEzKTi4cjnl9icldUs94x
 b5IFoBcaWlA8oCNOGJLecyf5L1+y0BjOkTLRygoHcvQsvzZ1XoPxBISqkzZD25bJE4rv
 DX1o7XboIpNJxf8agJV9MyEX1BJmx6ViQyzoGnrut+dQBeth3H/o/dAZquwz444uBW3R
 Lezg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022497; x=1783627297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=12vq7N5+1VPvaXk8Wf2dG+H9IspTMNoymbS4htMXN1k=;
 b=SxA4viavbXzeRWbTxb28S1wGpguL5jAXVS0HhItb7jHpYwOgAcaVNcRii8FJlYA4Gv
 yWDJ5IR3j124x5k/LKlZTVimoZQQG37UJ3P84ORhScMqjQwv0vtpEYB56abNonEeJTdP
 VlDUqlAaRy8E7mj29mVq11RYW815zyHOBbtTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022497; x=1783627297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12vq7N5+1VPvaXk8Wf2dG+H9IspTMNoymbS4htMXN1k=;
 b=j4w7874dW1O07uhKohC3jCPeNf/CaMt2tirIFxMnN0haN5VI6xFrC+tqnDyLwq9zP3
 mHsopRTJ+hUpcuLxuZ8HmELixihNh/UbJDXrGVYjqOoxXSHPOC7AGUbN7tI4xX0kHARX
 dUMv8czkEksBGhs9Pqx5Ph9ilQgqTyhKrpZ9WfREUgf1O22dMkz2UkrG2XwoZ0v8OTYA
 CRyaBSXvChzovPXAkfB7VDSMyPYMzPTMDIRKZ5jwDaJFxCxXFCH//C1VzdBqVtr9jGoi
 pw+bXRRF1IGhd+SKh5RCVo1epZhxytppjFoXbM/02d9f7YoCatt3ApmCOd3HoWh9kulq
 LuMw==
X-Gm-Message-State: AOJu0Yz1c0noklKgoVjt0JnZ/KvmXY6FqVbhIDy7DKd3GoqnBv0GL0ne
 g+EV3vh0Zx2+IqKdcE47Kdu+kRNpCZGJqiKqeiaqzoWDjmjqx82jclcXXUvY1lWidXFPWavDqfv
 OcV14AH7KgfN/ZudxFA3YG/SZEnnENnzMGrmnGwPY
X-Gm-Gg: AfdE7cls6hmE5B15eMCEZ487/+ugt89EA3/ub0ZHE8/ukgZ/H1Or7McWjIdlZIiXAzE
 v/11FxlwuRmhoVlTFMGY+eIBz2aw27EgMfjE3a0GVzqZQJhxVXmZ/O7rYcyahue82njqkX1DO1g
 O+FwAfDv0unCDftyWdSmDnEFpmiuOJosWubUaPp9y1R6puTqp9FYgcwQ5uxEZ2GjGCuEnhBII7/
 nVAUVbMxBIyz2n7Mvfv7ta+SzhcDgatzMbqClljY2n22BxqEUAWJdW8sMbA65R3kl06X/Sl+zri
 6pm+Ufu/
X-Received: by 2002:a17:90b:2cce:b0:381:22d6:f7a3 with SMTP id
 98e67ed59e1d1-38122d6ff1bmr9388a91.18.1783022496731; Thu, 02 Jul 2026
 13:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-1-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:01:22 +0100
X-Gm-Features: AVVi8CdtAlbMVJ5pvO6yjLsqbNoFlVQLm7lid86UGfx8GvRflks_EOozqT977Oc
Message-ID: <CAFLszThFxk-ns_XnVyEvTSMLfoGHKf5syxEomJ3y3oAMe1-uNQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] cmd: aes: fix DM operation handling
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi James,

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> cmd: aes: fix DM operation handling
>
> The DM AES command path takes operation-specific arguments after the
> common arguments. Parse the requested operation before reading those
> arguments so encrypt and decrypt use the correct positions.
>
> Also handle in-place operations by reusing the source mapping when the
> source and destination addresses match. Mapping and unmapping the same
> range twice can break UCLASS_AES providers that perform DMA-backed
> operations.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> cmd/aes.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

> Also handle in-place operations by reusing the source mapping when the
> source and destination addresses match. Mapping and unmapping the same
> range twice can break UCLASS_AES providers that perform DMA-backed
> operations.

Just to check, what actually breaks here? map_sysmem() is stateless: on
real hardware it is a plain cast (see include/mapmem.h) and on sandbox
it returns an offset into the RAM buffer, so when the addresses match
both calls already return the same pointer and unmap_sysmem() is a
no-op. It is not a DMA mapping, so I don't see how the double
map/unmap can affect a driver. If there is a real failure please
can you describe it; otherwise please drop these hunks. Either way this is a
separate logical change from the argv fix and should be its own patch.

> diff --git a/cmd/aes.c b/cmd/aes.c
> @@ -175,9 +175,9 @@ int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
> -     if (!strncmp(argv[1], 'enc', 3))
> +     if (!strncmp(argv[2], 'enc', 3))
>               enc = 1;
> -     else if (!strncmp(argv[1], 'dec', 3))
> +     else if (!strncmp(argv[2], 'dec', 3))

The fix is right, but the commit message undersells it: argv[1] holds
the subcommand (ecb or cbc), so the strncmp() always fails and these
commands unconditionally return CMD_RET_USAGE - they have never
worked. Please can you state that plainly and add a Fixes: tag, like:

    Fixes: b01444aa14cf ("cmd: aes: Add support for DM AES drivers")

BTW a sandbox test using the aes command with a DM_AES provider would
have caught this and would be a welcome addition to the series.

Regards,
Simon
