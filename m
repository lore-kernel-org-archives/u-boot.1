Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90D9CCF2C4
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78EC3409AD;
	Fri, 16 Oct 2026 21:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wjp_RMyyVMW5; Fri, 16 Oct 2026 21:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C3554409B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792185345;
	b=D6wuAHicCegZRT5gkAlDHd5Lt+mJaeYQ5HOwVJ6CcXSKK7CFYsoccSYtgf8kMpJTdm6X
	 otQ9Krjv/sfHvUFIcX8YihKgK/161owYBvZjF0dcUgk8UCApypUk3kEy/uu1yzuguiwok
	 kETwdsCBfVfLijLWZQcvragJLZ1hJpPazV3LGOz9y27IRRgtjhZ6sL8lJdqq9LyZ8NgeS
	 eV49bbjd0kAho2jzJ6SRuhBrwfxO9i2NUP6hwuw2AVW9A1ywFj3KBvjL+L2sg7cq4RMbL
	 yC7JNBtHrRMMwbSfUI0xZG+7h62QXq+bkHif3C0ilKOiWJG7Opr1+L1GlO1DrKrcmyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792185345;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-ICL-RepId:X-ICL-Out-Info:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Authority-Info-Out:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-JNJ:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/+edpcXbccPK4813H1z7nS//fGXCs7v0YkpLaojIBow=;
	b=QsYaZCvdnaA5RM+2FRAnjvepAWEuglpX42fhA5KKAjxGh55SLBiv1mIpNFP0fUczGwHJ
	 sfWAmcyCF9HwIpRHvU86jST1o263HQHX5d+h7/wbXqGriDAlkzACgxIBRMAdBzpm9utpp
	 5Llfq1G+9evo/yKqvOfuxQX5+pRt9xkvBilauHT4g6KwyTaDJHnzRT9p1oZUUrX+SYPgJ
	 SofuMtdbBNT9cTbHdYT15mGPHLqmG+Gk9nBIf9epyL5Ih+g0zI5MUuMsLvAM6TQhErmJv
	 O5mL7BlSlVB/CwDqtCbJKVdHTCr6rW4EKxa7N8LD+2iSCpXFjsFohAT7VAk74lrPt9Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792185345;
	bh=/+edpcXbccPK4813H1z7nS//fGXCs7v0YkpLaojIBow=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jg7kqur+PcAI1kruskXwX/kApu+DdwguKsdup7Nl3wrTIvG6lz8hvf84IH+Y8wCGv
	 xvyRWDK0D3Vv3YiMgr1qJSTWcFr59mOw2FIKxDZuiP7HcFqSDUJNohkMyufbmN8dR2
	 b5KOyPK7nqbSBoIyyl6pC3mm4+YqKYNDtEFsap71p7ARHmDTTLmF+UjhMeCEIiwOGc
	 XdbG10y6uIgtzeG54ArtSP7qPhkTomuQyR1uz33+jP/6mI3PFL2r70AQfIK3Byy/CD
	 TuByD7ivwIe6hTFLmZE3LD4IGcd35bmbDUEInHcW8f+uLmEUoapav9y7afna2AXVv6
	 E0z2IkNv8L4Fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3554409B2;
	Fri, 16 Oct 2026 21:15:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AEC5D79D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9263B608FA
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:15:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lj0xKi7QQ8NG for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DAD45608E7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:b747:3003:201::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792185343;
 b=ICWO4WKK1hXoZBX/KXZeZZ7WpvA/hgT+B5RSevmNoQhMnhu2I5zObxUlLpmo2eOl5Ayy
 HoszeQ/UjWpvYeTZV4ZAyoGc1l7vFmuRGSu4A5zpK/KFPVVaiDbEw+VwzJPoGNjDyx6W0
 kWaKFegOhuNWNr5h2U1kFYjNUNdqFCsHrBXkQFmWn6oqQM/6p68K0ae6crR+a6mxnItR4
 sSJ5JUyB52jHaiGDaa9+fGWUNIFsUWnrQa5cwJ53DybllNaAp48/i0GfaKCqk14Gzy0RF
 jinOqb0XUpWhjGQxSRFMaK3unwqUi5uka0za/GTplCbNOie6gDynyyzKbzuLpNoTswA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792185343;
 h=X-Greylist:Received-SPF:Received:X-ICL-RepId:X-ICL-Out-Info:
 Dkim-Signature:mail-alias-created-date:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Authority-Info-Out:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-JNJ;
 bh=/+edpcXbccPK4813H1z7nS//fGXCs7v0YkpLaojIBow=;
 b=oIrYrmmPhu5FFYaF4IvVV2fjKR7WK3U0yLh54k5atiDwaO2RTEOUymDLLU/rN4DHz2b3
 Me/85qGXSIgGxvRTElSbi0kSHXYyjSh+Ux8hIg2gorLiOsJ1P75UPnpewaVxyoUQcPuNe
 /TnM8kUXtvW0INPQ4f4fxvHXo/I2Kgozs+E8SFFfp5cgA4KFUd/0vK89vtAAMbXwBMKxg
 hBgYOrRx18O7BuZGzvOUkYoS8C/6bbXDVd49XESoaWt6jEfYE5SQCQd+jelU6AwUREFDu
 ODkUVVyVSafPMu6Hc1tvPRtDvetfu2ImDS16st6CoNxta+yRqGiTLa8Naeov3G5MvPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=dxdmail.cc;
 dkim=pass header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256
 header.s=sig1 header.b=VDFJU+X7; 
 arc=none smtp.remote-ip="2a01:b747:3003:201::2b"
X-Greylist: delayed 1200 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 16 Oct 2026 21:15:42 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=dxdmail.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dxdmail.cc header.i=@dxdmail.cc header.a=rsa-sha256
 header.s=sig1 header.b=VDFJU+X7
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3003:201::2b; helo=outbound.pv.icloud.com;
 envelope-from=nacht@dxdmail.cc; receiver=<UNKNOWN> 
Received: from outbound.pv.icloud.com (pv-2002d-snip6-3.eps.apple.com
 [IPv6:2a01:b747:3003:201::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAD45608E7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:15:42 +0000 (UTC)
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPS id
 2B2FB1800121; Fri, 16 Oct 2026 20:40:01 +0000 (UTC)
X-ICL-RepId: 01a14671-6d50-7e77-9ffe-9c69a5a697a0
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQFBHV8DXhxCC1YCWgZLVxQEFlIOXx9yFEEcXgxeBxwTWlhVCQoPShRUGVoBGQhRUEsbDloXA1ccVkVcGEMJXQVXHB0dQUVbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BTE1YdWBFfQ1QIEh1QHA5RBVsARghIAlsFWwFJC08dWwRdAF0IVV0MVANGMF0AVwBWAl5eWhsNTUMSQhUEG0YeQwRfL10XXgxeBQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxdmail.cc; s=sig1;
 t=1792183203; x=1823719203; bh=/+edpcXbccPK4813H1z7nS//fGXCs7v0YkpLaojIBow=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VDFJU+X7sefoYPaboeX8UkgyTInj0yNNatXdhOFM6p7RBvC5w7VGc/Ix+WjwMqMv31dLIHvSc4bEx/T9bChcc+Y7OXpGCpSZYo4bSbDh0qSkcAj0ct7DOVL19fAJc30ZEueXxuwZl2DG4Efu0BEXWj/9YJ3CPemjy0giVKhfpAkBWqqQ+wc3JsB0THdNPJhwsOtQQ2kz2fOIewQrRrsl/zIadG55+ZzmrQXzAs66GCAeYxw2WbEbtuXN9G6odFPjoTWTTRWQyo5U9b9DMiJBqTgjIHBnGHJAbezfc67HFJEzzXGiLyS+iGWa6AIoVQqPhbySMcB5dT1a8n2WmpsI9Q==
mail-alias-created-date: 1790174225171
Received: from fedora.tail053708.ts.net (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPSA id
 AFA5C18000FF; Fri, 16 Oct 2026 20:39:58 +0000 (UTC)
From: Nizat Mikayilli <nacht@dxdmail.cc>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Loic Poulain <loic.poulain@linaro.org>, Tom Rini <trini@konsulko.com>,
 Nizat Mikayilli <nacht@dxdmail.cc>
Subject: [PATCH v2] usb: gadget: acm: do not requeue failed RX requests
Date: Fri, 16 Oct 2026 22:39:27 +0200
Message-ID: <20261016203927.6362-1-nacht@dxdmail.cc>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=et7SD4pX c=1 sm=1 tr=0 ts=6ad28ba1
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=TcA7qK3IVxbl8t8k5AMA:9
X-Proofpoint-GUID: aPsJCAPo_GlUhmWGDB66X6yAQeHsZUpA
X-Proofpoint-ORIG-GUID: aPsJCAPo_GlUhmWGDB66X6yAQeHsZUpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MiBTYWx0ZWRfX8SNcUbWKA6ST
 SGcFr+a6xnalnooAiKYTlc1Yy2pLoqGLS7r/VltnWBIpZm1T2Jxc4+7PLlyML+ulfH+UpGZLrU/
 32MglqjbeTtf1SzSXNdxU6Fu8qaS7NAKkimFkJM530+tbOAbBo+IHdZqTI/msgKSw/v4f+BaLlH
 602oX/RDVnKdxHQSR9aA7wGTP6xKCNUDSvD/bVh0WwU+ThsB93O6OGc3G9eyw7P8xJhcxeWRkBo
 mSvU4T7X/34rwIaCJ9Uhx0WOFpe3Z7PxbY0M/Fd3CAPvPALg5cg83wCuub8BfAitHIKOs/Ux5Va
 i+eadXkkImJmPhBE/gJ1eCTXrGpDvlu0gq8lbIbJ5JWJQpRO4Mr/xz875EttUc=
X-JNJ: AAAAAAABCp9hlEnKdaVBac5bwf7vie/qMCHsDnyPawTDaf01V8y0LeSwC5wBTS1GgCFyR3VgnLbOriDGYL7cXzeQgTn6CGJ/DKHqVELrW12FPP4naWaybW9B4pxZUPOFWBSh2G8/0CNYIlXWGmRBEDLUvrMCuFBlHA6Bm5LeEVFYWmuvIlspuJywCic0Zcrmmxw+PXMoYtYRUWx74aRdTUvPutVv8cZt77zPdSl2Ifgx6gZ5s8rfMHGCj0c5vQv3I1d7PqivgFGaq0HuD+EVJCkNwPbvrusvlq5QYp3NQhkVoa3SD+be/em3WzAiIRnzBG3kUvRPkUQRlxaJs7UG61XxGnuICLC1x7I7I+nKsI2j+YEDE4WkndK25avIG6tUk+0fXYNqq30f8g7rTilINAzYJKA87vcvO8lb2NU3nJ5wDAxjPZvJsfxWwtmX03aC9Fwh2W/4qbEdPVP6BufKcfFOcHGWdjbiicr5NTo3CZQpdOXZs9hO1YovKQGuh3X2KiPCX57U6rDEsKFU2XirhEZzp0d5UYjX8QpmkBU5U8STB1MvpRYGiVwbOlXslbZG9hYSw8ZzHMHp6KeLqUIv12WVs2HJUsNjmaS6ctFiBH1SER6ndR6kzhdmk07yfPSGRAthcbovX9dI1OAHR7gi7+fGsukg7DPUp8FITz2FfuY0j4MwM0wQLfKQ+5yGganYwQG2fIM4sp9f7tVIw19khLUQZqHKny+5bT+FmF8kNDTlltH8aso1pyvtMXEvu3A3vTLZXY/6mz8h6AyMSFtLENw9nO22zRH7mZa4lH9CH26pI6qixeohdJIliGt4NP3SQ3sNnwEF17Cqg/mLyWwe1TnkCDT+s6cQ5MkQ0A1rU453W8uMoU69hxq/0sAmaNEFwLcbbaqNqO22lWZiYIkXDuiBDST2pPgyoVue+zv0Ht21rw/YeSetXFKMyfWLSnkx3cVSa9gbmysuxaGI487ITDL8sua9aOc
 yCcozktkGrOS3+SAUlmgw/X0dQ1kCZ9z0p5OwqWeCHLDTtuD98Z3WvCICp+a6gYTYuoybHVzogNpFolIIowBVdzQJVk4DODphuCW1xX4x4ZB2Nv4R4jl+dJ0AZV5RrH1sIqJepNAPHA8f+U6X+7glgJ7goUpIN7089sYxby41Naqspphm2j23B8HIvsmY6A6mJQFsIlZEvrOikVzUJWGuj9YfHRLCnQE9CUi1bzII66xIfJiBXeowVqxnQqHmnA//Ys0ryOIIkX3tY6O09iIh1kkhi5Y7Ee8VNdYXieSu+sASn4+gh7JAzo8oYr6hQg==
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

acm_rx_complete() pushes the received data into the RX buffer and
queues the request again, regardless of its completion status.

When an endpoint is disabled, the UDC gives back its queued requests
with an error status such as -ESHUTDOWN.  This happens when the ACM
function is disabled on a bus reset or disconnect, or when the usbacm
console is stopped.  Requeueing such a request from its completion
handler puts it back on the endpoint that is being flushed.  With DWC3,
dwc3_remove_requests() then gives the same request back again and
again, usb_ep_disable() never returns, and gadget teardown stalls.

Return early for failed completions, as the fastboot and rockusb
functions already do.  A failed request carries no valid data.  It is
freed by acm_disable(), and acm_set_alt() queues a new one when the
data interface is enabled again.  Successful completions are handled
as before.

Fixes: fc2b399ac03b ("usb: gadget: Add CDC ACM function")
Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
Changes in v2:
- Use my real name as author and in Signed-off-by

 drivers/usb/gadget/f_acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index b6c11d97a62..2ea54dfbe69 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -293,6 +293,9 @@ static void acm_rx_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_acm *f_acm = req->context;
 
+	if (req->status)
+		return;
+
 	buf_push(&f_acm->rx_buf, req->buf, req->actual);
 
 	/* Queue RX req again */
-- 
2.56.0

