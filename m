Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BBBC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98058606EF;
	Mon, 20 Jul 2026 18:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o6uhlNbvEODq; Mon, 20 Jul 2026 18:09:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A59F2606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784570992;
	bh=VTgSadEXqjuKz4FhWXc7Fekgd6z1havJb7EUnuI8tRA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qvCx79x3Qy2SLjrsDJzQtkyLriNd3ehvWi7SQAqCUgX1QrSb7Nci1i38hkvbmIDHC
	 dkXq/sqDu2uMBpv3rUeIU2stujjcMJZu195TwUPrnP1GVPFY4DxXAwhOULaCJrMSYr
	 W+hF+JT6isa9alEYxBA4H9+oY6Oqyh0OHVRhwGC7TijJFhEQw+dx9jMHzHFkGJUBjp
	 yEZoBOLePCURTH4nGVUxkipqRTWaUCWSIyu3PTCYzkP0oQKrWFBnMSubm58xXV4xTQ
	 oXbSPHXip9c1ZK9aKf4GXW79yFEYeBRvdsZ02Jvd6DthNFd9AxAri2bUPwUwyp8ltO
	 DhG3EP1d+p+AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A59F2606A7;
	Mon, 20 Jul 2026 18:09:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 820ED133F
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7F995406A3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1f-vQZ7EmIM for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=casey.connolly@linaro.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6494B406B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6494B406B3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6494B406B3
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 16:49:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD1884A4F; Mon, 20 Jul 2026 18:41:56 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A609E8493F
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 18:41:53 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so5866205e9.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 09:41:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784565713; x=1785170513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VTgSadEXqjuKz4FhWXc7Fekgd6z1havJb7EUnuI8tRA=;
 b=EH6NWROeZH7aXv5NdfmeED50xyM5AhnxNEVDNY1lDN4NGQe+CLeHlVDuvlC3o5BuIY
 BHeEZG4mb+0H+uZgPXrYpqsgmxtvv6zIXRNNaE0k2oL8lCr+AZ0UTjxV78HR/+rkbyW6
 T0Kr0g+U3YTItvTHPcLWyy7vsEBKDfOfKOup+5iBwPbphQ/sxWFgzySfsM880gcBgvHm
 ioE/LgZzrdpL6BAt60AtXbLRJcPTyqmeKGZFL0wD79ySIbW7rvHu7bLQ3uPuEBQixB9B
 YY7Rc4F8/51OsJCJBM1CQ0RYk1QD2hr/dByRjWY5X4uQIXn5dys64HOVWVsEq/AWf2j9
 jUqA==
X-Gm-Message-State: AOJu0YyyopLRs3qONCE8Q+SdPVNPmPqugFbRz1/ap4bKEMwhY3gplG95
 1EgSTwx4gZ/0M6wJOnfYl+J5FLP+KvGDrzE2fgE5aOPcyqbVQNqwWxZ3uhdOHVNkai4=
X-Gm-Gg: AfdE7clOLT61xXzSqkgGSt70rdOcyHqJFpwMYITm0V5poNa7awf76ps6HQLOpDO1TQG
 ajyoLi8sJHJuK/A2Un/POT4QM5odxZyDCEvBh0LSHVX26rFVnRO3FHuniSMzqz42BXvA9yb2oFV
 BGJfAMpEFXNxYYJmZs1hTF50Kbns53CQq0kaeN+1iHvTAbJ7Bei8L1s81qWQFE3Hphn8PIgiyBR
 vxyLl2+gAe7rBF4kRpk78v9Wp/BMICxZsEdoOxp1iTSzEDqrob2HOd3YMbu6FV12xqXjYfwyKOT
 RJLFN9Nmr+ncgmnfQXTw+EMPNnNk+mkkQNB50j1CJlwCM39581bY7UqM4tYFdFx0/DW8Xb+xw5b
 CXnqlYYzC7kX6h60J2oNWWx+5xbExyt4+LBpIJcSPqAYECRDs6rpZlw1qBK5diASR0w2Kuc8sLo
 y54BfoMdTGegGLGA9aWdu/jUddettdGQ==
X-Received: by 2002:a05:600c:4f56:b0:495:5045:39e6 with SMTP id
 5b1f17b1804b1-49550453a30mr142690315e9.17.1784565713107; 
 Mon, 20 Jul 2026 09:41:53 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956536870esm2755665e9.3.2026.07.20.09.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:41:52 -0700 (PDT)
Date: Mon, 20 Jul 2026 17:40:52 +0100
Subject: [PATCH 25/36] MAINTAINERS: add entry for CCF port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-casey-ccf-upstream-july-v1-25-8fece1b0333d@linaro.org>
References: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
In-Reply-To: <20260720-casey-ccf-upstream-july-v1-0-8fece1b0333d@linaro.org>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Paul Barker <paul@pbarker.dev>, 
 Dai Okamura <okamura.dai@socionext.com>, linux@analog.com, 
 uboot-snps-arc@synopsys.com, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Simon Glass <sjg@chromium.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Sean Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mario Six <mario.six@gdsys.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Yao Zi <me@ziyao.cc>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=7drK3ej9ixm/oIf8wmY8LlExwp6DyiVQUL37wG5XPVE=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBqXk+EnmmM8ONcsO9uHmz/Y0lb+tJwK2/VBZ7Oe
 SykpawyYYeJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCal5PhAAKCRAFgzErGV9k
 tgkWD/9a7A7NYRDiWEwGtmS8RTXvMRlJwiWoQQMU/5Cv+UmHEGhAokieaYc4LREmZzSUe37Gv7e
 Q3MGZ34nG1qfQrVmQN0n4EUYzNnHhJGnSLBE5RREczE9uq20Z0FkuaoySrLADGOqbWt2v7wHeBi
 FJlgmD6ewHx8B5FAA/5VCTfnIgPjJXrTEW23X3FUiw8VySB9vJ0n0nOaMIVV4uo/C0O2a59qERF
 K4mVWC2wxlkEhSX4BM3M9VFPAkyu7Be05/us7OEF97aTKGs7BzXOWjpz5h1U5FiKPNbJXWl+C/6
 oIKdXq/JjuENwfaJ92dwlhDeIpAlF39NFW5th0szdSQm6FsVtldqT8O6/4SJGE1Nxm6lLEt9xn8
 bAu+H6742s5+9N/cw2fIdCfI7cw+r9VYvtSAj/QDcNzxfQtfJOuPmXrcXsdiOblgTqjs0RgaFbG
 JLQgnRemxBheCXKTcEP1ATPW8YTclP5Cb/XbOyLduPsk01C+qdiR18SYktBIt99QcW1rHMTvbHn
 Tunl8XjLGX06Ez1iRx7K3xSP35eiZwX9sWTtmQ4c4NF6Ceindjdfi4Ua2/F/T2lkVj5ANF5Jn7b
 TInAhUoqek9oUUMT8GD7jJCPDcaZYaUCd6V2FqDV/EUNW4GisMMqCp8ouOUuDykv851fl8AMs+2
 H8oiZONPgA5retA==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 20 Jul 2026 18:09:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784565713; x=1785170513; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTgSadEXqjuKz4FhWXc7Fekgd6z1havJb7EUnuI8tRA=;
 b=Qhg14ynH92laQarTVQYRuKr4QdROeOQ7env8QMpoIRwyZRebFtm1u6g3oNlzsciacy
 YJfy1Ef9wACLIHXIu9x5nj9kkhWFmRqsskD1n9WklL8HNplBF7jw9pIEJsb3bAvFC5uX
 vf/eG4lEBTXlWjtd7MjV/ri1tzVhMLdPqCqvBKPm2tKH2AIb83CGD2RYqn1+1xyxJXT7
 xC2BSZjibSRlojedBOaP115X9dvj0J5K64T2cdNtYtvNCeGwiyY5vQGj97X9UV+SrJmR
 PLykYo6HJlVyYUu6MzRvgh7MqlgOro4QhJusPCbxY4pt2iXys9zspAAjr50Ydf/ocDtE
 CFUg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Qhg14ynH
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=casey.connolly@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Qhg14ynH"; 
 dkim-atps=neutral
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
From: Casey Connolly via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Casey Connolly <casey.connolly@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a maintainers entry for the Linux Common Clock Framework port. Since
CCF is independent of UCLASS_CLK and only aims to maintain a compatible
API surface for clock consumers it makes sense to have a separate entry
for this. I'd welcome anyone interested to become co-maintainer or
reviewer for this code.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a522c77ee368..54ac73015580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1065,8 +1065,15 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
 F:	drivers/clk/
 F:	drivers/clk/imx/
 
+COMMON CLOCK FRAMEWORK
+M:	Casey Connolly <casey.connolly@linaro.org>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
+F:	drivers/clk/ccf
+F:	include/linux/clk-provider-ccf_full.h
+
 CPU
 M:	Simon Glass <sjg@chromium.org>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 S:	Maintained

-- 
2.55.0

