Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3BEC4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 23:58:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ECF786C33;
	Wed,  1 Nov 2023 00:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TILB85sV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7D687B7F; Wed,  1 Nov 2023 00:56:20 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5996B87B1A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 00:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epoutp01e75296a9980ff1d36b61ce837d284b1f~TVnc2Uk6b2574725747epoutp01Y
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231031235554epoutp01e75296a9980ff1d36b61ce837d284b1f~TVnc2Uk6b2574725747epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698796554;
 bh=bjw3/ORzYww3ZVaRsqPckoL0vWKLRb6E8nT9Ogrpbj8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TILB85sVahRmUk5HDx9AP5KJpYJiz9C8CfIrh+grzXDIjODMxFjmpnrSV03fN+OM+
 JdiATZDZQoUMSoZ+6pj8mdOKPSzDEwAqh/MnDQEhW4nQtjZ5/qsf49ZUj0Z0bFdtEL
 AOyPShBGA16ezGduICcVXwJg1ttHsrJaG7yCteIc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231031235554epcas2p25754a70ceb717d0e3e78a828bf790c35~TVnckEEci1100111001epcas2p2b;
 Tue, 31 Oct 2023 23:55:54 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.91]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKn8T4JQjz4x9QF; Tue, 31 Oct
 2023 23:55:53 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 69.F4.10022.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235553epcas2p155fe2cd5cfdb5b33c490548a813a9aa9~TVnbsuQIw1708117081epcas2p1x;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031235553epsmtrp2510f63c61c60de3774536b282050f914~TVnbsIVbF0625806258epsmtrp2E;
 Tue, 31 Oct 2023 23:55:53 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-37-654194092739
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 21.68.07368.90491456; Wed,  1 Nov 2023 08:55:53 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231031235552epsmtip14bac545808ca2ad688d71b2b69980ddc~TVnbeJRz20166001660epsmtip19;
 Tue, 31 Oct 2023 23:55:52 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 1/5] riscv: import read/write_relaxed functions
Date: Wed,  1 Nov 2023 08:55:26 +0900
Message-Id: <20231031235530.1500393-2-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031235530.1500393-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQpdzimOqweWlChaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGpVtk5Ga
 mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0X0mhLDGnFCgU
 kFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndH7dC9j
 QYNExeGfN9gaGOeJdDFyckgImEi87uti62Lk4hAS2MEo8e9WPzuE84lRovv9fxYI5xujxJvb
 t9hgWp5s+8AKkdjLKDFx1keolmlMErdfv2ICqWIT0JXY8vwVI0hCRGA1o8S2/c3sIAlmAW2J
 zs9TwGxhASeJOa/2MYPYLAKqEht3zWIEsXkFHCR+3TsDtIIDaJ28xOIHEiBhTgFHiVNn37FB
 lAhKnJz5hAVipLxE89bZzBDX3WOXuNMXAGG7SCzef5kFwhaWeHV8CzuELSXx+d1eNojx5RI7
 liWBnCkh0MIo0dy2B2qOvcSPm1PATmAW0JRYv0sfolxZ4sgtqK18Eh2H/7JDhHklOtqEIBrV
 JQ5snw61VFaie85nVgjbQ+LNylVgBwgJTGGUWL5UYAKjwiwkv8xC8ssshL0LGJlXMYqlFhTn
 pqcWGxUYw+M3OT93EyM4NWq572Cc8faD3iFGJg7GQ4wSHMxKIryHTR1ShXhTEiurUovy44tK
 c1KLDzGaAgN6IrOUaHI+MDnnlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTT
 x8TBKdXAVKaTPEfQpeTj5RfFBjWfZ7cdMbByWx1xtlb+isA6GfbpPGd37XZvfLHh0feN7QEz
 LrkXyMs8luOwj3yl9WJi+eZZbuZvpXRzDmQ9b1By+pHoZlE2TUN6ab7JjRMfHb8KCtxpPO0w
 IfP1HNVnj7cJ56ivaFWeu4lJTo9VPFhhYYG6PlvB/PdJF9asEV1ao7D5VObc0D7WK50zlC2F
 Bbj/GG/O5Yte2B239W+JsduFT8v/pz6+suQ065sJQRm3Wn6ansm7ab3KONQxdRZvYu3ET/lb
 phcb8Hxr0gwU/rvOa9IdqYJz99r+HPN7/GTCc46Xxq4fG90rnrU1MqZeZIro2ZX27Rp/r8Me
 85vXjBi4lViKMxINtZiLihMBYQPfThYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWy7bCSnC7nFMdUg97vrBaX92tbvH1xltHi
 3jU5i7d7O9ktDk/9wGjx+NBrJgc2jz2nZzF7fPgY53Hn2h42j7N3djB69G1ZxRjAGsVlk5Ka
 k1mWWqRvl8CV0ft0L2NBg0TF4Z832BoY54l0MXJySAiYSDzZ9oEVxBYS2M0oceiVKURcVuLZ
 ux3sELawxP2WI1A1k5gkns7NBrHZBHQltjx/xdjFyMUhIrCeUeLH8vdgRcwC2hKdn6eANQsL
 OEnMebWPGcRmEVCV2LhrFiOIzSvgIPHr3hmgeg6gBfISix9IgIQ5BRwlTp19xwaxy0Hiw8RJ
 7BDlghInZz5hgRgvL9G8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PTTYsMMxLLdcrTswtLs1L
 10vOz93ECA5iLY0djPfm/9M7xMjEwXiIUYKDWUmE97CpQ6oQb0piZVVqUX58UWlOavEhRmkO
 FiVxXsMZs1OEBNITS1KzU1MLUotgskwcnFINTE/OXwm2eep4fEPuihqPPU9YdfKWZklc5NU4
 Pn0a39I/pwsuf850vHmlvl6WceJ9+dsBj+dtzvc5xVQtnKk73fbCqg/LuSacipNZs+pW16vv
 DYwyLVIbf2ceePbvfm5uf80Z5p3Lo3cwi5pWrTJ9x3107cW1E7VPnlm869mE49rH3po0KPLf
 TN/xQPDztt85G/RmzU8pFlHlbg8XC6uXrjkloK4xWebEtW+tvBlbL+9KuG5ReOBCa4Ll+4Wv
 b2d1nFVuMRLjFpz98OqHaX1Ls9eLrPHrEHi9JId/Qm/NWo2rqnPE/RpNlsf9jl0mx63T9nfK
 X9cdc1evW//GW2wvS8UukRkPTOfs8b70uMA04byyEktxRqKhFnNRcSIAXhU8PtECAAA=
X-CMS-MailID: 20231031235553epcas2p155fe2cd5cfdb5b33c490548a813a9aa9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031235553epcas2p155fe2cd5cfdb5b33c490548a813a9aa9
References: <20231031235530.1500393-1-chanho61.park@samsung.com>
 <CGME20231031235553epcas2p155fe2cd5cfdb5b33c490548a813a9aa9@epcas2p1.samsung.com>
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

This imports mmio functions from Linux's arch/riscv/include/asm/mmio.h
to use read/write[b|w|l|q]_relaxed functions.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/riscv/include/asm/io.h | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index b16e6dfa3760..4170877a1ae0 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -323,6 +323,51 @@ static inline void writesl(unsigned int *addr, const void *data, int longlen)
 #define insw_p(port, to, len)		insw(port, to, len)
 #define insl_p(port, to, len)		insl(port, to, len)
 
+/*
+ * Unordered I/O memory access primitives.  These are even more relaxed than
+ * the relaxed versions, as they don't even order accesses between successive
+ * operations to the I/O regions.
+ */
+#define readb_cpu(c)		({ u8  __r = __raw_readb(c); __r; })
+#define readw_cpu(c)		({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
+#define readl_cpu(c)		({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
+
+#define writeb_cpu(v, c)	((void)__raw_writeb((v), (c)))
+#define writew_cpu(v, c)	((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
+#define writel_cpu(v, c)	((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
+
+#ifdef CONFIG_64BIT
+#define readq_cpu(c)		({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
+#define writeq_cpu(v, c)	((void)__raw_writeq((__force u64)cpu_to_le64(v), (c)))
+#endif
+
+/*
+ * Relaxed I/O memory access primitives. These follow the Device memory
+ * ordering rules but do not guarantee any ordering relative to Normal memory
+ * accesses.  These are defined to order the indicated access (either a read or
+ * write) with all other I/O memory accesses to the same peripheral. Since the
+ * platform specification defines that all I/O regions are strongly ordered on
+ * channel 0, no explicit fences are required to enforce this ordering.
+ */
+/* FIXME: These are now the same as asm-generic */
+#define __io_rbr()		do {} while (0)
+#define __io_rar()		do {} while (0)
+#define __io_rbw()		do {} while (0)
+#define __io_raw()		do {} while (0)
+
+#define readb_relaxed(c)	({ u8  __v; __io_rbr(); __v = readb_cpu(c); __io_rar(); __v; })
+#define readw_relaxed(c)	({ u16 __v; __io_rbr(); __v = readw_cpu(c); __io_rar(); __v; })
+#define readl_relaxed(c)	({ u32 __v; __io_rbr(); __v = readl_cpu(c); __io_rar(); __v; })
+
+#define writeb_relaxed(v, c)	({ __io_rbw(); writeb_cpu((v), (c)); __io_raw(); })
+#define writew_relaxed(v, c)	({ __io_rbw(); writew_cpu((v), (c)); __io_raw(); })
+#define writel_relaxed(v, c)	({ __io_rbw(); writel_cpu((v), (c)); __io_raw(); })
+
+#ifdef CONFIG_64BIT
+#define readq_relaxed(c)	({ u64 __v; __io_rbr(); __v = readq_cpu(c); __io_rar(); __v; })
+#define writeq_relaxed(v, c)	({ __io_rbw(); writeq_cpu((v), (c)); __io_raw(); })
+#endif
+
 #include <asm-generic/io.h>
 
 #endif	/* __ASM_RISCV_IO_H */
-- 
2.39.2

