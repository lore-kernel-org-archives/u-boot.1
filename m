Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E44606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XThVO+6i;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UEWwk82l
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88ECB60A75;
	Thu, 29 Oct 2026 17:42:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vthk32xfcUMh; Thu, 29 Oct 2026 17:42:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D404160A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295720;
	b=emqhPXETfrF9WjDMCIOM9/yDZKGvwTLEr98GC/t49/RUvW9p7sTY+tG3+msxcM1UTXN1
	 A778ywwlyxOSMR+cSbjX0zzFCp6ChnCq9ArzyuI05LViLGuAhwZrShuipF9f0K+asM/xZ
	 Sl7el8/hp69twMY8aQR0ItD/ga1D4xAJNHkdZdNkJ3PGlm3QjE37qe5pkl9ZIHI7cw1rq
	 hzFP+HO6aHP8VB613uRuP2yp8qAOx7KgNYHhO347CpJqM1MxWgdFIMvY6rFzGPrSsWGAw
	 mfQhm0SoSyqu7SjoAbJLxBG29rBRj9/xIlE2+Q0f+d5dinqvi0WOTabCb7UNDGfzu3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pdaLA41T2cwXG602j/QNrQFduJDPz631ZXBMrr4eCVw=;
	b=WPB994u8xWZwWd6hcsZAOlgcXlGZW62qBXXrBKJOmoW+pnqBBa25APuMVjeCAXvV43YP
	 DP+Cp1iCljj7C7kGZP8KP0kD93IK58xa47CErDZl/kRcLKhNSRMFGl45LtvOMD8EOHwvo
	 vI8tv/f3ctlYWD26Jdc3amGKI71+3QapxTtSQtUQOt9uAD116Ua+aGHgnXbkG0/4j3itg
	 gEH5jqWlnm1OoOitDUOC1K+jHFVUpIVcaHU30AEjKu5dPVlqgj2KLodxbjJTJ40HE1lqM
	 hLLUhLxxIfO3bsc+HCzsBU44BdTADgRHZN8vDOQlPV61qDiv7oJFuYh0o1FVAiZZTow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295720;
	bh=pdaLA41T2cwXG602j/QNrQFduJDPz631ZXBMrr4eCVw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XThVO+6ivWFj0rfdiaqqtlAqlfrqDZsXdm/GpUS3w2V6rLadkQu1teeg+6PVf/Fi8
	 6aeTxB2ZBYgKuvtiM1LWF6mc7JepoLVhPZGgZ8laolZRWBi/GjeWYXr9VZ/xfh0BNx
	 Inc0sX5hf5LdhKQEN3p8zC9yPHopM/zzUwRLe7rGTpvXOltIZ/y4rW6Lklwv5wU1SU
	 MhwuJdExgnoLyYD3x+pPGni4b7ze5nOMQ85n25ynlb1pWplHeCu7JyBqrauHM0ubZk
	 F9hJnnOJAlCM4tDGdbOSadygUBX5XCXJ1+osWZGdZXzhtX40lx17jbaYeMOamyUX5Q
	 oeCMZeZHYsBNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D404160A6F;
	Thu, 29 Oct 2026 17:41:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B2D36712
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A52D9400C7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EhJBlyYsDGRh for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C168040048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::236"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295291;
 b=bLiwRkdIPTmRVbVmE20H76trs1+VOU8toGODgKJ77QdexOvLvdVwT2TWDjZch5JYkl8K
 i80FPHh9uC4pljCsmYgBP0DtNYHU6mgD6Qf573BFXjnGjJsYEN3HOEEnCCk6SOxtpGpoa
 NoM+xWfC4kNFrRsSWbyuOhL4kHECktFjZl4DL1Q7KmfeZ7GpOTbZtDI3K7O8Tr3GcyFjv
 BKmv54gKLpqWYYuQPSV3ovqLt2FMruYjscv3DRSIfNYhH6jNtSbW/u0U5JPQSOUCgZ84b
 oDYRO0DRto/wt9mUVFjPPsM3Mc+dcFHUJsgnl3ZK9vK9xmo47FwmwT69MoJlXA8iVsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295291;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=pdaLA41T2cwXG602j/QNrQFduJDPz631ZXBMrr4eCVw=;
 b=G7/OaPXWvJmLapYUmJiVWm9uhpZR26kYxtyVErvM2bKyfYATwLW6R5Ex9m6buqj8fgGt
 Ncf8B8NOfk1zI67JoCtwRx9hSfcxoBtxEQ/CdT35/Mnn+K/v1y/hL2HQmctkI7lGVlBdU
 dxu9TI6YTASGCxGk/TMx1ALnQmqo5nwmykP2HNibNgUUN2u2aU73KQ680KbTUGXRRdXya
 hzXWoz2QmJi/D4E9D1c2JmupnqcEJWkD2L5j8FuhE/wlufvY8T46yBlOsEUEYdPrHUyE7
 uenLbkKPu/s+xwks+EvGQ3HvHmTHaUYrUes0JPRWu3jEu+utHAjZKbV1WPpwj4wfK5g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UEWwk82l; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com;
 envelope-from=maxin.john@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UEWwk82l
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C168040048
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:34:49 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3ab27b4924aso18188931fa.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793295288; x=1793900088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pdaLA41T2cwXG602j/QNrQFduJDPz631ZXBMrr4eCVw=;
 b=UEWwk82lrd+ptaIdApdpiVnEhy2YEvi18S6NSkcpWG5RqGDjH7ZvENSdKnVjS5wD0u
 BevecPQNPzGdVvX/ZxI3j0fOouLWMiqG3DaFT31W1dlc235u6lvC3yt4+W/fXzZKvgZM
 aDj1OE7hDpaaOsaYQldf84AbW9U+83kkRs+jHs0b2D6xtCWLIFKDpocBzseQJtpSo6L6
 3yhXgT1MaTTxMprCeWeRcxO3l6IDQ/grP38dEynVzOxBv/u9Kue1DtFGCBUAL2orwC4a
 QhjmWt42NM+tXcymwR4nF3dZWCjDhiVHEG7kT1ZWm4wboYn2Ad1ZliGpfBQgyqplCnTW
 7U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295288; x=1793900088;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pdaLA41T2cwXG602j/QNrQFduJDPz631ZXBMrr4eCVw=;
 b=EkOef9wP3n/9dMXC9pMwrhDdA2pohS5UKx9H9EnQt0/PBZQ3VoV2nGVcr0JY+EwOll
 vnZJJ1mTTv6cIWXp2xhGEMV6ZhbSL+cFhmqZznrCmedd/tkN+b+k718YGxx5mDIvjOar
 FDfQauQjtzP2nvR8I4aGJwn+ipUrz22aJsGU1yh9QDaDQ9pZUqkdGjG236UZs6cMQd+D
 r2XNfLGUweclgqUfAuOSJFa887x4e6mEWW+3XgVZdLBv6xago6DfiOkB/mC0NLynWLO0
 buip0+LIpfBshM0hMgfPJf7fWaXxAi39s3HheZukcdtJ6HHQRLjrHa1qnzNvYOYVnBJ2
 NkRA==
X-Gm-Message-State: AFq9FYJvepPlBK+w7F177m8mzmvNaDWGWICcGom9KJJcmgqqSpLRT/i6
 QMl+PPTt1RaLDIcCUk74cAw+qiMAuGtnYlFTWlfoyi13ePhlNQ5uK0KdNKYCoA==
X-Gm-Gg: AYBFou3a7hR58ZjutAvmtl8NmtemPRD61ecpBLtsjDZWr2Qx5uQaPg8UUx4Njs201q3
 Z9FMS4ha98P4qDtJw2dWtV/Z+2HGf2VNAPmn/gC5dxykrfVbolfm6+9QV2avpsQGPpEtwKMNvzB
 RO4Ozm9IaDCfhWgDcBo8GYcVZmROTb9GebuKXR3ZeLPBJc2C6yQo8IsLCNI/XfE9zP7Msv6TfyG
 bvdZ5wDz1opLAfmLRzU/3NS5jTdad8UEsAKsp/BM73+hQTQq+ASDn/85VUmP8lOJNoWcx2ta2Zc
 Ks2PVnYtcy325KlWZ75bW2pLTpbzxF9AuSrCKIH/aXh8OnwQtJtK7tFFCF1ueWuMb7wM/c7haNp
 M5un5zVzgPtL7bC2Sd3PxQTU83UtFD+jxVBopSktA98QNi4abkbbG6DDgu5oxGDjgcAeM1B1VR9
 wy+pmYU3HjDUflDwCSdnfy/AjRDr9AZ1NRz2r+ME/m4cbCWoQbLXpXg2u3s0WTUpLj/7/ls1WFW
 vveGmNLLudC3Z05x6/1GG66nSsyLRdMZ+oTNaXrhO8+yBiK+DTBNQJ446PXqGIO4F3dnRsFGtwL
 oEF7S4zV5vjsqQ9Z7N6UDxluCX2sF5Rd9n99Zr4mspzrX2cPEwtHMeNfjiNXRz5Ze1FPpe2FCKD
 U7IA=
X-Received: by 2002:a2e:ae06:0:b0:3ac:487e:7aea with SMTP id
 38308e7fff4ca-3ac9cf92fe9mr11443901fa.24.1793295287341; 
 Thu, 29 Oct 2026 10:34:47 -0700 (PDT)
Received: from Thor.lan (nb6bp2luucgh1ubvhqb-1.v6.elisa-laajakaista.fi.
 [2001:99a:a58:9b00:9119:221d:45f0:de83])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acb5d264ccsm32531fa.21.2026.10.29.10.34.44
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:34:45 -0700 (PDT)
From: "Maxin B. John" <maxin.john@gmail.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH 0/2] test: cmd: add binop tests and enable on sandbox
Date: Thu, 29 Oct 2026 19:34:37 +0200
Message-ID: <20261029173443.1495866-1-maxin.john@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:41:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

binop has no tests today. Add some tests to catch regressions.

Each operation (xor, or, and) is tested with hex strings, environment
variables or memory as sources. Results go to an environment variable,
memory or the console. The tests also cover zero padding, console
wrapping, bad input, plus the heap overrun.

CMD_BINOP is enabled for sandbox/sandbox64, so both 32-bit/64-bit builds
run the tests.

The tests are a follow-up to the separate "cmd: binop: validate inputs
and fix heap overrun" patch.

Tested with:
  ./test/py/test.py --bd sandbox --build -k ut_cmd_cmd_test_binop
  ./test/py/test.py --bd sandbox64 --build -k ut_cmd_cmd_test_binop

Maxin B. John (2):
  configs: sandbox: Enable binop command
  test: cmd: add tests for the binop command

 configs/sandbox64_defconfig |   1 +
 configs/sandbox_defconfig   |   1 +
 test/cmd/Makefile           |   1 +
 test/cmd/binop.c            | 192 ++++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+)
 create mode 100644 test/cmd/binop.c

-- 
2.47.3

