Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9F606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X0oH/c7d;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U4bpCNA9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A741F606C2;
	Mon, 26 Oct 2026 09:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iL8BRAOCZw3L; Mon, 26 Oct 2026 09:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0320160645
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793006686;
	b=jvjfBXrYm2WSWK+IZVHXHaE/tVau30ZgRuAluAvHrRSRIB1wTHbT0y6Bonh2LixjHyAb
	 Vxj846P/2b8UopE0viT62PDhegUz3EtTd4yuztFiDZhccAVXD5aPgvzt1/AiWDbr1RvxD
	 AXH1bJSR98Y7MFKImaRWeJtS4AnDYFsGXgEQa4umxmy3b39DlL9UGrdGSbntwxmOGVIRk
	 7T+Q1vLPRskviyEfpaoNHS8DiF0mTTIxlvVWEe/tQ+bGZyauW5PkyMGnQJrMJiC6XsM8h
	 5wi3zjSOFiv+sgimwSsCZzhjkAXIXvLYxQJF+obrt+mRVO2MW0edCDlXx48BxDOqi1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793006686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X+Uu8IaB/ICt6tz9Cw4z+kXRWobFmRw0zsD3cq8BOGA=;
	b=Ll7Xsq47rrnJg3h/DFfK2dMVmFhq20tjvlc7/oO0R02Ek+T/g+n5ojuCG8gDtKC7W602
	 mwdp6Q5dhyB8l6MYn6pAUYV8n1D++0WgEmeXYwi6zmYHHZ62Cw1VuF4peLuo1hHfVQe0D
	 5rnO+uXiUHEaJPupohzLkj+wUZA1L3L2ZLEC062edETgV6dJlUpQxKsvq5ipG3eVfHSMN
	 kKq1mGIVuy28p75WCsvkQtsPA/WYY43uE/uWVH2YSWMnriPsKAcimCUexUIFAGGtnwnYj
	 8mNrQu5FKjiWw83Btt0fkg5Jsf4cX3lpBx7oMlZVH27ORD83ArhLY71ZwdsmWBQqSVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793006686;
	bh=X+Uu8IaB/ICt6tz9Cw4z+kXRWobFmRw0zsD3cq8BOGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X0oH/c7d3ab5HuL7mOTBtd7lCRV4M7KAPuLHWjQBNg7Cjd/SdUfYh1tgc66x83zip
	 1HxewwyUK6IucN7LIfjOT8gpVbocXKiEwAIG9fyl9ArVzIfxHmz8WrFeSfYKezKVZo
	 t3XaryGJFZ7bunCl6ETjnorP/uZVw5n03OHF0shTxj6agYb1uzWYXOCsbmCZQc3Ar9
	 jfV+r0xr9mB+hJe0DUKfnjXRjCXO4I7c3HUyRmZfdZoZ5Kp+T+MerjZEnruAQCSRvX
	 9C8l3xQURTp9Fy1pA4aD1WRvpZNZANedO/pIgZ+dXa09HdviJdWrUYiofuYsXG/gzp
	 u6VleGKHOF4Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0320160645;
	Mon, 26 Oct 2026 09:24:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C6CC356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B4A380DEC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbLIIjbG8ys8 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:24:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D4DAE80DB2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793006684;
 b=CODfYyKEZtfuzXPc55pv/eLdZ/jxCY/e+kGSQ6apjIUUWgorsqzsJRr7VPUdmVRBQHHE
 tzJlEhFjlACUwAmBI2q+m3WXql8MdnBZrzGQX00Iu8MFNwTDWYMbhMqCs17tWdqkub7hz
 x/Uk0enj3MF4yJMGbkWfdiG5ZVZUwEO6WqtaQtwuj81l3Tpt3CbCzbWtVVmfvw28d5U1S
 wEu2EC8i4vI7cXcFceoNLZPS/zgGQODofdIOcg90SJ3lZUvkorgT8TuVYsQIW5WgVdwZA
 sJXGE9ZTGCnMKMPO203GxCiPIcb0RC9nGDPn7U0QHNUPHmhlPI8XXb1jUZY0TFOY1Zg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793006684;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=X+Uu8IaB/ICt6tz9Cw4z+kXRWobFmRw0zsD3cq8BOGA=;
 b=ArYcC+JO3lMdY6USsVXtvxFXMaJuyDGxg2mClWY8hNQYteEnK8hPurbNpP1kL7prRHBK
 7xNbdrrVxbAGcgSxXlmZYilKMVrLpaHweM4ILoKC1pHesOC2J2VskC4ozCGN5Yenk5uaK
 p6k4LmSUiKJJaj5PX1R6omMGwiNMdpe4IJD2T3k3akL3lpPAfI1mW9t930BntFROjrrux
 T2u3lsyKM/HKBTpivP7u5A071/ry7aU0fdoJCJ4AqKCWfNu7heNYviXWjGPGHIz8dRilX
 5zbnuJ3WL5p7IwfqF0SuU9qysOE7izPG3fNdvBWazpAvPhhIh4ioTjvY9n9AIW18kdA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=U4bpCNA9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=U4bpCNA9
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4DAE80DB2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:24:43 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cd61a2dfd7aso600331a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006683; x=1793611483;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+Uu8IaB/ICt6tz9Cw4z+kXRWobFmRw0zsD3cq8BOGA=;
 b=U4bpCNA944N4QJeH4h1ig4ZRegag9AFukOvRtopAec0fBc5kxCjZcrZygpAYL1SEFW
 GBpUU4L6JibUMdbHo5/i6JGRDn/968e0CAChG6LQ1VgLJffya7sPH2/LlHXYelMt0gNB
 Xyjx+MEHP8VioXP48ML6fO4lQ/JPK7P754ewTxWqVqGBcYSrNtY9FmB6usm8xXj+bj6w
 ptgD91ciSr33lEf4SgEbRlTtfdsuEcOWGBNgckmP6/Yyt8UoiKaioUJpdSRpXg/MEOGv
 0fL2pDtTS+MXPWLjiNrRxWUuH/yl9dYrSXE5yL8fgjmC7A4pIz8GP496LmCASOz1yr3e
 Bqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006683; x=1793611483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X+Uu8IaB/ICt6tz9Cw4z+kXRWobFmRw0zsD3cq8BOGA=;
 b=Z8K8f6UcxU+lOGsanBQ84qLprbE0GCwGhM2UmwyCzRE+Z6MoMv8H7TsEln+7qTcqds
 06df9QXE0s4Tf5CN2u5Wq8pToW4BBMcLxNIX/rKMacwX2OeJPpJrC2WWXfAW3ea0fsSf
 b46Iyd7+LY+1UifgvvlzfiUCjLXWmEArtNoJeF6dyszSgO8sgSPU2rWVEKAl30WI0Ht0
 +tYmGDFB/cQJtmq9PPqRWS+wpXppeHMYS5GU0y5pdfEW2WXYt5vPoh5o/6/TDqEopVEd
 8YC4i3b8H8q2OCTJC8g7ThhtOmV6FgHpkD9vR3hUKPn7wZzLZRbNMxhei6Lb+iGWtrdA
 Tdgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVM/8C2n/XvzDGdaDBhoSoKH3QCNZZ28VDjRO49ZEHyLgadC5wA5IKBPlr0wA2LHQrNqklRLQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJXTiOOfhsAXw7e4mkTUcVc0WlYeOhtG9R+IctK0shhZyNtNqXw
 l1j1q1Qt00PW8zzql5Aj6JrPrA6cvg/8Y62olHycFi5gbwL6mfcSm0eu
X-Gm-Gg: AYBFou0aJreCd+TudZyJ8uzgf4fat+IAqJkaIzbwJSZDJ07kIsluypd3/uu+q70937V
 diavuQQ8lfE3vrpEjySzWJgTtPfendUbTWUYmDq7VUIspZpEije/6TyBp0l01FP1gl2E5kA/yvd
 LOKYTVGJGAYsIwXV+emdjxtyo8QFlK4Wq3lNB13Q0cp3LFXizcK4RiQlU+RMv6lZ7dzkFdaXW4t
 c395FJ5fUhlXlvwLKBNWlXhdfPIYkaWbNyjlYg6J3fpzzFgREwx2ZohXUhw6oMwtTwt9WAAAywb
 1ndsKUCAVFQ6zD4BhyJloEO4miwj/39G5O90B0YYLBKl6hl0BSmeTazpRj0YO4fG2A3thBjovNq
 lVqmDx1oCa3iFRy0+CLISQtKuht9Y2QIGkoUrFHtV0QcUXJp0tq36AiKp+pCOpd40G5BPd7p/mH
 eGHrwO4r3ZfWAqJSS9B9n4nHmWtkT59PIcDOmmMsVP+KNG2EShwQCv480bJnkDVnSH3N5xmKDF2
 rKb/sxqmJSbnDw2ZIQFl6NfmuTJbIqqruhbCx1wxMY4otROKehAnmR6K7CWZG5Vf2MyGythaUOw
 7j69mF7r1injOub8GjaPGlPaEjnzRST6wdXrK3jEf1jn1Fbf6NTynONcqgUTocH6UepX3lJ9+7U
 JZNkTHxVS5sfmK4HiRxL0GCwiq518J0/6JEY=
X-Received: by 2002:a17:90a:e70c:b0:3ac:6e91:3f14 with SMTP id
 98e67ed59e1d1-3adea899102mr5379178a91.22.1793006682889; 
 Mon, 26 Oct 2026 02:24:42 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc2268fsm1437353a12.7.2026.10.26.02.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:24:42 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 2/2] configs: spacemit_k1: Enable onboard USB hub support
Date: Mon, 26 Oct 2026 17:24:32 +0800
Message-ID: <20261026092432.769146-3-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
References: <20261026092432.769146-1-alan.tseng.cs@gmail.com>
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

The Milk-V Jupiter and the Banana Pi BPI-F3 need the VL817 hub to be
powered and taken out of reset before their USB ports work.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 configs/spacemit_k1_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 8ee9baa13..8a9badfde 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -116,4 +116,5 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_SPL_LIB_RATIONAL=y
-- 
2.43.0

