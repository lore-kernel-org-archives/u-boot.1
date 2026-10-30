Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F2606A32C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PdM3oaFU;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mucODV6z
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1799860ADD;
	Fri, 30 Oct 2026 12:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l0KlsyhLlV2f; Fri, 30 Oct 2026 12:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4901960ADB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365189;
	b=gnByUtj5qV1314kESSpisn0AXW9d2mGyj4RyLHSlpFD2SPNt4uVbkKDR/1j7sZbHugxR
	 dfxcYg53NFFJxWpwmGxZG2ts+fkB2IjC/7uEgpKgvuxTRDcNG87DrT+KBsu1/L0DGcYCV
	 H+ie3sjMEBPrqDzN/SkOhbwb6QdX4DSW/AWQFL1U0CIwbBkB3QudDV8z74Mdj9gVxd5Nh
	 8cciK0OAuCScy4zyrGSggwg9YDy+qnUfpdMhk2D3HMCDnKJ/S6yAbmRBMVeqefmeACUA6
	 cK4seKwgQTBtDjiXgRbUnOw3t4GkKMLutFfw67h+GyU9wgRuK+psn1iDsxOG7rynRiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365189;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DphhurV3w40nlDbo5cXQ6YHHS/P8LeLC4TAjssy0l6Q=;
	b=dRbUxQ2DrC0l5m5tqO6iq4qPp6ZWfK/qDVmSYW5iBxjJwd8VLm6AI+hTPh1LDGZIFt7t
	 W1qDaVg0eEcJoCN27RzvuCwYnT+S8qJOks6R6Kph4sh/K4L60qGFXRgoqWJQn47ljnO+i
	 MgACS8nAt/e7gDxKKgBNy0ZbCdYXmYogOxxG3/wtOPeNerhuAkn91pmr86q7eGcwZn3+E
	 NNUdB3DoKKG1L+dZDWfllwRV6KaP7Vgls06qPA8TCQtgHW6DcLO5F0J818RJckgw8smxb
	 uozeHswQcOGk0rp6Q6vX7KT/d7BTgnac3xbrsb9rj/22MKTIecJgQ9Fg10AIboS1wQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365189;
	bh=DphhurV3w40nlDbo5cXQ6YHHS/P8LeLC4TAjssy0l6Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PdM3oaFUHW3RwMdfBj797Q0HRtCpFa2SeLWgKIp9jNxRDztbFRVExsmT6EZSK7uxc
	 dJH+3z5ihP4L/2LrzIp5Ll1hQMOe31UnaOUdluykxz/6W/jFb1McJ6SiOlARlemEX6
	 bkylvIVmKEFLjhXnjABXMZqtvBHOahgsBKSWW159Evbviq3Tpg4Z388weA5JQ6BxDj
	 1pC+azdukvV5J27ZNxa00PIbNhNxy9MCi0UedXfkcpxj4GGQ2c0r2+CXZSjmtU65v1
	 5jVLMMFnhqVsA4bGMVyiiNm8QCXMcmf0oFI0eN1GYXq3n2IODg1IaGTtuDWeusynMp
	 DY50DrKAhiQNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4901960ADB;
	Fri, 30 Oct 2026 12:59:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 080E6D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E210640329
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFPMn3Cvv_hh for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 04152402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345852;
 b=f/4Z43DlZxyiznDbTysFvEqOkeLwXlZl6W6RUDf9y5G5ms1lCmKBL21qTbYhYpvrG0Mf
 +ucCLHtxFbyg5eb16yXFpCEpoqpEk/4xgPDLfKp8Q7yib2a3oJVlJ6FWZxJMPMQBzqgh9
 6rmc2ZC30iRvFPQKnbHTocn9vGszHSrDn6fSq/V4siZotT/rjCl/3z+GUmHgbda9qRDEw
 bwW7KnD09lH26wtjwpIEgCyj3cfpaJWbLQWtE45zz8/pZ8hnDnm23FLEI+lspJA4ThRrD
 BRqGNHT5GIkGaWYcKxxEJErlCzhW6RmOIq+ayyIyKgvWFpyG97Bqah1aoiJHeFp9TIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345852;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=DphhurV3w40nlDbo5cXQ6YHHS/P8LeLC4TAjssy0l6Q=;
 b=B07Tfrze5xoXa94VAPgT4r7VU4EEa/kexpACqv6Sz9T4loqYzYki9FDIltkOiB9V9zsQ
 sFwHsAEG4ZkIEIx8NJzWgxk5B0BxnvvVGRwEY8hPep/bw4y030efk7DaTZ7jzKrTHRWE7
 JkzDeo2DXFM1nzzAVwgYVv5/o/uC+GUgUXrT2/Go2Q4X0WKrE8p/g9n/uIpmdESqsV8SK
 3tXH5BQVlod1rkSSRBWOaNavJF74LzSGRiLRtog61HFICn+qZHBQvDGf2XKDR2+z9aqoD
 7gFIlf4+Tp/SJVX7I/rgauJ9tJxUKeQ0G4bJmMMM/aB641CTvxD9pgYZlaGkY8VjazQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=mucODV6z; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=mucODV6z
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04152402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:31 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso2257515e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345850; x=1793950650;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DphhurV3w40nlDbo5cXQ6YHHS/P8LeLC4TAjssy0l6Q=;
 b=mucODV6zkz86KqatPuT+onG97CQzxN6xm4oS9FICbzLKH2BvsoGxViAiT/hsk4GGSi
 r6pFQhCI6xmdw2gPJb6wDNMwiSvvn62vPBgfrKt8u1tMX/npIzmoPy9d2lLU6ifxW/Ht
 DIzW53b3k9Fk4Ur2JIMSunz4EY4oPGD4zAUnUD4gWeNrcLx1kBqHMGcLqbsLnxgu8dek
 g0auBo4d/Ei/+krQ2stL7FCbeBMKvqyMGEzamhpEiHFAhlkL32a8KN6nB8kr3oLYumGR
 DJNaOLB13ApNqTtuzNrn8uEy1VZ5f/dmvKoYJclm4IR9k+/ZJ6AGEqSpNMMOv+wBau8O
 0Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345850; x=1793950650;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DphhurV3w40nlDbo5cXQ6YHHS/P8LeLC4TAjssy0l6Q=;
 b=BBVuTg7ihgRCEdnzpa7xR5LAreCXHJeVb5nvtdmDrxnTaV+EEDsVbjUdUSBmhO3nU2
 npChzTwxArnvT4VgPMj1kYWLhr+MI+jvvHnkzwpxdXftYYjNi1FhmZZGk5oRgXCjn8yM
 ilJlVi1YIvNFn79QNwEpMFEGtXVim8oVcQjfgIqPNbD9z0cUXA+pv7zu4epSniSMwwXx
 TpCQhMFR9Jp5zahYtyhqmpS46FNYQ9xGl/i/3xt4NbcpCvfZ7s39I5G8nDlisI4Hyara
 ELu4uhgbM5XhIN+AOKgUZoj7uSBiZNIPphYoG/M/SwexQQ5lzV7Dj5EvOjcv/Nxmm9NN
 IqyA==
X-Gm-Message-State: AFq9FYLvyfR8dNtqSrIvJAYmD40rkp7q0aAI+HDm/R7LkLFdAkF+qQqR
 9D1Ln/K8CjG/IGwDJL5sUr9dz8aQgl8QevYaAbksCER1OkEfxt3qtBDzUH47Xsol38Y=
X-Gm-Gg: AYBFou0gu9EyOqYNWf1UxvZ9Wp0M81bAUPA97dVPXnw4FSXMRfq/ZqzfYs1Gy60ycGE
 vmRwkj309SxPOQRaz9R+J1I6lm+ElL1Kpc7rOAhXOeGCwL+dSjRJZWfCE9fpxxAmaPbMaVcXdhx
 XiS+BBXc481ehOVzJFB9NyW44If3xrBoNegQdt5uEpaqoaU/BMEeklz8RDp8HJaTciIn3E1cKtG
 /eao/1r6RBQBJNS+BKR1HHv+TP6fA4gY4pnN/1AaqRXnh92RwPfeFMDlexijDB2ExXd+SxrdK9W
 IuBR4DML80UOOFGAQllefPYzSEiCRBUmb4ORMG4ixDP2brjC00Dj9ahiKuFA41nQ7vHk79cbL5h
 PnCgh59B5NS2hoaC/W7k4JytF8Q339wrBshQ7M6Ox2SkZUlc901Sl1KvfiXO/1g/udmgYDCgGPH
 1KCnu8Yu+X12UqIpf39vYuysCfRGvtkFtGzx01ye3lYySskW0tbcp7bHAtah8+wGyfr/90mCdRV
 Mr8WKgYYTO89/c0Q2D3Z3OFeXP6C4S3IlZIUYvOFlOxMmc2kBknGIxWr5LgtkAZe9sXzZKSkYVQ
 jxW5gCLGFE4giINKLJnSq2/NmQKzwcqMBAUcwv6q3wlOjJD+0lhd2a+e
X-Received: by 2002:a05:600c:5397:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4ac15584cd0mr27058865e9.4.1793345849607; 
 Fri, 30 Oct 2026 00:37:29 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm65252315e9.1.2026.10.30.00.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:28 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] mtd: rawnand: nand_ids: add Hynix H27UCG8T2BTR-BC
Date: Fri, 30 Oct 2026 10:37:21 +0300
Message-ID: <20261030073721.164747-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

64 Gbit MLC, 16 KiB pages, 4 MiB blocks, 1280 bytes OOB, 40 bit/1 KiB ECC,
ID ad de 94 eb 74 44. Found on the MK808B HDMI stick (RK3066).

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 drivers/mtd/nand/raw/nand_ids.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
index 4f46378f..6a6a73c8 100644
--- a/drivers/mtd/nand/raw/nand_ids.c
+++ b/drivers/mtd/nand/raw/nand_ids.c
@@ -61,6 +61,10 @@ struct nand_flash_dev nand_flash_ids[] = {
 		{ .id = {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4} },
 		  SZ_8K, SZ_8K, SZ_2M, NAND_NEED_SCRAMBLING, 6, 640,
 		  NAND_ECC_INFO(40, SZ_1K), 4 },
+	{"H27UCG8T2BTR-BC 64G 3.3V 8-bit",
+		{ .id = {0xad, 0xde, 0x94, 0xeb, 0x74, 0x44} },
+		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1280,
+		  NAND_ECC_INFO(40, SZ_1K), 4 },
 	{"H27QCG8T2E5R-BCF 64G 3.3V 8-bit",
 		{ .id = {0xad, 0xde, 0x14, 0xa7, 0x42, 0x4a} },
 		  SZ_16K, SZ_8K, SZ_4M, NAND_NEED_SCRAMBLING, 6, 1664,
-- 
2.47.3

