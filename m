Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8DBCA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDD9F40DF3;
	Fri,  2 Oct 2026 12:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfu5wNCi8UEf; Fri,  2 Oct 2026 12:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E502340DEC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944000;
	b=hpGKqb/DrFhyqKyYTGaRzMW75CgYWOlDmTkvu30eMfhi0IUrP1a+BcH8waLUjyEUtfG8
	 OtDTYWojUum8LKWn+XzrEZZhYwvBaEeoTAc2MAoIVR1gbo51ppX+BrZ2k6GARro0RB4NG
	 NlaoCnzivvK8sMojrpKM4I+8sT4mBR1iB4qz+hc/AcvTXPRvQdQUGa7ok1JT7QTJfW+pp
	 AEo3ZmDaxl3/8JbINQuJ1VABFXt1YjydoTrv4TBUxZIxbL5AgMDGgNkcAlXfZYiy7goO9
	 euwUqysmvW9t//MW20C0gvUTUGBW1NOXBZEEDKpH5fwjm0DCM8YIZFosGB4pO3EWbJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sshLxo8fYeGllNrLdrjTZjczyw+AHU+NC5Y/qGRpXiM=;
	b=egSY9uFh+XalP4Lpk7KY4bEAgKDuIS47rJroji012gtkY/Ki01t1X2Jz3IGDLbOgiBzv
	 e2M/9MjBHunFA99nGd14ZB5RdljDdAcZS8Z7nblaLrbFDHmvu194dfoL1wVUMqznKLkhE
	 Ue3yydMAukf6Ik2AA10RZjXFyntpH0GczyQIZEnAVVZDwk3RfL9eyd3HUHpu54Z9PuixR
	 qL2Rorn+f3m17q5fR1CqwH88jWFNzbidQoWu7Fht6i09ctX/irVrJq7mpAsGtwkvDRlbm
	 dyufVWU2Evpg5qEx7XdTvWZd//FUZ2bKO/eCHb9XQXdVHKvIgMo+tdofHfEMI+5e2QA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=Fgp5kXJt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944000;
	bh=sshLxo8fYeGllNrLdrjTZjczyw+AHU+NC5Y/qGRpXiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ByXFUZBPKD5Ag6GqPNRKtP9Yogu2xjUik1HCP9f4+ODIozv9n65KFYj906QyS//Yg
	 61ooBTDxtOutNg7aYjBSxSDQkqTgoMxgSogaABZV/UgDtiEqk5HgcDJUrWK+UzOP/z
	 Xw9tSKIyUIZ/3pQT1vmpH5N7OkV39g5Ul6RzAGd95tfHiWdbdQdRRiRQRsv2pH5zaa
	 M3v25wgyHV9uFejrXGqmuVwycLjzaBL7+gwxl4+wAy40kWlQRL8El5zXIgcc7Rn3h6
	 +nTD9HsKMVL2Oc5qxM97EL/aEPLWzldf0SrLHL5Heu6ZoNBnQCPlcV9yZyU74uECDn
	 oHKleoSYn9SDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E502340DEC;
	Fri,  2 Oct 2026 12:26:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BE5271A6
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A516540A56
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VCB2_MH0CffK for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9200140A54
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926476;
 b=XHYbCKrfHzqN9YHp+nYu7bkccUlE1jTrGVZa+jzlrG31XCKFkI6omMnARoelFCbCdq8p
 v8bp1U2obAuej4ZCl/sRJy9MQUplCSM7IKw3psIHw0uyIUzyX4exQ7uc4ywzQEhbEsXKE
 r8Nv+U3K3/Cmyv65FT+ph3E8uu68vu4me/PrBK00EJHTx1zzGzYPvIlZLdv8l7zDdLn27
 hJ2Rofme6AfDfiVFjLrsrRx6lvZqL2p+zJrTcE4odSEQeIA5DmUG1Dhjy8JbzeYGXzkfE
 VE8oTEnLXamNoaXKCLnknlDckC/KkM4vSx5Y97/cQ+Jj1H4TKYJttLYbjBEM/8BPdyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926476;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=sshLxo8fYeGllNrLdrjTZjczyw+AHU+NC5Y/qGRpXiM=;
 b=CpuBO3fyNrp3mT7RY+7XgZ/YjpMyMEKt+bPoBSkPGLu33i7QZlXTHJ4uyxSJDwImkxuX
 aN2EVlArdNHKfWlKXTeCYCFvGNOWhkFAii6MtZ7iH18rA+Tx+9RAUJT3HYPl7PRZ8TDG+
 3ZkBZTlLey31zJB1z/GxHzWSeIxwltSsR0FYVVn/CAORch6rqYQxzDhHsdBCpklhDV1tz
 IuoEz6SywnD8VJ2g1WlYXilljU+eSF+TBkZckny6tUERCtltRWuAbWHF/x+s7oMIEYFga
 Rq1MijitjjGNdvay3ibaWy9rXc3gsF0UPHeyRPu8AIUjeSPEgaSccnMf3osRS4gdx2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=Fgp5kXJt; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Fgp5kXJt
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9200140A54
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:35 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03FED44DF5
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926474;
 bh=sshLxo8fYeGllNrLdrjTZjczyw+AHU+NC5Y/qGRpXiM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Fgp5kXJtdno1c+AVWZQIVEmwHOM7dNGi0l0G9JHi89mUPbnqNCWqjmlYDF2e05sUo
 lmcyBwdNeyeDcoa5uHF9gVl32IKUTdNHopKvHrVuN2VYebE2DqePt/3WsBn/J9d6he
 j9C8UOJO6SYd6kFflLf49jC37BzdkW8uQKnYycYk/0SNTqxiZMjThEih/1kVqh64h/
 XI5Yfgte8VjuXeKiky/5ZNJcgY9jOz/GBhwnBgh0scCzIuhALZ2bHfktuu4mza9c3+
 3pqYpuqAbCfUmfjCNPspA7QZBxrDcpAWrJRDvLq/H3/jJ3MhZiior8usnVlrq6j4o+
 YzL+oO42eNkLVsN599nH1P4Tp4HOPOztpTw3so3kuRcIulFRlw9nOWeK2mxeM7JuHr
 7cV/M9kjoBUyRnE0XcoPWyBM/62Felx8VmzoOUUq6AxU8MDoCzIk9rRtBLauRTQQL1
 l8hpVmvQGEMX98BxVDJc/iutFPqNZA4Wik/HRLt/eQ6loCQ48HvS2TRZ8gniKhd607
 a2kZTtLIodAujLy2WXnVRbl29op1vi4mUwefjlS4t+icCmNzoYe0GvvlvfP0m9ZQvM
 17HOlB24QXNIgqc9yRsV4maEUJTdfETJSMguTCXeMiu0uS3wjaPaFM0oM48ppO/OqV
 GozxmT3ceyWjzLTTig+LODgE=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e3c10ac70so10383281a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926472; x=1791531272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sshLxo8fYeGllNrLdrjTZjczyw+AHU+NC5Y/qGRpXiM=;
 b=KFagwSeVogVkqGXDQa0EE59TVDnwBbhqgL5mu+Plx7zZ7YX8wCsrhO97yF5grwujQw
 QkuASNejrz1ytTZKbUy78oCM7x/+0lgPmtKhQ5F5la79cLZtf9vQbBLYzONLI+oM8N9W
 w0gGzVaEvTFOs0C00yZIj9gVAdNHPMWSPl1ymif8a/J7t2c/a6NQKuynWb1/cbO380nj
 8bnPKsKDALNI7kExug5JyRQwEDI+s8Iu/hMojxYoW1FyPQyO+XA7WhhWyKpWGUwxZfMw
 WljiGpVrJC7iplEqYyElwz6nRUIL4hztNwjaOPd/G+mbvK0Q8VlpPONauS12N7jCtSD7
 6cfw==
X-Gm-Message-State: AFq9FYILOjRggUPdxzRjZJEEKbeiroNzySGZd3tyd9viFYheo4xGmdUt
 J9zqCFpvxnIdJqgYfaeDV86hkq16+a5JVVtjas4ywOOdjAujNNZBWUzbOCWOIv5UGGII3HrvFEP
 nOJqLNd8H9eSN/1MyGGF7+xD+fohroZKfjiRb2fVrLaQM9s8+UcMzRu8yEPSmEezQULGqTnKWVk
 i9iFbAcUDtCsuG6RFUjQ==
X-Gm-Gg: AYBFou2Nbwr4Fz+mEAAkvoxeVNAocen/b1LFw8qhz41gVhbKJ/z7TEcgm1T7BC7MKi6
 +Nc5gYH+nJkCWWBYta72nkNj7jZO2Hb9daPVyWhsO4AnrcRORvdhaArn3fczKkwGecSADdvr9IX
 beRux9z7K7pHGqKdVJp1Xux7WBNkwfyw/o5xCYd1pE4K1oiCnH74TgbEPRogO12R2KYjX9hj7dI
 1n7eU3/GSOp/If/gT5kUD6hoqy3dzC9ZEvvkIT1p57zCuHMD+Xnebd2aT3uoaAiiN/ybg+1XVoi
 KDDI8shDVo5ltGgvV4D00yhlZ86dx0ZZxEF9nztpVNKkrDhJDUleYEk4JJSLkAyuAFJO99IkRa7
 jkz6r95WzLU3Zr8d6g0LXV0+hTYy7fplFWydP4qSmLx95iEV98b0=
X-Received: by 2002:a17:90b:2e08:b0:3a0:8133:69a4 with SMTP id
 98e67ed59e1d1-3a6ceae5d44mr1733194a91.26.1790926472425; 
 Fri, 02 Oct 2026 00:34:32 -0700 (PDT)
X-Received: by 2002:a17:90b:2e08:b0:3a0:8133:69a4 with SMTP id
 98e67ed59e1d1-3a6ceae5d44mr1733178a91.26.1790926471918; 
 Fri, 02 Oct 2026 00:34:31 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:31 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, Aristo Chen <aristo.chen@canonical.com>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v1 2/6] scsi: drop the duplicate COMPARE and SEND DIAGNOSTIC
 opcodes
Date: Fri,  2 Oct 2026 07:31:52 +0000
Message-ID: <20261002073357.382228-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002073357.382228-1-aristo.chen@canonical.com>
References: <20261002073357.382228-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:26:15 +0000
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

SCSI_COMPARE and SCSI_SEND_DIAG are defined in the table of commands
for all device types and again in the table of commands unique to
direct access devices. SCSI-2 (table 31) lists both as commands for all
device types, so drop the copies from the second table.

The two SCSI_SEND_DIAG copies also disagreed on the command type: the
first said optional, the second mandatory. SCSI-2 names SEND DIAGNOSTIC
as one of the four commands every target implements, together with
INQUIRY, REQUEST SENSE and TEST UNIT READY, so the remaining comment now
says mandatory, as the other three do.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/scsi.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/scsi.h b/include/scsi.h
index 2520a8b8fe6..93561749b7f 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -144,13 +144,12 @@ struct scsi_cmd {
 #define SCSI_MODE_SEN10	0x5A		/* Mode Sense 10-byte (Device Specific) */
 #define SCSI_READ_BUFF	0x3C		/* Read Buffer (O) */
 #define SCSI_REQ_SENSE	0x03		/* Request Sense (MANDATORY) */
-#define SCSI_SEND_DIAG	0x1D		/* Send Diagnostic (O) */
+#define SCSI_SEND_DIAG	0x1D		/* Send Diagnostic (MANDATORY) */
 #define SCSI_TST_U_RDY	0x00		/* Test Unit Ready (MANDATORY) */
 #define SCSI_WRITE_BUFF	0x3B		/* Write Buffer (O) */
 /***************************************************************************
  *			  %%% Commands Unique to Direct Access Devices %%%
  ***************************************************************************/
-#define SCSI_COMPARE		0x39		/* Compare (O) */
 #define SCSI_FORMAT		0x04		/* Format Unit (MANDATORY) */
 #define SCSI_LCK_UN_CAC	0x36		/* Lock Unlock Cache (O) */
 #define SCSI_PREFETCH	0x34		/* Prefetch (O) */
@@ -172,7 +171,6 @@ struct scsi_cmd {
 #define SCSI_SRCH_DAT_L	0x32		/* Search Data Low (O) */
 #define SCSI_SEEK6		0x0B		/* Seek 6-Byte (O) */
 #define SCSI_SEEK10		0x2B		/* Seek 10-Byte (O) */
-#define SCSI_SEND_DIAG	0x1D		/* Send Diagnostics (MANDATORY) */
 #define SCSI_SET_LIMIT	0x33		/* Set Limits (O) */
 #define SCSI_START_STP	0x1B		/* Start/Stop Unit (O) */
 #define SCSI_SYNC_CACHE	0x35		/* Synchronize Cache (O) */
-- 
2.43.0

