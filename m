Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257D3C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 12:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA15E608A6;
	Wed,  2 Sep 2026 12:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9j5lITDPG23a; Wed,  2 Sep 2026 12:55:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788353752;
	bh=IwrLOwoVNJfbGAi5torGOKdylRY1p+tI4a0GFKE+XSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EMgsueNTcVb0SmFyB47fZLzbe0EhOfG/g0hpZHPBHStRsi8++6vUu7kd8UHbXGIY0
	 5EpGpMqYQDgjP9i1Ds+Qbk5vuxSBz52HAuAzhWon5XbhA7nY68tvPW2n63k2FBoCVg
	 IhTjTIIqxgurWg8WKgF3eDLXPnDKYo57XMkgLopWjTm43fts67FHzduDdhWPlTwfNB
	 zccNiP4hq2oYORnzEkJkdkGqUMdrfMOJ7khfLLgTMYLaJ18G3BPKLwwoxd5Qa0DAGr
	 cZCFSFPMVziOLK0lVEtP6poE3n72ZvCNv/XCK4Y6iFoENGbUeIEnyW6E4c0ofT3qFv
	 zEoAstHbfe8Vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DB746070B;
	Wed,  2 Sep 2026 12:55:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B4A1127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0CE5080F5A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YV1Xdxcp9ilg for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 12:55:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FIjgKCr+
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FAF680F50
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 12:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E31F600C8;
 Wed,  2 Sep 2026 12:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01AA1F000E9;
 Wed,  2 Sep 2026 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788353747;
 bh=IwrLOwoVNJfbGAi5torGOKdylRY1p+tI4a0GFKE+XSw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FIjgKCr+hLFj2nXLumjd/hfs1u8syjd8NXTcmgsuiFjW2lz06jfk+QYVj4Ewc/hrP
 YjUUol2hniAPYJn3EmgCKXUQPDodVhoOJDWGAm//vOf8LxPOqPTt61ihFEGe9gJsv5
 SvbyilAqtQACBwN05BVsOsEswvsGnrs3sw0+dmZIdAJ9W4TzwZcEH0NK2N0lncymmd
 KUpSPLokSic9NrCchOyUO0ZCzFRckISbXd9Iul/+ADXRqc/a8aF4qt+Hr/RawLU46Q
 JYuJNuihPQWwb5jD/IDsJ5uJH6fsChgehPWM87gA+V89cAAj7lqtB+MXkyTYMtLsMh
 VRyCct0kPEJTg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH 2/3] cmd: optee_rpmb: try to allocate large enough
 buffer when reading persistent value
In-Reply-To: <20260828105005.200338-3-ravi@prevas.dk>
References: <20260828105005.200338-1-ravi@prevas.dk>
 <20260828105005.200338-3-ravi@prevas.dk>
Date: Wed, 02 Sep 2026 14:55:45 +0200
Message-ID: <87a4pzn772.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Rasmus,

Thank you for the patch.

On Fri, Aug 28, 2026 at 12:50, Rasmus Villemoes <ravi@prevas.dk> wrote:

> It is implied by the comments in avb_ops.h and the translation of
> TEE_ERROR_STORAGE_NO_SPACE to AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE
> done in common/avb_verify.c:invoke_func() that the
> TA_AVB_CMD_READ_PERSIST_VALUE could return TEE_ERROR_STORAGE_NO_SPACE
> when the value is longer than the passed buffer size, and that
> param[1].u.memref.size would be set to the actual size, so that one
> can allocate an appropriate buffer and re-read.
>
> However, that has AFAICT never been the case; there is no mention of
> TEE_ERROR_STORAGE_NO_SPACE in the history of ta/avb/ in
> https://github.com/OP-TEE/optee_os.git, and what the code does instead
> is to return a value truncated to the given buffer size. In other
> words, not only can one not determine the correct buffer size to
> allocate, one is not even told that truncation happened.
>
> A fix is proposed on the op-tee
> side (https://github.com/OP-TEE/optee_os/pull/7959), but the
> maintainer would like to see at least some callers updated before it
> can get merged, which makes sense.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

