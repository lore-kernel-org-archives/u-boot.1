Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587BDC001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 05:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF4B86CA1;
	Fri, 18 Aug 2023 07:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="vgxWIz7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7AC86751; Fri, 18 Aug 2023 07:26:57 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD3D86C1A
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20230818052647epoutp02d4ac34c03f3941ceaba7dc548ecba5f5~8Yv753RHg1499614996epoutp02i
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:26:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20230818052647epoutp02d4ac34c03f3941ceaba7dc548ecba5f5~8Yv753RHg1499614996epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1692336407;
 bh=uDzWPFCDOsoiJkjwClhW5DcBugInZMZ5f9BMdXULWeg=;
 h=From:To:Cc:Subject:Date:References:From;
 b=vgxWIz7/mnREQDiMe++AjrZ9Uhb9RtsRIxW4sr6z64BO6yz4FclXlASEJcggeOAit
 TXAtzxEsIATfKvuR++HelHTJMH4baKTBPxGvplQP+rL9cJnSjtNk281yiZ/6Hqdr9+
 VwcC7tLVm2Elxa3OLK6KQ7R5MHbNrMzEgnLd9DQE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20230818052646epcas2p331466a8153a9cb5e991f10fea95ecfc1~8Yv7ali4N3220432204epcas2p33;
 Fri, 18 Aug 2023 05:26:46 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4RRr2t0wslz4x9QN; Fri, 18 Aug
 2023 05:26:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 E2.B2.40133.5110FD46; Fri, 18 Aug 2023 14:26:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20230818052645epcas2p47dad71943937119bbfe3652d178d769d~8Yv6kbthJ1909919099epcas2p4g;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20230818052645epsmtrp16caf559d19cdba5ab1cf62ab9b0e06e7~8Yv6j2kpu2945329453epsmtrp1E;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
X-AuditID: b6c32a46-6fdfa70000009cc5-9f-64df0115b8e6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9E.45.64355.5110FD46; Fri, 18 Aug 2023 14:26:45 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20230818052645epsmtip1046fee45fe769d79219cd6a36b32cd74~8Yv6UHGo61074210742epsmtip1k;
 Fri, 18 Aug 2023 05:26:45 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2 0/2] introduce EVT_DM_POST_INIT_R to fix VF2 boot fail
Date: Fri, 18 Aug 2023 14:11:01 +0900
Message-Id: <20230818051103.2427590-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmha4Y4/0Ug9ObmSwu79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFHZNhmpiSmpRQqpecn5
 KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAe5UUyhJzSoFCAYnFxUr6djZF
 +aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2Rm7F7WwFzzgrNg/Zy9b
 A+Ncji5GDg4JAROJU89Duxi5OIQEdjBKbLj0jhnC+cQo0bJuCguc86ipm7WLkROs48rGJVBV
 OxkluqacZIJwpjFJ9G3byAJSxSagK7Hl+StGkB0iAuUSD88YgISZBbQlOj9PYQexhQU8Jb6e
 +skEYrMIqEqc2/8DzOYVcJBYdLebDeI8eYnFDyQgwoISJ2c+YYEYIy/RvHU22A0SAtvYJX6v
 P8kMUe8i8fhjAMSdwhKvjm9hh7ClJF72t7FDlJRL7FiWBNHawijR3LaHGaLGXuLHzSmsIDXM
 ApoS63fpQ5QrSxy5BbWVT6Lj8F+oKbwSHW1CEI3qEge2T2eBsGUluud8hgaUh0TnpNlgBwgJ
 xEpMmf6UfQKj/Cwkv8xC8ssshL0LGJlXMYqlFhTnpqcWGxUYwSM0OT93EyM42Wm57WCc8vaD
 3iFGJg7GQ4wSHMxKIrwWTPdShHhTEiurUovy44tKc1KLDzGaAgN3IrOUaHI+MN3mlcQbmlga
 mJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXA1CNwv98yalXvApdpAndOu5UE
 WQfv1X159lOgaBhPesvLny/vTpFh2XKE+2VQsJEDv3LYuZRJqeovVbWkf0QpTZip6MMWN33O
 NYF/lkZ1MxOPi9gpzZ24T0NnW+q8XsX5HxZyntrb9vwfpxznodd1/xZsm6g+eYpDLbfB0UVM
 IrbTGbOFc2e8PLVbiHWtqtak8xYRU39NbLmy2qQyaHrM/CiBTsechQLOly/+Uds1U0+5MF8w
 6p3fwYa73syivW1KeYIfrl75Ft/bVOHT//fobYbUtbcr4nYJnmvKP74oQtJlvmTJq2sPDVfH
 Cl2/f8Ul4/PXK89fFl/bvzXpYWiAuLx4k6Nd0+Rq77sOQVxRSizFGYmGWsxFxYkA3PCsYv8D
 AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSnK4o4/0Ug30zNC0u79e2ePviLKPF
 ty3bGC3e7u1kt3h86DWTA6vHntOzmD1mN1xk8Th7ZwejR9+WVYwBLFFcNimpOZllqUX6dglc
 GbsXtbAXPOCs2D9nL1sD41yOLkZODgkBE4krG5cwg9hCAtsZJdYtZIaIy0o8e7eDHcIWlrjf
 coS1i5ELqGYSk8TJqYtYQRJsAroSW56/YgSxRQSqJX59XcQGYjMLaEt0fp4C1iws4Cnx9dRP
 JhCbRUBV4tz+H2A2r4CDxKK73UD1HEAL5CUWP5CACAtKnJz5hAVijLxE89bZzBMY+WYhSc1C
 klrAyLSKUTS1oDg3PTe5wFCvODG3uDQvXS85P3cTIzj4tIJ2MC5b/1fvECMTB+MhRgkOZiUR
 XgumeylCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTC1r
 nI5qX33qqGffNrFavTx8x8n9rE6Bp29OPPaQx/F00IIP292cddcL8uXdOrJV5LS6//HjDr9y
 rspLzY/akdZ3eaFL4Z3Vf+7ecXi5U/rhKt8a34CWkydZ3s4vT3v0WlRp+q753A8TU7I4Xb02
 zJTTPqfPvGz3RZ7XiUda92pNmDjt/uQrJ7drli/VmWiTd+H26bh90W+2pu83f2w457v0wm0v
 L8olp/nM/fjVwVpI/nbJwYcRUxevyZ7Bs0rCj99st3wz85X0N9c5f9oxf9n3q+zt+VX3eidp
 hX3fMz1R8P+bSwtS9Ut+FgQsDXu+pUTapNL0T+accxvdP7tIz9pY/FEmf83UxNfmgZ6WyaUf
 lViKMxINtZiLihMBJvqn8a0CAAA=
X-CMS-MailID: 20230818052645epcas2p47dad71943937119bbfe3652d178d769d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230818052645epcas2p47dad71943937119bbfe3652d178d769d
References: <CGME20230818052645epcas2p47dad71943937119bbfe3652d178d769d@epcas2p4.samsung.com>
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

We can reproduce it on Qemu Sifive HiFive Unleashed emulation[2] after
enabling CONFIG_TIMER_EARLY manually.

As suggested by Simon[3], we can address this by adding
EVT_DM_POST_INIT_R event and it's spy-callback function.

Changes from v1:
- Add EVT_DM_POST_INIT_R event type and emit it after relocation
- Make riscv_cpu_probe as the callback of EVT_DM_POST_INIT_R

[1]: https://lists.denx.de/pipermail/u-boot/2023-June/521220.html
[2]: https://www.qemu.org/docs/master/system/riscv/sifive_u.html#running-u-boot
[3]: https://lore.kernel.org/u-boot/CAPnjgZ2PbHVY_WLVq7XCd-HYKKwoh8R3LGXfOo7S6Sbvj0+ETA@mail.gmail.com/

Chanho Park (2):
  dm: event: add EVT_DM_POST_INIT_R event type
  riscv: cpu: make riscv_cpu_probe to EVT_DM_POST_INIT_R callback

 arch/riscv/cpu/cpu.c | 11 +++--------
 drivers/core/root.c  |  6 ++++--
 include/event.h      |  1 +
 3 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.39.2

