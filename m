Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tfKEh28g;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ubLrBnG1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EF03405C6;
	Wed,  4 Nov 2026 07:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSDZA4Fi9ZXe; Wed,  4 Nov 2026 07:18:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6244A405CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776691;
	b=Pmm4pBatBmCUzGQWAxsA2TkmXIANUsJn8zG+AAolz/Bna+1guy+Kb0cre0/tEH52lsxI
	 NUyMARQo8UIv5wEYbkbU+heD9Gd9A9TqqOQxdB5bu8EosFHg7tM30bOYqDhMztlYdqSiV
	 vcqFWapk8ao1MCGArFAFXqjEpz935qbvvrRMbHF4OBmUZsTjPzMvNHbJjVtOtOSEsyqQS
	 arGipaUhdOt+/aVz95sxyMA+Tr/skPnl+PMKRLc4jfWkT/dY095+WjIrff/fEvvlpHpYk
	 sxFBkKmAJUCTujyPDZzCKwvouGI7cqmroZ4V/aQdH8WTe4eCWJpLmATHT34wYikRggQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=W5usi5u/QdGNFsHrsZO0nwM1veI+TwBoJAotQ56yr0Y=;
	b=A9KeOHKAcn5hCgl8uZ1h6vTj3Uf8pNYSOSzuHiSHmDgR5FGQHpn/hyvTQXMy3+YiIBLr
	 7ACfgN3UtU4QW+sC0550Ctmo+dr5vBs/9j6rdG/HpiCkwZ2Vv3j89qV1fH3fonmiQhUNE
	 AyI+USVdxTeNBw3tn+8o22hAKL6e5m8T4wpOnCMDW9V0DyHsxIpHuND44EeL6I+QViLht
	 +l1pKwMNH1+ovf3hzalsrLgyLIwtI5CNX+4mJCXSgthHjabW2/cOA4qs5c0osrowC/zHw
	 xlD6WFus4fs++whrNJizVNOE2eZdsKoNXG3YojNnFjCbizNIvS5axUbmtgMEIHPcplw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776691;
	bh=W5usi5u/QdGNFsHrsZO0nwM1veI+TwBoJAotQ56yr0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tfKEh28g1WxvI1Ceix83ORxQAMi98eioU6shRatOKhFmOl+N8goGeRPd0RDR7HyOt
	 hjRAWmUBZvk8cdYevjIoGVQuETpusI7c3Nw+O+rMzh1q6X4MPXbJWxXDBQgS/v0aGO
	 V/LED3NFYqvSr8qgABEek8jgdzpWwFF42YWoDXbO4zHwMYTqUSDagQjHwBjlEbHvsZ
	 W4HHrguPOsCqVFns0qQSJiUvBXKR6X9pdLq4WsoH0KPgDKfLfKWPzrWz2BA2zPEVbM
	 sV0t1fS70qQL3ShIwQOW8fOVRpR1h9jLxzRk+1g4k0A1TiW8bEg5kEIxmuUAXl4+wR
	 XrmOH+sKBmFdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6244A405CD;
	Wed,  4 Nov 2026 07:18:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8371435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9E2F40176
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FwYNag4nOHpc for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E65F64004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776689;
 b=EzCjJERifXzBoyfPYj/2I0t7hatBcHV7/eoN9CSMbtJgXnMkVaPzIykIQH2A8yKwLW4T
 e6jL46lea97xzNLNb4VLao+Wbb2XTEQQPSkKhAuuSkA2Fp5sDoO6rHdOgxcdFL+q+kpo+
 bXgbTv67Qg0tJ9nJwsDGqB4DlnkJQHgJlV2LL5OibySCpAflThRPBlnEugXLLYz8rdh5n
 59LP2Lfee/a5AFyUOKWSyRb7lPN5lUX8avcB+ucxLIwJtobVMH6TxydeAXYxQNoar2Dfq
 bb06NUFMQbmpPXEHneAI1tLnQ2NhT6jc+s2lpx20z78oQqTNtSe/O30dhk7n5O+SFjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776689;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=W5usi5u/QdGNFsHrsZO0nwM1veI+TwBoJAotQ56yr0Y=;
 b=SLSkXX8gKsY62JALhaATZmyxk4ovw236OptzLUMTrZOQNsbmMaqkfMHlROEVLD0i7eiD
 YIJwLWiRgit6kDt69Vs52KtDAQIks11TphHMGfgx5+yXTrIKUXsXmuCJx6F0XARpd4k4p
 QszX/JWjYImvOFscfr1yXFrt457JDDT3swogocrECFFp1CMeTQCEW7h/SPDtd9bpiu1UK
 noGBduGjvbrINIpy5YTQAspzfLy77PaufEa0IQk7tuhs13oQHUVUmNdtS6So/kYtm18Mi
 sgXmk5G95gemS8Mp3RFxObFbBNxvjXbWsXwpgOYuMUOxhkLfQcpl9JjnGCm6/6+6pHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ubLrBnG1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ubLrBnG1
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E65F64004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:08 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so137901f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776686; x=1794381486;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W5usi5u/QdGNFsHrsZO0nwM1veI+TwBoJAotQ56yr0Y=;
 b=ubLrBnG1JPbnT8gCWnLr6D9It6knOguHdT/vrH/kg5fmyYm04cwuPEtUonkF/0vq8n
 agKBH5Icu7CpISFLswfW+FHRwsbe3U1tA8FjIUyTZKKPNgvTdDyRtK3i6CHThNMh8fUk
 W1uJLewspYJ01xwQ2V2FrBx74sopTjHHOMh5TuZkRGhcPjtKCkMxXBX+VacZGvPtAlry
 xPPOrzcI9fHBWy857OwcNjXit+qsEKMH8KF9CWP1vgybDNCwfATSCvH0Hnyah17fPNjd
 8X0e/hZkyn2ugY3nfC+3k8htIb88kXcnrAwfk6+zjSd+Pt9aCxW77VhPNNm2ZaRxgS+C
 Q2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776686; x=1794381486;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W5usi5u/QdGNFsHrsZO0nwM1veI+TwBoJAotQ56yr0Y=;
 b=Wf4+liYg/fzTmo0u3Y1hxqDpXvKZMwGd5FDavJXzy1oClNvgPsfS3czEydVtUr54sK
 hVTVxNK8hCxdf0/kZBjda+SU6FgloNlseTYb3g3c5Q1C650FBHRrl1aWdhuBtJhaANuV
 +pra8D4251zVgDwxta/6jEWStcHqPiQH6Kap0ozjK4VEeZPqTT42x9EEPAva4gWu9+/y
 AR6rjmZoXwsq/pdW3v3XAim6VlrJYl3x07eKTI9HdjEocPWi5A1LWGpK4I+Ux5J9JgkV
 7EaZ4pQ9/yx9TdzAZ6RO00iP0SifXsWD5iTAemiq3mE3tLpFRk//Kw+THeyvwX48et+P
 tAwg==
X-Gm-Message-State: APuU4Z/1VvR/R8XDPzWIoFZNk/KB8L7UVzeenuhxvUR6Q32qEJVTY5yL
 b0fQ8QN8pT3K2MbZp/hQybQhYpDyQY4YCuwm/QvqwExP8csYGXiEggeenPD64jem4E8=
X-Gm-Gg: AYBFou1zu5My2R2cG3n7oBafAq/3lGpPCgchL0IJ8rLQ+cxhy8hi3qA46d+l0QiOpWf
 PkVOuEiSlni6JgoHs5o3ts/Pmp2MFnAnKsts1Z5cJNbHC9eH6j1S7HrDT13TRHGSbgyCu8OYiEu
 R+g9pR0mBdwuKS19FC6ZBUAmH940uYC4xIcZKC8XccCMh0UvKggIgZTOmsr+0Wijkr3mv3stFkJ
 HXMchVxzJipznyLTpRzUlbbx0UwBM9pZcO+yz+t2wOWZUbNp7ylCX7xYcuSs/HsfYW3n3eDXADz
 b5SVDSPAumP5oaEkteryZoKbAsyL+OUWbpxqXGWkyRGX2LvCB1vEjGve67gS82B6toVW7i8tnd9
 FzMqReiSBpMcih2cLnPR1IZVtQLc3AgPPm0QvX2IDfxILtPghm7SQZXycDhH4V6n7BwjAoRV7ql
 T8y9qWZ72FAjIgkNOM6Ap3dfXKktSvtE19c4OSxzht8qnAfr1ZDJn+jKcRFNvJ48FNHdVW3QTxV
 Zokz/gdOPXVy+mthm3Fw6ylxLqUZtw+TKi3snaMDUJHjlGe5XlPp2PP7pJIHvNzbogoYhUO1Gtd
 JOkojL6vro751Qi/GhTMppbxE3zEw9U=
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4ac185bc1d2mr325962555e9.26.1793776686338; 
 Tue, 03 Nov 2026 23:18:06 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ed95sm30808195e9.4.2026.11.03.23.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:18:06 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 2/6] usb: gadget: f_sdp: drop an empty data packet
Date: Wed, 04 Nov 2026 07:18:05 +0000
Message-ID: <c8ea2d0b-88cf-4499-9e80-8433e1acab6a@gmail.com>
In-Reply-To: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

sdp_rx_data_complete() takes the payload length of a report 2 packet as
req->actual - 1, one byte for the report ID. A completed transfer of
zero bytes makes that -1, which passes the dnl_bytes_remaining check as
a huge unsigned value and is then given to memcpy() as the copy length,
reading and writing far past both buffers. Whether it gets there
depends only on the stale report ID byte left in the request buffer by
the previous packet.

Drop a packet too short to carry its report ID before acting on that
byte, and wait for the next one.

Fixes: 5661f08a7144 ("usb: gadget: add SDP driver")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 drivers/usb/gadget/f_sdp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index cd2c282247a..20de9507d36 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -386,6 +386,13 @@ static void sdp_rx_data_complete(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
+	/* A report 2 packet carries at least its report ID: drop it */
+	if (req->actual < 1) {
+		if (sdp->state == SDP_STATE_RX_FILE_DATA_BUSY)
+			sdp->state = SDP_STATE_RX_FILE_DATA;
+		return;
+	}
+
 	if (report != 2) {
 		pr_err("Unexpected report %d\n", report);
 		return;
