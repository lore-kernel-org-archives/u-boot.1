Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C74C9833E
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AA248100C;
	Sun, 27 Sep 2026 15:06:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZGca4cUDdYW; Sun, 27 Sep 2026 15:06:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3DC1981098
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521562;
	b=Mi97zcE1YlmJNPfuVb7vrZKR4Pwggql5nc5Nw04u4UfzLE7NTM9x3MX5T/0IMDj9zCZX
	 t+vIhklWcQ4T7jJl5jwWZ5BlLyOSbjbdWCQm+yBr8yKjKzWb7yWdqILykSJfUd6Ym2KjH
	 xBAo8ROmQP152kxl2eAPrYOO/rX5skHw4TvykzizkjJhfnth5AO4qBjhYImGVwuW5b6v5
	 8wGwqJ3gXp5zCjHALL3EJUvYSoV2auRWpH3TQ/zbgUv2B+1HP08FMEAtcdqFSiesRqP97
	 JEqaC8/lUWQxfWfoHDUSGC8BDXM4YiXQeHynih7BR3/Fer1jaZgAhSdep3yAXe1cAIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521562;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
	b=WffSiHYThguL5/w11jlUqAX94mr74neEnSGA4wrscdQApUqZ+AcaH6dm8a/N3EXHnpGb
	 6d+h9QQ7ppiuFhgU6QqVjMdBcMqg7hL3e3fHXePdvcAaAkpftgRYJclUvZlb0/NgFS4uG
	 SjGoqiZfCsLS8lDFd5Ew8IHWL7Ky/K2JmwKEYPiTdxbFklUriW5CN3gLQxjx+kmHAUW31
	 fbZ/Qv8S7xlxr+Wau3K8BFQnhPwt8LiFAvxX9LIvZJabTib56WPrpXM9DdJERs4IliLLZ
	 wH2nZdN73xKRgN3owmE7hy6O1KczyIVjERRYCQreFP8cK+4uaqBCNR/Nh0mAjOBsKXw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521562;
	bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r4FDlzVdKLR9hbh0Ofc2AMAI8WmoZNp308yCDel+lL2be6NEwM8ZiwektmE06eHYL
	 bcRROOl7heqSOVD/b7KW2Aj04JxSzVlfBurN5HDI2he6Hqkeh/qVJhXzeQcOqkLd32
	 jGScuJJrKu+VR8g8Jq8UjYuH7p0pCb+r1CL/2gad/AHyc0hqhKPWgY9KgeRloPJWSr
	 hKooPT/Z0Xx5BCA5LrJ0FAbHHq572c5TqKLcaqmjBL8d5hyxE7hPjdpK7uDxqgyWDI
	 uDDckggrwWCB4pQYuVD3uy8pMbUM5jKAbvhklh2nFj8yLpbNrGVflmNS+9WFING02z
	 T3MXfPk8v4fYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DC1981098;
	Sun, 27 Sep 2026 15:06:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 137BA422
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED95C40099
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QgL0IGJ6AbyZ for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 13:40:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 340C640068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790516405;
 b=rqrRMSsm6dbkEYzlyDT/GmNRwLWdvqOSglBsf3rdEYpaUSWQShr2Lzv0M5sOAbvvHr6R
 HPWN1rqKOw8+7wEPrHpoOiAjaiwVlePXqvdVemGGGuP/ApDNiQ/BVxPInroDQs8UvHIYF
 wRZW9EA7qtaeIpVFrorzCqBtpJG2Su+UauIy8t1FFs+0EONgm8AM/g+MweFNF8p7tTy+n
 upxJn1E/NZ7r383R1yavQPzvvARwZuAsh4qu8oN+ExBZAX0cNxj4LrdzVnyVEFGt0x7jg
 fyLrluUJ2CjQHZYGnQNiSsrR9iPQIpxtpVswmHrXfpR0fKlmruY7ha4+kXJ5tUHHk8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790516405;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
 b=aPV64tDK9J5e5XPcgJStr55dKGQzHDkeWi9WcqehHyu7FaymQcRll7NncSrVImd7QkwM
 HLM4hb9C7D/2fv/6MMBjO+eB3kB10R7Cn7pjRWuyqTbyR7y/qyWBTVQbnVtm/pHj150Wq
 3evl7kuKVIUTlgrNJEG6z8zCKVXS6a92w9pyYwKK8nrzwk/aOYodXlFcpf2gXLrsZ4hHG
 O55P+yI3wjQvCSwXk/nmX85c1gu56IuP6sXQKbnAiswIuT4FT2Cf4mm+fTbjOADLkcNp5
 sAOA05R6UrEnJZh6yvS8IAuWhOUDF8FpbYtHKsuEsRvrKaF/Qhim1sJh6/wKNoT+b/g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=ZobqWl46; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=ZobqWl46
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 340C640068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790516238; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gbmu5SIT8pNkLsmrfdDtg7KtWTUXHkF5cW6K5awSGNAGrKO/nUXCnzHoPElbPrMI6vZsAS2k0GV+vQtfUIkMWhxxl6gZlF6xoYf6dC80PNcIq/2gzCIRiONuf2J13Nl8elVAdN35JHIlpU1BM3jS9FisNMuJhg48xuF0ypOeEPI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790516238;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=; 
 b=i/8fTxEChpuy9nlZgtherpVwAQkTvDOWoALhlk/I1UYGvBS5uU6Aiedau7tFdT4S0PTPX/PwGB3I1ZFWsM/tv96WSb1fU0+fVylY0H4Xak1Vgc0B7Vr+dc4HNwP/8jAdcaLCBvJAdSnyeq/MGJXgRcVjE8uEhwqhJtftkWWtcH4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790516238; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=WoMYcr/cWLhLj4yK79gEPCTS0V/fcpQbbLl5NU05CCo=;
 b=ZobqWl46ZYsNZGCWHuV5MA75x6XrU37By+hHFIU/wJqU9Fl/Cj0ZmotPt5JJ7tdD
 eji3LEMAC9ixTF3mnqsSzdQVSQjyuCrWj0rt/Tn59vodZ7HKg7KoqjoB2+NrMqsnRca
 5XDkRQtXlgBVHl4WUZIso4rhlQ81tEUJj1hXeJDk=
Received: by smtp.zohomail.com with SMTPS id 1790516236917308.81426996111793; 
 Sun, 27 Sep 2026 06:37:16 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 19:46:00 +0800
Subject: [PATCH v5 10/10] clk: sophgo: cv1800b: Drop legacy compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-10-f95d9173b7e3@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112275396f77485bb5b41315f88890000675285dc4099a73f3edd7abb01f55e69180dbdcfc62f103af4:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 15:05:55 +0000
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

Milk-V Duo, Milk-V Duo 256M and LicheeRV Nano now use upstream
devicetrees with the SoC-specific "sophgo,cv1800b-clk" and
"sophgo,sg2002-clk" compatible strings.

Remove the now-unused legacy "sophgo,cv1800-clk" compatible string.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/clk/sophgo/clk-cv1800b.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
index 57051c1ec0a..2270a076ce2 100644
--- a/drivers/clk/sophgo/clk-cv1800b.c
+++ b/drivers/clk/sophgo/clk-cv1800b.c
@@ -743,7 +743,6 @@ const struct clk_ops cv1800b_clk_ops = {
 };
 
 static const struct udevice_id cv1800b_clk_of_match[] = {
-	{ .compatible = "sophgo,cv1800-clk" },
 	{ .compatible = "sophgo,cv1800b-clk" },
 	{ .compatible = "sophgo,sg2002-clk" },
 	{ },

-- 
2.55.0
