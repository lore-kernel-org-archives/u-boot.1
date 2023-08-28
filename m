Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7C5C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 09:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C296A864CB;
	Mon, 28 Aug 2023 11:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="bTSqaHes";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1779F8645F; Mon, 28 Aug 2023 11:50:00 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19B6864C4
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230828094954epoutp02f253d6bb787f0fc8f6b8c86d8f3bb61b~-gyhTCBbR2575525755epoutp021
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230828094954epoutp02f253d6bb787f0fc8f6b8c86d8f3bb61b~-gyhTCBbR2575525755epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1693216194;
 bh=O2CsP5j8ebJmi0fqQVx/PUPQKKyQtpSacNziPbIUV2Q=;
 h=From:To:Cc:Subject:Date:References:From;
 b=bTSqaHesisYtiO9ZrwCWKGjuqlsmEAU6jO4R0UGptypeBgpgZy2/T6E18Wrj6tACY
 SPAzj0k+aMlyltjWlIZlbLbmZA5aSkGdYx9iamJYjrhBFq0pHgqENldASCbWMpG56r
 wMYbJsYPgzu5u4oJNMkK1X5Zb5g3A93m/H1S6Fds=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20230828094953epcas2p48b093d42f7e57d9838af0bffe2f81802~-gyg3lS5D3028630286epcas2p4i;
 Mon, 28 Aug 2023 09:49:53 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4RZ5Ps0Sngz4x9Pt; Mon, 28 Aug
 2023 09:49:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 43.86.09765.0CD6CE46; Mon, 28 Aug 2023 18:49:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epcas2p31c71a57ef3486cbd75f605057cc8085f~-gygDSZbL2467724677epcas2p3Z;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20230828094952epsmtrp2b479d13b4978863f6c73a79cecafccd6~-gygCi8GJ1352013520epsmtrp2y;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
X-AuditID: b6c32a48-66ffa70000002625-2c-64ec6dc06b94
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EF.A4.08742.0CD6CE46; Mon, 28 Aug 2023 18:49:52 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20230828094952epsmtip2bfd438dd1c865e48947bb6dd1e685a07~-gyfzbb_W2579525795epsmtip2l;
 Mon, 28 Aug 2023 09:49:52 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 0/3] bootstage support for risc-v
Date: Mon, 28 Aug 2023 18:49:35 +0900
Message-Id: <20230828094938.2061606-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmqe6B3DcpBl/f2Fhc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKKybTJSE1NSixRS85Lz
 UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
 8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjN+n1vLWDCRtaL71xr2
 BsbJLF2MHBwSAiYS75/mdTFycQgJ7GCUOL/tNwuE84lR4uyjX0xdjJxAzjdGiatn7EBskIYt
 +54wQxTtZZR4su81VMc0Jokraxezg1SxCehKbHn+ihFkhYhAucSxe/wgYWYBbYnOz1PYQcLC
 QIP+tfKChFkEVCX6Lz8C28Ur4CDx4vhRdojj5CUWP5CACAtKnJz5hAViirxE89bZYCdICOxi
 l9j8qZ0R4jYXiW3H97BB2MISr45vYYewpSQ+v9vLBjGzXGLHsiSI3hZGiea2PcwQNfYSP25O
 YQWpYRbQlFi/Sx+iXFniyC2otXwSHYf/Ql3GK9HRJgTRqC5xYPt0FghbVqJ7zmdWCNtD4vfT
 VmgAxkp035jOPoFRfhaSZ2YheWYWwt4FjMyrGMVSC4pz01OLjQpM4PGZnJ+7iRGc6rQ8djDO
 fvtB7xAjEwfjIUYJDmYlEd5Ljq9ShHhTEiurUovy44tKc1KLDzGaAkN3IrOUaHI+MNnmlcQb
 mlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXA5M6wdJfkM7Gu4p/Pcgyu
 Vez22mS2RiRsvuBV/hkHljDm1st8Zbsg+Vd8cUDg0Z9s2q8VjglFu/zl6J+o4+Ajk6LF8Z5V
 8S1jVseq293pZncq1WYYHzlluNz18ZWXi3coljPyMz56d4/bw/ZGtbTa/aikzUane9oPFFR8
 /t13JPHkinu8Xh1xx2uSYn5/flF+QuVBiuCHhbtfHsqXYlkyQ/OwUeT8hTe+S1kyvTvy6t+U
 iCu9wbsqLr/02LSUseP9zUSu7k/X5/WVNPQqNTzp1dnMbff+a4ltikjX068dImdvPKjXvj+L
 /apoy+zrh55Ok0uRfGWgkS5YdTdNeaH1yXkqfqc84hy/Ki6S1txcpsRSnJFoqMVcVJwIADOT
 z5v+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSvO6B3DcpBot3aVpc3q9t8fbFWUaL
 b1u2MVq83dvJbvH40GsmB1aPPadnMXvMbrjI4nH2zg5Gj74tqxgDWKK4bFJSczLLUov07RK4
 Mn6fW8tYMJG1ovvXGvYGxsksXYycHBICJhJb9j1h7mLk4hAS2M0o0d3ziA0iISvx7N0Odghb
 WOJ+yxFWiKJJTBL/jjUxgyTYBHQltjx/xQhiiwhUSzx/tAOsmVlAW6Lz8xSgZg4OYaAN/1p5
 QcIsAqoS/ZcfMYHYvAIOEi+OHwUrkRCQl1j8QAIiLChxcuYTFogp8hLNW2czT2Dkm4UkNQtJ
 agEj0ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOAg1NLcwbh91Qe9Q4xMHIyHGCU4
 mJVEeC85vkoR4k1JrKxKLcqPLyrNSS0+xCjNwaIkziv+ojdFSCA9sSQ1OzW1ILUIJsvEwSnV
 wBTpP/+hj9x+ba+pr7r7ZOcLXEkLuxnxyvigzJrZCoc2/Hi5vW0VF5/pLLYLy5p0Ppla+zQe
 csyR23nmpfql2Re852yRilf8/P2e2ZaYDg7piHfLz6h2zNVXnxhksE71Ck+aqqOuwt87Hi/s
 Gz0ePzz35xHH9KVm2ge4b6hPS5ZcsvP9tBd/n4RrOl6aN6k88umEP9NFV3GIVIoW59zo+Phr
 vaLQcj65nyxclY3p55IWJKmZ7n317VNa+NO7jxW2fS7sOvR7UfA6xbKHot+1JJpu7A7ebtr8
 Srtwugf3mktzzppl3K1cMn32jr98264FppirHv69I8Rla/jS42oSXF2tanNrtaofJR09kHDl
 XWOqEktxRqKhFnNRcSIAp4q7Q7ECAAA=
X-CMS-MailID: 20230828094952epcas2p31c71a57ef3486cbd75f605057cc8085f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230828094952epcas2p31c71a57ef3486cbd75f605057cc8085f
References: <CGME20230828094952epcas2p31c71a57ef3486cbd75f605057cc8085f@epcas2p3.samsung.com>
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

This adds to support bootstage for risc-v. timer_get_boot_us function
is required to record each boot stages with microsecond timestamp.

Changes from v1:
- Correct #ifdef guard for riscv_aclint_timer and riscv_timer

Chanho Park (3):
  riscv: bootstage: correct bootstage_report guard
  riscv: timer: add timer_get_boot_us for BOOTSTAGE
  timer: riscv_aclint_timer: add timer_get_boot_us for BOOTSTAGE

 arch/riscv/lib/bootm.c             |  2 +-
 drivers/timer/riscv_aclint_timer.c | 22 ++++++++++++++++++++++
 drivers/timer/riscv_timer.c        | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.39.2

