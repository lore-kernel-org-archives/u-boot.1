Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD22CC5B572
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C107E4061D;
	Tue, 25 Aug 2026 04:25:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZzXP1fyLcf1s; Tue, 25 Aug 2026 04:25:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787631913;
	bh=9WgpHdJRdQK3IRrTzd/Q+VQ6N8VI4jkfl5z/Mlgz2EA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Il7Z5/zRNNzuJ0tHef3l6fnZuhyNB5vkum6LC+2015LWqpya5+apHGp9eDA0W5yyM
	 kkJG2N5VN6DteMEwYwskWFUv4qPknhOdE7+Brjttg3tLltDpkJCjv1eYUeDJj3I9T7
	 OZ9qvVwsr8LMfnxf8nWCW8GVoeXQhEtiF1jWvAvGKAIEpwBLXQytrUoiqvQW377yco
	 f5E9HvCk3xGCBF3/sZOWd/0TAnpl1waTDU6aiUshFFGYswlYUtBW/0wTfi6VowT3TM
	 SgQ7BX9wGzTet2QG7n6GVULylSO/lLvA+mwXt7dX2MbsjWohan8RMEZlB/OrSX0RVN
	 4gX0xeY1VLUpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E59C40604;
	Tue, 25 Aug 2026 04:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DDA4279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33C2080D09
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OmBwaW8We7uV for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:25:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fKF+BF1i
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C19880CC5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F1796013A;
 Tue, 25 Aug 2026 04:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C801F00A3A;
 Tue, 25 Aug 2026 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787631910;
 bh=9WgpHdJRdQK3IRrTzd/Q+VQ6N8VI4jkfl5z/Mlgz2EA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fKF+BF1iJ/mdO6kO/8as8MHIuGFlocHeqycYij5FF4b4HQu+suS42n2sKSXvPhctf
 kfacySNESRFBQLYjrexb9roLgNvSxubn+LsFFNcSI1a2w+mDooJErxmLDEEb5wW1Rn
 derK/V+lzYXtXW7xi/85etsqX8ofFoixa1YqNUg1yRhsg2yxKuX7oVg8TFeNFJKYRv
 kNW6tiqk7fpxi3CDLgbQPT1RwyLUQ0SaSRpdNup/oTAa2q15XUH+iPR/U3LMxMFYF0
 Fw+3AM3Ae5JiNOa4NOmeVof+S8uYDAP84gnWBujCYn9LZgi1hN0u9xRWgY229Frnfh
 HJNy1DQqSbvhw==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 25 Aug 2026 04:24:11 +0000
Subject: [PATCH 1/8] clk: spacemit: ccu_mix: fix inverted condition in
 ccu_mix_trigger_fc()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-01-k3-clock-reset-support-v1-1-c430253e759c@kernel.org>
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
In-Reply-To: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=847; i=dlan@kernel.org;
 h=from:subject:message-id; bh=6b0z52n/W0GMXn6vksZC3wPCqgn1ZBxSy4MBhqdVo28=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqjRkGdCAWNncikRKWoAMMoixxfZwWAQbjE669W
 WMXv2g6B8iJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCao0ZBhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1Adw/9HgcH0tm8ji6ekHtXpV93WqyRdPrNfO4onemVZyrwZ+1ARr9qkVWS5
 4TCtyhNG4tCRx0jew0yx+CcoC+OEsPuCJYJbeYvixh6mwUYbvPRsJbmw8kPlETSfMMqnSfO+ddm
 4zphg4wi7eQm1+TniQ2J8/7Fd7hzqbDvKxwjL36Cf6lcKVI0CFeM7OTTetmFzbB+VwzBf3THTxN
 b7bWNj+63mbyTat7rjWJ/yk5WULazFB19W+gS6MG3PDQn8MFv9CoW6wj9yHHH1gUA7Y9BwhVJNE
 y3wYxGjRYNsfm+3+m7AV2Jfz9iCei+L7jZXnhPQEh1vjC4FctPEVSmCY8msEl+7Y2nPRDX7Tluy
 AEpVF99QJwRQcrhOGU2JCMSH5+CkM2KBj0ZsHOq2vwkkSt8lm45c+fi4mQeS5WMElzZq97lemPp
 Jd4KXhFRF1nx+yCgCxTFUF48R5828VmOQUvTpG2RNZXBbjPQByOYV+MeLPU2Rxadx1BvlxvJYFR
 /kO1n6WHR38atXrZnfTeYLeWFsIwnaz5AOz/xxyVcAcvALsASYZQmhHVryrmZfjIVnDy7m0qpKY
 Icg0XSzPMUb+mACpLxDwlNMev5AfEYPbeu6sK/S5sPvSwfDbqnCcF2HqtHrFj10kKVIBisTzHdA
 PZtLefRzfLOtOpdSLFdw3VfaIEc64w=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Based on upstream commit:
  54e97360b44b ("clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()")

Fix inverted condition that skips frequency change trigger,
causing kernel panics during cpufreq scaling.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/clk_mix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/clk_mix.c b/drivers/clk/spacemit/clk_mix.c
index a1158512a92..45bf2c72375 100644
--- a/drivers/clk/spacemit/clk_mix.c
+++ b/drivers/clk/spacemit/clk_mix.c
@@ -78,7 +78,7 @@ static int ccu_mix_trigger_fc(struct clk *clk)
 	struct ccu_common *common = clk_to_ccu_common(clk);
 	unsigned int val;
 
-	if (common->reg_fc)
+	if (!common->reg_fc)
 		return 0;
 
 	ccu_update(common, fc, common->mask_fc, common->mask_fc);

-- 
2.55.0

