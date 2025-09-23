Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90971CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 08:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED1A80050;
	Tue, 23 Sep 2025 10:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="Aj3f2U5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B3A4833E9; Tue, 23 Sep 2025 10:12:36 +0200 (CEST)
Received: from outbound.st.icloud.com
 (p-east2-cluster4-host4-snip4-10.eps.apple.com [57.103.78.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF818004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 10:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPS id
 E495D18001C6; Tue, 23 Sep 2025 08:12:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=7gI2rJuq/b4Wbn4jbpRTQCMTUU+HJLDIK43+RK2Lrc4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Aj3f2U5bldsiF4XNeNiBzTTwwML+6dZyKcikNqOdB1zo+f1bV36V7PxUVozkMZ5GH/KooUubfYpgE8oZX+39226tognWkiGwPOvZk3oore/hqy3eFAXdWsXLOVHJGiQ2nzqqWKAFVRoysuVqc4dG9TX+ZzI/k326RPVtrKACItt5i5yyLqIRWWJNSonm3+Rn5LDIXATWnYCzHqafzUZDPvfFKVeAlCvZleVPASz+fM6v6iab3bxjPgoxDATTTRVXHhXq0ZaPzt3Z/B7t96ZY+JiDiuMRvaDEPRa6tYW2Mp0jqwLuiCIlImlHNYoDYLb4xiD5x0Tzjq3JLHLYIMQKTA==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (st-asmtp-me-k8s.p00.prod.me.com
 [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPSA id
 6F59118001EF; Tue, 23 Sep 2025 08:12:27 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/4] net: phy: aquantia: switch to use phy_get_ofnode()
From: Beiyan Yun <root@infi.wang>
In-Reply-To: <4DE4F2A2E02C441F+20250922192021.268592-2-root@infi.wang>
Date: Tue, 23 Sep 2025 16:12:16 +0800
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <40C6830D-0A91-4D5D-A5C2-6E5C9B025863@infi.wang>
References: <20250922192021.268592-1-root@infi.wang>
 <4DE4F2A2E02C441F+20250922192021.268592-2-root@infi.wang>
To: u-boot@lists.denx.de
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-ORIG-GUID: 8oK4EMJYB9LkqSaLMXkrRgpGqtZTvk7F
X-Proofpoint-GUID: 8oK4EMJYB9LkqSaLMXkrRgpGqtZTvk7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA3NSBTYWx0ZWRfX1pmWROi5W7PX
 3nChbPDNbQago2mN4tIVhqnIwDMR2rmjU9nh7sj7AZ8VnHiJtlxjiws+f4ftiQgczJyR9taPRx5
 CfzXwSpGe2IKdzEPSTY2aFCxaGBdUF2gW3G9qAxYMOf1Kq6+LOFnFuaea+/R4asQ2zmUkwzt0Ce
 rmPV3fH4X7W2nklzYSSqCCk+3nQjXX3FtBqBUlct5XPmUOQAWoDis4+3DzV3EXacUDecgSj+Sv+
 CdTwZEUxF5B8NJ9G22GM8BfKRx/LYceVjD4xeDRSO3b1ADT2rr/aYP1WE5juV/ARwhN3MUAL8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030 malwarescore=0
 adultscore=0 mlxlogscore=922 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509230075
X-JNJ: AAAAAAABpcRpJOelUADL5rL98xRkwW/ZUsz+koc4DpbabrU+BdWyIPaiufeSZQLcZgmrYGlvUhD4BkdrqjvLQKcE2YhzjGU72gMSQvDzechu/GrW3gt2aFf5dR+pbEoaYHOnj9DujaAWVqr4bzIEIw17mFCQ4VqOxsbsQrgph10rQvGNGLhV1xIaM/I2wUBtIR/eRcBG2UJGZePPYbWHDnud5jereRaQEGTFeDLsa8UFJ/WAawocrWPckr2819HORceFSNxP+2dN6ofHlX1ewbY7z315faZH4Qj4k2SEysLZEXR8b0hAGI4UcgRsB8iM+NQ+xHTPv/QYGGFEa5IlmaWYVRqpw9L1cxPy3hGXH3EDdeuH4mJsVWmz9A/JjXRxD7kUiTljCWzH9viRw8il3y2Zs5/IjKAaG7K+hUEtC4pVwqQ1J9tE5eu5vBcree/a14eIugV/oJhBG5PHKQrPa1oW0hcLNSmjmMtFllRD6PJAvhW5hSOAJQ5utE8JSW+Dyv09KQzppDqdI8vGvtdUDQiONmLdwKkDAQxESJQeFpXYEia80eA756vhh6rHSXsLP/XqWelgUIPojS0cG7Z6QK9OINxHB9JMJoIqmm2YfKBd8khnVVJSVRbqCvvpbwVFKWVzzZhA0zZlAXKjOCpdCviwFwcZgRO8sWB63lra0SUxhLg8MZv5Prs=
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

Please refer to resent series at =
https://lists.denx.de/pipermail/u-boot/2025-September/598941.html

> On 23 Sep 2025, at 3:20=E2=80=AFAM, Beiyan Yun <root@infi.wang> wrote:
>=20
> Use PHY API phy_get_ofnode() helper to get PHY DT node.
>=20
> Signed-off-by: Beiyan Yun <root@infi.wang>
> ---
>=20
> drivers/net/phy/aquantia.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index f63a13824ca..903fcd667f6 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -338,7 +338,7 @@ static int aquantia_set_proto(struct phy_device =
*phydev,
>=20
> static int aquantia_dts_config(struct phy_device *phydev)
> {
> -	ofnode node =3D phydev->node;
> +	ofnode node =3D phy_get_ofnode(phydev);
> 	u32 prop;
> 	u16 reg;
>=20
> --=20
> 2.47.3
>=20

