Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F28CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80CE88115C;
	Thu, 15 Oct 2026 14:47:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQy6t9oGjozv; Thu, 15 Oct 2026 14:47:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 931C38113D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792075629;
	b=G1m0UvXVonm2mcqSiSGFjr3CJ0cyWjayVMbJMN7LK9PU4c/XBTql82wvbkH+7GwXx6Ch
	 I4ASdMUJtOjFCcCGftm7o26I4rWnIA79kNHqD2z4/O80kEPwcYsDfK6+vjeNruun47i4W
	 j+/24Iw2jWjaWDcyLHwFfviHsWuSdkcQaedRPJfnGYhVbCAZXpnoutPdiNropIqluE60r
	 U+a4rOeFPVKuv/MK4Ap2gq5xYlYRILystFXkFSiDYsaqHnGjWGmZREFBtl+96+eDIyfhF
	 2SQ3TI/wKqE9m9VKI9UZ1giC0ZcKCUei9Ekw1YhUEokZPcAf7eCWNG7x1+8Y6KlzVYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792075629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZzxZKBNNogIviDC8gox4+sV9Kpmsp2my9tIkZ1KY8RQ=;
	b=nCI6Amw05tQGLVqa9WZ9yovBJfVoC3irXKz5Vipm4OkNTb9FqqzyEeolD+KgLvm/xqCM
	 rzTAYjrB316Ey3VTA1BKXdmow1FeuNrjpwQLqen0lyOwtblONcP1IXGhzLCAT7JZklV3D
	 gZZWMUgcc7KjVg+aOCNJ3Fbfie6xoHNKAoJyyCe7xEmXQxnxJtcjulbf6SZE+GDuA7QT5
	 LgPdb9981GbR7s2PA7t9a93tGvmWF3fPeHxnLTM4O0CKJKPLqtj8yzAg51tmCFGP+2R7L
	 sWnAIxRt5JxETTc18QwG8FqKLYdTEhhptaPmGvjmDhig6aQWVHLPzSFPqwgvSTinVRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=rJF9lfto;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=QnUXhWIo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792075629;
	bh=ZzxZKBNNogIviDC8gox4+sV9Kpmsp2my9tIkZ1KY8RQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fB0IF4GDDpYcQiW3hi4eIZ9QNDz08LrHGECDLNjJCTIyzr4/Wvm/l4D6i5XfsAiqY
	 IeAQrFQPqN404HRwRELBJ1OlzFHEpORwTBcFhoQELZXKEfO9p0HVo6KpBQ7pkw+o9W
	 gc//nrrur9Ol3HrokEgfHmSKJqlUwJVTG9a2ox/iBRZ6+QppEzVq+3KHsJ2ZSUbdHf
	 onAUpbScnMY5L7CofiSFm3YEI6/BL7A9fzsdl6n5n341FvwgAw1BmmEJ4cfqq7aPsa
	 9LVtOLR2UEERWdZ/O0uVgOkPslcMbz6V9nqgRsxkBKpalrFCAw+vkxkkeea7n8Mj4L
	 bw14CB3fFJmxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 931C38113D;
	Thu, 15 Oct 2026 14:47:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76D54E4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E132811E3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hAXyxZO_rZXR for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B0FC5810BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792071204;
 b=emxQZ8uXXPazSdA13CO77r21UHA6P+Lf3WEy1bmtmcl+3FMl2Tw2a6ppoMzyySQg7bn3
 EeD2jsuqOu2fTXuf6fnF/4gdj3uE3WM4DQHmpp+qmfpKE47PW8KxRJKjtuSLC0NcxT/oK
 2jMtX9KsqhrpB2UwdFbLNGhDjkWsjngKyxzAD/vN4vLB0q4ebl6frS8nxKor/pnxT4gkE
 Tu8JzQvvkSdBtNtTyteJUzOXoP6SBogz/9Z6u/UGsO5zUK2pYp0SNfXgeofExZda8WCEP
 ZYrV1/np+OYJldYa/PreXGKGXDa6+bBUWrWvwkA526puJa/GIzl5fD4wOqd2WJhHzww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792071204;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:
 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:
 Message-Id:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ZzxZKBNNogIviDC8gox4+sV9Kpmsp2my9tIkZ1KY8RQ=;
 b=CZnX7QgBXQxM3PEOKK/lpi1GCuIk3Mk7TNrvVanR3QwpWpvjU0qD/NIBLuNs8XeFhS7M
 uOnnyhIqDbiY7WiobA8bBXwYFwY3WP4/hbbo/uhlbf8+WJI2h567QK/G0KAG3vKWhs35K
 /LeNrmQc6ZagO8gSvi22aoEM4kVkkKTnAo8eMRG8Amt0EvdpYVlvzWtDjDUB2chf2iVVA
 Mt1xNtArww0qkAx/D3UnOLLTEH5xL0qEc0h9oPl5KK+KiIzEow1P28SgfLpxzNUB+wPDD
 9q28i0aJOl6YQlQkcCAZZEQEGaiv2dcQDwiauOf5yHSMh6U8JFd44o6i3RubWJZzr/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=synopsys.com;
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=pfptdkimsnps header.b=rJF9lfto; 
 dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=mail header.b=QnUXhWIo; 
 arc=none smtp.remote-ip=148.163.158.9
X-Greylist: delayed 4957 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 13:33:23 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=synopsys.com
 header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps
 header.b=rJF9lfto; dkim=pass (2048-bit key,
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=mail header.b=QnUXhWIo
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.9;
 helo=mx0b-00230701.pphosted.com;
 envelope-from=dineshkumar.parameswaran@synopsys.com; receiver=<UNKNOWN> 
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0FC5810BA
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:33:22 +0000 (UTC)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9lkB93934154; Thu, 15 Oct 2026 05:10:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfptdkimsnps; bh=ZzxZKBNNogIviDC8gox
 4+sV9Kpmsp2my9tIkZ1KY8RQ=; b=rJF9lfto8kEq1U0qvjOajVjIXorDc4yi8cM
 LclHWP08KhDtwNdqSy46HAmlcwVkoPNobzCv/vCPEAhOzoCRODZby3k49r35tIH+
 h+x8KgYPKzQWkkcWXOOlz1d5L2bg4lIGBH9TvlXlE1CdMz0cL/wCXS0jaP3KA+cn
 xemNabIn4oeVx1YR+/qzE/2OjBEWw/43dmLmXdjwjsKorFa9Immnd9xbz1brhXvf
 9nQFJ6kjJYJgQLrUvYBN3yM2ckR5ihuoHiXE6eJVxB6y03lucafvoBn10YyPBrvX
 FejSO/RxH3zIbEr5UaGF5hBRf93njw+f7v37A74qMDVzN4HE0Jw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4haeut5d78-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1792066242; bh=yzM4ila61NMk35iG9ciIMxlI9YW/NsiN+60/rNsY4Fw=;
 h=From:To:Cc:Subject:Date:From;
 b=QnUXhWIoXevOjaTN7EK1FqD3HAU6w8e8jG+jjowLlbCQWI0SLiYczqOzbSWh4wR9j
 8W0fBRdMtEBO7LgCbmUuh3q2OYrqUOU+noUXBQ74AXX4Fnq5Y7vGeL+uGnhOwM+/Su
 qH1TtuI/DQcGO2/4pSKlcG5TwWRqTCrBeaQrQ//OSO/g/SSIFV4gbRYd6aRfB/Q9uU
 lO/dDQnrbctRq062XnkYPpLfzt1zwI78B2x8jc3zxf1MdVJQ6L0CcVy66N22nLWZX1
 BhPXUXnOTB1aTmfe8EvADEomXPVioxeOnV68iIpPIVeuq6Cxy3N8NXZGlzQQrs5W6w
 8zARyJebmuT4A==
Received: from mailhost.synopsys.com (eudc-mailhost2.synopsys.com
 [10.213.161.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 713DA401CD;
 Thu, 15 Oct 2026 12:10:42 +0000 (UTC)
Received: from Ubuntu.internal.synopsys.com
 (snps-xodffzmzvk.internal.synopsys.com [10.155.156.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mailhost.synopsys.com (Postfix) with ESMTPSA id 77F37C1428;
 Thu, 15 Oct 2026 12:10:40 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Dineshkumar Parameswaran <Dineshkumar.Parameswaran@synopsys.com>
To: u-boot@lists.u-boot-project.org
Cc: dinesh.maniyam@altera.com,
 Dineshkumar Parameswaran <Dineshkumar.Parameswaran@synopsys.com>
Subject: [PATCH] drivers: i3c: master: Fix PID becomes zero after device init.
Date: Thu, 15 Oct 2026 17:40:30 +0530
Message-Id: <20261015121030.5504-1-parame@synopsys.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZCOPlwCkAo8NN9HpAES354O5RiRptmeF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX7YI+eKI3xetc
 n54C0Fv6BkuHesNPrd+GwHg1pPfjzHBv1JY3uBsR3puBcrF727QWcEz5FDyRie1qUYLwARLexMs
 TrvlGbUXT/KCMYPupQaoVQ2hIRt1dhE=
X-Proofpoint-GUID: ZCOPlwCkAo8NN9HpAES354O5RiRptmeF
X-Authority-Analysis: v=2.4 cv=FvaQbGrq c=1 sm=1 tr=0 ts=6ad0c2c3 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=jIQo8A4GAAAA:8 a=eHR4zWfR7vMI2KmxvhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0OCBTYWx0ZWRfX0jWkNaksAXuZ
 rkrN4boNLYScR2WnBEYiaPq1ukDXXDjTAE9qcVp3Hc0HOag3MxsF4qF9J8qQ1yrjUilZjmCWQHq
 UbFWvIGBHtPPvrSViNpQEn1+I9xdXh5e2xtsEqVXuKnroFb6zIpRf0GTg2H04bKHrSSp1oz2wj2
 uRz4DFvwIuNF38eblXwxS2yQfMJEbxUKg6ZI7bWalYb47kHHtwDgfe2Wg+mjDKu1M8YMHy8Eqee
 +ln4/AA/iQvsoSOD3Hk83t/y0WgbDZM1LwIRxyRohXLQ+SiPZsYcfyAqJrfmeC4QVTh5MjLOic2
 6ESS/SC2UbIl7sYI2lf84UHFFwf7uHrWSTYUz9TfHQBuk0UiUkSr9FC+7cii6qYDomlvfJBXtgS
 Ipf9Yyp2/h3tZqOdaO/Lq3kMKsAhshLLBSviNWqVXx0Ho8KFgYFcBPXxl3rOres/3c4YnojeYHu
 xJdnt8aE/81TExdU29Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610080000 definitions=main-2610150048
X-Mailman-Approved-At: Thu, 15 Oct 2026 14:47:08 +0000
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

During ENTDAA, a Transfer Error Status Interrupt may be raised while
the Response Status Interrupt is being handled. It remains latched in
the status register while waiting for GETPID, so clear the Transfer
Error Status Interrupt after ENTDAA. Also, `polltimeout()` returns
a negative value on timeout; update the comparison to account for this.

Signed-off-by: Dineshkumar Parameswaran <parame@synopsys.com>
---
 drivers/i3c/master/dw-i3c-master.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 25933adf010..4cdd908067e 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -539,7 +539,7 @@ static int dw_i3c_ccc_set(struct dw_i3c_master *master,
 
 	dw_i3c_master_enqueue_xfer(master, xfer);
 
-	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+	if (dw_i3c_status_poll_timeout(master) < POLL_SUCCESS)
 		dw_i3c_master_dequeue_xfer(master, xfer);
 	else
 		dw_i3c_master_irq_handler(master);
@@ -584,7 +584,7 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
 
 	dw_i3c_master_enqueue_xfer(master, xfer);
 
-	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+	if (dw_i3c_status_poll_timeout(master) < POLL_SUCCESS)
 		dw_i3c_master_dequeue_xfer(master, xfer);
 	else
 		dw_i3c_master_irq_handler(master);
@@ -661,7 +661,7 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 
 	dw_i3c_master_enqueue_xfer(master, xfer);
 
-	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+	if (dw_i3c_status_poll_timeout(master) < POLL_SUCCESS)
 		dw_i3c_master_dequeue_xfer(master, xfer);
 	else
 		dw_i3c_master_irq_handler(master);
@@ -669,6 +669,17 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	newdevs = GENMASK(master->maxdevs - cmd->rx_len - 1, 0);
 	newdevs &= ~olddevs;
 
+	/* Sometimes, when the Response Queue is being processed,
+	 * the interrupt status register may get updated with a transfer error
+	 * (INTR_TRANSFER_ERR_STAT) and this error stays set. Because of
+	 * this, when the system keeps checking for the next interrupt, it
+	 * detects that an interrupt is already present—even before the
+	 * intended, actual interrupt occurs. So, clearing the Transfer
+	 * error here.
+	 */
+	if (readl(master->regs + INTR_STATUS) & INTR_TRANSFER_ERR_STAT)
+		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
+
 	for (pos = 0; pos < master->maxdevs; pos++) {
 		if (newdevs & BIT(pos)) {
 			if (i3c_master_add_i3c_dev_locked(m, master->addrs[pos]))
@@ -743,7 +754,7 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 
 	dw_i3c_master_enqueue_xfer(master, xfer);
 
-	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+	if (dw_i3c_status_poll_timeout(master) < POLL_SUCCESS)
 		dw_i3c_master_dequeue_xfer(master, xfer);
 	else
 		dw_i3c_master_irq_handler(master);
@@ -888,7 +899,7 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 
 	dw_i3c_master_enqueue_xfer(master, xfer);
 
-	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+	if (dw_i3c_status_poll_timeout(master) < POLL_SUCCESS)
 		dw_i3c_master_dequeue_xfer(master, xfer);
 	else
 		dw_i3c_master_irq_handler(master);
-- 
2.34.1

