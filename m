Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB514C624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89DC18116D;
	Fri,  4 Sep 2026 07:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ou3hwtzTNSaQ; Fri,  4 Sep 2026 07:13:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F1B0981140
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788506001;
	b=FgvWVvVLdFdVjZkvJNax5K2ww/4ufGuXiIB5FpmfvfOxPZVZsEmZwFpd4pRD+gZFLZOc
	 z6SoNIILp3vC22MnWYlSUHFSbKuZ/YaH+lL7qnz/wIITpWmpxwyKnVUCi5ZgFcCAlzQZf
	 6dlLN8XJg9Wge75gip69rdqwh7N/CPOSvEzH6LtmmGvyq89x5219+o/p9XYkVEBKUjbG9
	 N7jXvmSTFnKTN9AzqWdntH80CzX5iFFwNgptiQqM+NPxv8zmycR/xY2mqD3tloF+NTjNC
	 h1ISHOm3znp0DXxKS3/a2UVQv8XtFC1HtZ9dgJehj5VRR+hX4+cmoWgkTIr4Zwy3urg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788506001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S5N2MOdSMvRqqMuwNfQiFET8DAKx/ix8/AghCxliWIU=;
	b=qMS7jqCqKQmoews3rbxsxwSauADtW5dTM63iR8oqCH6RJcEA5CaS2RQ9yjW4f8fF4a+d
	 LZodclW2sTf1CbdDSOqct/Vw5JHmueBtDXNf7CVOw/MYaLG1JQp5Alwedny5CB0xpG2OO
	 0SiUqmxCJibFbZ4Y4YEH9XNTcdJCAOMR9rIhQ+1vpwsDc6LlevUUMv8RP25crF9fO+bYv
	 CMQYoW26sCOtOBpWnL/pDyfBDwndD2lLSZz5klkJEIbPbQBoTj/QZlhTJtffOSbkrguoM
	 LgfSTwZGNNQJl/Y1Zzd01Qwbon/BD3Gr368Q2XA9NorD/IDzUGXhCvHKhY3CHoDkJBA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788506001;
	bh=S5N2MOdSMvRqqMuwNfQiFET8DAKx/ix8/AghCxliWIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FDR83mbHrhnKdKt2R+Ev3tznvlL9jWcqf8TJ0lsMHMGSMC/28Kb/MktKmkkVzcfH+
	 XpsQcIblWDg/z6NVkLUelqQtyqp013bnWVZX99qKkB3+vWDUs6KhkmuqcgsKyVEHOr
	 BJLNFiTboUkAxnWneMnbekXJp3EuyWbYkpzfemRuKOJrV7swKgrJ4FQVzs4l0PDldV
	 Y3egPtdV1rAgaU0DGEL5IcK+nRCdjs1JKY39Ssub7cuS0bP/oZRAFIAmwfU2Eie3Pr
	 KGBuXOpsnFY1HFSekz+GhSrxvsdjaLBGC7LYicBsF2LSi2b3pi5qOv4vpnmDEPZ17F
	 MShBrIbVVln4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1B0981140;
	Fri,  4 Sep 2026 07:13:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9FFB2FD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC45F400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UGyBzD8km2gJ for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 642804008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505998;
 b=YYM2PyLkXqWfn4WAK3YGfxEyFr15rfXGAdBqRq6w+OAd+CnRSZzUUl+YpyFUJJ2YA5YI
 BjAAiBeq/z/jAFBmTynTX0FdSN6LTd0nwLJirHR7PKwhLf8DmRDkAxtwPt02yixixKbpb
 syD5Bqyfx3LqjDGj7Aq+1SOKHbcqozM3IuuyUuF1zJSeOH/Z2zhzRvkGt4YQg7MT4z/Ck
 aZmz36CcDrXCrNaRT4U3mOjGIWM2GBaB+1WnYlwl5QMDVhPBqZV0Ukbh6jRpsk/zCO+kD
 8+CoJCnmYaMuE9bsV9WhZn1Uhd8UcQlQw27f+Fp/wYsMkV4HSAvPK7TsvCNjbEvI9MA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505998;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=S5N2MOdSMvRqqMuwNfQiFET8DAKx/ix8/AghCxliWIU=;
 b=o7uRLVZ9oX87jDHpym/0mzpGschZtXTrCIy87Ly7cLdzJkSKMVjuicCZB6iTHTV9HY3i
 R+7TnK4dGVtO0kP0OnMjei329cbETB0NUt+ZrVPPe278XtldSFOU/GuKIOXB8WypGkWND
 tDHMf6YlLeu1JzEf1hY/5kOrTDMO+WEPdTBH0XMjEqslHJ1Atv0kjd6qn3YRwE6Ty7xlC
 SiwPNjLnhJEBei/LyIVIcVY4Qlz3TVy5cDfY08Lyg6jECWxzyBI+nY0ulmMLA/PFIb1oW
 zRasfyp6+m5WCsZAkFQiTPZdhGuc9NVlAWNsgu1pBhDRDH+vD23UFJZ3x6iWGXTh7LA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=iHT2QGnJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=iHT2QGnJ
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 642804008A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:18 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-485850cf499so351241f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505996; x=1789110796;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S5N2MOdSMvRqqMuwNfQiFET8DAKx/ix8/AghCxliWIU=;
 b=iHT2QGnJvDxm3TEa0IPq6CCqVZDZRBTJN+uXM5JPUFiQz3evtK7C+17rYEAMxtdkFU
 QcYRITt4QGzBkzQKzccJtY8I/l1z2akTj+2MuzWiZTi/n0NBRAcGMFCFpLVioHctKvwi
 zBpnm+keNVOJrwJdzT3A3mNyM1fByUFO8KPd+STCLxxH8zQoawSVgS6NFoHjUNzRLNYR
 pvPTz5tC6WGjeYrIy+Cx9wHNzbd1/p19rKrlYYEpA0VCSqQH3XQ9U25JLpXFCOz+GdKu
 s44ThVX/0OC65VdsIt6R7lU37hIkNf9SAViP+8C++wfYEuqlXylgjOnVVew2XcfW6Ru9
 4OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505996; x=1789110796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S5N2MOdSMvRqqMuwNfQiFET8DAKx/ix8/AghCxliWIU=;
 b=VAQpacL937Mprhv8VPE0uHHnn3m8lbrr4SAlPk5E7qB0l9eoUdgSJpyig3pTj2/QFZ
 24T1htF/Fu33/gB+ckz/lrNzPSSK//t2sZRLKzXmUOIroFtZdI4j4IJN3DZktwWD+ipZ
 jyWa79B/Rk+PptbYByRj7QMTUWJMWDxa2gkj19lFWsxhRE2n5X2rGVKkfOgkqVcoNJ5s
 KUmNuZeaDH2JGbG7Qg+IAwAg7xDa2XaKbKiVBq70G9aFT1KHQrywXjOI0UgtMi+7cdZE
 cR2TqFOOFWZKd71qO3NuURIoFZaMN3HI6CSZyZcX2hQKmlCWSrx7UAWzTRh2hBlpeFft
 k8eA==
X-Gm-Message-State: AFuF++nCoo50j5RhkVowMBLsh/Efxum2t0ksMzzWp+xwEw07ArZ58qbl
 zsy17z0CtQoqo1ZJILY8euA/klPuHD3WK7nOW8dVWtIPbuuj6kyGqHwXBGv/QgX9OsM=
X-Gm-Gg: AYBFou3WyJftTRh6EGFtcuqEmu6djcvt05QdnW8+YeIjLXllNTf8cW+pfMUqdkyH266
 LFkWLJLqsp7iSUD1WNR+KJH84sQblw4cLS50ge5FqFPNFRn8Ndz9KSDDyzciLIOxp2/XzcvUx2m
 Zz0RrFOehagzB0cbxLikE+QdHzLVphfDrE57O49DnujjP3zXdU/Zye9hFiEYMTY8WL1EOP7cfJh
 9ZBWv7EU+AXIsRm+Mmb+cBde8liLm2prrFwD0maPCqbaKsFxhjzjlnv5Ke5LtACB7J5pggnFLlo
 w1Uou7+RvGUOXwpoNNlYqelnU8H6ky9ORnYeftYfl0XF+MHyW+FikGt8/+z+A5gFekKNgZE44ya
 mYrB6rpoTmmL2wxxS7v4mLurC8EyQRhfafLfTqsH7+qm89Ow5uRL4BhdbT2P5H6rVw2DONxzT8N
 2fYVrvv+LOXlwVfcX+QdM38+00lgcc7WCb0ElHm4cgprr3c/Jd7q5iyhqjOng2FmAaXuQyMGb/C
 8cduOpZGBtcH5dyZrAXwYPdSMF95FbpUymb3rpy
X-Received: by 2002:a05:6000:1a85:b0:485:8c17:9775 with SMTP id
 ffacd0b85a97d-4858c179a0emr1146760f8f.55.1788505996051; 
 Fri, 04 Sep 2026 00:13:16 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:15 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:42 +0400
Subject: [PATCH 07/10] ufs: define the well known logical unit ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-7-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=alchark@flipper.net;
 h=from:subject:message-id; bh=78pjHjKZ3sQWg+Ds+TE7xp3AWrQNNP/H7jFyQ+d97ZA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi/6nadwUO07l5DIhfQLLXetVngrX5p2KOh9v+Md1
 3eFFhOEOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhq+VSG/25mQXzV1Qw1RrM5flZ7uxdWnO5MVk+5rvHRMrTR53LtfEaGz2ZnPra
 rK11+1bPialjEx7itocbPT8o0fNqzq32T2M48NgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

A UFS device exposes several well known logical units that live outside
the ordinary LUN range. Name them centrally, in the public header, so that
both the driver and the SPL boot path can refer to them.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/ufs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/ufs.h b/include/ufs.h
index f6e27d90e43b..40088c935209 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -4,6 +4,14 @@
 
 struct udevice;
 
+/* Well known logical unit ids, as they appear in the LUN field of a UPIU */
+enum {
+	UFS_UPIU_REPORT_LUNS_WLUN	= 0x81,
+	UFS_UPIU_BOOT_WLUN		= 0xB0,
+	UFS_UPIU_RPMB_WLUN		= 0xC4,
+	UFS_UPIU_UFS_DEVICE_WLUN	= 0xD0,
+};
+
 /**
  * ufs_probe() - initialize all devices in the UFS uclass
  *

-- 
2.54.0

