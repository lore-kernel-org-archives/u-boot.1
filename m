Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C7AC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB7AF81B5B;
	Tue, 18 Mar 2025 13:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=msnmarket.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E5B18129F; Tue, 18 Mar 2025 10:05:48 +0100 (CET)
Received: from out0-22.static.mail.aliyun.com (out0-22.static.mail.aliyun.com
 [59.82.0.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0BB80548
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 10:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=msnmarket.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexandra@msnmarket.com
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.6870163|0.1314011;
 BR=01201311R101S63rulernew2363_292140_250212; CH=yellow; DM=|AD|false|;
 DS=CONTINUE|ham_news_journal|0.397313-0.0726044-0.530083;
 FP=9850040465365041325|1|1|147|0|-1|-1|-1;
 HT=maildocker-contentspam033037007122; MF=alexandra@msnmarket.com; NM=1; PH=DW;
 RN=229; RT=1; SR=0; TI=W4_0.2.3_v5ForWebDing_2120679A_1742288720231_o7001c92m;
Received: from WS-web
 (alexandra@msnmarket.com[W4_0.2.3_v5ForWebDing_2120679A_1742288720231_o7001c92m]
 cluster:ay29) at Tue, 18 Mar 2025 17:05:22 +0800
Date: Tue, 18 Mar 2025 17:05:22 +0800
From: "Alexandra" <alexandra@msnmarket.com>
Cc: "vicula" <vicula@163.com>
Message-ID: <e94e5ccf-eba0-4b19-8c0c-f3d427e1edf8.alexandra@msnmarket.com>
Subject: =?UTF-8?B?ZU1NQyBhbmQgVUZT?=
X-Mailer: [Alimail-Mailagent][W4_0.2.3][v5ForWebDing][Chrome]
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
x-aliyun-mail-creator: W4_0.2.3_v5ForWebDing_M3LTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEzMy4wLjAuMCBTYWZhcmkvNTM3LjM2vN
X-Mailman-Approved-At: Tue, 18 Mar 2025 13:47:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
Reply-To: Alexandra <alexandra@msnmarket.com>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

SGksCldlIHB1Ymxpc2hlZCBBIFJlcG9ydCBvbiBlTU1DIGFuZCBVRlMuClRoZSByZXBvcnQgYWxz
byBhbmFseXplcyB0aGUgY3VycmVudCBjb21wZXRpdGl2ZSBsYW5kc2NhcGUsIHdoZXJlIHNvbWUg
b2YgdGhlIG1ham9yIHBsYXllcnMgYXJlIDoKU2Ftc3VuZwpTSyBIeW5peApLSU9YSUEgQ29ycG9y
YXRpb24KV2VzdGVybiBEaWdpdGFsCk1pY3JvbiBUZWNobm9sb2d5CkxvbmdzeXMKS2luZ3N0b24g
VGVjaG5vbG9neQpCSVdJTgpQaGlzb24gRWxlY3Ryb25pY3MKU2hlbnpoZW4gVGVjaHdpbnNlbWkK
WUVFU1RPUiBNaWNyb2VsZWN0cm9uaWNzClJheXNvbiBUZWNobm9sb2d5Ckhvc2luZ2xvYmFsClNp
bGljb24gTW90aW9uIFRlY2hub2xvZ3kKU2hpY2h1YW5neWkgRWxlY3Ryb25pY3MKU01BUlQgR2xv
YmFsIEhvbGRpbmdzCllhbmd0emUgTWVtb3J5CkFEQVRBIFRlY2hub2xvZ3kKVHJhbnNjZW5kIElu
Zm9ybWF0aW9uCk1hY3Jvbml4ClN3aXNzYml0CkZsZXh4b24KQVRQIEVsZWN0cm9uaWNzCuKApuKA
pgpNb3JlIGNvbXBhbmllcyB0aGF0IG5vdCBsaXN0ZWQgaGVyZSBhcmUgYWxzbyBhdmFpbGFibGUu
CklmIHlvdSB3b3VsZCBsaWtlIHRvIGtub3cgbW9yZSBhYm91dCB0aGUgbWFudWZhY3R1cmVyLCBw
bGVhc2UgY29udGFjdCBraWtvQHZpY21hcmtldHJlc2VhcmNoLmNvbS4gV2Ugd291bGQgYmUgaGFw
cHkgdG8gc2hhcmUgdGhlIHNhbXBsZSBmb3IgeW91ciByZWZlcmVuY2UuCkJlc3QgcmVnYXJkcyAv
IE1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4gLyDmraToh7TmlazmhI8sCktpa28K
