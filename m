Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5769F606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pN5qp9wR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRN6USLp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 283496061F;
	Sun, 22 Nov 2026 02:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ljd1-w7BkYXb; Sun, 22 Nov 2026 02:34:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C37560697
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795314877;
	b=s89c/kxYNQ9jkRhXiCvve8iRgPkgrYUtkrbTPcEgi62MUf/vpBLoqdMYTWSzpaStPtyy
	 XOCgg4phyybcmlXm+4nGhPKkmyplRXS1VIz3SC2Sgr/+s0LUXlwXMQCY+eAI0N6XJM9z/
	 K/zUW1v613svYyV+kQpfCm0TovPkV+04ypyCjh8th28xo3x3vtkS+yt8PNhxrVjwzZCTt
	 f40lo/ZP/sn3VvwOACrH8TA9G/70mPrZ+QAaxaTQRKBuk6cwaEJ3tsGDedAHo8o6oPs2z
	 NMIXQdCE9xybkO8Xdo2JcMNKZVd90b0nY/vvozelEfsgJYNAu3RGSozMNNt0WdT0Fdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795314877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3HIIDodZ8X7uw6oSYvAQAsr2xXKQVK4nG1NRExy+n2Y=;
	b=JsJDvO3gSIp2JD0+duORfrmE7rsdSg3uGTG1tAhu3y2GAHlQgAeGwDcG0Qns1w5YKAn6
	 NYn7g3OEf3BiThxfMKtk+SfUmIAYnxezf6SEmDLLv88+Hm4Kd6XvUAnDg/we5d2bEAwX3
	 /KV71IzD+TEIbwG1MxN8KpUAp7DPZN7Ue4+MtwJHlaAKBhqc/9sho12st6WHgynDimYh0
	 Rv2VO7cAs/VWeM7e6W6VT8vkKJxcwLYdwJme547GZphMNKF5j9nPLzINooB3WyG+QNqOa
	 g9z6wK9ny7Or9KvC25F6a2hRRPVv5qrOHhICkjUT17rmo2SABEpSb2T8EJmwSh9CypA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795314877;
	bh=3HIIDodZ8X7uw6oSYvAQAsr2xXKQVK4nG1NRExy+n2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pN5qp9wR8sk8CplgGTrV1D6jiJ1UKnT0DE4sT8lHtY/7jb5wVjEB6yA7wRnQdM/Cn
	 daJlDdklqHS51g4BNTxoyTceJKrlF1z4qcnJXBA/7fszfE4Mi65L6dmIkUXNpboLev
	 i+aXWeTmdadENI1O/dFkMWj4b2imHiiGRToNoDQgEL3BmcvgIQfCrzWvMKRMQtc+Gb
	 r7qgdyVTSpBeFuY0+27s3nwQQYBofwGUG3i+YUk9vqu+NcQyh9IEbPzBn9xXiujKHO
	 6PEXxraOhSb0Qq0v9yTELZlkE+dhHkOr0evXFjKzCvr72bkXhSty5AoiGwaE3BdF4i
	 uMwLaLl9tst9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C37560697;
	Sun, 22 Nov 2026 02:34:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 514BB79D
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42F3680AE6
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1x5FMKkziKXF for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 02:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF3B680AC8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lRN6USLp
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF3B680AC8
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA71541B20;
 Sun, 22 Nov 2026 02:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C531F000C0;
 Sun, 22 Nov 2026 02:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795314874;
 bh=3HIIDodZ8X7uw6oSYvAQAsr2xXKQVK4nG1NRExy+n2Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lRN6USLpIA7BHtbshrQ4kqH3sAf6pSH2rAU7Zsmw+rezsSbxHdXOZIQT7rMA8VM+2
 Ao+xMJiZqqLWvMEPz2RndaJxD6+355rxL6si5ofaV87k8pxA/JT1ZDSm6Zmf7bw+Ma
 PLd2cauxPpQBNY6eml41ENP2HZ1VxhYyBjUd7+vz3x5idyDgxzE9sh/tx/WpSh4GDI
 KDnxBtMkPBaQI/5ZzF2lQ8wwTj6bi/D5rN+vXbBrmymR42NCSAdHPL56uzDcOv5oDn
 ABDuUQLhutxS8+6qXghgWnuuB2nIHbKn6OsGcmHHHHEvanhM1KTl4Oxaak12gWJUGN
 A4B4stSA813Ig==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 22 Nov 2026 02:34:09 +0000
Subject: [PATCH 1/5] riscv: spacemit: k3: Allocate SPL FIT load buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-06-spacemit-k3-spl-nor-v1-1-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=699; i=dlan@kernel.org;
 h=from:subject:message-id; bh=Rqfx3sc4EeGwQOcDPLOl3mU4pE6dqbvoTNPmfKqlC94=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAlSn0dsGkik+aNUPsTp50VIAZAwvJu/xFkYQb
 I7sbHhe1vGJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawJUpxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0X3BAAgKLm037b5ENA+H30HVqfguo2TDo6BPsT53C8HZ7zMwwrAl6F0TlAo
 VTOQTUsXTFkudpxfEtAJ1nPRQ43JFaqfaxjAmvlkuS1/Q/C0azlwRW+d+iopI47wruZZdbeTHYv
 5bxJMnbbr5P+h2lkvkt/q+9KG+lh9pu0nCb0yTqYPbCmTM55BLcci6Wgx7mpdE1NS5MC39Vi7zh
 LgLjJLFUUoSlsHZp3X0KG5re9OrocFhJRbQfirdbIO2niHLS3cvTt8p+dU9fDCD5GBofPmDOWfp
 GdUKYoiVzP0mvRtHscbmUIQdCzgmXmFVYyt136ecI1RuLd3kWNKATU9JmeLuha395ZslRCj9oa3
 0ROJa5kAx17gmY1l+KMFPxOK1S+n/secPrNRTc5ZFrx3hHRMgk5klPMYcUnRZImTxROicrM8rpK
 dRRuNBr4UIz7rPC/ILpvcnSr2VPYIdWpemufqa/Dp45LWwRZT/rM58/P8/J5ovacft5iS5tUSVY
 5OdE6M4mkzIXAN4On0Y1b0PkiOhVk0DM4cNHQPkFMxwuQMqf+xtSzywvEHi2FSCrK7tthTiyuqo
 Sn08yhJ9/013TRMua5Q/Ud82SpYQz1tpA9dEjxqCPtLnLFboKwDqrGEGFEQ7/dmijJI26jIvYd+
 LpAbzJ4MkEOaemWyPLE4Dbm9TdK/RE=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memory required for SPL FIT load staging buffer is quite large,
which close to 1070 KB, allocate a dedicated address for it, so it
won't consume memory space from SPL heap.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 board/spacemit/k3/spl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/spacemit/k3/spl.c b/board/spacemit/k3/spl.c
index 4798e5c9ebc..250e91b93a8 100644
--- a/board/spacemit/k3/spl.c
+++ b/board/spacemit/k3/spl.c
@@ -125,3 +125,8 @@ u32 spl_boot_device(void)
 {
 	return BOOT_DEVICE_NONE;
 }
+
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+}

-- 
2.56.0

