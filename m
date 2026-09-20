Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EDAC982D8
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F87640E54;
	Sun, 20 Sep 2026 15:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gnK3biYgGwwD; Sun, 20 Sep 2026 15:49:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D26BC40BA9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919360;
	b=M7c/qVnCkJDDQDWKt9MPwD6fx4P+tMt10KtgKFgyDeLTSeeiLaRk6N97DfNxifF4ymNM
	 72HwYNTuma2T0MAJqPzeTe3g7mX9AIuQCWZDyqFTC44CsFIyjs/Fy0sA1Nr7C8acrNuW0
	 5YLfldLy5wQqgcRFc9euzUh74zHDgzCLyh98l/Xu2VPnK2Dkjs7VtA74YcWGGpJJfZDH8
	 k/p3KyqY0059RlfRtXYfmoG8YViROoiRyUNJ1eslM0Xo4oWIWOvVLhXXfiTCkVjqqw9Y5
	 JQ0sM7SQlfRor2I+BcxoFPI3dKTy63BC7kMPwp2X1fqr8o10UR9POuLKrAnuFUos3Bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919360;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-GoodBg:
	 X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gbDiueU0GM1Veq6uPK+oiur8rt8OPC02fUUi85MvQIQ=;
	b=Gt3w1hwKvklBZV6qjU1hsjoZSbeEiuqvC9DJCY236Wm4nTbFRkaZqFB7ani+/Kk5MrSs
	 oNPer9PsSd27gG9emuVvqqc8s0MVbNs7QXpBpv6ZbvQXOaRR3vSGAOMivEofGdIxNRKUi
	 TfBOrzqXhtPmga2AZkLdkCreFwg5NYfCGOyboli27ug2fUtoBpnZI8VFvYVToLXui+INm
	 cjwFezO7hen/KWn2xf3Hnpv0DSlbszhyRg758FQ5Gk8Ra677FEnJindfqkDaj59Zf5xB0
	 09Nsh9EKr48SanzyPXVZJLFLZSOW88XX9/KUaksJzifR5aDjtLuW/5OGrYZGrOYAXVQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919360;
	bh=gbDiueU0GM1Veq6uPK+oiur8rt8OPC02fUUi85MvQIQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rrzY09/auTtw2RDXXzMTGqzLnPYGhLmmXHmsFILUEhXnfbZ4wRh3TkkYKWbOVHytT
	 BEAtcpIY+AHEzT9e5+Y0zqQJ7g7thPpkjJznJ45TMYJhCD8F2o+HzVe7IEqDgmKhUv
	 7ShmngL/RPDPMXzyRJnOQIjZSLqmBjOsMwq7stzd343vt4/pLVzasGyUom6cyr+eIQ
	 B91Wta0B2c9hLSa9PobXOTdjk1w1emsfcN8qrgB1jB5CsA6Wgo8y5M981gQbfqvNq1
	 EvbXGpic7kQNgbjDL3CCpVjsYss93/KS5vVCBrOpFpG2Mv700T7t0nJflpc+d3Gg08
	 qqkNdr1cpdtRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D26BC40BA9;
	Sun, 20 Sep 2026 15:49:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43F93224
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 358A460623
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:28:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8Z2vSLh6wDl for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 08:28:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8B88C60622
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789892924;
 b=Gb4tmmWqumrMJ2dqEAcPohZMEvI+dyRkMOoSrP6BxWsscfNv/VX91/jbnBGSvi22aj/d
 qrkq+6hVWUqMQ2a+tLmCuUiN8m5L/gvYGxYV2iVksnCLTao0Xo3ZtJpM8M7Abdf02iiuM
 B5GeURiUCr4cwyb1C3ouN2MjjZeDj3Ix1LtRr+ySDQHZS4AdNp8Z3ksJZmyC4cdZgdVL4
 NZgBiGZ5d/BrWpAH3kBCq9qZCZzkWfM9jNu9AlEIB8xCBfJZ+9//FjgLoYfAmzxcAyaXD
 RCD4oPMEqFo1f0Pj8eMLitO5rsKvZpcQymWhydNymMvbJF46ihyyKOiub8rODzD9nrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789892924;
 h=X-Greylist:Received-SPF:X-QQ-mid:X-QQ-Originating-IP:Received:
 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-QQ-SENDSIZE:
 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
 bh=gbDiueU0GM1Veq6uPK+oiur8rt8OPC02fUUi85MvQIQ=;
 b=A/jpMf339K2mssZxH05uG8qqQafGmMuxeTvSL9ocJ+by7DCtd7IDmqVZopKxLA8+eHyL
 fVKDByePDWYGS9qcLXweqU96ap/Wm9zZUFSNOuzKUOEj/+6DisrIp8sniEkyodntsa+mi
 RxLj68/gaFPZPeW6q1LllwJlN43Y0xu6si08g1xUfPXHWW4CPzSSCU4fY1hz3NtGMDPgK
 AFNEFqzkXmuWwvsT3dWomfm3l/L9ib+ZDmEKV4M9qgdOQUxEJF4hJ6To7wuzrJ6FU3pYW
 mnvp3cX+cBWdPo4DLfL3aI+SSFRN8crRGVKXKWc40L5O6TJi1T5KYissgb1yvUhNSRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=email.szu.edu.cn; 
 arc=none smtp.remote-ip=54.207.19.206
X-Greylist: delayed 138 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 20 Sep 2026 08:28:42 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=email.szu.edu.cn
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=54.207.19.206;
 helo=smtpbgbr1.qq.com; envelope-from=limingtian@email.szu.edu.cn;
 receiver=<UNKNOWN> 
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B88C60622
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 08:28:41 +0000 (UTC)
X-QQ-mid: esmtpsz21t1789892759tfca9fc0c
X-QQ-Originating-IP: jO60BlhRd9sx+WKCJNlk1iL1UG4A3ZXVWfId1ztfzuM=
Received: from ASUS-WIN.localdomain ( [119.123.46.112])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 20 Sep 2026 16:25:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4571404239048985265
EX-QQ-RecipientCnt: 5
From: Mingtian Li <limingtian@email.szu.edu.cn>
Date: Sun, 20 Sep 2026 16:26:10 +0800
Subject: [PATCH] net: fix UDP checksum check for odd-length packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-udp-checksum-odd-v1-1-a99dbfaddbf9@email.szu.edu.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrmkyDGqEqxAWTlulGn4yZYwJ4
 e4OuvwW721gElUM2mKDKG81naeMqiyAhtv0EFTOBu/8xTXeYeIFaRB6WRpxZsZTTYGr+uxDuEL
 Olih3/fyWXf+3pfAUWo8P7PsXfyEk9nQAAAA=
X-Change-ID: 20260920-udp-checksum-odd-43cbd1352bb8
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Mingtian Li <limingtian@email.szu.edu.cn>, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:email.szu.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MC/IZsaLXRr4x+jK31nGf6Q93Zo/v3gzeIi5qSFUAqAPXnRqHuxncOC9
 aag71BmPiXnaZzITlMrCkNm0VRWlUNjIYoOianRhPC6Yfn2I8tDeU6JvIs8vr/mwd+AUo32
 DWjHzWONFPc9yWieBNumHmfS9OctBxtMM6BNb5DQVF1OCHtUkWZGMg8/UUcRWVttP0IZRuG
 lC6NEytLytByqp9I1RonV4G3KY+9Ganm8A36J1uJe2XscpNhScbRV7V2GdwyjOJbUWSo8kC
 elzaWa+lQF9q8VEjJx7mxVwJtEx6KhrTISPNiZdqmhOEKMIYyCOI6eJn599afw26slPl/fS
 2gAmfn1fiINAnDVHE/BQQq1UQ5HLS50vlnpt4PPLZzVh4FhhXQJ2P/eGl9ki9RZ/K3umCRd
 x9iOpwoNA+HHNEQJClbvSif+3vxyRIYV4oN8UDT58g73dKYrbf74LH/EITN63v2BR6uIWIF
 Glo7Y1x0AhZkARmnEUpxl8zWaUDZ7UdLbft29DDVB4KiRkP87oWAmWrSrFO/DuZ+O1E4lLa
 J+F8zawVDic1iCA4m4VccU7TAO9zPfBgk/L2auMQyFeypm3hmhwwWi9/Kg96wbYQ9JTF5FP
 Mn4YgNXPsfFqqqi1yswDBlWAtygtgDGBjnU90vV/RlEUg/d7eylEHn8HOUTSeOWbl3UQbdV
 kj8x1ohLpW9DOJ+BAdA87WdN1RFbFcG/G8zKdqaaYq2Rp7oU2iWF1jeKvcNn4+C0XUdd3lY
 1d9OU5WqwyGt5Ex5ZxMEYGlh6bwNs9F7lohOP37MC+vYe61qrmlqKoPMe794y+VdF5Cu5+i
 puiRGIgd3oIvBcllG2bIr56ofUm+aReyILDIhMlucEmIgJTcqYXsGIZBMRdQ2M250zfxJyB
 iUd1myn1ezoQAkYaOhGgX2FyzPRMsOD0wy9vnII5j2Q04ot2hM6Sj8N3rhlQoX6FQUv2ZGz
 wW0DvlgCYRnErZExSEYk60IU9dnW8WtsC8n6K6GwMcLsBLBLx8rp/gSsuGTtRWM4mSsIpuq
 I2ludvRX7U6hx6EMZqZlUzcM8lci8iWu/OgTeNUcffMP8X1Hd1EZfatCgHkUcj2vl3Xj/p0
 w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

RFC 768 requires that when the UDP payload has an odd length, the last
byte is padded with a zero low byte for the checksum calculation, i.e. it
must be added as (byte << 8) only.

Since commit 8524423da9af ("net: avoid address-of-packed-member error")
the byte is added twice:

    xsum += (sumptr[0] << 8) + sumptr[0];

That commit replaced the correctly masked

    sumdata = *(unsigned char *)sumptr;
    sumdata = (sumdata << 8) & 0xff00;
    xsum += sumdata;

with the expression above, so with CONFIG_UDP_CHECKSUM enabled the
resulting sum for a valid packet is 0xffff + last_byte instead of
0xffff, and every received UDP packet with an odd length whose last byte
is non-zero is wrongly rejected with

    UDP wrong checksum 000000bf 00009288

and dropped. This breaks e.g. TFTP download of any file with an odd
size whose final byte is not zero, because the last data block of such
a file has an odd UDP length and is rejected on every retransmission.

Fix the calculation to add the byte as the high half only.

Fixes: 8524423da9af ("net: avoid address-of-packed-member error")
Signed-off-by: Mingtian Li <limingtian@email.szu.edu.cn>
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
Verification: replaying the receive path's checksum loop (the same
expressions as in net/net.c) over a synthetic TFTP DATA packet that
carries a correct checksum:

  odd-length datagram, udp_len 25, last byte 0xbf:
    current code -> xsum 0x000000bf, rejected with
                    " UDP wrong checksum 000000bf 00000958"
    patched code -> xsum 0x0000ffff, accepted

  even-length datagram, udp_len 24:
    current code -> xsum 0x0000ffff, accepted
    patched code -> xsum 0x0000ffff, accepted

So only the odd-length case changes, and it changes from wrongly
rejected to accepted.
---
 net/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 71666eb..43889bb 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1408,8 +1408,9 @@ void net_process_received_packet(uchar *in_packet, int len)
 				sumptr += 2;
 				sumlen -= 2;
 			}
+			/* last byte is padded with a zero byte (RFC 768) */
 			if (sumlen > 0)
-				xsum += (sumptr[0] << 8) + sumptr[0];
+				xsum += sumptr[0] << 8;
 			while ((xsum >> 16) != 0) {
 				xsum = (xsum & 0x0000ffff) +
 				       ((xsum >> 16) & 0x0000ffff);

---
base-commit: 211de43d0f954a00a490220c1aac9db298287c40
change-id: 20260920-udp-checksum-odd-43cbd1352bb8

Best regards,
--  
Mingtian Li <limingtian@email.szu.edu.cn>

