Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F23EE6748C
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 23:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CABB88B4B;
	Fri,  1 Nov 2024 00:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="SyWGSkGH";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nM3X3k2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B186788E41; Fri,  1 Nov 2024 00:07:58 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6E388B4B
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 00:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id ED3411140113;
 Thu, 31 Oct 2024 19:07:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Thu, 31 Oct 2024 19:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1730416075;
 x=1730502475; bh=kEchIUafgS/31Ijymf70JYqt+JFrUnc3WJSAQLh1VvI=; b=
 SyWGSkGHJwoHZIZ1o+vfsdeXr5ill7+lqRPy09jMy2BZ+Gh0rMvpkMHv/+NB2rj1
 imqINBP0+7kmCirQOEJ/Gaq1yhX5AwuJnZGe9YBVslY0YOWI0crekXWISB5mHI0F
 wGc3rLqEH8ACrweM4GHTJGX+wY99zojIhcaTq/qy3xwEk9RQg116qT7XNegiw06Z
 E8uEjsk1az7g1W82xjN3ag2v5Ekyw+Jpj4k33I8raYM1DxKfMj+hTsOH3Wh5vLj3
 3fI34BYzwyna6Asmza/Cl3dXXNjyvDs4CsndYoow0tDYV8QXSm+HjnU7xKAQ5aBD
 NYaeGgZK9MA06wz1RPfbiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730416075; x=
 1730502475; bh=kEchIUafgS/31Ijymf70JYqt+JFrUnc3WJSAQLh1VvI=; b=n
 M3X3k2lmJv97qe2hazwnDEYDTk4qDsyOucIfWjlAVO7d4CWgIWWf/hYBB37X/rC1
 3iib3AoKDDFhUHL2irzU0VADXxItaGXyjvxF1RXlLOyr47J7GU+fXTSM3u8B55oZ
 HLPpUzLbnIPCZBNe4plMwMbhk07N6wbJVT51BtWcE+jG/e2eSDs5oAQ9SiIkcgdq
 U0zzx8vdyNSPBzL+2KZwbykT3ITXpFqD8dKusza7zebS0eaPW7VCjYhzrmtunGPR
 jpwj2USSKx0jRFKKgfpqfUHYOOQ9VuRdBsSjKoc5d1q/tGxbZHvHQQcBnNB4AHQJ
 ATdZNXo8zQWy/F7RK1wHQ==
X-ME-Sender: <xms:yw0kZ2_I_ar2yGHwjAllocjlRQzbOu4ml1MbhakLkHnbFje0gsvPnA>
 <xme:yw0kZ2stbCDAm4xlC1d3JQYsI_zP8zfRYU7Lv8HIvymKZPJRzJ7GmK8w8SUphlVTf
 oTyCXP1SqomaD5YHWU>
X-ME-Received: <xmr:yw0kZ8DQ4Z6t1Fpp-w06Mx4YHQpBOITsdHAw-V9VBstDkff3ZJgtOw01aNmvo-rThI9vlsPckKqadvedcTmud6NsxbmdK749whI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
 necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
 cuggftrfgrthhtvghrnhepfeehheeileduffehteeihfdvtdelffdutdeludduiedutedv
 feffheekhefgtedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrgh
 dprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopeig
 hihprhhonhdrghhlphhksehgmhigrdguvgdprhgtphhtthhopehilhhirghsrdgrphgrlh
 houghimhgrsheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuhdqsghoohhtsehlihhs
 thhsrdguvghngidruggvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:yw0kZ-fNlb10hOsHGVbPTtD4gJbFns0gAwRtmYicaiOFaZEc0tv3zw>
 <xmx:yw0kZ7P5_a7tm0U6ELhzxUyb5csDf5D5CTeAunZtEUq_0cUY4yLuYQ>
 <xmx:yw0kZ4m_ZJwfQ-WrbwodvZkdlDtdNNH3GUfPoh7MaFc-qEOSWfmImA>
 <xmx:yw0kZ9s05O1x_DkZsTOi6us9TisCFQcQ3kTMTAy6BWPJky0texmBTw>
 <xmx:yw0kZ3AnuoOhCvgpgR1yRfO7iZCgkXzxpQ1HDkrVjKYpjAuYR7j1RGeg>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Oct 2024 19:07:55 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 31 Oct 2024 23:48:01 +0100
Subject: [PATCH 1/2] iommu: apple: Mark device with DM_FLAG_VITAL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iommu_apple_dart_ordering-v1-1-8a6877946d6b@jannau.net>
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
In-Reply-To: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=j@jannau.net; s=yk2024; 
 h=from:subject:message-id;
 bh=o6/ydQvdIL4GWcVP71wxj8fmo69Vd7glyPbsL7FLNVg=; 
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnQVToUzRxWrtz6NPyy473Y564xLrVvemPMlbqryPvb93
 KXtEbrbOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEyEYQsjw8oTr0OaWaK9tAyO
 MS9y/+lUuFCpOfPRQq+MGNW5U7xnhjAytLn5JXKXGHsGTmVPevmoKV7uitdMi6n/lpvWJG+2WKP
 MAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

Avoids NULL pointer dereferences in apple_dart_unmap when the iommu
device is removed before its user. U-boot's device model does not track
dependencies between devices.
Observed on a M1 Ultra Mac Studio with v2024.10.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple_dart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 611ac7cd6deb4fccd45ccfe8cbb9b3e36e2af753..9df174f32d721c39079e65736c91e3e27a72ace2 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -312,5 +312,5 @@ U_BOOT_DRIVER(apple_dart) = {
 	.ops = &apple_dart_ops,
 	.probe = apple_dart_probe,
 	.remove = apple_dart_remove,
-	.flags	= DM_FLAG_OS_PREPARE
+	.flags	= DM_FLAG_OS_PREPARE | DM_FLAG_VITAL
 };

-- 
2.47.0

