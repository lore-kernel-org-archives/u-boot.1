Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB919CA5FE4
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 20:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A199C8148B;
	Sat,  3 Oct 2026 20:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNe2kjb1i9eR; Sat,  3 Oct 2026 20:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EF8748146D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791058100;
	b=r+xU9NNKFpUdHbcKKaX5Ujwr7bvDdZ1F358QNmKsBRmTEEreZp4sEMASELtz2dYJ6GIZ
	 dnFPxAg+4GesxES9SCHzG20DGQD69iGIaiTWlsNmOYobSEW1Q+oaPpao/bNuZ6X2Jm5ie
	 cHsfod5vN9IsXgCeZc8ipQs97CJyPo2c3zZEQhvnEsHFNLbe3vVlf18epw4/afjLu486D
	 UGeLjVeIrX8QZLsthVV9S4qx1qzni7ZJBog0Uj84ObUOg7ChePlUkf1tNx0z+e7RR8v/0
	 v3Dcm/1N1xKnjGLKCxMzEPxGRfGDkrG0XxnImPe4bj5f8Y6K/0bBM0cDFdv7BHDEKXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791058100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vyo1L52PJqe1Mt92om7ZVTeRPOovQuhIsFyNyiICeJw=;
	b=nEPhRn+93PUhYJNZujglsz4zd1ls5NGC4LHEtJOsLWUALvwe+fXLJs+vOxiWoV+bm/17
	 CJ/sJd2t12VUFbwKSlUC/+PODAShXz40TAP309LaTUEIqK7YCI1vlE+qw7HFm5zWLBplL
	 hrdPX1g8Impn7QlrArW9k6fBCwMy+jpp+y5ssv9yuBbelhDus0KxyXyaYqZKmVa6ulLTk
	 irOjMc2cp1xOXLAHoiCZngd2mpjlgCcGxpwadPAvyoc5K7TZIesrxYbklEF7BX6hY1cW7
	 rL11u3OnZFSLmRdqkmcJHwTZRED7ptoY7fClVeKMf9b8p07SzHxYulYEk+EbiBpDzvw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=KXkxCMqo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791058100;
	bh=vyo1L52PJqe1Mt92om7ZVTeRPOovQuhIsFyNyiICeJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t64zaPjig0NM9J6Jh6hWBzjTr6YwWVaj6Obfete8xa4RHJTcQGA+F/UuvzX2+w7HN
	 TKDyJ87xs//cLHRu9ScFWzdWNWqb3Bkh3XrXkOiZbj60Ks0Rx5LJtzcEINnoR3kFAw
	 pZtr64VxBq3IGAlSqV6FccDn6pcYLIPt1lOotGEIvwUhu99stnAYtbKq4yYowwuH4A
	 lZqit6RriOwcI5twQlPudduKWVCh9rQCf6TabKOvviFR2R9vCyJrjwxooo4qt6tW2A
	 sWdiqRUGeiPKYzv2FzxBsZpEiCA+2s5I2HBCKbgc+snUAiAMpMqIPDVsWKEmEzb7vA
	 /cve74DgdoIeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF8748146D;
	Sat,  3 Oct 2026 20:08:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 112311A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EAD6C8101D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlfW1my5ZK6A for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 20:08:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 37F6580FA0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791058091;
 b=RvYVZeqZb3ho9ExLHuGi0AwDhGht3+Vbr297bvRRHjp2FwwlpQSqa2EU4hVVBs7KzKOV
 hRcPUHoFYMY6t8KAwSV9mod+ixT8Em7GG1RhsvNSlRWKzkFiq9v3llD6/9DEJYeppQjWo
 F+XDKkei1m4e6EGFjoeSuACZEwQPZ2d0ie187vhDPJDDAGMSNUtY7NS7A1tTZ2C74tvUu
 N42Ll407unJ+2opA0GHJxTm4Y03x8p5i6+PVkyLOponsXqNowuwx3PwoOff7dV1rsW8t0
 UOxl+NetHH1mb1qb8nom7gxzcZFjTeXE0vtl4vkmz4W/cJ1T+jSqrnP+8DLyQOq2Vkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791058091;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=vyo1L52PJqe1Mt92om7ZVTeRPOovQuhIsFyNyiICeJw=;
 b=km1cTC04QihTCRX1mf+HT74WWjZ4gGGfhcFIc5aaxDq630jaWngVDI+OozHmly8W+LXY
 WE7tRMWTjwBTZyInEFgzJGCC6wcPCvZmI7yMZtkgFfZ58GOjrNS1OxjNt2W/T93+MAj2i
 usInsZjtnz9GLTCxoH8pxtkyvZSpraDTpYrUmm6dLe9cp168FsaLPVJ8SXyar/OQojJTo
 Pmf/lbdZOLxRkmUALuJe48grxvEwb00JpvG5KJJTorO3N5HPs2Z6F8uQdB3EWVXJ3HlCw
 BXUVv+XGL7+qYbgZh21w0Qrv4uqixPqEbbnU81nDoSNdr7L6Ulwb/dU3LkbM4cdkaPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=KXkxCMqo; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::d;
 helo=mail-yx2-x0d.google.com; envelope-from=asrinivasan@tenstorrent.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=KXkxCMqo
Received: from mail-yx2-x0d.google.com (mail-yx2-x0d.google.com
 [IPv6:2607:f8b0:4864:41::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37F6580FA0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 20:08:10 +0000 (UTC)
Received: by mail-yx2-x0d.google.com with SMTP id
 956f58d0204a3-6756acdc3a8so421023d50.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 13:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791058090; x=1791662890;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vyo1L52PJqe1Mt92om7ZVTeRPOovQuhIsFyNyiICeJw=;
 b=KXkxCMqocAorqdKooTMJcCMc5uv3aqatFqOrpecGeulbeTNIgJFzYrRUGCmhivJ+5c
 nzYB+BjtRMDnwMpCJ33tnmPjKKSoPBw3UNH5ZUuHh10IGIMBqrGN3Xf+dPcfYB8DEtH9
 OuM8ipSuMfJ5UWMCZD2Ge8G9Cq0nkLxCdlwFtb9Blwr9FrAbcCkyUXOiSFsDHkwF98Oq
 hsKm6Yq6giqC9emvh87b0h7rlomkm0ctK6zhpMn1WyEUcvhFJ2HTHRIp4JKrPvGX3FZw
 uZuvqu2ydp3VusdH1GK/JISxHFwEciKzuKwnDOokBQzCh7z3j6c2yIHr+iOHbWHrR3gt
 9Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791058090; x=1791662890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vyo1L52PJqe1Mt92om7ZVTeRPOovQuhIsFyNyiICeJw=;
 b=1PrUb5/R3fwsWsvFAsEz/8l7dqnAVlplk1ZkZ7m+XNAqYgw2fD2w+0ebuf6Jgo+KN/
 MLuD1yEwJ3XELZehgJDeiVWDpgAYWCSWO/PaGgJ1Vm9mxv41zJBtNYD5mPDRCqPwhGAM
 C2/RXu8rrwHAq91sqtkxKh1W20d9khn4AIT9D7VLcXe2DqZb8eRGpuprhWrVXTx0mRNk
 y//3q+0w5EMq+JpOlq8L29AuVnZAcHpiMG7LTApbDo6r6h0QzwsbEYLS1gZquRlnDBvG
 phJkPYKEWvclf3jB17yLvKdpgYivU3T/oiC1q69nP0xmlX1RXrKprs6ElUsjKSn9pdS9
 kXXg==
X-Gm-Message-State: AFq9FYJu7m3IKZriCLSg4j5Rss69m4xujo8k43veGG0qk197HpGC8vGE
 HsaPSijnSNE8KwB8a48D5/I2RN2nJSIYa21vZs1yrm7Ds5+WV+/bLWtZmYno7dgp3hG5UlARhu9
 h/b2xk9k=
X-Gm-Gg: AYBFou14zid/hC4c8U91L5lw7OeXIzRuqY+zygR+GSFhL+MVf3Fwl3R5Jf/mf/xiupy
 BflCYOZ74qLwRpku2aS0ahktMx5OgrMH7tPiBQQmFH5EVhNJbNO9BxjTfA19cEJmciV0ykrx1rq
 vQrcLvob+cLxkeeWDTw0e881KXiRkDQBNm7FAMkW4KPNIiDim0j1461fU2UXRkMIg+S2DAdbUjV
 2mzZ/5sDpk3X7tw9l7khBzfXrvjT2ZG99gf9t3cMmqE2tRttGpHru1EXpJub5kUQupsJNZnGdJx
 kayYU/VULZXcb/gjC/DubI9c2jl7yDvwnIgIulK6rjdrChIMAFV5RuG64B4eK/eKXHulZVo8IL5
 SA8e1+GidO+6ckayYYu9G4OAuegBHTc9qyhbzwTpJlBcQ0sMnammEuLftvljOC6ziJ+briFLglm
 mxIrVs5oBfgu+Wuj1s3Q9pd9X41ycPuAgp2NX3o76Oh8QIOQicDcuMv7kq1lxSh2O+h0AoGc7MF
 Yy+T0nmI3hImyH4fhQI6s0GpLNI+ZYx9x70drNSvJ7FQ3q1DfUGDw==
X-Received: by 2002:a05:690e:11ca:b0:677:d023:49e5 with SMTP id
 956f58d0204a3-677d0236184mr73838d50.162.1791058089865; 
 Sat, 03 Oct 2026 13:08:09 -0700 (PDT)
Received: from [192.168.2.129] ([2600:1700:220:59e0:e2e9:9d9a:5aeb:a046])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-677c16c243esm986048d50.0.2026.10.03.13.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 13:08:09 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sat, 03 Oct 2026 15:07:58 -0500
Subject: [PATCH v2 4/5] bios_emulator: support 16-bit reads on VGA port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-aspeed_vbios_fixes-v2-4-f8e593f024ab@oss.tenstorrent.com>
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
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

BE_inw currently doesn't handle 16-bit reads on VGA ports and falls back
to LOG_inpw, which doesn't do anything on non x86 architectures that
don't support I/O ports. Implement this 16-bit read as two 8-bit reads
(similar to how BE_outw implements 16-bit writes).

The Aspeed AST2600's VBIOS has these 16-bit read instructions in it, so
this is needed to emulate that.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
 drivers/bios_emulator/besys.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
index e02c9fc636c..76a05e74f55 100644
--- a/drivers/bios_emulator/besys.c
+++ b/drivers/bios_emulator/besys.c
@@ -612,7 +612,9 @@ u16 X86API BE_inw(X86EMU_pioAddr port)
 	u16 val = 0;
 
 #if !defined(CONFIG_X86EMU_RAW_IO)
-	if (IS_PCI_PORT(port))
+	if (IS_VGA_PORT(port))
+		val = BE_inb(port) | ((u16)BE_inb(port + 1) << 8);
+	else if (IS_PCI_PORT(port))
 		val = PCI_inp(port, REG_READ_WORD);
 	else if (port < 0x100) {
 		DB(printf("WARN: Maybe INVALID inw.%04X -> %04X\n", (u16) port, val);)

-- 
2.43.0

