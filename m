Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B830CAC5A5
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 08:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 952DF80050;
	Tue, 23 Sep 2025 10:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="rO8FIz5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16FC980C93; Tue, 23 Sep 2025 10:11:55 +0200 (CEST)
Received: from outbound.st.icloud.com
 (p-east2-cluster3-host12-snip4-3.eps.apple.com [57.103.77.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2678004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 10:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPS id
 A3DE51800765; Tue, 23 Sep 2025 08:11:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=2a8DqXE0kGGcr6LhB1WTuPEjGjFiubh21p4M4bNe35Q=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=rO8FIz5JDPnbP7rn8TOnMM6dI5GBhVusj6RBnBInWKRD0nzxa2/UpEmFON/Lk6p7+UMlGyFo415yED/BCNrHlxvx4lpIhBPfahghLwGsCegX3m2Q2zGJGG1u0JviVKX2wTr6QMN6MQxE0Ry52MOoMaUo6OoXp9lG0dTxZDuSJuyVv729dB5Wt1aslIDlASEIDUK0mthXIqSMXTsQSbrXm4yyxypiKHTyqGOuUf+iwj/a2MRm2ETs56AV0SnuyKdhfGxBSznAhF7HwQ6HLVwqKq4MRprunFKllnko97L6I/VxfD0xJoc5P+kKjNQraEyu/HYN6W1NtahoorNYfHfwbg==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (st-asmtp-me-k8s.p00.prod.me.com
 [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPSA id
 B1B2318001F6; Tue, 23 Sep 2025 08:11:47 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/4] net: phy: aquantia: Switch to generic firmware loader
From: Beiyan Yun <root@infi.wang>
In-Reply-To: <FC37593FA94A297B+20250922192021.268592-1-root@infi.wang>
Date: Tue, 23 Sep 2025 16:11:34 +0800
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 weijie.gao@mediatek.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AC5DB75-0B31-408E-A4E1-734BAC92E3B1@infi.wang>
References: <FC37593FA94A297B+20250922192021.268592-1-root@infi.wang>
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: bvs1uRsNFvPxseBE66wMmN7aFaHO7kMJ
X-Proofpoint-GUID: bvs1uRsNFvPxseBE66wMmN7aFaHO7kMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA3NSBTYWx0ZWRfX01QBKRf0e61u
 6dLM95ru2JaB8AXDD0SVMO/NIJoRPSPUFUJKKmXhi6cBe4nnj8E6e1qrOLTLnEnIp3lJjIWwyU5
 II1xlZN7S9J9WoDFzJohG3IMk6C4R+t9T8v9VBs/8iYxQUmNJciPIi4xNI+sXU8RXTdDt5mcnyC
 VGZLrMCg3xJxzqycPlTXTezVs9eAKJzkRYNWD7I6mdu4fwcxr85XBM0cgUXrSQJqDT6ve0Db2ct
 2JctgfvPMnMwjl/6e8qMxMMpa37K9ES70NeqiRDKfWkYsJnbgFRtpCo7SJSgctDivqWky75mY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1030 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509230075
X-JNJ: AAAAAAABzMkDoi4KS0tBrX8EX1iGhxJRlw0xnddkqDAb7JvOgfwpHAFaZiXOoDdbQ8aFf2h3ZOV4KArnzRTWzzgiE6YdCvcQTTeN7vWYOsNW9LFXuM9HyTKjqlUfYnQEA9/fnYHB+xZDbqiJ2WiI2leRKGzdrld4vyrHcRPX9pxNCytWp1riPYKOqwsAOq9zuP7VtBGsgy9K2fGVPc6RmtpomT233GO95CDCQlVD2T73Sh/qMnkCJg3Iql5f9KRL9rP3IxxWNEzARg+l1wi3fTrTuoUNWb6LXw7c5C8M9SRwbiD8r3VIviC1tismwxoyssRUFEZ1WyXZQJ2Nym1Dp4tU8mu8cBU+Cwnh3+W4Sfc0jymW/ujCcI7cKHipRLru9D/v0dC86oQGQ3PkgInpK5rHMGnCVMGM+NPImLcSHnYyIP1qWOhGvQaE/xRZCG8fo/qHFGOzk5dBi/6uez6TigCGNSx04CO6O97cEQb6jZ0GxjwF+1SsJE7kUvPbxUujYKEBv2+I4HgRn3JTWZaXc0SDelbZuscRLJQITmdcFU06HboJ9wkMFzJMs7j8WDqr2YmjFJR4WZ81AR6AKZA6zNaqNNq1scVRwgoHOzRL7n6iA9a9HQBG/SlQ/+snV7lBjqwovIku7o+tHwkchs8K9nIIJiRYOfX2CL+1/FWo+ELLmxru2z3RKsTOQxvdUDMXaFiXSD3w8ItHsBBIjyhCGlYQPWne1zafjljjqqwwjuadtNMdyNuPPRCGYp2Vpvz+PY3mEV3Z5Wz3o37f8O5U
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

Please refer to resent series at: =
https://lists.denx.de/pipermail/u-boot/2025-September/598941.html

> On 23 Sep 2025, at 3:20=E2=80=AFAM, Beiyan Yun <root@infi.wang> wrote:
>=20
>=20
> Hi,
>=20
> This patch series refactors the Aquantia PHY firmware loader to use
> the generic fsloader framework.
>=20
> The existing loader is limited to loading firmware from an MMC device,
> which restricts its use on many devices (e.g., routers) that may use
> other storage like USB or have a UBIFS root filesystem. Migrating to =
the
> generic firmware loader allows firmware to be sourced from any backend
> supported by the fsloader framework.
>=20
> The series is structured as follows:
> - The first patch is a minor cleanup, switching to the =
phy_get_ofnode()
>  helper.
> - The second patch fixes a small typo in the binding document.
> - The third and main patch replaces the custom loader with generic =
one.
> - The final patch updates the device tree binding documentation to
>  introduce the firmware-name property and provide usage examples.
>=20
> This change has been tested on a Buffalo WXR18000BE10P router, loading
> firmware from a UBIFS volume for Marvell CUX3410.
>=20
>=20
> Beiyan Yun (4):
>  net: phy: aquantia: switch to use phy_get_ofnode()
>  doc: bindings: fix aquantia-phy.txt typo
>  net: phy: aquantia: use generic firmware loader
>  doc: bindings: add Aquantia PHY node's "firmware-name" binding
>=20
> doc/device-tree-bindings/net/aquantia-phy.txt |  32 ++++-
> drivers/net/phy/Kconfig                       |  19 ++-
> drivers/net/phy/aquantia.c                    | 124 +++++++++---------
> 3 files changed, 103 insertions(+), 72 deletions(-)
>=20
> --=20
> 2.47.3
>=20
> base-commit: d33b21b7e261691e8d6613a24cc9b0ececba3b01
> branch: aquantia-fsloader

