Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C491CA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 12:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 17767608CD;
	Sat, 10 Oct 2026 12:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LftToocK4A59; Sat, 10 Oct 2026 12:21:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3664260670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634883;
	b=CcwX5oEz5wm0uG5Vr4fbHtUYfqQmAb8LMAxE9Aer/kHGu6lLrgwNxbMUlMSSgDGzKv4b
	 OkdLiQ2AKhSswLUBejRSCySKkQIdwGvDiOZgk64SDenWoXenUSfsPklddk+F4/UC+dcPW
	 4TK95dmKoxdhhbEIlWjW/8fKwso9zeK1/IvlI5JV5mXvtW0p2Wo0clP9cDos3eem6EJDX
	 egfi9DeF4UCNwmZsGPPSN0/te9J8KdMBCoG7XYsJmuP1bNk52s17YsfRDJfY/NztQrfH+
	 zGgP8MXLpNvZWpYSZWPw5sbt45Ug4HaAfjBCepjlXbCs8WQcTiRJOEqVyef+kd5UOgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:DKIM-Signature:X-DKIM2-Info:
	 DKIM2-Signature:X-DKIM2-Info:Message-Instance:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fWQc/ThJPaitBWPHU5h4CIn3xEfHvtjRZYnK1mAPYzY=;
	b=g2/59QpEn9W9Qg909XGBE3FFnczQ36jrup+kCS0AUgYoB6wK9ncnAxGsYShlRL0q4OwP
	 NJcy8m+pZYr1VX7ulqmsw1jbtjfmGKqq2ihj54ytzxNCFRtayLKdMk5o8deZDVKNv1d0j
	 4Y572ufbBanZeGPSXZNu13E+Qx120rtSTxOyarlCOxBVO2JqTbCOHFjvtvcT0RmkuX/Bm
	 Hc6lb6+mLBj/4s/47ZRpspC8vrgujpFMmU3QiMcHBmL3LTSIV4EouRTLLsZ/2zIW8Hphc
	 1l1rEsjtFDqwNuxdm3bImhpZIGX94ivkTYP6MBxU6G5OOwHd6G+qCaGjw7+Ire2LjVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791634883;
	bh=fWQc/ThJPaitBWPHU5h4CIn3xEfHvtjRZYnK1mAPYzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQcTpN74qJnVi/t9Pq11XK+RLTHDrf/PpLtHUGYjb16LVw+Z8lNqPaQ4RpRe8CmrB
	 BCccVUXZziQYYE6jjNhECtqPohvY2YJjHdaJMpV3ykQYDrC2otEJVgzPB6c3LFgCUY
	 1qEjd56GVYthoHQEkUV8MRSjYNcsfAIphcgQVIop9JAUstdp2mLA+11D8WQk2w9AZZ
	 acBfx66poWSFC4MokjBPj/lS3fJxlrSgdyRmLGo1kbPmsHQqvs0re4hI0tdjQcyxZs
	 zhqE6GRuroVecRk93jsHG1QZ3IeBGmYDrBTEvbJa7hV1skimJ5av3Qd4uNJPt7yoyA
	 0K73HC4s542dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3664260670;
	Sat, 10 Oct 2026 12:21:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B6A722B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 419C840061
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DSds948NDYCy for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 12:21:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37B3D40004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634877;
 b=CBIn7DXkxmIKs+PviVUJVLrPYRjBTKUUJIccOy62nbHi97kzZb6u0xTDGv0I2yE2MvQb
 mmzrJSnhy0AIXn1eJ/JwMe7CDcOYD3wzF6qFJn4lHNoHbom1oBccz8GKyewdZpfbibVcQ
 AiIfaWpLcHSMYJ8l2js46wPImtkd2DJ0JNQtWhLu862Tgo8MAD8vAwxPKqMHrx9HenBUx
 TUvxSU9XSyTO8opxiv4kCLZT/67Z/oKXiYikRARA8byU7QD8Xqpz/oD0N4I7G6NEmTDAr
 wgxfUVyArJpt/kGjOxZ4d82oP9qrZqSLpg9evqfoCEt4E/mi7uGt3i4Nf46EPHtCq3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634877;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:
 DKIM-Signature:X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:
 Message-Instance:X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:
 X-ME-Proxy:Feedback-ID:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
 bh=fWQc/ThJPaitBWPHU5h4CIn3xEfHvtjRZYnK1mAPYzY=;
 b=hxi4pcIyltiV/W7/gv0mV0T8U+N1rRsRJte2PYuTVP9DAKu53qxcp8hCKnMR6K/4YLQb
 3s6ziNfETxbg7HwZz5hjcwIyu2Y2j967e1dWlDO6mspgWnme5Mt33SbV3tNki0VRHnon4
 LJXsRdrCAXEp527VWjBCNL1OjbQRHIOg7ZKlhbtkUIQ0ZZKNOC9zN2BtuGUkggQa3teml
 Hwj4waT6wu58hPux26GzoFvhW1ABqa6I/xQS6r6rbfMjxtlkGLws1IBZySYhLKlL7uSEw
 X61GYPo/BkeZPS2OR9lu02rDz0QSJQvBE5SwnbGJ/jQVEqgKhSJsEyRhO7Cp102QKxg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=jannau.net;
 dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256
 header.s=fm3 header.b=BnVcptCY; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=FuagkL9v; 
 arc=none smtp.remote-ip=202.12.124.154
X-Greylist: delayed 422 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 10 Oct 2026 12:21:15 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net
 header.a=rsa-sha256 header.s=fm3 header.b=BnVcptCY; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm2 header.b=FuagkL9v
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.154;
 helo=fhigh-b3-smtp.messagingengine.com; envelope-from=j@jannau.net;
 receiver=<UNKNOWN> 
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37B3D40004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 12:21:14 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 4529F7A00A3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:14:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 10 Oct 2026 08:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1791634461;
 x=1791720861; bh=fWQc/ThJPaitBWPHU5h4CIn3xEfHvtjRZYnK1mAPYzY=; b=
 BnVcptCYBoJHzw6L7mLO+BGkmq+apv5vrqhGxRdvgHxVhbXeGxhIR4rp10VERVEd
 Ty9z+5rPWl/AC1xLvqzCt0+USyO+1KoAUbdZnl56KXIuEAb4j/kAlpZT8HVD/EIi
 YJbpovLYFAli0uSrEiLWgr9jULiGmXYM8X7WgyUUyTzmd7wG5Tnl7nJyvfYfHtFa
 3JKFuMwp5786eh5AF78r+phrlY08wlxQplg20SO6XWUJPECKl9oBpMx0mY2i40Ri
 r3ol+DJYmahVa9jdg/Ksub9dxmm9kgqnyY+nQAf9WX7VKXSBMkEGC1+yz/3f9SRJ
 EBjHlfqqWm5Rw7D1LSRZ0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791634461; x=
 1791720861; bh=fWQc/ThJPaitBWPHU5h4CIn3xEfHvtjRZYnK1mAPYzY=; b=F
 uagkL9v+ZeCgsivwKJ24PRwHfT+Re89qd62J+ZBtcQsOmgP5VIwnTYHcApqUVuOn
 1iRaDaZjdhjUlsPo91dINafo6HEMQhXzCRz7J8ZgDIQKZMkWzY6JcayvmrrkljPa
 0Z/9yPmXxrrT4WzkVnFoj1mwZguUma1IO/sXIeH513x44DoDSzKBov1vwYK07eEN
 F2SGXwWXmJEXuOlQecQbXEH4lyfBdqWDkq8wzaSQYcUCJAuLlWCGkyfXP5mqs3qo
 Acbc5OfPreAdD/4t1Re1pjWGyxLkaKIF5hKuEkoRK6qBqJO0L3JS+7CVwhKQzgXu
 IlYubVJfrdDLavoYjszqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791634461; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+;
 s=fm3:rsa-sha256:kG0mG3bDxSEQq/Qp58bMS0DbHtgsJHLMWV66M8FOYdSr8tp
 wRm2+tY8KQP5EiKiim1/LUNWfUei6MHE9+/H/ZN1QXOqBvoMO9Xu83qhMOgEE71y
 GNW9sPYDI9S+olRaYwrNZILCRDZ6gqx1GO2M3drqVhr/iWpeO3vrNbTUUHojHX0k
 kqsiZjgqQ6iAs+LnmRq+L687Zmv3Uh4dfsO8tboffpCe8fxUQBxu+TcW+0ZI6elS
 jCHry3Owp/nH0nrNESN4ClPPmb93fqTfEeL4W51MdbEEIA3NtQFeVT+pBEsMawce
 FDc1klYs9e1alKb5AFxnD4m3b8h6yAPTWHhF5pQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:8U21TohnkAfpiw0uezkG/H2nS9j82uvYB1AyQajccQM=:5Nc5WJQmlbx7bJH+ves53FiV/ys9K1ivWkdije5L/qU=;
X-ME-Sender: <xms:HSzKaqLeUdA2w0_zuocjWg91FBz_Mt4wS-aXq6nekMAkxwUlDZGCFw>
 <xme:HSzKasJ0Im94lEprHJ5sYTrROSdwKkoLZouZB-bR9iwn5sv4oHqCUARXlHjGnrwKQ
 rNCEFTQgnmNr2MdT_R85dEQz-MqfiWe2MlyXfSXxUuHJmA9UcwrzfRLzw>
X-ME-Received: <xmr:HSzKahWRqE2RykYIHKHHZk5C47EQeW77gab4XvTuWWS6ZYJhwVMGM376Lv90a3VME0d0s90VL_tRmML8I4wQVB4CMtTQXOpEP8VGAw>
X-ME-Proxy-Cause: dmFkZTFqpbXI6Y3+CoqfhNPZi+DG5Qw8jkDyXnjv8Zl/hcPn3S78Zk6eoCtECVWjb8Y2mP
 PIW0cluxF5Sc6nA8ZXBbZHx8G7ibOOE8hxiBeWn6zFftUvVf/TcCNPG9UjdVl7tkgXlBTM
 LIHFh5/qAXUQUGnZjrmiiLHT6Mhx9NZvwa2FwbUQYPStfkEM5s3u9Gz4n73nwucxxl+Vrk
 0OjGShLCaE1QK0a/CZkhOjweGMDOC/NfzcH4E1RuSEKg9vyf3c3eEfXLFETICuYPbtU3Nm
 g7JoKw89k6iDnZDjcXV42ma1zlizScl/jHbpW4kCJPOna53gfhZsymwqsPRvp8WnWwvdDR
 XWhkumaZI/mI8Z6ZiTb5zyirRuiOnDy9YhoG1Y43/u8c9PSOyBk9HyURTM7BPSpkW2RuFL
 UBM7s78ibxETiVgK0+o4/g4rHohAFBRSFA3PNJOkEZNOM0uIIOszs7e/qsIrj6oKrJ8okA
 tW/BWPINliT5sv2B2zOJVcDpB7bohgXqLLrKn8pkixCqmwsWZHSSJGbsqyLrCU9Nmwljph
 ONRswWKmXc1R5dyQzkEIuKS/q8qxg1l6LLlakRKZCDC+Ok6y65Fxzwps3S6ZvOShFQLKpE
 z6dxpzfqzqIwtzLBicUGPhewug0E2WKj8p+t+ie+7uAgYIFWcOkrCm0vHkww
X-ME-Proxy: <xmx:HSzKatmhMlnS8mGGTv73JT7piOZtk7Hi8Gac3hgxU1Nvaan3U2eSTQ>
 <xmx:HSzKavkvx1zRtkZ6-jCV7YPPTcEkPJyPXEXCAVNx66apxgTQ8Z2O6g>
 <xmx:HSzKalYDKdDw7j6Bj2T99Z9pO6pKAv14KrixkqTFOaVLmF7_ACK6kw>
 <xmx:HSzKapSE26iIp_LGJVEKGu6o8pfw7Omwj3YUQrj0Eze_z3LLOJaXIg>
 <xmx:HSzKaiqZsyWK3QVER7uJ7oLFUtt3ZfOD-BBusZQSVd0f-AgjXk7dLUdG>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Oct 2026 08:14:20 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 10 Oct 2026 14:13:59 +0200
Subject: [PATCH 3/3] arm: apple: Add Apple M3 Ultra (t6032) support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-apple-t603x-support-v1-3-ca529f301a62@jannau.net>
References: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
In-Reply-To: <20261010-apple-t603x-support-v1-0-ca529f301a62@jannau.net>
To: u-boot@lists.u-boot-project.org
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, asahi@lists.linux.dev, 
 Anshul Dalal <anshuld@ti.com>, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5142; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=5Nc5WJQmlbx7bJH+ves53FiV/ys9K1ivWkdije5L/qU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxTOgLLLhy5EP/6VVHdo+UlqpxOuxdZPIs+5FWw/Q77j
 87tiz5HdpSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZiIyCeG/+Wt3UL/ZWtb+D92
 d8jk3PzEZL5iyqZPq06kJkz0c8/Zsofhv3Ou7d8fWav+LLae5cBj2zfTwH+Rqci10DNvbWY5qr4
 u5gEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Apple's M3 Ultra (t6032) SoC consists like its M1 and M2 predecessors of
two M3 Max dies with an "UltraFusion" interconnect. Since it is only
used in the Mac Studio the mem map does not need to duplicate all
entries. Two of the USB4 / Thunderbolt complexes on the second die are
unused. Only PCIe host controller on the first die is used directly. The
PCIe IO on the second die is used internally to connect the NVMe
controller with the NAND flash.
Most of u-boot's existing drivers are compatible with the hardware and
M3 Ultra device trees will carry "apple,t8103-*" as fallback compatible
strings. Only apple-atcphy-reset will use a new compatible as M3 Ultra
has ThunderBolt 5 / USB4v2 USB-C ports.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm/mach-apple/board.c | 127 ++++++++++++++++++++++++++++++++++++++++++++
 doc/board/apple/m1.rst      |   1 +
 2 files changed, 128 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index bd0c69fcb512..d8ad925a00e6 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -843,6 +843,131 @@ static struct mm_region t6030_mem_map[] = {
 	}
 };
 
+/* Apple M3 Ultra */
+
+static struct mm_region t6032_mem_map[] = {
+	{
+		/* I/O */
+		.virt = 0x280000000,
+		.phys = 0x280000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x300000000,
+		.phys = 0x300000000,
+		.size = 3UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x580000000,
+		.phys = 0x580000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5a0000000,
+		.phys = 0x5a0000000,
+		.size = SZ_512M,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE */
+		.virt = 0x5c0000000,
+		.phys = 0x5c0000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC0 */
+		.virt = 0x700000000,
+		.phys = 0x700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC1 */
+		.virt = 0xb00000000,
+		.phys = 0xb00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC2 */
+		.virt = 0xf00000000,
+		.phys = 0xf00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC3 */
+		.virt = 0x1300000000,
+		.phys = 0x1300000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2280000000,
+		.phys = 0x2280000000,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O */
+		.virt = 0x2300000000,
+		.phys = 0x2300000000,
+		.size = 3UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC4 */
+		.virt = 0x2700000000,
+		.phys = 0x2700000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* I/O ATC5 */
+		.virt = 0x2b00000000,
+		.phys = 0x2b00000000,
+		.size = SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* RAM */
+		.virt = 0x10000000000,
+		.phys = 0x10000000000,
+		.size = 16UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Framebuffer */
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
 struct mm_region *mem_map;
 
 int board_init(void)
@@ -896,6 +1021,8 @@ void build_mem_map(void)
 		 of_machine_is_compatible("apple,t6031") ||
 		 of_machine_is_compatible("apple,t6034"))
 		mem_map = t6030_mem_map;
+	else if (of_machine_is_compatible("apple,t6032"))
+		mem_map = t6032_mem_map;
 	else
 		panic("Unsupported SoC\n");
 
diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
index 002f4926ed5e..f1be55996b95 100644
--- a/doc/board/apple/m1.rst
+++ b/doc/board/apple/m1.rst
@@ -18,6 +18,7 @@ the following SoCs work:
  - Apple M2 Ultra SoC (t6022)
  - Apple M3 Pro SoC (t6030)
  - Apple M3 Max SoC (t6031 and t6034)
+ - Apple M3 Ultra SoC (t6032)
 
 On these SoCs the following hardware is supported:
 

-- 
2.55.0

