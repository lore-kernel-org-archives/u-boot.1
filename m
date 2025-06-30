Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2E7C8302D
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E60B081FEE;
	Mon, 30 Jun 2025 12:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="kLyY5Vhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286E681E13; Mon, 30 Jun 2025 12:53:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 393D280B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1751280816; x=1751885616; i=fiona.klute@gmx.de;
 bh=GL0SAmLLALjFb4t9xNpsSGYNKuKfNB62R2ZVURSgfR0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kLyY5VhdRt90AqhwN41V9mmPkdc+kNlocK36kVrIf8rZmCik4qtAjoGPJTgj9Dsg
 TL2lAjjeAvNQiORWVESEb1hCh9SRm4mWioyXmBMb7Q1RsRgSxGmPn+ssKe4w9NtkQ
 JCPYCJHOVxHDCsw3V3U4lRNg9uqGdG6QwlYLqbL3hEBE9Il0zd0bexhDmlrBzHmdU
 s0ZgUsgxawE/QMz5FeH4VrISRNSJK7gxXrgdilyyiERRwzrDYCNMqF3nZh3BQS1fN
 eAJkEzu4ADL1KJjJ0Fm239aQ2ft4guxrCjDIdmCEPRTae3ZLCgO8XQhLWdm5uVrvI
 GI/1ldieHG0wA/SNhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.121.243]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1uAvzD1uEx-00N3uw; Mon, 30
 Jun 2025 12:53:36 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 0/3] Move PXE boot from README into online documentation
Date: Mon, 30 Jun 2025 12:53:20 +0200
Message-ID: <20250630105323.1346850-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:kH3O8Fm7qQpnEVBg44sopBxuByCO9HLZpUruwqPA86ftlnDGAR2
 Mb/0IZpcyBEJDCtJvedLmFMQAnN7b4pxQ97i8DL8wVkIcu8Dhn+4LSXS4K/1ilBPpf5Q40I
 Pn/rIwn3kvZHKIWyXHl/yoGFcoMGXXqb50gW25s3EPOr7/fBqyI18KW/5BCbdaiKvWohBbk
 2e3rLsh1XyX9K1KVHyVGg==
UI-OutboundReport: notjunk:1;M01:P0:nA2Wm3Ui1yA=;N5eAH4k5chiOb3cRtowlusILlRQ
 hLl5aCHCw/1GFwB3niLvjy9xVgzZhzs9HbOfW/IJYR3e01TAZzrAceQIc/3C6N1Rfzr0QNSR4
 hx4FPpgUrnnKhHiwtUDXRb2/0y4FDkCOCSvinr2GRHcb3QJ/V9KhNqCfqywPGI9Wwb15Q5npZ
 eXU7ozsqkn2bzJJZoHvqx/9Wh4dM6Q+TOBiaJaS9aYyIq3nXj94mgVrxYrqhXX46lZYQFJJCg
 hVj/gIqfiM3ZcA+mdZrsk4Ka67BT4xyBliOTQaAYF17Z0hAnqGxUxu55xcvBJVI0Kn0WasIMW
 TFBvFe9AL1Cn4afaTFL+eorSn4t7O3cxVkIp3D6rAR8dpNomQ9gVjrA4jWfvMc1/E62R3gv/E
 +uhb8g7lasTY4VVjTOcEqmKwRaQIirb0S7gBozkhJIfBjfjEhLE+drUO/VVHFw+vL6sTy1pRz
 HXICqDt6EsY6dtuBFzVqZSPmN3ujVDONCeT+0xEwmhNUW8RX9FDlHL588SzbHZkl1OP0x9Sk1
 +5wynfNCcIzRVghTVnCVgNUQUcGNUxg/4MO681p5wNHgYZzweJBzWNanWedk7siKl0lt8WZ03
 sJiodX/BGqQ3Sjmd7vw2jPVDs4VaZUSXy/afdEvoLBjS9EhN1MaHbYuZX8htdWMR9WX8dqvOK
 3Qzb7mjGz0redHCUbyx19K60DbQd0TnDnUuIZ8Zwf3gBAJXfRvELb9jjoeX54jrkpQMjFthFz
 IooNSXOoefW6br7XXkWOtBrOHsFrgtt0XcteTPqeh9bMKXi5Kl6H+HEKwSwCdpjLA2x6EHjv+
 YJY7Dcq+cJ0quQpaGVZkg+M7+uof7TKuiP1TCP57ANenM2U5n9FmxFM814XePJvInuEnQESIy
 mXpCP4m43VIQYDn3Hw1mE1VTTSv0Bgdq9kWUAii6Ys237QBJkQNj3re1mnbJUSj/EY9hWYEAv
 +lmFA4mIrabB9ATPpLwk1XbnYF3lovVAivCK1uyvQLQ4RshYCtZd1XaL58XRpENTXeLf8iRla
 vf57EaM7Ln0Hir7OFuxhTBH40ZC0yZmCuku2sDhg7DL2+Lp1DdQh9SUiF7XE+lvNNh4cdvXwY
 6uvS7hv8DjpfpUEtRsjTk4g/SGpjbgTYEtEKr56n4RhqjXLcpR5IVVfHrjSGRtk42KNb/YhX2
 W7EkB+sYMmJbKE3UUSWk7D4NeMDzzkMsCMAhXyh6FEtWj/O3Fdf5JYwWoYu/nFkgbw89QcDvn
 ilEiJO2nF4kB+jib1aCC3nv61MORrjyv7tYZhIevRm+l1vf53fcwYBTbfypqH8/H/H6VJRwnm
 YQ1xgEmuyUGXAH3OXQPBRM6XX2FYHFKcBVwRdd+QmirAXSVTmiRxYbeLQySNb/oqLtUp3G0dd
 gPUJyYHCyH6PN14wTJEm57qBOE0UKuNFACixxdRqis4zCzVxHZ0fleFx6uanCSkCwLyogOoF3
 XSgoEfA6oL5u6zRj8SNBY9htH51BbE1QH4bjZ40CkQq0thdwDxYRAF+malkdtyGYUs9mQMnlU
 ZSEsv7VWV/VmLJq4JQbveWq8uS/OybQh1SMO1dWITVamEbXXmr5lK652aMq/LGO85e3ieg4EN
 fhrbgUpCoI8DckmZ1e/zg3EaIGUKAC+x4EhKNM+sjyWizLG777NH8q27ybHkA4Q7U92TaLel2
 W30alVATTxI0859MjcznTI/jjThQHYNQ10qo26l4Ox6ELlTTnZCwQT0UkEBZ50bSqnhK4W3+A
 eXM5acNEjiAWCEL5JvjyboKn9HJpZAYi344exaYELkeUpkIPzt7zLxLR8qbswg4rcMck8seJ5
 ImJF1A2vS8n4L7JGOXkkxdxYgkgywvUp4WWOmw3o+PedXYx2Tcxn/Px+3+C9bgTk3Gc5+P31O
 Dw0bInidQ6ad535h8a058zM7c67d9PFQSWMtcnPMoaGr0AEbUWCphLKw+/Bx4fPm3KkEM/T80
 nvrVTQKw6pWbOZA5jqUHn9rYUr9eOeD6ljJGbv51L5Z5EK6pqMVWAQoG/10rsOirQHVRdvp+X
 PIxNMqiBRKKar8DslmHnZo2feFADOZfjnZW+i6VuBZnsFhKeL8z4DJzUBGfEp321H0f6C+tnP
 Td39kxXhim46Jgf48r5Rhbh7AxtWgL8yyTqZXSyzdRaPeF+rkrNQvI6xoPa0LyH9/O02oob3Y
 I0kOgaf7Ysj0LMHbPwwIaUbft3OltOOEiB7Gdp3qg+nmkFEkx6gc1Wep0TVj+s3a8c7nQah8w
 pPWdrHvSm2bCS6k8kucRX8Aqub2gQ5rN8g4o7RnhUwAo2pi/Z8FnuI4v9pX6+DL6Rv4dFHq2T
 MwiqtcdnjOkCfNhlANYoZ+xoH97yNowdalrqkVOrbcZtRf3MzLRu+Hg7gXVz7D+Ps/4ubefMr
 G0v45kqN+K1fdwQCl4sMUaspJMz8i33NIzgDb1Fqgp9N+ZvtWgXRbXjiptKxtgiSaKdhp6Dvt
 0ZRoEuH6SXbpx76XVDmJANmQxDpdSMXsCS1pPCZh94uSiHsbyeqp6LkSWsjDQRkurPj1aPJu/
 SD/gI8uoSbC72DgjQWwsVeL9I+/Ualn47vFiMiR6PigHqXdSuj1Pw5c71dL9ImWu7SqYrdN2c
 vO9/9WBfQzAgbt83tlORA+XxGtpmVKNcjvmWpKVvGJnMqAlwnwEfG1RjA/emQQ1r0vB6bjlt8
 xuoDfIQscJ0FhugstaBA66cuxig3twH0Y7iHN5eWuPfVSlQ0KOSyDgKli8Wx3iSrobeMexpNG
 RKMAQKZHsDY4CJpUQ0Y1LfgKWeHmNvoFTpFUVkx+/TykiRt/ByIA0RjEa1LNcWVUk3/HznHEI
 w+SG2KHmxOIv2v0hdJHCciZSkffwPrbs+zlPMr19UomjRPM3Sw5VkiS3fucQnO4aZ4z0KtYAH
 8NV2ZgDSK4+i9zkSZJv4zXJ1kLUIOeJxaapSX9s7/wyNTgFgTmfDZhJ/fX4lOj5asUMlwYUJa
 xNpbvmLFS3t/QnaOkuCogORWPl0/4bAZ/7XjiskTPoQ/oqJgsOt2AFdVs0+ktRCYh8Vf+jA0q
 WlWKJGUnFBH8ZiDe9v8V0Z+XGQak80P8LvTYXyWp2y6YhZ+FjX7EZAc/khv1A5vcGJyhRzZ1L
 jzPJPhxB8iS4Q3WXad1zSnxc5hCotCW/0J6l2XBJtph+5lhyXNdZr4/xnqCpBCNTUa3OCpaqa
 L8X5WR2YYw2YFyIjZc6ijIpAXDHyoZggeOeDdYoAQYHZqNQd43Dr9SD68NMs6JBC4rewM0Onq
 0S98cwHbJq+wFua44YwM6+8WFuIBlHT+1ZyL9q0nESKpzRnb9WfyGlaSvOhAsJRQ7Vj/hMGM3
 NBrLR22XQoMFp9EeZf4iQgGbXqN21KjidxdI8XWwqEMpwMiy6l/Ecx6DU4S5aCel4l2boe7DC
 lpCy8PA/ZArxbJcdHKwMemeYutcLFDyHCWPuRaWM2kSmhpZR9t3ky2JbcW09XTRdkyHiO5Vra
 f4g7KGxjbpTmHV1/krhmJiaxc2SsxQ3MKNlVVshlQj58dwEg8+u9O
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

VG9tIGFza2VkIGlmIEkgY291bGQgbW92ZSB0aGUgUkVBRE1FIGludG8gdXNhZ2UgZG9jdW1lbnRh
dGlvbiB3aGVuIEkKc2VudCB0aGUgcmVjZW50IHBhdGNoIGFib3V0ICJhcHBlbmQiIGluIGV4dGxp
bnV4LmNvbmYuIFRoaXMgaXMgbW9zdGx5CmEgcmVmb3JtYXR0aW5nIHRvIG1ha2UgaXQgZml0IGlu
IHRoZSBSU1QgZG9jdW1lbnRhdGlvbiwgSSd2ZSBhbHNvCmFkZGVkIHRoZSAic3lzYm9vdCIgY29t
bWFuZCB3aGljaCB3YXMga2V5IGZvciBtZSAocGF0Y2ggMykgYW5kIGdyb3VwZWQKdXAgZW52aXJv
bm1lbnQgdmFyaWFibGVzIChwYXRjaCAyKS4KClRoZXJlJ3MgZGVmaW5pdGVseSBtb3JlIHRoYXQg
Y291bGQgYmUgaW1wcm92ZWQgaGVyZSAoZS5nLiBtb3ZlIHRoZQpjb21tYW5kcyB0byB0aGUgU2hl
bGwgQ29tbWFuZHMgc2VjdGlvbiwgcmVkdWNlIG92ZXJsYXAgd2l0aApkb2MvZGV2ZWxvcC9kaXN0
cm8ucnN0KSwgYnV0IEkgaG9wZSB0aGlzIGhlbHBzIGZvciBub3cuCgpCZXN0IHJlZ2FyZHMsCkZp
b25hCgpGaW9uYSBLbHV0ZSAoMyk6CiAgZG9jOiBtb3ZlIFBYRSBSRUFETUUgaW50byB1c2FnZSBk
b2N1bWVudGF0aW9uCiAgZG9jOiBQWEUgdXNhZ2U6IG1vdmUgZW52aXJvbm1lbnQgdmFyaWFibGVz
IHRvIGEgc2VwYXJhdGUgc2VjdGlvbgogIGRvYzogUFhFOiBtZW50aW9uIGV4dGxpbnV4LmNvbmYg
YW5kIHN5c2Jvb3QKCiBkb2MvUkVBRE1FLnB4ZSAgICAgIHwgMjkyIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KIGRvYy91c2FnZS9pbmRleC5yc3QgfCAgIDEgKwogZG9jL3Vz
YWdlL3B4ZS5yc3QgICB8IDM0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzNDcgaW5zZXJ0aW9ucygrKSwgMjkyIGRlbGV0aW9u
cygtKQogZGVsZXRlIG1vZGUgMTAwNjQ0IGRvYy9SRUFETUUucHhlCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZG9jL3VzYWdlL3B4ZS5yc3QKCi0tIAoyLjUwLjAKCg==
