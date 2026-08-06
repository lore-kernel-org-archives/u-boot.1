Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AC5C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 20:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 926954082B;
	Thu,  6 Aug 2026 20:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmZuheo7HhBe; Thu,  6 Aug 2026 20:59:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A38C84080C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786049988;
	bh=gm6hSTiCTeTFw4yEOjkdldmnujLE3h8m1Cp7XuI4LbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ednk8ZvPRZpjnltxkAjJDCnVx0ZKKcHoux9LhLDd439XumPUsfLZkTMqr51i6C9Bp
	 jbbAjAhBZYxgxeJ80EOCQYjX5TeBPtDxqNa1Xl2NLD8i6xlcglhV0vTLsUk68TxXfJ
	 XX7Mbk8prPn5cUJzd5Z+ll1XJXZbwyfCBb8kKHek+wSaL4gFiBwz9n5UAibhMvgykQ
	 kcfECVPQRz99vvUGxanqL45VTlQeUE3R6neFAOYDYtcynXImqjI8aVeeT4htw3ozRh
	 r6atYSWA9agRjy8kB+4o+MBsclMvdmA5EFmZ/YaDCB+O4D/ySjtCh4PCHb3IneLvFh
	 VQ2jKAksFc8aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A38C84080C;
	Thu,  6 Aug 2026 20:59:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA5AB28C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:59:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9006080ECF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8HCBF83v92Fl for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 20:59:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 80DB480E5A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80DB480E5A
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80DB480E5A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 20:59:45 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a157f90752so3537497a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 13:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786049983; cv=none;
 d=google.com; s=arc-20260327;
 b=fAsBA/nU+6yy7+xFLQn6fVryebcSw2Ceb4gxDFwWD2DpW3BPijc2RNHLdqLLSep7aR
 9VoVzuqxnkj18NgRtggTCchK5YTYCJVopXc+lrzgo4dGK8pN0xsAQPDKARRNFHmi24pH
 b71+0MMSgJk0UV97AwO4hA1GWm9kQGwU/338gajJ9XDSFKdBf7hGYDjbwX9jkAzpsN+P
 4k4dH+jPYiPNAdpUXmDJ7+d8my1HwuglCbqx1wzT/sNjeAgfm4/2cwerB8YYcMx+lUJZ
 SzgwTSvE0hyZkOn9IIgSVRBIhQeWhuueu+3O4kQu0/Iu5ZWUAU90smcWObGmFTmfPOHk
 Zm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gm6hSTiCTeTFw4yEOjkdldmnujLE3h8m1Cp7XuI4LbA=;
 fh=7xxvTH2sQtJt5Ay+3iwadnldSn0Fw9o87gYzUPDaOIA=;
 b=SziyDv3pLiDRqOU+6M6nbuze6Hem8gulJp8IBVLJ9GKx4Xw9PhQHIzxh6cj12Pyaee
 Agsj0btL2Ytz8q/v5/MmAML9KZaF26Doieu1gfDmXiZd7QSYLiHBsyAoVfmyNgcQIPEe
 QETfzILBcUE67TV5Mm05rqYBvWE9OzW7UBIvkeQislpXccexbH5cwLOdGJbSZbWTSwE3
 Aygo2DOH2z0aJJgqSX6qXqAbuqpbfDLRXXJsegEK5HmqOIt6W5tbRugIRbYSjgGjLTKu
 YxDD9kvCrNaXezmfQVQH2OWZpeZ/Ve3ORaKw9l+yi43bznEefbDpPy/TMIjCNilDTJtY
 A+Tw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786049983; x=1786654783;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gm6hSTiCTeTFw4yEOjkdldmnujLE3h8m1Cp7XuI4LbA=;
 b=P0Ok5QYlYV9RWRxLunxB+VLk6/6CFJGopv9Sfm86ptVRYIU6nXbd14yPLmvkzIdAp4
 AdiwZWPY3v7FfqoMMBQS+VA5/B1BLgzho+NW6cgD8vgDraSBDd29oolmi1jr6rUdJ8wC
 ya4+f5qdV7GVBccDQt0XqDpSdYv0jK8MHzM4tPVTeRwUpKz0AnKq/x3eph/di1kspkyc
 AcXanxtlib5fIU3QkM3QIOA7r9scV3Iev1otSPpGkyaINglz/7c7tLVPIAmnR54L5I4x
 8Nn0tChy4ae+Nj7Z6Nr+0RqZRvsuHgDW+EAvBR2C8KGahX+fbtEku/ZVLRigq1QMs4VV
 TsXA==
X-Gm-Message-State: AOJu0Ywal8DVdih5eL8yx7Fibditg/3sFq/0u0+/VZxbQJ99XNZNhuz0
 MR58v34p0mTvkwZLw7Xa8fI2Gs9q4M6vhUPsjOmhqVp02LVILo9NeMsxK+7f7Qg1bbB0jIFa9xR
 B1O42HAFjyL3EUquXOR8K3KS64sGGs5H05jzESL8t
X-Gm-Gg: AR+sD12DC0ElorldzI+08XE7k9WPCmglXeHIA/9UZZ2FM04VPaKFM/lNF183OYJ9/4+
 X7gfd3x84H0JcLOCHp8gduMy3ujXOOif8EYCs7SOP4aLA1kkGS573GnbiIgUX/l5+bxXbhkzAn2
 1aRj5UGCU/y7CzCOAbnFwNtCesGQ/rWZYq/762BkYE/D54hRw8yWazmoWS0B3fAzu47FId039Qs
 g+4Qoyzyl6T1+C1yW5NK9xkNdYkBVzvR8bDAO/1BiiXYJ05C9fIKQ5bEL2ckDgfxzv3WYukitxx
 Nu77F6UZ9o511sztGCaiJKOic1vZHeVuJRj498xEcNy1
X-Received: by 2002:a17:906:9f8c:b0:c16:8461:e308 with SMTP id
 a640c23a62f3a-c2039c1ee73mr792644866b.20.1786049983496; Thu, 06 Aug 2026
 13:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260806133724.336755-1-mehmet.fide@gmail.com>
 <20260806133724.336755-2-mehmet.fide@gmail.com>
In-Reply-To: <20260806133724.336755-2-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 14:59:30 -0600
X-Gm-Features: AUfX_mz7IS50thJJXLZBaj_1eVQWfRRG-xwcx3m-oWZ5jLX7dZ41_hKVAHSoGAw
Message-ID: <CAFLszTjzJj7ec-PFMC6tfjf=hui8nfgzTaiRWsjEa4ATXc9VWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cmd: allow bootd without bootm
To: mehmet.fide@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786049983; x=1786654783;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gm6hSTiCTeTFw4yEOjkdldmnujLE3h8m1Cp7XuI4LbA=;
 b=DSqHFJnKRX+ZToJ2OgNtOCo0WMQVHBBmJYBLyaBBpQRuY3rMJTHN4B+RM06j7YZTot
 rcAtIY6Yoc0KcYeGKNoivMsh64V9RNK7jFQ/faZ0z8amYkDktIma2EN2/G8HONnDOpDS
 CnIhVXesWZFooblFKHioJ0zYyGNEet7/qoVW4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DSqHFJnK
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

On 2026-08-06T13:37:22, Mehmet Fide <mehmet.fide@gmail.com> wrote:
> cmd: allow bootd without bootm
>
> do_bootd() runs the "bootcmd" environment variable through run_command()
> and does nothing else. It uses no bootm functionality, and neither does
> the "bootd" recursion guard in cmd_process(). doc/usage/cmd/bootd.rst
> documents it that way, with an example that sets bootcmd to
> "echo Hello World".
>
> Commit 1fd04cf46baf ("cmd: Correct dependencies for CMD_BOOTD") made
> CMD_BOOTD depend on CMD_BOOTM because the build fails otherwise:
> common/command.c is compiled unconditionally and references do_bootd(),
> whose definition sits in cmd/bootm.c, which is only compiled when
> CMD_BOOTM=y. The dependency therefore describes where the code lives
> rather than what it needs, and the boards that disable CMD_BOOTM
> (colibri_vf, iot_devkit, mx6memcal and r8a78000_ironhide_cm33) cannot
> offer "boot" or "bootd" at all, although the implementation would work
> there.
>
> Move do_bootd() and its two command registrations into cmd/bootd.c,
> compiled from CMD_BOOTD, and drop the artificial dependency. To leave
> every board in tree unchanged, CMD_BOOTD now defaults to y only when
> CMD_BOOTM is enabled, which is precisely the set of boards that have it
> today. Boards without bootm can enable it deliberately.
>
> Tested on sandbox: bootd, the "boot" alias, the return value taken from
> a failing bootcmd and the recursion guard all behave as before. Also
> tested on a Colibri VF50 (vf610) board built with CMD_BOOTM=n and
> CMD_BOOTD=y, a combination that could not be selected before: "boot" and
> "bootd" run bootcmd and bring up the OS, and a bootcmd of "false"
> returns 1. A colibri_vf_defconfig build with CMD_BOOTD left off is byte
> identical to the previous one apart from the version string; enabling
> CMD_BOOTD costs 272 bytes.
>
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> cmd/Kconfig  |  3 +--
>  cmd/Makefile |  1 +
>  cmd/bootd.c  | 30 ++++++++++++++++++++++++++++++
>  cmd/bootm.c  | 24 ------------------------
>  4 files changed, 32 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
