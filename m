Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476260A3832
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VvI4qbiW;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=i6mf7vag
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 731246070F;
	Tue,  3 Nov 2026 15:01:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9cupl5iwvqpg; Tue,  3 Nov 2026 15:01:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73DC2606DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793718090;
	b=eTGGiWvM2XhUNd68I2+4t//5yS20oSQnAAUbCOSjQx8dHwywtw5QYv1ImajaJnsXniwK
	 TFlKr6h5lduB065uZv5MyZKw9AqQAGGDtWsxBh8maDJ+VuF1WfLcJt78VqLnT5/C4s4az
	 jHGg/IuJef90ChYu5XvGEK+beox9jEglk1JQcTX2hgWBGPPDNPQkQTFVsr9BEsumxeZH/
	 RF59TQi5l27Tvwk3Q7ftfoobYGYWxHmsZRa+zXXzC57KoNjg34kSdxMPA62lvbGhCs8xI
	 0ekFojoRkAjyhn2cENAcOHtDNlsutqoqQu1wKdPcNaSy9jnRJlYi2uVYON46L3imEuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793718090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1nHTvKbl8S7aFQgJvsAU3BP4lFRDosPuktNMQ7I+ojg=;
	b=IGSLVWJwjkZpiJXtYq00ca7HlUBe0+fI8N0GSKqJmS8Uby2vO25u6N3AUxZo+tynZPLs
	 Y/p1O4Hoz0hAo5owgDTD51shKv6DY411WmL8zeCrgrZbN+2GebN5ThKjttaD6M/Qh0MnV
	 Uu8qBOFZTN8qgMjeQlKkM7YZ8502SqK3XViGzLVoUSsHbdoVLrfBAlKdym8Bro9ggmfj2
	 CDabqm8lZTm5FYQV+CN6YlJt3hzElaqWqLO1tpdsXLaYalKYps3KHNFI170G4vcKhQLoq
	 jcxLpYTT3PUbUwDvjAdDTVwluO6aNzkiQv5btLFUA1v315MWLDJJ7LDXXmt8fnzlhqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793718090;
	bh=1nHTvKbl8S7aFQgJvsAU3BP4lFRDosPuktNMQ7I+ojg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VvI4qbiWrOjpNrvIGZFpNnv7ySjeCeKYiW4hxa1bnbb+NnvrJPzNSZDasjXEbYjpE
	 r8Gr+rmfmUr3nEgly7WUGBeYTvHkFw7ZC08urm/PXnJi147A5LCTSnBXKkGB0Uw4yT
	 9jNP3BuIlB3oRuhTMoNHDVNQxARDmyejfsDX027EMkLcjjNDFu6qRv/gc6Uj60Xpkc
	 qZ+Z9L1FvsNttH5e7wmztjbCemtSnMkeRUdcKotDFIuXNi4kuf6i1xHLbNcpjlACcD
	 +aUkgLbLVJ5vd29NNxGsyrjn+XfJkC1+4T1mMN7HBxkYdmAnWT0jo/u5hDdtYShc1W
	 O3DMb2tRd+jbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73DC2606DA;
	Tue,  3 Nov 2026 15:01:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FB50A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E971840070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:01:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PeR1KCnDYG6v for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:01:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5082740068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793718088;
 b=qFOWcbWtExJfV6U13bLpotxgSlFP5Cx2wBvowSZSZGaIVbn5I7Jryi/j3phyLFDbvPm9
 FWPd9qg/d46sAPo1cJoTytQUIJhDTx5BOSOvLlWVdYo1g4zSFTAYocU16zUK0q/3gQ5mh
 GfsXaru9kLGzOj/mIf9M4Lo5O1G25skvKf8qoWshUzFNKFLI8xhVBOYDkprn6jKMSfH97
 FDCo9PIljJgtJlY/H+rIkUT3FezL2jGw1M/eJv7QJY9PqNakGAlWk5DyGtSViGjhNY34b
 RkTRkLiPYH1IW1CxwawCgUDxtRge/Wulc/qflJG6omhv6LFjlirR1F+FuIRMDSM/VVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793718088;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=1nHTvKbl8S7aFQgJvsAU3BP4lFRDosPuktNMQ7I+ojg=;
 b=Ev5MXv+AkDnjh+Rud+2dF0yKzXImVHpoXQ+EETpcsPtRX4RD8+2LA/Q6pKucQn0O2Nyw
 70e9Sil70qn2ftHcr/qXFQ+3IgvgrRSZXwQwQY3nX2LJk4e0FbW3kU2NrG13E9gjcyxjX
 azNVLb7WDqh81LDyHM5prKqGIyEySU/2ptrzbGwH6KZminesfoW7BLr6qtnlWxSutTEVG
 BZ7gzZ/ZGvIt0HyOUxyl04DGiQiFygE+mLJdbhFIyHv4cf9/s3Q9pIrVcPwCTKD62P+aD
 oR/P71bmzDPhFzg4Gw34vHfAz8oQJIHU9+avpEwtQvh3j7pZFM1Lf9P2z4V275cqLTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=i6mf7vag; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i6mf7vag
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5082740068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:01:25 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso47989735e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793718084; x=1794322884;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1nHTvKbl8S7aFQgJvsAU3BP4lFRDosPuktNMQ7I+ojg=;
 b=i6mf7vagYAaEkqRyKLmbpvEonUWG/fvn1imhxFxGag64wqz5RQ9hJEefSlnAu+axkw
 dBVcLGqClhYO4DXXwNmHwX07j1ze1FVcR88zbzKE34PnCpLO6qHX2s0O3ZYRC3xi6N4f
 YJNlvX9tLisUhp6qLZ+sQWy6STXmY8s/7re14J/RfiHLomnI8iNEzuWuTrGCiDLZkRUM
 FTmWDH/HxcVJKQnBNW72nEViXoax0rdO6VJV8vwioeCSP9onyhEmi+i9z4YjMEsUFxG5
 1Ftk5QKZtzoor7s7QvusQq3lypwZiRyrnS1KI4Vi7pBL5yyb9JQyAhQM010pWCrfNvfR
 boZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793718084; x=1794322884;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1nHTvKbl8S7aFQgJvsAU3BP4lFRDosPuktNMQ7I+ojg=;
 b=fEosgkgAs4DgNzKTW8rLkzM9VbOxe5NIr79ANLoh7vg10CA2bDmoqmcUlQDiyECWCW
 3q5gH0aj3qz/GnODsniecmCpJZjM15+evckMT6DfMRVb8qBPBHQ89ZLvgPNvfbEERj6t
 DmCCJjq61b+xRJMTrZZxlAOIsbeSFEyY3bCf2cKjgNCIg/eeK5gK5DBxXSs9yJPXeejM
 OuQhxrGwMcBUyNrlw7do3OZkK3MkYIyrmhfOlhjQc0xpmCXIQZtpAV6dfBtZkTwy4Eqw
 AZMLua9eh1T1xZGIWGocMmJj18LA91+VBNCp9KP2n9/HFLn4PyL2T9tBgseHovNR5fc9
 qlBw==
X-Gm-Message-State: APuU4Z/7122ajxeRHKp8PwOAPd9f13vDn7flUKToREWRihA065AxDCBQ
 gBY4GJgZXwuZn7KWLH7URKHz3nwBpMvvdJQsfldQYm2vDAscNIku3jZMyMfDIC5CTvxtWxeNFcp
 anvRU
X-Gm-Gg: AYBFou1U1h7TqeUW40e1kzCxnk5o+gcS5PT5RKMGH2Phat2bHawossG7lRyOUsvJ/7K
 EP8Z9b/3ZJRue6LqKqhKkbsmA9/lMD2UBZ6zvJOu+IxBU1S9W82TH3+Zgn9+l9p5vXqFKbcV5FI
 5tfQTjz03zBhz+pGkIS1CR4ctjuSbfP0F+q1Fb5jeDf20cGnDF4Y96vCpYTMG1WWnOtWrBa2ga7
 hm93NOeELm5k8cWiOX2Udks2qUxstGBFGcP0gkDyEwR/fo3b9I66C3sz+H0Rwo15lpLdRPqmAVZ
 YqJyzzvGevOKBjA778n2zppHwo3IJF/+954zgwqbspuSA9w1mds0pf8AY7WQICmez/voQDwvqP3
 FOyIipUov7t72rhmJuUFAPxJ18FyfKfugzYn6E4inJn7JV1dsVn753u1395QbbR5U5oSOkUN08O
 JH/cyVeo2dFAxHBLPm7vMjZCz56Ymyc2kXycqjv6gDkLgT/ves83tPPqQmoVzH/4z1/VqgDBiJ8
 7/cS0YZOb/Aj2mbf0t/+rX127ps/D6U2XCCMSv2ZNdVKYkpCcp/mZUw7He6VxmbG9j2M3DsVH6k
 vpyoSm/dIhPQU1C4kv63hBXIsAynrLymfD5RZrsPVuMXo0lcNDzPfy/wY2L1x/TwB1PSZ7WI/Q=
 =
X-Received: by 2002:a05:600c:3556:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4ac1932a355mr288239555e9.30.1793718083549; 
 Tue, 03 Nov 2026 07:01:23 -0800 (PST)
Received: from localhost (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad5ff8sm241915995e9.4.2026.11.03.07.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:01:22 -0800 (PST)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Tue, 03 Nov 2026 16:01:19 +0100
Subject: [PATCH v2] board: renesas: gen5-cm33: Start the generic counter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261103-clegoffic-gen5-generic-counter-v2-1-09493f3c7e8c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD736WoC/42OTQ6CMBCFr0K6toYW+akr72FY0GEKY7Q1LRAJ4
 e62eAEX85IvefnebCygJwzsmm3M40KBnI0gTxmDsbMDcuojM5nLSsTj8MTBGUPAB7RliigADm6
 2E3oOfW1UWeiqrxSLkrdHQ59j4N7+OMz6gTAla2qMFCbn1+ODRaTe32OL4IJfpKqbvMCmRHXT3
 fok7fEM7sXafd+/kJmeeeEAAAA=
X-Change-ID: 20261026-clegoffic-gen5-generic-counter-cd7f953b6d69
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
starts it before the Cortex-R52 cores are released, so their timers never
advance and a timed wait such as a Zephyr k_sleep() blocks forever.

Only CPU in secure mode can start this counter. Zephyr on R52 has no control on
the CPU mode so can't start it if it is in secure mode. Start it there
in u-boot IPL.

Program the counter frequency and enable it before any other
initialization, through the RSIP-M alias of the counter frame.

Also fix the advertised frequency as the counter counts by H'10 every
clock edge of its reference clock SASYNCD1_RT_MAIN (66.666667 MHz)
66.666667 * 16 = 1066.666667 -> 1066666667.

Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
Changes in v2:
- Explain in the commit message why the RSIP-M U-Boot starts the counter
  and the CONFIG_SYS_CLK_FREQ change
- Drop the Assisted-by trailer
- Link to v1: https://patch.msgid.link/20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com
---
 board/renesas/common/gen5-cm33.c         | 14 ++++++++++++++
 configs/r8a78000_ironhide_cm33_defconfig |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index f532daa16d5d..1837283c2bef 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -58,6 +58,10 @@ DECLARE_GLOBAL_DATA_PTR;
 #define RSIP_CTL_PROT0PS			(RSIP_CTL_BASE + 0x844)
 #define RSIP_CTL_PROT0PS_ERR			BIT(0)
 
+#define CNTCR_BASE				0xbc000000
+#define CNTCR_EN				BIT(0)
+#define CNTFID0					(CNTCR_BASE + 0x20)
+
 #define SYSSS_BASE				0xc1320000
 #define SYSSS_MODE1				(SYSSS_BASE + 0x1010)
 #define SYSSS_MODE1_MASK			GENMASK(11, 0)
@@ -1280,11 +1284,21 @@ static void gic720ae_init(void)
 		writel(1, GIC720AE_GICR_VIEWR(i));	/* View 1 */
 }
 
+/**
+ * generic_counter_start() - Start the generic counter shared by all cores
+ */
+static void generic_counter_start(void)
+{
+	writel(CONFIG_SYS_CLK_FREQ, CNTFID0);
+	setbits_le32(CNTCR_BASE, CNTCR_EN);
+}
+
 /**
  * mach_cpu_init() - Initialize hardware and start other cores
  */
 int mach_cpu_init(void)
 {
+	generic_counter_start();
 	mfis_unprotect();
 	pfc_set_avs_pinmux();
 	mdlc_mpg_start();
diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 3f09a7c25568..37d700096ff3 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -65,7 +65,7 @@ CONFIG_SIMPLE_BUS_CORRECT_RANGE=y
 CONFIG_SKIP_RELOCATE=y
 CONFIG_SYS_BARGSIZE=2048
 CONFIG_SYS_BOOT_GET_CMDLINE=y
-CONFIG_SYS_CLK_FREQ=16666666
+CONFIG_SYS_CLK_FREQ=1066666667
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
 CONFIG_SYS_FLASH_PROTECTION=y

---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20261026-clegoffic-gen5-generic-counter-cd7f953b6d69

Best regards,
--  
Clément Le Goffic <clegoffic@baylibre.com>

