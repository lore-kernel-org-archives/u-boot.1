Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE69606A332
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kEqVfdMQ;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=otYsMoM7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0A44607FB;
	Mon, 16 Nov 2026 15:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifUa-W7yjqwr; Mon, 16 Nov 2026 15:13:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 45C5160794
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794841999;
	b=h6JqSWZNiLDrI0AlC48BRbBhqn86lArj5Vhh33LzLWzFZUFzKyhrVbNEuaxXe2erYAL5
	 iVco2xuW8ltn7p39A5r6zncEU3zHEU3D6wGfQMZl0OExIgyrWP03s4GYituBFbPD/txcp
	 dJtvlBcsZDNCX2TVGzoTNpcGa0L6J2IfdpnNmVSSyIAe6fO7sTN5EboZZ7pBHjks6gx7g
	 eDKEE7a6C+F8ySSdd5+Ydwl/drBX6pDSp1uzVUGRwtlNiUu8p0HiDTnwbv9mNpccPlajf
	 1cp4hveBu3p4GdpSHe7u4en8womrT2RWnrmQXuMJHVkVJcqG8rLKqLuFZjTkPo+W47A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794841999;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nIAOcloieH6Ua1B5JRipNLsE/ac98+4SnjNh8SUAacM=;
	b=i7FHnYV/ckD3eXwxqy+3VsZT3WJFJIfW0TOJAq3lk/DaKjpmp4ize75LORSgnmvPzvZy
	 vLC0CajIFgDhG/hVID/Vg3ZsrOVRRy4wyj6171DO2NWaR+o6/LU0SdAZII2rYkZdtszXO
	 SmUWtitJ0o+GLXfWS/FJZbBTjPg0IXPtPUCOlsCUV/pBad1o/9SgKkQo9BI9U9ukyUhJ6
	 0je25BIgcRnv2Uo5o7g0eQym8bqBxQSO9HB95Fe7bjiIRm75vG21er5AC5s5wbD46Z9vT
	 Up/GNRttDCTSeb5khG3niJsHUDjrW7J2jkkCdSfHkVRtl53ZmTUUle6dWLY0uSna8qQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794841999;
	bh=nIAOcloieH6Ua1B5JRipNLsE/ac98+4SnjNh8SUAacM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kEqVfdMQC6d3e8HF7iRNj6qgnh8c7+dVz7WvqDAFNn8YMy9RMjD7SXiNy4miAG0/b
	 3XJqHfce0VKv4JGJfYPv+8Ip8XB3Yyd81OToYtVuf5vfpl7eYKiMvAqn5R+Nl5EQJv
	 BSjrYm3YH+Uo4Ofss9dth+KYweOSpcPg9BGXYSJUVb0QmWUmiZeN7OcY20Bvl4IODr
	 EiY350VVEgmnrpCEU65qH1r7xJr7s0MxbPvXu+ssRrWk78XhjItXxJ03dVkSsIo1IC
	 Kdcg+sRinhJCgGKuifnmIvyl9Iydse7Za8n6X5y8SP/RzZlo+ce7+irrzwEpHGNK8x
	 NVVZ5JAbUu5Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45C5160794;
	Mon, 16 Nov 2026 15:13:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AFEFB176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95F6A8091C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:13:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Olw1MA_EGZGF for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 15:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2BCC8089D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=otYsMoM7
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2BCC8089D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 15:13:16 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so22915615e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794841994; x=1795446794;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nIAOcloieH6Ua1B5JRipNLsE/ac98+4SnjNh8SUAacM=;
 b=otYsMoM7WFvF/uHNe42LH/SgVGLS87fN1+VhkHoZ+DOfgXiRMMtjL3GP6yaB7p3d3r
 MDH6kXvGqGItPrCDsX3BDxnYJWZQgNp/dt/4E9HMfoJuBHjbnq4GzQu2dDrXzuI3yaEx
 03bYziLE9zqdfKEuZOCmy8POy+bj/P2XRfkx9+Bae02LsNvSNFuKl/VttyNfPIXbxbiu
 gtlxy8A0vp3dXZELFHBiJdueMYlmfkjdvASvpILA4j9JNIJeLPuIOdZjp+p145Jvwnq+
 nBXQ10X3/URcWTAiT1Ji9999qTv8eM7twZK/XJYgoOUg4LdqkxdP2HweKqEUZgStX3Sc
 cIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841994; x=1795446794;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nIAOcloieH6Ua1B5JRipNLsE/ac98+4SnjNh8SUAacM=;
 b=agJWNzO6lyyJsipwyyJNMXMr83/aU+FY4lgM9/+CSuM4wopDF6lX0dm/fd8yCErjZm
 aBZGN3zSjgoGFgT2lCyR3couYSvQ8dRTgjqtWy5vx/Od1wxTTGPAcA8mOqVaKxJH/vDW
 ouNvaid7fpgyD0RK4NiUP/aM62AvNOgqx3vtIHcWckxgqUpk3dKTUGZ0mvApa772Bx0I
 c/D5DmwojEd4VqYKdeRD1rarKuUhAseDGrlZcYQMZZ+Kd6J7NfH09qxK3Ps6mG8SER3S
 5ywnb53Yadnx1wOcKcz2kWq/Qnl3KIJKhFS0+XhO9oa9eM7HrxBxNbFwG5on0rpU7zPw
 qd2Q==
X-Gm-Message-State: APuU4Z+n+95SN0ixuiBp5uoMzA9EYRktXN3jHwvBPCqWr44boITmyZjY
 hw7mCyv2iz8YoV0tvBK1vS6kiyqmbSwk5YXlnVLuZJkebm1O+FVTB8qHMxdBiD5gpQ0=
X-Gm-Gg: AYBFou0411up54NafLNMK/RI3QOyatSaYaC6fFOBLfkvHE3xyVj0HWuBXmY96KHBL+y
 4MXKvf0c56ff7TQXTyCx+BtkWvGMCQ4h/swfIVKgQfsa7MHiQbjRSsBXwXbMKrhYHAbRAyKoU+w
 BtxZh7xIiDlNRW0aOXzd1LZUpfLWmOGX8fhPt7cYiL4rBlZc/qj054uiayYOw3VY9xEvD2xYAGn
 qHN2G//jW8z++rrrpKmrgCppe5OnZbldW8F8/rqGt89Q2gc0AmNKDr6CPModdFN7n6gpsyNjgay
 oWuWnEi5FZlIp5TTPTx37xdVOqVLkksfszqgr6WYbU7rt68U/H9oNshtz/wXQLYVfE5YLvFPV18
 kfg5PWuBqJ9Y5mzx6rDqIAhI6iy7QVo7Vh7JN/rXlNH/aLqwWqsP7xi2tm3fvE9ispuvFsl7gds
 uY7C+rgzxfN9aAYrh2wFInVZKja6HM99wzO+RR5jWjtcuLNpVwMgOXDOYA3I4KHAIxkDC773noj
 21otWRDbR0S3RR+iPeVmKAMdkSnbzbuXdq6G035Wn0kFLguAHlkgJjObfCMyHUgNDuTgB8dQd/D
 ZtHwVRPaWQ+SJAHWl4z4SN+W3d6qWNntQftBpWvzaPN5b0YgGW8lh+588c6XNU8+/MVhPw==
X-Received: by 2002:a05:600c:34d6:b0:4a8:f2ad:a9e5 with SMTP id
 5b1f17b1804b1-4bb559f609cmr213618955e9.3.1794841994461; 
 Mon, 16 Nov 2026 07:13:14 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:ee3:3401:d23b:e87d:8bff:70bb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm23275617f8f.5.2026.11.16.07.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:13:13 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 16 Nov 2026 15:13:08 +0000
Subject: [PATCH v2] video: rockchip: Set return code
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-rk_video-v2-1-9d78708245a5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIMd+2oC/yXM7QpAQBCF4VvR/LZlx1fciiTWYCi0y6a0927x8
 6n3nBsMaSYDZXCDJsuGt9UDwwDU1K4jCe69ASPMpJSZ0EtjuadNJHGaE+Y4REUCPt81DXx9V1X
 925zdTOp49+DcA3/8AvBsAAAA
X-Change-ID: 20261116-rk_video-4357e272f094
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In rk_edp_start_aux_transaction the check for "AUX CH command reply
received" returns ret as the error code but it has not been assigned a
value so this could lead to the calling code silently ignoring the
error. Instead add the code to pass on any error returned from the
function call.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
[V2 updates]
- Return exit code from function instead of hard coding -EIO for any
  error. This is to match the pattern of calls above.
---
 drivers/video/rockchip/rk_edp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index 0ba68dbce3d..4d9dbd1b0e7 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -214,7 +214,8 @@ static int rk_edp_start_aux_transaction(struct rk3288_edp *regs)
 	}
 
 	/* Is AUX CH command reply received? */
-	if (rk_edp_is_aux_reply(regs)) {
+	ret = rk_edp_is_aux_reply(regs);
+	if (ret) {
 		debug("AUX CH command reply failed!\n");
 		return ret;
 	}

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-rk_video-4357e272f094

Best regards,
--  
Andrew Goodbody <andrew.goodbody@linaro.org>

