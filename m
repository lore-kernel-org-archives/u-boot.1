Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A001DC71133
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 05:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9739D86CC0;
	Fri, 18 Aug 2023 07:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="vYt8+U2/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638D486CB1; Fri, 18 Aug 2023 07:26:59 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D876786C21
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20230818052647epoutp04960e450cd0467d4d38ef04c8a9a796aa~8Yv8bZiQA2792427924epoutp04I
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:26:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20230818052647epoutp04960e450cd0467d4d38ef04c8a9a796aa~8Yv8bZiQA2792427924epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692336407;
 bh=b2Ba1ECoa5jUahGv76SQzJyJFhp5+5YzWU6D/BOgNsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vYt8+U2/lPwRxjP6tG/hd4LE4hXaN7tkMsnflIYEnoxdwTHWLww/ntuHkP94cq0Ti
 0KgITIncKLf3d90GbTv8SW11quNHMFjdQMdELssfg1SmwXS6VEfMjaktakvh1XECng
 Wt1YRiufU7+6mlHPCQ9hGlf1xgqYWYgSi6UOrRXo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230818052647epcas2p475df978e3f51ad39f7f802c4681b255c~8Yv8EAGIj1909819098epcas2p4l;
 Fri, 18 Aug 2023 05:26:47 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RRr2t5W5gz4x9QN; Fri, 18 Aug
 2023 05:26:46 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 DA.AF.32393.6110FD46; Fri, 18 Aug 2023 14:26:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d~8Yv6vH0Oz1588915889epcas2p3C;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230818052645epsmtrp19b8de541b35c011a9aa875553c77bbf2~8Yv6ud3412943329433epsmtrp1Y;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
X-AuditID: b6c32a48-adffa70000007e89-78-64df01165014
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B1.1D.34491.5110FD46; Fri, 18 Aug 2023 14:26:45 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230818052645epsmtip111b4a2149864c5053ae5ae25501f08e5~8Yv6evwPF1074210742epsmtip1l;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 2/2] riscv: cpu: make riscv_cpu_probe to
 EVT_DM_POST_INIT_R callback
Date: Fri, 18 Aug 2023 14:11:03 +0900
Message-Id: <20230818051103.2427590-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818051103.2427590-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTTFeM8X6KwewWJYupPfEWl/drW7x9
 cZbR4tuWbYwWb/d2sls8PvSayYHNY8/pWcwesxsusnjsnHWX3ePsnR2MHn1bVjEGsEZl22Sk
 JqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaCkUJaYUwoU
 CkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64vuYB
 a8FsvorPP98yNzCe4e5i5OSQEDCR2PN9KQuILSSwg1Fi8g/JLkYuIPsTo8SL5bdZIJxvjBL/
 fz5nhOlYO3UKVGIvo0T39TtQzjQmibf/Z4NVsQnoSmx5/grI5uAQESiXeHjGACTMLOAlMfPB
 fWYQW1ggUuL48YVgJSwCqhLNf6JBTF4BB4knW3VATAkBeYnFDyRAijkFHCX+P53HCmLzCghK
 nJz5hAVioLxE89bZzCAHSAjcY5f48n4F1JkuEj2n9rND2MISr45vgbKlJF72t7FDzC+X2LEs
 CaK3hVGiuW0PM0SNvcSPm1NYQWqYBTQl1u/ShyhXljhyC2otn0TH4b9QU3glOtqEIBrVJQ5s
 n84CYctKdM/5zAphe0g8+jCBDRJMUxglJi2bxTiBUWEWkm9mIflmFsLiBYzMqxjFUguKc9NT
 i40KTOCRm5yfu4kRnBa1PHYwzn77Qe8QIxMH4yFGCQ5mJRFeC6Z7KUK8KYmVValF+fFFpTmp
 xYcYTYEBPZFZSjQ5H5iY80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi
 4JRqYJL6zTHvkv+G4O1tmwVVzb6oOdyaWu0yt/ZvSIyXkuVe0SDnY4f+GGvKeU5h//qzRPCf
 vcqGhGl7H5ZsuDq5t/+af1tveVj7KWeZn4f5Ttlva5qcl1u5/ZSx7dzk1Q17eyY0fjo603ve
 aUet409nXGyanV1e8iPvx3whpc1Pluoum6Ait87dNWmm1PVfekLH03e88Pavsk2sckyfmHEn
 rXq+y3behivL3hY8Dn/C66SlL/WvZX5r4Y8eNTtRz6xLn9R4alqZSvkDehIMAyOzdFa6RZ0V
 bfghqv5Obc9WNk4LDR/FiH3K9YFrOn2YBK68jZh+rD5oNZulQrvN1cxE2dqG4plfoxZc4PZg
 XCipxFKckWioxVxUnAgAhHXwrhQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnK4o4/0Ug2XvjSym9sRbXN6vbfH2
 xVlGi29btjFavN3byW7x+NBrJgc2jz2nZzF7zG64yOKxc9Zddo+zd3YwevRtWcUYwBrFZZOS
 mpNZllqkb5fAlXF9zQPWgtl8FZ9/vmVuYDzD3cXIySEhYCKxduoUli5GLg4hgd2MEu/7LrBD
 JGQlnr3bAWULS9xvOcIKUTSJSWLuta9MIAk2AV2JLc9fMYLYIgLVEr++LmIDsZkFfCQ629vB
 moUFwiUeHdoLFOfgYBFQlWj+Ew1i8go4SDzZqgNiSgjISyx+IAFSzCngKPH/6TxWEFsIqGLr
 srtgQ3gFBCVOznzCAjFcXqJ562zmCYwCs5CkZiFJLWBkWsUomVpQnJueW2xYYJiXWq5XnJhb
 XJqXrpecn7uJERzEWpo7GLev+qB3iJGJg/EQowQHs5IIrwXTvRQh3pTEyqrUovz4otKc1OJD
 jNIcLErivOIvelOEBNITS1KzU1MLUotgskwcnFINTKVf/6+8KiezyeGS4i/t1nOrtbsSzf6v
 +K/xe+HOVq4HF+W/B2yYbZeR6V5nsksu8c0zDdvGa48uL54TztYu/7K4OSdtmUl/44LH6lYK
 O180OAsW94WZai4P3/zcS2Zir2JFwr6oR5+kFz54toHnSeZxMVnd2/cXuW+5JbqrimNTacnZ
 DmGvd2drF2Yu4JodZWIw287ZM/TOzta1PcvKO6ek1sgVKPx78n3/7EfLHv/XFbb8ON07N0/x
 pML58nsnIpR5u1Ydt7UInRdnkntuzpvOje8Yfm44vV2pgtN09sLX1rLyj153/uqM8D0t8d12
 LUOO9HTmlZ8tDBzSNBLuiT/c658t3eQSa7v0j2jSRCWW4oxEQy3mouJEAE25fezRAgAA
X-CMS-MailID: 20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d
References: <20230818051103.2427590-1-chanho61.park@samsung.com>
 <CGME20230818052645epcas2p3df52c8522cd903f869d366fed46ea89d@epcas2p3.samsung.com>
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

Since the Patch 55171aedda88, VisionFive2 booting has been broken [1].
VisionFive2 board requires to enable CONFIG_TIMER_EARLY but booting went
to panic from initr_dm_devices due to lack of a timer device.

- Error logs
initcall sequence 00000000fffd8d38 failed at call 00000000402185e4
(err=-19)

Thus, we need to move riscv_cpu_probe function in order to register
the timer earlier than initr_dm_devices.

Fixes: 7fe32b3442f0 ("event: Convert arch_cpu_init_dm() to use events")
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/cpu/cpu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index ecfb1fb08c4b..0b4208e72199 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -66,7 +66,7 @@ static inline bool supports_extension(char ext)
 #endif /* CONFIG_CPU */
 }
 
-static int riscv_cpu_probe(void)
+static int riscv_cpu_probe(void *ctx, struct event *event)
 {
 #ifdef CONFIG_CPU
 	int ret;
@@ -79,6 +79,7 @@ static int riscv_cpu_probe(void)
 
 	return 0;
 }
+EVENT_SPY(EVT_DM_POST_INIT_R, riscv_cpu_probe);
 
 /*
  * This is called on secondary harts just after the IPI is init'd. Currently
@@ -95,7 +96,7 @@ int riscv_cpu_setup(void *ctx, struct event *event)
 {
 	int ret;
 
-	ret = riscv_cpu_probe();
+	ret = riscv_cpu_probe(ctx, event);
 	if (ret)
 		return ret;
 
@@ -149,12 +150,6 @@ EVENT_SPY(EVT_DM_POST_INIT_F, riscv_cpu_setup);
 
 int arch_early_init_r(void)
 {
-	int ret;
-
-	ret = riscv_cpu_probe();
-	if (ret)
-		return ret;
-
 	if (IS_ENABLED(CONFIG_SYSRESET_SBI))
 		device_bind_driver(gd->dm_root, "sbi-sysreset",
 				   "sbi-sysreset", NULL);
-- 
2.39.2

