Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA24606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XwFTD5DJ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HH4o0apy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A4C160787;
	Sun, 22 Nov 2026 02:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxjx87M-E_xb; Sun, 22 Nov 2026 02:34:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 581B76076F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795314884;
	b=qC+vEjmlFOrdolIQcKZz7hjcwukVmWf0bLFCwj0e+RZDRhgmDOvlcoco6dSZZbefHcbI
	 0DKxmWskCE1ivFtKup0pyR31oAJK/9r4ehlL16+jmlHZhqMBCKGTRYoV+K9MQbx6a/glx
	 Jv/vrJub3wkX/kLDXAcm6Y3soQuO+oP73relIPxp9wrQEAkMZZR7VdjeOMPM35a9ctwJa
	 iiWHqrsWnYOioiuOy1mS9lP39idyAD+rhvYSD966VYUuOjWYvjN0FcJYyO0wU6W7F3x1k
	 AjQcqBRKMXqsrJHNSwKrDBR788m9Sia2L4zN0mboF3rsdkdoPkhbQ6TGvgIvXptSbWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795314884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6NE0KzXf13vZ0vkpJ3bssz/U+lPNsRQ6YnPEQxomP4g=;
	b=jBTADskur0qn2I6fWNgSM5A6AATguZbcAqilGoc98y/ksWHs2XItJEpbW1EWkkKpuVp7
	 U6iBkFItpipXeUuWtCSUwGh4iS5GJXo5Z5OkP19aeSS3OAq2LKMH2IRNQgSLnCt+WEKDc
	 Mi9xgnHzyHR+IwFXkG6KhX/7qn82LMJZBRtUAycUPu99zorqrfIPcrYt5Oo2EgUwTuQfB
	 l0qGc+ooPvavBHvg7R1dcr/Od0EuUs37DqZ/D7Jfiz6tU+37+JLtWPo0sdPiq/eKdQpWj
	 6XBP71fsufVf8WMFwKdsZgYfrOY0ey9ViCE4ZHWPKjg43ShDzIlX0Or4IzpIF5ZwOCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795314884;
	bh=6NE0KzXf13vZ0vkpJ3bssz/U+lPNsRQ6YnPEQxomP4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XwFTD5DJomqC3hzPAb4GQWnSOtsPrlhrpHD9yNRWvuIN5RqWCmbwqvnkqyaT4vwQ9
	 1xa7kknEhg6Q29b1asfGQeoVByiQwcds6Q4yzNhZ5Z81AVw9erlnrL3IFL/JMV3Che
	 a6WIo8EMgxC8VXBYdeFafiX8SWge9ClLIQ//CVnRte2aIDRctE4mbafEDmElkAtf7X
	 stbqe1VeCSV1t/QXOcDge3gdFn48mCIDmuYKCdAKJ8K82plSt3slkgz7dUyRu2bR94
	 uLioQ0enEJr0G/sKAfqH9UCf8Yluy8GXC7+FGHifM3dqfYMbD/H7QHxB0K80sWQMMn
	 fijcU9Z+CkUhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 581B76076F;
	Sun, 22 Nov 2026 02:34:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3D5A260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D105D40185
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DV5qE7v0ogC1 for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 02:34:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 97F8940012
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=HH4o0apy
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 97F8940012
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 02:34:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83C8160625;
 Sun, 22 Nov 2026 02:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FFF1F000C0;
 Sun, 22 Nov 2026 02:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795314879;
 bh=6NE0KzXf13vZ0vkpJ3bssz/U+lPNsRQ6YnPEQxomP4g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HH4o0apyfHAMFhkYvVCfEILt913i4j+O+pehtjhpiwcD88wvmcDEdxb56RA9OQ6ON
 qFE9QnotcbRDf3Lw6QC9IWLfcHRpK2NKIEYw41xzCBbCtcIZKTUALbyLQ21NOnGsqf
 ZUSklQQOvMp0EN5YspKFa1CYWZbNcLGUgISNUu5JjzBjEoBjaZ508+9bIV2yaYBmLT
 GvMsIhub/G6Z1528dxsW/iPw6VROB7UjONOrw4ta5NAP3OHcBJyFbtGiXdxe54/YFf
 BxLylRd//NdGrysmBvosYjyGYvIxIc3CE392OrsFnIZfmBbvy8g3Udj2na8BKRB3Rt
 yb237VqBo1X3g==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 22 Nov 2026 02:34:11 +0000
Subject: [PATCH 3/5] riscv: dts: spacemit: k3: spl: Enable various devices
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-06-spacemit-k3-spl-nor-v1-3-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=dlan@kernel.org;
 h=from:subject:message-id; bh=yzGlweHr5+mjgvUY0a5Q5caq+FhglejrdDchc/Podpg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrAlStGbA/azaDNd1XywxOVxtlmVNJQGLaU34sf
 J/ndJUQxi2JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawJUrRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+156hAAlvPQ7X9HQqpOEONd4x/YNpSSNfe2UIcBQf2xS8mA+WF958GMK2syY
 LcdmDdCWBP1OHkggS0s/sZoGM4yjxoqiSyIt6sbmHa9MbqI2iZwhttKaG8WG92aLaicW2IPsQXi
 zJ0kzN09U6i9OmvE1L51VnIJnqJ48D4bWjBVGou5vR09gr/AC2LwgpTknbksRWnNBoWVLrpNHVE
 lHJra3f4hHkakQDsd3u1FkWMfsEQbV9h0NHXFvi9XFN5iR8NGk1N7/mKBOrU+xROJIGyoLcC7zS
 YmUDOWQxsL+MoLXibPjmcG0PdUmESy3smkLYmqgP4M3i00RsPCklmfrLmy/AFQS4yddaKuXdfF6
 kN7ljNjUmOL1TLnOVk8LL74Q+KMDFLx1tWUbAQWSiFSiDZspzHj9WmLxOnHhhPLy6nHaMld+9/G
 7ZTptIIfiJb1KvlGIyUHa7vXJsXTppMfOifVxELF+7/ZjgQq+6RPUVqtoHFdoHS3JjvtcwJVlv9
 UEHBxQn7WU8E3GDJPEk1qtEKw3WhMtDtBDrcCrFmVrUe51SE6HUhyzyQjx6Lf7eSpdt/HpPipYH
 StNnWQHeTorUm/99j4qN8LunLdxpcyXo2bdgNM81oMQHj0DXYVsimgpqYJE/N+4YydCTU7ek7T1
 ctjvKTxIM8mQXVUKRtT7f5VDTj3mmk=
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add bootph-pre-ram marker to Pinctrl, I2C, Uart, QSPI for using
in SPL phase, so can configure their pins through driver model.

The SPI NOR flash is connected via QSPI controller, so enable it
in SPL for loading the next stage image.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 arch/riscv/dts/spacemit-k3-u-boot.dtsi | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
index 13ab6cba372..c41c117811c 100644
--- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
@@ -27,6 +27,14 @@
 	};
 };
 
+&i2c2_1_cfg {
+	bootph-pre-ram;
+
+	i2c2-1-pins {
+		bootph-pre-ram;
+	};
+};
+
 &osc_32k {
 	bootph-pre-ram;
 };
@@ -35,6 +43,10 @@
 	bootph-pre-ram;
 };
 
+&pinctrl {
+	bootph-pre-ram;
+};
+
 &syscon_apbc {
 	bootph-pre-ram;
 };
@@ -51,6 +63,14 @@
 	bootph-pre-ram;
 };
 
+&uart0_0_cfg {
+	bootph-pre-ram;
+
+	uart0-0-pins {
+		bootph-pre-ram;
+	};
+};
+
 &vctcxo_1m {
 	bootph-pre-ram;
 };
@@ -62,3 +82,23 @@
 &vctcxo_3m {
 	bootph-pre-ram;
 };
+
+&qspi {
+	bootph-pre-ram;
+
+	flash@0 {
+		bootph-pre-ram;
+	};
+};
+
+&qspi_cfg {
+	bootph-pre-ram;
+
+	qspi-pins {
+		bootph-pre-ram;
+	};
+
+	qspi-cs0-pins {
+		bootph-pre-ram;
+	};
+};

-- 
2.56.0

