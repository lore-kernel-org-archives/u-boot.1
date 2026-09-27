Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF52C98332
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2AE581028;
	Sun, 27 Sep 2026 15:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zn93ut8YbnGw; Sun, 27 Sep 2026 15:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD05481016
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521557;
	b=keeDGZHmDP3R5viHOAl1RGR1WUyGKKYYkqlCYGAkkCVg4gX33k+0YAeDiGnNyo8t+S0C
	 3rxC7ReTo3iNKh77TXtESatER4VN8nFN0M047X4c4Ryi6Tzumz4mgUpjAFElevsfgHyPZ
	 V20GHJB4zcapBck12kJwDaee3WmRfyNmeucSaKTFVDF9AnjGIS6/BsbX2ih6+MIAuMqTf
	 RdMuuMjNjJq9u4SwJ+iAuNT67W4LzKfu3hLlYnhQj/dgupaWRhZ5Z76VmBq3utDknhEUc
	 wnMMvNadRtA0hHZXV2r4AxbC9hdefqzYmT9AbLpTohy29qkeyYG/M0y1yqu7tc9MHcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
	b=BFqo+iMjxPaagjnDwcH1AvBbexF4fi7Xjo1tO1PBj+XvYSGTHNtKCba8FnHf57pjtoZY
	 NIzfYX0tf10x5TMA45hzeUXQdx38+x9/L07VcXh1XWbuaj2Y8POm0580383YkjrUl/exB
	 bpz5CmMG5/i2gqkDlSThRAH0wri6asSt4b6idOi8oG/1uq+7CireMvKKxFttOKm74XQVd
	 yXAmTuaStiMA2dnkunZzg2226UAxpbETbETirbVRiHt+ZmSGTg7+ieQ5O39XCUvZ9Ukee
	 zqwFE9pSVONJlHwPS4V1lUncUqfKOEv0Y5s0sbFO8krEnZpMLv69WVBjjbUL4P0ThdA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521557;
	bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AfuxTqGbI/XE/u2NFx70yiRPq6p6rC1fEUosReuJJwBu6Sg+0eFliCsxqNvTX4cCR
	 0P6G4lzOZwj4OykwwEU6YSP7y5o6fQ8N/r6kWzIfml/Il5dGitx9Ar1cqCU5m5UMA5
	 O7vmxqliWZ5QHYQKGaZREqO56ICkSIz/kCyuYX0MAZpSF9FilHGNMfhBDNH0WLOiOo
	 P06TmzSl5MFyVfDLJlHZXIou/X4IQ5jVwK4y4Ezgh/0bShd6rK/irVCTGjNQhvqR9q
	 TWfGRIMUqphg99jcb7nrQ4RSMb6nRuYAuuAnD0toUhGp4FvmCRDBwSOdQocmCh8Bgn
	 uIyBgfVt8/dow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD05481016;
	Sun, 27 Sep 2026 15:05:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 912514B8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 757C760624
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pyZ2wXLBqibC for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 13:36:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B4C106061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790516206;
 b=KGKCi2qlideEvuYyzh+iL3axu8t6xeZ109IOqmWFwxdQfvFKqQPJ213flmDO59N5H+Fw
 fxNA9zNB/kuOHdqtaMjBj1V1PG0qQ4LAvqQ3VeKY4ILItiDC6fEzgj0Q4bLr+d/4GGBf5
 waINsxjLEEIcpNgO/7HfkJmSF2T29r/DZ0XgH7JcGknlols8KN8H1h4oKw5SPFGQgouG8
 DOGLmtFEuhxMZBRvxuoiNTj5tl23Bn0bCnsVnJ09idSCK+GMXCrOq52xHpd4XVEabGVxJ
 N7WYJYWM8Qfu/QKZUQ5nube3+jFfmvYeGNLza54HAlp4sPJNd75UWzsdqHqPD7jzqCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790516206;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
 b=Muee9F4kPQTo6GAoDuvcRTBGNTzIoFe26UwGX8UkHo5A+Jyp2Hmw6pGD/dttjO0dvIjN
 PmKu6jdi7LR4zZNf3wyrz7v7yliKUopNOjZcNfixW3U+dPDuzkvLJvR9LKZ4+aJvPLstq
 X9WOTlaLUtrcZ37FF7QucwcBRvsQh7pGg8X6S46GWGs6oNnzw+7Weg6LUEYeW0+J2CLB0
 1NzlTe1cdjtqct64PZMC/PKQjlmzhWvsH3kU1zjxrSDE9PEvtCUxv3TNLZq01rIO5sJQB
 kfwUEQWlR3+N8NPy+y/5V4bje619kSew8tXpCDbHGzeg+fWEhYt2Ox5p3581a1Locqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=CVF+m3ba; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=CVF+m3ba
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4C106061D
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 13:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790516154; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UPSqOvRIhf/kzuCXISv0HxbGqRqu6uWUO66R3dylFLebdgbefVGiCYJJlLgyYiKEnw1eH/BMNuq8t3AaZlDjjHnFQvd3k9DLQXLGVJeqqQqwZBhsPBJ74pX3nJPWfrF6CoiN5eETODBLgarlWsWfeqDGIB0hAzDLX7wUnN3KnhU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790516154;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=; 
 b=RoV7FDnOlnZhQ6jliNBm42p90CpYt2Rw28+J0x3OfH72R81eGvw5CYsm+XDostIWa53LihKVSNzoOw4QMNlnglviSvFG7kq3euGrrFxLK+ucJFiY5Bls1+3vX2KwXb8kXhD13fLxEMl/aG3BGV9pRZlIznT9A9ve5blIQwJEke0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790516154; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=Jj8GPcgKGbo+/u95NAkT3CSduXi4fXZLPntwcCxcppc=;
 b=CVF+m3ba4io8QVZ4h/TY7X6gFwW7p0vRQj1qcxgxec83ivrzvESWq2BGPADpl3Ze
 tBkdCeI+zGyrzwAWED52CcNyla1TcMruRxp4iu9ukE92rdi7/m5mtayFwEGQznaNYwO
 /f76z35qgIT4YNF3TAC/h7xQ8NTGYdduzhzBIdiY=
Received: by smtp.zohomail.com with SMTPS id 1790516153171391.58695496573876; 
 Sun, 27 Sep 2026 06:35:53 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sun, 27 Sep 2026 19:45:57 +0800
Subject: [PATCH v5 07/10] riscv: licheerv_nano: Use upstream devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-milkv-duo-upstream-dts-v5-7-f95d9173b7e3@zohomail.com>
References: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
In-Reply-To: <20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Guodong Xu <guodong@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112273e1a6bc23bc77684d1fddfcb00009359b88abf67c97de6508f0a246c478cf164167779e3d74777:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 27 Sep 2026 15:05:55 +0000
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

Switch LicheeRV Nano to the upstream SG2002 devicetree by enabling
CONFIG_OF_UPSTREAM and selecting sophgo/sg2002-licheerv-nano-b.

The SG2002 clock and MMC compatible strings used by the upstream
devicetree are now supported by the existing U-Boot drivers.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 configs/sipeed_licheerv_nano_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 9aa3ede10c5..21b8fece201 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -4,7 +4,8 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
-CONFIG_DEFAULT_DEVICE_TREE="sg2002-licheerv-nano-b"
+CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2002-licheerv-nano-b"
+CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="licheerv_nano"
 CONFIG_TARGET_LICHEERV_NANO=y

-- 
2.55.0
