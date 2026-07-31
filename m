Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92821C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5752A80F28;
	Fri, 31 Jul 2026 16:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGCoKEeO9YBa; Fri, 31 Jul 2026 16:36:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AE0580FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515765;
	bh=gmwGcihrUrsmM5ulDFq4O+lyvxHKv2XUkRP9Z3GENyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SOIdtkPRKY3sD5q+x8mWLiGZgPrw3ytrXqAdprYtX4X3C6G83BR8l0aoLud61vewx
	 4zrKkSna7d7iedxDFiwi9ML0UWBrhqFz9Ep6jTw7kkw79KTA4qtoQKEYR54uGs7MnI
	 /dO7qOViVVOWDEbLjQIvrzRgm2gYzP2O5Vkl1HHKhoDXE3eFAf+Axmr6Rtlm8wV/6d
	 zqJ5an3j8VDgKwcYQuNzo91z4ao0in8uT7hVoFp1oZT79ZU6q6fkJomyNMvl7EJuJP
	 z4SrYuLDftuUrVfeh/VjcMzWgLz8aJkVTcnU/UlkfWfPUs1Mp4d19K+WFMwi9gJ/CF
	 Gp7H8DBMGHR7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AE0580FEF;
	Fri, 31 Jul 2026 16:36:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A00BC27C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92CDA60658
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lVMN3BYmwPR for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e30; helo=mail-vs1-xe30.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CF5C760657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF5C760657
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF5C760657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:17 +0000 (UTC)
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-74ab6c88052so393113137.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515656; x=1786120456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gmwGcihrUrsmM5ulDFq4O+lyvxHKv2XUkRP9Z3GENyw=;
 b=pwaoiJDsAr+xs5CzztpwerG17F6jIoXwepdJj88seklTfUeTL1OVVh28P757AP/DQ+
 He4V2orwse9xJSwgHSglPoqoBy4eKA2nrFMrcqAxizONyzc9d4ukoGUl9ZxcPi25a+jj
 m6qD97uKZfKGWUDJ1aB6kTBWbKPmj0Cv4mdDYtb5LycaLtHtTXKTBk4zYdRlBc5p2ki7
 mD4GWs/WwjybktLZyXKLf5065alclsKIEH0gmYgJUr8GsgGUAxaNE25B2JI/nueXjykc
 So8JqDlRdSCLhwktlP31YOTC+Ek3fxFSZnvqaarN8k87n3gTOkHhhbSa6spDOWMfnhzn
 fkLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCzAiQmekd0D/ao5DnfdkX4w6RgRzRYPba21QqSfIDZxa+m/8MMufyvRHDQDGmVTcung9p6UI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzRSq5DFL71CTUw2zlSXlnx6YNwPmmhpBRfyl+rn7Uaaa1DEOU6
 6lP3eO1NBPr55fsIsQBD9vGTb02A7pe1rnbwM3jkF+VFirDUKelKCd6GkaSPzR4t5o4=
X-Gm-Gg: AR+sD10cqnr83RVV8WZAPIxwFG0a0h8wGSNuglWuD88EMivhixIYmWJvYpSssPkjazK
 eiBAqah4b8I7Ogpb5Mb5AJWlu/+dhQXx9mmxxHNullvutN2OibpsV5HFwZWkrBsMjg8lyHdBj3d
 PiqpAFG/hy1P4yD2SkvVlay5JUUcIpDSloUzk38TVuTySuBpzMCKGNGt21o+xmNN6MWzIfk9u7n
 pkeUDhB70sLCe8mwGSj9IiXKSwTEnHbbNXx6fqzDvUW+I8yDvJ4SSyHTaZOnjfHplKvl9BYAA+y
 gfclZaRPbf319e+0ydsc/4bYUUObDoPYA1oi2S6W25ezWGu/JyZ85igx/UvQqkofDIhxJ+pPRDd
 U4J9heFlT0rYphus61jDa3ltmf4OobYTkQ2C6KG5lnHJGh3y0b8JZAosPy2ERtw4lPauSK1ylxV
 eDWcGDIezyywzyjEkG09RSZsvzhA86ZZIICMboo4XBU0MgbKLE8XgbcFOLuIzXrtfs5mVfszw+h
 7xtjPy/Lh8DJmcY5QIBeQMQ6hgvGgsiUZXjfokvohp/M2A92AEdaDIPEmv2yXZUHxJ4ZsE=
X-Received: by 2002:a05:6102:2d09:b0:737:783d:1900 with SMTP id
 ada2fe7eead31-75b23356ce8mr691540137.9.1785515656323; 
 Fri, 31 Jul 2026 09:34:16 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:15 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:40 -0400
Subject: [PATCH 11/17] board: schneider: rzn1-snarc: add rzn1.env
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-11-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=1280;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=OAAPJDBhgIupuGvoZe84BXf7+a+9ltZ8vzRWKsI7M3o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJYuCF+XnTzKP4VuSfSnIlJsKLm03qZTdFewdxc83knhWOVfjZURQ0b1Tm2jKa1TZ7VVe01qR/u
 QjNecEKayFwA=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515656; x=1786120456;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gmwGcihrUrsmM5ulDFq4O+lyvxHKv2XUkRP9Z3GENyw=;
 b=RhVezaKX9YfhSPSW+B95kaQvZD1es+3LeeXwkW0ZjH7p7w+YFJeGnNPCQmXeD/IcW6
 6bCA7/Y0D3tTf4nwiGTYrVWbOmmugFrNO7mJUdd27AbltCiCBzmfr7qOPdMv0VevrXVM
 4UoE+tlWY1DcTsSCWl83TMBEqho7IA+hY3udgFlSAYVffkdfLCb7V0Z2DYWu4I/TUBJG
 m3350maaOt3KqQX6cvUjDnfpN0hBemSU21i7aR5/U7HKlLoWwEElbYfcgLzUvzl2c2+N
 yWrhuWkcxN144UYlb2Am5fTt7oCQWHfa89iFv3YMCfEYYpr5TLF9tp7nC6zPuWBy4bfX
 1Vsg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=RhVezaKX
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add default u-boot environment for Schneider RZ/N1 board:
- Ethernet: default MAC addresses, use end1 interface
- dfu_alt_info partitions for DFU
- legacy bootargs

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 board/schneider/rzn1-snarc/rzn1.env | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/board/schneider/rzn1-snarc/rzn1.env b/board/schneider/rzn1-snarc/rzn1.env
new file mode 100644
index 00000000000..bc4f7e77b8f
--- /dev/null
+++ b/board/schneider/rzn1-snarc/rzn1.env
@@ -0,0 +1,21 @@
+ethaddr=00:00:0a:02:57:cd
+eth1addr=00:00:0a:02:57:ce
+ethact=end1
+dfu_alt_info=
+	sf 0:0=sf_fsbl raw 0 40000;
+	   sf_unused_mtd3 raw 40000 40000;
+	   sf_configcms raw 80000 40000;
+	   sf_unused_mtd5 raw c0000 40000;
+	   sf_env raw 100000 40000;
+	   sf_unused_mtd7 raw 140000 100000;
+	   sf_uboot0 raw 240000 100000;
+	   sf_uboot1 raw 340000 100000;
+	   sf_trustedfw0 raw 440000 100000;
+	   sf_trustedfw1 raw 540000 100000;
+	   sf_cm3_0 raw 640000 100000;
+	   sf_cm3_1 raw 740000 100000;
+	   sf_data raw 840000 0
+	&nand 0=ubi0 partubi 0 1
+	&ram r_kernel ram 80008000 d80000;
+	    r_vxworks ram 80008000 d80000
+bootargs=console=ttyS0,115200 rootfstype=ramfs coherent_pool=2M

-- 
2.55.0

