Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96205CFD312
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 22:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201ED83B5B;
	Sat, 22 Nov 2025 23:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hyt8Nzkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC3D83A36; Sat, 22 Nov 2025 23:17:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BD483AEF
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 23:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763849875; x=1764454675; i=xypron.glpk@gmx.de;
 bh=2gqohzZe9xz3kPn04ameOBzOmsjE8Pnm1dthSNR8G4Q=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=hyt8NzkwbRPeH1mn8uzXZUV/V7U2NRyaR8Vo6urAT2xXwP47vcaTjvkS3T70+w7Z
 WiyHSGI2ylFUBZHTwkdUSsm1e7d/8KjzaMLVyc9EdKzWxQgyDNWdXGG3K1scFJYxs
 O4EvVETmH2qfec3W/MHzOdhmff90SAL3P+m7Hbs8IwtKIZrShG/E71L/08CrJwYHE
 gAdI7t5sAp7ghtlyBxYDbmaoOKrv71HZJEYUPk72u7NPheIW2JEj4Mh5/rXkfQC7j
 CnfDkLFdr5BxoDpOO+zs56D3UfU0fXwevZRFVoxUr/qPGbc1uMRUF9WlOQe1yDcMB
 ZTmApXNDVFiaORjLAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from LT03 ([46.114.110.111]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1vJIlY2NSZ-00H5EP; Sat, 22
 Nov 2025 23:17:55 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 2/2] doc: add a page for downloading the U-Boot logo
Date: Sat, 22 Nov 2025 23:17:38 +0100
Message-ID: <20251122221738.238704-3-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251122221738.238704-1-xypron.glpk@gmx.de>
References: <20251122221738.238704-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:962r7ubFngPHiFiiyJQuaj9Z8JA2qA3NojnfLbwJcWFcZTZVADi
 RMntDtGXzKr5F7ZlIa/gUF49wp3haCyqc3y8sCfagQpiJH+PG+p7IJCEA02zigOpVdr0P0z
 75HZBBGmkdEAsP5vAsbAIJx27FsoX4jsHiJNWgCANZfNPz/2Hsqe/GFGghgVCWY1CIM3Uja
 QISh2SoJBqYgVQ7YJ0wdw==
UI-OutboundReport: notjunk:1;M01:P0:U0QHdqPa4uA=;a4K7gBo4+zQyjZmB00nokEnz5NC
 JwalYhp7J/NHfRDku3YNacGdyisKncRk+WIirnwKGYy7lq0WaCdyWjk9cBz+4zfaDL7IGdOLS
 H3SsAzoFnnpICR+0B/Ab+D6MFJ/oSFCdOn5BaG2eFPeOB2uAAW9ywbursiH0S6x0z7U9hdiD8
 C7T45P1xuEuHR9eHr0Axo18kgogY03DmIogTiPJzp69K8qAV91ANfgXnNChL97TLLX0AgQIdV
 M7xnn15r/cxfxQt3XwrOHz5cSQZgr8jNWCMtLYF8dVSz6+WrssJbmkH+mPQBUoV4SG2pHQ7Ry
 S2Tly2CvfXAUvBiLPBPIWT+b4/wybHCzlDAQ10fhps/Xk6rXRjjWFAMB79JeXkOFZOFGR9uVG
 Id/0isL429o2ynMkn/C4Ha6r5Wyp8z4PkonyWg58mkkfaH4m5+tkq8iE6R3uCPucA7JI/c4uK
 AHB69MQdmWmEtZ7FzDQihPA10YWhDIBiT2QzK2vZYPDDJ2FHcOfebsGHQfVg//sMEN0FWG0g8
 IQ+dQUUUjJaxWLsrmh5krymWE4wd4y4mmhISx6BJ9Kyc7OBS8I4/HwtGTDIYQ2DmsOskROeoN
 CMOlzIQcXP9B6NVybjKFvOCdAoe1r8x60XhZtSJUsZR2idnCv74YNT5Q9pTMXl/ywsb3b+CPz
 At2co28H9ElSf4yaT7SxiCpcVtZ3g8n1RNdEw0BTo6TDLI0y5UDwJtt1dWdjYJra6NlFSshK4
 e6zMnz3GWIaHT7vk93SL+AKsTi5DtieDxaUO+4WH+vTmUybVzEqBcmmnVKeTLKlO93ef6FGYd
 jWlR8ftowUSUsovoiMi++ZT7GmD7Dv43fFNKCUom8gRcP3FkgjBQ8Q1B6wB+u73+3nRu6K4Ux
 XDsiLfjmwpfDpWti7wdtpXhgViY6V6zYRmCV2In4DUvWQV3wfYgBZP8eK55Jv/VJXDImwJJPB
 sTij/Q/aEEDzYuwQFHznTn2dqvgsRQTylqE3l7h+XuZDkXI8t2ry4Ykcpo28co8rlXYefp99B
 UgV+xWLl+5/sV4JGfecemZucEX+4Dmsr31x2ugpyOVjiL6V637ftHiGKa3XPskdF4H6cBdNDH
 yFpM4WJ6wMd/R9vdH7NfRrEEdjIAqjU5fD9hWZZx7HdSd4BrdRlavjrXk8gnf7GmNYoRwPaun
 ooVqbyrrYsmbrVWDMrdzRInz+WbYjryZcygZkgZYhqrQZf1/CLyQpMnVDecVrGjRC2QGx7OA6
 oyjMScldRa+bygBAAWXzYkeGH4ZsujGU7ENMEzwiN+09jEFaVd+DIyRIiCXDjlQqpQRnQ1J1w
 ACi2F8+wMI1LYH4pb4/6ZgpCrTqrbQP0BaveCBHEp7CQNcn6FcKRfh16KZAA5i8Y4H83w3jrj
 uyCffI7ZgOWji2OrFCfh/V7PuYf+Uy4s/NIBY7Zojnt4oH5trunDN1WTybcD2ZTQnedLQyWSq
 63nIWMz15ts6QmUP9gzXeKikZ/IqNTniK1JYxeGayklLDMClDXWJCgIH3ihZb9DGGRsPusftz
 Z5bfrY2aK1ZQLuFquz4jtX+QNnejiGRDXkVhGikVO1EZjKfG+u6vF1/bXPSEwBnXr/dFMxMrn
 eDmeDPhrIH7kK2sCP/ltfsQdZbFU2PYOol9RzOmXl3TDp9OxxPKCN8k3gq2CTYQm08Tk8ixXN
 2aD5ZZk0p6OgJ/WWsUcuOyRwE5ZS/5Jaddxoh7Eop2h/gh0GnONoiSmqyTUJ1bfaZ+vWB8fcc
 rp0nOYfj3t/6ZcoO/+rKsyHf8d5zkoiOIIzc98dID57J2F4BLUwC5PlkVgtgAO/Nm8ezUSyaX
 m+QX9IbFcMnsKnOeud6PRmtreTy+fvmZMqWMbj4PzZxzaR9s3k8+LL6+Yc5mOodaSQTXa6qpr
 1GxCmNCUfjGFUaH2WtjtMup4NzHHYzugn6A3P8QixdVu4etq++G6+QdPglDbO0MO5TN6JP4LD
 nJC0mg950VILyJIwuUDX2kl/1MTPdzsG/v81vwa+9cw35yTwgU9vtmLkSZN3URpjuT3e8G3Dw
 0tMOd18IEYNXAbrkyB9PcYifAn4FkJBEl2L9aMuGq61gZ7H0DMJEUa969XycwHFG0Ic5S7Lrz
 CqrqjlrfHhZQFfUy3wiiNNDZBMTvZV0z1ueWBzvX06zOnh/Rdo8ls1ameAEkZlLUf20PIQpBE
 GOCsrzKUy2S14VBRzw23DX+CQE9bEyirppvDZcnT9lli+B5gSUfSGgH5Vea5rJWAHAAJddzRi
 HUBedmtxyn1FCOeXdsQI3ZrfeXuhozR4tcjKDVQmrfGL8Ptexhot2/+KQsZzY5jNwPXGDeOe/
 aGSQAJl1Qm45hGo/Y9dKgVqWw4YH0BpXXT0wpRbLqr6tYZJQ4rNHrrlgIVPUVjn/54aGr+Jgy
 rklL8KYdmiDZd9TCSQYD7bFTRJ/8JLSQYpbG27oEphCIxi4OUIo2E7pKIqrV9iBzIgUusZv0L
 nssvCjRck8tLjFcYnfeSU5CUvStUB1sYV7J6/CszjfHmhFG3SnFWQMVA0CsbGEL6S977elJ3c
 e1yO7gAAP+1wNAETIQMZw9CxDjFtlhVNOuFK0Byqpvl4g9Fw65kxgHqOb0loFIhxdt36d7DbE
 UJCamB9FYpQ866KxstvX0op+q/N8x2jLPYJwfKwzlNtN7b/dYvHa26l/YciZ/TCHVNatnm90H
 FLKwC70y5JPYO4p4p38pHZHTNINdqLAjwDEbgFrgHoTeCoGqbPuu6ik40LqcbiDnOsDGn44wH
 S2Co7JAgT4X9zl8NXefoaVQ76Xst7fv+ZU5N816oOhuESAB37FJE+1fKdYl9MgkcUjGa5G5ey
 PtY3VYyECAANu7JOePde5lW1lmsCD4j48R2gOtWvaCcM4Ws/6uAGRXjGx1z4AJZQ7KzjIgm5i
 niY/t2quDe4nRGpnKBQUFsG4hxlQtnQQM9nm+pX9si2z3DZrvf3J/+ZTDsKkwav2hlt44nKM1
 8t8MmUHTdkaUdZGXC0D5d8CfLGZZtsCJtsjQLX4xiIp5gWx+tWv0FvqdZ4kPpn2167yhrxBva
 qf3QCy/gpLGlEumsf2Bs6JUSw/axoUPOCQnqjyoP9F+G9DEhdwQLTCfiGTWzq60uBhttgh5Mb
 q4R71ZWJnjSM7mLP2ihfXhFU1/e9vQ7UH9nFTdfQwbE35haVrmwR3kh2EVW4U+MJuXl7MFxN6
 saSWmi94u980PI8L8yzpgwJzmQ5l2uLpaov+DT+Z4EsFHxrwJ2oQT/NMAFbQ0LvVT0qsLTOWh
 l20zgKFS0Q5gdK4rUoMc7lM2fonz8sDcwzyOts1WHLrjReyFDLwVNUkL8oV+FB7OIvNcns46l
 eeBZSO1vgiXeN1c2SDclUslrI6F49vRMQ1p3ATvm4o9y90Sb5fjUOAXLUpupvUKvVjB53w8yx
 6M2R9t4q0xtfJGFV8uAGPDc+2cGGL0RF0H7F93sD5/UVP2M1I8T1uE7tP20ILrj6no3ZwrDBv
 6U2DYIDvFlAk4GiQ1oy+Iylc/4/afaGL88icsUC/eL7Zhjmu4l5KysdXzP5bBeGvRkN/FaiSY
 ZQ6nNFNf/IKhv4eTGMoLpb7/xmfAhSARyiJ61kir0frqcx1eKn40dKCV2pLM0zlH3h50O3NRi
 Avo8GZqF371TTdeoplpCp51NGymTAupY6hH00+AwLolZGoYSumyzQGsrbohe1w+78zbTWXWPV
 q8iv4p7Zza3YQnA/+aQPW0VuKGA6WyW2tNLiPRCdFyMMLdDMIGgjJfwD2oHmv/K9bm12R1nxJ
 WQe7o60oFrhPtggQ2Dvf7aoVUkBFbjhgqldEb0PrLZxvZ4I717ANnJFKGAxA5qfbR3gPaa00Z
 PSWqeJDeQGmKOic/nlx09JrLehSU9RdXZiaArMPNQ/xjxNZUvAUGXAWWvSFM6cenAdcWg5vUF
 fYPopjg7ofnIsoLxsQNYofyELj0HrfB0DO+Q+Qg6MzpRi/634DoaqHre4KXo5XkgYdd50KUj6
 u8nx80f9FuGXVNQdbZBhcmKZuz1eYOzT/3PkHMqQuoLqfzBzfQnnyrvCmPxaV36PRuMFZpeCJ
 dXe64e+6hMd50Ue5JHL+MezNLjehGE5IBQRyvQKt6EPMlUxaoaoZElBQ9SsvjsLSNlzUd+1F0
 N2sYRBlJ/L1gM5B4Ai3lJyItUWji1e8LnuspaFKE8TxallEMMs2wvaDvsbYhwQ3ry/uI92IF9
 L+EzwhfiYRbi7hjpQ96t3y9CGyHTSF6YCAM5ZDeyJago5T4wSWOmZNvMkppqzuMGwBRkWzsOa
 nDta6BsDqzC0sLUCqYwlB0+gUf16DRz7pptpA+hPtktnr8fDoor5Nf0Sbr5734LioeaYpm+yr
 o/eee0r8CWJUTOFml4z2sc8BMFpqKJ8Uj1i9Szji5Z99PBX6ZNnIMVryy7Iehe6lUKWfDOvBP
 +n1OC0apk06eSSeUFz1zUh9K+zJbzLV0IVmRos5tOSlJ8kD+AEj8ih0IuZuCs391/kkQhNg6e
 mCuURF04SqWlThSZh9Pndo4+N3ZdQtmkJN6aa0e/ACkWlYzUV+wFxtd2tG6l47nPVs90OS+Cs
 ADHPbWhK8Xd/unWipjZTkLWSgYnywozOrmBPRLzZ1dH0ArOSKLdkSFERlOmoUGY0YzurjuusZ
 wOIWtCjFuY3O1NbZazDAvxSRgYZHDyo5LBJ7DSTCmh0Sv3GVd1ZKzKS5/HcflsrhN7J+5Xri3
 PyiOjiCEwt5ksZGXpW7MrQObhF6WAdbavDb3HZaYYlQCADtTFGRtWPRnIXHGDkz0RZCbA/xw/
 M+dlYaeqz2vvrdQiAE3Q7GV9ImpWhccTiIXMT9l1zv3MzPFbRpw45wNwkCxEdtt0wzoWI8Ru+
 3SDBxsd61vTBjed/ptB9IqypU84bIKyju8Hy0C+Dw1YigLkCwZ+XUnrQqhDckxEZuRBrPVmN8
 +UzkXa1rKX2RQQq+Xw2OTx70ObEMJ+4SMJC+96f+6vcHZpw6BPix2Q35nWHa57vds94AcwQYt
 P/mGOFjsDONMGmaEJpUfZKhuaubNJHgHrye7TnmI7Ah2wlbu6PKJnnGwCYG3APizsf7lSqWb0
 TevCMcolGVf7phUDzYX2Y1g5V0IoCy7pf2ucpcdWx32ulTdiRJdtMQWLp8gVD5rLpXi24ni6I
 DY5/kT7p4D/Z4T3as7W8AKmq5TyHpZYokBA886t6P5Dobh56+zBOvzg1ixug==
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

Add a page showing the logo with and without text.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 doc/learn/index.rst |  1 +
 doc/learn/logo.rst  | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 doc/learn/logo.rst

diff --git a/doc/learn/index.rst b/doc/learn/index.rst
index 8075c01d1df..5b139e3c9fd 100644
=2D-- a/doc/learn/index.rst
+++ b/doc/learn/index.rst
@@ -6,4 +6,5 @@ Learn about U-Boot
 .. toctree::
    :maxdepth: 1
=20
+   logo
    talks
diff --git a/doc/learn/logo.rst b/doc/learn/logo.rst
new file mode 100644
index 00000000000..66d403e4cff
=2D-- /dev/null
+++ b/doc/learn/logo.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+U-Boot logo
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The project uses the logos below.
+
+Logo with text
+--------------
+
+.. image:: ../../tools/logos/u-boot_logo_with_text.svg
+  :width: 10em
+  :alt: U-Boot logo with text
+
+Logo without text
+-----------------
+
+.. image:: ../../tools/logos/u-boot_logo.svg
+  :width: 10em
+  :alt: U-Boot logo without text
=2D-=20
2.51.0

