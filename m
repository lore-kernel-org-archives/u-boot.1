Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F903606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nGT/pkH+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rAM3nJCS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2AD960A41;
	Sat, 24 Oct 2026 11:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzU1M3k4PKjj; Sat, 24 Oct 2026 11:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2B4960739
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792841707;
	b=CvqZ9+1dnzmSJteaF1089xF/pKyqSRJ8pM2rPkbzpJAabfdD3Gfr3HxwU4gtDnETl6bW
	 0dBW5FtniAYbhAK5xXa6IKd1hWPURKoIbUFDZMRZ3nRZeEGVJmV5xlbz3eays3gLtMUle
	 sI+jeyVuyA+cJW18RYB0P0J3Fr0vCD1+0QgzVQ/ocF3sFfZSt8AmoGTFVA3hYNT2zAZX/
	 +LLHfodkiXdxYt9+AN6NouOtGSq3Y/yt8hiVdRN7WrOMl5BG4j1cCg3rwD/HtmiF76aq5
	 ZJmp9ao79yvWbczQIcWzeQUaVLm4+rdj+ZDQdghBAIQ8ztJ49lNuOOOsn0BAOj5Xx0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792841707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BE+bJPgyFYvem7b2G+KF83WXizdXdGEJxJ+OR3bGKbs=;
	b=llzhyo4lbxPEb/meNynd6Zp6s5TZUjIOTuY31tneJu9TRVlmbHq/nV24sq25TGA0aRWD
	 jJk6kJe08ElmJBHGjtpvvdXphXyAbUo8GHJ7FVs7xbBKg1yzQyxiVXZQdJfYs2hCBB+N6
	 gHd8jve9m2d54rYigyGOV1cwXvApmHwfnsxAgVirq5LBXqZATxGZbjk1yxEDEvQJgpNM5
	 wG5Yo9SAnaC+cP9V3cu5gQHdgpmWSjrYi0RlbqkjRNOMeB12ondXKGG554RP1IEjH/m70
	 pMBGdpRJT2T7vLYuOHGvKNdyjtJQHxyaYi941I+5YWweYJcIJ5vfNGm2UW1rPHDkGtA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792841707;
	bh=BE+bJPgyFYvem7b2G+KF83WXizdXdGEJxJ+OR3bGKbs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nGT/pkH+cikz3rKHc3oZAVtsIMloZeg/xvg93HnuF7YQuVz03/+FMjO1gwwQyi1yL
	 d5hAYVaOy+MwjBw1GcS+DDCQW5qi2URotyrAhVdkzznzNnH2OYI52ygAOFn3uVqbDI
	 qhVWY4xFjR07jnD7A5gag7qSXzrpGpW7ZVGgo9rJj6fobP+e4zxo0uL4A7W4wBIGq4
	 WC53c1KMKnds1WSuM1K3JrEb6N74mTGLLyW89zRceZhaGkOhdAGjINTtJP8gq4WBzY
	 zSPNuy3YjiDZEtFegZ1oJWxtbJdAZQXYB+VgGe5VzyXN4J8sggRI+Vu6/GDHn1ttm1
	 KE0u3IZu0swIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2B4960739;
	Sat, 24 Oct 2026 11:35:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DCF6B4D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2A1440A84
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFoD7RzcNkPt for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 11:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1A0540A6F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792841705;
 b=d9qKrbxHxSU4MwtXLUAxzQaidD9JuRdt0475rdknQwsdBOXBZqU7JrKXITNnxNKuDpDi
 6L4OFgOH5ew17oinO1RQJRCmmMyR5iNExl9/xULzfGbqyBg/TDSKgkoii2DElDrupznKk
 TCmLx5IO5MxcNN7NYnRFSMl9Ge+bND8VbArm1HqCwUtWxCYGxAuno69ct/nSN2z2ssi5P
 sXu0D8sZ5xJhhDR/xJ4y/hu+ERSQdlyHhYhjgmnzQc3CRDTNqokcHLMPlhSp0MFZk+3cn
 clOtrX9MM33+JZktlFCpmY6rJzYsmDWaJjydC4W1e02fLlFfPFnz1JQhcqA9ZXZdq9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792841705;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=BE+bJPgyFYvem7b2G+KF83WXizdXdGEJxJ+OR3bGKbs=;
 b=hqbipcUTRy5vJSyNmp+8TPniIMQ9Be5z+Tu2ymYutfIG6omAItta+gTymHudUnA8FfDa
 X1PZzfSu2LlWqwD0SP921/e13yb3TySoLJixpB57VURGg9mwr+bLJqYxGgD6vcG99XW4L
 FhAA+D8cuo1Lzrp8A2JMQBi73HjenD2UPm7jtir+4bwVwvaIxEHSOa9LVcftqX6i+51V7
 to/a1I/6pFsw7xJ90fEKUrvtMC/FdJLS7CTt6HQ9gy/IqNS3cNyHUPmK/DfGVUi8PWeF3
 YUhmHWt97rEWO5fbpJG1CFxBH/Gaf5lpKEhWRHRYx0EDf4rUy8dA2KTv+/nRqhE8z5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rAM3nJCS; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rAM3nJCS
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1A0540A6F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 11:35:03 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so1210221f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792841702; x=1793446502;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BE+bJPgyFYvem7b2G+KF83WXizdXdGEJxJ+OR3bGKbs=;
 b=rAM3nJCS4r6scQYwTBSGpSjlrNGesDlopfPDNu3+MBDpYIBZNjRNEA7JJz3hNeWDgj
 SAyxfTrN+kKDsm3IRc9dmqvDovvsIhZmy+YGPZHFQD01TXwF2mmA3ScJRf639nEIrjV3
 E2u+4VNPYQYkHoXEzg120fHDgSeEAu3+06UpUQCe1CMxpJBMK9HWmZqu34nKErlZwD3A
 II/otxxIerdncuPMeIhsnElwWIL5amE26zyTOwYWWFbxRgIqV9hE7CLlxM3/zOAcGr8C
 SyaWcpxrPs2MN6NgnuUy6ezSF8woOL2fHAXa8KXM9XyW5YW9Q0/f3I3DFkm+JMljevmD
 5bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792841702; x=1793446502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BE+bJPgyFYvem7b2G+KF83WXizdXdGEJxJ+OR3bGKbs=;
 b=0YlaglEe3FUNGjvwOGycNkw2WJWrJvVbieXZlQmmQ1K6pK57xhj9279X3v+U4gn/qT
 mGoef89DUqm6pBU9tesJMVg/0kKu3AcbZ/TtEEadbKlyDmoPxoNUuvGaDbi7wMP8j2O6
 F24kpcmhtwb3gDCm0V+hv5su4hX93bNxboiIC2HiXyQSB2Xwx+C+GX8EFrSdqi416RLh
 yGKm7wAEXd1gOppGbgPLE11+0FdypoAP6v0o0bC13pvz/K7LzRvv/iYjn/i6a2ME4JDr
 agjvruYwJi+vnVhYlQE7CSkzBVQtyA/EFsB0poX4YyARd3iiqOU33B2PebyQ6nM8v2hS
 E0RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWLF4Qot6dtbdA1nE9yPlWDNNBYuPctM7ffOCVSVq8/ynJ1cY34qZbhae0P4ygIUEsfn4jgzg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLsluRoKm0dCuFzMIt7ADzBAzaO1mrpZyBcRa9d+aH/m1M3C3WU
 ul/mg91DF5ntmpAk69xVfZwptC9iHxFhkuSthzWhvY+G9x1Jz+8MkYaU0S8busj829Y=
X-Gm-Gg: AYBFou0Dn9vebdsLpFXvh1xL8pHDQKO5X49Wr7EKAlIaWF0ZoeOlefhpLdLHjv3JqAZ
 ej18I1ggJr/vfSyN/e4NLjH/J9V3GtQVd0+2NtSpqkayDwfZreebLF7xOACuwJmrZtm2mMlzo0C
 uWT241RGvmO763VGnlm2dkmu2lBJpHbE7xqTXiPAX/LRhxXSg1W1Awb3hBFYqm/1OkVWJd/vZC7
 IGNiSVkSCtriyjgsngl9qICASxgi5SqOKdeg2F2VfIvqkjWAUBqWx4FalG9czmjRm7Gwxj4Il0S
 Ti5QTShMLSiWQlFkxhGaUVZutG05cin9uG6X+EfkHTK6SPZanItaWyyEQ3sYgkM43rUn4ZGtIml
 oLBMERHd+6ttAnLPIu84wf6Xsj4yPeNzi1Q10u/fGqW5V8suXcLnnyFitdiIB/BW6vDXjtK4lYi
 GOkABT3ZJFgZzNKSJTm+0nn7Rd+ViDZJ3QPly5ZsHgiI9TvvzMs/vBRv+x/OknSCmHzNxvlFMTX
 /hjdx8KgCRjXZk9OoFTQT3bC55ZaEEcbWAxUEiaPBvJykRBJD7YZ99h4etKdQhTAvF9C2NgF7SW
 23KoOuU=
X-Received: by 2002:a05:6000:1862:b0:48e:4316:411a with SMTP id
 ffacd0b85a97d-48e43164158mr2151144f8f.49.1792841701639; 
 Sat, 24 Oct 2026 04:35:01 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece13aasm3532368f8f.58.2026.10.24.04.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 04:35:00 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
Subject: [PATCH] colibri_vf: separate the partition numbers in dfu_alt_info
 with a space
Date: Sat, 24 Oct 2026 13:34:59 +0200
Message-ID: <20261024113459.3259910-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

Since commit 53b406369e9d ("DFU: Check the number of arguments and
argument string strictly") the NAND backend takes an entry as
"<name> part <dev> <part>", three arguments. The default dfu_alt_info
of colibri_vf still uses the older "part 0,1" form, two arguments, so
its first entry already fails with -EINVAL and "dfu 0 nand 0" returns
at once, before the gadget starts.

Separate the device and the partition number with a space. The
partitions stay the same: vf-bcb, u-boot and ubi.

Fixes: 53b406369e9d ("DFU: Check the number of arguments and argument string strictly")
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---

Notes:
    Tested on a Colibri VF50 with the ehci-vf series [1] applied, which
    the gadget on usb0 needs to start at all: after "env default -f
    dfu_alt_info", "dfu 0 nand 0 list" shows vf-bcb, u-boot and ubi, and
    "dfu 0 nand 0" enumerates on a host and stops at Ctrl-C. With the old
    value the list fails at once.
    
    [1] https://lore.kernel.org/u-boot/20261023111559.4081795-1-mehmet.fide@gmail.com/

 include/configs/colibri_vf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/configs/colibri_vf.h b/include/configs/colibri_vf.h
index 60f31389fd4..060e0ac3fe2 100644
--- a/include/configs/colibri_vf.h
+++ b/include/configs/colibri_vf.h
@@ -45,7 +45,7 @@
 #undef BOOTENV_RUN_NET_USB_START
 #define BOOTENV_RUN_NET_USB_START ""
 
-#define DFU_ALT_NAND_INFO "vf-bcb part 0,1;u-boot part 0,2;ubi part 0,4"
+#define DFU_ALT_NAND_INFO "vf-bcb part 0 1;u-boot part 0 2;ubi part 0 4"
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	BOOTENV \

base-commit: f97bb5c1ad78e95856917b92c7270c82d4b11e21
-- 
2.55.0

