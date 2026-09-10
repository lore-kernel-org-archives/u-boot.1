Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590AEC79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84C3480F11;
	Thu, 10 Sep 2026 06:57:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id itpSEuk0_aD7; Thu, 10 Sep 2026 06:57:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C46CE80F04
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023454;
	b=WzLeXbXhlXp+j+0w0CCl8XAQGFhxoW5kcUMQg14Df6yzR8odWDcM0Us72g+DcqsHtMHY
	 DzCwr0NvyNC0k47u7Bxg1jxv6+xesRC3nFDjQ4a9W1Um7QRvs6GduWIa1Jjqh0Pm1ZqE3
	 FE0S6LDgT33+Sp5ET0i7QxTMNv090RKSwnjDTMTyxeNoDqGmwMcuhQ1Z7hvv8/PDIcgHt
	 cMf66QJG6FBnuDC0/c2zVuCsUVpRvL/a4ZqwUew8NxI8urlOvhxcbDB1C8XFXM6wJdD5C
	 LYs/KM8viFpzKomvdMSLBx1Ihh1q7T78/DBJ/qSg2FQdVbo78c2D0cg2n/VIWGFhbrw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TUMm0qMEqpsFjk6PE2mrAx+j0SjOgxSYmYvSkTQjExg=;
	b=cdIK9f99lOwQKoen6hJt3jIMNzndIVrJd7YHmetCOw2V9nzl0XJ6ozuijo1c/EUQbHcF
	 PvmTkpSCvNYJqOIo0Sw5DUMVhVbV9tOjuABM8qqZVaVSZwtk4Oa4Ak4CSb4IIda4fpt3m
	 Ol2seKVR1XIqgDJkiMhaK3JioScTH1AIX6rKPweJ1F9fJX6JL8WUIN6O63slMm6Q12lEf
	 ZBIzlTcAZXjQJot/y+YwkC2Gjc+YYNgImB1MI+D3dmF6HjjPgU9GlZ7zzW2AymgmctLgc
	 /P48RfL5NbDMPJ+oP71FY/8Wryr9IYBIH912ppSwQ6TjVe1AXRReTxNgQQZgchZ8bpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b="rY/Qws/3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023454;
	bh=TUMm0qMEqpsFjk6PE2mrAx+j0SjOgxSYmYvSkTQjExg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hBN5U2zC4gswWivo731Gaxi9e0n6lsvVb2oG0o16hPBS+mnlDh6rozVL0vFgEVj5F
	 csHY7UZ2Lo4Ia2zOaWqjP8UbvrNEm7OlgFM1wHuKVd08+bytCG5mwl0+wsiyFVk0wy
	 FfYm16zDZwCSlzDQd6Dn4Yxte/AWdvz1fz7Fpt0DOazjP4DvOvY/5sCfvrNAn2mfLX
	 fXsuXrLwXdjTvtzOBEdPxmLx0G5in1KMZeDUokBDVUEzCg4zhBcKAOBtnmZux9UGVS
	 XAcUgDKzplzreLTTa4DniV976fgiecrYByZSzDpq05/6qrxomHi0+6as5ob+YTwsrO
	 lKxSJ2VBM+5fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C46CE80F04;
	Thu, 10 Sep 2026 06:57:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 239D3362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09B9780F03
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbtByb9zQtSN for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E463F80F00
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023450;
 b=kqnfRA6VLAQJv0xbj3B5fcwk/Wqjl+Wf/IrdDJBnzRiZPEMNbRrgudmw1Rs6kjMZvf3U
 yR1Ft/8esSfWLMz6/RJhXjQCkntz8Xvwc9eA/L3wqLpNhfCHUiWOebzCwVhvBGszTObjm
 UubgmMSMfskmzF7TWrMN63tQdERps1AYQdrk0Ogxhj0PtGXZjR/K75BFMma5dWi9ezUSI
 ZgLf5ifn0i/lYVGMpHGAUFuiIA8KwgEHLh+QT2DyeOvtcmQRDpDtNlLuOKQLXKZKFIx7p
 c2j0Zje6ReXbgItLTLZDEaTfR7aJabrqWfJ1LgEsMfLJ63Bclo1VUmOK6r8Ta5XOGBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023450;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=TUMm0qMEqpsFjk6PE2mrAx+j0SjOgxSYmYvSkTQjExg=;
 b=SWrFOS9K3JqAuZcANvNU1uHQRoVbtUx62cht+CLibPciU48znW7RUAxzzMKp3qSQV+lg
 VvTIskyB4j53vAfRyq292PSotIQ4CizRoYcYr825MhesZuC2sCdrBgn1QCqBTjyCYq994
 l1As+UxJQYYZlywJXzOZ9wd8Lsr29QQ30ndbbVleOy+WUME1weuMxPHgpKRsulLp9NO7A
 03t+SjIAGaAM7xlHGh+UJBPe0S3TvD2JCUTdQ9UMVHaeDW6zh0hDNAH21uD3SFFGIPN9H
 2fbtzllQoowLh5JLEOxumTHxKDC06Dkc2kazN3tr8l835w6cOtLLX1uqLvbNhvFZYBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b="rY/Qws/3"; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 62 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:28 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=rY/Qws/3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-294854-202609100656230550b3dceb000207f4-mfnogk@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E463F80F00
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:28 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202609100656230550b3dceb000207f4
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TUMm0qMEqpsFjk6PE2mrAx+j0SjOgxSYmYvSkTQjExg=;
 b=rY/Qws/3SsQHFW/Yb3006QANa39xiA6y9JiYdQ1sVS00Hn0pYcB3UTzpdnr7BetsPT2VoH
 MZRhuSMqRn4O1W9cw5qY85OGCFMHOT5Tw48a0BK9WpjY0smmqzSRxhU7wz+JYR12/Es8YnF4
 jeHXkCpjNWUTRXbdjefZr9YmIYjFETKVIrKYgR2STmdarbwmnQKrFswK9Xyr7E1Z79vgbvL9
 wQCXfncOcAYvSJ91nR1Vt0XV6I9G7PziIq5ReEvpDUjxogKhn81zG3kJaOP+kRoPJaEgQGJS
 Vo9aqp460jf+R7CnWbseRvuOkA+no/a4HnDXdHJ6fDR+uEhG2EsWQVdw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4 4/6] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
Date: Thu, 10 Sep 2026 08:56:19 +0200
Message-ID: <1677680cae50c28857064aa75987277e5d9beee1.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1789023381.git.jan.kiszka@siemens.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This is a transitional error that is resolved once an RPMB becomes
available. Keep it as debug output only.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tee/optee/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 7c481ceb804..a47c76811cd 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -112,7 +112,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
 
 	ret = tee_invoke_func(dev, &arg, 1, &param);
 	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
-		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
+			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		else
+			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
 		return -EINVAL;
 	}
 
-- 
2.47.3

