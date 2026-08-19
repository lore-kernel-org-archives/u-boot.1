Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CA0C5DF85
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 17:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C195A4061D;
	Wed, 19 Aug 2026 17:03:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KCGpMijbGaiA; Wed, 19 Aug 2026 17:03:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787158983;
	bh=smASLvwT9N2Kp+cMbcAsUW46U3Cq+JZl/q7t+juRgGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JPdPrJ3fqQ7Np9vXdHMteTDa5uHw3pv7s5e3AzqPI0srbxS7yGBw+5ESBtB9K9JpN
	 W3Kta+OH6JnPr12PRUprNW5Zv/P4wgkryqRbyzla3O8APOh1wIb/J3p0GcbBsDAZdS
	 vvj8hsrFGvER/OIVnB2hD/RUoYsplt3or53UfDUjZ7WNTsw0tWvJ868bCDCBFivnMq
	 2zMOafm/h77N2MBv86RnOJAKvlmjaRWMFu7cnHE9hLcsPtpevPr3ob5WjBTwhjtZby
	 ZxUphrlOxDrKUvN0nKwx16OcJFaPaEIsYzU9pjKFvkELVC7jqFh5/EJy9h5kdyy9DT
	 xTkPwh9xFZt8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0613A40603;
	Wed, 19 Aug 2026 17:03:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2533B285D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 230BE60739
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hm4BKjAUiyTX for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 16:40:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=byteray.co.uk
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=MKbmeHoA
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4032360718
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:45 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so1994445a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1787157644; x=1787762444;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=smASLvwT9N2Kp+cMbcAsUW46U3Cq+JZl/q7t+juRgGs=;
 b=MKbmeHoAWN6cUuyN1eNMxuxXawEnI+ufSRoseGjRquiTYVKoEa0n1jGpTGH4VXZAYy
 5wPSFMkTwP+duEfCftX1BZOxDXHcqfz8LX7UND4aY6PSxY6GKlE5NbvcNqTF+Y43yiv6
 S7T9PAisH5gS0kbJ1Nh77oIoLHy4Z1m9n+PbwPCS2OEtj3+ojGeZiij1tLFV0IdmMX1C
 mVsDyB98Xg94kYYQsN7Uc69/6Crst70Tn1DfwBGpid3tN7Aa0yZeLcQ9wJmxAwnwhA8t
 tHGpbEge/Hb5zXZ+an9KfhHwITjuGrN8AB5OFyRJG8wISlLeZZ++IglXnXdP3ufIvU3e
 zmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157644; x=1787762444;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=smASLvwT9N2Kp+cMbcAsUW46U3Cq+JZl/q7t+juRgGs=;
 b=ggzsY1Q5TxIgX0t/dX2BnY+T2koEB+RGbWgV1aNGUbUn1dTI6dH9uE1JJ/FULpjlbS
 1MGhTm360UoZmZZLehZMebH8wB58G12PvLggpJIBVl51CjIHEsLPcSZfBFN7HVB5cET2
 qGeBciXd3n7CyJlffrTT3DMI2hA/u5edNRBkfTLyPLLlZouezfSSeGNWFlFtuFJwW3sP
 yoNQOmMVIUGRr9RxNZdcvIFuAuIrDE4s0p6fwX3DmS+lIpFN4709ZtMtwtPZ7I1P3FpN
 Z5v7E6QeQwa+guV+hHxVw1kWnFuuSc5QrQ1LLy4+PnUb/8V9gW2fBnP6lgxZHXIqMIEi
 J/3Q==
X-Gm-Message-State: AFuF++mTU7MpIge4xBOCm6qlLRj6wN/ZspffABn/o3rMKYOL30QjevGO
 aO2fyc+4X7GXUqJsih8dbYIP/YMsCp5y0eWOiBJusDmHF1lLkHB9Bg5+GbMEVHSdrfSIwRcaA8y
 U8TGuh7U=
X-Gm-Gg: AR+sD11BQyjsLV78ugb6AbACam0MVPjT/VbekGvX9AAJ72GEWKKyDw7JHZwNvEBWuOC
 SaayOw13z8sZLQVNPzhemE2r8CN7CY0Gto5UncmLtQLqMnECDZRSgfhYQsnDLgEvjcj6L7An425
 PeRjDjhfdOmkA3PeLAO8vrCBr8vYIa4prHBZIf7cWpc454b1QyG3+f6SnmCEqjhCHZttTlFw173
 wV7vQQxRrKLJ0oEqRn59S6mTie1s+pVs3FwI+dgF4MyqWf7twQjSAY++jOXBxmUCY+GvCBnsaRe
 Q6NSwo1qmyXkT82M5dPvvC9JH4WSCYlLGnyXUwzlPd88rMY9dwBYuhCOpVpAaVUHyMNlWepIOUY
 m9CjoSxGDMHNCxXHAwtlQFbRhjAXGDYaAd2MT1T9fvBOARc0wmSbaQr01zxJJYc5EbviqCqOPM1
 mi0C6lKA0/G7g5M+1V8e2mToX6V0M3s4M2WYM10q1jtOwvnCwYJeFySfUN5ORUshbpUitlz3vYA
 8MVo0z/774sMrG1yGNVeB/rVnEdWvMcWZg4D85rBbEOBU8ZnIo=
X-Received: by 2002:a05:6402:28cd:b0:6a3:ee5c:8800 with SMTP id
 4fb4d7f45d1cf-6a4032b1629mr4608427a12.8.1787157643924; 
 Wed, 19 Aug 2026 09:40:43 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f003bf9bad107298ed5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:3bf9:bad1:729:8ed5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c327asm1219822a12.8.2026.08.19.09.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:40:43 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 19 Aug 2026 18:40:24 +0200
Subject: [PATCH v3 1/3] net: nfs: bound the length of an NFS read reply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-nfs-oob-fix-v3-1-7f8158088b80@byteray.co.uk>
References: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
In-Reply-To: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 17:02:59 +0000
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

nfs_read_reply() takes the length of the returned data from the server
and hands it to store_block(), which memcpy()s that many bytes out of the
1152-byte rpc_pkt stack buffer to image_load_addr.

The length was kept in a signed int and bounded with:

	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
		return -9999;

On an LP64 target the pointer subtraction is a 64-bit ptrdiff_t, so a
length with the top bit set makes rlen negative, the sum stays below len
and the check passes. store_block() then takes rlen as an unsigned int,
so 0x80000000 becomes a ~2 GB copy that runs off both buffers. The bound
is also measured from the reply header rather than from the data, which
begins several words later, so a large positive length still reads past
the end of rpc_pkt.

Read the length into an unsigned int so it can never be negative, reject
anything larger than NFS_READ_SIZE (the most a read requests), and bound
it against the received packet measured from the start of the data. Take
the NFSv3 length from the opaque data_size field that prefixes the
returned bytes, which is what store_block() copies.

Both the classic and the lwIP NFS clients reach this through
nfs_pkt_recv(), so the single check covers both.

Fixes: aa207cf3a6d6 ("CVE-2019-14194/CVE-2019-14198: nfs: fix unbounded memcpy with a failed length check at nfs_read_reply")
Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 net/nfs-common.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/nfs-common.c b/net/nfs-common.c
index 72d8fd823e3..91ae7a43b8c 100644
--- a/net/nfs-common.c
+++ b/net/nfs-common.c
@@ -694,7 +694,8 @@ static int nfs_readlink_reply(uchar *pkt, unsigned int len)
 static int nfs_read_reply(uchar *pkt, unsigned int len)
 {
 	struct rpc_t rpc_pkt;
-	int rlen;
+	u32 rlen;
+	size_t data_offset;
 	uchar *data_ptr;
 
 	memcpy(&rpc_pkt.u.data[0], pkt, sizeof(rpc_pkt.u.reply));
@@ -728,17 +729,19 @@ static int nfs_read_reply(uchar *pkt, unsigned int len)
 		int nfsv3_data_offset =
 			nfs3_get_attributes_offset(rpc_pkt.u.reply.data);
 
-		/* count value */
-		rlen = ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
-		/* Skip unused values :
-		 *	EOF:		32 bits value,
-		 *	data_size:	32 bits value,
-		 */
+		/* Skip count and EOF, read data_size from opaque data */
+		rlen = ntohl(rpc_pkt.u.reply.data[3 + nfsv3_data_offset]);
 		data_ptr = (uchar *)
 			&rpc_pkt.u.reply.data[4 + nfsv3_data_offset];
 	}
 
-	if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)&rpc_pkt + rlen) > len)
+	/* reject a length larger than a read requests */
+	if (rlen > NFS_READ_SIZE)
+		return -9999;
+
+	/* reject a length that runs past the received packet */
+	data_offset = data_ptr - (uchar *)&rpc_pkt;
+	if (data_offset > len || rlen > len - data_offset)
 		return -9999;
 
 	if (store_block(data_ptr, nfs_offset, rlen))

-- 
2.43.0

