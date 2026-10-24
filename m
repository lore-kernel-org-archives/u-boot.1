Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1C606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 22:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IC876tCz;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=givRfvFp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8853E60622;
	Sat, 24 Oct 2026 22:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ktZeJ2m4zApJ; Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD3D860618
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792881323;
	b=lukim72qU5fKCvjQg069+1/MlvwtugwzD5SvZjR4Q3nYagvxgftHunY4BmlkGdsupsiK
	 eYf9vhgCRx4baQ2/4rmVD8VSGLoMGvAIhoVrd97hgRslQFzFN32LEEQTYW+vc2lIEPiyC
	 nrc86gBoeNnjEtDBxP3YMk//aL/LctmnGW+7beQvbS5fjeid+HWXft9NQFRhdhWc25igS
	 /V6jG1skyFrzB+d+79xoT0YPBru6nLnTBuO2TZBG3JOLP0EmjUl+EMDzu3hOfbYkvzEaY
	 rpYV89gv5Rn8cuC5rAXgz0I1w1u1sT4sKj7PTi5vSXrUv4ykSj32OrdVDq/8ev2Aodw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792881323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BfV23CNwkAm5XiPLp4EpThvsZJS93pgds0SpgxIwetQ=;
	b=Htel04Ilx4xCrLP1QHGjH9ifdGhhliPnBUf2pE+gKgjbga4qOXcS4piv/pnQpYuLkb+9
	 jAYIlbjA9dteDlzA2rThFSF7dZdrjFQ5bx/45CjxJzNkCN12Cy4qpHpuvxmEq1LKGG30x
	 29CvqgKUmZ8KADAkBlMMSlg79miwO/iNqNruqfmU6JhM9DXnkHyJSmpOlE/OhczO58ujm
	 J+0cG5s7HLctjNxr7zVlPDEBlYHkZWTu39nkXZBstDq4GxldSeuOiMkU2LJANiGi2ODnw
	 zi7c6bIhWpoiBkP7H4AqUKS4PETWhPVcDsuNrOoWiT7DPFwVoca0ffDGyaKa/KiJOEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792881323;
	bh=BfV23CNwkAm5XiPLp4EpThvsZJS93pgds0SpgxIwetQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IC876tCzncEx5pC/74PE1TBAvdLK49OcLGZ9dlfdcGjXaxhDUaMRooq0xEoAHzlrt
	 tFLIu6Ounms0nZPU+uI5JaF3NBPHgnulDncPl+nS/rYq7lBh3EWKqnRxt7rmfErypr
	 N+OPLs1GRQx3/s60+GFwK281zGQ87RPK/1Zj+Z0eilvUzrIgmnzMaIqkRPcpxRFHB7
	 edHMSBuwdZxQH3YCY3ULlUSzewUhiC1a1l/1Dj0FwhCQv/chY0I3sdqROoa1KG1vXn
	 yR/6sD0gqpvW4+OmHQfV2mh+EW7jU4+hGtbf1VkuVSOqdfKEDQJIeSTBgERe47Kiaf
	 Szd3SnYgSA1jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD3D860618;
	Sat, 24 Oct 2026 22:35:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 69086380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5AA4580E4E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpf6kl9QAMRL for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 22:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B226480E3B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792881319;
 b=rDu52NNMuJ4nzi61vTFXjfQXoVyZhNt3qmP6cPlvOsDPYm0HE39+ebPp/cXnBLsoowSC
 mIGU7RHOWA4oW1BAwk7Y624+eYr2ZfptUfcRrlYh9MqoYU82MjaeL5h/YbHzt64OO11QK
 RXejqyBqz1hLzNT/ySo46aqQD4iL2lz1MJCL5/SqICssJ/L99KGTXkDi6ki9AK0fTRaom
 8NdNFMbw3mQR4F9Wun1dbdL8bl86fCVkOlkM/ILdmEFLyvxdmDbT/oA3Hnoouonmtk6Wk
 p0+q9rauw4W9dpYkX5P4by/MPX0vJFUIULU6wIB8OtKaKhifWtLPNWX13xkCJsvhPPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792881319;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=BfV23CNwkAm5XiPLp4EpThvsZJS93pgds0SpgxIwetQ=;
 b=QQGnoiim9Ib32RCuV6rEIpahFiUl/kgtNwYm8N0aSrivkydRNfFuDirqFbBH+EW9vE/N
 KSOtS3+NwxXeqQr8OXXdydmeYI/5ZWmBLMxLzZto9I3D3ssqQHRHdnugr0mwTLjrPCjgP
 A9GUEzWqePABkIo744R/MQwm0ncMpSlt2Nvmcw1Y26ZaEZiT005QOE+7YA3niaF2PatjM
 AR1ERqnDgA/uMdjT/thWz3dJ2NNcBD1BVoCd46hY4eg8TxkSwcx7Ot2+IMd/tUQbRUt6u
 dIg/DmpChTsNua1lgBYuNpm92h0az+glpfIcmBYRiQiDZvPbCfzTXRDGc9FDxVX8pxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=givRfvFp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=givRfvFp
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B226480E3B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 22:35:18 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6f5a0893610so1295317eaf.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792881317; x=1793486117;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BfV23CNwkAm5XiPLp4EpThvsZJS93pgds0SpgxIwetQ=;
 b=givRfvFpWJ4SvKR5lHjnw3d216huMzi7EsR8PPZKbp8FRgkwu2TOd2qYwuPfNY/wCe
 AeLeRO4YWKGuxN0XHRMaCI5qDENclczTK7Hqt+bChBme3QAfLK38Pz1Jingwe8W4XS8i
 QaEVpZklCMBHBdV5VuPjZSEmyjl6R6TXR7HZgt4sLxMylUfh/ubmJjj6AmtvvW5fzsJW
 GOCZvdYEp8vf21CfjYmE4xFZcnCyq/RRBhBWeloPRHpZN9PjR8nPRnWhAuzwTQNSCEpt
 ze5e+s3bD6YgZKZOx84F/AVwKlWNBr39FZx/eofis5uQTdmWkTre9cubI2yLlvgJb2o1
 34WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792881317; x=1793486117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BfV23CNwkAm5XiPLp4EpThvsZJS93pgds0SpgxIwetQ=;
 b=S+TuOtK+mQFnHHxgxiMIVLejFWB5rjFHjmD3+4WqrmKTIu6iMhrLrpQ1pjF8DePc6z
 0EiZO6ubFCAVnT69+CewbRRk0M7slolaz3Zb6WBzDKgY/Adh1B496de4O488YrT7Lka9
 WXXGhKeSptRHN5N6Hd2JwkaUUrDO8dbnSb3nr39rukJXYuJTpDoB9kR25VX3dHK5TiYM
 6rDM7+1SeUOi8KU4cixYnz7wkA3ygUnhIuuJV46tfIyH+DwwCjREyQ8+zwHCDQz/jIuK
 GRMbdhw4KEUp2cWPmN+lkvDN6wvM2r8ImCIID5fgsTQpLsHpXDcHfmn8tGVvpDHkgZ87
 8RXw==
X-Gm-Message-State: AFq9FYKl/wsWimmMBKGHwzZILRlW27aeMTaKwwkItRhJtjYqL0Bhs6iG
 i5bsRjRtbXpJOZo/rgTM5ymFZBIfLaCdjwj44XjFqSmLMdlXQG9NA0XF
X-Gm-Gg: AYBFou1nMHu0HBdln9EOmzdQcFuCXI26ibt/mPYlOQbfubjauy4Jao4pmtY2Z32iMJJ
 W17NmaEdT8iOst4SAvTa2yhiOd0aOOCotz5wz5E8LhoMKYCHcSrfchv9dzb7BIrYcSVZnRjvNqA
 fDF2/BSzCKi9CjEoxhdfmdneLLqFoT6QT2IW+EbyTMZE0fEpUM8iyTkSjHEwciRcxrsS+UbtxRa
 BXVjet6n2Jja9RMHfsFAYvULY3M4Q+UzGnjxPcKs/9oh2EOgKF4lIx3SPR50pCA78TO3A+Fz0O1
 TTvc4RF5xUhbl1kLJ68GXfntkDPpAkArfeXKaK6Mrg2PMKgQoIvucueYXRlk+hXqy4oHqF0dyb2
 NOoEUnDhwA7tBlJ6TRIJ5tfOJLOzMyTL/DMDofJP0pBgoNEPoFtBIxbZ3BhGt291o/vmgOIUduY
 UN+2JPfdYB9X3DWHmBLEWZcwhb5iMHdv2r3ybaJ3BvAMhhqpHNuY2/Q13GYZv8p7DPj4pEk/SI9
 MZgFdLnoT6Q6rQJeTpnLMCR1XxBlmadolARYdLaXeiBRpaGKK9yiE8xTOUGScVvmQyF2jym9uRr
 vE7iOl+yhrGsZuNKnk1b+ocAy+oXJ0BPOFfAQjD6jqSsuPESFqF0QqynbDPggcuKC+jvf94cz+V
 SVcTYm/DLGj1SDhwH3OLyCKR8tGFPdzcS/PRcKplNiMQdrJV1J1hULfwwXXLFr5bKpcfGeCS0wo
 FOZ0s=
X-Received: by 2002:a05:6820:1393:b0:6f9:59ee:cfb7 with SMTP id
 006d021491bc7-70ba0e6375fmr1778857eaf.23.1792881317335; 
 Sat, 24 Oct 2026 15:35:17 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a8430d8130sm1706457fac.5.2026.10.24.15.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 15:35:16 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 24 Oct 2026 16:34:48 -0600
Subject: [PATCH v2 01/16] net: lwip: tftp: fix write-request transfers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-submit-lwip-tftp-combined-v1-v2-1-0f663f735ee8@gmail.com>
References: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
In-Reply-To: <20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Drew Kluemke <ankluemk@microsoft.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RFC 1350 specifies that a server accepts a write request with ACK block
zero, after which the client sends DATA block one. The client starts at
block one and therefore rejects ACK block zero.

RFC 2347 likewise requires DATA block one in response to an option
acknowledgment for a write request. The common option path currently
sends ACK block zero, which is the response for a read request.

Start write requests at block zero and send the first data block after
ACK block zero or an OACK. Use the negotiated block size for transmitted
data, return to the default block size when the server ignores the
option, and add a setter for the write-request transfer size defined by
RFC 2349.

Validate the complete OACK before publishing negotiated settings. Handle
case-insensitive names and chained pbufs, enforce numeric and block-size
limits, and reject duplicate, malformed and unrequested options. Report
local transfer failures through the error callback before closing.

Add sandbox packet tests for valid, chained and rejected OACKs.

Keep the U-Boot receive command's context closed once it has finished.
Another WRQ can arrive in the same receive batch before the command exits;
it must not replace the completed filename or append to the loaded image.
The same guard prevents a failed command from accepting another transfer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c                | 248 +++++++++++++---------
 lib/lwip/lwip/src/include/lwip/apps/tftp_client.h |   1 +
 net/lwip/tftp.c                                   |   3 +
 test/dm/Makefile                                  |   3 +
 test/dm/lwip_tftp.c                               | 216 +++++++++++++++++++
 5 files changed, 376 insertions(+), 95 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index e73bea20e63..a28958934bb 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -74,7 +74,8 @@ enum tftp_error {
   TFTP_ERROR_ILLEGAL_OPERATION = 4,
   TFTP_ERROR_UNKNOWN_TRFR_ID   = 5,
   TFTP_ERROR_FILE_EXISTS       = 6,
-  TFTP_ERROR_NO_SUCH_USER      = 7
+  TFTP_ERROR_NO_SUCH_USER       = 7,
+  TFTP_ERROR_OPTION_NEGOTIATION = 8
 };
 
 #include <string.h>
@@ -99,10 +100,13 @@ struct tftp_state {
   u16_t blknum;
   u16_t blksize;
   u32_t tsize;
+  u32_t put_tsize;
   u8_t retries;
   u8_t mode_write;
   u8_t tftp_mode;
   bool wait_oack;
+  bool request_tsize;
+  bool put_tsize_set;
 };
 
 static struct tftp_state tftp_state;
@@ -111,6 +115,7 @@ static struct tftp_req tftp_req;
 static void tftp_tmr(void *arg);
 static void tftp_req_tmr(void *arg);
 static const char *mode_to_string(enum tftp_transfer_mode mode);
+static u16_t payload_size(void);
 
 static void
 clear_req(void)
@@ -168,13 +173,19 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
 {
   size_t fname_length = strlen(fname)+1;
   size_t mode_length = strlen(mode)+1;
-  size_t tsize_length = strlen("tsize")+3; /* "tsize\0\0\0" */
+  size_t tsize_length = 0;
   size_t blksize_length = 0;
+  char tsize[11];
   int blksize = tftp_state.blksize;
   struct pbuf* p;
   char* payload;
   err_t ret;
 
+  if (tftp_state.request_tsize) {
+    sprintf(tsize, "%u", tftp_state.tsize);
+    tsize_length = strlen("tsize") + 1 + strlen(tsize) + 1;
+  }
+
   if (blksize) {
     /* 'blksize\0'.\0" with . = 1 digit */
     blksize_length = strlen("blksize") + 1 + 1 + 1;
@@ -192,11 +203,12 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   payload = (char*) p->payload;
   MEMCPY(payload+2,              fname, fname_length);
   MEMCPY(payload+2+fname_length, mode,  mode_length);
-  sprintf(payload+2+fname_length+mode_length, "tsize%c%u%c", 0, 0, 0);
+  if (tftp_state.request_tsize)
+    sprintf(payload+2+fname_length+mode_length, "tsize%c%s", 0, tsize);
   if (tftp_state.blksize)
     sprintf(payload+2+fname_length+mode_length+tsize_length, "blksize%c%d", 0, tftp_state.blksize);
 
-  tftp_state.wait_oack = true;
+  tftp_state.wait_oack = tsize_length || blksize_length;
   ret = udp_sendto(tftp_state.upcb, p, addr, port);
   pbuf_free(p);
   return ret;
@@ -223,6 +235,16 @@ send_error(const ip_addr_t *addr, u16_t port, enum tftp_error code, const char *
   return ret;
 }
 
+static void
+send_error_and_close(const ip_addr_t *addr, u16_t port,
+                     enum tftp_error code, const char *str)
+{
+  send_error(addr, port, code, str);
+  if (tftp_state.handle != NULL)
+    tftp_state.ctx->error(tftp_state.handle, code, str, strlen(str));
+  close_handle();
+}
+
 static err_t
 send_ack(const ip_addr_t *addr, u16_t port, u16_t blknum)
 {
@@ -268,6 +290,7 @@ resend_data(const ip_addr_t *addr, u16_t port)
 static void
 send_data(const ip_addr_t *addr, u16_t port)
 {
+  u16_t size = payload_size();
   u16_t *payload;
   int ret;
 
@@ -275,17 +298,17 @@ send_data(const ip_addr_t *addr, u16_t port)
     pbuf_free(tftp_state.last_data);
   }
 
-  tftp_state.last_data = init_packet(TFTP_DATA, tftp_state.blknum, TFTP_DEFAULT_BLOCK_SIZE);
+  tftp_state.last_data = init_packet(TFTP_DATA, tftp_state.blknum, size);
   if (tftp_state.last_data == NULL) {
     return;
   }
 
   payload = (u16_t *) tftp_state.last_data->payload;
 
-  ret = tftp_state.ctx->read(tftp_state.handle, &payload[2], TFTP_DEFAULT_BLOCK_SIZE);
+  ret = tftp_state.ctx->read(tftp_state.handle, &payload[2], size);
   if (ret < 0) {
-    send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "Error occurred while reading the file.");
-    close_handle();
+    send_error_and_close(addr, port, TFTP_ERROR_ACCESS_VIOLATION,
+                         "Error occurred while reading the file.");
     return;
   }
 
@@ -300,55 +323,84 @@ static u16_t payload_size(void)
   return TFTP_DEFAULT_BLOCK_SIZE;
 }
 
-/**
- * find_option() - check if OACK message contains option
- *
- * @p:		message buffer
- * @option:	option key
- * Return:	option value
- */
-static const char *
-find_option(struct pbuf *p, const char *option)
+static int
+parse_u32_option(const char *str, u32_t *value)
 {
-	const char *pos = p->payload;
-	int rem = p->len;
-
-	/*
-	 * According to RFC 2347 the OACK packet has the following format:
-	 *
-	 * +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
-	 * |  opc  |  opt1  | 0 | value1 | 0 |  optN  | 0 | valueN | 0 |
-	 * +-------+---~~---+---+---~~---+---+---~~---+---+---~~---+---+
-	 */
-
-	/* Skip opc */
-	pos += 2;
-	rem -= 2;
-	if (rem <= 0)
-		return NULL;
-
-	for (;;) {
-		int len;
-		int diff;
-
-		len = strnlen(pos, rem) + 1;
-		if (rem < len)
-			break;
-		diff = strcmp(pos, option);
-		/* Skip option */
-		pos += len;
-		rem -= len;
-		len = strnlen(pos, rem) + 1;
-		if (rem < len)
-			break;
-		if (!diff)
-			return pos;
-		/* Skip value */
-		pos += len;
-		rem -= len;
-	}
-
-	return NULL;
+  u32_t result = 0;
+
+  if (*str == '\0')
+    return 0;
+
+  while (*str != '\0') {
+    u8_t digit;
+
+    if ((*str < '0') || (*str > '9'))
+      return 0;
+    digit = (u8_t)(*str - '0');
+    if (result > (LWIP_UINT32_MAX - digit) / 10)
+      return 0;
+    result = result * 10 + digit;
+    str++;
+  }
+
+  *value = result;
+  return 1;
+}
+
+/* Read a complete NUL-terminated field, including across chained pbufs. */
+static int
+read_option_field(struct pbuf *p, u16_t *offset, char *field, size_t size)
+{
+  const char nul = 0;
+  u16_t end = pbuf_memfind(p, &nul, 1, *offset);
+  u16_t len;
+
+  if ((end == 0xffff) || (end <= *offset))
+    return 0;
+  len = (u16_t)(end - *offset + 1);
+  if (len > size)
+    return 0;
+  pbuf_copy_partial(p, field, len, *offset);
+  *offset = (u16_t)(end + 1);
+  return 1;
+}
+
+static int
+parse_oack(struct pbuf *p, u32_t *blksize, u32_t *tsize)
+{
+  u16_t offset = 2;
+  unsigned int seen = 0;
+
+  *blksize = 0;
+  *tsize = 0;
+  while (offset < p->tot_len) {
+    char option[16], value[11];
+    u32_t number;
+
+    if (!read_option_field(p, &offset, option, sizeof(option)) ||
+        !read_option_field(p, &offset, value, sizeof(value)) ||
+        !parse_u32_option(value, &number))
+      return 0;
+
+    if (!lwip_stricmp(option, "blksize")) {
+      if ((seen & 1) || !tftp_state.blksize || (number < 8) ||
+          (number > 65464) || (number > tftp_state.blksize))
+        return 0;
+      seen |= 1;
+      *blksize = number;
+    } else if (!lwip_stricmp(option, "tsize")) {
+      if ((seen & 2) || !tftp_state.request_tsize ||
+          ((tftp_state.mode_write == 0) && (number != tftp_state.tsize)))
+        return 0;
+      seen |= 2;
+      *tsize = number;
+    } else {
+      /* RFC 2347 forbids acknowledging an option we did not request. */
+      return 0;
+    }
+  }
+
+  return seen != 0;
 }
 
 static void
@@ -460,25 +512,16 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
          * default block size.
          */
         tftp_state.tsize = 0;
+        tftp_state.blksize = 0;
         tftp_state.wait_oack = false;
-
-        if (tftp_state.blksize) {
-          /*
-           * Data received while we are expecting an OACK for our blksize option.
-           * This means the server doesn't support it, let's switch back to the
-           * default block size.
-           */
-          tftp_state.blksize = 0;
-          tftp_state.wait_oack = false;
-        }
       }
       if (blknum == tftp_state.blknum) {
         pbuf_remove_header(p, TFTP_HEADER_LENGTH);
 
         ret = tftp_state.ctx->write(tftp_state.handle, p);
         if (ret < 0) {
-          send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "error writing file");
-          close_handle();
+          send_error_and_close(addr, port, TFTP_ERROR_ACCESS_VIOLATION,
+                               "error writing file");
         } else {
           send_ack(addr, port, blknum);
         }
@@ -512,6 +555,11 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
 
       blknum = lwip_ntohs(sbuf[1]);
+      if ((blknum == 0) && (tftp_state.blknum == 0) && tftp_state.wait_oack) {
+        /* The server ignored the options in our write request. */
+        tftp_state.blksize = 0;
+        tftp_state.wait_oack = false;
+      }
       if (blknum != tftp_state.blknum) {
         send_error(addr, port, TFTP_ERROR_UNKNOWN_TRFR_ID, "Wrong block number");
         break;
@@ -520,7 +568,7 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       lastpkt = 0;
 
       if (tftp_state.last_data != NULL) {
-        lastpkt = tftp_state.last_data->tot_len != (TFTP_DEFAULT_BLOCK_SIZE + TFTP_HEADER_LENGTH);
+        lastpkt = tftp_state.last_data->tot_len != (payload_size() + TFTP_HEADER_LENGTH);
       }
 
       if (!lastpkt) {
@@ -540,32 +588,28 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
       }
       break;
     case PP_HTONS(TFTP_OACK): {
-      const char *blksizeoptval = find_option(p, "blksize");
-      const char *tsizeoptval = find_option(p, "tsize");
-      u16_t srv_blksize = 0;
+      u32_t srv_blksize = 0;
       u32_t srv_tsize = 0;
-      tftp_state.wait_oack = false;
-      if (blksizeoptval) {
-	if (!tftp_state.blksize) {
-	  /* We did not request this option */
-          send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "blksize unexpected");
-	}
-	srv_blksize = atoi(blksizeoptval);
-	if (srv_blksize <= 0 || srv_blksize > tftp_state.blksize) {
-	  send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "Invalid blksize");
-	}
-	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting blksize=%d\n", srv_blksize));
-	tftp_state.blksize = srv_blksize;
+
+      if (tftp_state.handle == NULL) {
+        send_error(addr, port, TFTP_ERROR_ACCESS_VIOLATION, "No connection");
+        break;
       }
-      if (tsizeoptval) {
-	srv_tsize = atoi(tsizeoptval);
-	if (srv_tsize <= 0) {
-	  srv_tsize = 0; /* tsize is optional */
-	}
-	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting tsize=%d\n", srv_tsize));
-	tftp_state.tsize = srv_tsize;
+      if (!parse_oack(p, &srv_blksize, &srv_tsize)) {
+        send_error_and_close(addr, port, TFTP_ERROR_OPTION_NEGOTIATION,
+                             "Invalid OACK");
+        break;
+      }
+      tftp_state.wait_oack = false;
+      /* Publish only after validating the entire option list. */
+      tftp_state.blksize = (u16_t)srv_blksize;
+      tftp_state.tsize = srv_tsize;
+      if (tftp_state.mode_write == 0) {
+        tftp_state.blknum = 1;
+        send_data(addr, port);
+      } else {
+        send_ack(addr, port, 0);
       }
-      send_ack(addr, port, 0);
       break;
     }
     default:
@@ -696,8 +740,18 @@ tftp_client_get_tsize(void)
 void
 tftp_client_set_blksize(u16_t blksize)
 {
-  if (blksize != TFTP_DEFAULT_BLOCK_SIZE)
-    tftp_state.blksize = blksize;
+  tftp_state.blksize = blksize == TFTP_DEFAULT_BLOCK_SIZE ? 0 : blksize;
+}
+
+/** @ingroup tftp
+ * Set the transfer size advertised by a TFTP write request.
+ * @param tsize Transfer size in bytes
+ */
+void
+tftp_client_set_tsize(u32_t tsize)
+{
+  tftp_state.put_tsize = tsize;
+  tftp_state.put_tsize_set = true;
 }
 
 /** @ingroup tftp
@@ -750,6 +804,8 @@ tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enu
   tftp_state.handle = handle;
   tftp_state.blknum = 1;
   tftp_state.mode_write = 1; /* We want to receive data */
+  tftp_state.tsize = 0;
+  tftp_state.request_tsize = true;
   return start_send_requests(addr, port, TFTP_RRQ, fname, mode);
 }
 
@@ -761,8 +817,10 @@ tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enu
   LWIP_ERROR("tftp_put: invalid mode", mode <= TFTP_MODE_BINARY, return ERR_VAL);
 
   tftp_state.handle = handle;
-  tftp_state.blknum = 1;
+  tftp_state.blknum = 0;
   tftp_state.mode_write = 0; /* We want to send data */
+  tftp_state.tsize = tftp_state.put_tsize;
+  tftp_state.request_tsize = tftp_state.put_tsize_set;
   return start_send_requests(addr, port, TFTP_WRQ, fname, mode);
 }
 
diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
index 78de50f4924..17fdbb47e4f 100644
--- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
+++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
@@ -45,6 +45,7 @@ enum tftp_transfer_mode {
 
 err_t tftp_init_client(const struct tftp_context* ctx);
 void tftp_client_set_blksize(u16_t blksize);
+void tftp_client_set_tsize(u32_t tsize);
 u32_t tftp_client_get_tsize(void);
 err_t tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
 err_t tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
index 48c6eb7022a..a88073865c1 100644
--- a/net/lwip/tftp.c
+++ b/net/lwip/tftp.c
@@ -122,6 +122,9 @@ static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
 
 	if (!IS_ENABLED(CONFIG_CMD_TFTPSRV) || !ctx || !is_write)
 		return NULL;
+	/* The command may still be draining its final receive batch. */
+	if (ctx->done != NOT_DONE)
+		return NULL;
 
 	ctx->wrq_accepted = true;
 	ctx->start_time = get_timer(0);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa932..f35f45e084d 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -61,6 +61,9 @@ endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_BOOTP),yy)
 obj-y += lwip_bootp.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_CMD_TFTPBOOT),yy)
+obj-y += lwip_tftp.o
+endif
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
 obj-y += netconsole.o
 endif
diff --git a/test/dm/lwip_tftp.c b/test/dm/lwip_tftp.c
new file mode 100644
index 00000000000..af4d6564929
--- /dev/null
+++ b/test/dm/lwip_tftp.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <dm.h>
+#include <env.h>
+#include <malloc.h>
+#include <net.h>
+#include <time.h>
+#include <asm/unaligned.h>
+#include <dm/test.h>
+#include <lwip/apps/tftp_client.h>
+#include <lwip/apps/tftp_server.h>
+#include <lwip/timeouts.h>
+#include <lwip/udp.h>
+#include <test/ut.h>
+
+struct tftp_protocol_test {
+	ip_addr_t server;
+	u16 port;
+	u16 opcode;
+	u16 block;
+	unsigned int sent;
+	unsigned int closed;
+	unsigned int written;
+	int error;
+	bool initialized;
+};
+
+static struct tftp_protocol_test *tftp_test_active;
+
+/* Capture IP output without depending on ARP or a real TFTP server. */
+static err_t tftp_test_output(struct netif *netif, struct pbuf *p,
+			      const ip4_addr_t *addr)
+{
+	struct tftp_protocol_test *test = tftp_test_active;
+	u8 packet[IP_UDP_HDR_SIZE + 4];
+
+	pbuf_copy_partial(p, packet, sizeof(packet), 0);
+	test->port = get_unaligned_be16(packet + IP_HDR_SIZE);
+	test->opcode = get_unaligned_be16(packet + IP_UDP_HDR_SIZE);
+	test->block = get_unaligned_be16(packet + IP_UDP_HDR_SIZE + 2);
+	test->sent++;
+	return ERR_OK;
+}
+
+static void tftp_test_close(void *handle)
+{
+	struct tftp_protocol_test *test = handle;
+
+	test->closed++;
+}
+
+static int tftp_test_read(void *handle, void *buf, int len)
+{
+	memset(buf, 0x5a, len);
+	return len;
+}
+
+static int tftp_test_write(void *handle, struct pbuf *p)
+{
+	struct tftp_protocol_test *test = handle;
+
+	test->written += p->tot_len;
+	return 0;
+}
+
+static void tftp_test_error(void *handle, int err, const char *msg, int len)
+{
+	struct tftp_protocol_test *test = handle;
+
+	test->error = err;
+}
+
+static const struct tftp_context tftp_test_callbacks = {
+	.close = tftp_test_close,
+	.read = tftp_test_read,
+	.write = tftp_test_write,
+	.error = tftp_test_error,
+};
+
+/* Deliver a UDP payload through the callback registered by the real client. */
+static int tftp_test_input(struct tftp_protocol_test *test, const void *data,
+			   unsigned int len, unsigned int split)
+{
+	struct udp_pcb *pcb;
+	struct pbuf *p, *tail;
+
+	for (pcb = udp_pcbs; pcb; pcb = pcb->next)
+		if (pcb->local_port == test->port)
+			break;
+	if (!pcb || !pcb->recv)
+		return -ENOENT;
+	if (!split)
+		split = len;
+	p = pbuf_alloc(PBUF_RAW, split, PBUF_RAM);
+	if (!p)
+		return -ENOMEM;
+	pbuf_take(p, data, split);
+	if (split < len) {
+		tail = pbuf_alloc(PBUF_RAW, len - split, PBUF_RAM);
+		if (!tail) {
+			pbuf_free(p);
+			return -ENOMEM;
+		}
+		pbuf_take(tail, data + split, len - split);
+		pbuf_cat(p, tail);
+	}
+	pcb->recv(pcb->recv_arg, pcb, p, &test->server, 1234);
+	return 0;
+}
+
+static int tftp_test_start(struct tftp_protocol_test *test, bool put)
+{
+	err_t err;
+
+	if (test->initialized)
+		tftp_cleanup();
+	memset(test, 0, sizeof(*test));
+	ipaddr_aton("1.1.2.2", &test->server);
+	err = tftp_init_client(&tftp_test_callbacks);
+	if (err)
+		return err;
+	test->initialized = true;
+	tftp_client_set_blksize(1024);
+	if (put)
+		return tftp_put(test, &test->server, 69, "file", TFTP_MODE_OCTET);
+	return tftp_get(test, &test->server, 69, "file", TFTP_MODE_OCTET);
+}
+
+static int tftp_test_oack(struct unit_test_state *uts,
+			  struct tftp_protocol_test *test)
+{
+	static const char * const invalid[] = {
+		"", "blksize", "blksize\000", "blksize\0000\000",
+		"blksize\0001025\000", "blksize\000-8\000",
+		"blksize\0004294967296\000", "unknown\0001\000",
+		"blksize\0001024\000blksize\0001024\000",
+		"blksize\0001024\000tsize", "tsize\0001\000junk\0002\000",
+	};
+	static const unsigned int lengths[] = {
+		0, 7, 8, 10, 13, 11, 19, 10, 26, 18, 15,
+	};
+	static const char valid[] = "\000\006BLKSIZE\0001024\000TSIZE\0007";
+	static const u8 data[] = { 0, 3, 0, 1, 'a', 'b', 'c' };
+	u8 packet[64] = { 0, 6 };
+	int i, split;
+
+	for (i = 0; i < ARRAY_SIZE(invalid); i++) {
+		ut_assertok(tftp_test_start(test, false));
+		memcpy(packet + 2, invalid[i], lengths[i]);
+		ut_assertok(tftp_test_input(test, packet, lengths[i] + 2, 0));
+		ut_asserteq(8, test->error);
+		ut_asserteq(1, test->closed);
+		ut_asserteq(5, test->opcode);
+	}
+	for (split = 0; split < 2; split++) {
+		ut_assertok(tftp_test_start(test, false));
+		ut_assertok(tftp_test_input(test, valid, sizeof(valid), split ? 5 : 0));
+		ut_asserteq(0, test->error);
+		ut_asserteq(4, test->opcode);
+		ut_asserteq(0, test->block);
+		ut_asserteq(7, tftp_client_get_tsize());
+		ut_assertok(tftp_test_input(test, data, sizeof(data), 0));
+		ut_asserteq(3, test->written);
+		ut_asserteq(1, test->closed);
+	}
+	/* A write request without tsize must reject an unsolicited tsize. */
+	ut_assertok(tftp_test_start(test, true));
+	ut_assertok(tftp_test_input(test, valid, sizeof(valid), 0));
+	ut_asserteq(8, test->error);
+	return 0;
+}
+
+static int dm_test_lwip_tftp_protocol(struct unit_test_state *uts)
+{
+	static const char * const vars[] = { "ethact", "ipaddr", "netmask" };
+	struct tftp_protocol_test test = {};
+	struct net_lwip_ctx net = {};
+	char *saved[ARRAY_SIZE(vars)] = {};
+	netif_output_fn output;
+	int i, ret = -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(vars); i++) {
+		const char *value = env_get(vars[i]);
+
+		if (value) {
+			saved[i] = strdup(value);
+			if (!saved[i])
+				goto free_env;
+		}
+	}
+	if (env_set("ethact", "eth@10002000") || env_set("ipaddr", "1.1.2.3") ||
+	    env_set("netmask", "255.255.255.0"))
+		goto restore_env;
+	ret = net_lwip_start(&net, NET_LWIP_ADDR_ENV_STRICT);
+	if (ret)
+		goto restore_env;
+	output = net.netif->output;
+	net.netif->output = tftp_test_output;
+	tftp_test_active = &test;
+	ret = tftp_test_oack(uts, &test);
+	if (test.initialized)
+		tftp_cleanup();
+	net.netif->output = output;
+	tftp_test_active = NULL;
+	net_lwip_stop(&net);
+restore_env:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		if (env_set(vars[i], saved[i]))
+			ret = -EINVAL;
+free_env:
+	for (i = 0; i < ARRAY_SIZE(vars); i++)
+		free(saved[i]);
+	return ret;
+}
+DM_TEST(dm_test_lwip_tftp_protocol, UTF_SCAN_FDT);

-- 
2.53.0

