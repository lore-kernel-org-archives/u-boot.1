Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68303CA5FAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9D3280BCC;
	Wed, 30 Sep 2026 13:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2scUl3WETJz6; Wed, 30 Sep 2026 13:07:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3906280AD5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790773661;
	b=rjF+CQUQxyjKTuli8EJ8kjmHeuvq/2RtfUKu696t0xuqdS6PSygggHI/vDI4r8XVEPgV
	 noschXlyHaQHDPO6mtjxTWa5pnlArCyCt3A/pgsnN1ewVrb3OKNLRBOaJ0/tBc4YewZEZ
	 OtvzPUCFBMp4zeAkuMcQLq3zZVo4LcAotSPuClh3iH0cpesDMrnujrl/1SwU6zI4zjhmh
	 Y0XehMppX1T6qctsJEqU82W5xoBe5HOGT3QPkw8CEo9gU2R92g7kUTSZQxU5ygy+Io8z1
	 j0GtpKPjqCGkjvB+XHsDslS4fBv4PBZp94+G3fM/bV2s3ygmLB3nxgyEXnr7CRuXEnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790773661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H9IFhLtehSfUywLsI2fpI8U6HNu/YV0ApAgwkW8eNw4=;
	b=mhUGvDi/8Z4O78u2qXZCE6PP83fzEo0C76rqG0xHlL8VfMLihOt4SINTuEho/iGb0Dju
	 +tiItpk7BfySmOwe2P11jSWDZZLtE35on2k+L9fT+6k/wWabO7j0/sY7qiUDv2hNiq8HQ
	 ylmj0hL2MHpujZr4MPGWOAEjo387n+zmggdxewjjuwIMZurO+rKM7iVhGNXTfJgL8+Ljl
	 Ik+Y+ls4YYbmxzCBxMDx1iYQK2QyR8iYF+Tv0ZjHswYdh9pDRE/3YYA15yJGN8ghQGznm
	 9f5+QotEiTDXFulKckL7KbZ39xYjwPmVwVGaWaZaj+sNU3Ve75D3ZPrjWZVXgqrT55Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790773661;
	bh=H9IFhLtehSfUywLsI2fpI8U6HNu/YV0ApAgwkW8eNw4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ibL5GS3S4zLr32QS+bqMMa/bKoXco/8tmloxWeZydV/PcLvHRHcEUcA6emMwQrWD+
	 0GsmEnJFYfrMuM5KBxZDOt9HdFiyfOhBtOp8GQ3y7/tE4jWRYVj0vf/kAhuj1bm8+9
	 KqefXoMbCEs28uO/oY4xLx6Mj5lxwMrbeT50y/UNUdAe9XJVEhjH8JvJwHkQU99brT
	 Sh5QaGCdDkm6Hsv7WfgRg4QG7CZiUHXZQ/CGwTgPknZtMeHFSbBLXVDQYoPikxO9s3
	 AAFs9fp23+DvPYfz43XzZBvqMnM/6Te1I5RR5pXx3h+41+gAi3c/T7q6GZ67+A8wsr
	 ZNCJNA4rNmayg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3906280AD5;
	Wed, 30 Sep 2026 13:07:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E7D732A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0062E400CD
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FE5_6FK3iWJ0 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 10:00:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E2228400AB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790762406;
 b=T9yfZ3gA/jc3RXAFTJUPX3rg7fwV8O6MU0IizfxIqfNXoMQ4tpJ8CCh5Xjqi1voik+uF
 2VggRvenlhuPBII5PII5+t5Qy4eupXEBJJjmsDeTnmWkNY77BYvlINjibcM1HvClQTuyc
 LrXjDcDqCQIne58cAhDJIude1GtWFDv7CzPU57xCDUoUQk4xVJzPGQHZ1/vj6OuekcUeS
 AoLuE/jQhaELUGytpz9bYi9TkUn0MfEFqR1lLzIJWKLZZ5jnGLpeQJyMmbSnI0cActpqb
 DYgVmZGfWqT3+ttbNb6wiP9UmQnraRbIGbW6ND+lrNx8yTuUo9XmDgWmZBv0/GXYlhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790762406;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=H9IFhLtehSfUywLsI2fpI8U6HNu/YV0ApAgwkW8eNw4=;
 b=cGs4iqvHnHzIepzWcs7X0wUNRvLDDxPhPm8FU2p46sTdXNNcYWDJXfWUY5sic3woM2Lq
 tbtUBIs6ojHHfDJHoY/A7Dr6uDsHjmkBsYq58hu9f4oOCLTX4m2X1dyabClX0mC6PygyN
 FrrK6rVCqr2/0Tc/ho7E/ooDHQHOts59FD/ASHs7j+EV4/elAxJzobUdEfVk795iPcTLB
 cKQgvE9pvEq+9QI4RaXVkj3bLfSCnDGnQ2wNDxdPh5DT9GpaPZcqpxbtiJIM0kmLdXGkQ
 gOM74zSxAT0aHESjfsfF8an+L/+bS4TCS5RVZKem0YTI25Lx3bXBfX+FWOknrNZOl1w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vUyCVqqQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=anders.roxell@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vUyCVqqQ
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2228400AB
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:00:03 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac9a5236b3so477287a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790762402; x=1791367202;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9IFhLtehSfUywLsI2fpI8U6HNu/YV0ApAgwkW8eNw4=;
 b=vUyCVqqQp+QT8zMo3no+6iD1sroo0LinolMFkLAHuiCCbiMrE8zI7txjxKlINdJujO
 mEHN5UrK/n7Y+kDup/zPMiG10KyIe5zJ4edw+Q9fkCLCh+lfmLO1E07NJ64EmvmfLJnY
 xRkjQKxteyU7n9tT7fxKRNBqz1ouqgS4dtT3plbda/425s77i/jXcKgW7GQUaSqQAJVV
 kB2+1UzRkO7+O29tLCGsmPXvCYAz1slrdRRIBa32PR0D4KWKLhCCV39UyVTLGynH0WO8
 SBGU0H0KJNW1TuyJrdQ/HdTviLbwOfOXM5ZoNhoZQiaXPcuFMWUH+2ufv9X1nGLlxPcv
 7ZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762402; x=1791367202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9IFhLtehSfUywLsI2fpI8U6HNu/YV0ApAgwkW8eNw4=;
 b=i2EYDBCpNP2Zv50e2OtB2FtMgNxiJ6qOI2rxPsKZM4SUV0nPBmo/HU72Ks5q3tjfCy
 tNmq1fwqBSDdns4QURaFZDv+mBCDQhaF6DD+TjwzjGootuNMXB13yuID0hW1LRPvaFwG
 QsW9IwB8PLAI0caBS9D4vhf1PbUkcUfIEu3qozvRLe0aGIMMfSnl9Lb1EJQdzqzVf1Nx
 xY8NFCSiC7xBMAJCwAcw2xFbhkjxHXm0emrX04tLoctHTg7iaDqYgWmppCVCTKp5Tx8p
 wALB0W+qbJFjZnWbdqynjAQADGx1eNB0ETtunT7c5NKLtVqpl7JepQz8SswZkV2rT7K8
 R4fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ0Etpew6C14KMD1BG35Kh3ip9WbpGIO2/XkuJscfv75OpnGetNNxWhPs4IcNNLqhkSohTERo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ8vd27j7lfuTYmpRf0KTGQC7JCCGbrrmUPKwxBeWCB7DV5YxLM
 RkzqLd7Vmacv/zlI4vfGnAxVmiX3QAMHRb9e6LNiKB1339SYSSXTBK2KorbzeH6u8PZlLn39K8n
 /ACLw
X-Gm-Gg: AYBFou2MIU5UcbYIp8OOk2pqiX6phc5TQEDI2QyLo96XcJVaWDpqIfpcFXYMO5iD7wt
 pdYFd51hby0HRieM36yrSgSCek8ATrn77Sz+kXd+jkiYK8whE7ZkvjaGxbaICPMtaXakKFnNvpf
 H+eJ/ET/6gcmTAO/CZxmymD8ou2g1KsADbFGAu/s7y9t/f8RDh2evj0dUY2UYAVt6OmCUv6ChmB
 ip6sOorTPV3sSgvcIQLcajKlumIZ4jFWAaVddDcL34f9ybfYPdpEbmp/RDUVg5nVw6emvPk9ygk
 uFnB1Ri9onqTCVrHx92DkP1vPiy+Wfhb8raZBgENbEDI5AHh/IDqHc2tqOlyFdwWx/ZtoKrqpuY
 nT1Cm5yxmeUT3odCt+MXj/cvvW65tT1QFDi00pCH2pum/RbPmYfuGRZjKQPCoP+EFGl13rfO+Ud
 WEXhNSZ960hMoo5H1hzbk0RmCGJTkK16N4hS2M1VsgG/4tR5FUut+NxcYc0b/rmB7Fbe02eV1rW
 KbGe9eIoxxSHimUs3zgIMFIfjh8qaRgsCI=
X-Received: by 2002:a05:6402:5505:b0:6a9:a2f0:9b50 with SMTP id
 4fb4d7f45d1cf-6ae197f5e36mr655210a12.0.1790762401587; 
 Wed, 30 Sep 2026 03:00:01 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ae1568f884sm564186a12.21.2026.09.30.03.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 03:00:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: trini@konsulko.com
Cc: sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.u-boot-project.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] test: ut: run every suite in a comma separated list
Date: Wed, 30 Sep 2026 11:59:48 +0200
Message-ID: <20260930095948.1556020-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 13:07:38 +0000
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

"ut lib,mem" only runs lib. The loop sets name to NULL after strsep(),
but strsep() has already moved it past the comma.

Loop on strsep() until it returns NULL.

Fixes: fa0b68d22add ("test: Allow running a selection of suites")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 test/cmd_ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 4328670d0d67..bd9905caf518 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -297,7 +297,7 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		int any_fail = 0;
 		const char *p;
 
-		for (; p = strsep(&name, ","), p; name = NULL) {
+		while ((p = strsep(&name, ","))) {
 			ste = find_suite(p);
 			if (!ste) {
 				printf("Suite '%s' not found\n", p);
-- 
2.53.0

