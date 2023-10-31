Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F81EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A1D987B7F;
	Wed,  1 Nov 2023 00:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="uXlBTF7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5C687B35; Wed,  1 Nov 2023 00:56:11 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD3787B59
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epoutp045c433fe891b7c89784a6146506662356~TVndAbtS91063310633epoutp04a
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231031235554epoutp045c433fe891b7c89784a6146506662356~TVndAbtS91063310633epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698796554;
 bh=Oh2UtrU7DRmsJziSyin0/+2lQoJgzhCNQwFDUucV1c4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uXlBTF7moG2m9EMJxXrjaPVPT4+5xVtMWpkLQKJpKzkzl/qXGfhH6aG9AoA9TVnm3
 VMKQG/PY0HcilpGSm75h8Pwjh35yHVbG6GGekvd9xCI5LThanmvZa3P7v4IfM5t86w
 9mmFwWnIJ1zOl62UumqfMYCEawmf69MBdGUcvqco=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epcas2p2fd9df3e3937caa619c7fc0abaf7e0294~TVncj15_t1327913279epcas2p2B;
 Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.98]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKn8T5pQ1z4x9Q6; Tue, 31 Oct
 2023 23:55:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C9.91.18994.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epcas2p4376b6148dded2cb7b0a47664aca4fa39~TVncAREbJ0985109851epcas2p4g;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epsmtrp1fb302dff2f2d963101481ca1a27d034d~TVnb-tKZp1667516675epsmtrp1y;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
X-AuditID: b6c32a4d-743ff70000004a32-fb-654194098502
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 57.D4.18939.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epsmtip1f5719a5196bba542e25bf6e4e5a3ef02~TVnbwIYNb2441524415epsmtip1T;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 4/5] riscv: dts: jh7110: Add rng device tree node
Date: Wed,  1 Nov 2023 08:55:29 +0900
Message-Id: <20231031235530.1500393-5-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031235530.1500393-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTVJdzimOqQedpfYvL+7Ut3r44y2hx
 75qcxdu9newWh6d+YLR4fOg1kwObx57Ts5g9PnyM87hzbQ+bx9k7Oxg9+rasYgxgjcq2yUhN
 TEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHar6RQlphTChQK
 SCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzjh+sZm9
 4D1bxbtdF9gaGI+zdjFyckgImEhs/HyCvYuRi0NIYA+jxNarvcwQzidGieaDIFVQzueTr9hg
 Wv4uusECkdjJKLH3QAsbhDONSWL/gg3MIFVsAroSW56/YgRJiAisZpTYtr+ZHSTBLKAt0fl5
 CpgtLOAi8WF1H9glLAKqEk8uLGcBsXkFHCRObr8JZHMArZOXWPxAAiTMKeAocersOzaIEkGJ
 kzOfsECMlJdo3job7G4JgWvsEgvWP2eC6HWReHxfE+JqYYlXx7ewQ9hSEi/729ghSsoldixL
 gmhtAXq5bQ8zRI29xI+bU1hBapgFNCXW79KHKFeWOHILaiufRMfhv1BTeCU62oQgGtUlDmyf
 zgJhy0p0z/kMDWkPiQkNnxghITWFUaJ76nymCYwKs5A8MwvJM7MQFi9gZF7FKJVaUJybnpps
 VGCom5daDo/k5PzcTYzgJKnlu4Px9fq/eocYmTgYDzFKcDArifAeNnVIFeJNSaysSi3Kjy8q
 zUktPsRoCgzticxSosn5wDSdVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFM
 HxMHp1QDk96DnWdk49dJRjobHlP4Y3s55VPVp2qv0PMfTE9tnjpB5dZTxv0Ff/zbhJea1Jpc
 OSIunrHr7ESWC+Ktd949OCSb0jl9fWSI3YpP7DENwTacccwH8yRsmVfmmU+JtXQIPyf9502w
 t9rbD4fCcvKZHu8969eUs6JywcNNnq8sz/1gfue4/k3fr+j9y0zvRi8MUr0jcj2BS3R6s+Cx
 tnlzbnoudbKZu5Vjg8kj7Q/ibzR23j1061F/7yTNc2flubgn7vm6SLO8gumF5418w5n75twv
 NtsbrhexIt2IZ7vehi0vJrR98uq9bC4rvIh5z6ZT9Y+3aH7eIqTDafHv95PXqufj/BWnahQe
 u/KT67imU6USS3FGoqEWc1FxIgDyufn0GwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnC7nFMdUg/XPpSwu79e2ePviLKPF
 vWtyFm/3drJbHJ76gdHi8aHXTA5sHntOz2L2+PAxzuPOtT1sHmfv7GD06NuyijGANYrLJiU1
 J7MstUjfLoEr4/jFZvaC92wV73ZdYGtgPM7axcjJISFgIvF30Q2WLkYuDiGB7YwSsw/1sEMk
 ZCWevdsBZQtL3G85wgpRNIlJ4trrP2DdbAK6Eluev2IESYgIrGeU+LH8PViCWUBbovPzFLBu
 YQEXiQ+r+8DiLAKqEk8uLGcBsXkFHCRObr8JZHMAbZCXWPxAAiTMKeAocersOzYQWwio5MPE
 SewQ5YISJ2c+YYEYLy/RvHU28wRGgVlIUrOQpBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vO
 z93ECA5graAdjMvW/9U7xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlOavEhRmkOFiVx
 XuWczhQhgfTEktTs1NSC1CKYLBMHp1QDk9T3g/uvSj58FSF1pEGez71MatuczSH6s33T3uhP
 /1aSIFz36HVZbzH/Of4fh58lhmxIjm5llj4k6XpCcJNa00/luq+hG87VpzwojI1uVNhVskJP
 RK5B8c/6lWuffqvWS4w+sPrXWitxo3fbypZG8fuxrNj+Z3c25xteZqmyCu4/5eb/w/9tSLl/
 PfewY7FW/cJzNqUyDML1l9PWmUw9l73qx/xZysnrdIO+nLybJVEt/TInbOXm9h+1b59841u4
 85BXY1Hbw9h1u9ef8+Z7rhzfc82vTLf87QVlwSXPT2+/NquI7zGHtlFCxN3PHY7yZz9ELFKS
 nvZB7nAlz6Iny16nuBr8cDRkcdYwsm+KVWIpzkg01GIuKk4EAGIO/4jPAgAA
X-CMS-MailID: 20231031235553epcas2p4376b6148dded2cb7b0a47664aca4fa39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p4376b6148dded2cb7b0a47664aca4fa39
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p4376b6148dded2cb7b0a47664aca4fa39@epcas2p4.samsung.com>
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

Adds jh7110 trng device tree node.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/dts/jh7110.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index ec237a46ffba..13c47f7caa36 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -627,6 +627,16 @@
 			status = "disabled";
 		};
 
+		rng: rng@1600c000 {
+			compatible = "starfive,jh7110-trng";
+			reg = <0x0 0x1600C000 0x0 0x4000>;
+			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
+				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
+			clock-names = "hclk", "ahb";
+			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
+			interrupts = <30>;
+		};
+
 		aoncrg: clock-controller@17000000 {
 			compatible = "starfive,jh7110-aoncrg";
 			reg = <0x0 0x17000000 0x0 0x10000>;
-- 
2.39.2

