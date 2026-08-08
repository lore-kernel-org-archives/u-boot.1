Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1428C55174
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 17:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5064D606A2;
	Sat,  8 Aug 2026 17:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0l3DoZSAoPg; Sat,  8 Aug 2026 17:33:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4678160692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786210407;
	bh=7NNLCLk6WoOyw1QQLx838l/oyDJzcqd9cdlQc/nSuuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1291DzRILzDgLzwxqxuI2Spn/hx7PMVKyC4CPRoeFZstcVq4Qvr1YqaDdKnUnFTh
	 EzJ1tllINxjwr8yIOBlisRIZkHTxuNIiKY+cHjdDX9Ddgyl/Hi4pT9PqnQ5p9PiH+u
	 sDVccrovUEaHrwdxwdfg6w1ved53E/QjGB0OmKVyEINm+4IM5JQbaA1WY4lfDoDwfE
	 SG7p9MW8qk/MhEGQH/hc+OHUdcA0gzr1e9mFrD9MLVzN/ofVxew4VEwABGhskIllYt
	 LpzjxvwvByG0976Tc9a+rqrpvXNd8tRsitlnkK3G506SpoxY96ootSYraOdRUxmmuu
	 PuJZIUqRPagWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4678160692;
	Sat,  8 Aug 2026 17:33:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E2332F5
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:33:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E873D405CF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s1EjCqOUfxHH for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 17:33:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B7691405BF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7691405BF
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7691405BF
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 17:33:24 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a18e24ad25so550133a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 10:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786210403; cv=none;
 d=google.com; s=arc-20260327;
 b=JeviGkAJuoS2K0yYLTHe/OznzXNPPFpo/IMpMRK9pQKz2wdodKZ3LRMIK5LPrPY56Z
 H1eX3xVYV9GG5seqsMBSS3FJpXqGECVD+9UnyB25V3T9dMsCa5a0J/PUwBhOmIk/v3Fx
 jFiOa+eSulCKFW2gFg7V571Uww8Qy/FNOhgPRqyc2z1ms6dEeA2cX/LqaTMwZtCCP8Ms
 p8MTuxRgJQNPnTr0MXn4EVmDgOJSvXawG+9qd4zfxi7+zGYKWCh3LelhJNGs0tzV8oIZ
 +qt7yJtvoSd6ZKlH7+XEfZnI8rB+89nE/wQ8R1x8bVaZ8ENAi2UOlw2PMWl4Nd/6HNww
 fdyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7NNLCLk6WoOyw1QQLx838l/oyDJzcqd9cdlQc/nSuuY=;
 fh=S8G6UEZOlml1/l/X4v7YXaauNsH7EJD8tcLHsSzYf+8=;
 b=j3b/co6rPS3d4W8KwBsMWoJOig8jh7gBZN5bqtKN9yUBdlDGPm7F8WtANOfmVzTBPc
 k3ZA5Yx1yEEJqo8c713WVafjlPDxqVkAma4gILWD9EPjvz75uhkdySOnpYsfzWxsgLtx
 R2PuUqDa1XWzwVMFC4tvBQnGlcovXk+cf1Rw06l34tJ79XgWstFUMQKb9NFgzR0kF0At
 cop4SYq4EQKzRtKGn6gfDlwrTSBWI8v/w54MfgPmWIP8ZPBg9jnJkLI3PdwOCD/eDsCU
 3wDrSeKXPMJA1+oqrXaghTxYN0H7coIQY/0TvcX96Hk/8kJCyfqIJ1nS/Ki9BBvUKqks
 4JDg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786210403; x=1786815203;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7NNLCLk6WoOyw1QQLx838l/oyDJzcqd9cdlQc/nSuuY=;
 b=oVebHaUTMVpyb19ubJvRFyD+p9fUweotD9HifLJaYD+W5llkIqO8KJl1DGGobGDZvP
 JFFsSUFWoWuo0pigAwWiSE9NYjfivVWoeP0eu+GhdSIbaACUtTXIQNowhzyD/KdFl5xr
 5iE4YiDkQSQFKObHrmAhK+HeS+fofSFPob5wR5Df8vekMx3h/ii01PkXhQHWZHjcuv1y
 2MsTTVCa8D7AyUicWCoWP07G3Mmq7jWHEP/Lys8optgdtcldeV5N2pBJLrwcqrEtZp4p
 xb/r/LIkTNG5BIqe1PM3DBdmX6OHKmRvsrT8q70TPt9LF98l1RoGzVhVbSDNHX3LFB2S
 o4tA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8o6l1JUkHYbxYPShwbsEdnmj/lKBba21Ub+a3IPydOCYa7OK8n30GjKyPRpxYw95uISKG65g=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwKA9IF7gCGhG+l/DMxagmkMnNTnu/mNr4RVZc8EjDXlmQdL0vL
 XNs2008s7XhBbG2tz11MwDsBXrdpgRvU4CqxWgp0O0ECXtJOMm9Xpr9AOaZuiwUlj+zSB7P9FAx
 Ohr6ADTMlKphYVkXF1et+OXN1eDI9gUZCE50+TDNR
X-Gm-Gg: AR+sD13Hxo9QT6YyCdpgiH7gKmv+wMm9/Kcz59fDubS/RD1FfKmZxZaSzZVjHwE2Wkx
 MY8l9HJzvCf1NmCiiPBFSj5vmy3ybWW9f/wtDPVVCvx7JvMx3q8InhaHkpTiusrkI0ync5769TB
 SPg4MTxPpgjudE3bXEqHVr/tgWvCc7rS0EWBem+2KB44CcB7Lp6oJza8mve7KD0n+13HIdmrrs+
 Kn85gZroZisfor3BUq058yfdZTPZ7Ga8Gn7xbe2pyGCyU8nckqJPzvDbuAN45lFSdvxY8T+uVcy
 gW5vbOMDqtDnttKhUqUwZVYigg/VmSn3wGJfe639JeM=
X-Received: by 2002:a05:6402:378e:b0:6a1:778a:d223 with SMTP id
 4fb4d7f45d1cf-6a1f24a294emr4229323a12.18.1786210402659; Sat, 08 Aug 2026
 10:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
In-Reply-To: <20260729-binman_template_phandle_copy_fix-v3-1-9bf6cbbe1a61@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 11:33:11 -0600
X-Gm-Features: AUfX_mwkifZGgJUKzFjYp5VkgYzj1OZ9uCs_UdoVCS7IqT6RoZ4kF356hKtFcxE
Message-ID: <CAFLszTjF-YcHuGmVWGJWJwSSxPYxN-c3n3imSeuNHWFo3r2iQw@mail.gmail.com>
Subject: Re: [PATCH v3] fdt: Fix phandles not copying when using templates
To: anshuld@ti.com
Cc: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786210403; x=1786815203;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7NNLCLk6WoOyw1QQLx838l/oyDJzcqd9cdlQc/nSuuY=;
 b=feTzByAIOXKnbWW5r1Qd3MsdkF/z6GaEMGAGYIpp8SZrEW/wh9jvM/S34Lwo6xSwt7
 PZZ6ujCTtDtzgpKitkEoxDLMBPL9TEuUnMLLYLRgdrVC1bc4I8jCZfv9zp5lWOWd/4pq
 1t8R5cQBfhwcTpbEWvXQD/41B+Y4wIS9a6kyM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=feTzByAI
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

On 2026-07-29T10:24:57, Anshul Dalal <anshuld@ti.com> wrote:
> fdt: Fix phandles not copying when using templates
>
> The phandles used inside a template are not copied to the node inserting
> the template, leading to a missing phandle error.
>
> The following example can be used to reproduce the issue:
>
> &binman {
>   some_template: template-0 {
>     ti-secure-rom {
>       content = <&some_data>;
>       keyfile = "some_key";
>     };
>     some_data: blob-ext {
>       optional;
>     };
>   };
>   output-bin {
>     insert-template = <&some_template>;
>   };
> };
>
> With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
> find node for phandle 103' observed.
>
> The test_copy_subnodes_from_phandles was also updated to verify the new
> behavior of phandles being copied.
>
> Reviewed-by: Moteen Shah <m-shah@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> tools/binman/ftest.py                           | 12 ++++++++++++
>  tools/binman/test/fdt/template_phandle_copy.dts | 22 ++++++++++++++++++++++
>  tools/dtoc/fdt.py                               |  2 +-
>  tools/dtoc/test_fdt.py                          |  4 ++--
>  4 files changed, 37 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
