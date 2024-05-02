Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA35C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95AB988BD1;
	Thu,  2 May 2024 15:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=viasat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=viasat.com header.i=@viasat.com header.b="r9mFYGlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F6B88BFF; Thu,  2 May 2024 12:24:00 +0200 (CEST)
Received: from mx0f-0085b301.gpphosted.com (mx0f-0085b301.gpphosted.com
 [67.231.155.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 978F088BD1
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 12:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=viasat.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=08523adbb2=ryan.shimizu@viasat.com
Received: from pps.filterd (m0351330.ppops.net [127.0.0.1])
 by mx0f-0085b301.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4427adhq021226; Thu, 2 May 2024 10:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viasat.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=JOFOXj9uytD3zDTDNJQhhgWSIDnwqG8Jnc2PMzy2meQ=;
 b=r9mFYGlDrBUlDwR5N2WCTY3yEuh4t/7eGiBw7VBWUCPKCHfFKvUL7UFSilvkgnmgHt+N
 DvuRiiX2Qv5ceJihOJIcL3qRpA9HEFgajzTUtMuwJEzAfeJUArT+cjPpXTgxYshtn9ZJ
 XhoXfOWK3yFv1LtoGYDn2ld6jVq29mIpB0nmWPZJ5jwP0eOQz+NPCWR3MDePlM5lVKae
 m+df913egSYRZqJUIswItk9EqGUeAVcCjEvLHEg3YwtW18uMglKTJ1Qr72e6lNxorPry
 JV5FKIdcrb0a017HXxV0IQaeAjqkFKd6G8NXxG3PZbZhL8NN89ml1zZxsf72ZN5ffLO/ 8A== 
Received: from naw02exchp01.hq.corp.viasat.com ([8.37.108.42])
 by mx0f-0085b301.gpphosted.com (PPS) with ESMTPS id 3xv6kdgew1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 02 May 2024 10:23:54 +0000
Received: from NAW02EXCHP05.hq.corp.viasat.com (10.228.7.175) by
 NAW02EXCHP01.hq.corp.viasat.com (10.228.7.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 May 2024 03:23:53 -0700
Received: from NAW02EXCHP05.hq.corp.viasat.com ([fe80::7c6d:7a79:c6b9:815e])
 by NAW02EXCHP05.hq.corp.viasat.com ([fe80::7c6d:7a79:c6b9:815e%2]) with mapi
 id 15.01.2507.034; Thu, 2 May 2024 04:23:53 -0600
From: "Shimizu, Ryan" <Ryan.Shimizu@viasat.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH] net: phy: Add missing RGMII internal delay cases to
 vsc8541_config
Thread-Topic: [PATCH] net: phy: Add missing RGMII internal delay cases to
 vsc8541_config
Thread-Index: AdqcegS/hfH2StxIQ+6fzkQzx2gUHg==
Date: Thu, 2 May 2024 10:23:53 +0000
Message-ID: <508e6b33f72f427cb90d2606cc1cbb96@viasat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-bromium-msgid: e66d6186-de7f-4f6e-99c1-2a26d801d5ed
x-originating-ip: [10.68.240.122]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-GUID: 7bKOVlQQWMWHwk10c75afiKdBqYtZulb
X-Proofpoint-ORIG-GUID: 7bKOVlQQWMWHwk10c75afiKdBqYtZulb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=937 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020065
X-Mailman-Approved-At: Thu, 02 May 2024 15:17:58 +0200
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

Currently, vsc8541_config does not account for cases where RGMII
mode with internal delays on TX, RX or both are selected, even though
the device supports that functionality. Instead, it returns an
error when "rgmii-id", "rgmii-txid" or "rgmii-rxid" is selected
in its corresponding DT node.

Fix by adding missing RGMII internal delay modes to list of
fall-through cases so that when configured with modes "rgmii-id",
"rgmii-txid" or "rgmii-rxid", the internal delay registers get
updated correctly in vsc8531_vsc8541_clk_skew_config().

Signed-off-by: Ryan Shimizu <ryan.shimizu@viasat.com>
---

 drivers/net/phy/mscc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index bd9cd95297..7263887b9c 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1371,6 +1371,9 @@ static int vsc8541_config(struct phy_device *phydev)
        case PHY_INTERFACE_MODE_GMII:
        case PHY_INTERFACE_MODE_RMII:
        case PHY_INTERFACE_MODE_RGMII:
+       case PHY_INTERFACE_MODE_RGMII_TXID:
+       case PHY_INTERFACE_MODE_RGMII_RXID:
+       case PHY_INTERFACE_MODE_RGMII_ID:
                retval =3D vsc8531_vsc8541_mac_config(phydev);
                if (retval !=3D 0)
                        return retval;
--
2.34.1


