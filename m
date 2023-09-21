Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67742E7108E
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCD386B35;
	Thu, 21 Sep 2023 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="U+E49u5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 506E986661; Thu, 21 Sep 2023 14:29:59 +0200 (CEST)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F48E865ED
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 14:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 21 Sep 2023 14:29:57 +0200
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 001F2B5ABC
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 14:29:57 +0200 (CEST)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id D7471B5AAC
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 14:29:47 +0200 (CEST)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 21 Sep
 2023 14:29:47 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.174)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32 via Frontend Transport; Thu, 21 Sep 2023 14:29:47 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OL5BRa89HvNHLgyoolPsQS/kbv7OmRagKfJHpDsqMJ5GcjXHZfg9CS7TTRKNGXm4gKB9f4IjS8vFO5TwHfqIMfZwLHbfVb5ywZ3dvNNoKIWXHPrXxs6NB5LU52yhfMRCnctZAaVM1XXPE4t6FymPVnw7fE2Awagt2oa2kbBjNygu/+XRP3CZWvMTIAlGydu8lDu2q8ranvyV+aFJi9/hq1YDOFMTuHYNXH6M0/LAi7X0bh4O+aB8Pv1rrS1Y/P/1onKg1YX3a8Oy0aBj5d7NQhwdPHaFU5VAUYK5ZFjvctrFv++wttxx2bmCybs8n41T6r7TInLaMnOPfFUiYbOzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXdKYog1nr2XAoLY9IxQ0GQPjeRy3XrpilbzRa9mrCM=;
 b=eU5MXn3gt8aWxEWE2lsK6667zIljtTM4qahdW8R0a5SqtEcOr+WlI32ucGb8/qoCqEVXXWeXLzoa2YrGwSpu99/m+taHo5ebmu/Xb7e6UIlAiE7vh56PrTFnzBjMIXB64pgPg9hUGnK5LmN2dyguluuvK+tsCOyLkWbbLEQubZ2ZsC7p6kQJDFhPUBvE84aP8MqabdikLGYdb3InuGTWwcxqW2jjqdAsk7qc9/JtVx6V+ZrMTppfV+0mfazsocFMNfC4YzI/RDPBSQPI3CBw/zr6iFm/QyeUuRa6uZghGeU9b/P0PUQSdnVTB1Oz/og0XCr87W0mBKLfeNxNtk3NoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXdKYog1nr2XAoLY9IxQ0GQPjeRy3XrpilbzRa9mrCM=;
 b=U+E49u5PfgGK+5vg8PSB5ZxTgbUPnzJKkEqDy9F37fuFa4VVRTOuMEM4xW0lND8rMbyXohdZ24XqrxIjnbWxxQXKwNHxEpBDsukHW6YJFSHec72fN1agHtUDhNgGNRHt7k1VbjXADhPKpBr4rqEV2dhAbHWRS2MTYSFcIcOHv+8=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by AM8P250MB0089.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 12:29:46 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::fe48:ed2d:5ec6:dc56]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::fe48:ed2d:5ec6:dc56%6]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 12:29:46 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] misc: i2c_eeprom: consider pagesize when writing to eeprom
Thread-Topic: [PATCH] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Thread-Index: AdnshtQ9/kG20rp0TrapVzJklV7R8g==
Date: Thu, 21 Sep 2023 12:29:45 +0000
Message-ID: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|AM8P250MB0089:EE_
x-ms-office365-filtering-correlation-id: 9b580a67-0048-43a3-b028-08dbba9e7098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nFYfckA8+gKVxgqcLyMbXFn1Cjq/9YmNGarlv8yTb/0acY7GD3GAFdkPYYsIIrIhu/KI6c4wVZ6NgJdFTo/KmShAQDeFSTX33soMDPUvtTn9EtxA/BulasjjYjSLmx7ucgEL35sWyhK8cxBazk01g4O/xzTEom6b9atzvuwTR1Ak0+IRj1pv8/03Sel4+ajuYS2GsxPH8NY2tfo2oQEJst9/ksB47jR3gHOe61l9bei+P50RrseEbTMUVkLBgOyhQjFMSPbeUgTrrmoir9j25PIyPt/Ln6FqAqFq7S1L+lmVwFVJaD6V1x3f8pmYKCHPoOC4d45zMlrcLoxz46My19Kw3nSTKOzLzNSAYSsp4SQeJK06geXLDKQEV5rxQ5SRZI6bCVBul4CuS24er/Hf7UFsg8paE0gPZcG03wR3OSkqKr+iXeavdzqCwcG6DVL1CtbE3kHHMsoLgU0yTYO7Zxj97tFm8v51WHLdplAWSIJZswD8K7OGsByfSP8M+AtgomE44xM8csYlpqVpwbDzvjgrkY2a5bd5epK2h26ldGGbDPxLLqQyql3YMGCaFmtAhO2i26r2RpKh0mYGIMPhHqeQvb56bbbtu0rQBXcfevfaNF5/BgXOsZuzgxyesGW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39850400004)(186009)(1800799009)(451199024)(76116006)(55016003)(2906002)(5660300002)(83380400001)(38100700002)(38070700005)(122000001)(6506007)(71200400001)(66476007)(7696005)(478600001)(9686003)(6916009)(316002)(26005)(8676002)(41300700001)(64756008)(66946007)(8936002)(66446008)(52536014)(66556008)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2tKaIn0qMJLlxv3a40IY9tQdE0XrUkcGzPaEVZqqvPtZzIZLYvnn14rmufbd?=
 =?us-ascii?Q?BWh38+/F+tRagkWq5FYatVKFJ6OSPdR8V8gKiLKR6E9MixudTWT6Q5X9poMC?=
 =?us-ascii?Q?zuSLKIdJMVQKTJzZYFMuXjujLGK+Hc2mO8+UqjNJjicQMPhTditZdMYqtuzl?=
 =?us-ascii?Q?tkfx1VbPcPLgxy3Hk31nPZldZ6gl9oHIhFnpxlbo8CLFmv8jTEwDAyHON5qj?=
 =?us-ascii?Q?pwTMOndAJfV+Sp1Yl/uRlPoTl2G3fk58rwULRR9lqnh2THn09aBcID3sAjCR?=
 =?us-ascii?Q?oju2AVnN503w50wVdwn/4QuIkznbvchsi2CLNkB+IT10NuwIllwKLwrAM7nE?=
 =?us-ascii?Q?sdwrH40YIsvr4kk4FVUdSEYlUK566fhr9zMxrr/HzKdlxhemC97fGwhBVPy6?=
 =?us-ascii?Q?22vX3XEQB/V0+TqdZRknh+5jiildZPRmGNpFQeU5j01WlrOk/xHCqBMNTOXS?=
 =?us-ascii?Q?Eb3Jemib6TS9+8ujH6lLQi40iY8vB2Ju/zH+ESODDCPTL/A26VOetWrg70SX?=
 =?us-ascii?Q?c06+sKojP2bY8Kqy+kLODrciOOGN6C6vFb1I8parMXZ5p9Hb0mI8mbi5SnfI?=
 =?us-ascii?Q?cvHrO8M0mFQ/n9YizGGvyvAvDwQTYHmve9ITFQL0hdjjP7UgL3MaNL4exQv1?=
 =?us-ascii?Q?4Cz3x96HPwueB0xfQRl/mez7OtYD12HP3yoyoeztZaLC+5Pnb+ww8UuFzRzP?=
 =?us-ascii?Q?XUx3JqLBBC+65ByXvC2vcCxuDhPduEXJV43CDr9aUfNTU8efkQDe5CT5AmMc?=
 =?us-ascii?Q?AaBgOeE3XGlvh+/EDVOsUv52YTD0HXXErtPWRaKWP/MkTs+Pu8++6mngv2wi?=
 =?us-ascii?Q?fvdLN8JFt3VDwH86C1hHV3CJEKtNjzwghFUS6P9mfN563otznwlLeT9lAFsJ?=
 =?us-ascii?Q?9aVRDeApDKlf5JCdhRwlmGYa0zo0Bvv5q9raRU653t8/29yWjiFs0hnFvPEl?=
 =?us-ascii?Q?/5efcTwhGSLlfFd6qjgm9NoT5prFCk/3eeJbNrqONL9eLuAF1XrhaKhbZnLh?=
 =?us-ascii?Q?XxaQRzOOumuo22/gcnxY0bW16eUEv2XoAZ7XZbFrr5saV2GcXDkEshh14Q3a?=
 =?us-ascii?Q?9afUovYQqJyReyGq9UQw/m+8s7Eb0u8QUsUoM/eCGLtiBJhXqWMzOeWwMNBa?=
 =?us-ascii?Q?/CJ1bg1aO0q1kt6bT3poR4GRvJFC4vkIYXS5O1+8278GtVRzJupvLOvFJIAk?=
 =?us-ascii?Q?F/tc2bgxPxnTJmGkpnQKPhrLzd8pT1S+TMxWfAH61GEkiFjq6bb7HT8G8vty?=
 =?us-ascii?Q?TZln1dvn2Uj7bUyCdjBv9J7gas9PY3jzbUYXixRoI7VBF5+agJXWtcAwxcm7?=
 =?us-ascii?Q?g9IFXqzBGCAfq7PYsvWS7bS25pYt6XZFRt/4uAyW8ud6OeNoNQF8TKN8R0eZ?=
 =?us-ascii?Q?VnXEUqbIYygbF+VPJhlM12CaEStRFqjUsH1dqksmyb9cW+PxcLArkoy32NoK?=
 =?us-ascii?Q?Kl0bzDYfQyn+ytxAF3gY4ltaIEzT889nedWwvyLVjIp5Ap5txZisbbiKshDj?=
 =?us-ascii?Q?2JxYVO+IpoidE0z0Jcl5tDo8enWqbFaH3ziSK9uEW8rkDO8DHBPi8p276jvr?=
 =?us-ascii?Q?qbp7oGBty1W0qvjN+fsbuS3Eyj3u5BYoQvzEHPCBggVJGArtkAdNoH+U+JmA?=
 =?us-ascii?Q?9g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: O6f5WiFDKI6GLowdu2OA96gENsEQmIfYP0BWeMSsReh3W4QYaj0g7x36BVQcoleNXgMVZA3C2oh5AX4b3CCP/0H0SKID6cpqQcDTZOrfqwc3c5CI1Qlh7sWdd1Z0PkhLNrnTuLR+bnex5NiSkzNHsFQ6NWIcb4i3oiVDgVOKbLOcS87c6iXqLXN51oi/DWJUomHjd0PVEzx0VZ68F60QT7tsG3s/81gNqSqHYBRHt5vgvFa41asolU2bCtIpmepENEE4NkRXdIZbFHK0RABWljEex62pCMBWlgDF6/2zhFuk6XzqXn0LZpDJiiJsl6QhyxFyuXEOboebUGW/V2eZIkThxqlkDucAJpzuO15hWTX7JHUaVeAlboSYt+w5K3VcqMxvevOZepVsyHH90GViTJN4cmfgF3yVI2Uru2vAD8nSBSUI27WbZcEN+Qjjtz//al7lqdIATl+8lsNaqjowjJ/bZe/bjz70AcOyWOIE7MHSsejJBYAMHvphXnzkp2z4Mm/zGONEGGDxQ3liKu07aVIBsZP7LPLRJTomqR1URgxqt6J2UBXMEWiZysnKDmTG+HMnXamOCBaVZWFx1cfXKAKWWMXPreKqqGEnqzHD8LzMKOakRc582oegGAX+ATPtGeU33gnGbICC2vHYF0jPO+syjBBRWz9EJaPpbVgH+tfgt9enfjIauQO1SKuK6fgMse3Uv+NJ/wfOjUwVH+b4I/wy8w3ZIQTGWXmmzy4+WVcDLHvQTtci+IZ/DdNIPfYJ
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b580a67-0048-43a3-b028-08dbba9e7098
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 12:29:45.9347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjTd5LTHDqqm/vd9JcUHIZpDYTDdZhvN98Oa46E3Ll77OwVdNJBaxLDIN/zjltUPa2rrhhuoYiR6T3eswC9PPbjwHHSu+3QcnUTvZAPIgtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0089
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 21 Sep 2023 17:43:58 +0200
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

Calculate the maximum length of the buffer when writing
accross the page boundary. If the buffer length exceeds
the page boundary, split it. Use this length instead of
comparing the length with the pagesize, because the write
start address can be somewhere in the middle of a page.

Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
---
 drivers/misc/i2c_eeprom.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
index bdd7e018cc..f345e34179 100644
--- a/drivers/misc/i2c_eeprom.c
+++ b/drivers/misc/i2c_eeprom.c
@@ -60,6 +60,17 @@ static int i2c_eeprom_std_read(struct udevice *dev, int =
offset, u
int8_t *buf,                                                               =
                 return dm_i2c_read(dev, offset, buf, size);
 }
=20
+static int i2c_eeprom_len(unsigned offset, unsigned len, unsigned pagesize=
)
+{
+       int page_offset =3D       ((offset) & (pagesize - 1));
+       unsigned maxlen =3D pagesize - page_offset;
+
+       if (len > maxlen)
+               len =3D maxlen;
+
+       return len;
+}
+
 static int i2c_eeprom_std_write(struct udevice *dev, int offset,
                                const uint8_t *buf, int size)
 {
@@ -67,7 +78,7 @@ static int i2c_eeprom_std_write(struct udevice *dev, int =
offset,
        int ret;
=20
        while (size > 0) {
-               int write_size =3D min_t(int, size, priv->pagesize);
+               int write_size =3D i2c_eeprom_len(offset, size, priv->pages=
ize);
=20
                ret =3D dm_i2c_write(dev, offset, buf, write_size);
                if (ret)
--=20
2.34.1

