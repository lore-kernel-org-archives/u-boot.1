Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6626CC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 06:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A300890E1;
	Fri, 26 Apr 2024 08:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="BNf0Bf91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFC189106; Fri, 26 Apr 2024 08:27:43 +0200 (CEST)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18E189092
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240426062735epoutp046ff89431a6a8d7fbd9023d4667918eca~JwI_KdR2M0568805688epoutp04M
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 06:27:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240426062735epoutp046ff89431a6a8d7fbd9023d4667918eca~JwI_KdR2M0568805688epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714112855;
 bh=yT8pnrTTfIPiT4syilZVekt1aCyb6WKSgf/4+JwCJ3E=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=BNf0Bf91n4oGw24xhEBwA3ek562EMQluv8c+RwBtSlz8CPgYmp3PG8KfqJja1St/5
 wPyCqrkV/TKlSh53Nnpe4RF0KkarrE3DW5drNjgDsqq42aXYPXZF0ZYmuUFdCsFlPa
 CUCkMfGm5RVl/n9OIzBnWb8Yms33AGc9fccCw09c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240426062735epcas1p2d90dcd893a150ab024e1131a4d0f5b6c~JwI956nkU2169321693epcas1p2n;
 Fri, 26 Apr 2024 06:27:35 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.136]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VQjSk5V3Gz4x9Q3; Fri, 26 Apr
 2024 06:27:34 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 BC.93.10076.6594B266; Fri, 26 Apr 2024 15:27:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240426062734epcas1p3393971695051450b70f490f569efd831~JwI83Ezv63225632256epcas1p30;
 Fri, 26 Apr 2024 06:27:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240426062734epsmtrp1077132d30e79bb449642e3b7ec8dcc06~JwI82WpE20914809148epsmtrp11;
 Fri, 26 Apr 2024 06:27:34 +0000 (GMT)
X-AuditID: b6c32a39-7edf87000000275c-3b-662b4956be85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1F.75.08924.6594B266; Fri, 26 Apr 2024 15:27:34 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240426062734epsmtip10738ea731be0e823ed4d7dd415d665dc~JwI8sXZ7y2342423424epsmtip1c;
 Fri, 26 Apr 2024 06:27:34 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
Cc: "'Peng Fan'" <peng.fan@nxp.com>, "'Simon Glass'" <sjg@chromium.org>
In-Reply-To: <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
Subject: RE: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
Date: Fri, 26 Apr 2024 15:27:34 +0900
Message-ID: <000001da97a2$d3247950$796d6bf0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFhA7XuusjSORLPiS0WG04V0LW/BwFhpEL9AsAUzzWyTC/80A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmrm6Yp3aawZt/2hYdd2+xW/xY9YXV
 4tuWbYwWb/d2sjuweMxuuMjicfbODkaPnbP3MXlsfLeDKYAlKtsmIzUxJbVIITUvOT8lMy/d
 Vsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2inkkJZYk4pUCggsbhYSd/Opii/tCRV
 ISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK0MDAyBSoMCE749TXXYwFR9gr1v58wNrA2M3W
 xcjBISFgInHjGVMXIxeHkMAORokFt1sYIZxPjBLnDjUxQzjfGCX23fjCAtNxpdEMIr6XUeLz
 0xY2COclo8T0q3fYuxg5OdgE9CT+L1rIDGKLCLhK7Nq2mBHEZhZwl/i7YCkriM0pYC/x6t42
 VpChwgIeEo8Om4OEWQRUJXbu+MgEYvMKWEp0TLoHZksIKEj8fLqMFWKkk8TrJz9ZIEaKSMzu
 bAM7VELgFLvE5HcrmCEaXCRWNdxig7CFJV4d38IOYUtJvOxvY4doaGaUWLrkICuE08Mo8a/h
 OlSHscT+pZOZQK5jFtCUWL9LH2Ibn8S7rz2skJDglehoE4KoVpG49PolE8z8u0/+s0LYHhLb
 J26FBuk5RonGbzfYJjDKz0Jy+CyEDQsYmVYxiqUWFOempxYbFpjCYzI5P3cTIzitaVnuYJz+
 9oPeIUYmDsZDjBIczEoivDc/aqQJ8aYkVlalFuXHF5XmpBYfYjQFBuVEZinR5HxgYs0riTc0
 sTQwMTMyNrEwNDNUEuc9c6UsVUggPbEkNTs1tSC1CKaPiYNTqoFp9kW7yFln0rfdNllUbFZc
 7L/7zM5tMrNWruWOLkt3uJjCIeRj++qaz23FZZ+zuz9KtybnF76dKnGbq18y0fNKY+Sp/5JO
 ezzVLyW/618Ye2X9PkmB9yuypVZ3VPkts/tw8W3/+5J/e7i+SB+cFzf7mfSjeKfjTpMrjudb
 Li7q7Zzo49nbcJD9QqRO4mrPmBeLf3G+Fd4jseNz0zNPTob3Lqzzr+1J+8Kz98O5zSL3fzPl
 HNPwe7aEMcUkrp5Z6eGJo0q/bgR1Jc0+zhdT7HmkfrbN8r2TfItKqqO02hTPmS7L+Tp7msNR
 g/OP37w5NMOiWmvKYp2Dh5pe/eTkYN/x6XvJiibNjEkVOnef3ojsVmIpzkg01GIuKk4EAK3E
 b0X0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnG6Yp3aawZGZMhYdd2+xW/xY9YXV
 4tuWbYwWb/d2sjuweMxuuMjicfbODkaPnbP3MXlsfLeDKYAlissmJTUnsyy1SN8ugSvj1Ndd
 jAVH2CvW/nzA2sDYzdbFyMEhIWAicaXRrIuRk0NIYDejxLJvNiC2hICUxOenU6FKhCUOHy7u
 YuQCKnnOKNGy/jEjSA2bgJ7E/0ULmUFsEQF3ibUPPrKA2MwCnhIbF05lgWg4xShx/N17JpAE
 p4C9xKt721hBhgoLeEg8OmwOEmYRUJXYueMjWAmvgKVEx6R7TBA3KEj8fLqMFWK+k8TrJz+h
 5otIzO5sY57AKDALibuAkXEVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwSGpp7mDc
 vuqD3iFGJg7GQ4wSHMxKIrw3P2qkCfGmJFZWpRblxxeV5qQWH2KU5mBREucVf9GbIiSQnliS
 mp2aWpBaBJNl4uCUamBaGlFyJUZfgdenKPhwFlOGcgf/ymO8O4rXXS3sW/nOuJ7Zz//O8QbW
 mGNTrHf/sP4vbOh49pmxYJ/FA3MV3ftfr1jlqxtMNOm+V36Wg8fbuYWX/5XviWqHubHntI8f
 SNR41bGo9NPLzbMjjzE//qwdfvu2XdUc25UTzV6EOmf+fHBhZf5CEc24+Kx5PpvDwnJXcwS5
 5XswLtLZu0/Eb/Oeqjy3h7FqHWk7A9dz9Pj3OnivO/M37NT6ltU+612eJzb/szubpvhomqfG
 tmYGdpnQM+W1KZvuv9m65XrmEfaIyLTnfQqnntTzT3q4tULST/ld2fyTb3d3qO05FrZ9t5/L
 6vaq6zbqmjf2CjzurldiKc5INNRiLipOBADIwex+uAIAAA==
X-CMS-MailID: 20240426062734epcas1p3393971695051450b70f490f569efd831
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470
References: <20240316201416.211480-1-marek.vasut+renesas@mailbox.org>
 <CGME20240423231800epcas1p4e21bd06153b2394afd9a8696a4df6470@epcas1p4.samsung.com>
 <fab40e09-1ac4-45c3-8dda-f0a1544d2d39@mailbox.org>
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

Dear Marek,

> -----Original Message-----
> From: Marek Vasut <marek.vasut@mailbox.org>
> Sent: Wednesday, April 24, 2024 8:18 AM
> To: u-boot@lists.denx.de; Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>; Simon Glass <sjg@chromium.org>
> Subject: Re: [PATCH v4] mmc: Poll CD in case cyclic framework is enabled
>
> On 3/16/24 9:13 PM, Marek Vasut wrote:
> > In case the cyclic framework is enabled, poll the card detect of already
> > initialized cards and deinitialize them in case they are removed. Since
> > the card initialization is a longer process and card initialization is
> > done on first access to an uninitialized card anyway, avoid initializing
> > newly detected uninitialized cards in the cyclic callback.
>
> Any input on this ?

When I have applied your patch from patchwork, it didn't apply directly.
If you're ok, I will apply after touch your patch. Is it ok?

Best Regards,
Jaehoon Chung


