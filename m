Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54250CA5FC4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0590140E0E;
	Fri,  2 Oct 2026 12:26:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49YPdKvtjcdK; Fri,  2 Oct 2026 12:26:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 00EAF40DFE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790944005;
	b=CGTgiYS7OTkfa5CbxL+dGFCnSels2wz9znaWWr0aZeKjeVejGX6VnovShiN+yKYyXXZv
	 7sxB3tweEnExFMiI+03OzLcEzgJSh75pDZSfQ7POGA4pEIQJiat6RS8MuEoIHJp2nfT0/
	 5wwce8oEBKa9+XaYSBpZjMyi9JsWGmGQnoXBAm/KflJrQnsbu1mXN0cyB+/OCznBQ8Sjh
	 f9MgT2MZwgzI0gmgH2+WXM7kNM3y4lkeShYFSwGtWcCnuoswbc5Yf6L+RctPn0gdn4w8Y
	 3MXi+EpNPVWjlV6K35TdNOtfVFkySRG8oZlGgHnxaF7eqEVKPeQVQ+3pUN0dwrKmgSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790944005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QQiQOFpS3IwWHlHRuSWJJvENUrQIOTaiY/BvE8VlpbM=;
	b=ed02ik45Y9XmIpNJosIYPRi3Am3LovijZ4GPEtGOK9IH4j7vv3+BcfdNqHF5yp9A28sV
	 trXZ0Qv8E70vO0vHR1+cdU06Jz/P7isQwj/NXOmhR+hzh5ACHeomM/QRo57hU7EHTaLN6
	 EQunrnaIFwPXxGGgNfVrXczpfMZwpioXT1SYX6GI9beZj6W9Ys/QH7EWMTAzjRdSQnVVT
	 rDttgEpe1Zr9CFlpjJ6px4hZe3N8QOL8Btynllau4XhiDIq3R1xGf2b634qmq75wpiXxx
	 iKK8+gbNLSAz0/QkraoKatrI0lA+9EOnpBQYp59QHLQvuOVsZmdiC/X+bmrQAb/rd9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=BLVmGw60;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790944005;
	bh=QQiQOFpS3IwWHlHRuSWJJvENUrQIOTaiY/BvE8VlpbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uk3K8/pYBzs2kYlRUSKQoaHsy1z7m1OK94NjNEa3PgYPBu2QQrQr/9yvQw8ILR9Rm
	 cNKO7c71GIgXaD6Ye9sjvuJzzEHofOYe4bOpZSgmnZnc/5X4GOny8kJ76gJMbE+0TC
	 niL59w2u1kPovjBSo1TH+BL+DzD3/t1tBOM/0ym6GnHQQwEy5X/OxNuCihUIVzt+Uz
	 hA+Wyl5MmzpUwYZNZswRhiW0DIWk11C0elWJJGADV+E5eoTvmi1CJgIMNZy6dDycaE
	 sYWL+rrEAy5JsopoME3ED5C1aaSgdmH8oLN/kB4yNsddIPuzkEzr9S5mzgfYciXyy1
	 AXTjfxZjXZFwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00EAF40DFE;
	Fri,  2 Oct 2026 12:26:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5CE294D9F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F60140BE4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id momxAkHa4Uqj for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 07:34:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2BFEC40A56
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790926480;
 b=f99x21EMQPeHdx6sv047ar/2e0RBWBb3n/jYdHMqvzw0cPFG+4QbhcubDBoAWE1jfFRL
 fPGes5UibohoKnSVGJY6PfKIMyCvk8n+53O67lP2ekRLMwUjpReoS96qWl9Jz+HBzbXW4
 IudKhnU+q0KoWa2RNMKQ0BuzP21J1gZ18XPwfuCWWQiyUduvYx+OednpFiKFF7aZmqebq
 dIgYqUjokWdNMnH1skHZoo9Lhcf7J5pROvfVGv90T6mz0b1nb9UdFrkMuSIoAX3binLLn
 vDT+diINJttojJ92batg8+Fk0D1SOhJXafv+OR85tE8AJPD6ummuHHszAB+UwmNoJEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790926480;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=QQiQOFpS3IwWHlHRuSWJJvENUrQIOTaiY/BvE8VlpbM=;
 b=rHk43O8ZZ3tOTMlAKG+bKg6QsCjSruZjsUsoeTqWlc5vnXcfE97dNDiJDLRlyCRY3Zr2
 UOOOILbTra2HROeeM2D0r0FReO+8UxKQQHdTzLMB4r7BGAvs9k2r+HNbHipL9hZz01xsw
 S8Iz+/O9eas1xkkw3YOx+/Eqp4LO8ZaxaBfeudhUYMpwHwgiDyWDXNu7DpA+y/iwSrBkD
 qb+15tgkuZMDwVhXqsei2O7BdUrb1KiXv8kvxlFOM7rhvz92WKml+LzseFA+o7cG8rFDk
 TyH1v/1XlawQIbvWu99eg/419CzvecwO2d85cFohDhfwK3n6G93/Yib60a/9MWQq7+Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=BLVmGw60; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=BLVmGw60
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2BFEC40A56
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:39 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 479033F2A8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790926478;
 bh=QQiQOFpS3IwWHlHRuSWJJvENUrQIOTaiY/BvE8VlpbM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BLVmGw60IRciP29NKpAaOHl6GjNGTDxX2NVup6585sSuuN2e3cQhwEKT4y+sdiAjN
 3Q+mUcaUQz24QG3Z0fiLm+NNCVir+k+oikbs8lpKGQq0q+JMg3IRoSeRj+mWO8RbYT
 rHQ86y7yO0aw+YkSZYK5agiYOA0G1Qi3sK6ZNqmhDmarPB9rfCh9Gj8X3htN+VQ7t0
 zPNwZC5M26j1Et6G197GxNfH9csXmXQaGhCLUNVxYZoBzmfxNinneFt4COGh/QsI+8
 7iT/SMV4alD3T+KA0g5PCFDhyEMKMkJ04uxB6Zn5FrrBIvEV1q9kZV645wtozsKocw
 F5Ln0u0dLeaZXqptFCD6eswH+bW+Bn0YFdfi+vkIkl9uBu5ubjQtbXr+VZg8iQOj6+
 TjbkEE+lBAXqKEWGkPUl4kcega/QcZl58bgoS5CcvqQTPKucVmOGXyUT7To/gSL01l
 agVnQkcr9TwUMVqAQSMG+YXgzNk8n/hzg3u+ANYneRnU4Oa2S13T4xGoZewlIYhSAA
 b/dzXxSwkoAkUNxP2KLt+9UrtZ80XiP7/HUe/y0ymrVJsJpdqi+DUjIjpI9O7bj/bf
 eodKeLQgY7/6YsKTjC0ahqH1WrPJPN3entoZAgCQT57xzs5/lLJ84qMagFWdtj0Y5j
 Le1NvwkP2cRFqtqDjdd+cmYA=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-395543dc382so7832861a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790926477; x=1791531277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QQiQOFpS3IwWHlHRuSWJJvENUrQIOTaiY/BvE8VlpbM=;
 b=2vRlK6dUXUlODCbSAmipE3La0iBtuteFqQGtzugWc4/OxgzcRQhAgk1oKedJC9XeVj
 yqGgTcJQqu9nMD9wHGpzIypgs9COHvYeaeNli5Gvg2hLBl7PBHXJBSulUjXfgFDIL68H
 khc3H5Pt4YjLqjFu9XG3vJlFcUYpk/hmFWkjougHIW3jA1ax8LIqflO/VHBRJv+j8Bf2
 B3qWYAJUYZf6/VQmajNDf3Isy0+TrCBbgc6G/7p88cBgaj1WR88vvDEn0iJxDZ9/bo+M
 oEqSOIaPzz4fX+Bci+7ROX6SIFJiiOXSOaBC7sGxoPcgffDkxUieOcnz9uOoAMP9EvGK
 4DMA==
X-Gm-Message-State: AFq9FYKZUMhUdwjS3hGry7wJ17nzIhZFwiEcQX4ybJ9xE3rsfiDQjciE
 6DIypcCJXYpnwiq2CY+UnjKIawUuhVJw8S7nN7DLqjwLmcXLYZbzFCh+wgE4nrcwb/EYSQSRG30
 YEjYpyJ/NPxUFiMGR3cLdydDQRdjN8XLqHMfA95S4OKLF683qYn4SH4lEmqsaYoFoZiZDsAeMp5
 Y+5OETG2XX7j30UM8Xew==
X-Gm-Gg: AYBFou37SFB8ax7vXLkuuXViQLtdQ5EhzL77Sk/nUPcWun6I1PL4INCVzt/ZU6DjCTJ
 3FycJey1lYGEOyA3K1rCbjPe2cRT6kT5YZUE47Z1j4HNEs+xONCZ4ry8u/nO6RNehoU1Yg4F/bj
 8gBnJ7c0OzmBApVVUlohmJkIcKPvGID3jbnX5RDIY6vr7tkeidPr2wHFyt7m1QAoelG0Q/5bFYq
 vfg6mkrcr6+sNPAsKHn9sZGk5+4zSCM1epdovxI9SdFqlyH46hyIjO3Fn/zdAA8PkecoFaE3Fwl
 OCPXezQtHDUE60+xObb8CQVbHEok8ubOd+RE90Avtkf7NHDRQeY5HDmG5HR+ObCf1/6wY+FUsAK
 DMmKXnhydoqlT8fLGVxPNWo+yIqiRyk9PCH4AZ8zNfeVdn9jCxrQ=
X-Received: by 2002:a17:90a:d2c8:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3a6ce6af3eamr890741a91.13.1790926476591; 
 Fri, 02 Oct 2026 00:34:36 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c8:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3a6ce6af3eamr890734a91.13.1790926476181; 
 Fri, 02 Oct 2026 00:34:36 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd44c2c9sm3172004a91.6.2026.10.02.00.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 00:34:35 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 4/6] pci: gt64120: drop the duplicate GT_PCI1M1LD/HD_OFS
 definitions
Date: Fri,  2 Oct 2026 07:31:54 +0000
Message-ID: <20261002073357.382228-5-aristo.chen@canonical.com>
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

GT_PCI1M1LD_OFS and GT_PCI1M1HD_OFS are defined twice in a row with the
same values. The Linux header this file was imported from,
arch/mips/include/asm/gt64120.h, had the same duplicate, which has now
been dropped in mips-next [1]. Apart from that, Linux has only changed
the header's SPDX tag since the import, so there is nothing else to
re-sync.

Drop the second pair here as well. No functional change.

Link: https://lore.kernel.org/all/20261001053016.76578-1-aristo.chen@canonical.com/ [1]
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 include/gt64120.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/gt64120.h b/include/gt64120.h
index b8d3f03a5e0..375b702c466 100644
--- a/include/gt64120.h
+++ b/include/gt64120.h
@@ -42,8 +42,6 @@
 #define GT_PCI1M0HD_OFS		0x0a8
 #define GT_PCI1M1LD_OFS		0x0b0
 #define GT_PCI1M1HD_OFS		0x0b8
-#define GT_PCI1M1LD_OFS		0x0b0
-#define GT_PCI1M1HD_OFS		0x0b8
 
 #define GT_SCS10AR_OFS		0x0d0
 #define GT_SCS32AR_OFS		0x0d8
-- 
2.43.0

