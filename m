Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317CCCA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 15:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE20260611;
	Sat,  3 Oct 2026 15:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VminP41TYgQY; Sat,  3 Oct 2026 15:01:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0F82F60642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791039719;
	b=Gir6X4FsDcYnK9F4xxKgwwC7CuMEL2Imhmqpci9qo6QqqIkK5xsgpp7kOErXx0JT+/vO
	 D4uT/7T/ejCYZF6nTWiPuP6ARutROSi865uM04SissVk+YRoB1v6W8b0wew6WAoPn61Jc
	 nBCYh/5VQhSqPUR2J4TojxsbDxf70GZVJbkBbNPIlguHBAz3HtdJVcFu083i6wXPc/THM
	 6JmDAUtOlNycdEQAXq9+ycPsqF+SyqKk3B3PTpi6sm8CdoaQ8wVxjmhggt7vj+E705pqC
	 AGHvZIP8bffypzDQcqsW/6+0WorJS/jJ6aE5ATRQvzBkV0B9uHr0wmyRsSahg3nTY8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791039719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ad/DFEwaYwjTbm4CfpGPTQHuD+GrgVuUmPQKaT+iDtc=;
	b=YHQxAxYY03j2VyVagG4Ib7KfAphlP3br1uJwiiLRGaIzlHUN3tIlrKJFJqDF9XxhI4l7
	 3DPj620SoifTPO71K6U8LFiN81ulR3xj+FP8cS6OvL1FY0G63IGy4xHI+Z+/jjKEpIbPr
	 OU9dZJi4LgI3lsLqwiHT4FXiiGt7iPnKwQLvS8WdO/ZT3kmcdaex7Wn7SNxpz+Iu5X7BN
	 3OH96NAjk2Ld7kA+5maSt6d8sKNMohO1pJ9yPknk+RNpOe5FZdNleMmN6J+KCvbvp2Qlf
	 91z4af775TxYaRoQpLrxE6XbWKosRuUbSAaQlRgU9yZH/TWUSdIuaenHJ3bQcxy4w7Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=W4WCOb5H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791039719;
	bh=ad/DFEwaYwjTbm4CfpGPTQHuD+GrgVuUmPQKaT+iDtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xcUo+mq6L1t89dnQ6c5N4+zXWy+3WKf//Yhz+M3KBQmfWNXtx94OLoywHp2TGCKnK
	 XqEsBDfFOy2fOL+XY3gOxfhVonwRac9RkR5b4Ch/hehIpZumvZBCf+mtpBnrgEmY8G
	 nnjvsJvrUmDE13/4vKn+mSbmbn9GC6pNxJRIXF8p4iWP6T3IQbiKXHvfh5rvcXTbKD
	 oji/vR1FKYsurvyXljcrpbaWRnqPvy8K/IYiiw3UuU0dSzR7D9wBZ7w49rMaxGibBG
	 hdtRK9UDDBWfGsQ+82k8zAGEWWyWAiheb5AoVGcVRafWJaGIRlTkT3JsxU8KoO9h+5
	 NeIGy57PxWj3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F82F60642;
	Sat,  3 Oct 2026 15:01:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FA391D2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2151B60642
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VqJZhYMyy-Fm for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 15:01:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8A83E60611
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791039716;
 b=WtWiCFmf5ytdqQ7zJlNfa5ryNI3gvyApkYLxa7+T8uXvl8CHSYmROMhHBsiQ0ChnVWzj
 Ju8p0+OtrsdUCd5Z54Gz53bp7fhbtQllQQ0Ynt6yZzxNmXDIuqYAhJ2PGIUm8b9mDwQtO
 Bx/tB8O9YANTja/+dOG4LKmv3NmZhJRERy3BV1hqbSDQFcuUGV0rIAgFN4WlPKsutVHpr
 FocP4ADjBjSMl8fJs27sbiSqh4EjMm4tMFdwL3+vVfFJ/jNd1a803F34TXnI4Zvt/nsQn
 YrxKzm/wGgfHO9SFuEx6fVKwKNGZwWaE2LI6G4lXZNmyq1ZoT5EAJiI/zX41P9dAxfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791039716;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=ad/DFEwaYwjTbm4CfpGPTQHuD+GrgVuUmPQKaT+iDtc=;
 b=R//TXxLw8JkK1LRGMPINCwyNaZmTgB3l5v0ZfU1iCo1JjY44tlta0Qs9O7lOaV+qUpse
 dj45SQMxpsVYNuJf2rkO9RzxnfuxTLXkGh1QcUT4LBNS72s3BL8J8lUUc3wI5LnR6f0Ct
 EUhITXsleZneNRmpiei3G2Xz3LR6hzPFKnGowVCKRb5177dyj8ETYcfrB1HXbJIbXHzK/
 8bAmVSO7gCKsKmOaJa2xCjHymYWffNQRgpUEBSDF0iVpWeuXL49k20IKB2Z9tsbnPtQw6
 rp76adzWL73taNy6o3lDXi+lrZ9a7YLpOGXVNgIYWPS35Is6rfgcH/1lbKyOpv7QQkw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=W4WCOb5H; 
 arc=none smtp.remote-ip=185.136.64.228
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 03 Oct 2026 15:01:54 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=michael.haener@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=W4WCOb5H
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-664519-20261003150047c9f1e7f384000207a3-_uo_io@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A83E60611
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 15:01:54 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20261003150047c9f1e7f384000207a3
 for <u-boot@lists.u-boot-project.org>;
 Sat, 03 Oct 2026 17:00:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ad/DFEwaYwjTbm4CfpGPTQHuD+GrgVuUmPQKaT+iDtc=;
 b=W4WCOb5HJFK9v39PEPyWs5doWaMkKWIv92VfuSfeSYnAieOLHEEi8ncpFoDGMdqg5Wk5S2
 ihmoPdcO9CILRNLF0hB/jFTS0CysBCp7RY5YaJA8OPrNchyWY7xapmu30wTycHDav4smxuVK
 Hb5ZZ1Qn0Win/CtqHQw3Rf7dTDzbX9NcGIRDBHLzt7QyUvUE7i8el5xSoACGHdc/Upx5Nmkl
 AlDd+vrmgiKdWsVLaMoeaQ7OrRC+rGnHbfFuk0fzpBi6yzo2iYS3XJBAe6ArKqzfsUPDeKF3
 Hn9CHvoXKefiTvIF55FKkZY9gbaxYqIkQQh89pLmak5SSj0S79sRQi+A==;
From: Michael Haener <michael.haener@siemens.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Date: Sat,  3 Oct 2026 17:00:46 +0200
Message-Id: <20261003150046.75584-1-michael.haener@siemens.com>
In-Reply-To: <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
References: <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
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

Hi Simon,

On Thu, 1 Oct 2026 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> This seems like a good way to enable the TPM for boards that want it.
> It would be good to document this somewhere, e.g. where we mention
> MEASURED_BOOT

Thanks. I have added a section to doc/usage/measured_boot.rst for v2.

> It seems odd to ignore an error in this case - if the board maintainer
> says that a TPM must be present, then I would expect U-Boot to fail if
> it is not.

The option is meant as "start the TPM if there is one" rather than "a
TPM must be present". A non-zero return from an EVT_LAST_STAGE_INIT spy
ends up in hang() via INITCALL_EVT(), so a missing or broken TPM would
leave the board stuck in U-Boot without a way to diagnose or update it.
It would also rule out boards like ours, which share one binary between
variants with and without a TPM fitted, where a missing node is the
normal case.

If a board really must refuse to boot without a TPM, I think that is
better handled by a separate, stricter option than by this one.

> In any case, uclass_first_device_err() also fails when the TPM is in
> the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
> problem on a board that has the chip fitted. That is a real fault, but
> log_debug() hides it. Please can you stay silent only for -ENODEV and
> use log_warning() for anything else?

Good point, done for v2.

> tpm_auto_start() returns a u32, which may be a negative errno or a TPM
> response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
> decimal from an int is hard to match against the spec, so please use a
> u32 and %#x here, as report_return_code() does for the tpm command.

Done.

> This is not really a driver, so lib/ (next to tpm_api.c) may be a
> better home than drivers/tpm. What do you think?

Agreed, moved to lib/tpm_autostart.c, with the Kconfig option next to
TPM in lib/Kconfig. Whether the startup should go into probe instead is
being discussed in the other part of this thread; I will follow what is
agreed there for v2.

> Please can you enable this on sandbox and it would be nice to have a
> test in test/dm/tpm.c, checking that the TPM is started after init and
> that a missing TPM is handled. Your test could send the event.

Done. There are two new tests which send EVT_LAST_STAGE_INIT with
event_notify_null(): one checks that init_done goes from 0 to 1, the
other unbinds the TPMs and checks that the event still succeeds.

> A full self-test on a TPMv2 can take a noticeable time, so the help
> should mention that this adds to the boot time on every boot, even
> when the TPM is not used.

Done, in both the help text and the docs.

> BTW, since the commit message mentions
> board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
> follow-up patch to show how the option is used.

Yes, I can do that once this has landed. I don't have the hardware
though, so it would need testing by someone who does.

Regards,
Michael
