Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9914CC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 18:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6351360A43;
	Tue, 28 Jul 2026 18:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q6Bau7A4buKN; Tue, 28 Jul 2026 18:43:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 21E71608E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785264192;
	bh=ZdMRoGanBenlWar7anM5kYk29EgCRNz/Yy8a5dntie8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SnJ6qXyvQrAY/qT/EMQr/ZniHWVtpGGzgDKozXshLCc649iYKFTXXqEAhg6RlMNu6
	 pcPGtH1HPTGnOrRMyGNrFir5BLvKzWQxAWoZ5j2vyIGXmO38jjRMgf7IfcdcozYHyA
	 nWzXORLUxj/1fS5kPC+qLMPUkIVGC0hRrmVOlHgFA0LZrjB606+ricl8pUBG2Yoazr
	 qTjbA/1L2KoO7nlXSRXBsE4CV973Tg5XxEueRKOO9RdrQljjjSfV/UIO1bqm3wnWbX
	 nCjuktNXP5bXPu5RIMnshk+n7mBKzfnI80FvDisbDtHyHNSgs3FEeys8piVhF7KXmY
	 NwbU2Lue96G6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21E71608E7;
	Tue, 28 Jul 2026 18:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77F0426C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69DFB40394
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0aXpoUny3zm for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 18:43:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 405794038E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 405794038E
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 405794038E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 18:43:10 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso16510666b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:43:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264188; cv=none;
 d=google.com; s=arc-20260327;
 b=WSn2k6LOXugJBPBPksdKbhtcoKJTYJAsjxImMqGJa6Ov1JWyiVX7Wv0hxIgEr/XHmB
 oJyvQWxjA0wFz76bS5J6Tp46qzXP2Agqzl235NSOe96yOfx+aneA50i56tpc+DJLeiiw
 6hY0LYu/vsP7XpXhlDEgojMlPc4PErgVyfifHAoIUXCBtykW37rW8n9ayIQpd6T+baGx
 4ZQi9LspNcfvNRAmCYTVJ3ymN6+lmSsE11JPXZlKL8SHd1pH28chGRA+M4fUiKgZlObQ
 5l8t+JptRtddJYUG0G6fn2VVd0moex9dEGhFT9NKVIAUuVAhUI3584q3H4HEif+AEuiE
 O2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZdMRoGanBenlWar7anM5kYk29EgCRNz/Yy8a5dntie8=;
 fh=KPCGqPWm+Awm/nZxSO85xv6ul+GGgZRPQqXX2nGcrfc=;
 b=FpNXSq+Uj8IMOsIWrugLxrsNVSHNsB9uFxFVj/hwMEodWKwgueytbh2Make30Nk4hG
 gVzmTZIMGxwZohBzBAmQUOspesAgj/m7cx4/+NFedIvixDjEdGPIWkwvFyMT0IGDP5/2
 lU7yJb/G7xQ5KJMQP0gjJrqBnj69G59jvfbflM8meVNVVF7gUOhgZ5FzsXExn/lo/IsK
 rmPjM1cRfw0DC7zoYwLcryvFwSwWcX3hjibmpLi2lpTvO7akqkt/j2Ty0K6w0tvVkQGg
 Frj1158wfHBtg6fH/2yaUDevjzVIan84KW+PoutZfE9xPPeFxnVnpURjDlfnN+KuUOr4
 sbMw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264188; x=1785868988;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZdMRoGanBenlWar7anM5kYk29EgCRNz/Yy8a5dntie8=;
 b=XErCqhrGBJjpQlP+9V8M5KTxD3dnPed7nCYGoYtKg4E96vnthmQjnb41oL/LGPw0tM
 SqxQ2A5vkWxN06NviI+S0Z2mjSI3VmYZPhIy50V/TZwq90FzZ7w/w8lmWYtWu2gFcxIP
 iq/y0q5GBKE3jgCG+ZFK/OYJmNgNhdivXYq6TdhJHadE9X6bKJIGkhAZqoXG7aDTrVlQ
 MEqr3+zbQBLUlsqiWL9QOawXNqcJd1SCqa6dqJxeG4Rdmp7LtzA5CKeohmgiydJBRA75
 /mYhBzs3kB2hnIinNiEBaAYxPkNVmH3uoN/n/NetoydzVE6b0K/PYiIXHEP00pamb4ZR
 QNwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKcPlrnP/V7ailh9iKueNwOuez44nYYlNQB7AF3CnWX8XhGc0ZGokNYhauS95/Sj01Sz7Pa5M=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxST6BSwuAIhmSsJ9UOuHQlUEP/k8Yus5GSVlEd/Rr18PSWvkR0
 QWcLfW0X6HaZCHbdWGYKI1ke5o50KdjGnT2AebEqATHnec4/RQAJ1nfs//iLlBIvnxas60yEegx
 5Ll7NK3SosLpp4fsSHV/Aynw1854gx5yyzZo3bCyZ
X-Gm-Gg: AR+sD13ErmYV2o52H/bmVdPMBDX+evjlyfz4Mv/wiJ0tfnRZTU5YIl3pbABNkQzZAs3
 sQz9mdGTcpDMXo7En16yRXAunsYzqzBqe2DszX6jKVqCMSl6IiVLatGJIxfpGz8EGBlH+AgvTYM
 Tj6gH2loMmwehirRaDoAiGPkKU64p4iItzTpVlTTL/u/2GeLRW9Wv8EWv/tbJRZndU2HMzuUdRD
 14yCwuI2RmWWmAN+nBh0IroZhq6MBNMMgB80TucQPzkeDY+DA9juZl357Gn
X-Received: by 2002:a17:906:eece:b0:c16:12b6:243e with SMTP id
 a640c23a62f3a-c1f72142e48mr220078266b.44.1785264188279; Tue, 28 Jul 2026
 11:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784601041.git.daniel@makrotopia.org>
 <cf2d647d26ea0850ead5e09fb5d683f92aee4cec.1784601041.git.daniel@makrotopia.org>
In-Reply-To: <cf2d647d26ea0850ead5e09fb5d683f92aee4cec.1784601041.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 12:42:52 -0600
X-Gm-Features: AUfX_my6nW2FrasWDoJi_VbuX-3GXZrZj_6_-QK1M9rLr4lPwJMc-BbP5nvnUGM
Message-ID: <CAFLszTj75c45QMdEk4zf9ckgX_CPrVYeQWY6pZ-kbx-KNC+Fug@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] boot: fit: cover the dm-verity roothash with the
 config signature
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Randolph Sapp <rs@ti.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785264188; x=1785868988;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZdMRoGanBenlWar7anM5kYk29EgCRNz/Yy8a5dntie8=;
 b=SirDwqchSKsnQcrMyXRVTJzCRFaibqn3roT6gsjDRnJLLPEqbvqiRKch9Ax075dyUH
 8511y9qyQea55V8bbYi/LBPomXokEm+suSAYL8rpIu+F4O6EVw0X+N3jzhC8wgd4BYVd
 g32QP0MQ+BuN/Znn9JoM8pBWVue94fVma7BiE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SirDwqch
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-21T02:34:47, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: cover the dm-verity roothash with the config signature
>
> A dm-verity protected filesystem image is not hashed by U-Boot when it
> is loaded; its integrity is delegated to the kernel, which validates the
> filesystem on the fly against the roothash taken from the FIT dm-verity
> subnode. The roothash is therefore the sole integrity anchor for the
> filesystem, yet fit_config_add_hash() only adds the image node, its
> hash subnodes and its cipher subnode to the signed region, leaving the
> dm-verity subnode (roothash, salt and block parameters) unsigned.
>
> An attacker able to rewrite the boot medium could then replace both the
> filesystem and the roothash, recompute a matching dm-verity tree and
> keep the configuration signature valid, defeating verified boot for the
> root filesystem.
>
> Add the dm-verity subnode to the list of nodes covered by the
> configuration signature, both when signing (tools/image-host.c) and when
> verifying (boot/image-fit-sig.c), so the roothash and salt are
> authenticated together with the rest of the configuration.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/image-fit-sig.c        | 23 +++++++++++++++++++----
>  doc/usage/fit/dm-verity.rst |  5 +++++
>  doc/usage/fit/signature.rst |  2 +-
>  tools/image-host.c          | 21 +++++++++++++++++++++
>  4 files changed, 46 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
