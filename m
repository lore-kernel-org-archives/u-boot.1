Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEB8C88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B14A40624;
	Sat, 12 Sep 2026 13:27:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vBpvGIfYugh6; Sat, 12 Sep 2026 13:27:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B51C6407E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219643;
	b=TytSPIZCg97pRAN8RdGUp4kSZ0nz66bcCoVt8uV2B+unTwC6hu+E5+q++iQiipmrLm4x
	 fSJnntuqcSYkrB1ni0OjK1OCpclx9cTbmA5dC2RdPwsbYdqcz9JBaJTcQrMbwYgT7fw9w
	 ZkiyHvh3sYoRI6KUKWzD4bJmrlSHnNhS/q0Vhg5Fr6R4SCqNF8IEjPk/U6oIp4WYGi7cK
	 JrE696haum1xIaU6P0WJXP9zswDEwL88BID3YULEb5Ld51n5w6uOLZr+j5VQ8YYFxCfnJ
	 SZVjYMt8SqjNqaKymZBTESkOzERiKuPiTRNJdmKEZaNuaeVbD8ScbSpdD2XhOPY84yQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IcD5347CNkCtztwmdh3Mm6N882+iK389wrmYySiWS8k=;
	b=ETaD8+rFLS1vTH6vBW9PniUqFGysr7xeMmraUXRiHPVte3T96A9xXrsQwWEa4TLlnC3y
	 Ot8OhxvQ0SfdnTOVZGPcZ9d9Dvd0hbH+4KJ+pj2J4B8zYAtwlBgSvynWF+xPWXRofE4c0
	 Vzat6R37dtnO3z22XCnw+lyZxs6fkDF9wzBi6TGAPeekJwcmaXRxK0ojh/ZtPQ3fw+JHt
	 nBxSeVQVADbhHMjiiw4Ky1RbuygglnHIvI6FcdtGqrPZiX+v2BqYEjf2oGtTsCsILCHBq
	 NQRv/c4cwwtvzxoFUwU/FeFW8ZDt1JAzelcfEWEGA1JLmWs8+VhzvwSrquWj4gtvt5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R9znfAYd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219643;
	bh=IcD5347CNkCtztwmdh3Mm6N882+iK389wrmYySiWS8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z1i9WIqF6LiZwXcYcSk62P5AHmfohZsWXfajJzimtm8DdNKxL9leol0ar2Jbwk1y5
	 3BE7PoQRdD79t9beDWwwYjOpyIRf87WJxucWdoQyXlrvzgSVPmUVevD4Tzb2YNaSIr
	 Fn4S7K5WunRTxKASFmkykAttRpOYnLBTlTfdKHD1Udd75OAYZm4RF2FKv/MHWkMkDv
	 GykEMAn22WSpzJhjITfpHDSpny93EhpVpzeMotmouRBXTDCAsL3A2LJpX/N+YQAULk
	 IGAL7GIVMztyUA64n1A8AJoYDr8hLrK0//huM2kzrOuKi7r0/GjpadTq2VRN9zHrZ0
	 YasiqXvOuTBzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B51C6407E2;
	Sat, 12 Sep 2026 13:27:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26A5A32F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D7F24079D
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qsT_h66y7Pt for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 07:27:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3597140799
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789198065;
 b=VkVllszHfCj1xVVJdL18nmM7u8amtGdKKkexVJHDBu8u8hvQEwccYqQMt2gADU6lmWp/
 Jp2sj1k+rhtmzW9b0+H6qBlQMj+qwVAyqopRtmBhXjhIJWaok09I9JkpZqFCMuuu26yDu
 QRVgM0RL5air/cOmpRO2j1N3bwXhvpjq++UPMXI8EPwfZP50gnydtJXafb7uAJKhH7lLs
 VKeKX/ryvbi525u0ZxSVC/EzkrIPEUvMkjeIsmXxCHbnNQWLSiynrk/ZJ9qOx8nfl4hrX
 RnUOEupcxeDl5y4PCX6CQz8ceDWAxO53lhqmTTANjaJbGvQL1MOSWWoQs2A1xHyyosg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789198065;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=IcD5347CNkCtztwmdh3Mm6N882+iK389wrmYySiWS8k=;
 b=CCR5oFYL5XJMEwQ1foFxxN5ivt2PHk+gXTliGvr0N217fRjqAlfFppi8ABrHI0ObLgC4
 CxnJ7J+pQNcZ5d6cyoZHbM5C7k36N8KTcr54iTVycsFG0JXwstdsUw7kunt42w4Zhf7Do
 SWoHkd3a+jnJ84U7L7s84aMkavz1dvdfjlKGP4IZNuoFSIP81hPYGkdWMJO8zQR3VnzwA
 MgE9mcWnUMf+4w0XXR4IOQ4ClTLl4pbGdYIjtwBNRd6URLxarPPSr6xjfKUFL0O0UrhjN
 0CA+yOEaJZ6keXcqZ/PeKdb6Rt0Dnp61SIgr3ICP7AZhtTzobNJKVSt1CPjwL+h3qkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=R9znfAYd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=R9znfAYd
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3597140799
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:27:44 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d91ede8035so3632625ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 00:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789198064; x=1789802864;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IcD5347CNkCtztwmdh3Mm6N882+iK389wrmYySiWS8k=;
 b=R9znfAYdCSwZfpSsQe5/C9E2Uh3CAqhRfdZZAGwzDwxdBN+Zm0zrXIQExra1dFmZbD
 37oMm3Gn2UPal+Ieogmfn5Dg34bM8cUHFn+WdSmMXOihvU6F95HTulogUXIJx/PWXHZo
 x2yH8b5YlZdDpwBODpJwWtpHRvfcNmfoEUdbe88C5hgKg6hznetxDp2qaYrBGx1zttdJ
 NU+IlRgpnTKcrBOtfhim+4MBuQUYuXR4Rv7+EnfZbdsH10U9qflZ/yuuqE2oSwCm1Ukv
 vKdyYLdikVh3YabOp9vorMvuA5yMjmTJzr/RQo/pgjGekgbWgcNwCVRT8LXrup1frfST
 tlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789198064; x=1789802864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IcD5347CNkCtztwmdh3Mm6N882+iK389wrmYySiWS8k=;
 b=mgO5xZQQAjNeEDLjxnbsWrAyoy8Bt63qxD0UIQ+8q2DpdSFtAJjg8uzuq/CsC+dIhz
 fjJgMfmyIt7wrTzYZ9GxF+AP3HA1DTrciVZbMQhJxsIaQmvpVSlb3337cblUHUXxeJAJ
 SMlcGmdWl7Av2XtB/CgUz2ZKo9Y5yNBSN0KtEzHpgBt81nJ3fThjOeJAOcJMidHfxpFP
 WiSPQvfmQRS2VPWbEgWHSEOxXrR7pyXeAMRXjwiaNyCyjUbg37AOeD2PJXGE1NWp05OP
 15a0MqeLq9ziRLWQWrWHxjtcfiPhacfbykJIjL4IzWVtFIai+p8S/lkgdTsaUkckN6jP
 iDVw==
X-Gm-Message-State: AFuF++loOgY1itYrlY7noTlRJ7nw0d3q/O2uZdbNGpCo1JDxxjZFMOb3
 znkotfCw4+/gb281rdvttdjn4Dj1XSQh9AR7ioJMqsykLt1ImM98zJIcB/2D5Q==
X-Gm-Gg: AYBFou0F+D48DAuPhY93XbJYr7/DQZL82s+Bgr7hrJwylIxnKzr5HymATwLXkSs7Pbm
 hXLCLC0X5cF8vDglTbpsGzPPawge9dhyikrDoqiO1M9QwZYWaVAuahu4ew3H1JLvardq3ifpP4f
 XGI4ohJa3s2dacEyghPj6qoaLwNneRYamTalqpJKAr2SG2yw7J9VPHdfBhGQqs0MoVkHYqFoWid
 QHcQouWiUFFimKc+qwEJuszAXnDPW3TKl2/BPXAPhNIdtKVf9J351kBlHiwgUVsS0hu7X9oLdzm
 HB+yHoXW4PKpup+ZcRnS8Nf2iAXjWXRKIyl30pHpyEiHwom/bFlzDSwT79owUGLyY98TNa8D9iL
 lAaQQDmz+F2QkISmCyoxEy//Fpst6154P++9tES6arRLf9uPKJGxZzVBMtTh47jr4P9f6E7+SHm
 yxt75OhKyP88kje/mCZ1yN1hu3RSgCDLf9Lcqfj4rXTrHM53PNA1J8QmMBIMvsatxtlgcdq/yc
X-Received: by 2002:a17:902:d486:b0:2d6:f988:398f with SMTP id
 d9443c01a7336-2dd4bd46a29mr27952985ad.12.1789198063942; 
 Sat, 12 Sep 2026 00:27:43 -0700 (PDT)
Received: from thefoxflat ([2404:c0:701d:4e35:a09e:399b:32ec:61ae])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfd719dsm21469235ad.59.2026.09.12.00.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:27:43 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH v2 3/4] clk: qcom: Add an option to poll for GDSCR
 GDSC_POWER_ON bit
Date: Sat, 12 Sep 2026 07:23:07 +0000
Message-ID: <20260912072619.244101-5-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912072619.244101-2-imkyufie@gmail.com>
References: <20260912072619.244101-2-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:27:13 +0000
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

Some SoCs such as MSM8917 poll its GDSC power domains by reading GDSCR
directly, as opposed to GDSCR + CFG_GDSCR_OFFSET.
Add a poll_gdscr flag to struct qcom_power_map to facilitate those SoCs.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---

(no changes since v1)

 drivers/clk/qcom/clock-qcom.c | 24 +++++++++++++-----------
 drivers/clk/qcom/clock-qcom.h |  1 +
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 6b46d9db7..754ff4ff4 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -505,9 +505,9 @@ U_BOOT_DRIVER(qcom_reset) = {
 static int qcom_power_set(struct power_domain *pwr, bool on)
 {
 	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
-	void __iomem *base = dev_get_priv(pwr->dev);
+	void __iomem *base = dev_get_priv(pwr->dev), *poll_addr;
 	const struct qcom_power_map *map;
-	u32 value;
+	u32 value, mask;
 	int ret;
 
 	if (pwr->id >= data->num_power_domains)
@@ -527,19 +527,21 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
 
 	writel(value, base + map->reg);
 
-	if (on)
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+	poll_addr = base + map->reg;
+	if (map->poll_gdscr) {
+		/* Some SOCs such as MSM8917 poll at GDSCR */
+		ret = readl_poll_timeout(poll_addr,
 					 value,
-					 (value & GDSC_POWER_UP_COMPLETE) ||
-					 (value & GDSC_PWR_ON_MASK),
+					 (!!(value & GDSC_PWR_ON_MASK) == on),
 					 GDSC_STATUS_POLL_TIMEOUT_US);
-
-	else
-		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+	} else {
+		mask = on ? GDSC_POWER_UP_COMPLETE : GDSC_POWER_DOWN_COMPLETE;
+		ret = readl_poll_timeout(poll_addr + CFG_GDSCR_OFFSET,
 					 value,
-					 (value & GDSC_POWER_DOWN_COMPLETE) ||
-					 !(value & GDSC_PWR_ON_MASK),
+					 (value & mask) ||
+					 !!(value & GDSC_PWR_ON_MASK) == on,
 					 GDSC_STATUS_POLL_TIMEOUT_US);
+	}
 
 	if (ret == -ETIMEDOUT)
 		printf("WARNING: GDSC %lu is stuck during power on/off\n",
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 3a4550d85..0b514cc1f 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -76,6 +76,7 @@ struct qcom_reset_map {
 
 struct qcom_power_map {
 	unsigned int reg;
+	bool poll_gdscr;
 };
 
 struct clk;
-- 
2.55.0

