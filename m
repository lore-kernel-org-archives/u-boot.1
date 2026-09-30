Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5920ACA5FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E56840AC3;
	Wed, 30 Sep 2026 17:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJLSz0eZ8Ix7; Wed, 30 Sep 2026 17:26:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4895D40ABB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790789215;
	b=XzXgFgkQf5tGTFp3D+KBufNk19U882eJsALpOrbCVV5c0lqJeIc9PaLbxkuR1lEfmsHj
	 +U+eEzC9/4UA0C4JnX0R2XjCUqiQTNElFG3mPxc+VeffwTN8Ijg7LELHbuqqUWA3W9BIm
	 ZmW4qd8ctsj60dZbtWTk8a7I5LGQ6NDPQA1ZYFgwx8gPEXVPQd44E4BL0kKX3g/z9PxJm
	 F9hnb7YwghPDU9EnEmDuaR7JTd8B5d5fBZNDfHxdfTxOiq1fBqom81dnSIE41MmbpnHfG
	 v4eO3J1D5+TI9i2VSPrcNVLgvJWTWYwhdBYtJWixGo4NCn68CT+hKIfl7nyNR/IkpQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790789215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8EoJEPlNAVLwXtUhG0vpNSQebyVYg8qt3pOTRj/f42Q=;
	b=KzegHOwyC04odTgKtQ2lnDtxbXcb6blYQI+sOOMN9F4oeoaNak5rpaNTbuUN8AlafHvO
	 dijuyPab6f9ZV9NYcn9FNggMEq2d1Ueb8hiKIWeTFlgj8ynrsT0IVZXS8bNPk9l6wR4Wj
	 aPw+F41ADNwkfm0yohdzeMMjOAQrNuFc04Ymjcjh/PIbopvL7KCKQW/nbd2bRMxJmvffD
	 WVJrEe35VfWAViLZiJK9SDVRSkRw/47115GbjE8tuzAM0EybJ9zTDS8SE2e5vaQmY1vzn
	 x4pD5sHTbMfJD7N9OqwtaUDD94RrrKFQ6seD/LFDt+LMw78tS0Qbhyz5maWyFe7yRRQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790789215;
	bh=8EoJEPlNAVLwXtUhG0vpNSQebyVYg8qt3pOTRj/f42Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JahCAByaxLAFs1/3qs5wzCPQRjxVroqtdM2fHcZjjUknHeTYlNGuPaSyMoJ46Yq3/
	 pmDHh8sCZz6IzkA6lLWbDEUZwD4wIAi5sYN1Rr8Dz63Z4DTG0+fYSujcfZYw2Afi42
	 cix12vOY4sMP2Jj8kV+I/S/R2VvkHcDYa2cCpHA7JW7hzKslfPtneEie2Jo1+eTgOK
	 5qWKAzrveC+uw/9ORPV67ibVJKut1oWyobxEiut958VdJMKFLHyYwTRsgx/d+ZV/HP
	 MyEJ6yN4g7q75jVRu29/GiFVIKYWRN8W+uzvnU+4FT+mO9LhKMHDm7LDLqofbRm0MF
	 AMbSNOwcyG5ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4895D40ABB;
	Wed, 30 Sep 2026 17:26:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA96533B
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC8A860B43
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SBSS5hT57Puh for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:08:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E5D1F60877
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788129;
 b=sSB444qTdl1OV1mjZztwayAL9ofxUWT+RNusdKaI5hshGHUcKQln7mkjYHLjizth13lP
 /SYUjhOkip8t+qCqQURHwHaJrgQNydHYLc0KmnK+T5esikRdU2Ai3o3dWVLHvMltPySzy
 glBnuxF/nX+A+TqaL12fXPJ392IjK8COH9gj7Wq62AIN2AX8WvrrgRPIqAAk6DSZjTpiO
 XLc8PY6IR8uL0n04hpHexAjDkG9t+w46Qvs1SA1mDCOXRDEmmoAGKiex9DSyJAgYBiBt3
 xaQ/9KnydMLigknbLYFDuBwrQcIKBg6PPY8+yqaXTCaeUJepGHTf/8rQu72wVLAFPfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788129;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8EoJEPlNAVLwXtUhG0vpNSQebyVYg8qt3pOTRj/f42Q=;
 b=JZmg+msoPslEvK+J/4fLyKypCPBhGS/v3BdFC24vPmFB6IZNZ14d6OaMY2z3Fk1VuoKW
 C7zxc97KE4Cna1hyiUDOEXrEFtg3xGG/ZsSsgY+DMZ8Z1g5I38hSUppPPg1b3cp+6t2ON
 TN+C+ZMSB6uPyWoQjy9v6q68duiBu395umn0OcIjRRzjYiJ8i/Y5NS0VrZ5UvG1whatU1
 pY24aaTPN+aEb/b8hURYZ5nys/sTXcLIBln6Owg9Gt5WwXaW6r3JYytyYmvw8SM0AzBSC
 jcIlT3ICoJBDTazGTWaiGH/UXGlLNFkBUaxd84G+X6Tc9TKRH+PA2lMy3xbF8OcxTEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=t0.technology; 
 dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256
 header.s=google header.b=QR3OC7zw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=QR3OC7zw
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5D1F60877
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:08:48 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso2944417a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1790788128; x=1791392928;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8EoJEPlNAVLwXtUhG0vpNSQebyVYg8qt3pOTRj/f42Q=;
 b=QR3OC7zwvnUWjrMVorr6gKoKgiyX+QSHKLOnqDeDAKUmRnYpqj6eT4YQ2hvaToOcBJ
 P/pgFpATUk+b0Xf6JuWhyDy5RY3VVd3w105I20QWESRS0EcFg0v6hJ3nk7LRP40qXfYR
 6dT/iazJmaQyBYs3RgCY+1WtUBlW2Yd0g+1++K+cwOoda76YZrMh7ZD7u5HV3J9Z92T6
 Hj5/Fz8YiBtBzaXBEagSo7rqCCFqq2dTm0tG5+XmJSFq2U/XOSB8OoHXiYNeuibT93+P
 oGs5zZUzDPVpR9qLN33sSEYQMw1y08LNMW0UB84s5qCvf5chcCBcAXnxnTeph5zKrRZw
 kd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788128; x=1791392928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8EoJEPlNAVLwXtUhG0vpNSQebyVYg8qt3pOTRj/f42Q=;
 b=hfs10fYTN+PyFKu6QcmO0uQCqzUtYOBZZkSZ5eE8dqjvtRUhFloKPUJzGYXcjJN/ew
 54Qh6ppl1L2lkHYlgjqoFpHW+Kkfm7Znin8Hq98EXDIkqhhKG50vbFckD9hq2xAFTkVj
 7gQqWuykfNO+yVqtqZxT+w9jGsZOkQYEqsGu6bS785u/Fr3y0eDd5y0CsE/gIDtn+dwy
 i541/45fXmDvXY8vXbkNFBg+pOsOiIIpzyEeF046wyCpwZtokmzuhojr6Sv7R41m24Y9
 GYm1VTwj6qGFQj8ydDGBTg9taFubsWbe0H4NCnlRrXoTGlyIIOuAJKM8iAzuKLp0u2+U
 N8rA==
X-Gm-Message-State: AFq9FYKtpgWHKFdxNRx8nSmp3zWNDAQmhbr6MiDeEe1jiDViDtmV5Z0L
 PirfY71EXiuBMfSaqwndMsxTSsl162A75RVxqQKMwn/WW+9W0AHhalbUr46sBXtI9IeEzaGNl6t
 IJfgwfqg=
X-Gm-Gg: AYBFou0YAJvj61F4+2YQwN9qk8xYbf6ZE4ikvrT/DoKmmrf+ZNjzqEDDKHacqRA1CBE
 pKA6CwtzI0HatLzxh05SLj2Zpq/LgEQi6j+lquqrtCtWkS6JBn1P/0CFcQlRMO+HOoeKRRXbRhZ
 hXytMboys3HkGSiahK7hGkZxTn9Gqeyw+5TODLrCGiBQ17H0KzvcLci5XZBkG6P6NFqF1QMH9Ry
 QTP4uEAoWfxQ8TCqyIw9Yfdn6QAWWSjZK6w6ciSa77ZEAhQF6CMdMuCyqTPQHzIR57w1Da7tM0d
 MHqT+Uf1Tt7S+OHsIfapfbLAXXV+rDGvZ9gv2hTAai2VTs7GuJmtDjPpGIeXmAsjLzs1JWlWrA7
 XF9IjWFqfzwswcq+KYRklX0p3ne982utScRAf7ab9eo8teUosAkzDOAXeHnm/xZGvhSFOSaBcwe
 WJhHGPPZpcVnHtdXLQUM8E2rQJ3XtVO+CG1Dxv2NKWkAr4Fjmm88PsiEui7zysKBwrMIgoFST59
 X8DiEd5tdKUp8r7tvqVjLrj6JuanCjD58/v+gWVLbS2OReYMdxRnwb6
X-Received: by 2002:a17:90b:2b44:b0:39e:359f:8539 with SMTP id
 98e67ed59e1d1-3a4d14de07dmr808192a91.15.1790788127398; 
 Wed, 30 Sep 2026 10:08:47 -0700 (PDT)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f47035e7sm199475a91.7.2026.09.30.10.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:08:46 -0700 (PDT)
From: Graeme Smecher <gsmecher@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Graeme Smecher <gsmecher@t0.technology>
Subject: [PATCH] xyz-modem: only strip trailing ^Z bytes from the final XMODEM
 block
Date: Wed, 30 Sep 2026 10:07:43 -0700
Message-ID: <20260930170743.2141954-1-gsmecher@t0.technology>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 17:26:53 +0000
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

XMODEM carries no file length, so the sender pads the final block with
^Z and the receiver has to guess where the data ends. This is a
fundamental ambiguity in XMODEM which can't be resolved. With that in
mind:

xyzModem_stream_read() previously checked every block for trailing
^Z^Z^Z (three EOFs in a row) and stripped all trailing ^Zs for blocks
matching this pattern. Two problems:

- A final block padded with one or two ^Zs keeps its padding. This is
  subject to the design ambiguity in XMODEM and is left alone here.

- In intermediate (non-terminal) blocks, 3 or more ^Zs that are part of
  the data are removed mid-stream. Each block still passes its CRC
  check, so loadx reports success. This is unambiguously wrong and is
  what this patch fixes.

Count and withhold trailing ^Z characters in a block until the next
frame arrives. Another data block means they were data; EOT means they
were padding. YMODEM transfers usually carry a file length and won't
take this path.

Because the bug is keyed by three or more trailing ^Zs in a block, it's
unusual (1 in 2^24 per block, assuming random data). We bumped into
this with a gzipped disk image with a block ending in seven 0x1a bytes.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
This patch follows the GNU/RedBoot style used in this file (and hence it
sets off checkpatch - happy to follow u-boot conventions instead if you
prefer.)
---
 common/xyzModem.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/common/xyzModem.c b/common/xyzModem.c
index 698a538a148..f10da6f20d8 100644
--- a/common/xyzModem.c
+++ b/common/xyzModem.c
@@ -47,6 +47,8 @@ static struct
 {
   int *__chan;
   unsigned char pkt[1024], *bufp;
+  int pad_pending;	/* trailing ^Z run withheld from the previous block */
+  int pad_deliver;	/* ^Z bytes to emit before the next data */
   unsigned char blk, cblk, crc1, crc2;
   unsigned char next_blk;	/* Expected block */
   int len, mode, total_retries;
@@ -445,6 +447,8 @@ xyzModem_stream_open (connection_info_t * info, int *err)
   int dummy = 0;
   xyz.__chan = &dummy;
   xyz.len = 0;
+  xyz.pad_pending = 0;
+  xyz.pad_deliver = 0;
   xyz.crc_mode = true;
   xyz.at_eof = false;
   xyz.tx_ack = false;
@@ -524,7 +528,7 @@ xyzModem_stream_read (char *buf, int size, int *err)
   /* Try and get 'size' bytes into the buffer */
   while (!xyz.at_eof && xyz.len >= 0 && (size > 0))
     {
-      if (xyz.len == 0)
+      if (xyz.len == 0 && xyz.pad_deliver == 0)
 	{
 	  retries = xyzModem_MAX_RETRIES;
 	  while (retries-- > 0)
@@ -551,8 +555,12 @@ xyzModem_stream_read (char *buf, int size, int *err)
 
 		      if (xyz.mode == xyzModem_xmodem || xyz.file_length == 0)
 			{
-			  /* Data blocks can be padded with ^Z (EOF) characters */
-			  /* This code tries to detect and remove them */
+			  /* Without a file length, EOF padding can't be
+			   * distinguished from block data until the next
+			   * frame arrives and we can check for EOT/EOF.
+			   */
+			  xyz.pad_deliver = xyz.pad_pending;
+			  xyz.pad_pending = 0;
 			  if ((xyz.bufp[xyz.len - 1] == EOF) &&
 			      (xyz.bufp[xyz.len - 2] == EOF) &&
 			      (xyz.bufp[xyz.len - 3] == EOF))
@@ -561,6 +569,7 @@ xyzModem_stream_read (char *buf, int size, int *err)
 				     && (xyz.bufp[xyz.len - 1] == EOF))
 				{
 				  xyz.len--;
+				  xyz.pad_pending++;
 				}
 			    }
 			}
@@ -612,6 +621,8 @@ xyzModem_stream_read (char *buf, int size, int *err)
 		    }
 		  else
 		    stat = 0;
+
+		  xyz.pad_pending = 0;	/* EOT: withheld ^Z run was padding */
 		  xyz.at_eof = true;
 		  break;
 		}
@@ -626,6 +637,18 @@ xyzModem_stream_read (char *buf, int size, int *err)
 	      return total;
 	    }
 	}
+      /* A ^Z run withheld from the previous block turned out to be data */
+      if (xyz.pad_deliver > 0)
+	{
+	  len = xyz.pad_deliver;
+	  if (size < len)
+	    len = size;
+	  memset (buf, EOF, len);
+	  size -= len;
+	  buf += len;
+	  total += len;
+	  xyz.pad_deliver -= len;
+	}
       /* Don't "read" data from the EOF protocol package */
       if (!xyz.at_eof && xyz.len > 0)
 	{
-- 
2.47.3

