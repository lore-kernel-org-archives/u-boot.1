Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFAFC282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAF1811C1;
	Mon, 10 Mar 2025 13:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGpomeHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F16581335; Mon, 10 Mar 2025 13:06:05 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684B08003E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223959039f4so79085685ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608361; x=1742213161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xE5NDsvlphSZcXEqS3DsFpgmiuCFidpkcVpj4sRNCXE=;
 b=MGpomeHGvnNR7+ajBNVj2fGO/V3WnKWb3sfPzEJmMDAWXfW0T2VOzjnNu6ydjdregI
 ShnefH3rq6o/VUpNJaynaLYHG/xfx2BZNhGOIUwdjPZ4E2ovBHjScFcCl0Jwbq9CRm27
 jlWfJMuO5Wh2azMSOVd11qF+avttfTESJ9PxJgKGqudInAds9IBKnrF/mqrvcb1tdCeH
 iff2WapKrW9nwFTD/vd04SxjEOefXpd6YTtaeEexK7qSLcvPstDOn2hWLFl7bFBoILXm
 E/xtCdYWG/q/yrQL8SbB4y9jtDoaBoZiTMreybDhnoAc4L83e27xn/urS3R1F/2/Qxlo
 i64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608361; x=1742213161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xE5NDsvlphSZcXEqS3DsFpgmiuCFidpkcVpj4sRNCXE=;
 b=DR6yk2huAOMvRLfjw9IkMIK/oMnB1DFtiLB3SazrnV2D+nanZBuh0mw39qHq66RXw7
 bX5HhjVbwtck84gjzf8OhBOYK0wX1VN7y3xpZymmAwMzjGTI1sKagrDsHpND7+pyv7zZ
 cqMKnnb/7TTCAzRS61HXYji7ZMFNQWjKdQJ//PwqLkzLHE5PJIo+VqB6LU1xcuDdqpjA
 0bnXBABkFpLKwliw8w90TJPyOoVaK2FVye9wqJ7EwUsesIPEgIfB6j6HU0v1mN9kM3C6
 xdEZ2XIkaNSXsgvwqA2sNcKXoBc11Ybc5U7A+fTUnFLA78o+Rxxc0boEQPr9K1LAHWrB
 KHlg==
X-Gm-Message-State: AOJu0YyDAq883uFe6tF+hBcrmTf40KpLyFYkcSptAlYyj2KbLhX5VMQP
 3yNaWyjEXtY2Qx8FNUfTm+ZjxKgKIbCboWFf+x/Ttyj4jZZIrCcdJ9/lXo7pl5k=
X-Gm-Gg: ASbGnctOkNl2PL4LslEoaXhQHDv527s14EZnChrRvymdjSBL+k5e3ZjK2+A3fSzEV87
 ybh7aexeOmZG7JHKbfMdFF+Prt8agRRdADPch7TaGaFVGVO9jYTEw36PrITL/5gECl2NThbf/28
 MKiwORAJsMe9y0QgdDnum6/wzy7G3RZkdn9ALFBrkDPDYksh7VmMJFve5pwmB5Z7wYt6Uil5DET
 /a9L20KOVhqKfzytMFhrBDnxINcgcCaBtGbSfbHlvB8uv0+UCor/LgB6s7uzs7mopKItToedHU5
 7aIJU8S424gz2ib+HUAqjKSIIZyTgAUcXIcC2+qNdN/uiIVtLfo3XB8=
X-Google-Smtp-Source: AGHT+IFoukchhBahwdDpaaw+eiLM2xD6F/HHPXW3eLZlKm6XJ1y3z7CrS0HlDBOUCEJbe1sHNavPVQ==
X-Received: by 2002:a05:6a00:3981:b0:736:a7e3:d4ab with SMTP id
 d2e1a72fcca58-736aa9d32bemr17660251b3a.5.1741608360780; 
 Mon, 10 Mar 2025 05:06:00 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:05:59 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 1/8] legacy-net: wget: fix wget_info handling after new tcp
 legacy stack
Date: Mon, 10 Mar 2025 09:06:00 -0300
Message-ID: <20250310120607.186999-1-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Check wget_info->buffer_size for overflow and do not clean the wget_info struct
on failure, let the owner of the struct handle the error. The latter is necesary
, e.g., for when a request fails because the provided buffer was too small.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 net/wget.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 0b082c61947..c73836cbc9d 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -53,6 +53,9 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
 	ulong store_addr = image_load_addr + offset;
 	uchar *ptr;
 
+	// Avoid overflow
+	if (wget_info->buffer_size && wget_info->buffer_size < offset + len)
+		return -1;
 	if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
 		if (store_addr < image_load_addr ||
 		    lmb_read_check(store_addr, len)) {
@@ -98,12 +101,6 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
 	net_set_state(wget_loop_state);
 	if (wget_loop_state != NETLOOP_SUCCESS) {
 		net_boot_file_size = 0;
-		if (wget_info->status_code == HTTP_STATUS_OK) {
-			wget_info->status_code = HTTP_STATUS_BAD;
-			wget_info->hdr_cont_len = 0;
-			if (wget_info->headers)
-				wget_info->headers[0] = 0;
-		}
 		printf("\nwget: Transfer Fail, TCP status - %d\n", tcp->status);
 		return;
 	}
@@ -212,6 +209,11 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
 			   "wget: Connected Len %lu\n",
 			   content_length);
 		wget_info->hdr_cont_len = content_length;
+		if (wget_info->buffer_size && wget_info->buffer_size < wget_info->hdr_cont_len){
+			tcp_stream_reset(tcp);
+			goto end;
+		}
+
 	}
 
 	net_boot_file_size = rx_bytes - http_hdr_size;
@@ -227,7 +229,9 @@ static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len
 	if ((max_rx_pos == (u32)(-1)) || (max_rx_pos < rx_offs + len - 1))
 		max_rx_pos = rx_offs + len - 1;
 
-	store_block(buf, rx_offs - http_hdr_size, len);
+	// Avoid overflow
+	if (store_block(buf, rx_offs - http_hdr_size, len) < 0)
+		return -1;
 
 	return len;
 }
-- 
2.48.1

